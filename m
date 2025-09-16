Return-Path: <linux-kernel+bounces-819693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06580B7D726
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FFF7B7CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C931FEE4;
	Tue, 16 Sep 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aict2+08"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0831BC8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061585; cv=none; b=nCVv0ygkmEmHKsKg3Yv6HQG8Ytab6gxQMxktAEgid4YO3CqQj5Msuw2heWNxaFa6ttjTDSbCX8ysOnRC6hCTrHFiRnDEsfM5njCkuRWylJb3hgggQfaTCNaeCVFvJ/PKnZDyf3vtgnna7W6yoZpIcYHmtl7SSLCnvKdTufWrNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061585; c=relaxed/simple;
	bh=cVeMMjmVdPpfMOwQJFzI49QZ9xe7wMN1VOe7GAEhnHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaylNFDZiOH+O/0ZQuaAC+/kJYO9KvJKH3snF7eK0UvRhs9aDygJI+FizkxHgMuoIbphuh54CeEMUbfjt3oCYHwKApJaCfrdHf1lJMgM2mCYgKpWX8GeSSaS341u9nHlp5nD0T5khdqkpTNBgt1+e4wl35JHsV6bFTMdwKLEOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aict2+08; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b4bcb9638aso212721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758061582; x=1758666382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvSjwFL8UuYKuZG1WOg7NuAXvGpOFQScQAyDoq9s588=;
        b=aict2+08HOuO2gNNY2+tCTe3SGZLbTC5/bECaORng7mou5bsk23kVN+Tn/nsK2XkhX
         CSuyP4LIAM4/8Qp0/SoOZ9j4eIlFz8CTu/ju7CBdPWI3p5SikSC6cX9/tsM7fQvxfoh9
         gtPng+JX6DnSzXYO5a7ds2FosreYdsBMmqHU7Sh9OtsftF2uE26do3aS3yyF1+BpYY5g
         v/Lkn7GtD+HhfC3ucRjxu1QB74TXM4sUiHDIwjJO09OEgK0hfACvBNPmVV5gwd50plwg
         N0GVNFfTpPQf6CDdtvGyRr27BtJy309tmWfgFosSmhQF9bUJ+4XmOrX/APpBWwMcJJ0b
         uePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061582; x=1758666382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvSjwFL8UuYKuZG1WOg7NuAXvGpOFQScQAyDoq9s588=;
        b=O9rNK+QVgHVR4aJ3Pwiz2u8cl27Z5HDlc5JjbZljU6BzDSWVgvTiaZuTZ0N0IEnNNt
         pxtK/i/4DKJxya5wIhijR3dMVH+k3AUbRNjQOLlElazBRQ+ASnXAmznbxhtKClyblthl
         uGO0utZ9Fwh6+DqRt+ms4eSDnLAMVRA47Nno+Xx4cMBx6HZmoCIQfKkF8wGv+58P9J6/
         3NWSKTxVyQFiiUydJs63AZLRRGbRVnKXXVeR5U0rEv5KqQa4IEXq9elv7hUks3tNVjef
         mvqj0izRjHoov3N5BIKpb00vFx6arzRJFXqqFyRlpfGmjewRUT16lIb9H6GCw17v4M6X
         Aspg==
X-Forwarded-Encrypted: i=1; AJvYcCW/nxXWGoKAsrkVtirTyEDNGXrBPKTN8lLquwox9IU9L4QIeLdnoizp6qBDO78knTSfr5K4BB2iIXEmhTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLFHdkULW0q+Sxx42sYoHZPYtHTPfUYElRDk4U9YzR/EtnSfC
	FtaMBZj5SCMxh+NY9UZdGGYrJqTcw9O0zk2e2Yg7/GKhUZzfIrhZCMN4rChSS9oYnBHPkySxoVZ
	7HyBE1duCeATk4NsQgSgjeYVD0nEIFmHQ2+SeES1xCP3cz2io5iw93FlVmos=
X-Gm-Gg: ASbGncva2VrxI56Tk8GY0OvqQdDEfCwm6V6ZAqSNaPXjtSB2Og0Q3A5gjQLyTC6vCP5
	c3L1bZLUSlsXP52CKn5jUXgvUia50zRcHCMFcCB45/s+KivRHMGKckJWOTb/uKt4E5DfShvdPQX
	WPL04TF4FVlPO6scftcfsMSBsV1f+1p9o9g3kQk7POkAitmkE6l235UmiKSfhoe0dj0TVgiMSbx
	0MeJnKFDQod28yltfe66+tb5hL+RBLIfxROAvtRsHjttRW7pHfM
X-Google-Smtp-Source: AGHT+IFZ5jUYQu6B8QCw74ApfQyzcnqjHFyeE6dxECfr9tGK65ubPC2uIrlJX9wgihBhc3eo1SpLLjs5WriW+JmFBNM=
X-Received: by 2002:a05:622a:1652:b0:4b3:1d1:fddd with SMTP id
 d75a77b69052e-4b9de80cacfmr1899361cf.18.1758061581913; Tue, 16 Sep 2025
 15:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com>
 <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com> <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
 <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com>
In-Reply-To: <e5e3d96a-d0aa-4466-8303-5a7e8f96bbe5@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 22:26:10 +0000
X-Gm-Features: AS18NWAHK6b7mJpKB5w6xp3zfsHo4ykhOEb2aPzZQjR1oXKBScQCFYr1qTsDmd4
Message-ID: <CAJuCfpEULVxMixDjrk_xg7+3+97dkcMmkDd++BaR17X4tDSs6Q@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 9:52=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 16/09/2025 22:46, Suren Baghdasaryan wrote:
> > On Tue, Sep 16, 2025 at 2:11=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
> >>> On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> >>>>
> >>>> On 9/16/25 01:02, Suren Baghdasaryan wrote:
> >>>>> While rare, memory allocation profiling can contain inaccurate coun=
ters
> >>>>> if slab object extension vector allocation fails. That allocation m=
ight
> >>>>> succeed later but prior to that, slab allocations that would have u=
sed
> >>>>> that object extension vector will not be accounted for. To indicate
> >>>>> incorrect counters, "accurate:no" marker is appended to the call si=
te
> >>>>> line in the /proc/allocinfo output.
> >>>>> Bump up /proc/allocinfo version to reflect the change in the file f=
ormat
> >>>>> and update documentation.
> >>>>>
> >>>>> Example output with invalid counters:
> >>>>> allocinfo - version: 2.0
> >>>>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_se=
tup_data_nodes
> >>>>>            0        0 arch/x86/kernel/alternative.c:2090 func:alter=
natives_smp_module_add
> >>>>>            0        0 arch/x86/kernel/alternative.c:127 func:__its_=
alloc accurate:no
> >>>>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstater=
egs_set
> >>>>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstat=
e_realloc
> >>>>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arc=
h_enable_hybrid_capacity_scale
> >>>>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 f=
unc:init_amd_l3_attrs
> >>>>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_=
device_create accurate:no
> >>>>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mc=
e_gen_pool_create
> >>>>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_t=
hreshold_create_device
> >>>>>
> >>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
> >>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>>
> >>>> With this format you could instead print the accumulated size of all=
ocations
> >>>> that could not allocate their objext (for the given tag). It should =
be then
> >>>> an upper bound of the actual error, because obviously we cannot reco=
gnize
> >>>> moments where these allocations are freed - so we don't know for whi=
ch tag
> >>>> to decrement. Maybe it could be more useful output than the yes/no
> >>>> information, although of course require more storage in struct codet=
ag, so I
> >>>> don't know if it's worth it.
> >>>
> >>> Yeah, I'm reluctant to add more fields to the codetag and increase th=
e
> >>> overhead until we have a usecases. If that happens and with the new
> >>> format we can add something like error_size:<value> to indicate the
> >>> amount of the error.
> >>>
> >>>>
> >>>> Maybe a global counter of sum size for all these missed objexts coul=
d be
> >>>> also maintained, and that wouldn't be an upper bound but an actual c=
urrent
> >>>> error, that is if we can precisely determine that when freeing an ob=
ject, we
> >>>> don't have a tag to decrement because objext allocation had failed o=
n it and
> >>>> thus that allocation had incremented this global error counter and i=
t's
> >>>> correct to decrement it.
> >>>
> >>> That's a good idea and should be doable without too much overhead. Th=
anks!
> >>> For the UAPI... I think for this case IOCTL would work and the use
> >>> scenario would be that the user sees the "accurate:no" mark and issue=
s
> >>> ioctl command to retrieve this global counter value.
> >>> Usama, since you initiated this feature request, do you think such a
> >>> counter would be useful?
> >>>
> >>
> >>
> >> hmm, I really dont like suggesting changing /proc/allocinfo as it will=
 break parsers,
> >> but it might be better to put it there?
> >> If the value is in the file, I imagine people will be more prone to lo=
oking at it?
> >> I am not completely sure if everyone will do an ioctl to try and find =
this out?
> >> Especially if you just have infra that is just automatically collectin=
g info from
> >> this file.
> >
> > The current file reports per-codetag data and not global counters. We
> > could report it somewhere in the header but the first question to
> > answer is: would this be really useful (not in a way of  "nice to
> > have" but for a concrete usecase)? If not then I would suggest keeping
> > things simple until there is a need for it.
> >
>
> I think its a nice to have. I can't think of a concrete usecase at presen=
t.
>
> I guess a potential usecase is if you are trying to use memory allocation
> profiling to debug OOMs and the missed objects size is very large. I gues=
s we
> wont know until this happens, but I would hope this number is usually sma=
ll.

Hmm. Missing a large allocation and not knowing about it can be a problem..=
.
I'll start sketching a patch to see if tracking such a global counter
has any drawbacks and in the meantime I'm open to suggestions on how
to expose it to the userspace.

About concerns on the IOCTL interface, would it be more usable if we
get the alloctop [1] or a similar tool which can be used to easily
issue such commands into kernel/tools?

[1] https://android-review.git.corp.google.com/c/platform/system/memory/lib=
meminfo/+/3431860

>

