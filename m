Return-Path: <linux-kernel+bounces-882675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEDC2B1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11ED74F4A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C42FE59F;
	Mon,  3 Nov 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joNaDF4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F412F39BC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166224; cv=none; b=pcRGZNWwyJaCRWiZMYXP2c6OpYED4pf3SzB/lImn2aYpwWYD4YS4rBcVvg+ZNAwQCCHRkMRRfqNtMOz/y/AdSVKFYJA9FkhZOTa+z8zEw0/uWs6HwUW/Uy+P2q3CkcSWDC3LOoI00A7+bN2T7BsIdu/FsFhT3pblpiif/xaKXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166224; c=relaxed/simple;
	bh=xY+/s+hLaz9F/EIwMEgitt4SB21wgz8sW68OqqlFqMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/04n5HKyyXEsFSsqXyDpfv1DDv24AT6oAH6uYnjvXUtfoJwDXpgHNS6YMf7f7eC0sCVryRvMTr4Tjb43YL3MTar7QgkpDfJDsH3qJDtJbBIGV5DPtgtPHp6t5vyxAD3vSMbtaqnvmIQnc6ACQQ0LxZXRLkyRKfpWRWuDHu3W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joNaDF4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0420C4CEF8;
	Mon,  3 Nov 2025 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166222;
	bh=xY+/s+hLaz9F/EIwMEgitt4SB21wgz8sW68OqqlFqMA=;
	h=From:To:Cc:Subject:Date:From;
	b=joNaDF4ulJleKSXAaHBaIr8oME3ENnhvOgwZr02q+6THT1uwBN7v8Z9RpTDL4qRR1
	 mEVe/T3eht8Q1reY+YrS+e/Ge7XR5pSj6mQEzRyToXSuuU7Qm9KyM0ldkZ7fIsZhbU
	 zbzqsFK5WnlqQkRVBiD8jQ97drgIxHmhclOzZdaHjmZzW+yRdhMhtuKqNSV8JOieJa
	 n0z6L9taxSKSPixV2jdRNnmXj/W9zFlRBn97OsNKKWgAiiASeRSSFBahioN/8kOmZ0
	 Rl1ATYg6IkzF4J2strnoNdJHypO0wrjI0Ld0cEpkGDJ8Vclzjfo2cGE8/18SPyiStO
	 fmZrFt1CeCxvw==
From: David Hildenbrand <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH] MAINTAINERS: Update David Hildenbrand's email address
Date: Mon,  3 Nov 2025 11:36:59 +0100
Message-ID: <20251103103659.379335-1-david@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

Switch to kernel.org email address as I will be leaving Red Hat. The
old address will remain active until end of January 2026, so performing
the change now should make sure that most mails will reach me.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/.mailmap b/.mailmap
index 369cfe467932d..a14166f834a41 100644
--- a/.mailmap
+++ b/.mailmap
@@ -206,6 +206,7 @@ Danilo Krummrich <dakr@kernel.org> <dakr@redhat.com>
 David Brownell <david-b@pacbell.net>
 David Collins <quic_collinsd@quicinc.com> <collinsd@codeaurora.org>
 David Heidelberg <david@ixit.cz> <d.okias@gmail.com>
+David Hildenbrand <david@kernel.org> <david@redhat.com>
 David Rheinsberg <david@readahead.eu> <dh.herrmann@gmail.com>
 David Rheinsberg <david@readahead.eu> <dh.herrmann@googlemail.com>
 David Rheinsberg <david@readahead.eu> <david.rheinsberg@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e0330421..091a0f8e49667 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11525,7 +11525,7 @@ F:	include/linux/platform_data/huawei-gaokun-ec.h
 HUGETLB SUBSYSTEM
 M:	Muchun Song <muchun.song@linux.dev>
 M:	Oscar Salvador <osalvador@suse.de>
-R:	David Hildenbrand <david@redhat.com>
+R:	David Hildenbrand <david@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
@@ -13730,7 +13730,7 @@ KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@linux.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 M:	Claudio Imbrenda <imbrenda@linux.ibm.com>
-R:	David Hildenbrand <david@redhat.com>
+R:	David Hildenbrand <david@kernel.org>
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
@@ -16217,7 +16217,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 F:	drivers/devfreq/tegra30-devfreq.c
 
 MEMORY HOT(UN)PLUG
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 M:	Oscar Salvador <osalvador@suse.de>
 L:	linux-mm@kvack.org
 S:	Maintained
@@ -16242,7 +16242,7 @@ F:	tools/mm/
 
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
@@ -16298,7 +16298,7 @@ F:	mm/execmem.c
 
 MEMORY MANAGEMENT - GUP (GET USER PAGES)
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Jason Gunthorpe <jgg@nvidia.com>
 R:	John Hubbard <jhubbard@nvidia.com>
 R:	Peter Xu <peterx@redhat.com>
@@ -16314,7 +16314,7 @@ F:	tools/testing/selftests/mm/gup_test.c
 
 MEMORY MANAGEMENT - KSM (Kernel Samepage Merging)
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Xu Xin <xu.xin16@zte.com.cn>
 R:	Chengming Zhou <chengming.zhou@linux.dev>
 L:	linux-mm@kvack.org
@@ -16330,7 +16330,7 @@ F:	mm/mm_slot.h
 
 MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Zi Yan <ziy@nvidia.com>
 R:	Matthew Brost <matthew.brost@intel.com>
 R:	Joshua Hahn <joshua.hahnjy@gmail.com>
@@ -16370,7 +16370,7 @@ F:	mm/workingset.c
 
 MEMORY MANAGEMENT - MISC
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
@@ -16458,7 +16458,7 @@ F:	mm/shuffle.h
 MEMORY MANAGEMENT - RECLAIM
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Johannes Weiner <hannes@cmpxchg.org>
-R:	David Hildenbrand <david@redhat.com>
+R:	David Hildenbrand <david@kernel.org>
 R:	Michal Hocko <mhocko@kernel.org>
 R:	Qi Zheng <zhengqi.arch@bytedance.com>
 R:	Shakeel Butt <shakeel.butt@linux.dev>
@@ -16471,7 +16471,7 @@ F:	mm/workingset.c
 
 MEMORY MANAGEMENT - RMAP (REVERSE MAPPING)
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Rik van Riel <riel@surriel.com>
 R:	Liam R. Howlett <Liam.Howlett@oracle.com>
@@ -16516,7 +16516,7 @@ F:	mm/swapfile.c
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Zi Yan <ziy@nvidia.com>
 R:	Baolin Wang <baolin.wang@linux.alibaba.com>
@@ -16618,7 +16618,7 @@ MEMORY MAPPING - MADVISE (MEMORY ADVICE)
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 R:	Vlastimil Babka <vbabka@suse.cz>
 R:	Jann Horn <jannh@google.com>
 L:	linux-mm@kvack.org
@@ -27084,7 +27084,7 @@ F:	net/vmw_vsock/virtio_transport_common.c
 
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
@@ -27239,7 +27239,7 @@ F:	drivers/iommu/virtio-iommu.c
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-M:	David Hildenbrand <david@redhat.com>
+M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 W:	https://virtio-mem.gitlab.io/

base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.0


