Return-Path: <linux-kernel+bounces-865731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A5BFDE18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A83F3A8D44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DC34D4FE;
	Wed, 22 Oct 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdxowlwz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0934D4F8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158315; cv=none; b=DM2GJbI1lc0VlU+r5SOe9emVcNoeeTPfwSAW1jU9QvW3JvwhRsgQuOQEKqJ+KC5dGo151kG7OJ0mrCoDTHtU28bymceIxRb7OknwWi2WEUbzqaXi32q4+c996Giy0+1fs7PXjXx6qu7RfopFNfkd/OEnJtbnUpJCZqN3TvjtZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158315; c=relaxed/simple;
	bh=fl1WQo5E/YjxGfFqNhLuYJqNkMvOHJQ1ANYx17j/Iao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PESgSR4CmidDhXCkflzN+NF8lIGBQLZLZqrNZ8JJgr8ozRI/nTSyP7OEhvJ53zNNCkptof6hc4XY2Lf7tI16s9EvMWJd98nby2ixHMeaQ+/r56Sqjw6B9rlYz3YzYvOBscnKItIQyKAdh6L+2GWUyygMLLyLzH54/yk4vSp4c2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdxowlwz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sGrCfbpJbLZ7HRMa9iPXf+hCVuEsHMIDx0PfwK6yFh0=;
	b=MdxowlwzvWwphTTpNcg33TQdvZ+UIQJq7P7dphnKrCMClBf54UFq6sk7erFgsBMe9QEsqM
	sm8hPlmB2s5fHVQVKgtCF0+eNng6QKfogFolmzdxU8Rz2OveQUnLyCQLO2DMzaTCEeCoho
	zdUEGKjEHtfKE09ioQ7MEiY8P+4+pEw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-1eKGJ1J5OM-DligeSKwWCQ-1; Wed,
 22 Oct 2025 14:38:27 -0400
X-MC-Unique: 1eKGJ1J5OM-DligeSKwWCQ-1
X-Mimecast-MFC-AGG-ID: 1eKGJ1J5OM-DligeSKwWCQ_1761158300
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE2418002C9;
	Wed, 22 Oct 2025 18:38:15 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1EB219560A2;
	Wed, 22 Oct 2025 18:38:02 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kas@kernel.org,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org,
	hughd@google.com,
	richard.weiyang@gmail.com,
	lance.yang@linux.dev,
	vbabka@suse.cz,
	rppt@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Subject: [PATCH v12 mm-new 00/15] khugepaged: mTHP support
Date: Wed, 22 Oct 2025 12:37:02 -0600
Message-ID: <20251022183717.70829-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The following series provides khugepaged with the capability to collapse
anonymous memory regions to mTHPs.

To achieve this we generalize the khugepaged functions to no longer depend
on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
pages that are occupied (!none/zero). After the PMD scan is done, we do
binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
range. The restriction on max_ptes_none is removed during the scan, to make
sure we account for the whole PMD range. When no mTHP size is enabled, the
legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
by the attempted collapse order to determine how full a mTHP must be to be
eligible for the collapse to occur. If a mTHP collapse is attempted, but
contains swapped out, or shared pages, we don't perform the collapse. It is
now also possible to collapse to mTHPs without requiring the PMD THP size
to be enabled.

When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
mTHP collapses to prevent collapse "creep" behavior. This prevents
constantly promoting mTHPs to the next available size, which would occur
because a collapse introduces more non-zero pages that would satisfy the
promotion condition on subsequent scans.

Patch 1:     Refactor/rename hpage_collapse
Patch 2:     Refactoring to combine madvise_collapse and khugepaged
Patch 3-7:   Generalize khugepaged functions for arbitrary orders
Patch 8:     skip collapsing mTHP to smaller orders
Patch 9-10:  Add per-order mTHP statistics and tracepoints
Patch 11:    Introduce collapse_allowable_orders
Patch 12-14: Introduce bitmap and mTHP collapse support
Patch 15:    Documentation

---------
 Testing
---------
- Built for x86_64, aarch64, ppc64le, and s390x
- selftests mm
- I created a test script that I used to push khugepaged to its limits
   while monitoring a number of stats and tracepoints. The code is
   available here[1] (Run in legacy mode for these changes and set mthp
   sizes to inherit)
   The summary from my testings was that there was no significant
   regression noticed through this test. In some cases my changes had
   better collapse latencies, and was able to scan more pages in the same
   amount of time/work, but for the most part the results were consistent.
- redis testing. I tested these changes along with my defer changes
  (see followup [2] post for more details). We've decided to get the mTHP
  changes merged first before attempting the defer series.
- some basic testing on 64k page size.
- lots of general use.

V12 Changes:
- variable cleanups & minor nits
- Documentation updates to be less specific about the internal workings
- Added Review by Baolin (thanks!)
- Improved readability of the collapse_max_ptes_none function
- Improved collapse_scan_pmd max_ptes_none logic using the helper

V11: https://lore.kernel.org/lkml/20250912032810.197475-1-npache@redhat.com/
V10: https://lore.kernel.org/lkml/20250819134205.622806-1-npache@redhat.com/
V9 : https://lore.kernel.org/lkml/20250714003207.113275-1-npache@redhat.com/
V8 : https://lore.kernel.org/lkml/20250702055742.102808-1-npache@redhat.com/
V7 : https://lore.kernel.org/lkml/20250515032226.128900-1-npache@redhat.com/
V6 : https://lore.kernel.org/lkml/20250515030312.125567-1-npache@redhat.com/
V5 : https://lore.kernel.org/lkml/20250428181218.85925-1-npache@redhat.com/
V4 : https://lore.kernel.org/lkml/20250417000238.74567-1-npache@redhat.com/
V3 : https://lore.kernel.org/lkml/20250414220557.35388-1-npache@redhat.com/
V2 : https://lore.kernel.org/lkml/20250211003028.213461-1-npache@redhat.com/
V1 : https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat.com/

A big thanks to everyone that has reviewed, tested, and participated in
the development process. Its been a great experience working with all of
you on this endeavour.

[1] - https://gitlab.com/npache/khugepaged_mthp_test
[2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/

Baolin Wang (1):
  khugepaged: run khugepaged for all orders

Dev Jain (1):
  khugepaged: generalize alloc_charge_folio()

Nico Pache (13):
  khugepaged: rename hpage_collapse_* to collapse_*
  introduce collapse_single_pmd to unify khugepaged and madvise_collapse
  khugepaged: generalize hugepage_vma_revalidate for mTHP support
  khugepaged: generalize __collapse_huge_page_* for mTHP support
  khugepaged: introduce collapse_max_ptes_none helper function
  khugepaged: generalize collapse_huge_page for mTHP collapse
  khugepaged: skip collapsing mTHP to smaller orders
  khugepaged: add per-order mTHP collapse failure statistics
  khugepaged: improve tracepoints for mTHP orders
  khugepaged: introduce collapse_allowable_orders helper function
  khugepaged: Introduce mTHP collapse support
  khugepaged: avoid unnecessary mTHP collapse attempts
  Documentation: mm: update the admin guide for mTHP collapse

 Documentation/admin-guide/mm/transhuge.rst |  84 ++-
 include/linux/huge_mm.h                    |   5 +
 include/linux/khugepaged.h                 |   2 +
 include/trace/events/huge_memory.h         |  34 +-
 mm/huge_memory.c                           |  11 +
 mm/khugepaged.c                            | 614 +++++++++++++++------
 mm/mremap.c                                |   2 +-
 7 files changed, 539 insertions(+), 213 deletions(-)

-- 
2.51.0


