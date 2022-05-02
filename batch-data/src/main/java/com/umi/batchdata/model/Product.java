package com.umi.batchdata.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    private String id;

    private String name;

    private double price;

    private String image;

}
