Return-Path: <linux-kernel+bounces-775490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84BEB2BFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709C51893442
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9332255F;
	Tue, 19 Aug 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxdFsQCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9B22A4D5;
	Tue, 19 Aug 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601432; cv=none; b=M09NP+xZ8x964aGb+T+ISixFltO0czoXtMqGe3pSv1tVT6kt+pvZHd7be6hZglCys9BrEPsPDHjh1AQtSqe+PskzA8P7TLINLWRIR3BrzI8UVzt10XTh/0oGo7+7ZEYAinygSoC12FJIOh10vrer72fcRDMQGJ2gA0N05jXfzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601432; c=relaxed/simple;
	bh=UcQi5igNficMd4VE9yzQLipb16wG55Yu37q1KOU8F3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPngsJ8IMA76cYBKWNwtttHbMtwdVUcv/olZFWS+plejSJ8OWbLPPK2RUBdDUDitnaWTYpi+zHLBpgHx4KomZUOcEG/zmPFe1n+MEkEROecgQzCfW9Jv52pEcLjt01rZoa8KpWp+l1VjVFH8lqWXG7xOyWC0+2GOX7BvrtYTsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxdFsQCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA29C4CEF1;
	Tue, 19 Aug 2025 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601432;
	bh=UcQi5igNficMd4VE9yzQLipb16wG55Yu37q1KOU8F3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxdFsQCr+OjBL4861fcA/j5N8Oi65KK+RZZZyZzgjdpJWamtjzsI7kPg8IClpZw80
	 fOWd66glzc6/gDVKCBlSWtSlEN/Wz/BqrtIKCuu0UahC8Ayy2dDToiyBer+GjsbwJ1
	 OiKqqguAFWrSk9KMh65PqMgMypHQEhpBOc1ZcJTnhpUPyCN60wUFDBftVgOHWuo7DS
	 WJDHwI812W+q5eXugX7VlOo6/O07U6KmBkvF+lgB0LkH4Gax4D1Ej7x0ITsnREWlpv
	 M4cI4GOw7v4nGQoTZDgZMVM3cgp91mgschqg3a83hpaFGYnX44tBitFQbpCRheo6hO
	 bwDXvMFXjtyuQ==
Date: Tue, 19 Aug 2025 14:03:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: robh@kernel.org, saravanak@google.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, david@redhat.com,
	Jonathan.Cameron@huawei.com, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com, chenjun102@huawei.com
Subject: Re: [PATCH v3] of_numa: fix uninitialized memory nodes causing
 kernel panic
Message-ID: <aKRaEL90Lf4_lLaT@kernel.org>
References: <20250819075510.2079961-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819075510.2079961-1-yintirui@huawei.com>

On Tue, Aug 19, 2025 at 03:55:10PM +0800, Yin Tirui wrote:
> When there are memory-only nodes (nodes without CPUs), these nodes
> are not properly initialized, causing kernel panic during boot.
> 
> of_numa_init
> 	of_numa_parse_cpu_nodes
> 		node_set(nid, numa_nodes_parsed);
> 	of_numa_parse_memory_nodes
> 
> In of_numa_parse_cpu_nodes, numa_nodes_parsed gets updated only for
> nodes containing CPUs. Memory-only nodes should have been updated in
> of_numa_parse_memory_nodes, but they weren't.
> 
> Subsequently, when free_area_init() attempts to access NODE_DATA()
> for these uninitialized memory nodes, the kernel panics due to NULL
> pointer dereference.
> 
> This can be reproduced on ARM64 QEMU with 1 CPU and 2 memory nodes:
> 
> qemu-system-aarch64 \
> -cpu host -nographic \
> -m 4G -smp 1 \
> -machine virt,accel=kvm,gic-version=3,iommu=smmuv3 \
> -object memory-backend-ram,size=2G,id=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=0,memdev=mem0 \
> -numa node,nodeid=1,memdev=mem1 \
> -kernel $IMAGE \
> -hda $DISK \
> -append "console=ttyAMA0 root=/dev/vda rw earlycon"
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x481fd010]
> [    0.000000] Linux version 6.17.0-rc1-00001-gabb4b3daf18c-dirty (yintirui@local) (gcc (GCC) 12.3.1, GNU ld (GNU Binutils) 2.41) #52 SMP PREEMPT Mon Aug 18 09:49:40 CST 2025
> [    0.000000] KASLR enabled
> [    0.000000] random: crng init done
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> [    0.000000] NODE_DATA(0) allocated [mem 0xbfffd9c0-0xbfffffff]
> [    0.000000] node 1 must be removed before remove section 23
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000]   node   1: [mem 0x00000000c0000000-0x000000013fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000a0
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x0000000096000004
> [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000]   FSC = 0x04: level 0 translation fault
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.000000] [00000000000000a0] user address but active_mm is swapper
> [    0.000000] Internal error: Oops: 0000000096000004 [#1]  SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17.0-rc1-00001-g760c6dabf762-dirty #54 PREEMPT
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : free_area_init+0x50c/0xf9c
> [    0.000000] lr : free_area_init+0x5c0/0xf9c
> [    0.000000] sp : ffffa02ca0f33c00
> [    0.000000] x29: ffffa02ca0f33cb0 x28: 0000000000000000 x27: 0000000000000000
> [    0.000000] x26: 4ec4ec4ec4ec4ec5 x25: 00000000000c0000 x24: 00000000000c0000
> [    0.000000] x23: 0000000000040000 x22: 0000000000000000 x21: ffffa02ca0f3b368
> [    0.000000] x20: ffffa02ca14c7b98 x19: 0000000000000000 x18: 0000000000000002
> [    0.000000] x17: 000000000000cacc x16: 0000000000000001 x15: 0000000000000001
> [    0.000000] x14: 0000000080000000 x13: 0000000000000018 x12: 0000000000000002
> [    0.000000] x11: ffffa02ca0fd4f00 x10: ffffa02ca14bab20 x9 : ffffa02ca14bab38
> [    0.000000] x8 : 00000000000c0000 x7 : 0000000000000001 x6 : 0000000000000002
> [    0.000000] x5 : 0000000140000000 x4 : ffffa02ca0f33c90 x3 : ffffa02ca0f33ca0
> [    0.000000] x2 : ffffa02ca0f33c98 x1 : 0000000080000000 x0 : 0000000000000001
> [    0.000000] Call trace:
> [    0.000000]  free_area_init+0x50c/0xf9c (P)
> [    0.000000]  bootmem_init+0x110/0x1dc
> [    0.000000]  setup_arch+0x278/0x60c
> [    0.000000]  start_kernel+0x70/0x748
> [    0.000000]  __primary_switched+0x88/0x90
> [    0.000000] Code: d503201f b98093e0 52800016 f8607a93 (f9405260)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> v2: Move the changes to the of_numa related. Correct the fixes tag.
> v3: Only amend commit message with no code changes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  drivers/of/of_numa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b..cd2dc8e825c9 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
>  			r = -EINVAL;
>  		}
>  
> -		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
> +		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
>  			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
> +			if (!r)
> +				node_set(nid, numa_nodes_parsed);
> +		}
>  
>  		if (!i || r) {
>  			of_node_put(np);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

