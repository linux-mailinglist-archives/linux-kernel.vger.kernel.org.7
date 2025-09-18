Return-Path: <linux-kernel+bounces-788543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B04B38614
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1539B1896792
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1582773D5;
	Wed, 27 Aug 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAYx8mqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36772749E2;
	Wed, 27 Aug 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307696; cv=none; b=jDFGazhmz2n02xeEin5hTKNDwVDreN/TpeD1R2BvkQwuWEwVlHB6w5haig3U2Lr+NTHlj1tu8N+9iilv85NSLnVElfmm51Yx+EZjBVv6jY1+ctnSqJ9xdd9CUS6c27u69VQy0L9rUh9GNBY3xsHn9nn6UBjx46m7SvIIvR01SYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307696; c=relaxed/simple;
	bh=gw2Ah4Rt2D+6bPW1+7M02U96xkL1iHc+3kS1D3Z/L0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/bw7M0rsQiKLU+1PPP32wcU+MHT3sT3H/ufwr1BV/qjKHJ5IkuLsPvwDyiPYYKEWU5gn/w0j9KxnJsd+gv7EyFc4aDPPFmfHUtmuEycOmpJAfRGq85EAhbpvhGN4GBj37Y6fNoOXW5G8jETp+713zVuNlT7L1Qm73C5ZF1OHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAYx8mqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70498C4CEF9;
	Wed, 27 Aug 2025 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307696;
	bh=gw2Ah4Rt2D+6bPW1+7M02U96xkL1iHc+3kS1D3Z/L0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAYx8mqsUEpyjqV3d0BmRT0pzARb3YUwvqI6cxKolz5P4W0Bf+U/uslnOuw/nQaXN
	 MEtT+p5upyuIPnne/UbnAFfdRtu2Iw5LEKM/JSz7zP5JYhFt+9owmvw5C9/NSLqvaw
	 vn0NgfxGw0d2ikqcCw6jzxucfabdyK8SjBEYEVohweCQmqJSk3IwkzH0L+if56SQNe
	 lZmmAb2BR+Sls6RV/QXEKDdrtv/TX5ZEEn+pzy5gMKSsMvA8KK3Kt8+AE9OX/uItZT
	 EPS+MQB3IcbLUeITEbvSNCX3AONYnf1dHX5eX8zoyP/aYdkcMC9eRR+gWfii0SgMY5
	 K7V/9i5SWn6rg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 01/12] arm: configs: Remove obsolete assignments to CRYPTO_CHACHA20_NEON
Date: Wed, 27 Aug 2025 08:11:20 -0700
Message-ID: <20250827151131.27733-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827151131.27733-1-ebiggers@kernel.org>
References: <20250827151131.27733-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v6.15, CRYPTO_CHACHA20_NEON is a hidden option and is selected
automatically.  Therefore, assigning a value to it in a defconfig no
longer has any effect.  Remove it from all files that did this.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/arm/configs/exynos_defconfig        | 1 -
 arch/arm/configs/milbeaut_m10v_defconfig | 1 -
 arch/arm/configs/multi_v7_defconfig      | 1 -
 arch/arm/configs/omap2plus_defconfig     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 6915c766923a2..84070e9698e8c 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -362,11 +362,10 @@ CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
 CONFIG_CRYPTO_DEV_S5P=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=96
 CONFIG_FONTS=y
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index a3be0b2ede09c..a2995eb390c60 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -99,11 +99,10 @@ CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f2822eeefb957..cc0e0e4a879cb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1289,11 +1289,10 @@ CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_EXYNOS_RNG=m
 CONFIG_CRYPTO_DEV_S5P=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=m
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 939913ed9a73b..1d5f752417398 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -706,11 +706,10 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_OMAP=m
 CONFIG_CRYPTO_DEV_OMAP_SHAM=m
 CONFIG_CRYPTO_DEV_OMAP_AES=m
 CONFIG_CRYPTO_DEV_OMAP_DES=m
 CONFIG_DMA_CMA=y
-- 
2.50.1


