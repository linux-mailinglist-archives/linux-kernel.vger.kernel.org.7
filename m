Return-Path: <linux-kernel+bounces-853632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE2BDC297
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11BF3BBF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13E30C342;
	Wed, 15 Oct 2025 02:36:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922430BBBB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495778; cv=none; b=NvFsvnB/b8H+jgUrCrL64j3c2FHTAygPdCKq/g4nYlLYVlGynZFHxFzYdxBmAFV/hOExguO0cN/Fa+9Bj6eA6OI+7Y0XN2CplFqGguz+zFWpU5nnO2112u17UmFhMcLkgtEMJSvaw7BUGVdMtqnp+2y3GrwwV7Bqmi4tJ068pXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495778; c=relaxed/simple;
	bh=OuAvhA/0BkmloJKoZBjLrYHI3OjNLfbqImhJg3V+Gmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ItuFakhI5IIsDOU3tF2vKbSw03Z0U4nE2WKc8Cd/N+tmK2MKycLv6pev7wQWxe92HqqG7KyDjAVjfwSGNeNEDklFT7QNWmKCPhkWL5z0njybM9qyMj0QUnyxh0cikbPe8zJPZpirl1Du3pzAb++1LNIb52SC4d8bZgRXieOk74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51AE21A32;
	Tue, 14 Oct 2025 19:36:08 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3119B3F738;
	Tue, 14 Oct 2025 19:36:15 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop redundant extern declaration for rodata_full
Date: Wed, 15 Oct 2025 03:36:09 +0100
Message-Id: <20251015023609.427911-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the redundant extern declaration 'rodata_full' which can be included
via the header <asm/setup.h> after moving exiting declaration outside the
function arch_parse_debug_rodata(). While here also drop 'rodata_enabled'
which is anyways available via the generic header <linux/init.h>.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 --
 arch/arm64/include/asm/setup.h       | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0375ca3162ff..e4b3563e1d96 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -26,8 +26,6 @@
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
-extern bool rodata_full;
-
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
 	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 3d96dde4d214..902f1aab520f 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -12,12 +12,10 @@
  */
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
+extern bool rodata_full;
 
 static inline bool arch_parse_debug_rodata(char *arg)
 {
-	extern bool rodata_enabled;
-	extern bool rodata_full;
-
 	if (!arg)
 		return false;
 
-- 
2.30.2


