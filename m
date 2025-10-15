Return-Path: <linux-kernel+bounces-853846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E53BDCC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C2353C46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2093126BE;
	Wed, 15 Oct 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gW1ZJQJZ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516EA306D48
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510168; cv=none; b=ECom1PqZJaWxBQd4h6c2t3szL1e52Vg2cx0GieuoIt8JC3QybGmSaNp7mCTrBaGAwoNHZtXClxV2pB1Bg7yq8rfSbNlREpIJWo7LUwRvXIpHOXtYfg9S8jdB8uNaXQjkcHo6At8dp+K1N4YqeQaXJKqTkQO73RI7GXx6YslAK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510168; c=relaxed/simple;
	bh=+rolIgnycTbfH3J5sR3JWWLXD7fBOZGNO3IAA6MdFUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MX/zwCxbid7qCRKcM8PiSRZe67ReA8JDdGnwVUdqWl0ZqH0YzrKVwVY3mA7b4AeufdQHh/e1yaqvUIFERERMw4BcuHQSFhI2wbAt+UULGil4bXddNlUChGCXy3HtlKWVvKHWEIgulkXsyeBuRA9EaerSU/oJZMmEVFdm5Xo6ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gW1ZJQJZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760510160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=chYLFKHOenLcAoAbuxLeK+xLyqa/SWaDhpi/ROUy1lk=;
	b=gW1ZJQJZl6v8GMrG3KfidtB039hu4hUhUhzri0l/yhaXnna1qQidZc0XD/jGRYbFQtRCzw
	aB9eQg0iDSgvjDMbpeQuRMWioTMBQ5BV9CMA/jtqZyesZZxFbMU2ohM6tb9oK/z6EPo01b
	Ac1TrRvDLNTWSmbXBBvR/uyfrrQiODo=
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
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 0/4] reparent the THP split queue
Date: Wed, 15 Oct 2025 14:35:29 +0800
Message-ID: <cover.1760509767.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Changes in v5:
 - fix the softlockup issue in deferred_split_scan() (Zi Yan)
 - modify the commit message in [PATCH v4 3/4] (Shakeel Butt)
 - move memcg_is_dying() to memcontrol.h (Shakeel Butt)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20251014

Changes in v4:
 - add split_queue_lock*() and let folio_split_queue_lock*() to use them.
   (I have kept everyone's Acked-bys and Reviewed-bys. If you need to discard
    it, please let me know.)
 - let deferred_split_scan() to use split_queue_lock_irqsave(), which will fix
   the race problem in [PATCH v3 4/4].
   (Muchun Song)
 - collect Reviewed-bys
 - rebase onto the next-20251002

Changes in v3:
 - use css_is_dying() in folio_split_queue_lock*() to check if memcg is dying
   (David Hildenbrand, Shakeel Butt and Zi Yan)
 - modify the commit message in [PATCH v2 4/4]
   (Roman Gushchin)
 - fix the build error in [PATCH v2 4/4]
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250926

Changes in v2:
 - fix build errors in [PATCH 2/4] and [PATCH 4/4]
 - some cleanups for [PATCH 3/4] (suggested by David Hildenbrand)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250922

Hi all,

In the future, we will reparent LRU folios during memcg offline to eliminate
dying memory cgroups, which requires reparenting the THP split queue to its
parent memcg.

Similar to list_lru, the split queue is relatively independent and does not need
to be reparented along with objcg and LRU folios (holding objcg lock and lru
lock). Therefore, we can apply the same mechanism as list_lru to reparent the
split queue first when memcg is offine.

The first three patches in this series are separated from the series
"Eliminate Dying Memory Cgroup" [1], mainly to do some cleanup and preparatory
work.

The last patch reparents the THP split queue to its parent memcg during memcg
offline.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20250415024532.26632-1-songmuchun@bytedance.com/

Muchun Song (3):
  mm: thp: replace folio_memcg() with folio_memcg_charged()
  mm: thp: introduce folio_split_queue_lock and its variants
  mm: thp: use folio_batch to handle THP splitting in
    deferred_split_scan()

Qi Zheng (1):
  mm: thp: reparent the split queue during memcg offline

 include/linux/huge_mm.h    |   4 +
 include/linux/memcontrol.h |  20 +++
 mm/huge_memory.c           | 250 +++++++++++++++++++++++++------------
 mm/memcontrol.c            |   1 +
 4 files changed, 194 insertions(+), 81 deletions(-)

-- 
2.20.1


