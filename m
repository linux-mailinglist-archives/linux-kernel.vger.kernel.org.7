Return-Path: <linux-kernel+bounces-815344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB44B5631A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D521D1B2671C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93632848B7;
	Sat, 13 Sep 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbOTBjde"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE00284663
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798191; cv=none; b=MrAramWjuyCBD7zCHfcS4Pl8gg/Wyt9zRZJd/oEfasstPzs/0tKKwNhUSOU2HOCdYLPCF7/z+ssxiGMiOifm/9+iEy0ZnSF4DiLAbndu8zmqKCxlmiLPZA0OGKI9vYtINB9Uo84Ic7PaA9DMdsyl0e56HBV3DFPsmYMxmvgS8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798191; c=relaxed/simple;
	bh=5e7C8/TepjeMtvdq2kYyVr6fK/WhjkkaD45NrgvOPnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDz3qgbC7au45z6uGLGyRi/QO++70wAXBuIgOkYbsEBxLU9mRqLKMbsyfTKhQZSifWnHlOd4aPHg2zrStiNLf6vXReNLoZjdH+RbWveb0J3k9UWtaPeYOSQN1/e73G1alSNtxAf7hNb7Ifj9Jcdz75o7TW3baozn6bQKkmDw8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbOTBjde; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e9a9298764so100997f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798187; x=1758402987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+VP5nzPO7TU78rfhYTFY7al0sL7mhZVAIAF4JSoUlo=;
        b=CbOTBjde5lQ7N36F3xP1hZbPey4UiqlZJ0Qt4MCpUEwD9AwaVzNlTFX2n4JxxAMQaK
         zC3xw66p6M682DlD4Bll9KaGuOSjhZyruH++wbp3MSgPSO4jebD54Pq0sbz7RGcnVPq0
         BnljcKv1E8fNVFmOolLRihI6bbor0hufy16Tw8E8P1ZOReL8l66yBqccEEEemLmwb6ES
         GMlWtl50IYK902AhJBecXDTjlBHGzykrPV8Wy/Tu7sVcdSuUKspACbiqc5lWFTKrAN/j
         +WCvXD7t6lgktm2ad4hKzxZLZiM4hkieAlqIQ4EXY/IMKiZDj08VuVxfsuzv95HJ3YNp
         StbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798187; x=1758402987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+VP5nzPO7TU78rfhYTFY7al0sL7mhZVAIAF4JSoUlo=;
        b=i3A3/pAcdAUK3GWo1IZ+dB/B96plxtNlezreQ0D9LfMxrHUubKHbCQxry0m6W99xat
         eNEHIAI2/dLMhmS6DNvbijweuZjUaXLBPIHnqrWNkxuvxb6zBMam0IXBJfC80DI83Oqu
         SozVea5m9hME1ncPo5XMOOd5lpW1/64VEbGVbZ1cZubHsbmhszHgTeKYb8rBppW3JPFl
         ++LEGCtKVdV84QteWZDVmn6ehR7mfqoD1I82lLEn0hZWxgeTn3B74CNVhqIzHlOZYoXt
         7gwRpV4uMYwt2G2uo/2HkAGcMwFSiLb8NlppntpcDuMv+BMZllg48JjFCGHKgeY9RBXv
         nlFA==
X-Forwarded-Encrypted: i=1; AJvYcCUDbowJVY9bqxNm8vYyKhgKh+7srdGcW+nQXEp418+2QXO+vJWuAWIs/KKeCS0fOL2CpvHFiMr1gub1YQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGeNt53NtFdqob5ZDs5QG+yfzwlrieG0+k220dWCvBwUtZ3aSA
	FV2E710MmkYgVNdcWfzcKVJbJ/lQWEiiGc/4NJZ1Ni97jeFG04naPYNrTMIVco1F
X-Gm-Gg: ASbGnct7vSUGt3oWP22NjNFIkUpLrl96JM0AziqgKC8ZoDiG34Ax/DMIdMlwK5WEb9M
	vNdnMiim4ICBBOndMegxRlF0yLSJfY5h98Z3ZxEb/h0/bj/Fbx5Ue8H3yeYxDxtnZVlzU8hl3Tb
	xkwV/rZJLihzwWKkWZ+EQu5V9erIcdOl6DW1/XaW/SlI4RYSx9oOkhYBwDqH2mYE1YgYiXpPkTQ
	ex1h79sZjhXcNSkIXosG+L+QjCAvRTEv1JojK7kznSts2WpcPBZU4pg8//rPyodaD0rDEV7FVtl
	Cy1UOuyzmJROKnaBJbeqHeV9cYC7xDvftU+pDOjVgKT6x+yYIitXU5Q0+hvKMx+NcDCXZ94qFwr
	imYfkUMKcgPhaDehE3hA50CutfYBnrARzo084dLFXjT8x+BXe/hj8
X-Google-Smtp-Source: AGHT+IErQfbzl+MbBvCHZhxs1p+1GYnI5sydo30kHH2h99Tqk9i7XQM6wd82P0gT6HpXmbTeKuaCjg==
X-Received: by 2002:a05:6000:2289:b0:3de:5aff:3498 with SMTP id ffacd0b85a97d-3e7659c40f9mr6426295f8f.14.1757798186616;
        Sat, 13 Sep 2025 14:16:26 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac468sm65403145e9.0.2025.09.13.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:16:26 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:12:50 +0200
Subject: [PATCH v4 3/4] clk: mmp: pxa1908: Instantiate power driver through
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-genpd-v4-3-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=w28rVWlir7yhdT2JFdKVFGiML/ldN3rGLXPeOpnXsl0=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlH7ytV2V8LFpVXk4iwbXp8pKpRROVavt7LuJkzhLbbe
 s1myKzrKGVhEONikBVTZMn973iN97PI1u3Zywxg5rAygQxh4OIUgIn47WVkWLF7ov5Fi8pXwYds
 p2TMzbuVvzdG5q5QekuY+E9u0ZPPzzIyfFr+4H/FqogKybKaJ9b6NkHfOJ8z6th9PeP96vi+gpo
 IfgA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The power domain driver shares the APMU clock controller's registers.
Instantiate the power domain driver through the APMU clock driver using
the auxiliary bus.

Also create a separate Kconfig entry for the PXA1908 clock driver to
allow (de)selecting the driver at will and selecting
CONFIG_AUXILIARY_BUS.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v4:
- Use devm_auxiliary_device_create()

v3:
- Move driver back to pmdomain subsystem, use auxiliary bus to
  instantiate the driver

v2:
- Move to clk subsystem, instantiate the driver from the APMU clock
  driver
- Drop clock handling
- Squash MAINTAINERS patch
---
 MAINTAINERS                        |  2 ++
 drivers/clk/Kconfig                |  1 +
 drivers/clk/mmp/Kconfig            | 10 ++++++++++
 drivers/clk/mmp/Makefile           |  5 ++++-
 drivers/clk/mmp/clk-pxa1908-apmu.c |  7 +++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b0e4767639b24d89fa760020a9681e5c2001a6e..148848dafac7c3dd50933ec22a3bd26170535d47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2869,7 +2869,9 @@ ARM/Marvell PXA1908 SOC support
 M:	Duje Mihanović <duje@dujemihanovic.xyz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
 F:	arch/arm64/boot/dts/marvell/mmp/
+F:	drivers/clk/mmp/Kconfig
 F:	drivers/clk/mmp/clk-pxa1908*.c
 F:	drivers/pmdomain/marvell/
 F:	include/dt-bindings/clock/marvell,pxa1908.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc1e28823fe6aee626a96847d4e6d5..68a9641fc649a23013b2d8a9e9f5ecb31d623abb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -511,6 +511,7 @@ source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
+source "drivers/clk/mmp/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mstar/Kconfig"
 source "drivers/clk/microchip/Kconfig"
diff --git a/drivers/clk/mmp/Kconfig b/drivers/clk/mmp/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..b0d2fea3cda5de1284916ab75d3af0412edcf57f
--- /dev/null
+++ b/drivers/clk/mmp/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMMON_CLK_PXA1908
+	bool "Clock driver for Marvell PXA1908"
+	depends on ARCH_MMP || COMPILE_TEST
+	depends on OF
+	default y if ARCH_MMP && ARM64
+	select AUXILIARY_BUS
+	help
+	  This driver supports the Marvell PXA1908 SoC clocks.
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 062cd87fa8ddcc6808b6236f8c4dd524aaf02030..0a94f2f0856389c8e959981ccafbb02140a7733d 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,7 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o clk-pxa1908-apmu.o clk-pxa1908-mpmu.o
+obj-$(CONFIG_COMMON_CLK_PXA1908) += clk-pxa1908-apbc.o clk-pxa1908-apbcp.o \
+	clk-pxa1908-mpmu.o clk-pxa1908-apmu.o
+
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o
diff --git a/drivers/clk/mmp/clk-pxa1908-apmu.c b/drivers/clk/mmp/clk-pxa1908-apmu.c
index d3a070687fc5b9fb5338f377f82e7664ca0aac29..7594a495a0093e8e22f2cfe3e61a13d23dc3b9c2 100644
--- a/drivers/clk/mmp/clk-pxa1908-apmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-apmu.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -85,6 +86,7 @@ static void pxa1908_axi_periph_clk_init(struct pxa1908_clk_unit *pxa_unit)
 static int pxa1908_apmu_probe(struct platform_device *pdev)
 {
 	struct pxa1908_clk_unit *pxa_unit;
+	struct auxiliary_device *adev;
 
 	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
 	if (!pxa_unit)
@@ -94,6 +96,11 @@ static int pxa1908_apmu_probe(struct platform_device *pdev)
 	if (IS_ERR(pxa_unit->base))
 		return PTR_ERR(pxa_unit->base);
 
+	adev = devm_auxiliary_device_create(&pdev->dev, "power", NULL);
+	if (IS_ERR(adev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adev),
+				     "Failed to register power controller\n");
+
 	mmp_clk_init(pdev->dev.of_node, &pxa_unit->unit, APMU_NR_CLKS);
 
 	pxa1908_axi_periph_clk_init(pxa_unit);

-- 
2.51.0


