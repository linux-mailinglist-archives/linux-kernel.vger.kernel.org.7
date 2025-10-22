Return-Path: <linux-kernel+bounces-864627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DFBFB355
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06E019C5308
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80B21FF5B;
	Wed, 22 Oct 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lejdTTWj"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CB30FC2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126416; cv=none; b=J8AukamPqiiLjLsICEA29hFo30i+HnOEMD4cCnBc82y+wZqzI3yHl/5KBjqRBlnOZYtcO/qNfzrpn8oXFORk+fcE5RSiOnn6F/x1lFqz+5BUA2BrziMpXA8fxa0igBnWzEmew7BF7C1dUmCs2U6yC4UG49IH+WpgDtys3wvRR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126416; c=relaxed/simple;
	bh=zbyTWkn1DSY36AZqfBe8yzoM7Sq/ED73jaQIS0huc5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSUjxkchpTBD+jFw+4q8CiYbgSPODeQxflp6GxNkmanP5Sw4s2XzwiNjPkbhAk8MJOppA9bT6RMjBxaSDznCFbb9b5kXTewPCQa0lD2/rkmbJ0LhS96SbMPfWxQ7/xVzunia0X6qdElRoKn8zxwqkFpglHy2wV7JOYlEug//zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lejdTTWj; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761126411; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=leTG8eQL2d1TJ+ZkjUXd68HfBJsD5TPizgYkX6kdZYY=;
	b=lejdTTWjyOeDXaFrUZDxnnE7kH6QxLl3cYZr0eXW5EMBo2grkiWY4tk8ys2I8E1XjS6WRG7GyZFFeybipzt3NGzOQZkpjjwduvpAHddyEuJkAIAnJvjEGKJTxI9N14WNIarmT/WJPbr7Q3iSV5FAZO+Q1tGy5bLNRxPFRuZOCdw=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqmS8Fc_1761126408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 17:46:49 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan
 <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Yang Shi <yang@os.amperecomputing.com>,
  "Christoph Lameter (Ampere)" <cl@gentwo.org>,  Dev Jain
 <dev.jain@arm.com>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Yicong Yang <yangyicong@hisilicon.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Kevin Brodsky <kevin.brodsky@arm.com>,  Yin
 Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
In-Reply-To: <CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 22:37:54 +1300")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-3-ying.huang@linux.alibaba.com>
	<CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
	<87a51jfl44.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
	<871pmv9unr.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
	<875xc78es0.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
Date: Wed, 22 Oct 2025 17:46:48 +0800
Message-ID: <87a51j6zg7.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

>>
>> With PTL, this becomes
>>
>> CPU0:                           CPU1:
>>
>> page fault                      page fault
>> lock PTL
>> write PTE
>> do local tlbi
>> unlock PTL
>>                                 lock PTL        <- pte visible to CPU 1
>>                                 read PTE        <- new PTE
>>                                 do local tlbi   <- new PTE
>>                                 unlock PTL
>
> I agree. Yet the ish barrier can still avoid the page faults during CPU0's PTL.

IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
memory writing (visible to other CPUs).  TBH, I suspect that this is the
case.

> CPU0:                                                                  CPU1:
>
> lock PTL
>
> write pte;
> Issue ish barrier
> do local tlbi;
>
>
>     No page fault occurs if tlb misses
>
>
> unlock PTL
>
>
> Otherwise, it could be:
>
>
> CPU0:                                                                  CPU1:
>
> lock PTL
>
> write pte;
> Issue nsh barrier
> do local tlbi;
>
>
>     page fault occurs if tlb misses
>
>
> unlock PTL
>
>
> Not quite sure if adding an ish right after the PTE modification has any
> noticeable performance impact on the test? I assume the most expensive part
> is still the tlbi broadcast dsb, not the PTE memory sync barrier?

---
Best Regards,
Huang, Ying

