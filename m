Return-Path: <linux-kernel+bounces-844102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9206BC101D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7385A3B0C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4722D8385;
	Tue,  7 Oct 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqKqFZgI"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC9199FB0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832730; cv=none; b=YB+llISIWlqT/QWWW0i3LxvNRD44EI50HXuqAoL5s8epmY2nkJz8w/p6d5GYjA3VD4vD7+AGPosljFbLEZ34/1qfBCqhyz0FHl+ZMLsvy0GFa2BqMCKX5bilebFx8xWjhTugAWR8XolJ0EarMWEU4q04l70SOhSY+3FNlB4VOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832730; c=relaxed/simple;
	bh=awBlR7WnH5/q5PpQZ6m/q7Kf9H3kP4DeNgkE85JqHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed7URvdjy8mH3uwnOr5Khfr2TfMp1mxg3TyzPndqVq8tBDpr3l9FbzKZKCwzEeBGgW8naG8qeGE40JhpnPZHmWDgDQtfPaFLr6Gcps3dgjbBIlvtMV3W3v4QGKvv6DcNnuTtutJhIVkrC9ZwbQAIk36KXhR0mGsRUe9XYWEZojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqKqFZgI; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29742109-13c2-4fa6-a3a1-d12b14641404@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759832724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1Qr/71x7vAffwB+BoaxiI5z0WOOCKgzr0UJkBVFUpE=;
	b=SqKqFZgIYKoV0S7J1CAQvyvkQcIPcwSyhGfTQdAamHUi4SyOW6IQF6JGbtTOkwnMkM1rcl
	6vugkpgjvz1qVgjBuy0wj17KViXX/gE9oDjC4CWp7PGYsMOmuHTQoaX1xWXdRN9rITI3lR
	Z5DDHIjcA2+A6I5UU0ZU9ouNNrA27yI=
Date: Tue, 7 Oct 2025 18:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
 <20251005010511.ysek2nqojebqngf3@master>
 <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
 <09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/6 22:18, David Hildenbrand wrote:
> On 05.10.25 04:12, Lance Yang wrote:
>>
>>
>> On 2025/10/5 09:05, Wei Yang wrote:
>>> On Wed, Oct 01, 2025 at 06:05:57PM +0800, Lance Yang wrote:
>>>>
>>>>
>>>> On 2025/10/1 16:54, Wei Yang wrote:
>>>>> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>
>>>>>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>>>>>> markers) are not caught early in hpage_collapse_scan_pmd(), 
>>>>>> leading to
>>>>>> failures deep in the swap-in logic.
>>>>>>
>>>>>> hpage_collapse_scan_pmd()
>>>>>> `- collapse_huge_page()
>>>>>>        `- __collapse_huge_page_swapin() -> fails!
>>>>>>
>>>>>> As David suggested[1], this patch skips any such non-swap entries
>>>>>> early. If any one is found, the scan is aborted immediately with the
>>>>>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>>>>>> work.
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb- 
>>>>>> a7c8-1ba64fd6df69@redhat.com
>>>>>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680- 
>>>>>> dcd55219c8bd@lucifer.local
>>>>>>
>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>>> ---
>>>>>> v1 -> v2:
>>>>>> - Skip all non-present entries except swap entries (per David) 
>>>>>> thanks!
>>>>>> - https://lore.kernel.org/linux-mm/20250924100207.28332-1- 
>>>>>> lance.yang@linux.dev/
>>>>>>
>>>>>> mm/khugepaged.c | 32 ++++++++++++++++++--------------
>>>>>> 1 file changed, 18 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>>> index 7ab2d1a42df3..d0957648db19 100644
>>>>>> --- a/mm/khugepaged.c
>>>>>> +++ b/mm/khugepaged.c
>>>>>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct 
>>>>>> mm_struct *mm,
>>>>>>     for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>>>>          _pte++, addr += PAGE_SIZE) {
>>>>>>         pte_t pteval = ptep_get(_pte);
>>>>>> -        if (is_swap_pte(pteval)) {
>>>>>
>>>>> It looks is_swap_pte() is mis-leading?
>>>>
>>>> Hmm.. not to me, IMO. is_swap_pte() just means:
>>>>
>>>> !pte_none(pte) && !pte_present(pte)
>>>>
>>>
>>> Maybe it has some reason.
>>>
>>> I took another look into __collapse_huge_page_swapin(), which just check
>>> is_swap_pte() before do_swap_page().
> 
> Thanks for pointing that out.
> 
> A function that is called __collapse_huge_page_swapin() and documented 
> to "Bring missing pages in from swap" will handle other types as well.
> 
> Unbelievable horrible.
> 
> So let's think this through so we can document it in the changelog 
> properly.
> 
> We could have currently ended up in do_swap_page() with
> 
> (1) Migration entries. We would have waited.
> 
> -> Maybe worth it to wait, maybe not. I suspect we don't stumble into
>     that frequently such that we don't care. We could always unlock this
>     separately later.
> 
> 
> (2) Device-exclusive entries. We would have converted to non-exclusive.
> 
> -> See make_device_exclusive(), we cannot tolerate PMD entries and have
>     to split them through FOLL_SPLIT_PMD. As popped up during a recent
>     discussion, collapsing here is actually counter-productive, because
>     the next conversion will PTE-map it again. (until recently, it would
>     not have worked with large folios at all IIRC).
> 
> -> Ok to not collapse.
> 
> (3) Device-private entries. We would have migrated to RAM.
> 
> -> Device-private still does not support THPs, so collapsing right now 
> just means that the next device access would split the folio again.
> 
> -> Ok to not collapse.
> 
> (4) HWPoison entries
> 
> -> Cannot collapse
> 
> (5) Markers
> 
> -> Cannot collapse
> 
> 
> I suggest we add that in some form to the patch description, stating 
> that we can unlock later what we really need, and not account it towards 
> max_swap_ptes.
> 
>>>
>>> We have filtered non-swap entries in hpage_collapse_scan_pmd(), but 
>>> we drop
>>> mmap lock before isolation. This looks we may have a chance to get 
>>> non-swap
>>> entry.
>>
>> Thanks for pointing that out!
>>
>> Yep, there is a theoretical window between dropping the mmap lock
>> after the initial scan and re-acquiring it for isolation.
>>
>>>
>>> Do you think it is reasonable to add a non_swap_entry() check before
>>> do_swap_page()?
>>
>> However, that seems unlikely in practice. IMHO, the early check in
>> hpage_collapse_scan_pmd() is sufficient for now, so I'd prefer to
>> keep it as-is :)
> 
> I think we really should add that check, as per reasoning above.
> 
> I was looking into some possible races with uffd-wp being set before we 
> enter do_swap_page(), but I think it might be okay (although very 
> confusing).

How about the version below?

```
Currently, special non-swap entries (like PTE markers) are not caught
early in hpage_collapse_scan_pmd(), leading to failures deep in the
swap-in logic.

A function that is called __collapse_huge_page_swapin() and documented
to "Bring missing pages in from swap" will handle other types as well.

As analyzed by David[1], we could have ended up with the following
entry types right before do_swap_page():

   (1) Migration entries. We would have waited.
       -> Maybe worth it to wait, maybe not. We suspect we don't stumble
          into that frequently such that we don't care. We could always
          unlock this separately later.

   (2) Device-exclusive entries. We would have converted to non-exclusive.
       -> See make_device_exclusive(), we cannot tolerate PMD entries and
          have to split them through FOLL_SPLIT_PMD. As popped up during
          a recent discussion, collapsing here is actually
          counter-productive, because the next conversion will PTE-map
          it again.
       -> Ok to not collapse.

   (3) Device-private entries. We would have migrated to RAM.
       -> Device-private still does not support THPs, so collapsing right
          now just means that the next device access would split the
          folio again.
       -> Ok to not collapse.

   (4) HWPoison entries
       -> Cannot collapse

   (5) Markers
       -> Cannot collapse

First, this patch adds an early check for these non-swap entries. If
any one is found, the scan is aborted immediately with the
SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
work.

Second, as Wei pointed out[3], we may have a chance to get a non-swap
entry, since we will drop and re-acquire the mmap lock before
__collapse_huge_page_swapin(). To handle this, we also add a
non_swap_entry() check there.

Note that we can unlock later what we really need, and not account it
towards max_swap_ptes.

[1] 
https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
[2] 
https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
[3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master
```

I also think it makes sense to fold the change that adds the
non_swap_entry() check in __collapse_huge_page_swapin() into
this patch, rather than creating a new patch just for that :)

Hmmm... one thing I'm not sure about: regarding the uffd-wp
race you mentioned, is the pte_swp_uffd_wp() check needed
after non_swap_entry()? It seems like it might not be ...

```
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f4f57ba69d72..bec3e268dc76 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct 
mm_struct *mm,
  		if (!is_swap_pte(vmf.orig_pte))
  			continue;

+		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
+			result = SCAN_PTE_NON_PRESENT;
+			goto out;
+		}
+
  		vmf.pte = pte;
  		vmf.ptl = ptl;
  		ret = do_swap_page(&vmf);
```

@David does that sound good to you?

