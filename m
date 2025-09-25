Return-Path: <linux-kernel+bounces-832593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C487AB9FD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF4216CB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A328C014;
	Thu, 25 Sep 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKgdXtxs"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369B82899
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809045; cv=none; b=IX/SmbfywJJ2ciGt9Qt6IE9swOCUsJs3Fj81rue49EMM5IVPJR7jCDtlGt6mi8b4kQWgU8rvpMfccu0yoAnUlmJRza1v1UKMwkGGaDOA+NL1VsD5NsxPnVo/MremFyOH67vphWfShlX82FJcY+ogwEy005Cilb3N3mWfL3mj9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809045; c=relaxed/simple;
	bh=FM13cmZbKx09ykOMcz6kwwnR2D85jrYjpdCl6kxvsfc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iQi9CN77DoHyXvzx1FroAvpv9985LcuCZ8cyfw5U+ecmpzaWPhbc5iBhwJvVFbaCtmyVQlcssbFJhzOBXd/lZKKRTa4lJ+vWEVCty8orNCHPL0puaAsr4ezqi+558GdxS6oUVHwGzA9afy3beeC8hDUZgK9LmraDDjFWWy+UgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKgdXtxs; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b28e1b87c31so160907166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758809042; x=1759413842; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnQGqF3miky45oHSFecUX1+o2qxyKeVjODpGjfHwY6Q=;
        b=IKgdXtxs4rZpw9f0W6cyZyoxvgsfDqObAAnqT/kBf+Pasp9eO0YHiBd/us/gfGYm0P
         uNpdvklhvbzk5zFgGYsqIzfbeaKWlE2C7shIK3CCgxoFGGPynYkzaXNgqrZOdPMBh289
         02vjaRJegSIAUY+qudUha2pAe5yEXxdzeh8zx/aOceXcRuh97a9RiDlwfSomZddg41kM
         HIgy9BT1w2XTQrr/b1kZdg961BiqYIKcqbCKMb2jP82YDAG7x6Zo3YIfVqtB7pRhJCWR
         17p+lZfTuCLquI3NdAAadqfgAuynkGl34HUVsT3T7d/owcK1AQeF9i6iCbob1LV0hOkV
         S/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809042; x=1759413842;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnQGqF3miky45oHSFecUX1+o2qxyKeVjODpGjfHwY6Q=;
        b=mExNttZDmxvzoVl/XfcU1skdYETjVWHQIT+PWG/uKkB7pZW/trURr2fRbwxYP8+ynb
         cYFmI8S8MUb1XN4YljiHXJTv8pawTFJmoA2JINpRoHQ8p9r4rWSI8sAga/XMgmgDrl2t
         cnnbXYmIQ6VxUKfMAtVOk8tkTbkK6cFhhvd18XbxxZp7uxoSM40ajekq+H7rEe7uX6h2
         sGhojf9ocFrhi3csQo7bsK+Y8GfkBQENibnVQnASOnrmNWJvWnCWSjhbZYWwKMHsQZ/4
         2WW1W5aflfPe3u9VE88kWRJWTLnUCzZElNaZ7YSMSnUpCC9CrKLzf0tFMpRDssqsJC51
         MJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUjzQSlEt+o8r4eHVuyJgcIuqObbk0mVuv+STOHCPuK+Y4YqpSHf8RIiPOukWGBQzoZVPIUn8X6fVuCMU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhve0VZF83LBgPsTdKMnroiKVImcwFO/czhHSHh41w4ied6nIr
	7KmukuXa/YSsM8rwfIcGDd7IIXaiTq2QiQxc8aw/CKUqnUZBPaqWXbUEbBZmJqogPig=
X-Gm-Gg: ASbGncsKbSynX6CH+6sNdfRN1tf0KBIQ9V0qZQPzYcFcMC0a5+brjonMT9FZybFQnGL
	yJXNC5U2y3WAbGF9PMQOdxmnbCogZKAqkaPwfZQFnBhMXgFDUY3Xnrapo+AWwkSrsTEbRlhno7F
	CqA1BU0zs1eGRpAGSDMCX74mqE0dEQ5rC7fZAyeJgF8GgYuvSwaQvSZzwlYdCatyKXyolBwC6RN
	apSUJy8jtf+IIYBAiTnq9ilWVhFbbRPId/xfVj2m2SpYVEEMwoo+t2VgdVQa5XCMwR9wPqftreR
	80xQOZ4Z8E4cBtTkxO0ScY0hvrcVaHKibTtc4MsjxnEJ4Sbmkx8ZmhtfZdyJAW8evux1wDy63dy
	xWyFeI9K4crhnyoRov31uN4NsPY5dxzJnksg3H7EaYrDAkjFB+7lGbgIgdQA+WCRJMQs=
X-Google-Smtp-Source: AGHT+IHjeCgwZEfqa7Y96eBDiBrld/XfJPAMOxqhP0Mq1Pdz0VZI7xx+XxPK7PDI4V3mCywjFrMjnQ==
X-Received: by 2002:a17:907:9484:b0:b2b:3c31:9529 with SMTP id a640c23a62f3a-b34b8b9372cmr357285366b.15.1758809039838;
        Thu, 25 Sep 2025 07:03:59 -0700 (PDT)
Received: from smtpclient.apple ([194.237.228.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3546355d6bsm168614766b.111.2025.09.25.07.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:03:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
In-Reply-To: <20250917174941.000061d3@huawei.com>
Date: Thu, 25 Sep 2025 16:03:46 +0200
Cc: Wei Xu <weixugc@google.com>,
 David Rientjes <rientjes@google.com>,
 Gregory Price <gourry@gourry.net>,
 Matthew Wilcox <willy@infradead.org>,
 Bharata B Rao <bharata@amd.com>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 dave.hansen@intel.com,
 hannes@cmpxchg.org,
 mgorman@techsingularity.net,
 mingo@redhat.com,
 peterz@infradead.org,
 raghavendra.kt@amd.com,
 riel@surriel.com,
 sj@kernel.org,
 ying.huang@linux.alibaba.com,
 ziy@nvidia.com,
 dave@stgolabs.net,
 nifan.cxl@gmail.com,
 xuezhengchu@huawei.com,
 akpm@linux-foundation.org,
 david@redhat.com,
 byungchul@sk.com,
 kinseyho@google.com,
 joshua.hahnjy@gmail.com,
 yuanchu@google.com,
 balbirs@nvidia.com,
 alok.rathore@samsung.com,
 yiannis@zptcorp.com,
 Adam Manzanares <a.manzanares@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)



> On 17 Sep 2025, at 18:49, Jonathan Cameron =
<jonathan.cameron@huawei.com> wrote:
>=20
> On Tue, 16 Sep 2025 17:30:46 -0700
> Wei Xu <weixugc@google.com> wrote:
>=20
>> On Tue, Sep 16, 2025 at 12:45=E2=80=AFPM David Rientjes =
<rientjes@google.com> wrote:
>>>=20
>>> On Wed, 10 Sep 2025, Gregory Price wrote:
>>>=20
>>>> On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote: =20
>>>>> On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote: =20
>>>>>> This patchset introduces a new subsystem for hot page tracking
>>>>>> and promotion (pghot) that consolidates memory access information
>>>>>> from various sources and enables centralized promotion of hot
>>>>>> pages across memory tiers. =20
>>>>>=20
>>>>> Just to be clear, I continue to believe this is a terrible idea =
and we
>>>>> should not do this.  If systems will be built with CXL (and given =
the
>>>>> horrendous performance, I cannot see why they would be), the =
kernel
>>>>> should not be migrating memory around like this. =20
>>>>=20
>>>> I've been considered this problem from the opposite approach since =
LSFMM.
>>>>=20
>>>> Rather than decide how to move stuff around, what if instead we =
just
>>>> decide not to ever put certain classes of memory on CXL.  Right =
now, so
>>>> long as CXL is in the page allocator, it's the wild west - any page =
can
>>>> end up anywhere.
>>>>=20
>>>> I have enough data now from ZONE_MOVABLE-only CXL deployments on =
real
>>>> workloads to show local CXL expansion is valuable and performant =
enough
>>>> to be worth deploying - but the key piece for me is that =
ZONE_MOVABLE
>>>> disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out =
of
>>>> CXL, but allows any given user-driven page allocation (including =
page
>>>> cache, file, and anon mappings) to land there.
>>>>=20
>>>=20
[snip]
>>> There's also some feature support that is possible with these CXL =
memory
>>> expansion devices that have started to pop up in labs that can also
>>> drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able =
to
>>> chime in as well.
>>>=20
>>> This topic seems due for an alignment session as well, so will look =
to get
>>> that scheduled in the coming weeks if people are up for it. =20
>>=20
>> Our experience is that workloads in hyper-scalar data centers such as
>> Google often have significant cold memory. Offloading this to CXL =
memory
>> devices, backed by cheaper, lower-performance media (e.g. DRAM with
>> hardware compression), can be a practical approach to reduce overall
>> TCO. Page promotion and demotion are then critical for such a tiered
>> memory system.
>=20
> For the hardware compression devices how are you dealing with capacity =
variation
> / overcommit? =20
I understand that this is indeed one of the key questions from the =
upstream
kernel=E2=80=99s perspective.
So, I am jumping in to answer w.r.t. what we do in ZeroPoint; obviously =
I can
not speak of other solutions/deployments. However, our HW interface =
follows=20
existing open specifications from OCP=E2=80=8B [1], so what I am =
describing below is
more widely applicable.

At a very high level, the way our HW works is that the DPA is indeed
overcommitted. Then, there is a control plane over CXL.io (PCIe) which
exposes the real remaining capacity, as well as some configurable
MSI-X interrupts that raise warnings when the capacity crosses over
certain configurable thresholds.

Last year I presented this interface in LSF/MM [2]. Based on the =
feedback I
got there, we have an early prototype that acts as the *last* memory =
tier
before reclaim (kind of "compressed tier in lieu of discard" as was
suggested to me by Dan).

What is different from standard tiering is that the control plane is
checked on demotion to make sure there is still capacity left. If not, =
the
demotion fails. While this seems stable so far, a missing piece is to
ensure that this tier is mainly written by demotions and not arbitrary =
kernel
allocations (at least as a starting point). I want to explore how =
mempolicies
can help there, or something of the sort that Gregory described.

This early prototype still needs quite some work in order to find the =
right
abstractions. Hopefully, I will be able to push an RFC in the near =
future
(a couple of months).

> Whilst there have been some discussions on that but without a
> backing store of flash or similar it seems to be challenging to use
> compressed memory in a tiering system (so as 'normalish' memory) =
unless you
> don't mind occasionally and unexpectedly running out of memory (in =
nasty
> async ways as dirty cache lines get written back).
There =E2=80=8Bare several things that may be done on the device side. =
For now, I
think the kernel should be unaware of these. But with what I described
above, the goal is to have the capacity thresholds configured in a way
that we can absorb the occasional dirty cache lines that are written =
back.
>=20
> Or do you mean zswap type use with a hardware offload of the actual
> compression?
I would categorize this as a completely different discussion (and =
product
line for us).

[1] =
https://www.opencompute.org/documents/hyperscale-tiered-memory-expander-sp=
ecification-for-compute-express-link-cxl-1-pdf
[2] https://www.youtube.com/watch?v=3DtXWEbaJmZ_s

Thanks,
Yiannis

PS: Sending from a personal email address to avoid issues with
confidentiality footers of the corporate domain.=

