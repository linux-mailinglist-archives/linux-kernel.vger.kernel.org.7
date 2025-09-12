Return-Path: <linux-kernel+bounces-813748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC2B54A43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6873EAC23F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082AF2FF171;
	Fri, 12 Sep 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f52isW18"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42972FE06C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674062; cv=none; b=mdAPliFiBsbReHSJWTZxqZqr2BynvsvFokuoutOliU+nNg0cCQmGrjN5Oq1gDhFPkLXM7RnpjqbBAfR7eAghRPa60I0NpIhEf2psCfXKd8D/cd5dat8PKTB3jYgoLb2ATy+lb5yaNZgrCOb1BvHy15iDRa+m+2nI9MlVJPDzvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674062; c=relaxed/simple;
	bh=GZsNYIhNQW8nw8uQfQs29srO1uUH4jHzjoSIQlnEnCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFWbOKDSEoUOUYKL1aBf5I5A8eurtogU1WpDUF0DcANnMnHtiEQfvFBtg+eAf2ZH0SUvki32KwTNQ5ZduK5K02GWbmuEmxtJkWodqmVxj5pQjAjII8aPdJbdsaABrNzm+fzXS9vKhaLPNYtU6fnWdX3BhWDq/enzY7Gi8pjJP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f52isW18; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e7622483beso932963f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674058; x=1758278858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=782JgLcVZE5V/iz3CxpYN6+/kxhPh4WkNQ54gM7xbls=;
        b=f52isW18N8CS74Bo6yey9cFjnCEhAd3g0036x/e6kOAaPv+HCOporMRcNNWRRzwHmT
         xGMxykRir8F7VF9Cc4KM5gTAoINPcY2VgZ3m89qJUCvZOVhCvHH8uYFEitDWNpkW0fFw
         cyoQshSP3SArNhW0aqVPeawWkZVoljWOwxt/lhAxTbCiSpHsxnmX3Vv+HnMYn56k/HnK
         7x78qJR4TZofRBFEtoddmIO5T8jhjkQguVEc/J5iv+jVO7UYQf66mqarw3LW9zuj+Nxv
         mpjfyZb3EauFWD7Yq4UtA1blfU6M2U0C50K++psCejQUBulLmh821j+QC/ITsECiuM1t
         rJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674058; x=1758278858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=782JgLcVZE5V/iz3CxpYN6+/kxhPh4WkNQ54gM7xbls=;
        b=iturJFrhGBSgM6p2SVfVgXABHls+efSO3QJS1+nnHlar+UNlMxatq0t7zqDov90rud
         lUTUEBXHWF0zX7QVv8fg7a1fQ3HfISYn8018EgL6XYEbiuVglndhZN9B5XC4Y4wh9nKd
         qWyQAw53KeepQIN5Y3kJVLTLVp7xK6/v8s5kyZ4G8U8nTbG437IaL6NryXK42E4SJLWU
         izVXL6tGZs+sb43y9aBI5aCNgNUSGf2GbRSRSRv4bMXK+4QQygSE+cjlon8hJkJvvSMP
         mhaQv0WrwpcfBpJe5bIeUaqVIaWavbywqa0agLtewF1qmQQ8luj4+tufAu3rE1a1n0BQ
         OO4A==
X-Forwarded-Encrypted: i=1; AJvYcCXyfSck+3iR/El3Zxl23f8QlgjNEy7aLSLAUjdkOASbcj0hrvEwJ9ZwJ1Sg542EJJIbTHd+nPcO1Jg505E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZ7cddiyUzs5PcXj/l5JaRZDu6Md2esxZIt2QLCAs2FCfrihu
	x5pcV3QaI+9yBn6OUeR01bgn7sQWilveVTIQy2R0KXh0mVaQUga4QgPS
X-Gm-Gg: ASbGncu8Ne+rV4IzTWsB0IZDPTOy5s+qgkfX64SlYvUBxl5vuOj6x2tp+rgMZdYk/50
	Uz5kYsEG/hT9iYPK+Dh3XjOIDKv93DBHHTlYt7JDjIbvL+hjIBpvPqq5zBBeEicdiHkRTtNIyLH
	FbB/zevU/6+223QayrAwK+nfsv9k4sMu/UYV+tx8MGZi1//IYczC2QSRYmRDOucGSUeh+px6Bug
	Fzm0+94pFLC8HoKiJRbop9WwiG6YF00dQtIkEb2w9m6wWmv6rWtvn3f913Bgms5HcX76RFhr3c5
	wpEwxMY2pcmQPA07j+cJJfMHX6mqQ3FNoAMCIZYL7F4yavznsi9xLSMzE5tWguTQs/BPy3mSp2E
	6gnXgODltfKOumFxicgEYV0Jhe2sPSxxRFFpcbolxXhG0yEoBQSNlVjsRPNeNuqv4Zki7SpNy68
	/Yfw==
X-Google-Smtp-Source: AGHT+IFr4IwLBTu6cjtpwB2lWd5M+6tpZjnmPqolt3ll/etGNw+S2XNN5WwUzpzDYgAHZ+JIpF+qyw==
X-Received: by 2002:a5d:5850:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3e765a1b215mr2395804f8f.53.1757674057766;
        Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 4/7] can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
Date: Fri, 12 Sep 2025 11:47:22 +0100
Message-ID: <20250912104733.173281-5-biju.das.jz@bp.renesas.com>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Extract the code to (de)initialize global state into separate functions,
for future reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Added RAM clk handling in rcar_canfd_global_{,de}init().
---
 drivers/net/can/rcar/rcar_canfd.c | 182 +++++++++++++++++-------------
 1 file changed, 104 insertions(+), 78 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index da469595be74..c26a605659eb 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1961,21 +1961,120 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 	}
 }
 
+static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
+{
+	struct device *dev = &gpriv->pdev->dev;
+	u32 rule_entry = 0;
+	u32 ch, sts;
+	int err;
+
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		return err;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
+	/* Enable peripheral clock for register access */
+	err = clk_prepare_enable(gpriv->clkp);
+	if (err) {
+		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_reset2;
+	}
+
+	/* Enable RAM clock */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev,
+			"failed to enable RAM clock, error %d\n", err);
+		goto fail_clk;
+	}
+
+	err = rcar_canfd_reset_controller(gpriv);
+	if (err) {
+		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
+		goto fail_ram_clk;
+	}
+
+	/* Controller in Global reset & Channel reset mode */
+	rcar_canfd_configure_controller(gpriv);
+
+	/* Configure per channel attributes */
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		/* Configure Channel's Rx fifo */
+		rcar_canfd_configure_rx(gpriv, ch);
+
+		/* Configure Channel's Tx (Common) fifo */
+		rcar_canfd_configure_tx(gpriv, ch);
+
+		/* Configure receive rules */
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
+	}
+
+	/* Configure common interrupts */
+	rcar_canfd_enable_global_interrupts(gpriv);
+
+	/* Start Global operation mode */
+	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
+			      RCANFD_GCTR_GMDC_GOPM);
+
+	/* Verify mode change */
+	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
+				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
+	if (err) {
+		dev_err(dev, "global operational mode failed\n");
+		goto fail_mode;
+	}
+
+	return 0;
+
+fail_mode:
+	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
+fail_reset2:
+	reset_control_assert(gpriv->rstc2);
+fail_reset1:
+	reset_control_assert(gpriv->rstc1);
+	return err;
+}
+
+static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
+{
+	rcar_canfd_disable_global_interrupts(gpriv);
+
+	if (full) {
+		rcar_canfd_reset_controller(gpriv);
+
+		/* Enter global sleep mode */
+		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	}
+
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
+	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
+}
+
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
 	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { NULL, };
 	const struct rcar_canfd_hw_info *info;
 	struct device *dev = &pdev->dev;
 	void __iomem *addr;
-	u32 sts, ch, fcan_freq;
 	struct rcar_canfd_global *gpriv;
 	struct device_node *of_child;
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
-	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	u32 ch, fcan_freq;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2117,67 +2216,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = reset_control_reset(gpriv->rstc1);
+	err = rcar_canfd_global_init(gpriv);
 	if (err)
-		goto fail_dev;
-	err = reset_control_reset(gpriv->rstc2);
-	if (err) {
-		reset_control_assert(gpriv->rstc1);
-		goto fail_dev;
-	}
-
-	/* Enable peripheral clock for register access */
-	err = clk_prepare_enable(gpriv->clkp);
-	if (err) {
-		dev_err(dev, "failed to enable peripheral clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_reset;
-	}
-
-	/* Enable RAM clock  */
-	err = clk_prepare_enable(gpriv->clk_ram);
-	if (err) {
-		dev_err(dev, "failed to enable RAM clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_clk;
-	}
-
-	err = rcar_canfd_reset_controller(gpriv);
-	if (err) {
-		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
-	}
-
-	/* Controller in Global reset & Channel reset mode */
-	rcar_canfd_configure_controller(gpriv);
-
-	/* Configure per channel attributes */
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
-		/* Configure Channel's Rx fifo */
-		rcar_canfd_configure_rx(gpriv, ch);
-
-		/* Configure Channel's Tx (Common) fifo */
-		rcar_canfd_configure_tx(gpriv, ch);
-
-		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
-		rule_entry += RCANFD_CHANNEL_NUMRULES;
-	}
-
-	/* Configure common interrupts */
-	rcar_canfd_enable_global_interrupts(gpriv);
-
-	/* Start Global operation mode */
-	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
-			      RCANFD_GCTR_GMDC_GOPM);
-
-	/* Verify mode change */
-	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
-				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
-	if (err) {
-		dev_err(dev, "global operational mode failed\n");
 		goto fail_mode;
-	}
 
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
@@ -2196,14 +2237,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
-	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
-fail_reset:
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, false);
 fail_dev:
 	return err;
 }
@@ -2218,15 +2252,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
-	rcar_canfd_disable_global_interrupts(gpriv);
-	rcar_canfd_reset_controller(gpriv);
-
-	/* Enter global sleep mode */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, true);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


