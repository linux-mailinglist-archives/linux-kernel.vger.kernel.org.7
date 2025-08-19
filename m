Return-Path: <linux-kernel+bounces-775679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E7EB2C38B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3692D72167B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05833342CA8;
	Tue, 19 Aug 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEAzAqhT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88551342CA4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606079; cv=none; b=fpayTiZaNbxYeJdxwXeHm8lmht2DrPW2DdX36Lpqj+EROOgmu3R3qPYvP7LlnyKf28hu6mq/XVteF/L0MO33nfT0+g1F5u2B0mqGTLr81g5Qc3jwbV+nyAMu/HcgPRjE6mmxcbejkvlXph74pMrzg60PzhEbMYQOWIB9OiMr/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606079; c=relaxed/simple;
	bh=0Q9EBNgnuOCskljbtw+Vs3Xg9fPTIle3oM4oVNzAITE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XTbJBOyVpPX4J84SYdsJYcqEKwn2Eh4F8YAZw1DmR07ln2mBmgFxEjCwaX593rAAXwaGG+wM0CO/8BzQlW/rXfQqY3sjm2cuPPKtYDbApS4GGgIhP8GPIZJqQ11SLfMDtfKHE9KLBs4zeebuTXiuXhTK208d8iDHRPT0W2I9Op4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KEAzAqhT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b097037so29234185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606076; x=1756210876; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rQW6TBzGK1G1eXbPBin0o7LZ+IJINQdyNxTLpbpWdo=;
        b=KEAzAqhTInXI0BZyE7IuciwAzlki5ce/kodxWfBHPtavTIGwvmUqz0aOM41gXmDk4c
         Q0eGO8cUzoTdfI0p9nYwKPQMiw/C6dVW4Oivsaee7oAfKztpz2FxnVsesCwqNan1BN0O
         gCc05FcEx9wYbuxQUSa6F66SH+siCGYZI2CiAY2op5YvHvKG/cAK7zW2MYfIDv9y9AU+
         OU5MZjmqxcDZ6lgK2a3FjXPd08HVhpj5CApiKBwI/6cOVbT00+VhNLvZYwXOonmpJD+9
         bEE9XwzeyTpwwLVMbHGS37pJ0ZwTA+8y45GCABw8kDi+n0xSVn9eX+yHrqbbji7/JEYb
         2ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606076; x=1756210876;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rQW6TBzGK1G1eXbPBin0o7LZ+IJINQdyNxTLpbpWdo=;
        b=TP9uXejGeG60tRorwAF+0TZBWnA0dpLGV8T1DxO7l6u4MEuvHUBpAxTOcDl3taYGYq
         8yaMkNoLhP4nuBelRno6MrTQibW029hps3OSFIJ6rY6lRGPRdui7ZL5g4M+b8QjQtktL
         dka3j8cDosVZcZ4VXTaDYBXe5Ow9vIwmCxyASpJGZmN2+6uii8f6+7IMvWjXktGtMTvs
         T6v+g1AYSyW0c1BE6FaUyh27EMo408SdDCyB+T3adWN/4qovQXNWJ+dKjSG59EGX21/k
         LNTBgmqmAcRE5A9iQDFLVrBEtL/1H/g2udUq8ITLiZQWrPZioZ4EuDM8ioAkwnD8GABS
         UTEg==
X-Forwarded-Encrypted: i=1; AJvYcCVPNKabz8oh9pufzeUebW+yGlqk8+EpocicVWhF341ehWQTh3nomSKrTRKBzvpDbrw3sKe35PjWnxPpxok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfXEwnIf3DNLyGAoamFAYU4PPSREB6oeVlhT29ZWloG9tq+D4
	NVb5VjBc08W+lRQj2g6QbSKMPyB1JocPzvKNPd2QFXxitFIBG65HEsA5hj+RlJS9PFM=
X-Gm-Gg: ASbGncsNWMz/lW7rpHpKve2Te4bkVsMAWuQrqLQZtY+QbfJ8Q3VVg+wW0GnC67/OOSH
	2UvjRHU2J8pvD7suHu/bsp9pC30VAovWTNSJORpX3EiAlnsS5j84lIiZHNFKxMtpzpehNvZvMlA
	26HHGS0j7/6kqcoDYglivjkfwn/4bsmAwAgUb1iIiWMHjFQfFq5SHVFz7vKp7Kf6xKYjqW/rbHA
	yj8KYr38iUdkfzfMaXQ0nCxkp7MCW6sfeKPF8R2Fz0KpXuoXoQw52vXLwot17DgVSEMqAjDSsJT
	CnjZuuhIGa/WWm0PdS7KV4t/FkZuopRvpjOh2p3X5hsUmw19zaB3zCb9QiIsBzb18G45acz/vWq
	lno5Z9DL6SmshTJ8OGEdNh7duY5xICicSqTqIJG9vxKBr9wFPhRbWCCLhR4Yz2VRm3hvKNXVJY2
	Wvrw==
X-Google-Smtp-Source: AGHT+IGUZT2806D2Tn5scfUdkvETMFzU3Pnq507Z4qfJ65eJZCeuTeyx3S8c5HAi/cNBGb4vzb9RdQ==
X-Received: by 2002:a05:6000:18a7:b0:3b8:f318:dc61 with SMTP id ffacd0b85a97d-3c0ec660614mr2020703f8f.40.1755606075840;
        Tue, 19 Aug 2025 05:21:15 -0700 (PDT)
Received: from ta2.c.googlers.com (245.92.187.35.bc.googleusercontent.com. [35.187.92.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1636sm3472701f8f.43.2025.08.19.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:21:15 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 19 Aug 2025 12:21:13 +0000
Subject: [PATCH] arm64: defconfig: enable Exynos ACPM clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-acpm-clk-defconfig-v1-1-70f5963ef90a@linaro.org>
X-B4-Tracking: v=1; b=H4sIADhspGgC/x3MTQqAIBBA4avIrBvQJPq5SrQwHWuoNBQiiO6et
 PwW7z2QKTFlGMQDiS7OHEOBqgTY1YSFkF0x1LJuZKd6NPY80O4bOvI2Bs8LqtlpT1q2bSehhGc
 iz/c/Haf3/QAri9t4ZAAAAA==
X-Change-ID: 20250819-acpm-clk-defconfig-1bd3fe307780
To: krzk@kernel.org, alim.akhtar@samsung.com, 
 linux-samsung-soc@vger.kernel.org
Cc: peter.griffin@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755606075; l=1140;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=0Q9EBNgnuOCskljbtw+Vs3Xg9fPTIle3oM4oVNzAITE=;
 b=1QpGIWzICtt4qBg5AUnoDnZH57zYNvQvtpTetSQcHjxBXDrf0iLiogSx2aqj6oMJ+G0EyagZK
 meoZ0SgJ3xtDnh+qdZB/uqt72AnEDttjSsN7AWiioZIDe9Y/SsHTj8Z
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM clocks driver. Samsung Exynos platforms
implement ACPM to provide support for clock configuration, PMIC
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
The patch should go through the Samsung SoC tree.

The driver is proposed at:
https://lore.kernel.org/linux-samsung-soc/20250819-acpm-clk-v1-0-6bbd97474671@linaro.org/
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366cd12ae212a1d107660afe8be6c5ef..4255bc885545fb3bb7e9cf02760cac35bf2872fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1445,6 +1445,7 @@ CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_SM_VIDEOCC_8450=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
 CONFIG_CLK_RENESAS_VBATTB=m
+CONFIG_EXYNOS_ACPM_CLK=m
 CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_OMAP=m

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-acpm-clk-defconfig-1bd3fe307780

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


