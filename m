Return-Path: <linux-kernel+bounces-678487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A328AD2A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 00:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7234118890E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064D227EAA;
	Mon,  9 Jun 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eswxoG3G"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05262226545
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509794; cv=none; b=SSGm7QW62ddqUkRVxAgX4k7rKoU3NpbwsrpcwKv33rJaLDurN0xT24u+fjQzUXArDMC5SBO07EqbYKuMBNFZixGnmwoJ7uCBB6rCRBVJoPGIyDHmtPGQW88zk2P5knOtW9t+4Mbc01ansBGPAayl6HlqsjqTJxczAEAVLjUSlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509794; c=relaxed/simple;
	bh=fnvgnGU/oZtXEwKHJwF4oXb0QENWEDEDPSOTdAb7sqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7Cm0dHJaR/uvchqQJJ8MuAbHcGDRzM52HF46Y34auaPn2nIqPjE0zQWB2CdhHiC1w9GwmQhxKmws+OVC8kFfZTHyapK5HvMV9ze6iGQDxlMyqo2+DYtXfb89flh8zAz4/sUIm0ZAAw3IZcXbDYrqYNs56gLoIcM9tLNBfRfv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eswxoG3G; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749509781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j3bC3QS+YLVQDjDxB/dMj/zdRv0EphT3+T18L+fEShg=;
	b=eswxoG3GLoy2gFPGrmXzRUrJQnzdp7StbXSBdaIEFckRQ+Xr1i44A8obRqGLQyOcuIJA2g
	NATLzItcQAxPHnD5rHiC/nBSU/rC8PGx9wR01no1RefepK2ElUk/5mQJukswVhj1sryRJE
	5SiXj4Br0I35cLEZ1F4doWgqWizaF5Y=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
Date: Mon,  9 Jun 2025 15:56:08 -0700
Message-ID: <20250609225611.3967338-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can run in nmi context and may trigger memcg charged memory
allocation in such context. Recently linux added support to nmi safe
page allocation along with memcg charging of such allocations. However
the kmalloc/slab support and corresponding memcg charging is still
lacking,

To provide nmi safe support for memcg charging for kmalloc/slab
allocations, we need nmi safe memcg stats and for that we need nmi safe
css_rstat_updated() which adds the given cgroup state whose stats are
updated into the per-cpu per-ss update tree. This series took the aim to
make css_rstat_updated() nmi safe.

This series made css_rstat_updated by using per-cpu lockless lists whose
node in embedded in individual struct cgroup_subsys_state and the
per-cpu head is placed in struct cgroup_subsys. For rstat users without
cgroup_subsys, a global per-cpu lockless list head is created. The main
challenge to use lockless in this scenario was the potential multiple
inserters using the same lockless node of a cgroup_subsys_state which is
different from traditional users of lockless lists.

The multiple inserters using potentially same lockless node was resolved
by making one of them succeed on reset the lockless node and the winner
gets to insert the lockless node in the corresponding lockless list.


Changelog since v1:
- Based on Yosry's suggestion always use llist on the update side and
  create the update tree on flush side

[v1] https://lore.kernel.org/cgroups/20250429061211.1295443-1-shakeel.butt@linux.dev/
 

Shakeel Butt (3):
  cgroup: support to enable nmi-safe css_rstat_updated
  cgroup: make css_rstat_updated nmi safe
  memcg: cgroup: call memcg_rstat_updated irrespective of in_nmi()

 include/linux/cgroup-defs.h |  4 ++
 kernel/cgroup/rstat.c       | 80 ++++++++++++++++++++++++++++++-------
 mm/memcontrol.c             | 10 ++---
 3 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.47.1


