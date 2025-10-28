Return-Path: <linux-kernel+bounces-873903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB16C1506D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8416189742E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8E226CF9;
	Tue, 28 Oct 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tv6x6GDA"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F12D3EDE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660128; cv=none; b=JxgHF5Gk8FO+ETjwZlKthZWdSOEd/xWTj6PfRu+2Q1ZgPAJAX3H3vGHQi4CDFHxfOTnye9qKV4rzG/WupldoMQBLkV8o3TrVOcPxwCX4ycZX6LCQf3QCLLvmPnZv0leREKuXuwFgK+Kbf9SKI98uPQhkRA9eF85CpormHWWHbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660128; c=relaxed/simple;
	bh=ooW75H3+SHCpn0lkn6GMdTyVIqxWbZ5VXGcIqrRC97U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJzgP3PzS3dTDIzED+fhNfnrtkHvXOzW69mnaZFh/HpmwFdH/Zx6UdRqA/i1eHCNawlJUD7dFs5yykq9osduGqDThbfDr+5/nJeNU8fZOmfWMoGI/I3azD/70nAwvBwPPdlqwqIiqcqNMfbO8P4HAGQ22n6vGyy825xl1mshFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tv6x6GDA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8HLDo8n6coWUrWdqlQjN8qAiPeJQK26USUMmC8y9OKQ=;
	b=Tv6x6GDAu6ty+Y6P8qlVzDiLQ+tdMFZ85wcxZ9qX6iiFWS45iB+Kt4UVSDQZ3CRi6wczLH
	oaPoIRqMaIdEzYwyyNDfYz76VUSwt+xk2zKcS/ug38emiAeNnfsuzEisrQ2i5P5VbVkVvh
	gV18JBY4odaD6/ihxL5yuVChikMG1KQ=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 00/26] Eliminate Dying Memory Cgroup
Date: Tue, 28 Oct 2025 21:58:13 +0800
Message-ID: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Hi all,

This series aims to eliminate the problem of dying memory cgroup. It completes
the adaptation to the MGLRU scenarios based on the Muchun Song's patchset[1].

The adaptation method was discussed with Harry Yoo. For more details, please
refer to the commit message of [PATCH v1 23/26].

The changes are as follows:
 - drop [PATCH RFC 02/28]
 - drop THP split queue related part, which has been merged as a separate
   patchset[2]
 - prevent memory cgroup release in folio_split_queue_lock{_irqsave}() in
   [PATCH v1 16/26]
 - Separate the reparenting function of traditional LRU folios to [PATCH v1 22/26]
 - adapted to the MGLRU scenarios in [PATCH v1 23/26]
 - refactor memcg_reparent_objcgs() in [PATCH v1 24/26]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20251028

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20250415024532.26632-1-songmuchun@bytedance.com/
[2]. https://lore.kernel.org/all/cover.1760509767.git.zhengqi.arch@bytedance.com

Muchun Song (22):
  mm: memcontrol: remove dead code of checking parent memory cgroup
  mm: workingset: use folio_lruvec() in workingset_refault()
  mm: rename unlock_page_lruvec_irq and its variants
  mm: vmscan: refactor move_folios_to_lru()
  mm: memcontrol: allocate object cgroup for non-kmem case
  mm: memcontrol: return root object cgroup for root memory cgroup
  mm: memcontrol: prevent memory cgroup release in
    get_mem_cgroup_from_folio()
  buffer: prevent memory cgroup release in folio_alloc_buffers()
  writeback: prevent memory cgroup release in writeback module
  mm: memcontrol: prevent memory cgroup release in
    count_memcg_folio_events()
  mm: page_io: prevent memory cgroup release in page_io module
  mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
  mm: mglru: prevent memory cgroup release in mglru
  mm: memcontrol: prevent memory cgroup release in
    mem_cgroup_swap_full()
  mm: workingset: prevent memory cgroup release in lru_gen_eviction()
  mm: workingset: prevent lruvec release in workingset_refault()
  mm: zswap: prevent lruvec release in zswap_folio_swapin()
  mm: swap: prevent lruvec release in swap module
  mm: workingset: prevent lruvec release in workingset_activation()
  mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
  mm: memcontrol: eliminate the problem of dying memory cgroup for LRU
    folios
  mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers

Qi Zheng (4):
  mm: thp: prevent memory cgroup release in
    folio_split_queue_lock{_irqsave}()
  mm: vmscan: prepare for reparenting traditional LRU folios
  mm: vmscan: prepare for reparenting MGLRU folios
  mm: memcontrol: refactor memcg_reparent_objcgs()

 fs/buffer.c                      |   4 +-
 fs/fs-writeback.c                |  22 +-
 include/linux/memcontrol.h       | 159 ++++++------
 include/linux/mm_inline.h        |   6 +
 include/linux/mmzone.h           |  20 ++
 include/trace/events/writeback.h |   3 +
 mm/compaction.c                  |  43 +++-
 mm/huge_memory.c                 |  18 +-
 mm/memcontrol-v1.c               |  15 +-
 mm/memcontrol.c                  | 405 ++++++++++++++++++-------------
 mm/migrate.c                     |   2 +
 mm/mlock.c                       |   2 +-
 mm/page_io.c                     |   8 +-
 mm/percpu.c                      |   2 +-
 mm/shrinker.c                    |   6 +-
 mm/swap.c                        |  20 +-
 mm/vmscan.c                      | 198 ++++++++++++---
 mm/workingset.c                  |  26 +-
 mm/zswap.c                       |   2 +
 19 files changed, 612 insertions(+), 349 deletions(-)

-- 
2.20.1


