Return-Path: <linux-kernel+bounces-755996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2AEB1AE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D961738FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ECB21C16B;
	Tue,  5 Aug 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sIE1xJZ9"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD31B960
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376091; cv=none; b=g1065dilmgID5wMeFDvCGu4UFyhDF7JfHtTCLjjHeeHWWigY+XNhkoPTcRMCV55iTlsl6WPBOxKpUEgo/WcPFHCeSX/+DuUwhQCYKqRo5uBoaDm5DHejenFCOLbg4x+0RmFxpVUQFb9bfs808/Fym9KGkZDoTwaiEmqpowuNcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376091; c=relaxed/simple;
	bh=QzygLQFMu2kTxxlR2qMgnqwBcyPqL2BCfiJuwFwquV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVv42/qppqcgCJl3HvIjdtfCYsVr1Ni6YSfWByPAu84FB/QRLEcxpj1C3GYBBqDpvQ3X4gLo0SWVh0t5+74CMRts/LyCCItXYyYJ5bVvOWAmw9C4I1BCq86pCJHpEkQeDEcDwaUU1CKipm8Xv2c8Q0njEEc1F1O9x4Y7jC5SOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sIE1xJZ9; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754376085; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iKwb3jyiyyLlRq/hzHJCa8IJJVZNalYmdaLHaPwmwrU=;
	b=sIE1xJZ9CIWW6fXKGycIeABlUbx7mE540ro2p3S8r9ZNkXEbOJ7vaE9vGrxwqYayyNYOW7tYlUt6T9l6Ud9msqBEJLjW55pBc/S925BTqSP3cDTUqiTRrRrv6vflZdz0NI7Y5TUa/CM2ULcoLQ1U60rc9sBaOPqWkEY3mjA8q/k=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl440vN_1754376082 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 14:41:23 +0800
Message-ID: <721c093c-a54a-4ccc-b784-e3634a8c2278@linux.alibaba.com>
Date: Tue, 5 Aug 2025 14:41:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 "Lai, Yi" <yi1.lai@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Lokesh Gidra <lokeshgidra@google.com>,
 Tangquan Zheng <zhengtangquan@oppo.com>, Lance Yang <ioworker0@gmail.com>,
 Zi Yan <ziy@nvidia.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>
References: <20250805035447.7958-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250805035447.7958-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/5 11:54, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The check_pmd_still_valid() call during collapse is currently only
> protected by the mmap_lock in write mode, which was sufficient when
> pt_reclaim always ran under mmap_lock in read mode. However, since
> madvise_dontneed can now execute under a per-VMA lock, this assumption
> is no longer valid. As a result, a race condition can occur between
> collapse and PT_RECLAIM, potentially leading to a kernel panic.
> 
>   [   38.151897] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASI
>   [   38.153519] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>   [   38.154605] CPU: 0 UID: 0 PID: 721 Comm: repro Not tainted 6.16.0-next-20250801-next-2025080 #1 PREEMPT(voluntary)
>   [   38.155929] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org4
>   [   38.157418] RIP: 0010:kasan_byte_accessible+0x15/0x30
>   [   38.158125] Code: 03 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc0
>   [   38.160461] RSP: 0018:ffff88800feef678 EFLAGS: 00010286
>   [   38.161220] RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 1ffffffff0dde60c
>   [   38.162232] RDX: 0000000000000000 RSI: ffffffff85da1e18 RDI: dffffc0000000003
>   [   38.163176] RBP: ffff88800feef698 R08: 0000000000000001 R09: 0000000000000000
>   [   38.164195] R10: 0000000000000000 R11: ffff888016a8ba58 R12: 0000000000000018
>   [   38.165189] R13: 0000000000000018 R14: ffffffff85da1e18 R15: 0000000000000000
>   [   38.166100] FS:  0000000000000000(0000) GS:ffff8880e3b40000(0000) knlGS:0000000000000000
>   [   38.167137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   38.167891] CR2: 00007f97fadfe504 CR3: 0000000007088005 CR4: 0000000000770ef0
>   [   38.168812] PKRU: 55555554
>   [   38.169275] Call Trace:
>   [   38.169647]  <TASK>
>   [   38.169975]  ? __kasan_check_byte+0x19/0x50
>   [   38.170581]  lock_acquire+0xea/0x310
>   [   38.171083]  ? rcu_is_watching+0x19/0xc0
>   [   38.171615]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>   [   38.172343]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
>   [   38.173130]  _raw_spin_lock+0x38/0x50
>   [   38.173707]  ? __pte_offset_map_lock+0x1a2/0x3c0
>   [   38.174390]  __pte_offset_map_lock+0x1a2/0x3c0
>   [   38.174987]  ? __pfx___pte_offset_map_lock+0x10/0x10
>   [   38.175724]  ? __pfx_pud_val+0x10/0x10
>   [   38.176308]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
>   [   38.177183]  unmap_page_range+0xb60/0x43e0
>   [   38.177824]  ? __pfx_unmap_page_range+0x10/0x10
>   [   38.178485]  ? mas_next_slot+0x133a/0x1a50
>   [   38.179079]  unmap_single_vma.constprop.0+0x15b/0x250
>   [   38.179830]  unmap_vmas+0x1fa/0x460
>   [   38.180373]  ? __pfx_unmap_vmas+0x10/0x10
>   [   38.180994]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>   [   38.181877]  exit_mmap+0x1a2/0xb40
>   [   38.182396]  ? lock_release+0x14f/0x2c0
>   [   38.182929]  ? __pfx_exit_mmap+0x10/0x10
>   [   38.183474]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>   [   38.184188]  ? mutex_unlock+0x16/0x20
>   [   38.184704]  mmput+0x132/0x370
>   [   38.185208]  do_exit+0x7e7/0x28c0
>   [   38.185682]  ? __this_cpu_preempt_check+0x21/0x30
>   [   38.186328]  ? do_group_exit+0x1d8/0x2c0
>   [   38.186873]  ? __pfx_do_exit+0x10/0x10
>   [   38.187401]  ? __this_cpu_preempt_check+0x21/0x30
>   [   38.188036]  ? _raw_spin_unlock_irq+0x2c/0x60
>   [   38.188634]  ? lockdep_hardirqs_on+0x89/0x110
>   [   38.189313]  do_group_exit+0xe4/0x2c0
>   [   38.189831]  __x64_sys_exit_group+0x4d/0x60
>   [   38.190413]  x64_sys_call+0x2174/0x2180
>   [   38.190935]  do_syscall_64+0x6d/0x2e0
>   [   38.191449]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This patch moves the vma_start_write() call to precede
> check_pmd_still_valid(), ensuring that the check is also properly
> protected by the per-VMA lock.
> 
> Fixes: a6fde7add78d ("mm: use per_vma lock for MADV_DONTNEED")
> Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/all/aJAFrYfyzGpbm+0m@ly-workstation/
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

