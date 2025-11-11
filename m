Return-Path: <linux-kernel+bounces-896084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C2BC4F9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BB3B9448
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C332863E;
	Tue, 11 Nov 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1cBkiZt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC2327216
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889207; cv=none; b=OyBphC6jzTt0IsNmdF9SWB5/NtcwY3Z1JOp9c2aPz5X48KktSyMSwh6WApf5Ymzj7GUetYKDefpK16uLNYIXgDScAmguaq4yEHrkifz1Q8LB1JVUAr1oE4Mp/IJRj1Kv6Nxd9DocJpsXAmxLn8HmgAi2hGw9bAC03PDLxLby+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889207; c=relaxed/simple;
	bh=fwml7KgkE1J3Ai4MZr/kpN1tNeDhuCSqy9eCyYXxwZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISSTr3wdxHWY3WyMbuTYlABVjTht/4mruVMosYhzDQM+KWrNei9vfj3QdUSuil9kpmAgam7lXdHvhUzKzr7CFRuRNqAuwf8aL859byN10vXJCa5o4lOrBOqCto7w6oBIvGEVJH3DtsQLkQwaTzamMlgl6KAyWorkb1owKgbAKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1cBkiZt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29844c68068so440285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762889205; x=1763494005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imIwJUQw0bI9H7QFTurPbNC+Bd5DwsLxwxGR/tUh3uE=;
        b=i1cBkiZtj4ACKpZgXrCK8MXtMksxE0MitPhMh2HvBM1yS0G2Phu8TuEgf65aw/W1fp
         WfcvIe1o7HsyKjzXa4E8OkelO1nC5JkyccOOuCYx+r0A3K/tPblUj0i5aeV0TE5gfW7m
         7obQszC6ve+2NbSc8NYcHZMtacc9wgh9egSLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889205; x=1763494005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imIwJUQw0bI9H7QFTurPbNC+Bd5DwsLxwxGR/tUh3uE=;
        b=Eiwcqy5gNPhYj2xL0aDtKcBtWT4I5reaxm5VRa3NRpxrLy6po6IGr6U2CyypNkkQNi
         afboXpGLUrwYjY1G0C1AWrCt2VBa6DAJm/3BFRyZiieLKPzIgmUvRGM+sej1wcxsnk33
         2sQm/pn7p1Ls79nIufrX5IAdbGg2WUWgM1jbD9JdBUA1WkvktDcMMVr9kYWK3L7UxAQw
         ScQStt/RE6tntJ8ktp1wMsH8x96DmAjr0hPsDx0ao8WmnTGPiEAX39pCV2ii3ll/ncIP
         EP6hjyS7TyKHVcC+SCIGIGmhZOO3gdqdr0E9HP2J02Ww4vFwLwSee9dRNRH+FEqlAdEh
         iHSA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxBP/3nugAWzRxhUWpJU3EVqrjkKLKjtOrqLCbCKfMx/lIMX0BIrrIfvL3uZbmuKkEoct8/P0WoteDW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUpw4Pu18jh7tq4N4sTqRi/kW+AxOZ8+foelFfxzc4LGgCrbI
	NX7NdBzyCVWIdiEXI+qmsYIeftf0JCe0FdI3ihuCn2aAsF0ohxz/KaeXCNSdGKdAPQ==
X-Gm-Gg: ASbGncte9AeYiyxG0rySLc90pbPohic7uD2FeuwC4V0KVLplsx5JfiqxyfpGx+twgsq
	9dbqaVsp6oMgfjf9IlCIqzEZ4hdbcnTCcdSAfFGkBaznN/St1yy0xZbMwjOYjEmOUW3+SbgmN71
	QUpZKeo1j2Mg4k7FKvRWTmkOrQuKlw31OQHd+yW4BVHUR/axWqntNYAnLP6ENPIgZdGNwKyxmyf
	G9d9zYMkwbpUqOCHzL5DDprDX6Bat18mXI1pFSuz+f2baXU+1lS/yzl7J5ESOa+Sg8dtOqCrtWE
	ofjzFgVc8e21Vv9J/L6g+lZ5yAbG9ZkLM7f9w/gDz6VzNt1q/7EuvXXsLV0AYuoBMeQC36Xkjgz
	R5z3Aj6Zo9iwkkqhnep9T7cN2hyLhoByQ0hMrO4I1piIZN/yG4CnzPpXCx2CeFZzvDpeZxdrVhI
	CYHtLVQKh83mz2NYAWpwD9YZr+hJ/hXXn17sKMoAhE5Uc8yimPlvRsxgXxeKrmTsMDSYudTg==
X-Google-Smtp-Source: AGHT+IGjCOd+4ejNkIaM3IgSSrfNJ+dmBJ/8y2etg+UINkDzARyyHRj4mxQVKfiW2P/glN4METLcKw==
X-Received: by 2002:a17:902:e88c:b0:297:d697:41e with SMTP id d9443c01a7336-2984edaab98mr5869605ad.37.1762889205543;
        Tue, 11 Nov 2025 11:26:45 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:ba9f:d4c6:9323:4864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0974sm4861075ad.90.2025.11.11.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:26:43 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Drew Fustini <fustini@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	soc@lists.linux.dev
Subject: [PATCH 3/4] arm64: dts: google: Add dts directory for Google-designed silicon
Date: Tue, 11 Nov 2025 11:22:06 -0800
Message-ID: <20251111112158.3.I35b9e835ac49ab408e5ca3e0983930a1f1395814@changeid>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111192422.4180216-1-dianders@chromium.org>
References: <20251111192422.4180216-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first four Google Tensor SoCs were offshoots of Samsung Exynos
SoCs and their device trees were organized under the "exynos/google"
directory. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
Google Tensor SoCs are now of Google's own design. Add a location in
the tree to store these device tree files.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS                         | 1 +
 arch/arm64/Kconfig.platforms        | 6 ++++++
 arch/arm64/boot/dts/Makefile        | 1 +
 arch/arm64/boot/dts/google/Makefile | 1 +
 4 files changed, 9 insertions(+)
 create mode 100644 arch/arm64/boot/dts/google/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..f73a247ec61c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10606,6 +10606,7 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
+F:	arch/arm64/boot/dts/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	drivers/phy/samsung/phy-gs101-ufs.c
 F:	include/dt-bindings/clock/google,gs101.h
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..044af9a3b45f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -138,6 +138,12 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
+config ARCH_GOOGLE
+	bool "Google-Designed SoC family"
+	help
+	  This enables support for Google Tensor chips starting at the
+	  Google Tensor G5.
+
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select SOC_TI
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index b0844404eda1..b4b5023d61d2 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -17,6 +17,7 @@ subdir-y += cavium
 subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
+subdir-y += google
 subdir-y += hisilicon
 subdir-y += intel
 subdir-y += lg
diff --git a/arch/arm64/boot/dts/google/Makefile b/arch/arm64/boot/dts/google/Makefile
new file mode 100644
index 000000000000..a6b187e2d631
--- /dev/null
+++ b/arch/arm64/boot/dts/google/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-- 
2.51.2.1041.gc1ab5b90ca-goog


