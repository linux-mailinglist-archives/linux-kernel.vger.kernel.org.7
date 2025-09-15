Return-Path: <linux-kernel+bounces-817714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CCB58594
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C6F1B24F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91652877C8;
	Mon, 15 Sep 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YoaKsmJ8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4728727D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966036; cv=none; b=I4p0nWRUzLPaqUSdO33AVBORZqaImxV1eUMVA2rh+B1nvIsd8oFagZlJF30F9Ym0NmFpjnF6pusV/Al/p83WhktqVUouajZHm3wz4BKIMN7391K8OkWD/7ZkmHSKfyfeGoHBkeY2jPTCcGg4XNQ0uswgyBg0zj0BzDpvOYNKFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966036; c=relaxed/simple;
	bh=BRys3ZutdevswohgMnBrm5EhSN86iKLozXVmHM3NKNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESEhOyYX8OxVMEuLwz/yYaxUIAj6ga+0x8eGpIfkonXKPP6l4LaK5mDg/qo1GutE949JZH/gzvJvKWfBzFtS0R63MghYt8EZFarkuTfwVIqABLSd8WxbzLcmOWIx3QbT4Y+keJri5kss16XABfiiF64bAcu2DdTYE0VQLK40RJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=YoaKsmJ8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so8910445e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757966032; x=1758570832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=YoaKsmJ801Qs+klLh4QnG++exE4VUIj3S+Sk6onsvfM1utKE4WwncvOR8gDt8n/S21
         aNm6AFGeuVx7kFqE47gpC9VQzidV3P1+gK03/uWR1cwtRkdCJrHxhib2G+QA/tCQtwim
         8Yj16JfeMJNSbeQoO2JI6PwnBqavqFBUCxIp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966032; x=1758570832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAYdvSVQgA1h0haeD8J+mH93pNUjVxDxBFzkQXHtMmU=;
        b=OOlOj7IKp4vn6V5iELWfdCNOINd0Jc1UiuxJ3a4FG4bXPSiUaJ0LOuIuuXP+catp0t
         90qSvJ7l1Iiuvn9uNU9cWrOGoaEmx8gTUTXH8mD9atVcLXG7SBZAWiOq3qhE5YvapLbJ
         51sGnlxmLFJJniab/m9ytYuieSj9bUNDgFx7nhzGAkAq5RL6AGzyGm0R1gcoEplfnr4q
         uRLamiSsU0DjgsBRgPVliIDsuxhZzRgavTyLr5lwY3Vp2plv9A82zkTfU8mrccO6Zmz2
         QuDreCL4LCsxRdaQk7B55XCAwp+TPulvBDQODrxwYOTS16+X6sXuctjgbXp0bDEBCySf
         baVw==
X-Gm-Message-State: AOJu0YwDYVMf2B1akwnpyW0YrxuTdsKcmMNelHuRC80ZGtA0wKqZ+GXD
	jHvIpV2uqh6kDwppE5/oiKjJa9FIR0l5XB3mN+XlvEq7MsdLm3cYtzfromfS2Y7rpMn3zvtQqkX
	D5ceo
X-Gm-Gg: ASbGnctNySFVssetpv095ueaEINl6Cv9g/DoDBBPgAQrq3bIWRRMUWZdChFUnpIAGxz
	8RV01z8CZWRBwU6+MijEp3WbRe+09y7lrW1H9abO3ySDtwKTxodyvZYVKodjrkCJZrqFBYoZ9rr
	HKpZr2H8bcBq4V/CuL/6QylvQLAVx3R9Ki06GUpRWiwBrf/fVgiA60NK0G6AxtVEv5eiVnRcRsR
	k0OZE6Wjg5EPCFXENOHCnQcgX+3ON0DSEtXBNI83L+snM+zTGK25uB3c7+gvimclYPLbzPYg5gl
	3Xc/XfL3eig8oXM4WyooE/qRzdPV4V0jlEw1qk07pBy9r3rbtKRIz1jT/GJtjz0sIAqsAJPbAgz
	TLYwVJdRQZjl1k+EzyS+eBFdlgrOPbHCUxhKO2I4IZhmRZDYrkGsdpx4WxD6ahpodBEKB76uga2
	bXlcXNNk9Q
X-Google-Smtp-Source: AGHT+IHfif4UVv4IrK9t7pQTUnYShPYNK5zEJaWSq2zpbicbbJiow2T3/MUB/cRMHEEknTaIP9xExw==
X-Received: by 2002:a05:600c:6a0d:b0:45d:5c71:76a9 with SMTP id 5b1f17b1804b1-45f211f6b70mr128799385e9.24.1757966032348;
        Mon, 15 Sep 2025 12:53:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm530985e9.9.2025.09.15.12.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:53:52 -0700 (PDT)
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
Subject: [PATCH v3 1/6] Input: imx6ul_tsc - fix typo in register name
Date: Mon, 15 Sep 2025 21:53:03 +0200
Message-ID: <20250915195335.1710780-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
References: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
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


