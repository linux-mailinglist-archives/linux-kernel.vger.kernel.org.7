Return-Path: <linux-kernel+bounces-866072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BFCBFED45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A46524EFF15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F371ACEAF;
	Thu, 23 Oct 2025 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LBRBSITn"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7884502A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182534; cv=none; b=XtybkBEvvXrKkBSj+Dk1U5U8dyF8WJagI5bRZVqqcUoqKQMJ5gQlTAOYHIbMzOZIUVv092IRgUudIVAxy8FtP88/86yHG+4LVILBXPWBxR3thFgqMo05Ky5+K118pHFC68ObeD8bbZ24/plNn0V2ZV2WY5l9zNNLcZtFgclgAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182534; c=relaxed/simple;
	bh=gDPUKctcf380ybDTEmE0TEsWMcviF8EedHQAtRmMmI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+gG+RmJzuKGc4srf2pqyjvnJnqtQOXAUBARBEGmloL9Ns+KzkSM1ShEA3MN28JRTrkTcnQOgwiqg9vZtRNC14E9jTt5vEBSr8SkT3GYAptx+OvfHME3mTzHFPg4MNWgU2evIjRQefOA4KTnLZAXLbZ/nI2L5qVIcaK2OJ4mUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LBRBSITn; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761182529; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=2IDMW7CBAbRVu3DReKyJ3tXIFVRCpnWKhvXJ2ha+0SM=;
	b=LBRBSITn+lYzPaJmzq9qZgM0i315LC7+D34GBE4WYvXKVNdoll+Ohyvu6jloRZxYnZg8g2Hdnq3IHWxs6rhTJZA+zfCLyRxzB4feovYus3LDn2iY5kiTVzPw3Y2SwzQPMcdvGTeCZ4DsVriJ52fic1ibwlXJJt3WUCebp8tnuew=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqooiVd_1761182526 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 09:22:07 +0800
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
In-Reply-To: <CAGsJ_4xhJSLnXOZy4kPmnif5Paq+OPN_Ww+rPk2WO4-ADSC0Yw@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 23:52:23 +1300")
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
Date: Thu, 23 Oct 2025 09:22:05 +0800
Message-ID: <87qzuu1kg2.fsf@DESKTOP-5N7EMDA>
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

> On Wed, Oct 22, 2025 at 11:34=E2=80=AFPM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Wed, Oct 22, 2025 at 10:46=E2=80=AFPM Huang, Ying
>> > <ying.huang@linux.alibaba.com> wrote:
>> >
>> >> >
>> >> > I agree. Yet the ish barrier can still avoid the page faults during=
 CPU0's PTL.
>> >>
>> >> IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
>> >> memory writing (visible to other CPUs).  TBH, I suspect that this is =
the
>> >> case.
>> >
>> > Why? In any case, nsh is not a smp domain.
>>
>> I think dsb(ish) will be slower than dsb(nsh) in theory.  I guess that
>> dsb just wait for the memory write to be visible in the specified
>> shareability domain instead of making write faster.
>>
>> > I believe a dmb(ishst) is sufficient to ensure that the new PTE writes
>> > are visible
>>
>> dmb(ishst) (smp_wmb()) should pair with dmb(ishld) (smp_rmb()).
>>
>> > to other CPUs. I=E2=80=99m not quite sure why the current flush code u=
ses dsb(ish);
>> > it seems like overkill.
>>
>> dsb(ish) here is used for tlbi(XXis) broadcast.  It waits until the page
>> table change is visible to the page table walker of the remote CPU.
>
> It seems we=E2=80=99re aligned on all points[1], although I=E2=80=99m not=
 sure whether
> you have data comparing A and B.
>
> A:
> write pte
> don't broadcast pte
> tlbi
> don't broadcast tlbi
>
> with
>
> B:
> write pte
> broadcast pte

I suspect that pte will be broadcast, DVM broadcast isn't used for
the memory coherency IIUC.

> tlbi
> don't broadcast tlbi
>
> I guess the gain comes from "don't broadcat tlbi" ?
> With B, we should be able to share many existing code.

Ryan has some plan to reduce the code duplication with the current
solution.

> [1]
> https://lore.kernel.org/linux-mm/20251013092038.6963-1-ying.huang@linux.a=
libaba.com/T/#m54312d4914c69aa550bee7df36711c03a4280c52

---
Best Regards,
Huang, Ying

