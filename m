Return-Path: <linux-kernel+bounces-772746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA7B29715
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDD620352C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE142571D4;
	Mon, 18 Aug 2025 02:34:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DC1487E9;
	Mon, 18 Aug 2025 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484441; cv=none; b=noK+VD+lUecu28ZlrwCcuaSvRaOMhXHknG4p8pyTf1TFjfm4AFHGevVs5Zz+rVB4lEThYWPMKNQKwwQQmQKBLL6z6ciVfk9n1BgYW65xQzQ+h+o42Feb4Tie4LSSjfhR5td+T4et4J/bRqADnqjQfaWcox1O3uCxPLxNvtnM/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484441; c=relaxed/simple;
	bh=fZ8eB1YSjzBqPgU2DKEqBD6uZ+it9xFTWJLKkRdNn5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oEnuuK6jbIfFS4mzNRhf6a9Eh7zdKzc/7eeSMyyN8IUquTH081xlwKqSBwIatiVljGrMANk1Z++c4XZ4Zy09oXlm6t/rFwu7T6h9FN9fqJqznaZnkUnMc6tKX+TV61QyidemxfyCPXjc/Y5lznnRrGqwbsDzAndSCli11g1jPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c4xbt58mBzvWy5;
	Mon, 18 Aug 2025 10:33:46 +0800 (CST)
Received: from kwepemo100001.china.huawei.com (unknown [7.202.195.173])
	by mail.maildlp.com (Postfix) with ESMTPS id 76EE8180B5A;
	Mon, 18 Aug 2025 10:33:49 +0800 (CST)
Received: from [10.174.179.35] (10.174.179.35) by
 kwepemo100001.china.huawei.com (7.202.195.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 10:33:48 +0800
Message-ID: <3098ccce-4ddc-4d64-977f-b901278d1f13@huawei.com>
Date: Mon, 18 Aug 2025 10:33:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] of_numa: fix uninitialized memory nodes causing kernel
 panic
To: Mike Rapoport <rppt@kernel.org>
CC: <robh@kernel.org>, <saravanak@google.com>, <dan.j.williams@intel.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <devicetree@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <chenjun102@huawei.com>
References: <20250816073131.2674809-1-yintirui@huawei.com>
 <aKF2VZ1y8OuEChmw@kernel.org>
From: =?UTF-8?B?5Y2w5L2T6ZSQ?= <yintirui@huawei.com>
In-Reply-To: <aKF2VZ1y8OuEChmw@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100001.china.huawei.com (7.202.195.173)

Hi,

在 2025/8/17 14:27, Mike Rapoport 写道:
> Hi,
> 
> On Sat, Aug 16, 2025 at 03:31:31PM +0800, Yin Tirui wrote:
>> When the number of CPUs is fewer than the number of memory nodes,
>> some memory nodes may not be properly initialized because they are
>> not added to numa_nodes_parsed during memory parsing.
> 
> Why the issue happens when there are less CPUs than nodes?
> Does anything updates numa_nodes_parsed when there are more CPUs than
> nodes?
>   
>> In of_numa_parse_memory_nodes(), after successfully adding a memory
>> block via numa_add_memblk(), the corresponding node ID should be
>> marked as parsed. However, the current implementation in numa_add_memblk()
> 
> ... current implementation of of_numa_parse_memory_nodes()?
> 
>> only adds the memory block to numa_meminfo but fails to update
> 
> maybe "... but skips updating"
> 

Let me describe this in more detail:

of_numa_init
     of_numa_parse_cpu_nodes
         node_set(nid, numa_nodes_parsed);
     of_numa_parse_memory_nodes

In of_numa_parse_cpu_nodes, numa_nodes_parsed gets updated only for
nodes that contain CPUs.

A more accurate description is: When there are some nodes that contain
only memory (no CPUs), these nodes should have been updated in
of_numa_parse_memory_nodes, but they weren't. This is what caused the
problem.

>> numa_nodes_parsed, leaving some nodes uninitialized.
>>
>> During boot in a QEMU-emulated ARM64 NUMA environment, the kernel
>> panics when free_area_init() attempts to access NODE_DATA() for
>> memory nodes that were uninitialized.
>>
>> [    0.000000] Call trace:
>> [    0.000000]  free_area_init+0x620/0x106c (P)
>> [    0.000000]  bootmem_init+0x110/0x1dc
>> [    0.000000]  setup_arch+0x278/0x60c
>> [    0.000000]  start_kernel+0x70/0x748
>> [    0.000000]  __primary_switched+0x88/0x90
> 
> Would have be nice to have the full crash trace here and more details how
> qemu was run.
> 

QEMU with 1 CPU and 2 memory nodes:

qemu-system-aarch64 \
-cpu host -nographic \
-m 4G -smp 1 \
-machine virt,accel=kvm,gic-version=3,iommu=smmuv3 \
-object memory-backend-ram,size=2G,id=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=0,memdev=mem0 \
-numa node,nodeid=1,memdev=mem1 \
-kernel $IMAGE \
-hda $DISK \
-append "console=ttyAMA0 root=/dev/vda rw earlycon"


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x481fd010]
[    0.000000] Linux version 6.17.0-rc1-00001-gabb4b3daf18c-dirty 
(yintirui@local) (gcc (GCC) 12.3.1, GNU ld (GNU Binutils) 2.41) #52 SMP 
PREEMPT Mon Aug 18 09:49:40 CST 2025
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory 
node in the DT
[    0.000000] NODE_DATA(0) allocated [mem 0xbfffd9c0-0xbfffffff]
[    0.000000] node 1 must be removed before remove section 23
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000]   node   1: [mem 0x00000000c0000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000040000000-0x00000000bfffffff]
[    0.000000] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000000a0
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [00000000000000a0] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 0000000096000004 [#1]  SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 
6.17.0-rc1-00001-gabb4b3daf18c-dirty #52 PREEMPT
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.000000] pc : free_area_init+0x50c/0xf9c
[    0.000000] lr : free_area_init+0x5c0/0xf9c
[    0.000000] sp : ffffcfb466733c00
[    0.000000] x29: ffffcfb466733cb0 x28: 0000000000000000 x27: 
0000000000000000
[    0.000000] x26: 4ec4ec4ec4ec4ec5 x25: 00000000000c0000 x24: 
00000000000c0000
[    0.000000] x23: 0000000000040000 x22: 0000000000000000 x21: 
ffffcfb46673b368
[    0.000000] x20: ffffcfb466cc7b98 x19: 0000000000000000 x18: 
0000000000000002
[    0.000000] x17: 000000000000cacc x16: 0000000000000001 x15: 
0000000000000001
[    0.000000] x14: 0000000080000000 x13: 0000000000000018 x12: 
0000000000000002
[    0.000000] x11: ffffcfb4667d4f00 x10: ffffcfb466cbab20 x9 : 
ffffcfb466cbab38
[    0.000000] x8 : 00000000000c0000 x7 : 0000000000000001 x6 : 
0000000000000002
[    0.000000] x5 : 0000000140000000 x4 : ffffcfb466733c90 x3 : 
ffffcfb466733ca0
[    0.000000] x2 : ffffcfb466733c98 x1 : 0000000080000000 x0 : 
0000000000000001
[    0.000000] Call trace:
[    0.000000]  free_area_init+0x50c/0xf9c (P)
[    0.000000]  bootmem_init+0x110/0x1dc
[    0.000000]  setup_arch+0x278/0x60c
[    0.000000]  start_kernel+0x70/0x748
[    0.000000]  __primary_switched+0x88/0x90
[    0.000000] Code: d503201f b98093e0 52800016 f8607a93 (f9405260)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill 
the idle task! ]---

>> Cc: stable@vger.kernel.org
>> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
>> Signed-off-by: Yin Tirui <yintirui@huawei.com>
>>
>> ---
>>
>> v2: Move the changes to the of_numa related. Correct the fixes tag.
>> ---
>>   drivers/of/of_numa.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index 230d5f628c1b..cd2dc8e825c9 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
>>   			r = -EINVAL;
>>   		}
>>   
>> -		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
>> +		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
>>   			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
>> +			if (!r)
>> +				node_set(nid, numa_nodes_parsed);
>> +		}
>>   
>>   		if (!i || r) {
>>   			of_node_put(np);
>> -- 
>> 2.43.0
>>
> 


