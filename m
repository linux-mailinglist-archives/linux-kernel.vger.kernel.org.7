Return-Path: <linux-kernel+bounces-826660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4CAB8F101
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9D71789F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244218DB1F;
	Mon, 22 Sep 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MW888rvK"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1826AEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520955; cv=none; b=T5WFKS1d0o+8sTw8kgzzIoUNiKj9b3rOVXbC4BdALNPHW92j0yWRXAt0GQIc3Cc9HP8/raxGV6Kx1GFjSLncAZz03LsQRAnyCf9g0n8BWya0SaP3jePcrVi2ffjOKoUFWWChVR6sd8FkNKX/KS03xz/TPCntNwpAx3e5a4gWiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520955; c=relaxed/simple;
	bh=wO7oZjCBLCBVcx0E/BeTPMM8qaQ3IU4vYENbcmGuNcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIl+30lgG0zRzh3LIAGzdF3nU0ZFqiKzr/oHumIRZGLNo4YIULEujEnaQqp0cqe/0xujWDcgsNJ/q/2cNrAAMNMih44HKiWibrdY68cz8/lpkG/+SpJddWy4h+9z4HlqdME+MxvM5kN7Auq2iuXxHc2eCqKI0FdhjwmLPkFF4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MW888rvK; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758520950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mtqUfqd4lMiGo6Ala6WXTiJWCiC2KxDk241gcLH8Hc4=;
	b=MW888rvKTBHQ/rdvh2Hg2crxiFFR0268ap1aOjb4dJzILRth4Eqi/11WizkKuNViBL/5560r5wPZ42uF7jbuELza5W3BgJrEw8QKQz+uEpQ6mY3iPcIUhc3HuiYTFQS9e+QYi2f0aSICQZODTj4GqsTCxJi0neay0u8WWZQ+Zsw=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoRwKND_1758520948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 14:02:28 +0800
Message-ID: <392a9ca3-31ac-4447-bd44-3c656d63e4ca@linux.alibaba.com>
Date: Mon, 22 Sep 2025 14:02:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
 <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
 <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com>
 <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
 <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z>
 <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
 <74e0af46-18a0-8c4a-5ae5-3cba69ca77bd@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <74e0af46-18a0-8c4a-5ae5-3cba69ca77bd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/22 13:32, Hugh Dickins wrote:
> On Fri, 19 Sep 2025, Baolin Wang wrote:
>> On 2025/9/19 09:06, Shakeel Butt wrote:
>>> On Thu, Sep 18, 2025 at 05:36:17PM +0800, Baolin Wang wrote:
>>>> On 2025/9/18 14:00, David Hildenbrand wrote:
>>>>> On 18.09.25 05:46, Baolin Wang wrote:
> ...
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index f1fc36729ddd..930add6d90ab 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio,
>>>>>> struct address_space *mapping,
>>>>>>             return PAGE_KEEP;
>>>>>>         if (!mapping) {
>>>>>>             /*
>>>>>> -         * Some data journaling orphaned folios can have
>>>>>> -         * folio->mapping == NULL while being dirty with clean buffers.
>>>>>> +         * Is it still possible to have a dirty folio with
>>>>>> +         * a NULL mapping? I think not.
>>>>>>              */
>>>>>
>>>>> I would rephrase slightly (removing the "I think not"):
>>>>>
>>>>> /*
>>>>>     * We should no longer have dirty folios with clean buffers and a NULL
>>>>>     * mapping. However, let's be careful for now.
>>>>>     */
>>>>
>>>> LGTM.
>>>>
>>>> Andrew, could you help squash these comments into this patch? Thanks.
> 
> (Myself, I would delete the comment entirely: it's justifying the change,
> which is good history to go into the commit message, but not so good in
> the final source. And we don't fully understand what to say here anyway.)
> 
>>>>
>>>>>> -        if (folio_test_private(folio)) {
>>>>>> -            if (try_to_free_buffers(folio)) {
>>>>>> -                folio_clear_dirty(folio);
>>>>>> -                pr_info("%s: orphaned folio\n", __func__);
>>>>>> -                return PAGE_CLEAN;
>>>>>> -            }
>>>>>> -        }
>>>>>> +        VM_WARN_ON_FOLIO(true, folio);
>>>
>>> Unexpected but better to use VM_WARN_ON_ONCE_FOLIO here.
>>
>> Um, I don't think it makes much difference, because we should no longer hit
>> this.
> 
> We do hit it.  Observe, there was no WARNING before in the !mapping
> case, just a pr_info in a particular instance of the !mapping case.
> We believe that instance went away with reiserfs, but that does not
> imply that there are no more !mapping cases left.
> 
> We do hit that WARNING: not often, and I've not seen it repeatedly
> (as ONCE-advisors fear), but a few cutdown examples from my testing
> appended below.

Thanks for reporting. That surprises me how that happened.

> I'm sure you'd like me to explain how it comes about: I did spend a
> while looking to do so, but then found better things to do.  By all
> means go in search of the explanation if it's worth your time: it
> might indicate a bug somewhere; but more likely it's just a race
> against code elsewhere cleaning up the folio.

Interesting. I'll try to reproduce this issue.

> The fact that it does not appear repeatedly suggests that the folio
> is successfully dealt with afterwards.  I didn't think to check at
> first, but in later runs did check back on such folios after, and
> verified that they had moved on to being freed and reused, not leaked.

No leaks, good.

> The examples I've seen have all been swapbacked, though that may
> just reflect my tmpfs swapping load.  With mapping NULLed, there's
> not much to go on: but index 0x7ff5ce103 is likely to have been
> anon, and index 0xcff more likely to have been tmpfs.
> 
> My vote is simply to delete the warning (and the comment).

Thanks for your examples and sound reasonable to me.

Andrew, could you help squash the following changes (if you need a new 
version, please let me know)? Thanks.


diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4907e255857a..aadbee50a851 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -689,16 +689,8 @@ static pageout_t pageout(struct folio *folio, 
struct address_space *mapping,
          * A freeable shmem or swapcache folio is referenced only by the
          * caller that isolated the folio and the page cache.
          */
-       if (folio_ref_count(folio) != 1 + folio_nr_pages(folio))
+       if (folio_ref_count(folio) != 1 + folio_nr_pages(folio) || !mapping)
                 return PAGE_KEEP;
-       if (!mapping) {
-               /*
-                * We should no longer have dirty folios with clean 
buffers and
-                * a NULL mapping. However, let's be careful for now.
-                */
-               VM_WARN_ON_FOLIO(true, folio);
-               return PAGE_KEEP;
-       }

         if (!shmem_mapping(mapping) && !folio_test_anon(folio))
                 return PAGE_ACTIVATE;

