Return-Path: <linux-kernel+bounces-883747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183AC2E3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96084E1D94
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658482BD580;
	Mon,  3 Nov 2025 22:20:09 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915301509A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208408; cv=none; b=GOVKnYDWA1z1y6F/uoe0dZK6k/BbwgVukyhohA2N4sEi1B55GNZCGKh0paQSYw8fp2Ww3bJYywcF6oeJ5lwMpuM9ff/2s46Xg/yD/F4S+OqoMyFHUlHDSlrjZhxUv08jEp7k1NLu2Q+8BgC9MGNGkp1XjfaGr989GleitYGqtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208408; c=relaxed/simple;
	bh=RZZGW9wkmTQ6/q1ynHjZ72Ap/stQVT7AelIhPqqcvZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhWlosWHrsdzGIbP7n0zdidPGZAr741LI8w+4ChWVFEyOnQ51CnXUiNFtEl0QFl4e7GE/uG4uqpPj2oaXPA88cA8knFwtX0dAUN4Wm/8esvNUN0xX8D/EvKtlzqoColNhGsY0ECrbhx2PQI5DCo3+eO14wUaXURNeO6o1+wwOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0lXN1KLcz9sSR;
	Mon,  3 Nov 2025 22:46:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JqLU5buq-Vrb; Mon,  3 Nov 2025 22:46:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0lXM6sDDz9sSL;
	Mon,  3 Nov 2025 22:46:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D67848B76C;
	Mon,  3 Nov 2025 22:46:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id msbw2gEQ50eF; Mon,  3 Nov 2025 22:46:27 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 39A2A8B763;
	Mon,  3 Nov 2025 22:46:27 +0100 (CET)
Message-ID: <662a5f56-8851-43a8-af27-237acd799943@csgroup.eu>
Date: Mon, 3 Nov 2025 22:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2025 à 20:12, Sverdlin, Alexander a écrit :
> [Vous ne recevez pas souvent de courriers de alexander.sverdlin@siemens.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Christophe,
> 
> On Mon, 2025-11-03 at 17:33 +0100, Christophe Leroy wrote:
>>> Replace the RAW SPI accesses with spi-mem API. The latter will fall back to
>>> RAW SPI accesses if spi-mem callbacks are not implemented by a controller
>>> driver.
>>
>> With this patch (kernel v6.17.1) our powerpc boards are totally
>> unstable, we get multiple random Oops due to bad memory accesses.
>>
>> With this commit reverted the board is stable again.
>>
>> The SPI driver is:
>>
>> CONFIG_SPI=y
>> CONFIG_SPI_MASTER=y
>> CONFIG_SPI_MEM=y
>> CONFIG_SPI_FSL_LIB=y
>> CONFIG_SPI_FSL_CPM=y
>> CONFIG_SPI_FSL_SPI=y
>>
>> How can we further investigate the issue ?
> 
> could you share these "random Oops"?

Sure. At the first place they look unrelated. Something is likely 
writing in the weed.

> 
> Looks like spi-fsl-spi doesn't support spi-mem interface (similar to spi-fsl-lpspi
> we use the patch with), so spi-mem falls back to the regular SPI. From this standpoint
> it's not that much different from the situation before patch.
> 
> But let's look into the splats.

First one:

[   27.112241] Kernel attempted to read user page (7f) - exploit 
attempt? (uid: 0)
[   27.119739] BUG: Kernel NULL pointer dereference on read at 0x0000007f
[   27.126181] Faulting instruction address: 0xc01af5fc
[   27.131093] Oops: Kernel access of bad area, sig: 11 [#2]
[   27.136422] BE PAGE_SIZE=16K  CMPC885
[   27.143594] CPU: 0 UID: 0 PID: 64 Comm: rcS Tainted: G      D W 
     6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7 #17 PREEMPT
[   27.155385] Tainted: [D]=DIE, [W]=WARN
[   27.159056] Hardware name: MCR3000_2G 8xx 0x500000 CMPC885
[   27.164479] NIP:  c01af5fc LR: c08c3698 CTR: 00000000
[   27.169481] REGS: ca173c00 TRAP: 0300   Tainted: G      D W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   27.180054] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 95003599  XER: a000bf00
[   27.187024] DAR: 0000007f DSISR: c0000000
[   27.187024] GPR00: c08c3d1c ca173cc0 c32b4c80 c2004400 00000cc0 
00000cc0 00000100 000039db
[   27.187024] GPR08: 000039da 00000080 c31ea000 00000004 35003599 
100d815e c329a1c0 c11b0000
[   27.187024] GPR16: c312ac30 c11659ec c11d7f98 c11b01b4 c3284260 
c107b85c c312abc0 c1165450
[   27.187024] GPR24: c11d7f08 c11f0000 00000cc0 ffffffff c08c3698 
00000cc0 ffffffff c2004400
[   27.226870] NIP [c01af5fc] kmem_cache_alloc_noprof+0x54/0x21c
[   27.232551] LR [c08c3698] mas_dup_build+0x154/0x75c
[   27.237372] Call Trace:
[   27.239781] [ca173cc0] [00000001] 0x1 (unreliable)
[   27.244514] [ca173ce0] [00000000] 0x0
[   27.248129] [ca173d20] [c08c3d1c] __mt_dup+0x7c/0xf8
[   27.253034] [ca173d90] [c0188b14] dup_mmap+0xc8/0x690
[   27.258026] [ca173df0] [c001f8a4] copy_process+0xcd4/0x148c
[   27.263534] [ca173e70] [c0020188] kernel_clone+0xa4/0x3e8
[   27.268869] [ca173eb0] [c0020820] sys_clone+0x78/0x9c
[   27.273861] [ca173f20] [c000ddcc] system_call_exception+0x8c/0x160
[   27.279971] [ca173f30] [c00110a8] ret_from_syscall+0x0/0x28
[   27.285479] ---- interrupt: c00 at 0xfca2a6c
[   27.289696] NIP:  0fca2a6c LR: 0fca7c40 CTR: 0fc6f51c
[   27.294701] REGS: ca173f40 TRAP: 0c00   Tainted: G      D W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   27.305272] MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 25005590  XER: 
a000bf00
[   27.312587]
[   27.312587] GPR00: 00000078 7fc30fb0 7795b520 01200011 00000000 
00000000 00000000 77954088
[   27.312587] GPR08: 0000d032 100d4010 100cdd2d 0fc6f51c 59005998 
100d815e c0004a68 00000000
[   27.312587] GPR16: 00000000 7fc467dc 1001041c 10010000 100103ec 
10005984 00000000 00000000
[   27.312587] GPR24: ffffffff 00000000 100d58a4 100d58a4 100d5340 
00000000 0fde378c 00000000
[   27.349679] NIP [0fca2a6c] 0xfca2a6c
[   27.353207] LR [0fca7c40] 0xfca7c40
[   27.356649] ---- interrupt: c00
[   27.359753] Code: 7c9d2378 418201ec 813f0000 81090004 83c90000 
81290008 2c1e0000 4182004c 2c090000 38e80001 41820040 813f001c 
<7d3e482e> 7ca000a6 7c5113a6 815f0000
[   27.375418] ---[ end trace 0000000000000000 ]---

Second one:

[   25.086900] Disabling lock debugging due to kernel taint
[   25.086966] Machine check in kernel mode.
[   25.086999] Caused by (from SRR1=d032): Data access error at address 
7f9aeb94
[   25.087136] Oops: Machine check, sig: 7 [#1]
[   25.107454] BE PAGE_SIZE=16K  CMPC885
[   25.114628] CPU: 0 UID: 0 PID: 260 Comm: syslogd Tainted: G   M    W 
          6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7 #17 PREEMPT
[   25.126850] Tainted: [M]=MACHINE_CHECK, [W]=WARN
[   25.131380] Hardware name: MCR3000_2G 8xx 0x500000 CMPC885
[   25.136804] NIP:  0fcdbb30 LR: 0fde378c CTR: 00000000
[   25.141805] REGS: ca22bf40 TRAP: 0200   Tainted: G   M    W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   25.152378] MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 99003398  XER: 
a000bf00
[   25.159693] DAR: 7f9aeb94 DSISR: 00000001
[   25.159693] GPR00: 00000000 7f9aeb70 77d07520 0000004e 0fde378c 
29003398 77d004cc 0fcdbb14
[   25.159693] GPR08: 0000d032 fffff000 00000000 00000000 59003398 
100d815e 7fa52560 100d0000
[   25.159693] GPR16: 100d0000 00000000 ffffffff 00000059 100d0000 
11a681f7 11a683f8 11a681f8
[   25.159693] GPR24: 100d0000 100b4559 100d0178 00000058 11a681f8 
00000058 0fde378c 0000004e
[   25.199453] NIP [0fcdbb30] 0xfcdbb30
[   25.202982] LR [0fde378c] 0xfde378c
[   25.206427] Call Trace:
[   25.208845] ---[ end trace 0000000000000000 ]---

Third one:

[   25.295400] BUG: Bad page map in process syslogd  pte:ffffffff 
pmd:031c0041
[   25.302212] addr:7f98c000 vm_flags:00100173 anon_vma:c3278c30 
mapping:00000000 index:1fff7
[   25.310682] file:(null) fault:0x0 mmap:0x0 mmap_prepare: 0x0 
read_folio:0x0
[   25.317750] CPU: 0 UID: 0 PID: 260 Comm: syslogd Tainted: G   M  D W 
          6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7 #17 PREEMPT
[   25.329963] Tainted: [M]=MACHINE_CHECK, [D]=DIE, [W]=WARN
[   25.335258] Hardware name: MCR3000_2G 8xx 0x500000 CMPC885
[   25.340684] Call Trace:
[   25.343090] [ca22bc50] [c08b4d48] dump_stack+0x78/0x94 (unreliable)
[   25.349373] [ca22bc60] [c017b2c0] print_bad_pte.isra.0+0x134/0x240
[   25.355483] [ca22bcb0] [c017d374] vm_normal_page+0xc0/0xd0
[   25.360905] [ca22bcc0] [c017df94] zap_pte_range+0x1ec/0xaf4
[   25.366413] [ca22bd70] [c017f194] unmap_page_range+0xfc/0x144
[   25.372093] [ca22bda0] [c017f2d0] unmap_vmas+0x70/0x134
[   25.377256] [ca22bde0] [c0188244] exit_mmap+0xbc/0x3d0
[   25.382334] [ca22be80] [c001db84] mmput+0x4c/0x12c
[   25.387067] [ca22be90] [c0024b54] do_exit+0x20c/0x954
[   25.392059] [ca22bed0] [c0025324] make_task_dead+0x88/0x164
[   25.397567] [ca22bee0] [c000a6bc] die+0x204/0x20c
[   25.402214] [ca22bf10] [c000b4b0] machine_check_exception+0x110/0x264
[   25.408583] [ca22bf30] [c00031f4] MachineCheck_virt+0x100/0x104
[   25.414434] ---- interrupt: 200 at 0xfcdbb30
[   25.418651] NIP:  0fcdbb30 LR: 0fde378c CTR: 00000000
[   25.423657] REGS: ca22bf40 TRAP: 0200   Tainted: G   M  D W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   25.434228] MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 99003398  XER: 
a000bf00
[   25.441543] DAR: 7f9aeb94 DSISR: 00000001
[   25.441543] GPR00: 00000000 7f9aeb70 77d07520 0000004e 0fde378c 
29003398 77d004cc 0fcdbb14
[   25.441543] GPR08: 0000d032 fffff000 00000000 00000000 59003398 
100d815e 7fa52560 100d0000
[   25.441543] GPR16: 100d0000 00000000 ffffffff 00000059 100d0000 
11a681f7 11a683f8 11a681f8
[   25.441543] GPR24: 100d0000 100b4559 100d0178 00000058 11a681f8 
00000058 0fde378c 0000004e
[   25.481302] NIP [0fcdbb30] 0xfcdbb30
[   25.484831] LR [0fde378c] 0xfde378c
[   25.488273] ---- interrupt: 200
[   25.694562] BUG: Bad page map in process syslogd  pte:ffffffff 
pmd:031c0041
[   25.701361] addr:7f990000 vm_flags:00100173 anon_vma:c3278c30 
mapping:00000000 index:1fff8

Fourth one:

[   29.366796] Kernel attempted to read user page (24) - exploit 
attempt? (uid: 0)
[   29.373925] BUG: Kernel NULL pointer dereference on read at 0x00000024
[   29.380367] Faulting instruction address: 0xc08cbd0c
[   29.385279] Oops: Kernel access of bad area, sig: 11 [#1]
[   29.390607] BE PAGE_SIZE=16K  CMPC885
[   29.397780] CPU: 0 UID: 0 PID: 415 Comm: rm Tainted: G        W 
     6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7 #17 PREEMPT
[   29.409562] Tainted: [W]=WARN
[   29.412467] Hardware name: MCR3000_2G 8xx 0x500000 CMPC885
[   29.417890] NIP:  c08cbd0c LR: c08cbcf8 CTR: c08cbc44
[   29.422892] REGS: ca2f3c80 TRAP: 0300   Tainted: G        W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   29.433465] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 99005999  XER: a000bf00
[   29.440435] DAR: 00000024 DSISR: c0000000
[   29.440435] GPR00: c08ce480 ca2f3d40 c31c8640 00000000 c31f0800 
ffffffff c31f0880 ffffffff
[   29.440435] GPR08: 00000000 00000000 00000000 ffffffff 0000001f 
100d815e 7fab0cc0 100d0000
[   29.440435] GPR16: 100d0000 00000000 100d442c 100d4430 c334a740 
00100000 c31f0880 00000000
[   29.440435] GPR24: 00000000 00000001 00000004 ff074600 00000009 
00000024 ca2f3df8 0e0a2324
[   29.480281] NIP [c08cbd0c] mas_wr_store_entry+0x508/0xa90
[   29.485618] LR [c08cbcf8] mas_wr_store_entry+0x4f4/0xa90
[   29.490869] Call Trace:
[   29.493278] [ca2f3d40] [000000ca] 0xca (unreliable)
[   29.498097] [ca2f3d80] [c08ce480] mas_erase+0x63c/0x6c4
[   29.503261] [ca2f3df0] [c08ce568] mtree_erase+0x60/0x100
[   29.508510] [ca2f3e40] [c02093f4] simple_offset_remove+0x24/0x40
[   29.514449] [ca2f3e50] [c0158a10] shmem_unlink+0x4c/0x108
[   29.519784] [ca2f3ea0] [c01daa98] vfs_unlink+0xc4/0x344
[   29.524948] [ca2f3ec0] [c01df0d8] do_unlinkat+0x288/0x334
[   29.530284] [ca2f3f20] [c000ddcc] system_call_exception+0x8c/0x160
[   29.536394] [ca2f3f30] [c00110a8] ret_from_syscall+0x0/0x28
[   29.541902] ---- interrupt: c00 at 0xfcdc8c4
[   29.546118] NIP:  0fcdc8c4 LR: 10098e84 CTR: 0fcda734
[   29.551124] REGS: ca2f3f40 TRAP: 0c00   Tainted: G        W 
  (6.17.1-knld-3.16.4rc3-git8ac3a4-g568c147ca0f7)
[   29.561695] MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 29005590  XER: 
a000bf00
[   29.569010]
[   29.569010] GPR00: 0000000a 7fab0b80 77d3f520 100d4414 10098eb8 
29005590 ca2f3ebc 0fccf170
[   29.569010] GPR08: 0000d032 00000074 005b5d4e 0fcda734 00000003 
100d815e 7fab0cc0 100d0000
[   29.569010] GPR16: 100d0000 00000000 100d442c 100d4430 ffffffff 
00000001 00000000 00000000
[   29.569010] GPR24: 00000000 00000000 00000002 ffffff4d 100b7abc 
100d4434 0fde378c 100d4414
[   29.606102] NIP [0fcdc8c4] 0xfcdc8c4
[   29.609630] LR [10098e84] 0x10098e84
[   29.613158] ---- interrupt: c00
[   29.616261] Code: 57e9063a 418203c0 7d29e430 7d3c4b78 553d103a 
7fc3f378 4bff40c5 2c030003 39200000 4082000c 57ff002e 393f00a8 
<7d29e82e> 7c09d800 418202a4 7f65db78
[   29.631927] ---[ end trace 0000000000000000 ]---
[   29.636486]
[   29.637947] note: rm[415] exited with irqs disabled

Christophe


