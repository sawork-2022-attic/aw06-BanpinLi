package com.umi.batchdata.service;

import com.umi.batchdata.mapper.ProductMapper;
import com.umi.batchdata.model.Product;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ProductWriter implements ItemWriter<Product>, StepExecutionListener {

    @Autowired
    private ProductMapper productMapper;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public void beforeStep(StepExecution stepExecution) {

    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        return null;
    }

    @Override
    public void write(List<? extends Product> list) {
        int count = 0;
        for(Product product : list) {
            try {
                productMapper.save(product);
                count++;
            } catch (Exception e) {
                logger.info(e.getMessage());
            }
        }
        logger.info("write {} line", count);
    }
}
