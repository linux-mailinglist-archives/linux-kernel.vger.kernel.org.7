Return-Path: <linux-kernel+bounces-864735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5069BFB6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742371A04BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74630FC07;
	Wed, 22 Oct 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k0lcJIUX"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E643221DB5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129273; cv=none; b=LVrcG6ghwMkLruYCUBiqzTp9htG0/2QxNYdbdhSQ6QpRTsKEqrRHk/xA7x4Oxk38reXtDIIyKyG3VAgXWhCG2QD5dS3z9MhJibUJwdZ2hx4tXOnYqLkKN7BufXokb3fNz+66zh37SqTL4ojPOq2HCna5ULBcUNmzos4VfvSXFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129273; c=relaxed/simple;
	bh=X1TQ5dul0RJRSnRtHx40ap9JALt/j5M977/T7yg/bf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SyVjaxiNBGCO02KU+Z3qSqUvua8sVXY1KUkQ7y2ltAiKiDWycwfyWZAemso++/EEK9koijR4iIctvx53CtSnGmfhNn5ARroP3aFm3EQuH6ulN/+vYekhm51CdXWH8952hh5M/hwShJcIJQEgn/OdmHbHRYXNyo8AHnTJ0M/aXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k0lcJIUX; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761129262; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=zApZp8kIsLL8CaVDud/rM1l2bNSLJbbDdobxbcxNIAk=;
	b=k0lcJIUX1uYdi06zVmB9qcUCJpPpePKY8zuUWV6tOqV8azKQg9BSVL08S4B1LiSsm9ZbLbn+ZsAYALmDcNa6oAPaUeIvjc/FN6TvKYEShggCJ76skxl9lvFYJ5UOZv+zpByNBv+nL2rBK2ci74zMI9WePCYQqBc/Co67to2Jxmo=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqmTUwB_1761129260 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 18:34:20 +0800
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
In-Reply-To: <CAGsJ_4y32i3aNYPum=8J3_Kt6vOSisr_jg6btB-YG1uQBqHG7Q@mail.gmail.com>
	(Barry Song's message of "Wed, 22 Oct 2025 22:55:05 +1300")
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
Date: Wed, 22 Oct 2025 18:34:19 +0800
Message-ID: <87ms5j4444.fsf@DESKTOP-5N7EMDA>
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

> On Wed, Oct 22, 2025 at 10:46=E2=80=AFPM Huang, Ying
> <ying.huang@linux.alibaba.com> wrote:
>
>> >
>> > I agree. Yet the ish barrier can still avoid the page faults during CP=
U0's PTL.
>>
>> IIUC, you think that dsb(ish) compared with dsb(nsh) can accelerate
>> memory writing (visible to other CPUs).  TBH, I suspect that this is the
>> case.
>
> Why? In any case, nsh is not a smp domain.

I think dsb(ish) will be slower than dsb(nsh) in theory.  I guess that
dsb just wait for the memory write to be visible in the specified
shareability domain instead of making write faster.

> I believe a dmb(ishst) is sufficient to ensure that the new PTE writes
> are visible

dmb(ishst) (smp_wmb()) should pair with dmb(ishld) (smp_rmb()).

> to other CPUs. I=E2=80=99m not quite sure why the current flush code uses=
 dsb(ish);
> it seems like overkill.

dsb(ish) here is used for tlbi(XXis) broadcast.  It waits until the page
table change is visible to the page table walker of the remote CPU.

---
Best Regards,
Huang, Ying

