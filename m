Return-Path: <linux-kernel+bounces-780843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F6B309FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B49623415
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BF2EA478;
	Thu, 21 Aug 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="f4LIXA2K"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F82E1EFF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819226; cv=none; b=etpxVTYCZAi6MzW62C8L4vOeQB3IIpXoeBhECH3zbQae0T1WB2KOp42z6i94WQGRrbwvZYV4WkVQ8iWVgWxPffDbzfQqhROmgX6/Y07EAoDIv2yGhbTUqY0Kq6SVGPeg4gXZ1PnylBIyxGeWfe+fQSLZwM1kC41gxQ7m8zgz2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819226; c=relaxed/simple;
	bh=DJeXCGYX6D/OlH0QEqQjuSy5fuYgqi7zZqhKILfluK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GU78TUuZpGMlZ6YEND9CI7V5sITZJuM4sstg4Hj81GzQSGBeC0K1ML7EfpZ9dN5NFEE6zqKwbgll/pDWqAzKxtJXiApBwJbQ6mL/jdVefy88kUB7WTAXKwRCAsTmi2AoVBxqDEPwaNfiRLtARzW3K0J9GGzAm87ilqsdG75wL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=f4LIXA2K; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e87055e1b6so231694985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1755819223; x=1756424023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvbh5Obgs9w+xkwaE6p3IluxarxC/+wS6HEpg73DttY=;
        b=f4LIXA2KqvYP3jSE2Tw5FeqTUubloMJxusbAyjpLek0wSXXnFI4AEzNkrOAKjrkcG7
         +1+oz0dUvA3XdGINt1eZdwv9Vg/w25GYjQo2J+nFHwd2ooLQdoljqNI0OZhyc5fimqbY
         l2JS6EYXYqeuVA5Gv60IfqkEJwtwepS7Lv34czKMszZGv5cpDX4795YWhirv63GCLWGk
         7Ccp3wnIN+DseDA6A5RLEMY8ZB/PvfpeGKdzuJHDkdkzMwQd3OaXeIvgeDJwgvo9UWS1
         LGgkPYFy7vQUyYe3u4GuBUtJOWtlTRBdiJR7Aj88mnu3lh11nGVMT/sJuas0yF1MLFhX
         LiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755819223; x=1756424023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hvbh5Obgs9w+xkwaE6p3IluxarxC/+wS6HEpg73DttY=;
        b=spxemASWOyR+DBH5wEngvwHS5mXBPFdvRLi9LpN1VypIxXJi31LxYf/AibQZbhGpQI
         bhABLKlAEKBf9lrf0JP3sRrE81KZG8By2SkSoB1WkLLGa+t3ZBmnCQGGE7sPFyvza7d6
         oy0UGXjPb5qdeYCeulLkNvl7u0RhOLJ6wypPKt28/QGqTXg41qYF+58ehXKbo9c6Fbzj
         davRRFVT6kQWl01G0T/ekMcPyy9xVVui/586r6H9+XVTo28tcRS2fhO3/f2kA/Wriya+
         vseWjzdTUfnPw4wyAu5fNiuyiOHmFja2GLGfyHhiBVQCKsqRH0AyKHj8vbhmKgAEyOrT
         nbcg==
X-Forwarded-Encrypted: i=1; AJvYcCViKxKJ86fF+/L8owf4QUdZLjujHZxBTwzpnBwOizCemtIauicTUrA8IpDuu5d/Td2uzq5mz91HjsNmVPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUewBv1vGNcG45hOjwMcs9rqJ7j7NK2OUf8tWTkHDTBc0595d
	j2JwXTTT7nEv6PAL3F04unMCdP6aLFXOeDpMlsEqAn3b+2EPzsupIWgOwWfPuluVsA==
X-Gm-Gg: ASbGnctajIQWE3sE+mk2kXkU129h8zW+z3aNkHg8VzYy75ZGIACXofi8+eOwbAzJlbc
	LAPOZBguvBMX+10P2+r8RiZyxVmo6QIkOOF1xQzpwxkFtdK6RpQozo10mPZdZf5ysSICvtJvtb0
	HqdQWiH6TTIa6BenkI3P/fK3ZE+vzuIAmq0uv9Gf1JKrmGG7fj3y5sd+C1fnhMp7p48O5jEH1Ag
	t/8VWn3yNwDiNwlg+KvoROB8X39vde8zlm+44WjM7tEq18Eu0TP9pyR5pABiix8mrowyYEedSqm
	Izj2NerDfXm1rfA/hMsj2o2Cww2oFIq36DYUhEvPN8IEzUzeXl6uJhU1v5nFNeINb1Z3oAozY+B
	R6OOG+fqGJlAnMXDoC7+uBfXBst0vkQ==
X-Google-Smtp-Source: AGHT+IEE8fYgK55NmdoQhhgPInOhivLoo6o9lQD203iWvd3p+5PTTXRIeOG74yZ2ZatbGTKv9Gbgbw==
X-Received: by 2002:a05:620a:4590:b0:7e2:23c2:e55a with SMTP id af79cd13be357-7ea10f73cf5mr175527285a.27.1755819223112;
        Thu, 21 Aug 2025 16:33:43 -0700 (PDT)
Received: from localhost ([2607:fb91:3b82:29b4:add9:bee5:e413:378f])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e0204ddsm1216833585a.10.2025.08.21.16.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:33:42 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>
Cc: Da Xue <da@libre.computer>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson-gxl: add missing i2c_d pinmux
Date: Thu, 21 Aug 2025 19:33:34 -0400
Message-ID: <20250821233335.1707559-1-da@libre.computer>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amlogic GXL has 4 I2C attached to gpio-periphs. I2C_D is on GPIOX_10/11.

Add the relevant func 3 pinmux per the datasheet for S805X/S905X/S905D.

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 9171de657f97..a75762e4d264 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -187,6 +187,9 @@ static const unsigned int i2c_sda_c_pins[]	= { GPIODV_28 };
 static const unsigned int i2c_sck_c_dv19_pins[] = { GPIODV_19 };
 static const unsigned int i2c_sda_c_dv18_pins[] = { GPIODV_18 };
 
+static const unsigned int i2c_sck_d_pins[]	= { GPIOX_11 };
+static const unsigned int i2c_sda_d_pins[]	= { GPIOX_10 };
+
 static const unsigned int eth_mdio_pins[]	= { GPIOZ_0 };
 static const unsigned int eth_mdc_pins[]	= { GPIOZ_1 };
 static const unsigned int eth_clk_rx_clk_pins[] = { GPIOZ_2 };
@@ -411,6 +414,8 @@ static const struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIO_TEST_N),
 
 	/* Bank X */
+	GROUP(i2c_sda_d,	5,	5),
+	GROUP(i2c_sck_d,	5,	4),
 	GROUP(sdio_d0,		5,	31),
 	GROUP(sdio_d1,		5,	30),
 	GROUP(sdio_d2,		5,	29),
@@ -651,6 +656,10 @@ static const char * const i2c_c_groups[] = {
 	"i2c_sck_c", "i2c_sda_c", "i2c_sda_c_dv18", "i2c_sck_c_dv19",
 };
 
+static const char * const i2c_d_groups[] = {
+	"i2c_sck_d", "i2c_sda_d",
+};
+
 static const char * const eth_groups[] = {
 	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
 	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
@@ -777,6 +786,7 @@ static const struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(i2c_a),
 	FUNCTION(i2c_b),
 	FUNCTION(i2c_c),
+	FUNCTION(i2c_d),
 	FUNCTION(eth),
 	FUNCTION(pwm_a),
 	FUNCTION(pwm_b),
-- 
2.47.2


