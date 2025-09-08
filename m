Return-Path: <linux-kernel+bounces-805254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9AB4860B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4AC3B43CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2232E54D3;
	Mon,  8 Sep 2025 07:51:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12361925BC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317873; cv=none; b=RtBmdk2VTQnL2sqPTEP2eeOWlXtxj25TslB4wGhEm9zHyVS/KOShtZDPEzkNbCrrzIWzTYVbWDoZ3X1krahsez2TDF1H1zHuGHuxCOx9vmoHk3rvqj0/dp0GxYShHvRxdPrE8TC0i6cs3wkXttY8pd0EIN7XNZIvRh4GwXpa+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317873; c=relaxed/simple;
	bh=AMr9tSIiW0pm9GEQStKfofummy2PPI2G3G24bIrwHgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYj4QrkKgg+j9vST+qhlNo81E3N4VbTj6IQ2X6LQxSBnLzGk1Lgesrml+EIzQqxqk7znidDfNaMXXslbR5E/oDL/CA3OCIaaUyhr45dS57lnTYGK8aSqVRSndlW7J3PH1BkQXJVhEQa8usTma/tDHRRBehjH6R42KcXRLWomTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6E11692;
	Mon,  8 Sep 2025 00:51:02 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A843E3F63F;
	Mon,  8 Sep 2025 00:51:06 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	kas@kernel.org,
	willy@infradead.org,
	hughd@google.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	richard.weiyang@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/2] Expand scope of khugepaged anonymous collapse
Date: Mon,  8 Sep 2025 13:20:26 +0530
Message-Id: <20250908075028.38431-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently khugepaged does not collapse an anonymous region which does not
have a single writable pte. This is wasteful since a region mapped with
non-writable ptes, for example, non-writable VMAs mapped by the
application, won't benefit from THP collapse.

An additional consequence of this constraint is that MADV_COLLAPSE does not
perform a collapse on a non-writable VMA, and this restriction is nowhere
to be found on the manpage - the restriction itself sounds wrong to me
since the user knows the protection of the memory it has mapped, so
collapsing read-only memory via madvise() should be a choice of the
user which shouldn't be overridden by the kernel.

Therefore, remove this constraint.

On an arm64 bare metal machine, comparing with vanilla 6.17-rc2, an
average of 5% improvement is seen on some mmtests benchmarks,
particularly hackbench, with a maximum improvement of 12%. In the
following table, (I) denotes statistically significant improvement,
(R) denotes statistically significant regression.

+-------------------------+--------------------------------+---------------+
| mmtests/hackbench       | process-pipes-1 (seconds)      |        -0.06% |
|                         | process-pipes-4 (seconds)      |        -0.27% |
|                         | process-pipes-7 (seconds)      |   (I) -12.13% |
|                         | process-pipes-12 (seconds)     |    (I) -5.32% |
|                         | process-pipes-21 (seconds)     |    (I) -2.87% |
|                         | process-pipes-30 (seconds)     |    (I) -3.39% |
|                         | process-pipes-48 (seconds)     |    (I) -5.65% |
|                         | process-pipes-79 (seconds)     |    (I) -6.74% |
|                         | process-pipes-110 (seconds)    |    (I) -6.26% |
|                         | process-pipes-141 (seconds)    |    (I) -4.99% |
|                         | process-pipes-172 (seconds)    |    (I) -4.45% |
|                         | process-pipes-203 (seconds)    |    (I) -3.65% |
|                         | process-pipes-234 (seconds)    |    (I) -3.45% |
|                         | process-pipes-256 (seconds)    |    (I) -3.47% |
|                         | process-sockets-1 (seconds)    |         2.13% |
|                         | process-sockets-4 (seconds)    |         1.02% |
|                         | process-sockets-7 (seconds)    |        -0.26% |
|                         | process-sockets-12 (seconds)   |        -1.24% |
|                         | process-sockets-21 (seconds)   |         0.01% |
|                         | process-sockets-30 (seconds)   |        -0.15% |
|                         | process-sockets-48 (seconds)   |         0.15% |
|                         | process-sockets-79 (seconds)   |         1.45% |
|                         | process-sockets-110 (seconds)  |        -1.64% |
|                         | process-sockets-141 (seconds)  |    (I) -4.27% |
|                         | process-sockets-172 (seconds)  |         0.30% |
|                         | process-sockets-203 (seconds)  |        -1.71% |
|                         | process-sockets-234 (seconds)  |        -1.94% |
|                         | process-sockets-256 (seconds)  |        -0.71% |
|                         | thread-pipes-1 (seconds)       |         0.66% |
|                         | thread-pipes-4 (seconds)       |         1.66% |
|                         | thread-pipes-7 (seconds)       |        -0.17% |
|                         | thread-pipes-12 (seconds)      |    (I) -4.12% |
|                         | thread-pipes-21 (seconds)      |    (I) -2.13% |
|                         | thread-pipes-30 (seconds)      |    (I) -3.78% |
|                         | thread-pipes-48 (seconds)      |    (I) -5.77% |
|                         | thread-pipes-79 (seconds)      |    (I) -5.31% |
|                         | thread-pipes-110 (seconds)     |    (I) -6.12% |
|                         | thread-pipes-141 (seconds)     |    (I) -4.00% |
|                         | thread-pipes-172 (seconds)     |    (I) -3.01% |
|                         | thread-pipes-203 (seconds)     |    (I) -2.62% |
|                         | thread-pipes-234 (seconds)     |    (I) -2.00% |
|                         | thread-pipes-256 (seconds)     |    (I) -2.30% |
|                         | thread-sockets-1 (seconds)     |     (R) 2.39% |
+-------------------------+--------------------------------+---------------+

+-------------------------+------------------------------------------------+
| mmtests/sysbench-mutex  | sysbenchmutex-1 (usec)         |        -0.02% |
|                         | sysbenchmutex-4 (usec)         |        -0.02% |
|                         | sysbenchmutex-7 (usec)         |         0.00% |
|                         | sysbenchmutex-12 (usec)        |         0.12% |
|                         | sysbenchmutex-21 (usec)        |        -0.40% |
|                         | sysbenchmutex-30 (usec)        |         0.08% |
|                         | sysbenchmutex-48 (usec)        |         2.59% |
|                         | sysbenchmutex-79 (usec)        |        -0.80% |
|                         | sysbenchmutex-110 (usec)       |        -3.87% |
|                         | sysbenchmutex-128 (usec)       |    (I) -4.46% |
+-------------------------+--------------------------------+---------------+

---
Based on today's mm-new.

v1->v2:
- Replace non-writable VMAs with non-writable PTEs to be more specific
- Add cover letter

RFC->v1:
- Drop writable references from tracepoints

RFC:
- https://lore.kernel.org/all/20250901074817.73012-1-dev.jain@arm.com/

Dev Jain (2):
  mm: Enable khugepaged anonymous collapse on non-writable regions
  mm: Drop all references of writable and SCAN_PAGE_RO

 include/trace/events/huge_memory.h | 19 ++++++-------------
 mm/khugepaged.c                    | 23 +++++------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

-- 
2.30.2


