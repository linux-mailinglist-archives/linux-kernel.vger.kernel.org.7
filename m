Return-Path: <linux-kernel+bounces-579944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB8A74B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BBC1B632EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9823BF9C;
	Fri, 28 Mar 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+noLTjD"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330821CC52
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168676; cv=none; b=F5pDOPHYKvCBQKmqJlEfDhRTj43rGe9PHBHUxfBpKZd43EhxUr1cyFe/Nucg65OJx27qVo61qw79k1i/GAS7SqYGetnanNFLvLrB++uZyibzYLIKdhvdgwJ89N5tVZw9U51ez3Nuac0glB6RsTXtIn/T3sKVj9fJM6jN6OBmvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168676; c=relaxed/simple;
	bh=MZ30T8KMJXBJoDDM3cr1kCmHXcpVB3LCx1uy4q775s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/O7Y+HuBfX+gsKZ5DWh8vt0SvuXJHs+tNJJtVqziUTSFhTFMTWMvwMcHz5DJ3VUwFfekkE7tPeaktWMZwV5w1tTvwLnQxFeCgZvrWEP27dnFh5DMAa5tUQtxR/18GiioYxYWleV7Ycjv3qg4pDRg2+YSXeerTW7LwNUb9eQE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+noLTjD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so3160365a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743168665; x=1743773465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op+5mEOgNYYFAMowJxBfybjaNESu4Eako9395vK9N0c=;
        b=s+noLTjDxDYQ59pHADLzOeCCWKhXG/A7sKPNkyr5ZScb0I9EEzqxJzeaSWsHkI6SdG
         G82/uB8l3Ge0zyE68HY5KJx4XfE8l4Nmwp6xHfR3l2cpBJNLqWiv5Wy6/78w3M2k66xI
         /XmlA2Awr03KUJvHFvaMfVTdwg4IDxnBBS6U93ylY4noZt2yAIN8ypbkKO6LUs61WRAM
         CtHCBPuitsG2+bhDFf7ZQDh2j00tC4wRb5AW003u1oGpa9D7Jt9lY+ToAOEaKzDZ+UvQ
         Yh/AJ7E6FP/m7V6qm7BAstyzSvNdhpGeZIuwy2JCUGw2g3RnlbOr59z/sEOB8lDvBmXe
         ZdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743168665; x=1743773465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op+5mEOgNYYFAMowJxBfybjaNESu4Eako9395vK9N0c=;
        b=mZq3v1VrLr29RHIJkINbm41bILfHP6e0HV30RWsn7JNxinDqQUDllrFVw74299xlVH
         7MGhn0yLcffVkIKGvz2V9ItdFyw2VhA+haCDbCHTfAyMl6b6jo4NuPNxgZwH67gcZSZx
         /qIeVS3BUzNaOscxMzYctx3Ge7DgjLGLL+3wqyJma5B6GstNQjDaeMEB5W6qPxOM4Jb7
         BaieEjAEAoFHzMW+Tx9RwHgWGJgSJvMOFwTfaNfkewUgXQWPrEAkzVLTi7C4f2xPINVk
         6JHxSY6swZS83JvXDpBOBaOFoPEiLuVQqZc9o/n4Bmt9q2xqACeCi+LHGHhHDVOrvYEm
         rDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdBFVvAGMv+JKy3k5IP/8zlpzzadhIRLJ/ZV6f5yZNYWtBoR0VF8oe1hFvsb6vf4xPcK/jOJ6ZY/wXajg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fwiaIKdTwo9EsFDFmp7DWEnlHpMkSZNzx9/cNohts0t1hTPJ
	6Slf1pnzPMdbfA25WCq/fbqcf0jq3N8oU75bSRS8Cs/5C3NqXV1qDY8eT6v/U+8=
X-Gm-Gg: ASbGncvAP6+yK75snJCf7dOSWDdhOQZtjNqMF4ttZY/iNUKs/XfeonIleaizlg8TGsW
	SfmDpWE+adLzZ+Rg/XUrO3JP9DopsN7LSHtr1retoc1GikKuFRYsCi3brG+2MQurLoAI4MP62fW
	3/LLf6gA2DxwjbjyuoHLNyCuaDfJT7yU4yu2qgM8uJgbF55m4KjwPTWacvd6dlHAvgwk5pI6blM
	P+qSiPtfqYBPo9UYV2rAGlsruvD/oQ47Xi2lo26pGzMfHkipdeRSc35H2clzfxfJwjBp23IQ3JG
	JJRXrqqJ0tLOzra/N+V9ngtJ4gurk9Bwh/E5jbqFyg7MDiS52T1EKptf1tUE/T6TlEsKSt9WDOz
	38nwX6hzZYlxmkAoM9ujMfQlmPFe4
X-Google-Smtp-Source: AGHT+IEDYL3eHUsT5flu6o11GExiJbQgaRJn0w6hcUwsv1LO9+z3oQ7AfyRxuBAye055avOV0tJXIA==
X-Received: by 2002:a05:6402:278a:b0:5e7:f707:d7c4 with SMTP id 4fb4d7f45d1cf-5ed8f902a81mr6436324a12.31.1743168665253;
        Fri, 28 Mar 2025 06:31:05 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17e01f7sm1355284a12.79.2025.03.28.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:31:04 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Mar 2025 13:29:08 +0000
Subject: [PATCH v2 22/32] mfd: sec: convert to using REGMAP_IRQ_REG()
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250328-s2mpg10-v2-22-b54dee33fb6b@linaro.org>
References: <20250328-s2mpg10-v2-0-b54dee33fb6b@linaro.org>
In-Reply-To: <20250328-s2mpg10-v2-0-b54dee33fb6b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Use REGMAP_IRQ_REG macro helpers instead of open coding. This makes the
code a bit shorter and more obvious.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-irq.c | 343 +++++++++++---------------------------------------
 1 file changed, 75 insertions(+), 268 deletions(-)

diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index 5cd9667a21e9e8b052b2ef0b5d2991369bffe8bb..a2c821704b771a9f8a10c7efc900812684771862 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -74,212 +74,68 @@ static const struct regmap_irq s2mpg10_irqs[] = {
 };
 
 static const struct regmap_irq s2mps11_irqs[] = {
-	[S2MPS11_IRQ_PWRONF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONF_MASK,
-	},
-	[S2MPS11_IRQ_PWRONR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONR_MASK,
-	},
-	[S2MPS11_IRQ_JIGONBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBF_MASK,
-	},
-	[S2MPS11_IRQ_JIGONBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBR_MASK,
-	},
-	[S2MPS11_IRQ_ACOKBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBF_MASK,
-	},
-	[S2MPS11_IRQ_ACOKBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBR_MASK,
-	},
-	[S2MPS11_IRQ_PWRON1S] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRON1S_MASK,
-	},
-	[S2MPS11_IRQ_MRB] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_MRB_MASK,
-	},
-	[S2MPS11_IRQ_RTC60S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC60S_MASK,
-	},
-	[S2MPS11_IRQ_RTCA1] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA1_MASK,
-	},
-	[S2MPS11_IRQ_RTCA0] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA0_MASK,
-	},
-	[S2MPS11_IRQ_SMPL] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_SMPL_MASK,
-	},
-	[S2MPS11_IRQ_RTC1S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC1S_MASK,
-	},
-	[S2MPS11_IRQ_WTSR] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_WTSR_MASK,
-	},
-	[S2MPS11_IRQ_INT120C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT120C_MASK,
-	},
-	[S2MPS11_IRQ_INT140C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT140C_MASK,
-	},
+	REGMAP_IRQ_REG(S2MPS11_IRQ_PWRONF, 0, S2MPS11_IRQ_PWRONF_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_PWRONR, 0, S2MPS11_IRQ_PWRONR_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_JIGONBF, 0, S2MPS11_IRQ_JIGONBF_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_JIGONBR, 0, S2MPS11_IRQ_JIGONBR_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_ACOKBF, 0, S2MPS11_IRQ_ACOKBF_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_ACOKBR, 0, S2MPS11_IRQ_ACOKBR_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_PWRON1S, 0, S2MPS11_IRQ_PWRON1S_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_MRB, 0, S2MPS11_IRQ_MRB_MASK),
+
+	REGMAP_IRQ_REG(S2MPS11_IRQ_RTC60S, 1, S2MPS11_IRQ_RTC60S_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_RTCA1, 1, S2MPS11_IRQ_RTCA1_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_RTCA0, 1, S2MPS11_IRQ_RTCA0_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_SMPL, 1, S2MPS11_IRQ_SMPL_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_RTC1S, 1, S2MPS11_IRQ_RTC1S_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_WTSR, 1, S2MPS11_IRQ_WTSR_MASK),
+
+	REGMAP_IRQ_REG(S2MPS11_IRQ_INT120C, 2, S2MPS11_IRQ_INT120C_MASK),
+	REGMAP_IRQ_REG(S2MPS11_IRQ_INT140C, 2, S2MPS11_IRQ_INT140C_MASK),
 };
 
 static const struct regmap_irq s2mps14_irqs[] = {
-	[S2MPS14_IRQ_PWRONF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONF_MASK,
-	},
-	[S2MPS14_IRQ_PWRONR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONR_MASK,
-	},
-	[S2MPS14_IRQ_JIGONBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBF_MASK,
-	},
-	[S2MPS14_IRQ_JIGONBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBR_MASK,
-	},
-	[S2MPS14_IRQ_ACOKBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBF_MASK,
-	},
-	[S2MPS14_IRQ_ACOKBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBR_MASK,
-	},
-	[S2MPS14_IRQ_PWRON1S] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRON1S_MASK,
-	},
-	[S2MPS14_IRQ_MRB] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_MRB_MASK,
-	},
-	[S2MPS14_IRQ_RTC60S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC60S_MASK,
-	},
-	[S2MPS14_IRQ_RTCA1] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA1_MASK,
-	},
-	[S2MPS14_IRQ_RTCA0] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA0_MASK,
-	},
-	[S2MPS14_IRQ_SMPL] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_SMPL_MASK,
-	},
-	[S2MPS14_IRQ_RTC1S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC1S_MASK,
-	},
-	[S2MPS14_IRQ_WTSR] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_WTSR_MASK,
-	},
-	[S2MPS14_IRQ_INT120C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT120C_MASK,
-	},
-	[S2MPS14_IRQ_INT140C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT140C_MASK,
-	},
-	[S2MPS14_IRQ_TSD] = {
-		.reg_offset = 2,
-		.mask = S2MPS14_IRQ_TSD_MASK,
-	},
+	REGMAP_IRQ_REG(S2MPS14_IRQ_PWRONF, 0, S2MPS11_IRQ_PWRONF_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_PWRONR, 0, S2MPS11_IRQ_PWRONR_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_JIGONBF, 0, S2MPS11_IRQ_JIGONBF_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_JIGONBR, 0, S2MPS11_IRQ_JIGONBR_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_ACOKBF, 0, S2MPS11_IRQ_ACOKBF_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_ACOKBR, 0, S2MPS11_IRQ_ACOKBR_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_PWRON1S, 0, S2MPS11_IRQ_PWRON1S_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_MRB, 0, S2MPS11_IRQ_MRB_MASK),
+
+	REGMAP_IRQ_REG(S2MPS14_IRQ_RTC60S, 1, S2MPS11_IRQ_RTC60S_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_RTCA1, 1, S2MPS11_IRQ_RTCA1_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_RTCA0, 1, S2MPS11_IRQ_RTCA0_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_SMPL, 1, S2MPS11_IRQ_SMPL_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_RTC1S, 1, S2MPS11_IRQ_RTC1S_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_WTSR, 1, S2MPS11_IRQ_WTSR_MASK),
+
+	REGMAP_IRQ_REG(S2MPS14_IRQ_INT120C, 2, S2MPS11_IRQ_INT120C_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_INT140C, 2, S2MPS11_IRQ_INT140C_MASK),
+	REGMAP_IRQ_REG(S2MPS14_IRQ_TSD, 2, S2MPS14_IRQ_TSD_MASK),
 };
 
 static const struct regmap_irq s2mpu02_irqs[] = {
-	[S2MPU02_IRQ_PWRONF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONF_MASK,
-	},
-	[S2MPU02_IRQ_PWRONR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRONR_MASK,
-	},
-	[S2MPU02_IRQ_JIGONBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBF_MASK,
-	},
-	[S2MPU02_IRQ_JIGONBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_JIGONBR_MASK,
-	},
-	[S2MPU02_IRQ_ACOKBF] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBF_MASK,
-	},
-	[S2MPU02_IRQ_ACOKBR] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_ACOKBR_MASK,
-	},
-	[S2MPU02_IRQ_PWRON1S] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_PWRON1S_MASK,
-	},
-	[S2MPU02_IRQ_MRB] = {
-		.reg_offset = 0,
-		.mask = S2MPS11_IRQ_MRB_MASK,
-	},
-	[S2MPU02_IRQ_RTC60S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC60S_MASK,
-	},
-	[S2MPU02_IRQ_RTCA1] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA1_MASK,
-	},
-	[S2MPU02_IRQ_RTCA0] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA0_MASK,
-	},
-	[S2MPU02_IRQ_SMPL] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_SMPL_MASK,
-	},
-	[S2MPU02_IRQ_RTC1S] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTC1S_MASK,
-	},
-	[S2MPU02_IRQ_WTSR] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_WTSR_MASK,
-	},
-	[S2MPU02_IRQ_INT120C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT120C_MASK,
-	},
-	[S2MPU02_IRQ_INT140C] = {
-		.reg_offset = 2,
-		.mask = S2MPS11_IRQ_INT140C_MASK,
-	},
-	[S2MPU02_IRQ_TSD] = {
-		.reg_offset = 2,
-		.mask = S2MPS14_IRQ_TSD_MASK,
-	},
+	REGMAP_IRQ_REG(S2MPU02_IRQ_PWRONF, 0, S2MPS11_IRQ_PWRONF_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_PWRONR, 0, S2MPS11_IRQ_PWRONR_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_JIGONBF, 0, S2MPS11_IRQ_JIGONBF_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_JIGONBR, 0, S2MPS11_IRQ_JIGONBR_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_ACOKBF, 0, S2MPS11_IRQ_ACOKBF_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_ACOKBR, 0, S2MPS11_IRQ_ACOKBR_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_PWRON1S, 0, S2MPS11_IRQ_PWRON1S_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_MRB, 0, S2MPS11_IRQ_MRB_MASK),
+
+	REGMAP_IRQ_REG(S2MPU02_IRQ_RTC60S, 1, S2MPS11_IRQ_RTC60S_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_RTCA1, 1, S2MPS11_IRQ_RTCA1_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_RTCA0, 1, S2MPS11_IRQ_RTCA0_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_SMPL, 1, S2MPS11_IRQ_SMPL_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_RTC1S, 1, S2MPS11_IRQ_RTC1S_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_WTSR, 1, S2MPS11_IRQ_WTSR_MASK),
+
+	REGMAP_IRQ_REG(S2MPU02_IRQ_INT120C, 2, S2MPS11_IRQ_INT120C_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_INT140C, 2, S2MPS11_IRQ_INT140C_MASK),
+	REGMAP_IRQ_REG(S2MPU02_IRQ_TSD, 2, S2MPS14_IRQ_TSD_MASK),
 };
 
 static const struct regmap_irq s2mpu05_irqs[] = {
@@ -303,74 +159,25 @@ static const struct regmap_irq s2mpu05_irqs[] = {
 };
 
 static const struct regmap_irq s5m8767_irqs[] = {
-	[S5M8767_IRQ_PWRR] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_PWRR_MASK,
-	},
-	[S5M8767_IRQ_PWRF] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_PWRF_MASK,
-	},
-	[S5M8767_IRQ_PWR1S] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_PWR1S_MASK,
-	},
-	[S5M8767_IRQ_JIGR] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_JIGR_MASK,
-	},
-	[S5M8767_IRQ_JIGF] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_JIGF_MASK,
-	},
-	[S5M8767_IRQ_LOWBAT2] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_LOWBAT2_MASK,
-	},
-	[S5M8767_IRQ_LOWBAT1] = {
-		.reg_offset = 0,
-		.mask = S5M8767_IRQ_LOWBAT1_MASK,
-	},
-	[S5M8767_IRQ_MRB] = {
-		.reg_offset = 1,
-		.mask = S5M8767_IRQ_MRB_MASK,
-	},
-	[S5M8767_IRQ_DVSOK2] = {
-		.reg_offset = 1,
-		.mask = S5M8767_IRQ_DVSOK2_MASK,
-	},
-	[S5M8767_IRQ_DVSOK3] = {
-		.reg_offset = 1,
-		.mask = S5M8767_IRQ_DVSOK3_MASK,
-	},
-	[S5M8767_IRQ_DVSOK4] = {
-		.reg_offset = 1,
-		.mask = S5M8767_IRQ_DVSOK4_MASK,
-	},
-	[S5M8767_IRQ_RTC60S] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_RTC60S_MASK,
-	},
-	[S5M8767_IRQ_RTCA1] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_RTCA1_MASK,
-	},
-	[S5M8767_IRQ_RTCA2] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_RTCA2_MASK,
-	},
-	[S5M8767_IRQ_SMPL] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_SMPL_MASK,
-	},
-	[S5M8767_IRQ_RTC1S] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_RTC1S_MASK,
-	},
-	[S5M8767_IRQ_WTSR] = {
-		.reg_offset = 2,
-		.mask = S5M8767_IRQ_WTSR_MASK,
-	},
+	REGMAP_IRQ_REG(S5M8767_IRQ_PWRR, 0, S5M8767_IRQ_PWRR_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_PWRF, 0, S5M8767_IRQ_PWRF_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_PWR1S, 0, S5M8767_IRQ_PWR1S_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_JIGR, 0, S5M8767_IRQ_JIGR_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_JIGF, 0, S5M8767_IRQ_JIGF_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_LOWBAT2, 0, S5M8767_IRQ_LOWBAT2_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_LOWBAT1, 0, S5M8767_IRQ_LOWBAT1_MASK),
+
+	REGMAP_IRQ_REG(S5M8767_IRQ_MRB, 1, S5M8767_IRQ_MRB_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_DVSOK2, 1, S5M8767_IRQ_DVSOK2_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_DVSOK3, 1, S5M8767_IRQ_DVSOK3_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_DVSOK4, 1, S5M8767_IRQ_DVSOK4_MASK),
+
+	REGMAP_IRQ_REG(S5M8767_IRQ_RTC60S, 2, S5M8767_IRQ_RTC60S_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_RTCA1, 2, S5M8767_IRQ_RTCA1_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_RTCA2, 2, S5M8767_IRQ_RTCA2_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_SMPL, 2, S5M8767_IRQ_SMPL_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_RTC1S, 2, S5M8767_IRQ_RTC1S_MASK),
+	REGMAP_IRQ_REG(S5M8767_IRQ_WTSR, 2, S5M8767_IRQ_WTSR_MASK),
 };
 
 static const struct regmap_irq_chip s2mpg10_irq_chip = {

-- 
2.49.0.472.ge94155a9ec-goog


