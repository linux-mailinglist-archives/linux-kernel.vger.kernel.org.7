Return-Path: <linux-kernel+bounces-642545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E00AB2036
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 01:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883289E72F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 23:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A81264A6E;
	Fri,  9 May 2025 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NSMF+qwX"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B843221DB9
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833359; cv=none; b=tbQGs3KVIvfiA0uaSFBIs297+lUbUJbQoDYiQgq9GGUtgfX2gEh5pKZqrMZr8coxl3ICsdQmk1Qx/tlfFe2CnEiud3AtQZjw62QmZzssEBYTrZKS1m1K2lVy5VuSoQsgV1LoEkampUl33UKPJcUiNuHU/JbNu3x1fV4euZZWmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833359; c=relaxed/simple;
	bh=aWMDUqTlg8yBXVFLElcPolZriEBCBo36iTwWLs5hHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twWvtq+IjYJK6cAXxFSNoHjPm4wRC4VwHZ+TlPZXLk/WfeSThiGilfYrSnpyfYW/dlxx06aRr5vovS24zOmthQ4FjdfBye9OhJne8Ul13R0doPoQgwlx+vwYKiH1B5xYxfIjF3uN+et0Ve31B+9KpS+SfuiQLlH6uJDrXWWyLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NSMF+qwX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J4VBELZKVh9c+NN05lvMDVzh5vrV8L5R0K09W43K4So=;
	b=NSMF+qwXdjyonU75kVK3drmkVY72aepNgUdyyTMjA3GlllkY3BKuGMwnb83kE6Qe/joeK6
	Ugsuoi8uALx2oFJgDiw5BrzxWNpBVn39/ZEQcdyz6wIf49PNG88TACXc0idbiVvJLoHvdC
	77k+BVstMcpgReG0AAAkvt4ExOdO+Dg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/4] memcg: nmi-safe kmem charging
Date: Fri,  9 May 2025 16:28:55 -0700
Message-ID: <20250509232859.657525-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can trigger memcg charged kernel allocations in nmi
context. However memcg charging infra for kernel memory is not equipped
to handle nmi context. This series adds support for kernel memory
charging for nmi context.

The initial prototype tried to make memcg charging infra for kernel
memory re-entrant against irq and nmi. However upon realizing that
this_cpu_* operations are not safe on all architectures (Tejun), this
series took a different approach targeting only nmi context. Since the
number of stats that are updated in kernel memory charging path are 3,
this series added special handling of those stats in nmi context rather
than making all >100 memcg stats nmi safe.

There will be a followup series which will make kernel memory charging
reentrant for irq and will be able to do without disabling irqs.

We ran network intensive workload on this series and have not seen any
significant performance differences with and without the series.

Shakeel Butt (4):
  memcg: add infra for nmi safe memcg stats
  memcg: add nmi-safe update for MEMCG_KMEM
  memcg: nmi-safe slab stats updates
  memcg: make objcg charging nmi safe

 include/linux/memcontrol.h |  6 +++
 mm/memcontrol.c            | 87 +++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.47.1


