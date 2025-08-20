Return-Path: <linux-kernel+bounces-777264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04333B2D787
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A378C4E72B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224E2DA769;
	Wed, 20 Aug 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IK7edZBw"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85B18991E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680864; cv=none; b=VAqYfcZNAsNIGoGWdwmLAtpJNO3flJLU4Y2dPFEra4rJQtOcsmSyUa5YUEYoPkI+TzObfhbXlbC9/0F8WxrghFu1BModb3IO1pnvBf//s+U9GdzQrADLtU646ZCRh9CUklAwhEmaNAyZDPqodKbFooGayc/Wg3WctFWofc1TvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680864; c=relaxed/simple;
	bh=//QsdE7OPpcCMYDo8ixRe1OSOVosgH95wSSfFKANKKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tr4mhv8wBx1aN24IfHmu4GEt7OIsarxfOfF49mBbteK6Votu140wOTMGH9Eu9FeIc+cbZUQS5ASz/toDIBtxOTe+S5A47Wuz85e4OHoevdZB0R2yPpDD/0+nc5PGWB9Na3tCMpNUpYJowsOqqqldphgPNaf510Z7bGi0uddOQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IK7edZBw; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680853; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LaVLdCXndmYsJn6b1HROP2zqjNIw7pnHQe3ZO2d5Rxg=;
	b=IK7edZBwW1WP0nEEEKPpPan9g6A7MV8V9EdSRmoA5h97az5wPfFuMSQlhQY/975aTFMh+ha5YWIeGMaBaHx4ws7yc9YCzsPngkISX9rYrZsSoJb6uVu4LCmMVFeGi+VielhoM6IjAsqQ3hup+SYy89VArXP1bIHZ2dl3wa6xCCs=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBXj3i_1755680852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:32 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/11] add shmem mTHP collapse support
Date: Wed, 20 Aug 2025 17:07:11 +0800
Message-ID: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on mm/mm-new from today.

This is a follow-up patchset for mTHP collapse to support shmem (or file pages)
mTHP collapse, which is based on Nico's patchset [1].

The strategy for shmem/file mTHP collapse follows the anonymous mTHP collapse,
which is, quoting from Nico:

"while scanning PMD ranges for potential collapse candidates, keep
track of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER PTEs.

After the scan is complete, we will perform binary recursion on the bitmap
to determine which mTHP size would be most efficient to collapse to. The
'max_ptes_none' will be scaled by the attempted collapse order to determine
how full a THP must be to be eligible.
"

Moreover, to facilitate the scanning of shmem/file folios, extend the
'cc->mthp_bitmap_temp' bitmap to record whether each index within the
PMD range corresponds to a present page, and then this temp bitmap is used
to determine whether each chunk should be marked as present for mTHP
collapse.

Currently, the collapse_pte_mapped_thp() does not build the mapping for mTHP.
Cause we still expect to establish the mTHP mapping via refault under the
control of fault_around. So collapse_pte_mapped_thp() remains responsible
only for building the mapping for PMD-sized THP, which is reasonable and
makes life easier.

In addition, I have added mTHP collapse selftests, and now all khugepaged
test cases can pass.

[1] https://lore.kernel.org/all/20250819134205.622806-1-npache@redhat.com/

Baolin Wang (11):
  mm: khugepaged: add khugepaged_max_ptes_none check in collapse_file()
  mm: khugepaged: generalize collapse_file for mTHP support
  mm: khugepaged: add an order check for THP statistics
  mm: khugepaged: add shmem/file mTHP collapse support
  mm: shmem: kick khugepaged for enabling none-PMD-sized shmem mTHPs
  mm: khugepaged: allow khugepaged to check all shmem/file large orders
  mm: khugepaged: skip large folios that don't need to be collapsed
  selftests:mm: extend the check_huge() to support mTHP check
  selftests: mm: move gather_after_split_folio_orders() into vm_util.c
    file
  selftests: mm: implement the mTHP hugepage check helper
  selftests: mm: add mTHP collapse test cases

 include/linux/shmem_fs.h                      |   4 +-
 mm/khugepaged.c                               | 177 +++++++++++++----
 mm/shmem.c                                    |  10 +-
 tools/testing/selftests/mm/khugepaged.c       | 162 ++++++++++++----
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 .../selftests/mm/split_huge_page_test.c       | 135 +------------
 tools/testing/selftests/mm/uffd-common.c      |   4 +-
 tools/testing/selftests/mm/vm_util.c          | 179 +++++++++++++++++-
 tools/testing/selftests/mm/vm_util.h          |   6 +-
 9 files changed, 455 insertions(+), 226 deletions(-)

-- 
2.43.5


