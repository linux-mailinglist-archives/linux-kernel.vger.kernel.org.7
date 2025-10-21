Return-Path: <linux-kernel+bounces-863078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3FBF6F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D783B89FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254433A039;
	Tue, 21 Oct 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N2wRm8Yf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C49339717
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055294; cv=none; b=PAOx1r1TifaXVmrxdJJ8xWhmB+tVvSgLKy4CRsOP0vFihDu6P8LKR1w4No1Jeh0zpkpg8jteUb8yXgVjZTUQ9W8rTo1DsZ4bDyAmUuwczKOlEApJa6dtbhXjtlxr9EYjV/ZoxD9usY3SAYxxm4X/cov0ij4L2wGdXuYlXx7YcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055294; c=relaxed/simple;
	bh=nr3v+KAv0bsSo2UoizMT3KfogG9BEzVDV05jre07CTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUNFqKwi44ewW3eVuKchmMWiM2QvoOlQ8jWjaOEIzgyXz1Houil+iZVS467FquId5IAZ3BNCIkqVscdCHPJ5q1J2WcK3ZsG8H8lSq73uDKW+sgccavfmO2lCOnu7xLs5YOgKCotvEkgBp2ICuVqs3KnwpCMkGGXvFOCIrcPb3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N2wRm8Yf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4nZFcTjd7RKIj1S03JiY9y5f0peW613Ihxf8XSZrzbU=;
	b=N2wRm8YftuBOdPpfW4sjGGEeCJplxM1h+32RHJb02QWAJvQ/hC4Dq/Vao19vFX
	xZFcNEgBivkwKdg1fe+RbxcbxIvEFZyG0RY++hOpMCV45pk9/W69Rg0X13uSHaNB
	wo4RFJFsEGPDB//oe9IwY/ED26V3ZYZ4Sp79QkqFVKBR0=
Received: from [IPV6:240e:46c:1400:1724:2929:d8e0:886d:7a3a] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHTvb_kfdoKgo2Bw--.44574S2;
	Tue, 21 Oct 2025 22:00:33 +0800 (CST)
Message-ID: <122ef241-787d-4e8c-82cf-01ff318293a6@163.com>
Date: Tue, 21 Oct 2025 22:00:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: David Hildenbrand <david@redhat.com>, linmiaohe@huawei.com,
 lance.yang@linux.dev
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <7e533422-1707-4fea-9350-0e832cf24a83@redhat.com>
From: Long long Xia <xialonglong2025@163.com>
In-Reply-To: <7e533422-1707-4fea-9350-0e832cf24a83@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHTvb_kfdoKgo2Bw--.44574S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1fXrW7XF1xtw4UGr45Jrb_yoWftrWDpF
	WxJF4vkr48XFyxW3WIgwn7uryaq34DCw4UKwnagw10kw4Fg34qyr18Jw4rWF47Zr4Fka1x
	JaykXr17Ka1YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsR6rUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBgAnt+Gj3hgOvXQAAs0

Thanks for the reply.

I do some simple tests.
I hope these findings are helpful for the community's review.

1.Test VM
Configuration
Hardware: x86_64 QEMU VM, 1 vCPU, 256MB RAM per guest
Kernel: 6.6.89

Testcase1: Single VM and enable KSM

- VM Memory Usage:
   * RSS Total  = 275028 KB (268 MB)
   * RSS Anon   = 253656 KB (247 MB)
   * RSS File   = 21372 KB (20 MB)
   * RSS Shmem  = 0 KB (0 MB)

a.Traverse the stable tree
b. pages on the chain
2 chains detected
Chain #1: 51 duplicates, 12,956 pages (~51 MB)
Chain #2: 15 duplicates, 3,822 pages (~15 MB)
Average: 8,389 pages per chain
Sum: 16778 pages (64.6% of ksm_pages_sharing + ksm_pages_shared)
c. pages on the chain
Non-chain pages: 9,209 pages
d.chain_count = 2, not_chain_count = 4200
e.
/sys/kernel/mm/ksm/ksm_pages_sharing = 21721
/sys/kernel/mm/ksm/ksm_pages_shared = 4266
/sys/kernel/mm/ksm/ksm_pages_unshared = 38098


Testcase2: 10 VMs and enable KSM
a.Traverse the stable tree
b.Pages on the chain
8 chains detected
Chain #1: 458 duplicates, 117,012 pages (~457 MB)
Chain #2: 150 duplicates, 38,231 pages (~149 MB)
Chain #3: 10 duplicates, 2,320 pages (~9 MB)
Chain #4: 8 duplicates, 1,814 pages (~7 MB)
Chain #5-8: 4, 3, 3, 2 duplicates (920, 720, 600, 260 pages)
Average: 20,235 pages per chain
Sum: 161877 pages (44.5% of ksm_pages_sharing + ksm_pages_shared)
c.Pages on the chain
Non-chain pages: 201,486
d.chain_count = 8, not_chain_count = 15936
e.
/sys/kernel/mm/ksm/ksm_pages_sharing = 346789
/sys/kernel/mm/ksm/ksm_pages_shared = 16574
/sys/kernel/mm/ksm/ksm_pages_unshared = 264918


2.Test firefox browser
​I open 10 Firefox browser windows, perform random searches, and then 
enable KSM

a.page_not_chain = 4043
b.chain_pages = 936 (18.8% of ksm_pages_sharing + ksm_pages_shared)
c.chain_count = 2, not_chain_count = 424
d.
/sys/kernel/mm/ksm/ksm_pages_sharing = 4554
/sys/kernel/mm/ksm/ksm_pages_shared = 425
/sys/kernel/mm/ksm/ksm_pages_unshared = 18461


Surprisingly, although chains are few in number, they contribute
significantly to the overall savings. In the 10-VM scenario, only 8 chains
produce 161,877 pages (44.5% of total), while thousands of non-chain groups
contribute the remaining 55.5%.

I would appreciate any feedback or suggestions.

Best regards,
Longlong Xia

在 2025/10/16 18:46, David Hildenbrand 写道:
> On 16.10.25 12:18, Longlong Xia wrote:
>> When a hardware memory error occurs on a KSM page, the current
>> behavior is to kill all processes mapping that page. This can
>> be overly aggressive when KSM has multiple duplicate pages in
>> a chain where other duplicates are still healthy.
>>
>> This patch introduces a recovery mechanism that attempts to
>> migrate mappings from the failing KSM page to a newly
>> allocated KSM page or another healthy duplicate already
>> present in the same chain, before falling back to the
>> process-killing procedure.
>>
>> The recovery process works as follows:
>> 1. Identify if the failing KSM page belongs to a stable node chain.
>> 2. Locate a healthy duplicate KSM page within the same chain.
>> 3. For each process mapping the failing page:
>>     a. Attempt to allocate a new KSM page copy from healthy duplicate
>>        KSM page. If successful, migrate the mapping to this new KSM 
>> page.
>>     b. If allocation fails, migrate the mapping to the existing healthy
>>        duplicate KSM page.
>> 4. If all migrations succeed, remove the failing KSM page from the 
>> chain.
>> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>>     error) does the kernel fall back to killing the affected processes.
>>
>> The original idea came from Naoya Horiguchi.
>> https://lore.kernel.org/all/20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp/ 
>>
>>
>> I test it with einj in physical machine x86_64 CPU Intel(R) Xeon(R) 
>> Gold 6430.
>>
>> test shell script
>> modprobe einj 2>/dev/null
>> echo 0x10 > /sys/kernel/debug/apei/einj/error_type
>> echo $ADDRESS > /sys/kernel/debug/apei/einj/param1
>> echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
>> echo 1 > /sys/kernel/debug/apei/einj/error_inject
>>
>> FIRST WAY: allocate a new KSM page copy from healthy duplicate
>> 1. alloc 1024 page with same content and enable KSM to merge
>> after merge (same phy_addr only print once)
>> virtual addr = 0x71582be00000  phy_addr =0x124802000
>> virtual addr = 0x71582bf2c000  phy_addr =0x124902000
>> virtual addr = 0x71582c026000  phy_addr =0x125402000
>> virtual addr = 0x71582c120000  phy_addr =0x125502000
>>
>>
>> 2. echo 0x124802000 > /sys/kernel/debug/apei/einj/param1
>> virtual addr = 0x71582be00000  phy_addr =0x1363b1000 (new allocated)
>> virtual addr = 0x71582bf2c000  phy_addr =0x124902000
>> virtual addr = 0x71582c026000  phy_addr =0x125402000
>> virtual addr = 0x71582c120000  phy_addr =0x125502000
>>
>>
>> 3. echo 0x124902000 > /sys/kernel/debug/apei/einj/param1
>> virtual addr = 0x71582be00000  phy_addr =0x1363b1000
>> virtual addr = 0x71582bf2c000  phy_addr =0x13099a000 (new allocated)
>> virtual addr = 0x71582c026000  phy_addr =0x125402000
>> virtual addr = 0x71582c120000  phy_addr =0x125502000
>>
>> kernel-log:
>> mce: [Hardware Error]: Machine check events logged
>> ksm: recovery successful, no need to kill processes
>> Memory failure: 0x124802: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x124802: recovery action for already poisoned page: 
>> Failed
>> ksm: recovery successful, no need to kill processes
>> Memory failure: 0x124902: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x124902: recovery action for already poisoned page: 
>> Failed
>>
>>
>> SECOND WAY: Migrate the mapping to the existing healthy duplicate KSM 
>> page
>> 1. alloc 1024 page with same content and enable KSM to merge
>> after merge (same phy_addr only print once)
>> virtual addr = 0x79a172000000  phy_addr =0x141802000
>> virtual addr = 0x79a17212c000  phy_addr =0x141902000
>> virtual addr = 0x79a172226000  phy_addr =0x13cc02000
>> virtual addr = 0x79a172320000  phy_addr =0x13cd02000
>>
>> 2 echo 0x141802000 > /sys/kernel/debug/apei/einj/param1
>> a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
>> b.virtual addr = 0x79a17212c000  phy_addr =0x141902000
>> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
>> d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a)
>>
>> 3.echo 0x141902000 > /sys/kernel/debug/apei/einj/param1
>> a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
>> b.virtual addr = 0x79a172032000  phy_addr =0x13cd02000 (share with a)
>> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
>> d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a)
>>
>> 4. echo 0x13cd02000 > /sys/kernel/debug/apei/einj/param1
>> a.virtual addr = 0x79a172000000  phy_addr =0x13cc02000
>> b.virtual addr = 0x79a172032000  phy_addr =0x13cc02000 (share with a)
>> c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000 (share with a)
>> d.virtual addr = 0x79a172320000  phy_addr =0x13cc02000 (share with a)
>>
>> 5. echo 0x13cc02000 > /sys/kernel/debug/apei/einj/param1
>> Bus error (core dumped)
>>
>> kernel-log:
>> mce: [Hardware Error]: Machine check events logged
>> ksm: recovery successful, no need to kill processes
>> Memory failure: 0x141802: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x141802: recovery action for already poisoned page: 
>> Failed
>> ksm: recovery successful, no need to kill processes
>> Memory failure: 0x141902: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x141902: recovery action for already poisoned page: 
>> Failed
>> ksm: recovery successful, no need to kill processes
>> Memory failure: 0x13cd02: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x13cd02: recovery action for already poisoned page: 
>> Failed
>> Memory failure: 0x13cc02: recovery action for dirty LRU page: Recovered
>> Memory failure: 0x13cc02: recovery action for already poisoned page: 
>> Failed
>> MCE: Killing ksm_addr:5221 due to hardware memory corruption fault at 
>> 79a172000000
>>
>> ZERO PAGE TEST:
>> when I test in physical machine x86_64 CPU Intel(R) Xeon(R) Gold 6430
>> [shell]# ./einj.sh 0x193f908000
>> ./einj.sh: line 25: echo: write error: Address already in use
>>
>> when I test in qemu-x86_64.
>> Injecting memory failure at pfn 0x3a9d0c
>> Memory failure: 0x3a9d0c: unhandlable page.
>> Memory failure: 0x3a9d0c: recovery action for get hwpoison page: Ignored
>>
>> It seems return early before enter this patch's functions.
>>
>> Thanks for review and comments!
>>
>> Changes in v2:
>>
>> - Implemented a two-tier recovery strategy: preferring newly allocated
>>    pages over existing duplicates to avoid concentrating mappings on a
>>    single page suggested by David Hildenbrand
>
> I also asked how relevant this is in practice [1]
>
> "
> But how realistic do we consider that in practice? We need quite a bunch
> of processes to dedup the same page to end up getting duplicates in the
> chain IIRC.
>
> So isn't this rather an improvement only for less likely scenarios in
> practice?
> "
>
> In particular for your test "alloc 1024 page with same content".
>
> It certainly adds complexity, so we should clarify if this is really 
> worth it.
>
> [1] 
> https://lore.kernel.org/all/8c4d8ebe-885e-40f0-a10e-7290067c7b96@redhat.com/
>


