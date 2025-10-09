Return-Path: <linux-kernel+bounces-846371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18190BC7BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5CE4E6856
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAE1F4606;
	Thu,  9 Oct 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="u7mRIsYE"
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D200F4FA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995575; cv=none; b=iry3p6dh1YXSV7muKzk2O9K5DUn/R9IaaNYK+JKbKGYL0E9edPA8aFUUcjDdrAGg8Ec56g1IzHRG9pESHE989KrqsEPf2cpAJ1Zx8jL6YDslc2joa274IxxcHtDT6bIvqHzKBgx5D6g7BXCxftzVoRqX9t3zIsmx7pOHgfaeOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995575; c=relaxed/simple;
	bh=aorsUTPkFWqCFdlVfn+gmvwxsPqVoK0PMUOOoh3YSj4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DShLyam3PNLgDqkyxPdDr91XNrNsAMrWwA4NKKMEVhY+SGmrBH2z/A2c4NJwYK4SzOhTLD+haqVHW/k4eYlFJoSWI0UBLfGWvdDXfJ7pFp4iykBqvGA372GAjEU/utr+DACWpp3FmPKTo/i5C2YM9hcB5UFXNFGWIwuj5Xn2c3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=u7mRIsYE; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ws1QWS1SxNWWPViN/1fQpFGlPzNSlgREQgIxN0gMQfM=;
	b=u7mRIsYEMtXyJfvnau1s8DhoBjkD5LC60mpdYdgmtiPIiZU7U9EbFu0ZGBIJkHOBLVo8c2SqZ
	/FMJkS7kLoi0gnal7SQjl5qzoicZ5iKX946fNxVXx+QU6Wpwj+i1ZdX/50hkSxDbjWN2B93cNKR
	mP4kcNFk++iaJfT5HF/lfyE=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cj1wH2Lppz1K98v;
	Thu,  9 Oct 2025 15:39:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 386AF1A016C;
	Thu,  9 Oct 2025 15:39:27 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 15:39:27 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 15:39:26 +0800
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: <jane.chu@oracle.com>, Zi Yan <ziy@nvidia.com>
CC: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <kernel@pankajraghav.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mcgrof@kernel.org>,
	<nao.horiguchi@gmail.com>
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
 <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
 <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
 <57d9aa32-2fc8-48d2-b68b-3308c7d58125@oracle.com>
 <CD6D8EBD-F139-41BC-9A59-5033EF5A09BC@nvidia.com>
 <ae74c0b4-7115-4856-a3f0-c61945f64c7d@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f5870e90-2c3d-7d65-fcc3-92ec5a1fe177@huawei.com>
Date: Thu, 9 Oct 2025 15:39:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ae74c0b4-7115-4856-a3f0-c61945f64c7d@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/3 1:47, jane.chu@oracle.com wrote:
> 
> 
> On 10/2/2025 6:54 AM, Zi Yan wrote:
>> On 2 Oct 2025, at 1:23, jane.chu@oracle.com wrote:
>>
>>> On 10/1/2025 7:04 PM, Zi Yan wrote:
>>>> On 1 Oct 2025, at 20:38, Zi Yan wrote:
>>>>
>>>>> On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:
>>>>>
>>>>>> Hi, Zi Yan,
>>>>>>
>>>>>> On 9/30/2025 9:51 PM, syzbot wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>>>>> lost connection to test machine
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Tested on:
>>>>>>>
>>>>>>> commit:         d8795075 mm/huge_memory: do not change split_huge_page..
>>>>>>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ce96e2580000
>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
>>>>>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>>>>>> userspace arch: arm64
>>>>>>>
>>>>>>> Note: no patches were applied.
>>>>>>>
>>>>>>
>>>>>
>>>>> Thank you for looking into this.
>>>>>
>>>>>> My hunch is that
>>>>>> https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>>>>>> alone is not enough.  Perhaps on ARM64, the page cache pages of /dev/nullb0 in
>>>>> Yes, it only has the first patch, which fails a split if it cannot be
>>>>> split to the intended order (order-0 in this case).
>>>>>
>>>>>
>>>>>> the test case are probably with min_order > 0, therefore THP split fails, as the console message show:
>>>>>> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for unsplit thp: Failed
>>>>>>
>>>>>> With lots of poisoned THP pages stuck in the page cache, OOM could trigger too soon.
>>>>>
>>>>> That is my understanding too. Thanks for the confirmation.
>>>>>
>>>>>>
>>>>>> I think it's worth to try add the additional changes I suggested earlier -
>>>>>> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com/
>>>>>>
>>>>>> So that in the madvise HWPOISON cases, large huge pages are splitted to smaller huge pages, and most of them remain usable in the page cache.
>>>>>
>>>>> Yep, I am going to incorporate your suggestion as the second patch and make
>>>>> syzbot check it again.
>>>>
>>>>
>>>> #syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_order_and_opt_memory_failure-for-kernelci
>>>>
>>>
>>> There is a bug here,
>>>
>>>         if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>>             res = -EHWPOISON;
>>>             kill_procs_now(p, pfn, flags, folio);  <---
>>>
>>> If try_to_split_thp_page() succeeded on min_order, 'folio' should be retaken:  folio = page_folio(page) before moving on to kill_procs_now().
>>
>> Thank you for pointing it out. Let me fix it and let syzbot test it again.
>>

Sorry for late. I just got back from my vacation. :)

>> BTW, do you mind explaining why soft offline case does not want to split?
>> Like memory failure case, splitting it would make other after-split folios
>> available.
> 
> That's exactly what I think.  Let's wait for Miaohe, not sure if he has other concern.

It might be because even if split is skipped, the folio is still accessible (thus available)
from user sapce and premature split might lead to potential performance loss. But it's fine
to me to split folio first in soft offline case. No strong opinion.


Thanks both.
.

