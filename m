Return-Path: <linux-kernel+bounces-736568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847C1B09E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44101C456A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D997B295DB8;
	Fri, 18 Jul 2025 09:03:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B7294A0C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829417; cv=none; b=jcpQ33CVnQBOEM68HtBxQoEaMmWn/P0CMqzjFu16UOFcVopGEtTP4wAgoRjQ2mnf3PZVCdhSTUJHaEiDz9QbcjJMovAhVKWGangz27t8CDr9CmKRKXXgHM1CxnpZ9OtbkXQqd8lZYgs/Umzz3PQ4XYrgo69PUZ4reBVnDODBDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829417; c=relaxed/simple;
	bh=Lg7dW7bactYjr4swofwJqqd79Xj6oFX6KDX5alxYefo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axrX/0L4EMp0EXXj4FNVXPncP1uIIP1rvPuF9rHQxvOgRF9VQMiJ/x7Yeqxp16m1WwvvfxjDdtkD6a4TMb7RCA1maGoxe7MAuon8eJHOE6TyAXMjR81W125nHKavtGwUVr0zOa6xTvVFFn1dYEzL3sUH0d0i+WX1xilDJvKNIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B94176C;
	Fri, 18 Jul 2025 02:03:27 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A93ED3F66E;
	Fri, 18 Jul 2025 02:03:26 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	anshuman.khandual@arm.com,
	peterx@redhat.com,
	joey.gouly@arm.com,
	ioworker0@gmail.com,
	baohua@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	hughd@google.com,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v5 4/7] mm: Introduce FPB_RESPECT_WRITE for PTE batching infrastructure
Date: Fri, 18 Jul 2025 14:32:41 +0530
Message-Id: <20250718090244.21092-5-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718090244.21092-1-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 6 optimizes mprotect() by batch clearing the ptes, masking in the new
protections, and batch setting the ptes. Suppose that the first pte
of the batch is writable - with the current implementation of
folio_pte_batch(), it is not guaranteed that the other ptes in the batch
are already writable too, so we may incorrectly end up setting the
writable bit on all ptes via modify_prot_commit_ptes().

Therefore, introduce FPB_RESPECT_WRITE so that all ptes in the batch
are writable or not.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/internal.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5b0f71e5434b..28d2d5b051df 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -208,17 +208,20 @@ typedef int __bitwise fpb_t;
 /* Compare PTEs respecting the soft-dirty bit. */
 #define FPB_RESPECT_SOFT_DIRTY		((__force fpb_t)BIT(1))
 
+/* Compare PTEs respecting the writable bit. */
+#define FPB_RESPECT_WRITE		((__force fpb_t)BIT(2))
+
 /*
  * Merge PTE write bits: if any PTE in the batch is writable, modify the
  * PTE at @ptentp to be writable.
  */
-#define FPB_MERGE_WRITE			((__force fpb_t)BIT(2))
+#define FPB_MERGE_WRITE			((__force fpb_t)BIT(3))
 
 /*
  * Merge PTE young and dirty bits: if any PTE in the batch is young or dirty,
  * modify the PTE at @ptentp to be young or dirty, respectively.
  */
-#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(3))
+#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(4))
 
 static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
 {
@@ -226,7 +229,9 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
 		pte = pte_mkclean(pte);
 	if (likely(!(flags & FPB_RESPECT_SOFT_DIRTY)))
 		pte = pte_clear_soft_dirty(pte);
-	return pte_wrprotect(pte_mkold(pte));
+	if (likely(!(flags & FPB_RESPECT_WRITE)))
+		pte = pte_wrprotect(pte);
+	return pte_mkold(pte);
 }
 
 /**
-- 
2.30.2


