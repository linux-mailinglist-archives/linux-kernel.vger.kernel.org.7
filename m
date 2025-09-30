Return-Path: <linux-kernel+bounces-837196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43467BABAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B5A7A783C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFB248F51;
	Tue, 30 Sep 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yLrGcdBX"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE2224AEF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213906; cv=none; b=evn6NyAM3JmsL8ZaVUdOcnzU3aP9mmdigkPsvInvlb3SWRsEXAz5b1k9bsiKHe7+H5K8B8hhyM7LqYJ4i+50OtKl+6gDeD9eqIBTZ8iIb4Er5b6DQ399PND7x9+yDiRd5DV4lpFI254+y0jc2HyyfnIbAao+kNGqD2OvNPRnFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213906; c=relaxed/simple;
	bh=3BUzruO98xegBEy3Goi3ezeWcXr7FKTMgIlelLmhQCM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jUjJ3MRzktRIcBy8q/+djSI844TqVEd37CUmw7axciEr7feJLYvFIs6uBsOkVOWgt1tdC2iisNXaqAMUIgKYoC5qxnMkGlihgEaILe+f4Nj5FchFkiSMFvWQHLnCiNjIHJ0J/3ZccGEevcLvc3RBb0Cs3TYFxizgtJt51DkDY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yLrGcdBX; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uUCA7eVrP/zVqrhbttxDcCsaHz85pF/bBDpoThnF+xc=;
	b=yLrGcdBX+ePJr6aOloP5qw0PA3hSv1zBPQ4LN+kMhgLIk/O/f8e6/5fUbSpj1xWW/mp15U9d2
	tLPsemmNezgfiu9EKmCGT4KE05SVs3JTbKbzl6VraNE6jShFj/ykz1eKPNA0OgTpuJVRWh1tEDt
	2v6OZdVDnuqPvCgpAzQ9dJQ=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cbSrf6GCtz12LDF;
	Tue, 30 Sep 2025 14:31:46 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F2D91800B1;
	Tue, 30 Sep 2025 14:31:38 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 14:31:37 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 14:31:36 +0800
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: <jane.chu@oracle.com>
CC: David Hildenbrand <david@redhat.com>, Luis Chamberlain
	<mcgrof@kernel.org>, syzbot
	<syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <nao.horiguchi@gmail.com>,
	<syzkaller-bugs@googlegroups.com>, "Pankaj Raghav (Samsung)"
	<kernel@pankajraghav.com>, Zi Yan <ziy@nvidia.com>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <594350a0-f35d-472b-9261-96ce2715d402@oracle.com>
 <7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com>
 <c61ca94b-5b19-4c69-b2a1-d11a5301c6bb@oracle.com>
 <d15fec58-58ad-fd20-7130-9c480df43d15@huawei.com>
 <8d39b975-b85f-42f2-8be4-0b7adee09dd6@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c97dedf5-0f45-5082-64b6-ef0772dc33a3@huawei.com>
Date: Tue, 30 Sep 2025 14:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8d39b975-b85f-42f2-8be4-0b7adee09dd6@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/9/30 12:35, jane.chu@oracle.com wrote:
> 
> 
> On 9/29/2025 7:51 PM, Miaohe Lin wrote:
>> On 2025/9/30 2:23, jane.chu@oracle.com wrote:
>>>
>>>
>>> On 9/29/2025 10:49 AM, jane.chu@oracle.com wrote:
>>>>
>>>> On 9/29/2025 10:29 AM, jane.chu@oracle.com wrote:
>>>>>
>>>>> On 9/29/2025 4:08 AM, Pankaj Raghav (Samsung) wrote:
>>>>>>>
>>>>>>> I want to change all the split functions in huge_mm.h and provide
>>>>>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_folio().
>>>>>>>
>>>>>>> Something like below:
>>>>>>>
>>>>>>> 1. no split function will change the given order;
>>>>>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_order
>>>>>>> is smaller than mapping_min_folio_order().
>>>>>>>
>>>>>>> In this way, for an LBS folio that cannot be split to order 0, split
>>>>>>> functions will return -EINVAL to tell caller that the folio cannot
>>>>>>> be split. The caller is supposed to handle the split failure.
>>>>>>
>>>>>> IIUC, we will remove warn on once but just return -EINVAL in __folio_split()
>>>>>> function if new_order < min_order like this:
>>>>>> ...
>>>>>>          min_order = mapping_min_folio_order(folio->mapping);
>>>>>>          if (new_order < min_order) {
>>>>>> -            VM_WARN_ONCE(1, "Cannot split mapped folio below min- order: %u",
>>>>>> -                     min_order);
>>>>>>              ret = -EINVAL;
>>>>>>              goto out;
>>>>>>          }
>>>>>> ...
>>>>>
>>>>> Then the user process will get a SIGBUS indicting the entire huge page at higher order -
>>>>>                   folio_set_has_hwpoisoned(folio);
>>>>>                   if (try_to_split_thp_page(p, false) < 0) {
>>>>>                           res = -EHWPOISON;
>>>>>                           kill_procs_now(p, pfn, flags, folio);
>>>>>                           put_page(p);
>>>>>                           action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>>>>>                           goto unlock_mutex;
>>>>>                   }
>>>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>>>>                   folio = page_folio(p);
>>>>>
>>>>> the huge page is not usable any way, kind of similar to the hugetlb page situation: since the page cannot be splitted, the entire page is marked unusable.
>>>>>
>>>>> How about keep the current huge page split code as is, but change the M- F code to recognize that in a successful splitting case, the poisoned page might just be in a lower folio order, and thus, deliver the SIGBUS ?
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index a24806bb8e82..342c81edcdd9 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -2291,7 +2291,9 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>                    * page is a valid handlable page.
>>>>>                    */
>>>>>                   folio_set_has_hwpoisoned(folio);
>>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>>> +               ret = try_to_split_thp_page(p, false);
>>>>> +               folio = page_folio(p);
>>>>> +               if (ret < 0 || folio_test_large(folio)) {
>>>>>                           res = -EHWPOISON;
>>>>>                           kill_procs_now(p, pfn, flags, folio);
>>>>>                           put_page(p);
>>>>> @@ -2299,7 +2301,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>                           goto unlock_mutex;
>>>>>                   }
>>>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>>>> -               folio = page_folio(p);
>>>>>           }
>>>>>
>>>>> thanks,
>>>>> -jane
>>>>
>>>> Maybe this is better, in case there are other reason for split_huge_page() to return -EINVAL.
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index a24806bb8e82..2bfa05acae65 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1659,9 +1659,10 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>>>    static int try_to_split_thp_page(struct page *page, bool release)
>>>>    {
>>>>           int ret;
>>>> +       int new_order = min_order_for_split(page_folio(page));
>>>>
>>>>           lock_page(page);
>>>> -       ret = split_huge_page(page);
>>>> +       ret = split_huge_page_to_list_to_order(page, NULL, new_order);
>>>>           unlock_page(page);
>>>>
>>>>           if (ret && release)
>>>> @@ -2277,6 +2278,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>>           folio_unlock(folio);
>>>>
>>>>           if (folio_test_large(folio)) {
>>>> +               int ret;
>>>>                   /*
>>>>                    * The flag must be set after the refcount is bumped
>>>>                    * otherwise it may race with THP split.
>>>> @@ -2291,7 +2293,9 @@ int memory_failure(unsigned long pfn, int flags)
>>>>                    * page is a valid handlable page.
>>>>                    */
>>>>                   folio_set_has_hwpoisoned(folio);
>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>> +               ret = try_to_split_thp_page(p, false);
>>>> +               folio = page_folio(p);
>>>> +               if (ret < 0 || folio_test_large(folio)) {
>>>>                           res = -EHWPOISON;
>>>>                           kill_procs_now(p, pfn, flags, folio);
>>>>                           put_page(p);
>>>> @@ -2299,7 +2303,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>>                           goto unlock_mutex;
>>>>                   }
>>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>>> -               folio = page_folio(p);
>>>>           }
>>>>
>>>>           /*
>>>> @@ -2618,7 +2621,8 @@ static int soft_offline_in_use_page(struct page *page)
>>>>           };
>>>>
>>>>           if (!huge && folio_test_large(folio)) {
>>>> -               if (try_to_split_thp_page(page, true)) {
>>>> +               if ((try_to_split_thp_page(page, true)) ||
>>>> +                       folio_test_large(page_folio(page))) {
>>>>                           pr_info("%#lx: thp split failed\n", pfn);
>>>>                           return -EBUSY;
>>>>                   }
>>>
>>> In soft offline, better to check if (min_order_for_split > 0), no need to split, just return for now ...
>>
>> I might be miss something but why we have to split it? Could we migrate the whole thp or folio with min_order instead?
> 
> The soft offline code was originally written with the assumption that only 1 base page will be offlined.

Yes, only page corresponding to parameter @pfn of soft_offline_page() will be offlined.

>
> With the recent introduction of min_order, it might quietly offline multiple pages, is that a desirable thing? 

I don't think so. Even if try_to_split_thp_page splits folio into smaller one with min_order, page_handle_poison()
will put back the folio into buddy after migrate_pages, set the hwpoisoned flag to raw error page and hold the extra
refcnt. So only raw error page will be offlined while other sub-pages will be put back into buddy.
Or am I miss something?

Thanks.
.

