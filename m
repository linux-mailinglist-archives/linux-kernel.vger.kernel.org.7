Return-Path: <linux-kernel+bounces-810310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A0B5189C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF10C563EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D50322743;
	Wed, 10 Sep 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ow30V3hw"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682093218D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512764; cv=none; b=eq5ugGg163+inwugyUgHrE+dORzzbH8OuAZdnFG7luacrt+3CeEYn6D+HkblIlAYuBDOVB1eaaZr2RBMtyX+QX75wD2sWbLU7TIoLqF1aFEyhy3vEmfSW2Xc+eBQ55mW/X2tiD0ZrX3pJn5etyHb3shx8eVZ48zoMhqD3vF2+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512764; c=relaxed/simple;
	bh=Uu0KyPQm4WIIkWykK1EPIZXCY66nvgOqnqJpxxXLb8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJR9YlVsnY2pm7GSCaL0gflmdYdTCosMGf/Coq+/1TWXvG0Bv+yqifMl+D/4P6masHPwYRtzNcAjmzHDmY1cbtXSm3KBUJKmmoh2klTbpCTny6+kdQadosF7snzldX9SDKTFdo//wk2ch4uowzOk1RxGEKklK6wcrgQYB20SgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ow30V3hw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc3954fso1137845766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757512760; x=1758117560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOaQOy4NwCzyitlYEvpuiMsUEgnozIVGmGmKLfL9eXI=;
        b=ow30V3hwhE8MsjSrY/6Bp4IHSaC7rKH+Ns67xvrmhuAODELBpx2hz7Gm4Lq52c068I
         sgDgyVTTK5PdPSnK1wg8fr/wyVIzsYPj9mjgWk0x4y8o/sCZkayzpy6ts6QnTSR6UXwY
         5OTu0TOVqok6ZgI2dPM0eUdpEKn7aF55h95Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512760; x=1758117560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOaQOy4NwCzyitlYEvpuiMsUEgnozIVGmGmKLfL9eXI=;
        b=SU9DmcEODMBWqN3BSfAanOpoiCCOhQMlO1mUE42fxMeDsvXnszjnm+8XvO8iwkTXVD
         DgRQwD5gtTo6ZtcpR04DXDaOyE8aQmIFnX3h13F4yTl7Ds56fmW3DQZjoArBceR+OiOe
         T9hUU54Ho+97wCE0inF8NWQjBfByHls2vqgxXrSBeg1pc9LV2UQ1zcANbsqHRYCW/Dcf
         Q5oRsj93lJ1IkdwOGCL1sKbxfbpcUhTCvFYGH/Qa42Y2VHKfbbFkeePn6Es88X1UMwNM
         pRcQkIuV9MHfkQmmcfuN1GvKgMvE+pr7EInFJNhrT181BbBXXgO3QHDPJFrxbQmCd67K
         gScQ==
X-Gm-Message-State: AOJu0YxvvWssvnlmzfl7BvNq0NjiNMOsutXuYfCuerH54XF/0CZXqMf4
	0i9dG9jJq3SMiaT6JaByXs2pSYpq82Ewea+Xp3OaAxk1ndbuTCaJZFtNd28pYAqCr/l5eqHX3x0
	LUQ9D
X-Gm-Gg: ASbGncuCQP32IbK6JqU2CRkoY4Da+li8BSnZ5LVjNmyG1I37Vl1N6oTlQjzhfAdLLGI
	NOolRHzVGHyjIfCAtx6kiduuxXmsewBc7iIOeNBmi7Wf0xQHK44ZkYlDMJcDGvDDJ38P9mjuSER
	1E88RbLumDd0DH+ZesekccJIjCYBfgx6ucCfHWMwwIEZEar+mRgtioq/XIXUnozzQCAL0YfpKvg
	+3XpKDwhn3GSG85W8vrI2nHAaWbCEJ/bxwZuF/M3wb8DFvI7zwBwP6wy3WRS+rBCCwIVE6MwGW0
	X8QNlYlrOHUIJbDTxNBNGPlWN06+qaEj2Wro33GR1gWVcFAAThSqneCvjmpZk8xl0NXPskPivod
	R3reml4JWuduGYMMuliygH9ADpu3HzBqnzXg2GDnkaxrgSxsZHjeAXr6w/kCAQGEMZQaRYFzK7A
	YRe+ZYxEFqi2neLCqgIA0QDill7UWErCxUxbugj7OFtnKZaNY29kiMYiRCGofG5O6q42Qju547I
	xo=
X-Google-Smtp-Source: AGHT+IFx4sggugwyl7NvTvxiC9DVo19Rr8B3xJJ7gt1HragPcAUN78syGn8W6pBdTcWy3/sRmc9Emw==
X-Received: by 2002:a17:907:25c4:b0:b03:fa9e:4b68 with SMTP id a640c23a62f3a-b04b1696b7cmr1544984566b.32.1757512760390;
        Wed, 10 Sep 2025 06:59:20 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833a4e37sm172523066b.76.2025.09.10.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:59:20 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [RESEND PATCH 1/4] Input: imx6ul_tsc - fix typo in register name
Date: Wed, 10 Sep 2025 15:58:35 +0200
Message-ID: <20250910135916.3939502-2-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Replace 'SETING' with 'SETTING'.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/imx6ul_tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 6ac8fa84ed9f..c2c6e50efc54 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -55,7 +55,7 @@
 #define ADC_TIMEOUT		msecs_to_jiffies(100)
 
 /* TSC registers */
-#define REG_TSC_BASIC_SETING	0x00
+#define REG_TSC_BASIC_SETTING	0x00
 #define REG_TSC_PRE_CHARGE_TIME	0x10
 #define REG_TSC_FLOW_CONTROL	0x20
 #define REG_TSC_MEASURE_VALUE	0x30
@@ -192,7 +192,7 @@ static void imx6ul_tsc_set(struct imx6ul_tsc *tsc)
 
 	basic_setting |= tsc->measure_delay_time << 8;
 	basic_setting |= DETECT_4_WIRE_MODE | AUTO_MEASURE;
-	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETING);
+	writel(basic_setting, tsc->tsc_regs + REG_TSC_BASIC_SETTING);
 
 	writel(DE_GLITCH_2, tsc->tsc_regs + REG_TSC_DEBUG_MODE2);
 
-- 
2.43.0


