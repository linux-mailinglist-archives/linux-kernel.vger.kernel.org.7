Return-Path: <linux-kernel+bounces-806872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECFB49CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DC61B26BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC632F616D;
	Mon,  8 Sep 2025 22:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16212EC0AA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370938; cv=none; b=GNSyk1zF5ZInRI+mCOcm9UzV0b7c+Ezvq5e5CI6PcAJ0H9+s9xmxutWyAs/5++UeV1ZLRztsOvVItqTRPsosQ8zf3ouIpm0do0ilVPrYonOvwcvg6TmOec/G993Orsj5UdC3QhM0pcu7qCkDpzm6pRNGeRG6yVhKVw6trW3iwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370938; c=relaxed/simple;
	bh=bwvyHVJBZAjMcnsVcx3mFaC9jBdi0suEgz8i+jKzcy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9nJzMyf/IDL5r1PJPP1N1FPifCihpisc8ayegEqd09zceDSCOEb+Geux1kGNEW3IHc32bZpZQ4QwKF3/qwOFLfeXqVOzwshxuhIRR5zzYBNoUrwKc7yR+DXVzyU7O7CkAaGkSquDK53owpHBk6X4YDr1DejrhvKmhWccFojvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5EF2F9D;
	Mon,  8 Sep 2025 15:35:27 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B88E03F694;
	Mon,  8 Sep 2025 15:35:34 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	gshan@redhat.com,
	aneesh.kumar@kernel.org,
	sami.mujawar@arm.com,
	sudeep.holla@arm.com,
	steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 2/3] arm64: Enable EFI secret area Securityfs support
Date: Mon,  8 Sep 2025 23:35:18 +0100
Message-ID: <20250908223519.1759020-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908223519.1759020-1-suzuki.poulose@arm.com>
References: <20250908223519.1759020-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable EFI COCO secrets support. Provide the ioremap_encrypted() support required
by the driver.

Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Sami Mujawar <sami.mujawar@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/io.h          | 4 ++++
 drivers/virt/coco/efi_secret/Kconfig | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 82276282a3c7..83e03abbb2ca 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -274,6 +274,10 @@ int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
 #define ioremap_np(addr, size)	\
 	ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
+
+#define ioremap_encrypted(addr, size)	\
+	ioremap_prot((addr), (size), PAGE_KERNEL)
+
 /*
  * io{read,write}{16,32,64}be() macros
  */
diff --git a/drivers/virt/coco/efi_secret/Kconfig b/drivers/virt/coco/efi_secret/Kconfig
index 4404d198f3b2..94d88e5da707 100644
--- a/drivers/virt/coco/efi_secret/Kconfig
+++ b/drivers/virt/coco/efi_secret/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config EFI_SECRET
 	tristate "EFI secret area securityfs support"
-	depends on EFI && X86_64
+	depends on EFI && (X86_64 || ARM64)
 	select EFI_COCO_SECRET
 	select SECURITYFS
 	help
-- 
2.43.0


