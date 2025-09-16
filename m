Return-Path: <linux-kernel+bounces-819695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45AB7DD64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A50C3A3544
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8D323F63;
	Tue, 16 Sep 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agB0wlt2"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC72E2DF2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061636; cv=none; b=mnn0Uzhdl+agO0PoUcREp8HqynOTAsYH77d3lzfeKwFr8EeVtu48Lduol0zCql7J9W37qeitEezjHQH1h0OlztYU0RhPMGu5cHu30SsyfiwaJJDCEFEs1O/wfY/EjdGjDEYeF5uwxmu3BfRPTNx5/rBGvM6XWDyCDHSiQBNRFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061636; c=relaxed/simple;
	bh=ZC0S4op/aNxyz7Wj67ILxedTb4k9w2qmvAh0Ti2hgkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVhH6MOabiBPKnIP0wJRDgH0Omnv1xaDLpqpPlk4p35BwywlEKcuvl/Ir2YC+KkeCuLescf6znk3Q6EdjEoziMr7gcPzlvnkVsKUyEBwj7Z1z3Nke8k6WmCEq3LEmtXfzSk9OX9YnKD64A0ImyBWYNl4wDD8wEWqRjGzi9HnpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agB0wlt2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b796ff6d45so81441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758061633; x=1758666433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5oGqStTlrxjJJErw3FSyvsriDK+5H2PHCclCCKyPlI=;
        b=agB0wlt2x373TjgOmfXgX7mqQ6ymbJvklQiSSBpV8YnSUADi4fYWz2SK07kJ4JHusF
         +rZj+m8ZuTLuEjGXfZHUZOZPAk4pkIF5W1HoeM59rl3xjN7TsGL0M2sq6nGo/WxKDLWe
         nRn7Hvt/hKvNWaeqpHpLrIDcq9TBrx+VKjK6KklQ28Iqzj/6SJCmbMEijhxySK7K2Osi
         Fhga+M88uo244CE5gbKyHAT6WaRJv00iz/ob3CzzFJiCWf8tfmLzOD8WFiwfWNWWA4Rs
         6GXaEBG6oWthejzLR/nDyNUdKcy4fxy08u58YtphNemmJ+OUzdRJzrt54CRMRzN4qI5j
         1f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061633; x=1758666433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5oGqStTlrxjJJErw3FSyvsriDK+5H2PHCclCCKyPlI=;
        b=Y2ox/xQCGj7ZqEFo+nAm6Jc9twvrFDii76irYAo4C181ceB3NJ9dEnh/NdoI8hp3l+
         DgV86dPf/RKcVMIp5YW+MtXg9WIGs5Wg/s9yWdTJVTrK39XApvEzFrmcVWuzR1R8godG
         4iKsjyDQ4imKVbLgB7cT/AOb2DeUh6K/h3UqxR8hEQbVvWomVgfg0RiC0T5y0lLoFv95
         3v+dZwzrnGELUpXBFtu3be8p3gKHvqoTot7NPJq8WdM10SzSm3BRCt6rZUfin8zr8z1Y
         lTqz+KZZszB8+b097yhZ6j2NSaKs1ZpbuXTZ/lg0UbvgjA60/sro6zN/7VL5lAP+Auaz
         01Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXUsAS+TTb7/GzjeYcC62G8ZqPdzGZYohiP9U3hqbCcuhNtXu6AqaILbZny/JCuOuzIWHsGc1PSTUdlWmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27dTn1k4idV6L48CBMV6aT9NdnxgRzKXwc4jg1qoQ+NjtksMZ
	3newo0VA+yS+/rnapdnxoSjz8fSpY3Jq5gOvyfBM0rjqEOPhTqSzPv2VaQnPMZgQ/6ZX3d/Ri+q
	pvOSeser87tANUCcucCLuiHJOxuiDv9AP6UpxrVU1
X-Gm-Gg: ASbGncsdBHtanYYOCdqilCo8VqJOp0j/rR1NDdq9kBGd6C1kai/Hs+gzzBWhY/9y9PR
	V/IGLLAkMNbsWYyfSZCmfDa0ReEfC6Uobti8natT1Agp+gKetub1HTEcZE+M0ELE6iO5vGomPM/
	i97iSxNkxc0jgtRfP9sPFZ1JzkPnXJumMkopQSqVgEnCNILKEmiu0rc/dZTs55u+6xhzqqDCgWY
	hfb7k+oVZFRTVuVoIgLC2lqwSmtPtkX3JXOceFnLiWJknIgS2Qt
X-Google-Smtp-Source: AGHT+IEUNWLGad5EmSZbszNpLgC7MWP+kbjMVYLNIGqPaE6Z5fcUumRp4YQSjQFFL5pYHmDte9ohw2TcDL5C7EMoxKg=
X-Received: by 2002:a05:622a:24a:b0:4b3:4ed0:c6f6 with SMTP id
 d75a77b69052e-4b9dedd96d1mr2412771cf.16.1758061632490; Tue, 16 Sep 2025
 15:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
 <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com> <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
 <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com> <CAJuCfpEULVxMixDjrk_xg7+3+97dkcMmkDd++BaR17X4tDSs6Q@mail.gmail.com>
In-Reply-To: <CAJuCfpEULVxMixDjrk_xg7+3+97dkcMmkDd++BaR17X4tDSs6Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 22:27:01 +0000
X-Gm-Features: AS18NWCkByc0Xrj59xTWaHu3gfBggFkAKq-qIvFSK4jhhtsFXnOzESI7IWk08is
Message-ID: <CAJuCfpGgVa9X7nXhqOUZWi+p+JGz1QofiXrTJ+BF=DU3m2-64w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:26=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Sep 16, 2025 at 9:52=E2=80=AFPM Usama Arif <usamaarif642@gmail.co=
m> wrote:
> >
> >
> >
> > On 16/09/2025 22:46, Suren Baghdasaryan wrote:
> > > On Tue, Sep 16, 2025 at 2:11=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> > >>
> > >>
> > >>
> > >> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
> > >>> On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> > >>>>
> > >>>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
> > >>>>> While rare, memory allocation profiling can contain inaccurate co=
unters
> > >>>>> if slab object extension vector allocation fails. That allocation=
 might
> > >>>>> succeed later but prior to that, slab allocations that would have=
 used
> > >>>>> that object extension vector will not be accounted for. To indica=
te
> > >>>>> incorrect counters, "accurate:no" marker is appended to the call =
site
> > >>>>> line in the /proc/allocinfo output.
> > >>>>> Bump up /proc/allocinfo version to reflect the change in the file=
 format
> > >>>>> and update documentation.
> > >>>>>
> > >>>>> Example output with invalid counters:
> > >>>>> allocinfo - version: 2.0
> > >>>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_=
setup_data_nodes
> > >>>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alt=
ernatives_smp_module_add
> > >>>>>            0        0 arch/x86/kernel/alternative.c:127 func:__it=
s_alloc accurate:no
> > >>>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstat=
eregs_set
> > >>>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpst=
ate_realloc
> > >>>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:a=
rch_enable_hybrid_capacity_scale
> > >>>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258=
 func:init_amd_l3_attrs
> > >>>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mc=
e_device_create accurate:no
> > >>>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:=
mce_gen_pool_create
> > >>>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce=
_threshold_create_device
> > >>>>>
> > >>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > >>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >>>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
> > >>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >>>>
> > >>>> With this format you could instead print the accumulated size of a=
llocations
> > >>>> that could not allocate their objext (for the given tag). It shoul=
d be then
> > >>>> an upper bound of the actual error, because obviously we cannot re=
cognize
> > >>>> moments where these allocations are freed - so we don't know for w=
hich tag
> > >>>> to decrement. Maybe it could be more useful output than the yes/no
> > >>>> information, although of course require more storage in struct cod=
etag, so I
> > >>>> don't know if it's worth it.
> > >>>
> > >>> Yeah, I'm reluctant to add more fields to the codetag and increase =
the
> > >>> overhead until we have a usecases. If that happens and with the new
> > >>> format we can add something like error_size:<value> to indicate the
> > >>> amount of the error.
> > >>>
> > >>>>
> > >>>> Maybe a global counter of sum size for all these missed objexts co=
uld be
> > >>>> also maintained, and that wouldn't be an upper bound but an actual=
 current
> > >>>> error, that is if we can precisely determine that when freeing an =
object, we
> > >>>> don't have a tag to decrement because objext allocation had failed=
 on it and
> > >>>> thus that allocation had incremented this global error counter and=
 it's
> > >>>> correct to decrement it.
> > >>>
> > >>> That's a good idea and should be doable without too much overhead. =
Thanks!
> > >>> For the UAPI... I think for this case IOCTL would work and the use
> > >>> scenario would be that the user sees the "accurate:no" mark and iss=
ues
> > >>> ioctl command to retrieve this global counter value.
> > >>> Usama, since you initiated this feature request, do you think such =
a
> > >>> counter would be useful?
> > >>>
> > >>
> > >>
> > >> hmm, I really dont like suggesting changing /proc/allocinfo as it wi=
ll break parsers,
> > >> but it might be better to put it there?
> > >> If the value is in the file, I imagine people will be more prone to =
looking at it?
> > >> I am not completely sure if everyone will do an ioctl to try and fin=
d this out?
> > >> Especially if you just have infra that is just automatically collect=
ing info from
> > >> this file.
> > >
> > > The current file reports per-codetag data and not global counters. We
> > > could report it somewhere in the header but the first question to
> > > answer is: would this be really useful (not in a way of  "nice to
> > > have" but for a concrete usecase)? If not then I would suggest keepin=
g
> > > things simple until there is a need for it.
> > >
> >
> > I think its a nice to have. I can't think of a concrete usecase at pres=
ent.
> >
> > I guess a potential usecase is if you are trying to use memory allocati=
on
> > profiling to debug OOMs and the missed objects size is very large. I gu=
ess we
> > wont know until this happens, but I would hope this number is usually s=
mall.
>
> Hmm. Missing a large allocation and not knowing about it can be a problem=
...
> I'll start sketching a patch to see if tracking such a global counter
> has any drawbacks and in the meantime I'm open to suggestions on how
> to expose it to the userspace.
>
> About concerns on the IOCTL interface, would it be more usable if we
> get the alloctop [1] or a similar tool which can be used to easily
> issue such commands into kernel/tools?
>
> [1] https://android-review.git.corp.google.com/c/platform/system/memory/l=
ibmeminfo/+/3431860

Ugh, sorry. Externally accesible link would be
https://android-review.googlesource.com/c/platform/system/memory/libmeminfo=
/+/3431860

>
> >

