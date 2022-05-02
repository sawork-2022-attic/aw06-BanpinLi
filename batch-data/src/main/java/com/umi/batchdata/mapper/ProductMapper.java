package com.umi.batchdata.mapper;

import com.umi.batchdata.model.Product;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductMapper {

    @Insert("insert into t_product(id, name, price, image) values(#{id}, #{name}, #{price}, #{image})")
    void save(Product product);

}
