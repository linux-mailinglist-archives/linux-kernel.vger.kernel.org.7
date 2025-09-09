Return-Path: <linux-kernel+bounces-807052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A75B49F52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01CF1BC20DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B66253954;
	Tue,  9 Sep 2025 02:40:37 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8E1A9F8E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385636; cv=none; b=d6oo8tKNBbRcGdclM3bDbOOKPow9BCelldzk40xaHw4z8oMfQQ0yf05VS6jvYJXWG/a3MZSaNxMm+r8JhFwmnbbuPL3AZ/Rbr0Yn3z+skoydSfSTFw1aUVNo+Vq5KnEqnqgmM518HSwHQ/MqZaFzZs5sUDT3Eq5Yd9gDxgl83zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385636; c=relaxed/simple;
	bh=6OuNmwzoB/P7Zlyg5SUaQw4tKe16Wfpd8nJefkC1CLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlQtkjnn28IVy2bKPHMgmz4j7tRULb0y+QpUXwu+ai05L7x2ETYdYpPeSYkRB+sI33uhTPtmXQZT21sohU007PdOEEKTDMufR/08ycvhVWMcV1KtQ3lK6TYWaqTayg+bZWriQIDEqjEd5bm2PsSOFjT5R/RrIhGfRetCz4kiaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509091040251217;
        Tue, 09 Sep 2025 10:40:25 +0800
Received: from PC00024056.home.langchao.com (10.94.13.120) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 9 Sep 2025 10:40:26 +0800
From: cuishiwei <cuishw@inspur.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: cuishiwei <cuishw@inspur.com>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <hannes@cmpxchg.org>, <weixugc@google.com>,
	<david@redhat.com>, <zhengqi.arch@bytedance.com>, <shakeel.butt@linux.dev>,
	<lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] disable demotion during memory reclamation
Date: Tue, 9 Sep 2025 10:40:08 +0800
Message-ID: <20250909024022.2393-1-cuishw@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908183649.da6b77d15c1076e5b69064af@linux-foundation.org>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 Jtjnmail201614.home.langchao.com (10.100.2.14)
tUid: 2025909104025b0b5c0a585e17b0e2198fc39453a626e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

On Mon, 8 Sep 2025 18:36:49 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 9 Sep 2025 09:21:41 +0800 cuishiwei <cuishw@inspur.com> wrote:
> 
> > When a memory cgroup exceeds its memory limit, the system reclaims
> > its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
> > set to 1, memory on fast memory nodes will also be demoted to slow 
> > memory nodes.
> > 
> > This demotion contradicts the goal of reclaiming cold memory within
> > the memcg.At this point, demoting cold memory from fast to slow nodes
> > is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
> > we should set no_demotion when reclaiming memory in a memcg.
> 
> Is this from code inspection?  Or is there some workload which benefits
> from this change?  If the latter, please tell us all about it.
Hello, I've found an issue while using CXL memory. My machine has one DRAM
NUMA node and one CXL NUMA node:
node 1 cpus: 96 97 98 99...	- dram Numa node
node 1 size: 772048 MB
node 1 free: 759737 MB
node 3 cpus:			- CXL memory Numa node
node 3 size: 524288 MB
node 3 free: 524287 MB
1.enable demotion
echo 1 > /sys/kernel/mm/numa/demotion_enabled
2.Execute a memory allocation program in a memcg
cgexec -g memory:test numactl -N 1 ./allocate_memory 20	- allocate 20G memory
numastat allocate_memory：
                           Node 0          Node 1          Node 3
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.00            0.00            0.00
Stack                        0.00            0.01            0.00
Private                      0.05        20481.56            0.01
3.Setting the memory cgroup memory limit to be exceeded
echo 15G > /sys/fs/cgroup/test/memory.max
numastat allocate_memory：
                           Node 0          Node 1          Node 3
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.00            0.00            0.00
Stack                        0.00            0.01            0.00
Private                      0.00         4011.54            10560.00

Based on what you can see, because demotion was enabled, 
when the memcg's memory limit was exceeded, memory from
the DRAM NUMA node was first migrated to the CXL NUMA node.
After that, a memory reclaim was performed, which was unnecessary.
> 
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6706,6 +6706,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >  		.may_unmap = 1,
> >  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> >  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> > +		.no_demotion = 1,
> >  	};
> >  	/*
> >  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> > -- 
> > 2.43.0

Sent using hkml (https://github.com/sjp38/hackermail)

