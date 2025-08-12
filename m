Return-Path: <linux-kernel+bounces-764446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5BB2231D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822901685A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F182E8DF1;
	Tue, 12 Aug 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GtwTgxXQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07352E8DE7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990681; cv=none; b=b/z/PZy+ABySdup6RkTbj84XXnZD1KMrZGwWq1NReXAPm5VsdWXesaXYm23IaACHv3ZiTpFf47DGSQ11COMD9DZR3KviDsaWNmbKuODt7Oy3Hdn+xlC6xn1DUlysvXFHNRfLzqG4X9VWl5Xr8JUwrVSToMOPUCmyvcpVjUk4KrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990681; c=relaxed/simple;
	bh=Q6SiaUMUBwADMLT46ML/ci6aY1rgmloSnDAqLBs4qCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lp1d+uZuAOsPCiIEnSrAeGcYVhu9b2Prp/LbG/l7SduvcxIR1i+1VhB2L/BMbYQJEArW7HjxKOGIROrJzyIkyC1wpHysRTafSGPVV53aNtxne3C27vN5OrVM3Ug7oNT9QG7PJa/wNrd4MoYj38uYLI5hjQaph2Rwru2sCI5LjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GtwTgxXQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso6194606a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754990677; x=1755595477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ik89ZT962vx6SU8Qf4vXzKTiJike3fWaSdDlAHYYf0=;
        b=GtwTgxXQnsELrIuvNxlBOHfQZMWA0tpqS8kvcCE0JoAFU9UlcQn2wgqGK8uWLrV9KI
         XR38OOjiqII5xvAxwLEMDzPFonYB/Qt2MI986zuvENCj668DEgqp1jm/ZuePUxunea6g
         dxteVRu/1LPDcgMzogFOb3LN7AtQhdoqrdBftU6SaU4T0Bu6RiLDAztuYWr/jZAUDBGi
         nzcytjyuZitml4WFo/OsM//lNokKmxi79mj0lTWiUp1rfR5niH8wGLFjVNK75MRhtPJO
         rRtKpo9SfNwaxhixTuJHBkW0rO8sC8i4xupbDax+flekpprC3SboK2O9IVkGyanNilvs
         n4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990677; x=1755595477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ik89ZT962vx6SU8Qf4vXzKTiJike3fWaSdDlAHYYf0=;
        b=JWQZ831DqU0fkLqz7BxV88Bh9WAK5+gmGhIFyIt70w8RWDaPvBKZ5ccsq5VX+Ww9HB
         /bnM6puNR/+7FkUcPR/D6NJgkRS1AlTA8UoDfjeSq9Pkbn0EkLmswtXq089XahFLXr5M
         DEe+UhvIk4TAA1Pk5mdYwguyA7NyqHuxwpyS0JcoUTnwaPPyi++DoYPtIYt5VZu6U+wv
         HTTSp20ULy1TGpZfA2l6ssW1WkSb81vI7Ey4gKcR0rUt+BHwA/ZYuDYdzaZE7uIq+lz1
         Lke42ypV486p6oE2YOtuWZCRsd+NQMcCVdEtCtfc7/Ug7sDCQt0pYf26DdByNhaRu+i9
         v5iA==
X-Forwarded-Encrypted: i=1; AJvYcCVN4LUXGp51tlsCUtJBDd+7z8q7mj/46Y1QKZeZOOAnvkXSWhnbZSGaTTioH/F13Ptrku33HlXowQYVC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmh5H6es/bZNT/oaBZG99apAMEpxNui1Rofe1AMUzFLIh2LuU
	jdovNI0LiIlEC9PEkC2Axgt8Ip3MXbZu6x4jqctnoxS7FnHFIipF0rzJ3XQhPgFjZGQ=
X-Gm-Gg: ASbGncsI641xiZKBjrBGcYyazrmvTUKfrD7Og/JW0UlGzIgEvv8UVYf/qtmFBaF/yer
	HzbYC0h5684ImyVxwTcdY65lTWtuPklx3wTEiM9jw3XEpTevP9QlC792BQe2rHomplLonAiEeqP
	REgC9p0WZdme/s3/jl8Ip/VJdBmUVyJYnzu+FxK/5zX1W6WxGOKtMQG9hbmdg33jMUHz9CyATXE
	kEHTyLkAU/elEv0fIwkvERvGnCGRqx95dAVomNf/9J7k8EFnNozfehoxkcFYBWjc2K5YKs/1w6e
	cU2XNc7DAsBxspq2omfKthUIy0BKJngPXjCnt2Z4QywSlerthnRghC5+mtNa6dnhONU1N5TmC2F
	giLvPQi2XTj2wHM4k0I3hBEP8kg7V262wP2vXV13Z4LvAiLVAnXa3w5aa8eM1lMtDnmVXYD+ijZ
	oS
X-Google-Smtp-Source: AGHT+IF0y/ejWJ54lbTQXObqXK6yYP3pFrZAFOlbINbsKGuqFolmXDycq6lrJK1l59TCnacyLDHgFw==
X-Received: by 2002:a17:907:a893:b0:af4:148:e51f with SMTP id a640c23a62f3a-af9c6375c30mr1421293766b.2.1754990676889;
        Tue, 12 Aug 2025 02:24:36 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm2202606466b.17.2025.08.12.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:24:36 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] pinctrl: rp1: Add regmap ranges to RP1 gpio controller
Date: Tue, 12 Aug 2025 11:26:18 +0200
Message-ID: <20250812092618.14270-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current gpio driver for RP1 shows only the very first register
from sysfs, e.g.:

$ cat /sys/kernel/debug/regmap/1f000d0000.gpio-rp1-pinctrl/registers
0: 0abe0000

Add the correct ranges to the regmap configuration.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pinctrl/pinctrl-rp1.c | 95 +++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
index dadafc935dbb..b231efc62ff3 100644
--- a/drivers/pinctrl/pinctrl-rp1.c
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -1623,12 +1623,97 @@ MODULE_DEVICE_TABLE(of, rp1_pinctrl_match);
 
 static struct rp1_pinctrl rp1_pinctrl_data = {};
 
-static const struct regmap_config rp1_pinctrl_regmap_cfg = {
+static const struct regmap_range rp1_gpio_reg_ranges[] = {
+	/* BANK 0 */
+	regmap_reg_range(0x2004, 0x20dc),
+	regmap_reg_range(0x3004, 0x30dc),
+	regmap_reg_range(0x0004, 0x00dc),
+	regmap_reg_range(0x0124, 0x0124),
+	regmap_reg_range(0x211c, 0x211c),
+	regmap_reg_range(0x311c, 0x311c),
+	/* BANK 1 */
+	regmap_reg_range(0x6004, 0x602c),
+	regmap_reg_range(0x7004, 0x702c),
+	regmap_reg_range(0x4004, 0x402c),
+	regmap_reg_range(0x4124, 0x4124),
+	regmap_reg_range(0x611c, 0x611c),
+	regmap_reg_range(0x711c, 0x711c),
+	/* BANK 2 */
+	regmap_reg_range(0xa004, 0xa09c),
+	regmap_reg_range(0xb004, 0xb09c),
+	regmap_reg_range(0x8004, 0x809c),
+	regmap_reg_range(0x8124, 0x8124),
+	regmap_reg_range(0xa11c, 0xa11c),
+	regmap_reg_range(0xb11c, 0xb11c),
+};
+
+static const struct regmap_range rp1_rio_reg_ranges[] = {
+	/* BANK 0 */
+	regmap_reg_range(0x2000, 0x2004),
+	regmap_reg_range(0x3000, 0x3004),
+	regmap_reg_range(0x0004, 0x0008),
+	/* BANK 1 */
+	regmap_reg_range(0x6000, 0x6004),
+	regmap_reg_range(0x7000, 0x7004),
+	regmap_reg_range(0x4004, 0x4008),
+	/* BANK 2 */
+	regmap_reg_range(0xa000, 0xa004),
+	regmap_reg_range(0xb000, 0xb004),
+	regmap_reg_range(0x8004, 0x8008),
+};
+
+static const struct regmap_range rp1_pads_reg_ranges[] = {
+	/* BANK 0 */
+	regmap_reg_range(0x0004, 0x0070),
+	/* BANK 1 */
+	regmap_reg_range(0x4004, 0x4018),
+	/* BANK 2 */
+	regmap_reg_range(0x8004, 0x8050),
+};
+
+static const struct regmap_access_table rp1_gpio_reg_table = {
+	.yes_ranges = rp1_gpio_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rp1_gpio_reg_ranges),
+};
+
+static const struct regmap_access_table rp1_rio_reg_table = {
+	.yes_ranges = rp1_rio_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rp1_rio_reg_ranges),
+};
+
+static const struct regmap_access_table rp1_pads_reg_table = {
+	.yes_ranges = rp1_pads_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(rp1_pads_reg_ranges),
+};
+
+static const struct regmap_config rp1_pinctrl_gpio_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.rd_table = &rp1_gpio_reg_table,
+	.name = "rp1-gpio",
+	.max_register = 0xb11c,
+};
+
+static const struct regmap_config rp1_pinctrl_rio_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.rd_table = &rp1_rio_reg_table,
+	.name = "rp1-rio",
+	.max_register = 0xb004,
+};
+
+static const struct regmap_config rp1_pinctrl_pads_regmap_cfg = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.fast_io = true,
-	.name = "rp1-pinctrl",
+	.rd_table = &rp1_pads_reg_table,
+	.name = "rp1-pads",
+	.max_register = 0x8050,
 };
 
 static int rp1_gen_regfield(struct device *dev,
@@ -1685,17 +1770,17 @@ static int rp1_pinctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pc->pads_base), "could not get PADS IO memory\n");
 
 	gpio_regmap = devm_regmap_init_mmio(dev, pc->gpio_base,
-					    &rp1_pinctrl_regmap_cfg);
+					    &rp1_pinctrl_gpio_regmap_cfg);
 	if (IS_ERR(gpio_regmap))
 		return dev_err_probe(dev, PTR_ERR(gpio_regmap), "could not init GPIO regmap\n");
 
 	rio_regmap = devm_regmap_init_mmio(dev, pc->rio_base,
-					   &rp1_pinctrl_regmap_cfg);
+					   &rp1_pinctrl_rio_regmap_cfg);
 	if (IS_ERR(rio_regmap))
 		return dev_err_probe(dev, PTR_ERR(rio_regmap), "could not init RIO regmap\n");
 
 	pads_regmap = devm_regmap_init_mmio(dev, pc->pads_base,
-					    &rp1_pinctrl_regmap_cfg);
+					    &rp1_pinctrl_pads_regmap_cfg);
 	if (IS_ERR(pads_regmap))
 		return dev_err_probe(dev, PTR_ERR(pads_regmap), "could not init PADS regmap\n");
 
-- 
2.35.3


