Return-Path: <linux-kernel+bounces-838639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C9BAFCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410BA7A8C80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFA2DBF47;
	Wed,  1 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsIELARi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BE2D9499
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309851; cv=none; b=f2kaeqcKCW/221Xvj1bjtuWfTJO2DPxQypqBtUL/gUnjav+Jnr+b3BnjlMW/pHB7as/ugXadTD9MjSIKM3U7qlAtnxrOoSHFR0lOJhQY5+G/eBNMCOLjYYpDMHHLRiU9jMMwnjGoFqwjNpmpqHL4YE4r7ZyMY2kvI7meHXq5ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309851; c=relaxed/simple;
	bh=9L3gQ0+1ET6P5sIpnbODjpkXwsRD7oIboYXbSSEzbwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9JkL26zLHkGpmjKsFeGGukuIVf+lI5SuTEnDga0aBSq0P9Mxb6X4Es2Mwc7bTpIaOOfLieCSBXk6tDmn5+thEJSnAcgpXjlY8oRhjITFYaILhnYDabyqqulThlBrgw2bjbSVM9CEtkpJXRl4MKI2dupG8NskqJViuMWnXErIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsIELARi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917vFuI018680
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2YfY4oJdQ6f
	kUnOWCE1mjTXBY2BCI5s2fVtajgXgfUc=; b=LsIELARiPPwesTYXjHSHt8Z10ma
	sFD7n5vahRbPW3fCJVxRc65va3k2uq+fs5da+E20IBDXf1vCDs4VqlBUAv7hscjY
	deQqLb8ROinDRfnSrxiB2kqFDwzSmvAsvTIuh7Sa/X7HdmfXLhL9K+I3b+x3+ya2
	foVwbJn8AE1oInxdoTnkj8uiyxTgIa/jfvRAcHLCqJbxXbS6tiZxXDBDSrwJh0W5
	Yu4HNUFl8wowYPaSbwUhqVTTbVIBlE8sSd12WJOwzaZ68Z6pqGhIbWohP+eMOt/c
	MDYHaZWlt/i7fgmr5X7pgECRzkG6GfGIx6vWuCb710on80JFWdPa5PYQIDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tv5gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so6253920a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309846; x=1759914646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YfY4oJdQ6fkUnOWCE1mjTXBY2BCI5s2fVtajgXgfUc=;
        b=iMMheuilsYfgIKrbTZMbgYIRPS7+oG7F6S45+adFJbIS/hTBHWubVOfldehz2Qwett
         p9DCPRw4TQ//SMM1JJaIFQI/NBNjuEqJ0/06aBt3lTBxYhX02t/Z+mg6y1cOpNd4bhBV
         l51Sbq90jw9w/MPXnYbw0zw2vxAlYDvGFjhihCZupwlxOH792a0m0m4XS6M0HdcaB5yM
         NSwI52yIX0z3dd0J26bJIk79PTKDPII6q9lu439ByCSjdTfCa5C6aQSzPONnmMupehfj
         FO0i2tc9WoIiFo4HZpif+39wDIKo0tz7BhEMlQ+wJ8sfIEAbXvI8SWorJgdDvv2QE5Yk
         aFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVBKetMOeipXcGHTGUYo+OgvcBbopJEIBUVhbx3vFwx49IMMVj7L1ttbcbo9rP7BiGYoqDATPmmmqIUfIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiW4jTzz+vMn5itiCAoNa3eTwfiskOQHsuEhMQiyS23SUL/Oqw
	GxMxYwEd7ADqYGXi9dvQJD03qRi6gtC+zPl+5ORvjew6a2/MGsA6l/ihB68ROtEAXgwcWgGbNt2
	G898q19BTn7Qgbkz5W4Y9BqmxIVTzSh2FlaHQrp/tLIY5v06R6gLIrINIdmmJi6lgvyg=
X-Gm-Gg: ASbGncsLIuLeeJvNbmi381h8w8waxQT6i9hQflxgs3FBjCf/oweCML5zJkWaHgu1NJm
	irRL2DLqK/BYH9AMAazsMTIoC3Ao8F9zY433iWnaIqcrSgxlIcJbtCyuLkoQ83d6VTQ1DSTb8Nj
	gT+5FWYTExI0nHStg9tEh9V5Q+YJf1g6mNq66DwRv6D/6bSxpZktL9KOeUwrXtSf+5pBrClzXrx
	jyGmQcXDbJMU8e8mtPJUkc++2HUo7wOKxfvOE6q+gMGgfktJhW8tOsqCwtMgzfH0rfOWK6gi0QN
	wdRYqo0GIQNaht8GE01b5AzGdyfQTTdeYZAldndLBHeo7zqE5FMYtm9EkdudrFyt4qnlDhNEceP
	ANZ/X4A==
X-Received: by 2002:a17:90b:3c92:b0:32e:23e8:2869 with SMTP id 98e67ed59e1d1-339a6f688d5mr3095946a91.30.1759309846003;
        Wed, 01 Oct 2025 02:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESdbSxcj6fFTqJ2XMnzUJV1v2CK57SbLMejOkZNBQx8uvv4Qof2avs+1XJXZSiDjbkGUEPlg==
X-Received: by 2002:a17:90b:3c92:b0:32e:23e8:2869 with SMTP id 98e67ed59e1d1-339a6f688d5mr3095899a91.30.1759309845542;
        Wed, 01 Oct 2025 02:10:45 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:44 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
Date: Wed,  1 Oct 2025 14:40:05 +0530
Message-Id: <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX72cZET9iumWE
 WRIw7PPQgIjYAAuu8xuo2F7zzluwSA9aJyOs5O+laaIDDo796HIgs7ChypRUi0IFEwAoihRCqII
 Hx92pICMfdkYkJwtCsJug8WlBu6YsMmhv4q9+M9I1BlYN0J4XBZmX43SJhpUZ2WEI9LCnUFzpgN
 K5KiH4rxAYDbgruz4PN+SUws3GHG6GXsDSG1eM41ufsKekdIF2AWoR7hnvDYHooN5DgLWu/ugbj
 Q4CS0+/wyOhmjHY+OoAB9GehHr1mO+NR2JTZpmw+2q4s7Yw/Nujb28d+cXtNpGrKHL5bgvmcQx7
 nZ5wM5hlH6JVA5blmc8KfAUVLJwgR/jOCJqdizku6FH81REbeaWCJqAh113yiubTHsPewoqG8p0
 Cf4uHGGvSKAyQpnWYRecHpLMsNDIag==
X-Proofpoint-GUID: Pv_9oh11gDy2xVRJM69nBqaVnF7vvE95
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dcf017 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tLDx1KCooYQGmN993QAA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Pv_9oh11gDy2xVRJM69nBqaVnF7vvE95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

The mcp251xfd devices allow two pins to be configured as gpio. Add this
functionality to driver.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 160 ++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   2 +
 3 files changed, 163 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/Kconfig b/drivers/net/can/spi/mcp251xfd/Kconfig
index 877e4356010d..7c29846e6051 100644
--- a/drivers/net/can/spi/mcp251xfd/Kconfig
+++ b/drivers/net/can/spi/mcp251xfd/Kconfig
@@ -5,6 +5,7 @@ config CAN_MCP251XFD
 	select CAN_RX_OFFLOAD
 	select REGMAP
 	select WANT_DEV_COREDUMP
+	select GPIOLIB
 	help
 	  Driver for the Microchip MCP251XFD SPI FD-CAN controller
 	  family.
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index ea41f04ae1a6..586336d9e421 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1797,6 +1797,160 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+static const char * const mcp251xfd_gpio_names[] = { "GPIO0", "GPIO1" };
+
+static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
+	int ret;
+
+	if (priv->rx_int && offset == 1) {
+		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(priv->ndev->dev.parent);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, pin_mask, pin_mask);
+}
+
+static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+
+	pm_runtime_put(priv->ndev->dev.parent);
+}
+
+static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_TRIS(offset);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	if (mask & val)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_GPIO(offset);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	return !!(mask & val);
+}
+
+static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				       unsigned long *bit)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	*bit = FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
+
+	return 0;
+}
+
+static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
+					   unsigned int offset, int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
+	u32 val;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask | val_mask, val);
+}
+
+static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, dir_mask, dir_mask);
+}
+
+static int mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
+	u32 val;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, val_mask, val);
+}
+
+static int mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				       unsigned long *bits)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+
+	val = FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  MCP251XFD_REG_IOCON_LAT_MASK, val);
+}
+
+static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	struct gpio_chip *gc = &priv->gc;
+
+	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
+		return 0;
+
+	gc->label = dev_name(&priv->spi->dev);
+	gc->parent = &priv->spi->dev;
+	gc->owner = THIS_MODULE;
+	gc->request = mcp251xfd_gpio_request;
+	gc->free = mcp251xfd_gpio_free;
+	gc->get_direction = mcp251xfd_gpio_get_direction;
+	gc->direction_output = mcp251xfd_gpio_direction_output;
+	gc->direction_input = mcp251xfd_gpio_direction_input;
+	gc->get = mcp251xfd_gpio_get;
+	gc->get_multiple = mcp251xfd_gpio_get_multiple;
+	gc->set = mcp251xfd_gpio_set;
+	gc->set_multiple = mcp251xfd_gpio_set_multiple;
+	gc->base = -1;
+	gc->can_sleep = true;
+	gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
+	gc->names = mcp251xfd_gpio_names;
+
+	return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
+}
+
 static int
 mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 			      u32 *effective_speed_hz_slow,
@@ -1930,6 +2084,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	mcp251xfd_ethtool_init(priv);
 
+	err = mcp251fdx_gpio_setup(priv);
+	if (err) {
+		dev_err_probe(&priv->spi->dev, err, "Failed to register gpio-controller.\n");
+		goto out_runtime_disable;
+	}
+
 	err = register_candev(ndev);
 	if (err)
 		goto out_runtime_disable;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index bd28510a6583..085d7101e595 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -15,6 +15,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/regmap.h>
@@ -676,6 +677,7 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+	struct gpio_chip gc;
 };
 
 #define MCP251XFD_IS(_model) \
-- 
2.34.1


