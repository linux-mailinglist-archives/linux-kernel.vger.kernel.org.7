Return-Path: <linux-kernel+bounces-864607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F2ABFB2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF7BE349043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696278F4A;
	Wed, 22 Oct 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jqM07O1Q"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA29275111
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125432; cv=none; b=sApYJZpWHPCuG7MuIY0szbNDJQDqlZMRMJIubSzI1yr376UJJceKriEiF39Xex13QLMFHOyueT0O1eOPH2uNMemT7y5w/KSc6RO1LH8n7G4umnSgO6UvquCPK0JT7Oz/3oX6/icoOqIJlqGprqd+tyWyDiJaiIfG8FyPLkp+nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125432; c=relaxed/simple;
	bh=k2Afl+YRkJvgma2iL/7Z/a95PVfjvJPYNCtTGvBtmIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iv1GFXKQZxPCa4/pejOR4BBp44Uyf3WobsSLtpGEx5adtU3cln06bGuJ5mjr2G3116dSfifMFMama5mMD+/RYwRXLm0TXh7kn9I7aTMDhcfvuT03dYvKfV0Oq9ijmCHnZr40JZ7wVAWcMvzuH6wI/0HuFPlPa5JFyCMs7iqDbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jqM07O1Q; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761125426; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=mZHxml0O18Vg7HUA3QwmCPVMku0Lb676UdH10r5wy0U=;
	b=jqM07O1QdNz01NceVGafF+1NiP7V8ca7e/Ei/LZOwfQ1HSeH/C/yTiAchlmeHqH4CL8lfy5iCK1vB1FeyYJzO1oXjh9oxL6SNiP6Y5jMI3JkzXuk12AIkjNO4fMq6qykDSwqKBaWulVrulxLC+tEXogB7aBBTGubGmJs561mJso=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqmQxuR_1761125423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 17:30:24 +0800
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
In-Reply-To: <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 22:17:56 +1300")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-3-ying.huang@linux.alibaba.com>
	<CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
	<87a51jfl44.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
	<871pmv9unr.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
Date: Wed, 22 Oct 2025 17:30:23 +0800
Message-ID: <875xc78es0.fsf@DESKTOP-5N7EMDA>
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

> On Wed, Oct 22, 2025 at 10:02=E2=80=AFPM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> >> >
>> >> > static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>> >> >                                            unsigned long uaddr)
>> >> > {
>> >> >         unsigned long addr;
>> >> >
>> >> >         dsb(ishst);
>> >> >         addr =3D __TLBI_VADDR(uaddr, ASID(mm));
>> >> >         __tlbi(vale1is, addr);
>> >> >         __tlbi_user(vale1is, addr);
>> >> >         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAG=
E_MASK,
>> >> >                                                 (uaddr & PAGE_MASK)=
 +
>> >> > PAGE_SIZE);
>> >> > }
>> >>
>> >> IIUC, _nosync() here means doesn't synchronize with the following cod=
e.
>> >> It still synchronizes with the previous code, mainly the page table
>> >> changing.  And, Yes.  There may be room to improve this.
>> >>
>> >> > On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem t=
o use
>> >> > set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are vi=
sible to all
>> >> > cores. If a remote CPU later encounters a page fault and performs a=
 TLB
>> >> > invalidation, will it still see a stable PTE?
>> >>
>> >> I don't think so.  We just flush local TLB in local_flush_tlb_page()
>> >> family functions.  So, we only needs to guarantee the page table chan=
ges
>> >> are available for the local page table walking.  If a page fault occu=
rs
>> >> on a remote CPU, we will call local_flush_tlb_page() on the remote CP=
U.
>> >>
>> >
>> > My concern is that:
>> >
>> > We don=E2=80=99t have a dsb(ish) to ensure the PTE page table is visib=
le to remote
>> > CPUs, since you=E2=80=99re using dsb(nsh). So even if a remote CPU per=
forms
>> > local_flush_tlb_page(), the memory may not be synchronized yet, and it=
 could
>> > still see the old PTE.
>>
>> So, do you think that after the load/store unit of the remote CPU have
>> seen the new PTE, the page table walker could still see the old PTE?  I
>
> Without a barrier in the ish domain, remote CPUs=E2=80=99 load/store unit=
s may not
> see the new PTE written by the first CPU performing the reuse.
>
> That=E2=80=99s why we need a barrier in the ish domain to ensure the PTE =
is
> actually visible across the SMP domain. A store instruction doesn=E2=80=
=99t guarantee
> that the data is immediately visible to other CPUs =E2=80=94 at least not=
 for load
> instructions.
>
> Though, I=E2=80=99m not entirely sure about the page table walker case.
>
>> doubt it.  Even if so, the worse case is one extra spurious page fault?
>> If the possibility of the worst case is low enough, that should be OK.
>
> CPU0:                    CPU1:
>
> write pte;
>
> do local tlbi;
>
>                                        page fault;
>                                        do local tlbi; -> still old PTE
>
> pte visible to CPU1

With PTL, this becomes

CPU0:                           CPU1:

page fault                      page fault
lock PTL
write PTE
do local tlbi
unlock PTL
                                lock PTL        <- pte visible to CPU 1
                                read PTE        <- new PTE
                                do local tlbi   <- new PTE
                                unlock PTL

>> Additionally, the page table lock is held when writing PTE on this CPU
>> and re-reading PTE on the remote CPU.  That provides some memory order
>> guarantee too.
>
> Right, the PTL might take care of it automatically.

---
Best Regards,
Huang, Ying

