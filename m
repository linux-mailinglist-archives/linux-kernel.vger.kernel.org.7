Return-Path: <linux-kernel+bounces-856683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABEFBE4CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3664075C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023D216605;
	Thu, 16 Oct 2025 17:15:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F43346AB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634931; cv=none; b=kvwpDiz5NVE283rzbhzpN0ogLWUbiAotwUDTqHgH3iYyVX6J8lNGZEPKcPQZJ4M/cmtZzikYbp6VP464nEb1lqQjz+N6vDxz6nyXSW8dPG/rWRtHjvpFfDxr7KKyZEAvXEzvRWgAMK5Xf5Qy4jXKzCsSsjmZ5fz1KlkW8Gz16X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634931; c=relaxed/simple;
	bh=0Mp37pjY3oRfIuccjn7Ck2dwdstb2IFSBc+CmWkWdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S84+WK2uGZBJhwWiBuVud7o4t2zcAuppFFr59BXe/pRhX0gsKrgsUrEkJ2EAK4Y1Tb1iysyRrn046Z/53GTkXhSiWlUqVWdRdvu/9k0p8GyEFHr1qSEQ5B6IPrgeb3xF5cEDorlPigJlrSusMXgiGQ+Iw/Bmp2owWc32kZisWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611B4C4CEF1;
	Thu, 16 Oct 2025 17:15:28 +0000 (UTC)
Date: Thu, 16 Oct 2025 18:15:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG RESEND] Kernel panic in update_cfs_rq_h_load() on aarch64
Message-ID: <aPEoLc1mDB22f2Ff@arm.com>
References: <20251013071820.1531295-1-CruzZhao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013071820.1531295-1-CruzZhao@linux.alibaba.com>

On Mon, Oct 13, 2025 at 03:17:58PM +0800, Cruz Zhao wrote:
> Hi, all. We are encountering a kernel panic in our production environment
> running Linux kernel version 5.10.134, on aarch64 architecture (aarch64
> architecture only).
> 
> Summary:
> - Kernel Version: 5.10.134

That's a pretty old kernel though still maintained LTS. Can you
reproduce this with the latest 5.10.x?

>  - Architecture: aarch64
>  - Problem Type: panic
>  - Reproducibility: About 40 times per week
> 
> This issue leads to system-wide unresponsiveness and requires a hard reboot.
> We have collected the panic logs and backtraces, which I will include below
> for your reference. We tried to analyze the vmcore but have not found out
> the root cause.
> 
> Backtrace from dmesg:
> [352245.601209] Unable to handle kernel paging request at virtual address 006410a84bf5c71c
> [352245.609208] Mem abort info:
> [352245.612077]   ESR = 0x96000004
> [352245.615208]   EC = 0x25: DABT (current EL), IL = 32 bits
> [352245.620595]   SET = 0, FnV = 0
> [352245.623723]   EA = 0, S1PTW = 0
> [352245.626938] Data abort info:
> [352245.629893]   ISV = 0, ISS = 0x00000004
> [352245.633803]   CM = 0, WnR = 0
> [352245.636845] [006410a84bf5c71c] address between user and kernel address ranges
> [352245.644059] Internal error: Oops: 96000004 [#1] SMP
> [352245.728419] CPU: 98 PID: 2075637 Comm: execution_task_ Kdump: loaded Tainted: G           OE     5.10.134-xxx.al8.aarch64 #1
> [352245.740578] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 1.2.M1.AL.P.153.00 05/23/2023
> [352245.750306] pstate: 82401089 (Nzcv daIf +PAN -UAO +TCO BTYPE=--)
> [352245.756400] pc : update_cfs_rq_h_load+0x80/0xb0
> [352245.761007] lr : wake_affine_weight+0xa8/0x158
[...]
> The crash occurred because the line of code "cfs_rq->h_load = load;" accessed
> an invalid pointer 006410a84bf5c71c when trying to access cfs->h_load. The
> variable cfs_rq was obtained via "cfs_rq = group_cfs_rq(se);". According to
> the assembly code, the value of se is stored in register x2, with the pointer
> ffff04128c023c00. However, upon inspecting its fields, it turns out that
> this object is not a valid sched_entity. We've analyzed the logic of code,
> and checked the cfs_rq and se in memory, which are all correct, but we cannot
> find out where the pointer ffff04128c023c00 came from. And we've also
> analyzed most of the vmcores, and identified a common pattern: all corrupted
> pointers belong to the kmalloc-1k slab type, the same as cfs_rq and
> sched_entity.
> 
> We currently suspect that this is not caused by a scheduler bug. Has anyone
> encountered a similar crash stack? Does anyone know why this issue only
> occurs on aarch64?

I haven't seen this before but I don't do large scale testing. It could
be some unrelated bug corrupting adjacent kmalloc allocations from the
same pool. Have you tried enabling some kernel sanitisers like kasan and
see if they spot anything?

-- 
Catalin

