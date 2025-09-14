Return-Path: <linux-kernel+bounces-815752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BDB56AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF433B9C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599052DE6F7;
	Sun, 14 Sep 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Nw5Jg+jb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046502749DA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870180; cv=none; b=Fr6dH0+cIfcP8EQ/8bZYxJ/HTzgmcI+WBBso0YIMpWGPnRj+Z1YhfEptkW8Trvrzmf68avPPm4fuU+QMMRm71nNiPeRVwXRI6wKvjYvGAKBUzzHPHUQbmXXDs64eHNGuCHpcQNEeI3GI4yN75SxEGc4uXqCJ12wBLX9jHxw96mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870180; c=relaxed/simple;
	bh=ipys+sa9gnvK/DvJjMtWh3ebWZIbOPBtZHEYTv7XZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV0CVa8/Go12eyTsqVMS0cm79hXUi/OdYFuqUd2bCn9v3n5gr8sozo5+LE03D4/ZgMlYHNElU7EsbWGvYmycARsRqSwS6gjAl35z2Mdh0D4eUZqiz1eCjxkHozEEdat6yQuYtUh2MhIGDYcZg5hfCvL/maYmadhdfZzYMHN/2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Nw5Jg+jb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f4273a404so127755a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870177; x=1758474977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0a/vjTQEtX+/yGwy3GQfrzKjZgyz27Pw8rW7Pi3j2A=;
        b=Nw5Jg+jbOFbWUksSwkY0mb6B6Q038Q5TZhYDW3v5l2psvaMLMN6unRyWC2LJNrxogc
         nznuaSqQAPkjfdGprabEvMHN0w1nXzuDdPgfqw0Cd9Uc5VPM7SdvaPVhXXJ2XNgt19co
         iq0FuX8HesrhSjhTP0GYm+ar7ToHiEALl5/zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870177; x=1758474977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0a/vjTQEtX+/yGwy3GQfrzKjZgyz27Pw8rW7Pi3j2A=;
        b=VB9+2dWUfjIYK7RyQmkUjmbI0iGD3n7q/g9AAKzAlr+TxyvHCNom38oSPYlHqMrpHL
         IfaKwzMkw7K1U3X83fgSH2egCsz+7RXgRjww+vCgd6XltqVgwFrQePx1eVJCfkV5hPyX
         rVv2EL6Nxd2SykOWt/X8Zhf6ZjoCEwQllnNy3mtDxjQBmSV2EnRpbShPq37ecjr0DUzV
         KmMiIu/DCT5Opz1TZqkXoSxHMYxrIfD6uZQ50m9W3esgjn2RHILWav0TwOfjeD/wi3S0
         LAsWmLFeV9TcE+dZgKuT752BJ7v74+d0j3Q0LGHJ0eo+hFK2f3rWCKv8shFu8bEfBORZ
         kT9g==
X-Gm-Message-State: AOJu0Yzf2/BlEhhMlyDdbHF5ZZsULaHzy0USivm8K4mleTtjAPLa83yh
	9YUh7UazdEBhgEOqm0wL1h9okc80wfQDDZY7QyZgprQJM3CpSzhd4iD/2V3IaOvJXs77bNlAJtH
	YMnJe
X-Gm-Gg: ASbGncvZ7a0nTgw7xg7bp/KECzQuj60hSg8jiGH5B36bEQquu6SCdtrO1VPtYagmlxO
	vzKC3WkrWERyednlaJhfSPtq+LIRDYVSGBWr3sl5gqpYt8U1n+el90Bi3l3egIoPBzOMkbHgEJy
	onAazUG3dHpYxccOd0U7YIQUDnIGyT6WKXEvyU2J7+f4mdHZY+7TefV1vIJ91cYdpKoHqfAchKs
	1pQ6z7o+XO7EW1TajP0LVHPP5rhUMk4Dad65D/m8ZWbw50/nSlmHww+Kk+ngMcjEwQ091R4ybb6
	jtunNxjWXlRYxNkAegbPvxeK8ad/cX8SqCIRRG7/oUTGvm1YGnVXOLdhZ2Q/ghle8wjegNhcL74
	fdZQazB+6bN65vMB2ZEKD0QBj86eNY3tv6X9SETXzJROnU2Ib6NCQN+9Fefmvy2zY9hfK5H7Yea
	SONEUzyGbypFJ8+eNlp3Ba9K/Zk60b92iA2TLNJp522L/jpepZVFUx8iLe+KVmrirj
X-Google-Smtp-Source: AGHT+IEvX+quO6ICKhJRdf8NKT/j6OYJ6Pe+ZtB6ww1NFEvD0skqRYkw1DUilScz0LuELvehDfDMmw==
X-Received: by 2002:a17:907:971d:b0:b0c:7269:8459 with SMTP id a640c23a62f3a-b0c726986afmr363002766b.7.1757870177023;
        Sun, 14 Sep 2025 10:16:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:16 -0700 (PDT)
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
Subject: [PATCH v2 1/6] Input: imx6ul_tsc - fix typo in register name
Date: Sun, 14 Sep 2025 19:15:58 +0200
Message-ID: <20250914171608.1050401-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
References: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
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


