Return-Path: <linux-kernel+bounces-850386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ABBD2ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734924E60D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D12241139;
	Mon, 13 Oct 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IhoJKFb3"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640619D087
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353248; cv=none; b=XwhXQpe23773aso1NqH/BXr+azVJDhswPPR09CHr8WVihpRyff6nGKylMfBhhZ2ycdeMwSBUGmmxY4NHmreCCoy1weJt+2Cbno8PuRNDT5lfgHSn5gAlDfWPDnlU3nI+R5Ek+noRMz5hUn3XiY2zB4ou0TH67lNTYQVf2RRV7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353248; c=relaxed/simple;
	bh=mEnuHDd9zGtiv6AhQdy2ieRF0Bsnl45fWtLkGpN7IPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7RRvrOpPp5lXNM+SyDWpYJehlWt/ErxITbfdtjzA0sA0F4Pca36eFF9UX77fQnBuNx8QKQ8XOjyj4fgi1TKyn4kV+dcM2wb9RY3tzNMvj/+ipmieu8FOIaUqmThXYp+5X3rtaaG0NGEx7ZJoQZ8TfxO/DEdOzm4gear5p07MH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IhoJKFb3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c129e522-853e-45c7-a064-34c25e63e610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760353243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1V0QqXKTj8ZcNMA+dAf03zBCdE/xeeZHahyNYqCg5k=;
	b=IhoJKFb3ziQ/8pq+DlNF1eFjNpLYLPXCUowndf8ldIIqgeFNiWPTGvKTFRZc8IJrm6kcP3
	rYzLs5q2JSg6rbQc1MRIsV6qF1w0aJw/TL227OUBEQuF0/bUHxh2SbN8IDkdV35ZHOwhu/
	gYp95dKvcIzhgEEfuZTGY7ZgYEw7nF4=
Date: Mon, 13 Oct 2025 19:00:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, Miaohe Lin <linmiaohe@huawei.com>, qiuxu.zhuo@intel.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
 <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
 <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
 <bd374ac3-05a2-41ae-8043-cc3575fb13c0@linux.dev>
 <3e6500dc-723f-4682-9e37-b28bc78a2bdb@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <3e6500dc-723f-4682-9e37-b28bc78a2bdb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/13 17:25, David Hildenbrand wrote:
> On 13.10.25 11:15, Lance Yang wrote:
>> @David
>>
>> Cc: MM CORE folks
>>
>> On 2025/10/13 12:42, Lance Yang wrote:
>> [...]
>>
>> Cool. Hardware error injection with EINJ was the way to go!
>>
>> I just ran some tests on the shared zero page (both regular and huge), 
>> and
>> found a tricky behavior:
>>
>> 1) When a hardware error is injected into the zeropage, the process that
>> attempts to read from a mapping backed by it is correctly killed with a
>> SIGBUS.
>>
>> 2) However, even after the error is detected, the kernel continues to
>> install
>> the known-poisoned zeropage for new anonymous mappings ...
>>
>>
>> For the shared zeropage:
>> ```
>> [Mon Oct 13 16:29:02 2025] mce: Uncorrected hardware memory error in
>> user-access at 29b8cf5000
>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: Sending SIGBUS to
>> read_zeropage:13767 due to hardware memory corruption
>> [Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: recovery action
>> for already poisoned page: Failed
>> ```
>> And for the shared huge zeropage:
>> ```
>> [Mon Oct 13 16:35:34 2025] mce: Uncorrected hardware memory error in
>> user-access at 1e1e00000
>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: Sending SIGBUS to
>> read_huge_zerop:13891 due to hardware memory corruption
>> [Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: recovery action for
>> already poisoned page: Failed
>> ```
>>
>> Since we've identified an uncorrectable hardware error on such a 
>> critical,
>> singleton page, should we be doing something more?
> 
> I mean, regarding the shared zeropage, we could try walking all page 
> tables of all processes and replace it be a fresh shared zeropage.
> 
> But then, the page might also be used for other things (I/O etc), the 
> shared zeropage is allocated by the architecture, we'd have to make 
> is_zero_pfn() succeed on the old+new page etc ...
> 
> So a lot of work for little benefit I guess? The question is how often 
> we would see that in practice. I'd assume we'd see it happen on random 
> kernel memory more frequently where we can really just bring down the 
> whole machine.

Thanks for your thoughts!

I agree, fixing the regular zeropage is a really mess ...

But for the huge zeropage, what if we just stop installing it once it's
poisoned? We could just disable it globally. Something like this:

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f698df156bf8..8543f4385ffe 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2193,6 +2193,10 @@ int memory_failure(unsigned long pfn, int flags)
         if (!(flags & MF_SW_SIMULATED))
                 hw_memory_failure = true;

+       if (is_huge_zero_pfn(pfn))
+               clear_bit(TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+                         &transparent_hugepage_flags);
+
         p = pfn_to_online_page(pfn);
         if (!p) {
                 res = arch_memory_failure(pfn, flags);

Seems easy enough ...

