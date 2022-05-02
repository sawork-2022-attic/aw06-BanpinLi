package com.umi.batchdata.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.umi.batchdata.model.Product;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.batch.item.ItemProcessor;

public class ProductProcessor implements ItemProcessor<JsonNode, Product>, StepExecutionListener {

    @Override
    public void beforeStep(StepExecution stepExecution) {
    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        return null;
    }

    @Override
    public Product process(JsonNode jsonNode) throws Exception {
        // 判断对应的字段值是否存在
        if (!(jsonNode.has("asin")
                && jsonNode.has("title")
                && jsonNode.has("price")
                && jsonNode.has("imageURL"))) {
            return null;
        }
        String id = jsonNode.get("asin").textValue();
        // 判断title是否是一个非法的字符串，而是一个标签“<...>”
        String name = jsonNode.get("title").textValue();
        if(name.contains("<") || name.contains(">")) {
            return null;
        }
        // price中含有$和逗号，将其去除并转换成double类型数据
        String priceStr = jsonNode.get("price").textValue();
        double price;
        try {
            int startIndex = priceStr.indexOf('$');
            price = Double.parseDouble(priceStr.substring(startIndex + 1).replace(",", ""));
        } catch (Exception e) {
            return null;
        }

        // url是一个数组，从中取一个即可
        try {
            String image = jsonNode.get("imageURLHighRes").get(0).textValue();
            return new Product(id, name, price, image);
        } catch (Exception e) {
            return null;
        }
    }
}
