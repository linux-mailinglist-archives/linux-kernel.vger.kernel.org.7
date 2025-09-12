Return-Path: <linux-kernel+bounces-813746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEBB54A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED14AC237A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E72FE06D;
	Fri, 12 Sep 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNcVc/IG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D152FDC5C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674061; cv=none; b=LcK0AI1ioLm4T6jVkazOFDXkqtbyuA329cvQu2sO6q1u0syX1Fc2Qyb0NweBwXjmvXu/BmwvYPYP4OkC1iGV//WmkiOCkwdYljDPLVxtswAxkQDmfds3UYVWuwob7oVwe1FlDOWIL5xgS1AG0pDeRGHcSKasLCWsT31RVNHMG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674061; c=relaxed/simple;
	bh=KA+sI7ufjFyPZYwEYQoZfZGFYRielFswFPXUoh/FBo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDZ4d5prnuWqQ99Tj8sMlsejKZOZ/c3nUG6zNoQ96jSWS0xyXz2OU++KjK5onehVS1MHYYOSuij2fKYmci9q/hEkQXmCp87WbfrVNKoagNS3NM6nhPVlikfalZcMQHtf3exS/nD/72Fj1ajY/UNHn7ycYcOVDUV8Vyh3yzXSmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNcVc/IG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso17637985e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674057; x=1758278857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7yeEcm3Ced8ELUFuY76TaeRPtauHExqRBxvtKmA4Mc=;
        b=KNcVc/IGshwKGIDvMMrPcgnA/b/rIjGQ2gG77A/GvQzblWZbQHG6+ZL2delpTf2fvN
         TNSyTmLauk9bWoP8e7elMneJU+eaFuCWOZRNQwJq3ehYIbqvkcd7LlnxgEjqTjS2PVRJ
         fuYco0vYc8zbR5V/Qvpr7639vxFarPDXRMg6mrxJAnmOTA3nx23ihcOhcgJthVC9qG68
         qBrmZfHY7+DRzpsLawfAgkeArXqihShoLscbza4wmzdCuYRW+QvyLFaobmbqLsfTx8Zt
         odhBciwyNZTuU1o7p1waaVUaxT3gtSBDXiRBbovjLfcZd9uyOJH+0vai8s1lzGWPV2pr
         dI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674057; x=1758278857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7yeEcm3Ced8ELUFuY76TaeRPtauHExqRBxvtKmA4Mc=;
        b=GuS/E4trzYDaejo+2ilsD9f6cqnq8+BRd+5NyPo4AiWLCI2X6VzlBak8x5Z/dNppjg
         Jcolj/5o6F4EHPIzOlEL+1PUJSjFBY9ao3RZ0zLzjT1lATAyMx/yyEU179+bi1H/KLSr
         lqxswrVFyRqMCtBHauLvuC/tt7O9TCHqgALXCH0hcv9oz9zn4bCnSZvwakHr5ogpad0J
         wB/14fbR5b8mq5N3xdTyI1ydH4XG+dwhvEAfacWXOyOgAaWHSU6qlFTQGugWUW7sDTmT
         euhBsdoJ4g3dtLx8I2ibkRPr0PPtrnAJ2B1ovqfO892vwN8w+7A2yqLAysdGgLsZDvXZ
         PYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVh6tPn9UyHk1GfNdcXow+lEPXQwZVFSLvkorD+l7Ag5XyrqeCO+Qfo+sUG3rP7VIH7Ft7J3YShogXV0cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVizWo5JOc5mNJXPE/WD4ZAnQirla6tzk+qPrf0mQLW1flesu
	PjP/+n0yCLfL7r38e+NRtFvRM98eWwlsKkrHC3wg9w4AMj5frSnKKnf3
X-Gm-Gg: ASbGncu3YzHwtiO9yr4qSL1A/k5aQAHfMH6jIHqohwssslH2dk0WE/y8zHJ5AehuJpz
	3lO/aSu3200eBGAyPqGO2l2BeBNlvmXrYuQUxZ/1F9ccz+FJo6YYFIJeAKEMQiRY9KM6DS6bT6a
	AGh+kl4C+Op0QzO5ay2a8Cx7SnosokpxiSz85g8TuF3v2GpZWXOsNrUJhuOGcd2SahCNJXoUMm0
	UbqiHSb+J2U271jD/1pBh5DKPmiN7S9CmcqB100PV9/4voF8nukKsD2kJ7iPoQuR6gj4YghYDBZ
	JeG3S84JnSCKFKf6xMAQXbfG1Lkz1qiw5vUbb3JQWIAJUtgE6sS21QZAMCyEQcMlJaWL9ZyQfQ/
	X91Wsgv4sdOveruVa2rCIYv9x0MHVzlgSHQ6OvBztJqtCXoUTeVce0BieEpNhywiwxU/Nbi+CCR
	SJQg==
X-Google-Smtp-Source: AGHT+IGrhgEWEAy/UQRry9eO3Ixag9/wrNC8n1JxqWbGRYDy8gImXUuDgETKAkJ8vsUGzKh4KDII4Q==
X-Received: by 2002:a05:6000:22c5:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-3e7659f3385mr1834367f8f.18.1757674057078;
        Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from probe()
Date: Fri, 12 Sep 2025 11:47:21 +0100
Message-ID: <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC. This change also result in less power consumption.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 460bb62bbd08..da469595be74 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -468,6 +468,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1975,7 +1976,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2065,10 +2065,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
-	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
-	if (IS_ERR(clk_ram))
-		return dev_err_probe(dev, PTR_ERR(clk_ram),
-				     "cannot get enabled ram clock\n");
+	gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2134,10 +2134,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2189,6 +2197,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2213,6 +2223,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


