Return-Path: <linux-kernel+bounces-746734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A0B12A97
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF24E705B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CF248F57;
	Sat, 26 Jul 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dG+4ollu"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61300246BC5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535415; cv=none; b=tmqL1iW8zT2pHNxTFcPdcBSesaYgGe/HuvSxIsTb9CNVB2REev8aX0LK+275CW+BQ+6xqKq6q3uy5JMZQ0gTGMsUrtFi0QA7LZnR4sLvCcTeb5RXvCbXG3TME2DY3zuYjMzPwRcKe3JEsw+stUJgPIBwNO4FBZkkR1h/ZNnpr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535415; c=relaxed/simple;
	bh=i24VZQoL4HdNicf8fZrx7hfEBriE1Lb+9VIUFSrq24E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyMuEjVNoJCr6s0AP6LY91uiBHg/uWoGbE3/3WZFCZjAjcnMvAw5fdTk1vOTT6W0J6vV7toT8ioRu2XEozjdqp4UJmc+6xQRit0N28whkCjopDXXBSI41p5iO6BBJQad8bzNPfVj3vWJUB/Itbaw2GVMrlB7t/IhBQpX14Ck1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dG+4ollu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so243044739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535412; x=1754140212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBjRH5dYFSfxMS2Dw/xrzSnit2iXBotKiwm7tMWcaRU=;
        b=dG+4ollu30Ry+lgXOeq2KFgfSF/tjhwFz6Lgt5s3FNiPOwjMOsge5JQAuyiYM658oZ
         nKV/H6umysR4seyMKph3u/Arq5VStH36mYiLFhYYlFlm4nIDYn4dKQMjFJheiLNVp6u5
         hsXirVeM92LE9oIYKDv6qT7dn+KVIyeLX27A2xqDk9D+kxg3KqLqp3MHKjOuAwNZ4ZL6
         aslVd21jZqzcZoOZiHNdFXKxtnEFyZcxr7Gil+7TWVprSyXl9CDF+JJF+DlrqmDs72N4
         RZTcAT+cChsvEVzAvutVoWkvEeolIyo6V3O+2VGfVs9Mzd+bRrN9wEcHGFSiiCx3tQ19
         RPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535412; x=1754140212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBjRH5dYFSfxMS2Dw/xrzSnit2iXBotKiwm7tMWcaRU=;
        b=uWUgdbrCH0z9OhWhRa1OQbo//kCZDerqkWk1RSfJrktvyZFfZXp34pNQsLKNA+d1M2
         09S5jO6EJE+EX9WXQGH8uwlpXb19mv7DmJl0nnmV5qGdbcapu/nlfLvv4OLA7cyFRhjz
         M71Ws652RukAePJ3wZ5YvN373X96MhegvJhZHmxjHTy2U3ObRvKthPwruAqN+SlUiHQm
         G2spsik4GPPJeft7QqSMUM0++Hc1zoXulOGklN4WYNA9Kgim9x4vQuS/ZH5lHo815YpQ
         mjx37cGc3cq3HT4zeZ1MX+Dl1xCMLbSmgG9ySr+PMsabUrfoqMpJr5mIH5mDlO1nLUuv
         DNAg==
X-Forwarded-Encrypted: i=1; AJvYcCVCakI1zhPRqVURnsO3T+k3mPLahj9KgKwpQ42ryso5q8LK8CjwdzQVUELMN3bF2oqYyji8xyCbvda00ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfshh2mac9sGNGRHDIiQJvMxgpQYE1ucvXRW7/YKEwtuVZco1
	ewjTzH37+TVzlp1qeOFcIDE12rpce+9iqnB9wBa1QoYF5Rdw25ccz2v33f3OTGTUiHQ=
X-Gm-Gg: ASbGncs/80ahUrqTuG2fbhmBeVLhc7Dtdx+cdHqa+xoysSx9kWPYMA76ev9BD1dQ/Cv
	rjmPJz2dzCHsvTHq6Xv5sEzBe5M5nXomFnoAN5+SPyqhgal1dtAMfj7UV6oYB6msyVSBibjqDXX
	nKGb5sYt5xYSQLpK9PQeeWMhd1HWpGj2phBeWNRhM7PK3KJNY7KrNsQ+SjUljoAibpQrQu9Y67t
	KAzr/Rq601z8BhPpqJxqAUpuRr76Qor8u++41oe++VNDIeU2JJ5OlE9GiCB4QUDHC92UXA+7OwO
	ajRCWcMD8FfITpG4+bNvRvWePBKFscR13sLH4N1r8tiWHGrKMtuVo2BJlDUwx0RAbABvsBPmBaB
	OzbVTrcK8bJIVgE+6x9DtZXyHqAsgpvpjFuro0KJCZcXGlsvPOG8arNjx4wVDBRDbxg==
X-Google-Smtp-Source: AGHT+IEMiSe1+TI8S2A/w2fU5yeWMCGvndi/cNc/yR7qunidcz9YFlCFnwcgzawUglMsdcxbT5XxBQ==
X-Received: by 2002:a05:6602:1582:b0:879:c609:f5a1 with SMTP id ca18e2360f4ac-880229bbf86mr905586239f.12.1753535412429;
        Sat, 26 Jul 2025 06:10:12 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:11 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/8] mfd: simple-mfd-i2c: specify max_register
Date: Sat, 26 Jul 2025 08:09:56 -0500
Message-ID: <20250726131003.3137282-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726131003.3137282-1-elder@riscstar.com>
References: <20250726131003.3137282-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices supported by simple MFD use the same 8-bit register 8-bit
value regmap configuration.  There is an option available for a device
to specify a custom configuration, but no existing device uses it.

Rather than requiring a "full" regmap configuration to be provided to
change only the max_register value, Lee Jones suggested allowing
max_register to be specified in the simple_mfd_data structure.  The
8-bit register 8-bit configuration is still used by default, but
max_register is also applied if it is non-zero.

If both regmap_config and max_register are provided, the max_register
field in the regmap_config structure is ignored.

Signed-off-by: Alex Elder <elder@riscstar.com>
Suggested-by: Lee Jones <lee@kernel.org>
---
v10: - Rename simple_regmap_config() -> simple_regmap_config_get()
     - Introduce simple_regmap_config_put() to free regmap_config

 drivers/mfd/simple-mfd-i2c.c | 45 ++++++++++++++++++++++++++++++++----
 drivers/mfd/simple-mfd-i2c.h |  5 +---
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 22159913bea03..3622f189c8342 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -29,6 +29,40 @@ static const struct regmap_config regmap_config_8r_8v = {
 	.val_bits = 8,
 };
 
+static const struct regmap_config *
+simple_regmap_config_get(const struct simple_mfd_data *data)
+{
+	struct regmap_config *regmap_config;
+	const struct regmap_config *source;
+
+	if (!data)
+		return &regmap_config_8r_8v;
+
+	source = data->regmap_config ? : &regmap_config_8r_8v;
+
+	if (!data->max_register)
+		return source;
+
+	regmap_config = kmemdup(source, sizeof(*regmap_config), GFP_KERNEL);
+	if (regmap_config)
+		regmap_config->max_register = data->max_register;
+
+	return regmap_config;
+}
+
+static void simple_regmap_config_put(const struct simple_mfd_data *data,
+				     const struct regmap_config *regmap_config)
+{
+	/* This condition holds if data is null */
+	if (regmap_config == &regmap_config_8r_8v)
+		return;
+
+	if (regmap_config == data->regmap_config)
+		return;
+
+	kfree(regmap_config);
+}
+
 static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 {
 	const struct simple_mfd_data *simple_mfd_data;
@@ -38,13 +72,14 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 
 	simple_mfd_data = device_get_match_data(&i2c->dev);
 
-	/* If no regmap_config is specified, use the default 8reg and 8val bits */
-	if (!simple_mfd_data || !simple_mfd_data->regmap_config)
-		regmap_config = &regmap_config_8r_8v;
-	else
-		regmap_config = simple_mfd_data->regmap_config;
+	regmap_config = simple_regmap_config_get(simple_mfd_data);
+	if (!regmap_config)
+		return -ENOMEM;
 
 	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+
+	simple_regmap_config_put(simple_mfd_data, regmap_config);
+
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/drivers/mfd/simple-mfd-i2c.h b/drivers/mfd/simple-mfd-i2c.h
index 7cb2bdd347d97..6fa36b3d7a217 100644
--- a/drivers/mfd/simple-mfd-i2c.h
+++ b/drivers/mfd/simple-mfd-i2c.h
@@ -8,10 +8,6 @@
  * shared by all sub-devices.  Children can use their parent's device structure
  * (dev.parent) in order to reference it.
  *
- * This driver creates a single register map with the intention for it to be
- * shared by all sub-devices.  Children can use their parent's device structure
- * (dev.parent) in order to reference it.
- *
  * Once the register map has been successfully initialised, any sub-devices
  * represented by child nodes in Device Tree or via the MFD cells in the
  * associated C file will be subsequently registered.
@@ -25,6 +21,7 @@
 
 struct simple_mfd_data {
 	const struct regmap_config *regmap_config;
+	unsigned int max_register;
 	const struct mfd_cell *mfd_cell;
 	size_t mfd_cell_size;
 };
-- 
2.48.1


