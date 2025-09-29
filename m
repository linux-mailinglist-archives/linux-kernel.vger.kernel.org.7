Return-Path: <linux-kernel+bounces-836260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F0BA9225
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C17177D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48B30497C;
	Mon, 29 Sep 2025 12:01:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14701D90DD;
	Mon, 29 Sep 2025 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147260; cv=none; b=s9B2TaDaQvFl1LTyIsMM2TtvIb9RfWZZ4s98rtnj2wk50W+MzgU9Tybf8so3s6hXwcGERY0S9JlPWFxYAi6VxnkLM24qK/QPi0VDZ4ERrKW+m2Efqv+EzjuLCMl2Uq0InTkPOutRXRp/aNBTCaGwx1YGqI70zfBBasfGykzIMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147260; c=relaxed/simple;
	bh=hFQflsCJnGv46xmDE7wImt9MOVzgtPaInbridFqhIhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qq7uAsuQ/TN9pSP4nXZX76M4oCzOaRArqwpdsqfQjPmZPJ7CvYRN5KmpHkfpmV+zlntQUEmypBB5w8MVmOajoiB12fCWVkfhVpDEgCvPo2ToBfElnsMQ45DfjS4BQhDVux0UYaWoQeiSiIrxW9gNaw5wdfIFAqsXbXm3rpSA/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BE7150C;
	Mon, 29 Sep 2025 05:00:47 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9229F3F66E;
	Mon, 29 Sep 2025 05:00:54 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/mm: Drop pxx_mkdevmap() descriptions from page table helpers
Date: Mon, 29 Sep 2025 13:00:45 +0100
Message-Id: <20250929120045.1109707-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove pxx_mkdevmap() descriptions, as these helper functions have already
been dropped (including DEBUG_VM_PGTABLE test) via the commit d438d2734170
("mm: remove devmap related functions and page table bits").

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/mm/arch_pgtable_helpers.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index ba2f658bc241..2447b8a4b08c 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -52,8 +52,6 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mkspecial             | Creates a special PTE                            |
 +---------------------------+--------------------------------------------------+
-| pte_mkdevmap              | Creates a ZONE_DEVICE mapped PTE                 |
-+---------------------------+--------------------------------------------------+
 | pte_mksoft_dirty          | Creates a soft dirty PTE                         |
 +---------------------------+--------------------------------------------------+
 | pte_clear_soft_dirty      | Clears a soft dirty PTE                          |
@@ -124,8 +122,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_mkspecial             | Creates a special PMD                            |
 +---------------------------+--------------------------------------------------+
-| pmd_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
-+---------------------------+--------------------------------------------------+
 | pmd_mksoft_dirty          | Creates a soft dirty PMD                         |
 +---------------------------+--------------------------------------------------+
 | pmd_clear_soft_dirty      | Clears a soft dirty PMD                          |
@@ -185,8 +181,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_wrprotect             | Creates a write protected PUD                    |
 +---------------------------+--------------------------------------------------+
-| pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
-+---------------------------+--------------------------------------------------+
 | pud_mkinvalid             | Invalidates a present PUD; do not call for       |
 |                           | non-present PUD [1]                              |
 +---------------------------+--------------------------------------------------+
-- 
2.30.2


