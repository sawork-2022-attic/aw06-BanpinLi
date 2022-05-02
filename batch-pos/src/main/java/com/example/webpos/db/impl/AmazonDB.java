package com.example.webpos.db.impl;

import com.example.webpos.db.PosDB;
import com.example.webpos.model.Cart;
import com.example.webpos.model.Item;
import com.example.webpos.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class AmazonDB implements PosDB {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    @Cacheable(value = "products")
    public List<Product> getProducts() {
        String url = "select id, name, price, image from t_product";
        return jdbcTemplate.query(url, new BeanPropertyRowMapper<>(Product.class));
    }

    @Override
    @Cacheable(key = "#productId", cacheNames = "product")
    public Product getProduct(String productId) {
        String url = "select id, name, price, image from t_product where id=?";
        List<Product> products = jdbcTemplate.query(url, new BeanPropertyRowMapper<>(Product.class), productId);
        if(products.size() == 0) {
            return null;
        } else {
            return products.get(0);
        }
    }

    @Override
    public boolean deleteItem(Item item, Cart cart) {
        return cart.deleteItem(item);
    }

    @Override
    public boolean updateItem(Item item, Cart cart) {
        return cart.updateItem(item);
    }

    @Override
    public boolean insertItem(Item item, Cart cart) {
        return cart.addItem(item);
    }

    @Override
    public Item queryItemByProductId(String productId, Cart cart) {
        return cart.queryItemByProductId(productId);
    }

    @Override
    public boolean deleteAllItem(Cart cart) {
        return cart.clear();
    }


}
