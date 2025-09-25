Return-Path: <linux-kernel+bounces-832172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BDB9E8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442111889A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB52F2EBB93;
	Thu, 25 Sep 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pDJxieZq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553E2EB86B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794652; cv=none; b=O0IIodGF20OUQXIKvUx+P0IhegX5DQH+5RSxRmoWtbdeVjH8jV9wly4YnZQRlflvjgXpCXAhXcSsed8EDe7HPYQhQiE6CUhuqx1Kq148NX0AxakAG1nnr7gfqdKmG84kwMn+5YIV/twY7RoSa1VUvybPhSGULmu1GIwgihM8qHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794652; c=relaxed/simple;
	bh=jl+8FwOD6VtHhv5J6kpcVA9OYckbjjBovXhJMETPuE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXEfZPjYB7hA9Lyf4f2LGM6NRxhhPqaf0LkNsO2FxIaOi9C/i1XtTnpmBdpOspIQUnL46s2MJ31X4qMos4b5vrTXPQAqmClkgt5mNSPGFuzsvGLjbM65pJq3RzSk7QkeVx9unoh2sHuhOXzYlt1ranDbNGh0BbZCpVhXYUayK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pDJxieZq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso14080655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758794649; x=1759399449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tKlPEoAGYIWGPFABYx17MyiXr9Nx+u7PwyPwUhqgeo=;
        b=pDJxieZqUEXSzooBAMFfSG07wVk6AyArIu2lgzjENjFreuDjp3c3m31tHKqjRXeQCe
         nfuLQK2UTL0b5cWlze9eOPOJ5MoPQCmTAIh4MQRTVEU9GjbyQ8TQElcFkYZ23EaY3Zg4
         O6BmthSp08MC+UAmphT3OVNBTvUlE4wVrqX/N/9Hrv74Phgzqls9nx33Rl1l/do1Y/1P
         8G5h0jOeVQhlHV5qbS+O0SOcAgaoJP+olLT1EMrPHz5K2qfZdHn3xFQicQWg5FoJyR84
         +Wfss3SbWsaC2J8EwyLIbDFLqtY5fjNmYZ3FHxMIMW9TFo0mY4TEoKfAaqbCdlQUBYl6
         dPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794649; x=1759399449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tKlPEoAGYIWGPFABYx17MyiXr9Nx+u7PwyPwUhqgeo=;
        b=UXKrCpFBukr+Q2rRmQtjor5PBAU1m0etw9DLAFazUlCVfeQqgEVH8TV/+h81e3dQBT
         Nut4SgW1+ObqdqxDcssDn5+lcdcASx9++Cir8fNtK2ek2noPOd5dFCi3mvKEvMwy8Jjy
         dycyBMdxMlGlf1y4dhI5Eey1AmEnpXtzDebB/9ejZ56QQkEPSjxziZqRcEGnzPEZKScN
         1RgMJJ9mMo4kPEMEzTkRkDPwTn/6dOBquP8Mbjdc/NaP80ICdQk0WCJyvSvILGbE6e/e
         KPk7/BXMx0zyzcueblz/3bOqHHbLbPUYAQeNF/fNuNT0IAU0vCe5OAaeLMc+py0r/ylc
         ul5A==
X-Forwarded-Encrypted: i=1; AJvYcCUMDfQFSHuFekQtyrJlthKc0SwE9g/bofAf26ItwKgJHGDEkUIIDC/uwlQFFcoK5mN9Vw5NRH9MGtibhp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD06d4ounSj+HpIlM+hNt4dPkSWf3jEz5MKkRjthtiSw4pBa1
	+wMIygrdngrBjJGYTd9vnt24H6eHerwAI8U1NkrNG9zJN7zDQiG4cR/uz5YjzoCUo/w=
X-Gm-Gg: ASbGncs9EZphpJpExKRLZbzKb+E1hPQKgofuSI2tVXK1pY4kdO+6bqRKYvIMz6my9p8
	CyyP6p4jkzfWCwKm4L4GPNDfKQMaPStf3wPmkSn1hnQaQrtesejAnvTjDVliWOcmFtWaNLP2YA4
	gaSFpWE96IbEkFp0rSH0iL1nK4ltdndt906VXrKQhlaTifBIeYDzw02H9t8ENHl3DCuZrnsZadO
	yq2XogCgIHEm0M98umabLB19CDf9gF+II0f2ZZqPLOOc1vwwGWd1QzBJ3ijt1Oi2Bz6/jCxT03+
	8BJ3NBZCHN+pdM0YNu29rMKQGWsc5oeXJfWzVAwXRMwndCQkZTJI1ekunBsnD9pz45+YVdyhTBD
	brroZy/C/jJUQXYVf1NjPlZuRmNU13QG0VihuMUEQMm96fezVH/uN
X-Google-Smtp-Source: AGHT+IEAFncSrCN/DyxZQdkXk07wqustp+8ZzXW52nZf4Olgw0IFwcTFDA4LiIPHm2KGkdMJd1zQqA==
X-Received: by 2002:a05:6000:610:b0:3ec:42f9:953e with SMTP id ffacd0b85a97d-40f5fdb1108mr1870089f8f.7.1758794647472;
        Thu, 25 Sep 2025 03:04:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm2501122f8f.2.2025.09.25.03.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:04:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v7 5/7] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Thu, 25 Sep 2025 13:03:00 +0300
Message-ID: <20250925100302.3508038-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
signal from the system controller. Add support for the Renesas RZ/G3S SoC.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none; this patch is new


 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index be315199e2b0..b623a511e505 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -108,6 +108,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
 	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
+	{
+		.compatible = "renesas,r9a08g045-usbphy-ctrl",
+		.data = (void *)RZG2L_USBPHY_CTRL_PWRRDY
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
-- 
2.43.0


