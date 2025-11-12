Return-Path: <linux-kernel+bounces-896575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E8DC50B46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600FB4EAA34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356932E718B;
	Wed, 12 Nov 2025 06:27:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC012E7182
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928859; cv=none; b=FNeBlct/OAe3g+NN9t9v8hqmPsqBkLzJ226BsKa8kMcAY3XQq+Lbyg0IKpq+fvmwvgJSa5noA1sK370pz+q9Tklka6bYUrW0Y746BgzgP4IPr1nq7zddLVdGjxEKjzqtkWK3nv1dqSMgNQtGdWvVoGXoGWkzTHTeOLa/HR1RhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928859; c=relaxed/simple;
	bh=//xwDxJGPkAJ9Y89CWiFQFsY8WI4ZLyZdRn+QVzwaKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9uJozTPrPDgr2rPlznAQSEoUxSH4FZieHJ1c4Aq6ntAOjovRhkyeD1SvwES1iRUgGe2yQZayGTiUjM/l6mI69G+KBaQ+U0x//tTlir7uvoyKkQY9KsYmjK26glTA7MFYUWJC7YepBv8xAlETJ9SeoBpdOZ28tFLEpGojC0560g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F4B1515;
	Tue, 11 Nov 2025 22:27:30 -0800 (PST)
Received: from MacBook-Pro.blr.arm.com.com (unknown [10.164.18.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6C543F5A1;
	Tue, 11 Nov 2025 22:27:34 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ryan.roberts@arm.com,
	rppt@kernel.org,
	shijie@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 2/2] arm64/mm: Document why linear map split failure upon vm_reset_perms is not problematic
Date: Wed, 12 Nov 2025 11:57:16 +0530
Message-Id: <20251112062716.64801-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251112062716.64801-1-dev.jain@arm.com>
References: <20251112062716.64801-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider the following code path:

(1) vmalloc -> (2) set_vm_flush_reset_perms -> (3) set_memory_ro/set_memory_rox
-> .... (4) use the mapping .... -> (5) vfree -> (6) vm_reset_perms
-> (7) set_area_direct_map.
Or, it may happen that we encounter failure at (3) and directly jump to (5).

In both cases, (7) may fail due to linear map split failure. But, we care
about its success *only* for the region which got successfully changed by
(3). Such a region is guaranteed to be pte-mapped.

The TLDR is that (7) will surely succeed for the regions we care about.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/pageattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index b4ea86cd3a71..dc05f06a47f2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -185,6 +185,15 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
+		/*
+		 * Note: One may wonder what happens if the calls to
+		 * set_area_direct_map() in vm_reset_perms() fail due ENOMEM on
+		 * linear map split failure. Observe that we care about those
+		 * calls to succeed *only* for the region whose permissions
+		 * are not default. Such a region is guaranteed to be
+		 * pte-mapped, because the below call can change those
+		 * permissions to non-default only after splitting that region.
+		 */
 		for (i = 0; i < area->nr_pages; i++) {
 			ret = __change_memory_common((u64)page_address(area->pages[i]),
 					       PAGE_SIZE, set_mask, clear_mask);
-- 
2.30.2


