Return-Path: <linux-kernel+bounces-842590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8447BBD162
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69B7734889D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4165246760;
	Mon,  6 Oct 2025 05:52:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79733EEA8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759729944; cv=none; b=fKF3dev4T1AeNMdB1nX/S6fq4pTL1hlZ3g7DawVxEfKBykZXxaEdcNOrqltws4QaD5DkuVsYd2uGYJrqfVdudelbYayVXfXOb5F/z5rvnqv8bEifkXAYZNWi3R6qlUAu04JMv6Id5SRd1ql3GnXfqBk7BTFBtHntqGX2l5C0ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759729944; c=relaxed/simple;
	bh=qY3qCRDZ7NEOGKCtGNtjypd/KmSsT/S+ooPu525NMd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CotLakFZ7Ty+OXrZ8AgCBCg6Jo1m6smV+fdfNP2FBnEg7ZyEtFOpVa3nTN4OXy/TnPzXMqeRsbBS7YaiA1mnZtF33N2Z/vCdqK5YQ883IM+mFgMsAJxoMg1sWg0GIFFKVL+Z3Lk1x7sbn3RjyhgWSFB+ltPIm76RMoqsx3X+CRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8086C1424;
	Sun,  5 Oct 2025 22:52:12 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B84B3F59E;
	Sun,  5 Oct 2025 22:52:19 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
Date: Mon,  6 Oct 2025 06:52:14 +0100
Message-Id: <20251006055214.1845342-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
anyways defaults into READ_ONCE() in cases where platform does not override

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mapping_dirty_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index c193de6cb23a..737c407f4081 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	pud_t pudval = READ_ONCE(*pud);
+	pud_t pudval = pudp_get(pud);
 
 	/* Do not split a huge pud */
 	if (pud_trans_huge(pudval)) {
-- 
2.30.2


