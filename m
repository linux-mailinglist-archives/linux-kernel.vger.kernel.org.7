Return-Path: <linux-kernel+bounces-882331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC5C2A337
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B794EA8A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119D296BC3;
	Mon,  3 Nov 2025 06:37:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3029221DB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151864; cv=none; b=RLwo1yxz3jjs4Dr5RZfzrO4vXTEYk4AQVR0WKxvFhSJp1bTuY4kjpaMcT66qMh+lNLOvz8E8H8qFucZ/FDe11OFuQlii9106VB+kNhlhERd2j7UMVJYYkbWqRqD94AMzMufYAijllRfDgd1wJo/Ug5ARurxr38zRRZjupa/ospk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151864; c=relaxed/simple;
	bh=l6Gg/KXsf7Xx6bbK38Vv301YSNTzxuyblASz3B0eElI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bU/APkDL2cP8QyDTSATNBEuRP5G6AVmeS2yTCq7S0iFEDyxkVucdXB5bC1meIaIPWDC9xNMVS/gSEVEqJejeZR0MN0IsmFjxJiLYFYwxowGduQetSTChRUKJl5zaLqJVssj1lUUHEoS5iA0YEgZCHVT40l7fX/WghiG/I5Npdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005BA28FA;
	Sun,  2 Nov 2025 22:37:33 -0800 (PST)
Received: from Mac.blr.arm.com (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 258E73F694;
	Sun,  2 Nov 2025 22:37:34 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	hannes@cmpxchg.org
Cc: ryan.roberts@arm.com,
	hpa@zytor.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	ppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
Date: Mon,  3 Nov 2025 12:07:18 +0530
Message-Id: <20251103063718.90743-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of CONFIG_PT_RECLAIM is completely contained in generic
mm code. It depends on the RCU callback which will reclaim the pagetables -
there is nothing arch-specific about that. So, enable this config for
all architectures.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/x86/Kconfig | 1 -
 mm/Kconfig       | 5 +----
 mm/pt_reclaim.c  | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..5681308a5650 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -327,7 +327,6 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
-	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..903c37d02555 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
 	  The architecture has hardware support for userspace shadow call
           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
-config ARCH_SUPPORTS_PT_RECLAIM
-	def_bool n
-
 config PT_RECLAIM
 	bool "reclaim empty user page table pages"
 	default y
-	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
+	depends on MMU && SMP
 	select MMU_GATHER_RCU_TABLE_FREE
 	help
 	  Try to reclaim empty user page table pages in paths other than munmap
diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
index 7e9455a18aae..049e17f08c6a 100644
--- a/mm/pt_reclaim.c
+++ b/mm/pt_reclaim.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/hugetlb.h>
-#include <asm-generic/tlb.h>
+#include <asm/tlb.h>
 #include <asm/pgalloc.h>
 
 #include "internal.h"
-- 
2.30.2


