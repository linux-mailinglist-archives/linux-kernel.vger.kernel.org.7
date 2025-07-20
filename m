Return-Path: <linux-kernel+bounces-738136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8CB0B4EC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5C3A3E87
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B01F1317;
	Sun, 20 Jul 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egxX5CuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9C4A0A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008102; cv=none; b=Kp0/hjgryymAB7UORYPgbxE7YDkZ75FtA+E7CqOlzhLl+ep1I7/enwO0CjxAX0EcHl73v7d1GpAxN+IHQcF9mqd4I1qS6ibwQx8JceXI4b+rdTrDcrvq01dV6PXBN1sNOj5q3KaN6OR2v2slRYoOdjv4zR5xxkXDOk29MSi58vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008102; c=relaxed/simple;
	bh=+/hl7T5dSMa4TqrtTRVUwQ05aV1bc75sZnp0CNl8R0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMBU13yB1YjkwvhyHTw/1yBOKN80LKC8bh/ciRH1SFyUbHYaou2x8AW0NfoGwv6jdM9E4KpcxcZ4jSN2Cxe8lgbT56GknE8NF4gUUhtHUEatd1Kehq8I3hppW5YI5PIdkky6EyyDadVDE6NT3uH9XHS7Gs+2qXcHKlzvU8Agxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egxX5CuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA9FC4CEE7;
	Sun, 20 Jul 2025 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753008101;
	bh=+/hl7T5dSMa4TqrtTRVUwQ05aV1bc75sZnp0CNl8R0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egxX5CuMBqt1a5nXv2CV8g25aHzv0sxrL9QHbkvlifvFeq6DzZZrTP26nKElJz0DE
	 DtRNBV8ruCUC0oM7oD+pc8CBADFR6W/DZClDQ3Ad/aCq33bvoB6Q0OY6mFo1pWUVag
	 femZec3sm2l8wVzFxB0nUZ+N3NJnO7TA8pRoI24Yw4ayhAqJ1xUqQqUZfUqKe8QWWv
	 PZofnM6TlIP3xg+6Y3SIfmtreQvIufnzIlufYtpT/DCQdUz9MwPslEIi200smtP6vO
	 ctt8Bt+BfthRroFhjhTi3KNqtpWx0CjeVxRREPHk5Uo8JNgUBr+M0D0wyRMwg0RMia
	 KLgUUlahrMCqw==
Date: Sun, 20 Jul 2025 13:41:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
	Borislav Petkov <bp@alien8.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v4] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250720104136.GI402218@unreal>
References: <20250709161917.14298-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709161917.14298-1-kprateek.nayak@amd.com>

On Wed, Jul 09, 2025 at 04:19:17PM +0000, K Prateek Nayak wrote:
> Leon noted a topology_span_sane() warning in their guest deployment
> starting from v6.16-rc1 [1]. Debug that followed pointed to the
> tl->mask() for the NODE domain being incorrectly resolved to that of the
> highest NUMA domain.
> 
> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
> set to the "tl->numa_level" during tl traversal in build_sched_domains()
> calling sd_init() but was not reset before topology_span_sane().
> 
> Since "tl->numa_level" still reflected the old value from
> build_sched_domains(), topology_span_sane() for the NODE domain trips
> when the span of the last NUMA domain overlaps.
> 
> Instead of replicating the "sched_domains_curr_level" hack, Valentin
> suggested using the spans from the sched_domain objects constructed
> during build_sched_domains() which can also catch overlaps when the
> domain spans are fixed up by build_sched_domain().
> 
> Since build_sched_domain() is skipped when tl->mask() of a child domain
> already covers the entire cpumap, skip the domains that have an empty
> span.
> 
> The original warning was reproducible on the following NUMA topology
> reported by Leon:
> 
>     $ sudo numactl -H
>     available: 5 nodes (0-4)
>     node 0 cpus: 0 1
>     node 0 size: 2927 MB
>     node 0 free: 1603 MB
>     node 1 cpus: 2 3
>     node 1 size: 3023 MB
>     node 1 free: 3008 MB
>     node 2 cpus: 4 5
>     node 2 size: 3023 MB
>     node 2 free: 3007 MB
>     node 3 cpus: 6 7
>     node 3 size: 3023 MB
>     node 3 free: 3002 MB
>     node 4 cpus: 8 9
>     node 4 size: 3022 MB
>     node 4 free: 2718 MB
>     node distances:
>     node   0   1   2   3   4
>       0:  10  39  38  37  36
>       1:  39  10  38  37  36
>       2:  38  38  10  37  36
>       3:  37  37  37  10  36
>       4:  36  36  36  36  10
> 
> The above topology can be mimicked using the following QEMU cmd that was
> used to reproduce the warning and test the fix:
> 
>      sudo qemu-system-x86_64 -enable-kvm -cpu host \
>      -m 20G -smp cpus=10,sockets=10 -machine q35 \
>      -object memory-backend-ram,size=4G,id=m0 \
>      -object memory-backend-ram,size=4G,id=m1 \
>      -object memory-backend-ram,size=4G,id=m2 \
>      -object memory-backend-ram,size=4G,id=m3 \
>      -object memory-backend-ram,size=4G,id=m4 \
>      -numa node,cpus=0-1,memdev=m0,nodeid=0 \
>      -numa node,cpus=2-3,memdev=m1,nodeid=1 \
>      -numa node,cpus=4-5,memdev=m2,nodeid=2 \
>      -numa node,cpus=6-7,memdev=m3,nodeid=3 \
>      -numa node,cpus=8-9,memdev=m4,nodeid=4 \
>      -numa dist,src=0,dst=1,val=39 \
>      -numa dist,src=0,dst=2,val=38 \
>      -numa dist,src=0,dst=3,val=37 \
>      -numa dist,src=0,dst=4,val=36 \
>      -numa dist,src=1,dst=0,val=39 \
>      -numa dist,src=1,dst=2,val=38 \
>      -numa dist,src=1,dst=3,val=37 \
>      -numa dist,src=1,dst=4,val=36 \
>      -numa dist,src=2,dst=0,val=38 \
>      -numa dist,src=2,dst=1,val=38 \
>      -numa dist,src=2,dst=3,val=37 \
>      -numa dist,src=2,dst=4,val=36 \
>      -numa dist,src=3,dst=0,val=37 \
>      -numa dist,src=3,dst=1,val=37 \
>      -numa dist,src=3,dst=2,val=37 \
>      -numa dist,src=3,dst=4,val=36 \
>      -numa dist,src=4,dst=0,val=36 \
>      -numa dist,src=4,dst=1,val=36 \
>      -numa dist,src=4,dst=2,val=36 \
>      -numa dist,src=4,dst=3,val=36 \
>      ...
> 
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changes are based on tip:sched/urgent at commit fc975cfb3639
> ("sched/deadline: Fix dl_server runtime calculation formula")

Was this patch picked?

Thanks,
Tested-by: Leon Romanovsky <leon@kernel.org>

