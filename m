Return-Path: <linux-kernel+bounces-864547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44FBFB0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF55B48613C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A630FC25;
	Wed, 22 Oct 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nIzwe8U+"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2B3128B4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123734; cv=none; b=mZildQWC86yiCilAwoeRGl4rF7hoCDI2I7Ztl3lvVJqryNpd5s9k+1qAgERwPZZiruBDgzE7k8ALYkS+plfXJgzpdbs+1N1ciljqpI2FqVcJNLVddl+3K8c02rNyj03RlPllf1hASQ++SDn4B3h8Ry455uSOGTLryhcYSVFh1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123734; c=relaxed/simple;
	bh=NX7B2ky64eydNN7QPbta8cm8f9JDTm0tgNpkW6KJk6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hV4bzANsq/STK3xWSeTgSA2bcxIcam9dILdaaWZZ7/lop9a4NQKYCdMQ/Dv3UfuvM17ZcXD5179PbYl8pQuHdU56KbW9wpe9LCEiuugqim/x7i/HBkxn+volexq+bCjujCUwg3R7O/kYdfNTlcZBtYP4mCk53i+8NwMnfcOdIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nIzwe8U+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761123723; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=mcRDTEAbzquuDlXqMd0IqQmK0PoHGGByotq3KkqD9LA=;
	b=nIzwe8U+srCOQtLPvNdVsgZhCJjoe1k0CBDXt5Q/K4/vMwZwiA1i6f7rHyA/RByliy4bQ5EMXjG5LzuyT/nZo5z7FgvfTOJ9hxUwucU7VYk16eyKOsNvvf28qQFTrEMNemPMj9vQeR2A6zyNW6FQB1KUVvN37UQWMAWxlothHLk=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqmBveP_1761123720 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 17:02:01 +0800
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
In-Reply-To: <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 21:14:48 +1300")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-3-ying.huang@linux.alibaba.com>
	<CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
	<87a51jfl44.fsf@DESKTOP-5N7EMDA>
	<CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
Date: Wed, 22 Oct 2025 17:02:00 +0800
Message-ID: <871pmv9unr.fsf@DESKTOP-5N7EMDA>
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
>> > static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>> >                                            unsigned long uaddr)
>> > {
>> >         unsigned long addr;
>> >
>> >         dsb(ishst);
>> >         addr =3D __TLBI_VADDR(uaddr, ASID(mm));
>> >         __tlbi(vale1is, addr);
>> >         __tlbi_user(vale1is, addr);
>> >         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_M=
ASK,
>> >                                                 (uaddr & PAGE_MASK) +
>> > PAGE_SIZE);
>> > }
>>
>> IIUC, _nosync() here means doesn't synchronize with the following code.
>> It still synchronizes with the previous code, mainly the page table
>> changing.  And, Yes.  There may be room to improve this.
>>
>> > On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem to u=
se
>> > set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are visib=
le to all
>> > cores. If a remote CPU later encounters a page fault and performs a TLB
>> > invalidation, will it still see a stable PTE?
>>
>> I don't think so.  We just flush local TLB in local_flush_tlb_page()
>> family functions.  So, we only needs to guarantee the page table changes
>> are available for the local page table walking.  If a page fault occurs
>> on a remote CPU, we will call local_flush_tlb_page() on the remote CPU.
>>
>
> My concern is that:
>
> We don=E2=80=99t have a dsb(ish) to ensure the PTE page table is visible =
to remote
> CPUs, since you=E2=80=99re using dsb(nsh). So even if a remote CPU perfor=
ms
> local_flush_tlb_page(), the memory may not be synchronized yet, and it co=
uld
> still see the old PTE.

So, do you think that after the load/store unit of the remote CPU have
seen the new PTE, the page table walker could still see the old PTE?  I
doubt it.  Even if so, the worse case is one extra spurious page fault?
If the possibility of the worst case is low enough, that should be OK.

Additionally, the page table lock is held when writing PTE on this CPU
and re-reading PTE on the remote CPU.  That provides some memory order
guarantee too.

---
Best Regards,
Huang, Ying

