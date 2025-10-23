Return-Path: <linux-kernel+bounces-866258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD684BFF500
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32A844ED5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FD21A436;
	Thu, 23 Oct 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vqOPnXgR"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4961E502
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200164; cv=none; b=G4h5gyx8ulpKKRwwn5BTpeyS88aS6c/oMijjJfGRakYG18AowbndboxxyhkxtPZo1OxRJ7tDJQWZ+b9/lNdTe6S/54ON/zLo9aSSZphLVXNmrAnyMYBYTdmPd2YexCfVUo+SkfaZ1XJ59RyzON+Svp0LQmI6eLJb5/wKtsWCFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200164; c=relaxed/simple;
	bh=XL+bJoTceH2UkMnJaD6SFvvRmec44qTz1JVZhc60Ips=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqUxUjdW+Bi5acyT/PFjty0p+aIjQbr6ULMW/rJny0sVRiJid7s5nlx4TEE5i6OSS1bEqoskfGeD31/wAoLCVW4wvCOnGqTV87KYO6/2mL+owNMJ/HcMKQn3jISUol1Jk1+Fm+jHgWQVLswafH9Y+ezEKmkiR6Ioa2UnHoBK1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vqOPnXgR; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761200158; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=hhj1VLtSYO+AfqlDWQL1li1LYgXwZ69chK1m/bx772o=;
	b=vqOPnXgRdA37HK4z4noYbJaw4QlF9pxXCjyjLkPddbfdpHMKq75SO49l2ikJ0XN/+plkf6Y/0knJIPpuYFNqSZK+pIv0sVWjOJ+jnBqZQVWv7t1HWYBdiItwO2Fh8YDBzj9s+d6EwP2Op2WugK3tXvxMcjWonfpS0MrUejx5zeM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wqq5ZkD_1761200155 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 14:15:56 +0800
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
In-Reply-To: <CAGsJ_4z7SASir4gWThfePdnvw82TB8E6rXnzJ=CieaFnJpJt7g@mail.gmail.com>
	(Barry Song's message of "Thu, 23 Oct 2025 18:39:39 +1300")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-3-ying.huang@linux.alibaba.com>
	<CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
	<87a51jfl44.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
	<871pmv9unr.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
	<875xc78es0.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
	<87a51j6zg7.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
	<87ms5j4444.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4xhJSLnXOZy4kPmnif5Paq+OPN_Ww+rPk2WO4-ADSC0Yw@mail.gmail.com>
	<87qzuu1kg2.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4z7SASir4gWThfePdnvw82TB8E6rXnzJ=CieaFnJpJt7g@mail.gmail.com>
Date: Thu, 23 Oct 2025 14:15:53 +0800
Message-ID: <874irqywh2.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

>> >
>> > A:
>> > write pte
>> > don't broadcast pte
>> > tlbi
>> > don't broadcast tlbi
>> >
>> > with
>> >
>> > B:
>> > write pte
>> > broadcast pte
>>
>> I suspect that pte will be broadcast, DVM broadcast isn't used for
>> the memory coherency IIUC.
>
> I guess you=E2=80=99re right. By =E2=80=9Cbroadcast,=E2=80=9D I actually =
meant the PTE becoming visible
> to other CPUs. With a dsb(ish) before tlbi, other cores=E2=80=99 TLBs can=
 load the new
> PTE after their TLB is shoot down. But as you said, if the hardware doesn=
=E2=80=99t
> propagate the updated PTE faster, it doesn=E2=80=99t seem to help reduce =
page faults.
>
> As a side note, I=E2=80=99m curious about the data between dsb(nsh) and d=
sb(ish) on
> your platform. Perhaps because the number of CPU cores is small, I didn=
=E2=80=99t see
> any noticeable difference between them on phones.

Sure.  I can git it a try.  Can you share the test case?

>>
>> > tlbi
>> > don't broadcast tlbi
>> >
>> > I guess the gain comes from "don't broadcat tlbi" ?
>> > With B, we should be able to share many existing code.
>>
>> Ryan has some plan to reduce the code duplication with the current
>> solution.
>
> Ok.

---
Best Regards,
Huang, Ying

