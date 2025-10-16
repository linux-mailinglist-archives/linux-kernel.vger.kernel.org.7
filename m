Return-Path: <linux-kernel+bounces-856122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F2BE328D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0127B587147
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD231CA54;
	Thu, 16 Oct 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix9hvkPB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2582741AB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615297; cv=none; b=YcRwKjxxKAilagdoZgDSRzjf8GTJ0P0yd/vQ7gp7KDurCJbbOprwgOnnBbmhjMrBOw28qf4Hs0BwlEdWy4p2LP0GHfo1k+CR5k5DNDC3V9kEx3wJvn/3cqJ+gLohcbOxkh4R8nktIcMTSJtHG0xMwMMNhiknzGmTZy9Lj7GlAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615297; c=relaxed/simple;
	bh=gnYW3cmLfcJmyL+dDXi/ADL2dg+IMPo0iOKFLlQwOTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzt1jVl/81mclwuYbm5VeUPFSuY47L0z0Is+gH3YDfOK7lGbcrAkMljKPyJcRyB8LUwUmXyMaUVAjkk1J0rxpDNfWcAGa/oQ78rRPlIyYiKQUloCOChROvQoX7WBQ3uury1QkNB7Rdz1Oi8l1B6Ol4a9A2hAjBEemGNZyKETHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix9hvkPB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e9d633b78so147294866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615294; x=1761220094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbfblspUf1NHvFa8rqaPO/OBh7bIieHqwYUbGcwqhUY=;
        b=Ix9hvkPBunDkkdMRdMjPCZZ1tLl8Dwi6fLyeFkl1xw3ToUl6mDsXjeGm33BMCYz2aA
         pYipCcsg3SejzHkgl7Qv0CzoJOx2iq7MWXvr93lkocuPuseGlLa2ffbjd9WqZp093uBZ
         FBACQ1cTdq+Z2jj0A7OHY/MN1SEb8m9j2QdMoQRT2Hnb5/2xlBDrg0Hcm0UIizibirmL
         yjwZrBL4Plck5ML9A+t7SzMGqYSAjagV+iB84vaPNQztlplnqxcGIwZ+u8fN56Cggl7p
         T9EX1jo+3KFrba7lBp7UVa34j/oSIE4epDcdOqhl12l0Za2mfxRvTHXkvSAu4is9AGu0
         42jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615294; x=1761220094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbfblspUf1NHvFa8rqaPO/OBh7bIieHqwYUbGcwqhUY=;
        b=t0EkbFzAgvUcz+pYCtltBq0TCrlZJyMu6rFz1wdyrelg6ueMRSadiRUXSvGPIc8+iJ
         3UA4MvemdTXAkpjKEFYJ9n8C3BveB6b2cqq7MGN+JVG26QpDXvkdrRdwr1F1KVAHqo2n
         6l3hjVhubNVFmQUKfsieyTyKvQPyZ8DOP2v+++hqzAPYob7YvZzZHvVPVTtZK1YuNg93
         GLSYTFZ48vMRZfXGPL40xBEUD9epyYd1B/lpRdqtehx+huQlx4mJqB0pu1ZQA2rsJgAN
         Ddh/1hSGk0kkJLswTULlT5wA9p3Pjx2/RxPYf9gksCXyrutD1QPnWlODDNJ6daVhf7NF
         gPiw==
X-Forwarded-Encrypted: i=1; AJvYcCX88vze82XPDR8OIiHtmGzIf1c9RyLZYN2HHImLZ0ulR6vfYvyeWb9cl8GWDfcO7OqcAoRUivwFUlpwTYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+MmI9o+PC1gfIWgXrx3JjWA9X6v0F8Ot9tcBlpNEDgCMZLqY
	K9bjet1Mqa0Z9rDwrS9bMV11fJq/TWcR2a6dSfCv2+F5btKPGvUodFcdosmbNF8hITyQGUwGQf5
	Q6fhLaUEP1fxZz/AHRp2deUy3WAP9jtuE5Nqf
X-Gm-Gg: ASbGncvoonLoGDUFOrs5OPJz+jzgbFyKNR0wsZFPZfwntOy0p5fUD8Tf3A9w4eWKk3w
	BBYrCfKCRPKwPhQIqxp00VbW4qYgDqq5/vGfvw275R2O26i/geTP4B0a3p7nWzXzLaIWEbijPIU
	u4K6+4tRKh26FCpkp2hsJFvjz7sClBVRJMbIU9CwSMW5n6e6vfnaqCIVGCGz9c3hgKu6T7EjD3b
	mwM90RHubpD7N+Wl3skKGWs+8c9LMvYqi6dFwnB7PEmeU1SVl8z1NHfNVy7knMX4vxgjsfKQe5g
	DrU4nLb8
X-Google-Smtp-Source: AGHT+IGcC+rv81VWhZTcZBUgRu0dX8VfUzA2nML1FlKIlGwDvZnd5mmYfiM+F+OaoWEvfM+30LqIrY79KpIOMbvrCOM=
X-Received: by 2002:a17:906:ba85:b0:b3d:d30b:39c0 with SMTP id
 a640c23a62f3a-b605430adffmr404516466b.21.1760615293429; Thu, 16 Oct 2025
 04:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910144653.212066-1-bharata@amd.com> <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F> <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com> <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <aNVUj0s30rrXEh4C@gourry-fedora-PF4VCD3F>
In-Reply-To: <aNVUj0s30rrXEh4C@gourry-fedora-PF4VCD3F>
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Thu, 16 Oct 2025 13:48:00 +0200
X-Gm-Features: AS18NWDJVaOLg3sD89oqQ0S3zxcwWAIbzuo4fkT0WRZGgszNkjVK1a-hVthyEu8
Message-ID: <CAOi6=wTXSTgTB+KUpn+LOUGvXg4UeEz-DN0mh-LjChn3g8YiHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	dave.hansen@intel.com, hannes@cmpxchg.org, mgorman@techsingularity.net, 
	mingo@redhat.com, peterz@infradead.org, raghavendra.kt@amd.com, 
	riel@surriel.com, sj@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	dave@stgolabs.net, nifan.cxl@gmail.com, xuezhengchu@huawei.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com, 
	Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

Thanks for all the feedback. I am finally getting some time to come
back to this.

On Thu, Sep 25, 2025 at 4:41=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Thu, Sep 25, 2025 at 04:03:46PM +0200, Yiannis Nikolakopoulos wrote:
> > >
> > > For the hardware compression devices how are you dealing with capacit=
y variation
> > > / overcommit?
> ...
> > What is different from standard tiering is that the control plane is
> > checked on demotion to make sure there is still capacity left. If not, =
the
> > demotion fails. While this seems stable so far, a missing piece is to
> > ensure that this tier is mainly written by demotions and not arbitrary =
kernel
> > allocations (at least as a starting point). I want to explore how mempo=
licies
> > can help there, or something of the sort that Gregory described.
> >
>
> Writing back the description as i understand it:
>
> 1) The intent is to only have this memory allocable via demotion
>    (i.e. no fault or direct allocation from userland possible)
Yes that is what looks to me like the "safe" way to begin with. In
theory you could have userland apps/middleware that is aware of this
memory and its quirks and are ok to use it but I guess we can leave
that for later and it feels like it could be provided by a separate
driver.
>
> 2) The intent is to still have this memory accessible directly (DMA),
>    while compressed, not trigger a fault/promotion on access
>    (i.e. no zswap faults)
Correct. One of the big advantages of CXL.mem is the cache-line access
granularity and our customers don't want to lose that.
>
> 3) The intent is to have an external monitoring software handle
>    outrunning run-away decompression/hotness by promoting that data.
External is not strictly necessary. E.g. it could be an additional
source of input to the kpromote/kmigrate solution.
>
> So basically we want a zswap-like interface for allocation, but to
If by "zswap-like interface" you mean something that can reject the
demote (or store according to the zswap semantics) then yes.
I just want to be careful when comparing with zswap.
> retain the `struct page` in page tables such that no faults are incurred
> on access.  Then if the page becomes hot, depend on some kind of HMU
> tiering system to get it off the device.
Correct.
>
> I think we all understand there's some bear we have to outrun to deal
> with problem #3 - and many of us are skeptical that the bear won't catch
> up with our pants down.  Let's ignore this for the moment.
Agreed.
>
> If such a device's memory is added to the default page allocator, then
> the question becomes one of *isolation* - such that the kernel will
> provide some "Capital-G Guarantee" that certain NUMA nodes will NEVER
> be used except under very explicit scenarios.
>
> There are only 3 mechanisms with which to restrict this (presently):
>
> 1) ZONE membership (to disallow GFP_KERNEL)
> 2) cgroups->cpusets->mems_allowed
> 3) task/vma mempolicy
> (obvious #4: Don't put it in the default page allocator)
>
> cpusets and mempolicy are not sufficient to provide full isolation
> - cgroups have the opposite hierarchical relationship than desired.
>   The parent cgroup will lock out all children cgroups from using nodes
>   not present in the parent mems_allowed. e.g. if you lock out access
>   from the root cgroup, no cgroup on the entire system is eligible to
>   allocate the memory.  If you don't lock out the root cgroup - any root
>   cgroup task is eligible.  This isn't tractible.
>
> - task/vma mempolicy gets ignored in many cases and is closer to a
>   suggestion than enforcible.  It's also subject to rebinding as a
>   task's cgroups.cpuset.mems_allowed changes.
>
> I haven't read up enough on ZONE_DEVICE to understand the implications
> of membership there, but have you explored this as an option?  I don't
> see the work i'm doing intersecting well with your efforts - except
> maybe on the vmscan.c work around allocation on demotion.
Thanks for the very helpful breakdown. Your take on #2 & #3 seems
reasonable. About #1, I've skimmed through the rest of the thread and
I'll continue addressing your responses there.

Yiannis
>
> The work i'm doing is more aligned with - hey, filesystems are a global
> resource, why are we using cgroup/task/vma policies to dictate whether a
> filesystem's cache is eligible to land in remote nodes? i.e. drawing
> better boundaries and controls around what can land in some set of
> remote nodes "by default".  You're looking for *strong isolation*
> controls, which implies a different kind of allocator interface.
>
> ~Gregory

