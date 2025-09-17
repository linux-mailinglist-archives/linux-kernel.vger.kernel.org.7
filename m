Return-Path: <linux-kernel+bounces-821782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E48B823B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DE6263B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979682C1583;
	Wed, 17 Sep 2025 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UegGWzPG"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE29478
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150302; cv=none; b=K74LGfJ1Rsomd9mhAHvvbkvMOGt2tUv1KP+N1if17lWVJQ/41sIvfy3grF1HWGFRKdgNXGk4wELwBfMch+B02634wfgqNMNX8HWiq97aGsoDadQmIuTzNPe5nBRyNXICur9MumCa0k9X89ePcL1+01B7PKS10WfMLyBiHuk8gSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150302; c=relaxed/simple;
	bh=dR1/3B0uLM7h8u82KRKDaZNzgKalcWTw90Yo1zs9izM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRqKEkoRjOvBqi9NvefG+Jz4xViJP81UnsJHoBdyQSE4QD93v2GHP6l5+FluIkIJKNIM6buRx+lAUG3Mn7BlPWUBrw1hFQKjjY+y3ohGTX1SdE+IhAUMzj2s7+lvwG+1zlgYTev6BLdqIfn1rapo3h9NpHYymoo4NCQW7NEpn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UegGWzPG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b78657a35aso128031cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758150300; x=1758755100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVacp95PmJEGvpJOGbUdRRUCnkNBzPvT5lvXym+9x6g=;
        b=UegGWzPGOKN8Eq66ZDl4fWjGRfqJhazIl8N0q+2ORMkCTcuOBusESm5fdqfRYKUCWG
         VaLe8zDEW9JvpIHhrkqpCzKqypO+PB3ORo24BAG8obVk0CEOKAvIqRuww9z71fUKWk1m
         dRdOwkqUHDPxGUjcS1NSyaMkFqugvz37ddO6finMGOg9RxhzPB32M+eWcS5es/2aEi3s
         U+dLqahefMae4c8Smilhk3u1NRvJY9+H/dUwsvdF8g6qUv9cM5ZJDrR9xPnPviCHj2bf
         N10QBm7qThCvCi1DcHl9R5x9NyKqZ7OKlAWs5LrdQbL8lRPfUqK5c623jTSrSxgSSCXN
         O2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150300; x=1758755100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVacp95PmJEGvpJOGbUdRRUCnkNBzPvT5lvXym+9x6g=;
        b=nOp2fVARMKqkqX2XCnpMkpnRm0kKYqyiOnSL4yGRpPKJ2eiozTv0RhmgJYJzEXGRx2
         Tb+ltGmwyA74UYSr0yw2Zpkx2IMx/0nlp1AhIu34EurYc/qzqsUU/UtTLOJGudwKMzw6
         sG+1bdXRNfDsqjHFDv14HK5aTfGuO5MOBuyNIZnu8T/UtRDOrvFl7pNLoq3wLwLkZV3c
         IwTu2B6I9Lv2XbN5ZEsjx7bMIzEZWS1+jZ92NWHpZ9hvx/PpI4o0q3NyMlRkLdccL4To
         AXfKQ6I4Bdu+RjbijJgXc+zbD6tf0uGQTPBuCvsA1vd9kvvRBtikT43rRlBlR0w7z1wI
         z6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUivXslaXhBUO6rpTkGuHdm9325juJDxzmDhHG91GW7T2KYkToSGxRnMjBIN9eq97kl6nVlvIIWXJDr+Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTA9LaynMDdpeVPdeNOqzkoIgRw2N5z7b6XTvprDLqHrWhvA+z
	ccLtVlqwjvymzWURJN9QruVheJx3xACoP3Mjvcma405ZNl6BZPoVNmOW5DuCbEjcaOsOoF66Ke2
	NINKO0EUeulYL4t59Az2YE4TxeH/lDiZwwDk3l74v
X-Gm-Gg: ASbGncs6Y1R34XrhENHegxkafaSWOZqKRjos30NcNeMw/oddnc5TL0AIoC+A3CK0Bob
	2ttm3IHGTZ7yjuGrYNUcYuH6wSYTytZeIlkiQB7/ioDbOBXkWdezrGLs8F1TDz1Bsm7aiNgDxoq
	NPqBwKNhkgExSFyDSZwN6QVqZY2JFPtt7pxPXgEKoKe+uZj9qtYy4YIJ69XIMMk9IlBxUGhzXlo
	X6pyaioRKcTRBd9yAyaBOfQ70ffk+o=
X-Google-Smtp-Source: AGHT+IEpS7YuKIKyZFfw31Uu07t4KPK9fVtMAut4dTsdy4GPUFdw8RSwkUECsWmieUIlYCZPPsPBn+8xhrMusrmOb7c=
X-Received: by 2002:a05:622a:188d:b0:4b4:9590:e091 with SMTP id
 d75a77b69052e-4ba2e670206mr8111921cf.5.1758150299422; Wed, 17 Sep 2025
 16:04:59 -0700 (PDT)
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
 <CAJuCfpGgVa9X7nXhqOUZWi+p+JGz1QofiXrTJ+BF=DU3m2-64w@mail.gmail.com> <d451dce9-2217-4351-bc53-09967fa86cca@gmail.com>
In-Reply-To: <d451dce9-2217-4351-bc53-09967fa86cca@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Sep 2025 16:04:48 -0700
X-Gm-Features: AS18NWAeIVfrhOzpDwgwUeOERlQjLT1PVrBGTGH4hcV6VLZUnFIIfH2FmKLtLBU
Message-ID: <CAJuCfpFBov_2F9Kx5Csio=hOe8kY1yXjmg_z8dXU=ZUQ_-wmaQ@mail.gmail.com>
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

On Wed, Sep 17, 2025 at 2:10=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 16/09/2025 23:27, Suren Baghdasaryan wrote:
> > On Tue, Sep 16, 2025 at 10:26=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>
> >> On Tue, Sep 16, 2025 at 9:52=E2=80=AFPM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 16/09/2025 22:46, Suren Baghdasaryan wrote:
> >>>> On Tue, Sep 16, 2025 at 2:11=E2=80=AFPM Usama Arif <usamaarif642@gma=
il.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
> >>>>>> On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Vlastimil Babka <vbabka@su=
se.cz> wrote:
> >>>>>>>
> >>>>>>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
> >>>>>>>> While rare, memory allocation profiling can contain inaccurate c=
ounters
> >>>>>>>> if slab object extension vector allocation fails. That allocatio=
n might
> >>>>>>>> succeed later but prior to that, slab allocations that would hav=
e used
> >>>>>>>> that object extension vector will not be accounted for. To indic=
ate
> >>>>>>>> incorrect counters, "accurate:no" marker is appended to the call=
 site
> >>>>>>>> line in the /proc/allocinfo output.
> >>>>>>>> Bump up /proc/allocinfo version to reflect the change in the fil=
e format
> >>>>>>>> and update documentation.
> >>>>>>>>
> >>>>>>>> Example output with invalid counters:
> >>>>>>>> allocinfo - version: 2.0
> >>>>>>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create=
_setup_data_nodes
> >>>>>>>>            0        0 arch/x86/kernel/alternative.c:2090 func:al=
ternatives_smp_module_add
> >>>>>>>>            0        0 arch/x86/kernel/alternative.c:127 func:__i=
ts_alloc accurate:no
> >>>>>>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xsta=
teregs_set
> >>>>>>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fps=
tate_realloc
> >>>>>>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:=
arch_enable_hybrid_capacity_scale
> >>>>>>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:25=
8 func:init_amd_l3_attrs
> >>>>>>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:m=
ce_device_create accurate:no
> >>>>>>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func=
:mce_gen_pool_create
> >>>>>>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mc=
e_threshold_create_device
> >>>>>>>>
> >>>>>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>>>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
> >>>>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>>>>
> >>>>>>> With this format you could instead print the accumulated size of =
allocations
> >>>>>>> that could not allocate their objext (for the given tag). It shou=
ld be then
> >>>>>>> an upper bound of the actual error, because obviously we cannot r=
ecognize
> >>>>>>> moments where these allocations are freed - so we don't know for =
which tag
> >>>>>>> to decrement. Maybe it could be more useful output than the yes/n=
o
> >>>>>>> information, although of course require more storage in struct co=
detag, so I
> >>>>>>> don't know if it's worth it.
> >>>>>>
> >>>>>> Yeah, I'm reluctant to add more fields to the codetag and increase=
 the
> >>>>>> overhead until we have a usecases. If that happens and with the ne=
w
> >>>>>> format we can add something like error_size:<value> to indicate th=
e
> >>>>>> amount of the error.
> >>>>>>
> >>>>>>>
> >>>>>>> Maybe a global counter of sum size for all these missed objexts c=
ould be
> >>>>>>> also maintained, and that wouldn't be an upper bound but an actua=
l current
> >>>>>>> error, that is if we can precisely determine that when freeing an=
 object, we
> >>>>>>> don't have a tag to decrement because objext allocation had faile=
d on it and
> >>>>>>> thus that allocation had incremented this global error counter an=
d it's
> >>>>>>> correct to decrement it.
> >>>>>>
> >>>>>> That's a good idea and should be doable without too much overhead.=
 Thanks!
> >>>>>> For the UAPI... I think for this case IOCTL would work and the use
> >>>>>> scenario would be that the user sees the "accurate:no" mark and is=
sues
> >>>>>> ioctl command to retrieve this global counter value.
> >>>>>> Usama, since you initiated this feature request, do you think such=
 a
> >>>>>> counter would be useful?
> >>>>>>
> >>>>>
> >>>>>
> >>>>> hmm, I really dont like suggesting changing /proc/allocinfo as it w=
ill break parsers,
> >>>>> but it might be better to put it there?
> >>>>> If the value is in the file, I imagine people will be more prone to=
 looking at it?
> >>>>> I am not completely sure if everyone will do an ioctl to try and fi=
nd this out?
> >>>>> Especially if you just have infra that is just automatically collec=
ting info from
> >>>>> this file.
> >>>>
> >>>> The current file reports per-codetag data and not global counters. W=
e
> >>>> could report it somewhere in the header but the first question to
> >>>> answer is: would this be really useful (not in a way of  "nice to
> >>>> have" but for a concrete usecase)? If not then I would suggest keepi=
ng
> >>>> things simple until there is a need for it.
> >>>>
> >>>
> >>> I think its a nice to have. I can't think of a concrete usecase at pr=
esent.
> >>>
> >>> I guess a potential usecase is if you are trying to use memory alloca=
tion
> >>> profiling to debug OOMs and the missed objects size is very large. I =
guess we
> >>> wont know until this happens, but I would hope this number is usually=
 small.
> >>
> >> Hmm. Missing a large allocation and not knowing about it can be a prob=
lem...
> >> I'll start sketching a patch to see if tracking such a global counter
> >> has any drawbacks and in the meantime I'm open to suggestions on how
> >> to expose it to the userspace.
> >>
> >> About concerns on the IOCTL interface, would it be more usable if we
> >> get the alloctop [1] or a similar tool which can be used to easily
> >> issue such commands into kernel/tools?
> >>
> >> [1] https://android-review.git.corp.google.com/c/platform/system/memor=
y/libmeminfo/+/3431860
> >
> > Ugh, sorry. Externally accesible link would be
> > https://android-review.googlesource.com/c/platform/system/memory/libmem=
info/+/3431860
> >
>
> Yeah this would be nice to have. We do have something very similar in our=
 infra, to basically
> sort by size and store only top x entries.
>
> When doing manually, I just do sort -g /proc/allocinfo|tail -n 30|numfmt =
--to=3Diec which is copied from
> the kernel doc.

Got it. I guess if we get an upstream tool like that which is kept
in-sync with kernel's UAPI and new features, that would make the
maintenance easier for everyone.

