Return-Path: <linux-kernel+bounces-745759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9CB11E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE691C27790
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DB241668;
	Fri, 25 Jul 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD7vA23t"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92B2222D1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444859; cv=none; b=o1GuoH5Uee9sBP/shqgST/X1Egxuuls4/tyArjmxcFH9JDDXcikFdbSeohAunh2fSfNAFBFCGtf75iANtpTSw18Gc/ClquFEWH89YHaCHHCFjEwsrjhc0uCY0G+93EQ+Oj9tyma8ePzw/GTQG/hArLjOtM5Q8rWmDPKkSetIl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444859; c=relaxed/simple;
	bh=cMkKCUdz/PhAuPdWhvME7acv5CTS5FEuMjCNv2Vn8BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFvQ1t3fL3XRZWT3rrTu1pPD5GTm2IPC3qvjujtdivPew7lCNpSyIZrIUwRfr4eKXxGc2kM1vCLN0mqaVdJBHR9drysNRnggC1n6j7KmZFV5F1Z77OsXpFLMY7qGEOgvdOP8HK4rCRhVPbgGsU1HDHHhhAXRf76KNztXbzPQDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD7vA23t; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso9408a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753444856; x=1754049656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh4dBPnKL9asOrMaPO22NPX8F8r/EmmrhHR2PE4LS5U=;
        b=JD7vA23tHwdv+pJ0Y4XNI6p6Lty2sbiYgz9fulD17M9idIxOL2bKjrWHsNlK2v2+Mf
         8uyi7wsDgkaWqDVLhp3GB5EokseZWU1yUaC6gJSsCrDlsgcyx1xmNNF+UA3ghTVGdksk
         Xopi5PWzR9A7ECwkXjpqlOSp9MWi+IyADWS+6qep9Cfdvx/w7/b0V/2b/20smT5/V563
         DjfQxzeTbpiKMEdwNCdMIW9tkfj+djEysXXS/S2VHh5SNYuD69IzmRlvSFwTspisoJOw
         Gj/R5mWvDPhorM2XdhdzeIwUkINzrtLzmmWFxj/HRg2CIDWQ99tCR6fSB60HCLf/VUyb
         GqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444856; x=1754049656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh4dBPnKL9asOrMaPO22NPX8F8r/EmmrhHR2PE4LS5U=;
        b=RzdrJMjvW7wMAkeJ1Ens/WA+T5hEqm9ql+7bzkTZKHqeip70C9wP0QkjTFCeMzcJ1f
         jWO0e0sg6W4Ex5YsCA6+VYT3Rppj4kxMBijlbkEKEmY3U+DOWZCPaLoz1DEsp8at5b3r
         J+438jrNodlBS/ccIKbTrHVY386TG/nMyDxbzXJNM4AdcfrAGrpo1lYqrk2PsrTEPBkC
         wYicHQABGB57PkNtKPRdlNKfcvDZZb+XNeE77h1Ag6CO76MKmdZEKX7rsjHSZ7utVGKE
         Bu22sr95WQEjvf7rWE8/8ZA+WRBbISwUxA2Y7q9xSMxxBwGC+d03EqNJZ4t7IUSZoAMe
         nyOw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjha8hy0cRFKMU9p6f3oMwMpN3/APsH+AUk2pEdEcKzp+qNsQiMFyFLHsosp+0Rt8hOsSA0NGMcg+Jfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySnAMJGRTXeQs5dHb1QCWHn2MLC4r/GiI63Kskrm13N5iYujn
	u5kmWyLvcCHpCuGVFozlyDAbuEiHEsTdXHEUSDipnsopbySl/0RenP2OpBEHj4SuBLcgZiFyR/8
	Fn528y0lVgwiYq0XvB8ofmBvPfK/ic9CeuIHV5QXm
X-Gm-Gg: ASbGncuzTyAqHS+10kDcLFALQSC/xP5BZdGVwVEc6hORr+hImhHAB+wp07rCDpZ23Mz
	ixg0gvi6rPIcL75ZgIpmdtfkymqNh7JmnrRJtUzbtyyRLUy+Jv21Xj2kgdnGRbpuaoHcD69P6Jz
	riSKuVWN331MQ/lM0BMTUE92OQHi0C9/ikioNplNzQlNfX5PlM03OdvX5TGoO2OP1YWuOUvpk7y
	vAvM65LXq2ivdtcRWC0Ulcw7jTRPuQncZo=
X-Google-Smtp-Source: AGHT+IHSG6B8cp0/LEbloQrjETaNDXkra5YuBdrTSkhuuJTSqsINYcZjJHSwLDJBaVZSNG1/gP4CfJsXaIEu54thnsA=
X-Received: by 2002:a05:6402:2921:b0:607:41dd:5fe7 with SMTP id
 4fb4d7f45d1cf-614ea6cc834mr57442a12.1.1753444855735; Fri, 25 Jul 2025
 05:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com> <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
In-Reply-To: <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 14:00:18 +0200
X-Gm-Features: Ac12FXw7jMvLf5hIHnVYApdEf2yr5qrJO0NwRf-N9VozIjLNzSouJwtx8U7nM-M
Message-ID: <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:32=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jul 24, 2025 at 09:13:50PM +0200, Jann Horn wrote:
> > If an anon page is mapped into userspace, its anon_vma must be alive,
> > otherwise rmap walks can hit UAF.
>
> This is extremely weird. I guess it's a UAF of vma->anon_vma
>
> Because we:
>
> put_anon_vma()
> ->__put_anon_vma()
> ->anon_vma_free() (also the root anon_vma... interestingly!)

FWIW, the thing we're trying to access can't be the root anon_vma,
since KASAN says the UAF'd object was allocated from anon_vma_fork.

> But none of this obviously updates the vma to set vma->anon_vma to NULL.
>
> So yeah god almighty. To get this, we must be dereffing vma->anon_vma
> somewhere unexpected.

I don't see how vma->anon_vma is directly relevant. I think the
relevant things are:

An anon_vma is only kept alive as long as at least one associated VMA
is still alive.
An anon folio may outlive the VMAs it comes from, so it may also
outlive its associated anon_vma.
When an anon_vma goes away, it does not clear the ->mapping of
associated folios (this is an intentional design choice).
When an rmap traversal wants to go from a folio to the associated
anon_vma, it (under RCU) checks that the mapcount is non-zero, which
implies that there must still be associated VMAs, which implies that
the associated anon_vma must still be alive; and then it dereferences
the ->mapping.

I think the ASAN splat indicates that syzkaller must fairly often get
into situations where the ->mapping pointer is dangling despite the
mapcount being non-zero, but syzkaller likely only actually hits the
UAF when the kernel gets memory pressure by chance and does rmap walks
on the reclaim path.

So there are several invariants we're relying on here, and breaking
any one of these could allow an rmap traversal to cause UAF; a
non-exhaustive list:

1. An anon folio is only mapped into VMAs that are associated with the
folio's anon_vma.
2. Removing an anon folio mapping reduces the anon folio's mapcount
before the VMA can go away.
3. VMA splitting/merging/forking properly preserves the anon_vma associatio=
n.
4. If the anon-exclusive bit is set, the folio is only mapped in a
single place (otherwise swapout+swapin could erroneously set
RMAP_EXCLUSIVE, causing the swapped-in folio to be associated with the
wrong anon_vma).
5. When a VMA is associated with an anon_vma, it is always also
associated with the corresponding root anon_vma (necessary because
non-RMAP_EXCLUSIVE swapin falls back to associating the folio with the
root anon_vma).
6. If two VMAs in the same process have the same ->anon_vma, their
anonvma chains must be the same (otherwise VMA merging can break
stuff).

> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
>
> Will try to take a look when I get a chance.
>
> > walks that seems to indicate that there can be pages with elevated mapc=
ount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressu=
re
> > randomly caused reclaim to rmap-walk the affected pages, so it of cours=
e
> > didn't manage to create a reproducer.
>
> Fun.
>
> Please hook me in (I mean you're going to anyway right :P) on this stuff,
> as I'm looking to rework the anon_vma stuff so am naturally interested in
> any and all rmap anon stuff.
>
> For my sins ;)
>
> Maybe I"ll dig into these syzkallers.
>
> >
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages=
 to
> > hopefully catch such issues more reliably.
>
> Good idea.
>
> >
> > Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> > unlike the checks above, this one would otherwise be hard to write such
> > that it completely compiles away in non-debug builds by itself, without
> > looking extremely ugly.
>
> David already addressed.
>
> >
> > [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.=
com
> > [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.c=
om
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Nit below, and pending David's requests, but LGTM so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

> > ---
> >  include/linux/rmap.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index c4f4903b1088..ba694c436f59 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(cons=
t struct folio *folio,
> >       default:
> >               VM_WARN_ON_ONCE(true);
> >       }
> > +
> > +     /*
> > +      * Anon folios must have an associated live anon_vma as long as t=
hey're
> > +      * mapped into userspace.
> > +      * Part of the purpose of the atomic_read() is to make KASAN chec=
k that
> > +      * the anon_vma is still alive.
> > +      */
> > +     if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
> > +             unsigned long mapping =3D (unsigned long)folio->mapping;
> > +             struct anon_vma *anon_vma =3D (void *)(mapping - PAGE_MAP=
PING_ANON);
> > +
> > +             VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) =3D=3D =
0, folio);
>
> Maybe stupid question, but wouldn't we pick this up with KASAN? Or would =
we
> pick it up far too late I guess?

I mean, it depends on the exact nature of the issue. If the issue is
that we somehow end up with anon folios mapped into VMAs that are not
associated with the anon folio's anon_vma, then I think the only time
we'd notice would be if we randomly end up doing rmap walks of the
folios, as syzkaller did above.

> We're sort of relying on this
>
> a. being a UAF
>
> b. the thing we're UAF-ing not either corrupting this field or (if that
>     memory is actually reused as an anon_vma - I'm not familiar with slab
>     caches - so maybe it's quite likely - getting its refcount incremente=
d.

KASAN sees the memory read I'm doing with this atomic_read(), so in
KASAN builds, if this is a UAF, it should trigger a KASAN splat
(modulo KASAN limitations around when UAF can be detected). Basically,
in KASAN builds, the actual explicit check I'm doing here is only
relevant if the object has not yet been freed. That's why I wrote the
comment "Part of the purpose of the atomic_read() is to make KASAN
check that the anon_vma is still alive.".

> Which is fine - because hey this is the only way we can get a hint that
> this is happening, but I think we should describe what we're doing.

Sure, I can make the comment more verbose.

