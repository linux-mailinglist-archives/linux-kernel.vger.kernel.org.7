Return-Path: <linux-kernel+bounces-823221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB5B85D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4938916C324
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED6314D3F;
	Thu, 18 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iqN/mNId"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9E30FC0F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210768; cv=none; b=R2RHNLJYe+U4j/UcRZfN37wMCz+NECVrs2aJHLZZbZFbzNZ+xG6T9Z6Vc761H3RcL/1s41DD0CSKmigEMm611tta8VlG0m3MugTZiHtlG4Be/FW4k9Ln92IRUnUKmUMKt+B0cmSPUX2hLp7vLLC8nqzgB0t+qPaW8V83knz9sQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210768; c=relaxed/simple;
	bh=BRys3ZutdevswohgMnBrm5EhSN86iKLozXVmHM3NKNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+7rk/WnOhfkhd8BZd6rTLjWiJtrjNngi4oQeJHSSrVsnzX+LHlcV5Qstdhijw+IOJQpp5rplPHMZzzCU4jtOeYMp+N0H/fxCLQQ+LlbbMYlftboAPfz/YEV4o7+0MQoOGvsiLlrSBNYWLXQFb580lfzzzgcVCFV6vFqZLYt0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=iqN/mNId; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b00a9989633so234433266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210765; x=1758815565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=iqN/mNIdBHsoxt7W9k3jvewSWUqoFL0ktOmTmaOOjQusami66i3lq1kwP603ckpzpu
         7RX+/P2tb7QRWQZ134CL4nBFE6JEmPWgYlETKE2HETZk88iRUdmZDxBNbLLnXIit7fVZ
         q92S62sEIrpWtKoW7ADIDKpDaDWfsNIYA+THc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210765; x=1758815565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=xKE2nDGrm3ToCZQFG6aL3qH+khw7U/Q4vTZgE1KbnabglDWFyh4wBpGc8j8Je0wazj
         dUG1DbJjSlyWdxPP//fkPZrCZSoHF60A9aTcJ/thz2HPYGX/vHDoykE2LUoBTwn7BHZE
         9T3+H7ATzs47veuEOQ21joaafDszVednd5w0jPkWAXLP08EUWqDP9L3Ih2XfcAEoAR/W
         ngIJt2TxlTE+1jKmQrTv/upifmNIk889iCPSKjRb2syK1qbqlM3/Aab3niyymQR8IztM
         OdFO7QJ1P6b5ud3TXFYBmnvUfCLqF5LSY2icDkamEbSwdYvpLya0wNWeMdmYkOQIIvTT
         07mQ==
X-Gm-Message-State: AOJu0YzmXYVzCobOU00IuB2ziou2EwRsiF76yO69a6hPXbCfOSriQQh5
	HvsoFmLbGbWeOim6xnMVCdE+3Y+2GkhkA/aTGetwr7/xYPD0d1YySP4CmN23vF33DAxHa00mDVK
	aBA+o
X-Gm-Gg: ASbGncvFyzw+VvEiq/EEWmlQDNEFWk3SDghyJVf0CF6NS+mw82cPkPd13orj4KDA3wk
	pFKSrMgkTjUQqiEYIPutQwUIdMZBRHUUJL78Shdfs9RXC23Mb8+8cNxOCgEGKoI5n2rren8Xumv
	E6l9FiQJteRNiSCfyDv323BJXnFxXTIlTuctu+78pxG+sbyCkvwT87GmN7qE8c7U6PueV6/4M8X
	ndCE2Kqxf5Q2lukT8eV0gSOfCPmK7KDJOmpJd61HkBEiKWurOpsLZcmghXlTPoRnHs+TwhgUZDM
	OnRPuFxNHHnLBnqx8TjNENDfUfxTFE7dg+0OclGc5UoWY1nJK5xMJbhiLN3H8KaQ5vQBF7iRYEO
	mX/LA3hr4fFTzfWpB9GYkHhz+KVTwLqFpZEbGLuiq9OfqNlamH4RS1Z95PpnXbx5Sv6eD1GAiXG
	p0XYLa7/Zl3Hlz+U1u50BkhQX3acMY9r2A61xJMWJGU20nX6P8L446n88SZ1AqKtvHTaO1EClDR
	xgWAYQSQZc=
X-Google-Smtp-Source: AGHT+IG+gvq9vJTCt+5pyWxiCzEcIfQz6BO4MhPzenmoiqj/1PmPt6GDmC6QwRXxUKbRTif4JvBq0A==
X-Received: by 2002:a17:907:d7cb:b0:b04:1d85:7106 with SMTP id a640c23a62f3a-b1fab24299cmr333418466b.21.1758210764801;
        Thu, 18 Sep 2025 08:52:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
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
Subject: [PATCH v5 1/6] Input: imx6ul_tsc - fix typo in register name
Date: Thu, 18 Sep 2025 17:52:29 +0200
Message-ID: <20250918155240.2536852-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag of Frank Li.

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


