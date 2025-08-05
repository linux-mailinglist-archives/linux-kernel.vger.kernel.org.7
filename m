Return-Path: <linux-kernel+bounces-755997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6568B1AE80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E66B173E96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C611C861A;
	Tue,  5 Aug 2025 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c9fNJW5B"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBE1EEA5D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376190; cv=none; b=M7L3/xLwgAz9489uw0c/K2tNH+KBpO4Md8GXaKjEM7tMtEBQ86nbFaGwZffnJsjuUAPJ+RaoAYPVGiXmicJs967ULy3lJoGXB5UpRlvtg030OYtYNlqApAgHpMpwVoBSUAsPDIdzLMfh6LRcW6wX+2i8a9YH3JA+ywcDZ5+r/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376190; c=relaxed/simple;
	bh=YYGYwiRhWMF11vSAo0hpe4SgGa2dFiHZF6UrCnwZ3hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+ZM121KQMg3imnSm4n8o4gwiYygIhjWLMR+kKKRqdYVMYmJvOC5aEtPqYJhPDncfERe7mbGMuZdU6P/t7KOZ1f67l/p3F0pfMp3GSYcaLG1WYAoH07xeK3kSPWokHsADzLiTBGHEdZnbo6w6B5gtlWNTJt8ecZIyIEqrwtnVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c9fNJW5B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b424d2eb139so1778590a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754376188; x=1754980988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9nhYHdVYijXwXhKsqe5CscEEMmPinucJwaX/wDudLk=;
        b=c9fNJW5BQ8o4imag1g31HWfZlnhfx97M40aI8R2nYhgdH1qCV/BQPWcnlu0zcGk4M+
         LfvzL68qRmQN8xmXFCuk3tYwuw10BpppW1EgEL8RaPxvr55wv1Ol4o87S7p2jRABA4mv
         9haKS2OYvQbGOSnRBVR3jaVrCXV68DJ+BLlkvsDF6KVvcHvZSsfZrOOUzholaQ4I2MUc
         fv00ELRIF+JCvWkDr4GfHpd26KYSeR2aSeptXr0Qwn+3tsdzLMV7m64Z1tL/89dk0+zy
         wteu1g/HeosjFeqUc+iFH3Am2QTB8apICeZUUoaeG6B08V67Es68tXnKN9Bc2OyrPVrH
         lBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376188; x=1754980988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9nhYHdVYijXwXhKsqe5CscEEMmPinucJwaX/wDudLk=;
        b=o0bVM8YENSDdZn/wBzLBEbLq1htKA24sygNq5mKIlbFYKQU59zdJdqyuF7YyS5oQr0
         zQQXjoPCS+d9fHpasC7Frpn7wLWTJolv6d4wRgpep6mjKOgpib47Y0Fodp0pLImLk7mx
         rTd2nJbpuL/pOR2yfHG35udkEcHWj8akomHyEz5owjmfjByFcwfrlAYHai5zYaUjPyzM
         FGqnPT8xRuhXDATkdIfLMNgFZ++9JPL6GgMyKFeXRQhc0+Gi4cRpb011VI473RYXoXms
         yM1vT99CLJBAJmDny8AyYAs+rghS1kcu9Lta7S00RF1AIAC1VbygzSFK6/Uw+KWO6vwy
         Vbgw==
X-Gm-Message-State: AOJu0YwoF3iTJLk6TydGwEfuxJxCyOfkhp1tTs9R4TiM5JS9sh+IfTCg
	Ej03uOVlPx4r+SJ3lvQTFY2yXaXw008zX/oDvv6ac5vdGWgu9lK+p8ajdjHj1Ngycl4=
X-Gm-Gg: ASbGncsqRfMsmqE5s6S+A8p/qnusl/63992YepETOBMFhTKskJuIBz+O1TU/umGgki8
	BYRItooFqudf7BjzPXQAIIYXIEVMAAjcntZYUTbs/pYcTBGQPpfbLwfSA+/f2CZcrfCE5HVeRdL
	HP0RjCiqU5VYSak+WGo7R70Wjcajz59sk2GHjYspg1MDdpBg1jAuZUfykG5CqdcGc84AQqptH2Q
	CNsZO0w+3uLbxH3E1l+aTPRtU5fsX9uX4MBKvkLoC3xyZZcXjc9dlQXgWKtKIujbdZmCOl55rtx
	8k9MWrDUqFcdf/48cPUYByDmOhWM+hOLaJO7Ay1nTrol/jUH2vmcbvUp4pciZX+ibzd8ET++M6K
	+A23NFtDTj7gSaHtRZKSG5nbyeU6rUq+pFV8r/DWjDGJBtZMvSRtixR+Qp/j5
X-Google-Smtp-Source: AGHT+IH6NKePpdklUEnERKhxy8cHNhExcNHW5IOQAP4eRTVMhTlFfu5DUYuvB7IhXb/s4ZjlKfsy4Q==
X-Received: by 2002:a17:90b:33c4:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-3214feb327dmr3290114a91.15.1754376187896;
        Mon, 04 Aug 2025 23:43:07 -0700 (PDT)
Received: from [10.4.54.91] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm13561149a91.10.2025.08.04.23.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 23:43:07 -0700 (PDT)
Message-ID: <35417160-86bf-4580-8ae9-5cadd4f6401d@bytedance.com>
Date: Tue, 5 Aug 2025 14:42:58 +0800
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
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>
References: <20250805035447.7958-1-21cnbao@gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250805035447.7958-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Barry,

On 8/5/25 11:54 AM, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The check_pmd_still_valid() call during collapse is currently only
> protected by the mmap_lock in write mode, which was sufficient when
> pt_reclaim always ran under mmap_lock in read mode. However, since
> madvise_dontneed can now execute under a per-VMA lock, this assumption
> is no longer valid. As a result, a race condition can occur between
> collapse and PT_RECLAIM, potentially leading to a kernel panic.

There is indeed a race condition here. And after applying this patch, I
can no longer reproduce the problem locally (I was able to reproduce it
stably locally last night).

But I still can't figure out how this race condtion causes the
following panic:

exit_mmap
--> mmap_read_lock()
     unmap_vmas()
     --> pte_offset_map_lock
         --> rcu_read_lock()
             check if the pmd entry is a PTE page
             ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
             spin_lock(ptl)                  <-- PANIC!!

If this PTE page is freed by pt_reclaim (via RCU), then the ptl can not 
be NULL.

The collapse holds mmap write lock, so it is impossible to be concurrent
with exit_mmap().

Confusing. :(


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
>   mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 374a6a5193a7..6b40bdfd224c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1172,11 +1172,11 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	if (result != SCAN_SUCCEED)
>   		goto out_up_write;
>   	/* check if the pmd is still valid */
> +	vma_start_write(vma);
>   	result = check_pmd_still_valid(mm, address, pmd);
>   	if (result != SCAN_SUCCEED)
>   		goto out_up_write;
>   
> -	vma_start_write(vma);
>   	anon_vma_lock_write(vma->anon_vma);
>   
>   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,


