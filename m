Return-Path: <linux-kernel+bounces-799429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667DB42B84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166D51BC5B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222062EAB7F;
	Wed,  3 Sep 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Ku5Vh3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E72EA743
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933754; cv=none; b=fMV9PmDyfskYe0+WZXsGw1WSenuiyjdRgCxsN0CxE0312Noi4b43o5apes4xQblk6sCnozu/iyTSHhLDwZHWXY1LxAdqa6GKjqm8HOpF2yIYBSgKyvo048FxUC4P+kidRiD/DbAJCXiNAMMNvHTmAwvblGjhAnGbu5c914H0Uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933754; c=relaxed/simple;
	bh=jBQ0GLzIgJtUzHPSuTv9C67rywO4iISt46JXGJOSByg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpJg7UqrHD/JpGfbt+Ab7ZH7nDqkKln25wSes1BPFrKpuo615Iloa+3DJB1JGp6lt+t4E3e83FQz+eh2k05atSPnksbdIzO6YTG4iSEhnbSC2gFN/sTTIa9z0CBBJeYDFfbx4K7YGPOaCBXeMOqwNSVAuyvkb+EuHKjLyJk7MNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Ku5Vh3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f720ffe34so360219e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756933751; x=1757538551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dS6BCSDc4Ij3ElxhugOJZt1FZy+9YqKMXdSfgf8lCI=;
        b=P+Ku5Vh3r7eO8+Pr44wpE/Ahk1XNhN6EkwLmNqeHtVwXcpd/ma5PYtYzZ0FQifMNWR
         Uu6fvc9Dw/aGIW7EK+iSHOVpcgm3KGNaNf+qU7kdRdcPUR/oQmvr6VtiXNu4KzA5N+49
         bOZOhjd6Gj3tgmeRmZl89uCIfBrRFDStWasHF/RsYcRlfxVeWdoCEod5apg3VthHDfZp
         qgvH3NNr022+wweRCsP90pu/8Zq2NngWuggxncox+K0+WaYwnk9AddIEf8SyQ+Lklind
         NGQggybLFI5rGUO28ToJm+Fl/jQty8PLAmNEjJmvMrJH4SYaKHfiR6TbQH9wDZQeW60v
         ztEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756933751; x=1757538551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dS6BCSDc4Ij3ElxhugOJZt1FZy+9YqKMXdSfgf8lCI=;
        b=O8Goq6iIPkm9763FuNZslwNC1gYQkfX5oeO/KwrsXYmyC1o8kJix/gcc18hWixLju0
         7409e0aUAYZwUNb+tW7+vA3PLH19aHBzQX0/p1fdcV6w6SW/6y1DrbzCzbiucWIWdzub
         Qh0doDiw1UKgXBdxvUE5Q6IAB9/z+OFVId9rDTfmFwuWds5NikOkt4Puo9GOKFab46sV
         0rlH8MFAskAxmKhX1cmPT3Jz8R9onT/Co2CvQ1W31iIvzOQnsgP1H5dcUJDcjav1a8VW
         E81MTC0TeLduxkeGoWl4e01UGvhd0Alld0/luwLedref4LugDkgTWrpeYWh2dtt20TRo
         bGDA==
X-Forwarded-Encrypted: i=1; AJvYcCWvW6+esLslwad4nSex8V9fGERmwOYUQ5neY+Plqfn/JW5vjkUI/e6QsqYcXwCa9EnuDyxFzlLfnPjd5VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Tvj5vFvIW2eYWYNaiTEC/ynpHvqXxnj9J7SiwhgAMxklaTdj
	n1QpeP5WeOo9sfqz8ldoJ2AfoGX5ikAvAm28M174/TKCZgC1PuXB4V+K
X-Gm-Gg: ASbGncuWDg2FtwnQmA/X6hurzOtuH2YdNpBwxcy2C0yP0oyQPC4N3GRNq0WXlRJimyh
	OICWmZ30nTg51TUyXcsBXUjo37BQCMBDZVk+GUmEFNATadkntCwGjtJjZhv57HOgJZqK8CB/b8+
	K33qOgLDm8zkh3ACEcZJVQiQyFJfOzVzWoE/VNZvsfeNnUqFWlvreleA6eJBSEaXyAcSuFQn8QU
	O/w1UMtuv7XfimXdmcm7MCSUFeq30Dpy/XcmDDaEpXDAwNTUWnQsIUkSC6GI4tTdM87nTNpqTLR
	yRo/x4d2UpvbRzXtLzJgvcyK6XWD15GQoGRML8Sny8wDufGRkCip0sYBjZMuhEzf/l6sgITp9QM
	hrfm8xpGpMQuram6GCkhZ10EoRyMszDvZ
X-Google-Smtp-Source: AGHT+IEaWkvpbsHceTX1bATJyN4ozxPpzobv06l7Bv+6L6XYgG3xH3vM4xM3c+56Qk8vMFcG1sSl8Q==
X-Received: by 2002:a05:6512:3b9c:b0:55f:6cc3:45a6 with SMTP id 2adb3069b0e04-55f6f72864amr4878076e87.13.1756933750589;
        Wed, 03 Sep 2025 14:09:10 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608acfc242sm742652e87.97.2025.09.03.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:09:10 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: himax-hx83102: changing gpio state with gpiod_set_value_cansleep
Date: Thu,  4 Sep 2025 00:09:06 +0300
Message-Id: <20250903210906.238655-1-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is better to use gpiod_set_value_cansleep, because the panel
can be connected via i2c/spi expander or similar external devices,
and their callbacks can go to sleep.

for reference see Documentation/driver-api/gpio/consumer.rst

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 66abfc44e424..2aad315aec5a 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -859,7 +859,7 @@ static int hx83102_unprepare(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
 
-	gpiod_set_value(ctx->enable_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 	usleep_range(1000, 2000);
 	regulator_disable(ctx->avee);
 	regulator_disable(ctx->avdd);
@@ -875,7 +875,7 @@ static int hx83102_prepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	gpiod_set_value(ctx->enable_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
 	dsi_ctx.accum_err = regulator_enable(ctx->pp1800);
@@ -899,11 +899,11 @@ static int hx83102_prepare(struct drm_panel *panel)
 
 	usleep_range(1000, 2000);
 
-	gpiod_set_value(ctx->enable_gpio, 1);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
 	usleep_range(1000, 2000);
-	gpiod_set_value(ctx->enable_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 	usleep_range(1000, 2000);
-	gpiod_set_value(ctx->enable_gpio, 1);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
 	usleep_range(6000, 10000);
 
 	dsi_ctx.accum_err = ctx->desc->init(ctx);
@@ -917,7 +917,7 @@ static int hx83102_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
-	gpiod_set_value(ctx->enable_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 	regulator_disable(ctx->avee);
 poweroffavdd:
 	regulator_disable(ctx->avdd);
-- 
2.34.1


