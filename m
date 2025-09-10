Return-Path: <linux-kernel+bounces-810312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B3B518A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46420563FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6069322C9E;
	Wed, 10 Sep 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qCLJgAmD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899132255C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512768; cv=none; b=iEHh84aFvyZUlNymHbvQmM8WexKAtqxFKUm6clwmyCKE+jIjGVC7PH2ztrc2h3rkisBgqqo7SCyYAK4pj8PPZ+8frKS2dfOP59kMxDUwqr9kyNrFI4BTHBa322mvl/kGVmy89rNSmRsq/tE8Mg9ZQAXtZlKenv69yK7pvfeFjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512768; c=relaxed/simple;
	bh=mAnzVAui+Zh2pgPs+xFJHjOfsAlD+iZi1XelY8rp6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mECDo0+ZVDaQyVYi/4TgjOSWH9dfJlj5StmK15VfZ0ZtkAxR0IMKq0H2VpDDn970L8PU+KHyVa/5+8D6tfW+3WjwcxPnXFGo0qAw+h3sOOz0ufE05SPrwT5xDGLx4HNzj73/v+zJNSxPFhcLB/z8oYMzY7TQo+/N39Vark48HIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qCLJgAmD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so1013247166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757512763; x=1758117563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0R5rRW0Dwv8g9EBflVK6bi6TKX/71M89TmluJsUG60=;
        b=qCLJgAmDSQTG82uJC/Z/l9e7PThzJ+Bqz6hwkcY03BJ4/6l17K7/AJiUv2L+iRZyNM
         cTeRm+BBGjOLeizkGcmikkm0WDX4PoUmHHHFx2SR7Z7c57aweqdugaaQUVIiM/TQPl8g
         e+DvS1GszZtg5bk9WyjVzNh8Rhl/pb2FQD9+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512763; x=1758117563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0R5rRW0Dwv8g9EBflVK6bi6TKX/71M89TmluJsUG60=;
        b=OTBCh7sk8al/oGBwfv5CIBUL01bpKJYBpRaECqYpbN+bQntbEqz+do10Gx9b2h7LF2
         jzibLAkjsVp0XPXflK4GC4ny3ol7H/YBd7Gj6tA2Q30LGMcY6UaLOcqNPOtuK7d8dsso
         53BaCE6G0MpAOorYY6XOQo/Rb0sv7RLMy6sjqAiNkDI6zxpjqXC0lKv69j4mJ8GfxTRp
         2UmTnDJ9mVjmAMucFMiKAKwx8EwMVkuc78Pfa9pFS21wLs/Ey9RsvLMLL2jjx+MCxldY
         c/d6yO1d1UhFoEz+CVUdeT8zJ73+q/AQdPXr1f1ONs22sgACpbqRM10vJ+tSe0XAH8dy
         Zddw==
X-Gm-Message-State: AOJu0YyKAN474PbkgfRiFMTmhZp+GEkVJCYou1+I5KGhbQRy2krYZXLs
	MJe7TvA3PoOx/9nMjDaNkdr6Um4n6tuQQ1r70FVZ4zooBJgfnOzVyiSVk4jJuNodCZRbO4U0OBj
	0o1Rq
X-Gm-Gg: ASbGnctg+ynEqxOk98W3Qhkhw9PH3QpXsVu7U6YnufZdqie3QWIELIZBTSJRWcV3Hr6
	PlErS4D5/oC3kxLk0AiWMdZTLUk2bDtj/Hq/rkzB0HyfWjhekmf+cB1r/maRv3ZQOhqlLyDQhWg
	hDUgHR858u67+rW9XJo9imWc9pPNMVGSjtHtTgVf6fwI9io3Fyj4SnIbCMH/c8HPfH8/vGCj3Oc
	EcazQ6kl6Dgb5AgIZkwA597+EiKyNAvt4FjL11wgwE4EIxXTUx8th8mbJ0vRHgXxuZXnK8AsVVP
	wTwu8C9ZCRRP/UoX5lkL3fWRDwtY5bbWlZ2IP6Hib9AZxfmocvcnbuSmVqCgOvAYTg0GMh3KY9F
	ZI8HqlHV3mo84mRl2mbC3Ch5yv9fX0A+T0dV7hbAG3FKf97qEL4dY6hTHTyu+5pBdBhijuxH9VL
	h2k2N+Ib5/S5xnvZphDWsQm4eXTzb1QYa5WPgkr71dvWRQ3HvEAUvSYgFsfFG55Ey5
X-Google-Smtp-Source: AGHT+IHdweJVzi0li6Hab/FnHQdGRXCIG6Nx0PPgMqfpJ3S+dtaqUO7p5/p1o4bXf82vFHRmV8q+6Q==
X-Received: by 2002:a17:907:1c25:b0:b04:5c90:8013 with SMTP id a640c23a62f3a-b04b173763amr1525363866b.45.1757512762970;
        Wed, 10 Sep 2025 06:59:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833a4e37sm172523066b.76.2025.09.10.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:59:22 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [RESEND PATCH 3/4] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Wed, 10 Sep 2025 15:58:37 +0200
Message-ID: <20250910135916.3939502-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910135916.3939502-1-dario.binacchi@amarulasolutions.com>
References: <20250910135916.3939502-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the glitch threshold previously hardcoded in the driver. The change
is backward compatible.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/imx6ul_tsc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index c2c6e50efc54..a6066643bd48 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/slab.h>
@@ -74,7 +75,8 @@
 #define MEASURE_INT_EN		0x1
 #define MEASURE_SIG_EN		0x1
 #define VALID_SIG_EN		(0x1 << 8)
-#define DE_GLITCH_2		(0x2 << 29)
+#define DE_GLITCH_MASK		GENMASK(30, 29)
+#define DE_GLITCH_DEF		0x02
 #define START_SENSE		(0x1 << 12)
 #define TSC_DISABLE		(0x1 << 16)
 #define DETECT_MODE		0x2
@@ -92,6 +94,7 @@ struct imx6ul_tsc {
 	u32 pre_charge_time;
 	bool average_enable;
 	u32 average_select;
+	u32 de_glitch;
 
 	struct completion completion;
 };
@@ -188,13 +191,15 @@ static void imx6ul_tsc_channel_config(struct imx6ul_tsc *tsc)
 static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 {
 	u32 basic_setting = 0;
+	u32 debug_mode2;
 	u32 start;
 
 	basic_setting |= tsc->measure_delay_time << 8;
 	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
 	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
-	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
+	debug_mode2 = FIELD_PREP(DE_GLITCH_MASK, tsc->de_glitch);
+	writel(debug_mode2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
 	writel(tsc->pre_charge_time, tsc->tsc_regs + REG_TSC_PRE_CHARGE_TIME);
 	writel(MEASURE_INT_EN, tsc->tsc_regs + REG_TSC_INT_EN);
@@ -501,6 +506,17 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	err = of_property_read_u32(np, "fsl,glitch-threshold", &tsc->de_glitch);
+	if (err)
+		tsc->de_glitch = DE_GLITCH_DEF;
+
+	if (tsc->de_glitch > FIELD_MAX(DE_GLITCH_MASK)) {
+		dev_err(&pdev->dev,
+			"fsl,glitch-threshold (%u) must be less or equal to %lu\n",
+			tsc->de_glitch, FIELD_MAX(DE_GLITCH_MASK));
+		return -EINVAL;
+	}
+
 	err = input_register_device(tsc->input);
 	if (err) {
 		dev_err(&pdev->dev,
-- 
2.43.0


