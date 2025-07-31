Return-Path: <linux-kernel+bounces-751519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28090B16A88
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9718A7A0F79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1019309C;
	Thu, 31 Jul 2025 02:48:52 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B68F5E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930132; cv=none; b=CGlUm5PACTwojDd1cwonDURrH7sBBYTesXSxbjzaI+/TD9HRszcCiWU+jOX9vDKGhOmLc7VdYXIbQN2VjUorSVN/B5uwYpFmZRCHfWZrU0vl1s6mg+XYtVK7XZPVgwz3/9Yju3E+gHnjquOSEOh+1pqw6Sb+hnRyf1FIALdMvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930132; c=relaxed/simple;
	bh=UgPYaQwlWJc9Zen37DK75P/yQXewXknsnjFDmjKxJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkvOtRqwBr8BL8q0Mm16JamFIM69njXBAXQNkByqgNLf1LzRUoynmf/NfRq4xghDpYIsKjG55XVTMIe/MVkyv0MvT2zxdAOAPR/xhlULHQtkrHc9RN3H/5JFXotmnDB7J4U8dqI/HDE9d/tEltxO0qt5ojDtxv+BfvhYCEsA0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1dce07079;
	Thu, 31 Jul 2025 10:48:44 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alessandro Rubini <rubini@unipv.it>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] hw_random: nomadik: add missing dependency on ARM_AMBA
Date: Thu, 31 Jul 2025 10:48:42 +0800
Message-ID: <20250731024842.351-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985e61caae03a2kunm8ed30b26289fe4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkJKVkweGExJH0xMTh4ZGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUhZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Compiling without CONFIG_ARM_AMBA causes undefined reference errors:
 ld: vmlinux.o: in function `nmk_rng_remove':
 nomadik-rng.c:(.text+0x6f64917): undefined reference to `amba_release_regions'
 ld: vmlinux.o: in function `nmk_rng_probe':
 nomadik-rng.c:(.text+0x6f649ee): undefined reference to `amba_request_regions'
 nomadik-rng.c:(.text+0x6f64aba): undefined reference to `amba_release_regions'
 nomadik-rng.c:(.text+0x6f64ae0): undefined reference to `amba_release_regions'

The Nomadik RNG driver uses AMBA bus interfaces (amba_request_regions/amba_release_regions)
which are only available when CONFIG_ARM_AMBA is enabled. The existing dependency
on ARCH_NOMADIK implicitly selects ARM_AMBA, but when building with COMPILE_TEST
on non-ARM platforms, this dependency breaks.

Fix by explicitly adding dependency on ARM_AMBA to Kconfig, ensuring the driver
only compiles when AMBA support is available.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index c85827843447..09abd1acb99f 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -311,7 +311,7 @@ config HW_RANDOM_INGENIC_TRNG
 
 config HW_RANDOM_NOMADIK
 	tristate "ST-Ericsson Nomadik Random Number Generator support"
-	depends on ARCH_NOMADIK || COMPILE_TEST
+	depends on ARM_AMBA && (ARCH_NOMADIK || COMPILE_TEST)
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.43.0


