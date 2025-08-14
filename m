Return-Path: <linux-kernel+bounces-768113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD65B25D12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF297ABE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC136263F5F;
	Thu, 14 Aug 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfmk3THY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5723A9AD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156271; cv=none; b=Y1U8b47PQz0AXDTbagVRdgPo3nLnAFsJ6ZKOusOxQpac6u7uafI17NcPIPC9OpOoKh2wOa/tXK466Isz88z292hPmn/5UxIuEcq458LH+GAyhNsdRgJJcMDckQhZz3MjW01oDlB/uRAEdegtTJmsYeqmXINKd1rNvfAM5I1g6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156271; c=relaxed/simple;
	bh=g+8cuxhTOlGQMxQ0dElv+Rq0Xre19vXaepdGVaB2vv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7J38b9wyX+SGAqPW20wMC/lszTWlh7WbxPfefrh9asRADv2oMLi70pQmx38cCvASY+bqGulEUqgmWtspKZDwe9ANOWJkKb6X1MZkgfrLR9LYoPvJLNwVOux0mFEClY6+jNjvKXl2feG7HM60g1/61dYG1mT8XnUU6Jeg7WZYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfmk3THY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755156267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIvfbzyT9Aegr3dWXVJ85T4HzEO+HdxXBmAclblXRsw=;
	b=Cfmk3THYZiOCOCmZcHx/xCxYfywnHzsGNwZgqjw7aIHZr7shhYHOKToii8CubHxSHABVAS
	9Fk7wI2hzCpzA73CYMY++FKx5n3DEs/pFV8VCWHg6T1I3qL/nRubRfvdxZQ9gwLzoADtTE
	1mu/DbIFEQ2jn9cojLPgi649p0M6H4E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-jjQ1yPEiOCOeDPK9zD3grQ-1; Thu, 14 Aug 2025 03:24:25 -0400
X-MC-Unique: jjQ1yPEiOCOeDPK9zD3grQ-1
X-Mimecast-MFC-AGG-ID: jjQ1yPEiOCOeDPK9zD3grQ_1755156264
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-333f9150cedso2510341fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156264; x=1755761064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIvfbzyT9Aegr3dWXVJ85T4HzEO+HdxXBmAclblXRsw=;
        b=oUjGhhsnsd+Z/YkNA+hiTfSmVy/NtH7PqKQWOYEpNKuT/70dtCjbIFIRT9unsX4Evr
         onXDUOQwT2gorRMHxwyx5vqOiwA5m1LuEt8VqMmCGlKe+3ehcAzchipDtxYO07kROjUK
         MIF/J1N5IDSJlsMaPzVSOtjeX3FeFfet8sIeLtfurgo8lWX3uCQGEqfjN7gMcAt2qsm+
         Nj4xuPoqH496b2FLCb3KrGDDCqGAbnkiW2zpMe441XgZjPqvHYmEJRiFE6Mz81NRZYMb
         7Gc2k4M8CtQTfxmN57zrn0cDAoYGNNXCNa3KoO5kyQklTxfN6apXfiqUekC/fqv9Twdw
         ZPtw==
X-Gm-Message-State: AOJu0YzrzQZ+ML8SKDc56yx3hwF26BgT5mgwwGN05qvSxCTAlK2x2Kk0
	/0Qsa9l2Q67DKmnZR1RTdz9bdqS6edm6PG2/MVLlig/LYXhJ9aeMhCpOq1ZQCX7RRird5a4jwxV
	Vy/tfuTl5qmFgW3MYcN59X52mRWti4lwCUtKFPCo08tLt8/nb7QPTotckh2dQNn9E
X-Gm-Gg: ASbGncvmMzCRg2bY4EcByO3X4xwBULy1QctgI15NEa0o/yfy4MPFtoV9LaKL5W9ac4u
	p3fIW2Woy3/uukoCVsvOAN9okGCIfcjB5E/q6IK+3pHk+VNRc7vD+9Ga2KAVEX8Fmf2nn5PghM2
	DXtbLzCLkchQ0cJ60HXlbkoIIu6TLLUzEfkwMvWNaQcNSWdaaTtFIHGi1SQhi4XHFDXoC++CiHF
	y+982dnVakritQBFM8p0VQdS1QzqaDfKHhEAzH9BIIwShUAO5RZczvISH9kEdj03migO0Hz/do/
	j1nIOVMB30gK1zTlKyjGF7Zn16fznNeF8ALsl6YBmnObiS9tMnCTTog=
X-Received: by 2002:a05:6512:15a5:b0:55b:7c34:2b95 with SMTP id 2adb3069b0e04-55ce5045da9mr796976e87.20.1755156264156;
        Thu, 14 Aug 2025 00:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtIPuBiMFY0ZIY9glLmcyHL2YD88jMmKDvw3Qwgo8mPRFe+d1e9BQ4g3jqn4rV/aPKZsRSdQ==
X-Received: by 2002:a05:6512:15a5:b0:55b:7c34:2b95 with SMTP id 2adb3069b0e04-55ce5045da9mr796971e87.20.1755156263663;
        Thu, 14 Aug 2025 00:24:23 -0700 (PDT)
Received: from fedora (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b887f72f4sm5620240e87.0.2025.08.14.00.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:24:23 -0700 (PDT)
From: =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
Date: Thu, 14 Aug 2025 10:19:26 +0300
Message-ID: <20250814072045.3637192-3-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250814072045.3637192-1-mpenttil@redhat.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When doing migration in combination with device fault handling,
detect the case in the interval notifier.

Without that, we would livelock with our own invalidations
while migrating and splitting pages during fault handling.

Note, pgmap_owner, used in some other code paths as owner for filtering,
is not readily available for split path, so use current for this use case.
Also, current and pgmap_owner, both being pointers to memory, can not be
mis-interpreted to each other.

Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 lib/test_hmm.c   | 5 +++++
 mm/huge_memory.c | 6 +++---
 mm/rmap.c        | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 761725bc713c..cd5c139213be 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
 	    range->owner == dmirror->mdevice)
 		return true;
 
+	if (range->event == MMU_NOTIFY_CLEAR &&
+	    range->owner == current) {
+		return true;
+	}
+
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&dmirror->mutex);
 	else if (!mutex_trylock(&dmirror->mutex))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f09..276e38dd8f68 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3069,9 +3069,9 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
-				address & HPAGE_PMD_MASK,
-				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
+	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
+				      address & HPAGE_PMD_MASK,
+				      (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE, current);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pmd_lock(vma->vm_mm, pmd);
 	split_huge_pmd_locked(vma, range.start, pmd, freeze);
diff --git a/mm/rmap.c b/mm/rmap.c
index f93ce27132ab..e7829015a40b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2308,8 +2308,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	 * try_to_unmap() must hold a reference on the page.
 	 */
 	range.end = vma_address_end(&pvmw);
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
-				address, range.end);
+	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
+				      address, range.end, current);
 	if (folio_test_hugetlb(folio)) {
 		/*
 		 * If sharing is possible, start and end will be adjusted
-- 
2.50.0


