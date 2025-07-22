Return-Path: <linux-kernel+bounces-740666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E7B0D775
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A213E561655
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935372E3B1C;
	Tue, 22 Jul 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R8lacz1W"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038462E06DC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180641; cv=none; b=Ss46/eqy45cWWY57nlRgdoPfTH7cIiee6SG9iu3KlD6WJRpCxH3cX3vD26Xlz2J1ExgXhYD2YUhaASx7QEvZrT9t89CyKro9i3Yy3pHH5yxoV/xLa1lAuViPt8erK2XluL0eiYJZcCx9vOYMXCQ53KMVrU+DTgWkA4dtSbUKK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180641; c=relaxed/simple;
	bh=mAnzVAui+Zh2pgPs+xFJHjOfsAlD+iZi1XelY8rp6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmvOgXtIGhOvMIsT7Kr6xl0SzUYxFKI3oz5fy6UkomGyEyOpgkJd/EYG5s9yo98H3nczu5uSAozmdhLllXZA/2ABm07dXXM55QUnx/Jnu2hTdFql9uDuGqhdyg56JnYlOPM2FQXVudqgdr1AsekewyrkhM75lHUOV3y0ALlhaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=R8lacz1W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so7600582a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1753180638; x=1753785438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0R5rRW0Dwv8g9EBflVK6bi6TKX/71M89TmluJsUG60=;
        b=R8lacz1WPk5aCKoaeN2EZyoqiHYTl8ljgWG15zNWMdAcJCvLgttVFZsYmFka4qMfuK
         KSQGTEk6zhP1N7FWJLrevRncDHyAzt2wVWPhWRW2V023P2yv2PlAjUQbN/1UKKj9wHSS
         zzT1kBByHRGfK6U6w6ZXTcN71i81WN1otjqUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180638; x=1753785438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0R5rRW0Dwv8g9EBflVK6bi6TKX/71M89TmluJsUG60=;
        b=DoQ5PbA4SEkqzs5YeJfZzJf83wPC4aBtsdSDveZfhKkSxyHD9Nk7mkXv0yeh5rc74s
         +5kS65bmQlm4ZmGZy1sY9KrniKsazAHbu4WD10BEEgD7+LO690YmuQMRtWxQL7J4mh7e
         AwlcjQukpQo+/9fErCGS7E0pUN1+W0Ej0RlAgytNN1PG1Acg2NyUt/uLU14oGqacJGkn
         8bn55HATubqElik2s/cTt7tWwJyGMYtSwAo8BwjYF3gU7boMQR0qA6nK1mITE5oZa0sv
         +SyHQiKbjmWR+tG7uOiJ3SfzsIQa/bY5hpO+QX2XcmjuvSjv6Ug9by37nWIC7DkOzqBR
         pOoQ==
X-Gm-Message-State: AOJu0YzYkB6JYfXzHiQAs0g2rBmcATFzXApE7QcuEvzTP5vxtjD5Yr5J
	Ga07tqG1l8pIhyEWNFLBTNkZqE6z8wmnYDYwgXh9L7J6T1Nv6Nhzv8BOG00x2uiOcQrmqd12KPy
	E7duZ
X-Gm-Gg: ASbGncv398irgjh5dM6Ifi1y9ILsgkE5XJ/uUW3fHcKL5tzZvq3vAWDoHVWYHbXx3dL
	CypZLjgjQbUjgq1nX/zROzkxUxwWRZKpmXCUrxi1aFM42g7AdvE6UQ9VKbyo3fZvJAKlWl2eFli
	BdQ8g25rkibuyG/a/OvUfHE61DaBQQ41rSjHBp8wrFYQoOIC4SymBV54uFm3uGfJh6qGGg2zRp9
	eWFLnXdgoNxguA9eHb2XNVHIgd63q7dwqfn36jBrLZoksQn9kmOSPK0x3JNaFYBXhbUU4AJFxGH
	Erxk//xAAt1a5bQojD0ft/foTPDiSZRonjUxepHWqCafs8XGntKggsn2t7EfRIct9pJ9ERddpQx
	ymO2ulzoW+E3WK91jx2NaoVU6PuS3S/Go9ujrpj0kYA0gEpILU8Igcw1sbqk=
X-Google-Smtp-Source: AGHT+IF5XH+ULXAJm2Yd7fdwy7Og8oahMPwKCKBYQfiU9IiXyUwIgGfm5dtLgUZCNSYYUrIZy4YonA==
X-Received: by 2002:a17:907:cb81:b0:ae9:c494:1ade with SMTP id a640c23a62f3a-ae9ce199db0mr2520430366b.53.1753180638060;
        Tue, 22 Jul 2025 03:37:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:2bba:d7b0:8e79:c982])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310e2sm844568766b.79.2025.07.22.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:37:17 -0700 (PDT)
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
Subject: [PATCH 3/4] Input: imx6ul_tsc - set glitch threshold by DTS property
Date: Tue, 22 Jul 2025 12:36:17 +0200
Message-ID: <20250722103706.3440777-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
References: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
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


