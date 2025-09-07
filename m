Return-Path: <linux-kernel+bounces-804640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0683B47AF4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2AA3AB1DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03C2627F9;
	Sun,  7 Sep 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG+QAHPb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD018A6DB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244393; cv=none; b=gkvtfn/HXKo/zJc7LlqZx9X3Lr0VryoRian4H8VsOJxaQR9LcLcUnTnXXAZycqT0D4Xl26KTTz4aocIi0LkDgGAEUw5AbpdRXWIPYDSQeWCw+k998gxblVxRmXLz64U3iXrppfFzq9v+ErArIsHRE964NcU5DHQBZBXsDyf0rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244393; c=relaxed/simple;
	bh=WplKFwssKc1f+3uh2xBYy47HhTBAUrgd7sJvb8Dd+AA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MfCMF9mFsxAT8ejELUzt+yqKsjMZualm+1D0EF5j0bZyDv9OHwAlHGfRTQXAd7DT+9JCXnemj50tGvFYtWhECk8JAc+W4oaZCHO1WlBMaKUe7RdpYEASZn0l/Qja8BwtOrCSMcMdZZW1NG39j5E76U062VOUE9lAd0++DezbkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KG+QAHPb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so9335565e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757244388; x=1757849188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAYNdsBKYi67Oem/jYjGQylTcJt/iir5KzfK7uZa2Os=;
        b=KG+QAHPbjocr7Tu9LZy9t5tBr+la3VuGLttUqPQKQWvHtDH+MEUhEjZT8i1c6re2ID
         9CNnFw1Vp2aW3Q6XobfdrqmUXvSIgNTRdWc8Wm83cstvqJxSDNIFXgqAIyYXNAPi0nbN
         yhXU2OrL8J2DC475cTCBFa5AjzFy/Holk7+icwE4RQf7zvCHQiAuml9a+oEkZvJ1atf4
         c97kktVHzfA9RzcO5VeUr4KM2rcmXlFiT7Mzq+22Jk+gyWD1wMrmsn4vxDs1AXj/TmW6
         PAJJ7ocP9JatkwQsZJajO3tMtY2wQQHEkdPhwpIVihVz6Epb9NvNK4LXbkEdnWqT+23n
         wV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757244388; x=1757849188;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAYNdsBKYi67Oem/jYjGQylTcJt/iir5KzfK7uZa2Os=;
        b=u8Ebk5S58VnrmacfKlTMHeV16Mf523ceNM5Nyp0564F5ctnl1eeZQFFwJ+UhpasnnG
         pt844yMx+XOpmhGorRDFddA2XglVzdj2Q88zniXbLCqHnrM7LJM1MupGV87PfYUsrta/
         S2grifFuZ6QN9GfW87Aa9IZB/1c5ius8FgFeCloFqC1FUcon5ANcrxnLKn3eBiv5niCK
         o9HXgR/lKoZ5RWlgjbzwawbJmdS7c6a07vfbGeP/lEPzGgxm3pFq62QTFRxTdXbjvJC+
         yz5/dyeRYwLzd9SzhHMCa7JUhqj5UfadBGBwMCpOt4io5rqRRmdaW+TsJW3MrwtytXvI
         7O9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPsSBbcB2DaMkxnnkoa5FUxXCr8KuCE4pXBgwX8Uv9L36tmxlgOudXysrGoj82fo7OvxuhAd6rwTvR/30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYWJI1Xncc9+1qavLc3425u7vcYx2wQDUDEOOyVH1D2EcQDVr
	73qN/CDyPh8G6jncm9MDDD1ZJbJvpPCyXg9jK1tuOF98mtO/Qvmmnj440Le2gC9eEck=
X-Gm-Gg: ASbGncsEuXLVUpgO+XtAP5kilgpdMyMd+Acf3c5b7EYA+tSjw8PPAvnxNjAqCcyy5TS
	tVVPGmIGxYXsPs+seRrSv7EN2f5y3+esAQit+CLVCRAVFbSyJK8GmS8OF1Ql7jj/6RI87vrqPHC
	rVTMPTs8MJgpvFrkHoyftK+CEWaB8uINoSl1+AzS/aDapw3x/sMch39SuY4exQMmNS2KYkxQJH5
	iuzKf1ydsp0977snwVbxtkZPXtouovXERUlyiitZMI2yvTW945tC/0xUWwb/LgdRAXCJ4VSWHpx
	yG+L8DbED81IQwpVhLSldOF0y+hbsU0QqV/Xy64rymo8n83e5ObfJGwF6hwocOGuhIFCvH51w7A
	/7mty69wDvfeGvJ4raW7FcTCYbZ522/CD0yVvuw==
X-Google-Smtp-Source: AGHT+IGH6H0mBFkDQVDcAbYMsb+ulzbOrfFiUgLrXxCyJBe2kwF4x8+y+psKdMwtQ84ERtsBks0g8g==
X-Received: by 2002:a5d:5847:0:b0:3e5:190b:b04e with SMTP id ffacd0b85a97d-3e64317fdd0mr2511246f8f.37.1757244388066;
        Sun, 07 Sep 2025 04:26:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e74893acecsm319047f8f.36.2025.09.07.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 04:26:27 -0700 (PDT)
Date: Sun, 7 Sep 2025 14:26:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Andreas Kemnade <akemnade@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Andreas Kemnade <akemnade@kernel.org>
Subject: Re: [PATCH 3/4] regulator: sy7636a: add gpios and input regulator
Message-ID: <202509071141.TSai6ltk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-sy7636-rsrc-v1-3-e2886a9763a7@kernel.org>

Hi Andreas,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/dt-bindings-mfd-sy7636a-Add-missing-gpio-pins-and-supply/20250906-171133
base:   1b237f190eb3d36f52dffe07a40b5eb210280e00
patch link:    https://lore.kernel.org/r/20250906-sy7636-rsrc-v1-3-e2886a9763a7%40kernel.org
patch subject: [PATCH 3/4] regulator: sy7636a: add gpios and input regulator
config: x86_64-randconfig-161-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071141.TSai6ltk-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509071141.TSai6ltk-lkp@intel.com/

smatch warnings:
drivers/regulator/sy7636a-regulator.c:121 sy7636a_regulator_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +121 drivers/regulator/sy7636a-regulator.c

8c485bedfb7852 Alistair Francis 2021-06-15   77  static int sy7636a_regulator_probe(struct platform_device *pdev)
8c485bedfb7852 Alistair Francis 2021-06-15   78  {
cb17820ef71ed7 Alistair Francis 2021-10-15   79  	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
8c485bedfb7852 Alistair Francis 2021-06-15   80  	struct regulator_config config = { };
8c485bedfb7852 Alistair Francis 2021-06-15   81  	struct regulator_dev *rdev;
8c485bedfb7852 Alistair Francis 2021-06-15   82  	struct gpio_desc *gdp;
d38d49b140043b Alistair Francis 2021-08-03   83  	struct sy7636a_data *data;
8c485bedfb7852 Alistair Francis 2021-06-15   84  	int ret;
8c485bedfb7852 Alistair Francis 2021-06-15   85  
27fdd3bbb7a138 Alistair Francis 2021-08-06   86  	if (!regmap)
8c485bedfb7852 Alistair Francis 2021-06-15   87  		return -EPROBE_DEFER;
8c485bedfb7852 Alistair Francis 2021-06-15   88  
07678e530d8eab Andreas Kemnade  2025-09-06   89  	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
07678e530d8eab Andreas Kemnade  2025-09-06   90  
07678e530d8eab Andreas Kemnade  2025-09-06   91  	gdp = devm_gpiod_get(&pdev->dev, "epd-pwr-good", GPIOD_IN);
8c485bedfb7852 Alistair Francis 2021-06-15   92  	if (IS_ERR(gdp)) {
07678e530d8eab Andreas Kemnade  2025-09-06   93  		dev_err(&pdev->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
8c485bedfb7852 Alistair Francis 2021-06-15   94  		return PTR_ERR(gdp);
8c485bedfb7852 Alistair Francis 2021-06-15   95  	}
8c485bedfb7852 Alistair Francis 2021-06-15   96  
d38d49b140043b Alistair Francis 2021-08-03   97  	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
d38d49b140043b Alistair Francis 2021-08-03   98  	if (!data)
d38d49b140043b Alistair Francis 2021-08-03   99  		return -ENOMEM;
d38d49b140043b Alistair Francis 2021-08-03  100  
27fdd3bbb7a138 Alistair Francis 2021-08-06  101  	data->regmap = regmap;
d38d49b140043b Alistair Francis 2021-08-03  102  	data->pgood_gpio = gdp;
d38d49b140043b Alistair Francis 2021-08-03  103  
327603c2e83590 Andreas Kemnade  2025-09-06  104  	ret = devm_regulator_get_enable_optional(&pdev->dev, "vin");
327603c2e83590 Andreas Kemnade  2025-09-06  105  	if (ret)
327603c2e83590 Andreas Kemnade  2025-09-06  106  		return dev_err_probe(&pdev->dev, ret,
327603c2e83590 Andreas Kemnade  2025-09-06  107  				     "failed to get vin regulator\n");
327603c2e83590 Andreas Kemnade  2025-09-06  108  
327603c2e83590 Andreas Kemnade  2025-09-06  109  	data->en_gpio = devm_gpiod_get_optional(&pdev->dev, "en",
327603c2e83590 Andreas Kemnade  2025-09-06  110  						GPIOD_OUT_HIGH);
327603c2e83590 Andreas Kemnade  2025-09-06  111  	if (IS_ERR(data->en_gpio))
327603c2e83590 Andreas Kemnade  2025-09-06  112  		return dev_err_probe(&pdev->dev,
327603c2e83590 Andreas Kemnade  2025-09-06  113  				     PTR_ERR(data->en_gpio),
327603c2e83590 Andreas Kemnade  2025-09-06  114  				     "failed to get en gpio\n");
327603c2e83590 Andreas Kemnade  2025-09-06  115  
327603c2e83590 Andreas Kemnade  2025-09-06  116  	/* Let VCOM just follow the default power on sequence */
327603c2e83590 Andreas Kemnade  2025-09-06  117  	data->vcom_en_gpio = devm_gpiod_get_optional(&pdev->dev,
327603c2e83590 Andreas Kemnade  2025-09-06  118  						     "vcom-en", GPIOD_OUT_LOW);
327603c2e83590 Andreas Kemnade  2025-09-06  119  	if (IS_ERR(data->vcom_en_gpio))
327603c2e83590 Andreas Kemnade  2025-09-06  120  		return dev_err_probe(&pdev->dev,
327603c2e83590 Andreas Kemnade  2025-09-06 @121  				     PTR_ERR(data->en_gpio),
                                                                                             ^^^^^^^^^^^^^
s/data->en_gpio/data->vcom_en_gpio/

327603c2e83590 Andreas Kemnade  2025-09-06  122  				     "failed to get en gpio\n");
327603c2e83590 Andreas Kemnade  2025-09-06  123  
327603c2e83590 Andreas Kemnade  2025-09-06  124  	if (data->en_gpio)
327603c2e83590 Andreas Kemnade  2025-09-06  125  		usleep_range(2500, 4000);
327603c2e83590 Andreas Kemnade  2025-09-06  126  
d38d49b140043b Alistair Francis 2021-08-03  127  	platform_set_drvdata(pdev, data);
8c485bedfb7852 Alistair Francis 2021-06-15  128  
27fdd3bbb7a138 Alistair Francis 2021-08-06  129  	ret = regmap_write(regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
8c485bedfb7852 Alistair Francis 2021-06-15  130  	if (ret) {
4cafe1aeb5fb4e Alistair Francis 2021-08-03  131  		dev_err(pdev->dev.parent, "Failed to initialize regulator: %d\n", ret);
8c485bedfb7852 Alistair Francis 2021-06-15  132  		return ret;
8c485bedfb7852 Alistair Francis 2021-06-15  133  	}
8c485bedfb7852 Alistair Francis 2021-06-15  134  
8c485bedfb7852 Alistair Francis 2021-06-15  135  	config.dev = &pdev->dev;
27fdd3bbb7a138 Alistair Francis 2021-08-06  136  	config.regmap = regmap;
8c485bedfb7852 Alistair Francis 2021-06-15  137  
8c485bedfb7852 Alistair Francis 2021-06-15  138  	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
8c485bedfb7852 Alistair Francis 2021-06-15  139  	if (IS_ERR(rdev)) {
4cafe1aeb5fb4e Alistair Francis 2021-08-03  140  		dev_err(pdev->dev.parent, "Failed to register %s regulator\n",
8c485bedfb7852 Alistair Francis 2021-06-15  141  			pdev->name);
8c485bedfb7852 Alistair Francis 2021-06-15  142  		return PTR_ERR(rdev);
8c485bedfb7852 Alistair Francis 2021-06-15  143  	}
8c485bedfb7852 Alistair Francis 2021-06-15  144  
8c485bedfb7852 Alistair Francis 2021-06-15  145  	return 0;
8c485bedfb7852 Alistair Francis 2021-06-15  146  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


