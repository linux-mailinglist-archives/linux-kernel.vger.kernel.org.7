Return-Path: <linux-kernel+bounces-894912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6442C4C6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A9474F350D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A773287505;
	Tue, 11 Nov 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lyd9yXcK"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4821FF30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850201; cv=none; b=eQv5+Iz1RsnltCfYjw0vEUvTQSCNa6T7iPXWLt2rvmhW0B4kA1/rKy45AADlD8Pc04ERyS8yp7XC/B2XD8UI12SUXj89ib1856hOFbtTXYFl2nlDOKWCmal2B4FOm4lBe0ouJet3xomjuckQPlOezMtVoUDC0TNIyD5mjJWcRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850201; c=relaxed/simple;
	bh=cS8osK4BzNveAQJzepJcDWiGlSaOD1CHuN9fiKEnKQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrXZjQexEDs4dtkiQy7FSPnfMN9MBVlhnWeQ0mSCf690CB8crOwzkf3Qax+ych6INCpwOQnWT7Si7SFP/e7Vq+TPFmjSQu4vnVDI+JgUou2LQn84GTIxQAP2TmKu2QryIZBmmznhu33vykxIYAFpdo4hwOKggjSXCxhYvVvK0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lyd9yXcK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762850183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYW7uwo5YmrbKTsOhY6HR/nNpnR25sBnCicgt/mIAYI=;
	b=lyd9yXcKgVyy5ObtM77OrHWo0Dxr+4i4HTrXVudYHhVkwnMGRUPM/IbZOc1d9CnGGgLNJ0
	ioIhGiUkn5YLIwJs1ZXguIXPhWyXOZte/exkLOwZ35rlxE9hDZ4mkej6SQDbTXei3S78nV
	BRjknCA95GHxC8ux0HjhPJGdOqZ2vqM=
Date: Tue, 11 Nov 2025 16:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 11/11/25 7:20 AM, Shakeel Butt wrote:
> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However for some stats which are also maintained
> at node level, it is using irq unsafe interface and thus requiring the
> users to still disables irqs or use interfaces which explicitly disables
> irqs. Let's move memcg code to use irq safe node level stats function
> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> (all major ones), so there will not be any performance penalty for its
> usage.

Generally, places that call __mod_lruvec_state() also call
__mod_zone_page_state(), and it also has the corresponding optimized
version (mod_zone_page_state()). It seems necessary to clean that up
as well, so that those disabling-IRQs that are only used for updating
vmstat can be removed.

Thanks,
Qi

> 
> Shakeel Butt (4):
>    memcg: use mod_node_page_state to update stats
>    memcg: remove __mod_lruvec_kmem_state
>    memcg: remove __mod_lruvec_state
>    memcg: remove __lruvec_stat_mod_folio
> 
>   include/linux/memcontrol.h | 28 ++++------------------
>   include/linux/mm_inline.h  |  2 +-
>   include/linux/vmstat.h     | 48 ++------------------------------------
>   mm/filemap.c               | 20 ++++++++--------
>   mm/huge_memory.c           |  4 ++--
>   mm/khugepaged.c            |  8 +++----
>   mm/memcontrol.c            | 20 ++++++++--------
>   mm/migrate.c               | 20 ++++++++--------
>   mm/page-writeback.c        |  2 +-
>   mm/rmap.c                  |  4 ++--
>   mm/shmem.c                 |  6 ++---
>   mm/vmscan.c                |  4 ++--
>   mm/workingset.c            |  2 +-
>   13 files changed, 53 insertions(+), 115 deletions(-)
> 


