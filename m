Return-Path: <linux-kernel+bounces-745679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F127B11CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA4F3AF41B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062182E542F;
	Fri, 25 Jul 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7nZb2e0"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87514A4F9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441192; cv=none; b=TDYwIBCenx/r+W1LWQzga6QOFqeJWVdY/rSuZQU9zrzUA+nX6reQsJit9L+beST9CkIPFYOdoPeZVlnUnwJvuZt88xd74aa0fC9alIzvJJskKc79lGrfpLDLigupUOxOnKtRw+tyFhbSlL2y8yYw4zXVqeFjKvn9SMHdCBp7bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441192; c=relaxed/simple;
	bh=5usJCVzJncSDMi9Z3DDwFoEr4hvgPrhDulBMi04TA14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJ+3WUb+8tlcKnAGUDA94mKprjOUYgRvurJQw6LduSi8DMBJecWpMYnMKzDOZEc93MyIog3RYi2GoQ0TageSqga22FP4kN+a518WmDgE2IYc2JCPsCq+Nxm5ncFJMW2ZTSPn7lZkmj62nEcfkmBevfnU7AJyTx7seNiIlowfCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7nZb2e0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso7030a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753441189; x=1754045989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zMIKxIMeWA6Y0zyT/VEWNC40kHI/lEjExxPURm2a8w=;
        b=f7nZb2e0Bfy7qvd+qpUHfsYWalWCtT3VMxDw8YmFmLdXYVGMUmgKn8lJCk/qyjY/fM
         Pi6+xiBCqwKf675PoVAIplDtU0IX62GfS3AkiayKDOZI+nsjFJ66zwaxwstD1Qssm8G1
         bEoOd9GegiVxgC11kXs+9078v3IYqxDZx+HeKI+FSVD3c+eVEDi97Js4qhT5mRbYTx9H
         d9Zac0Vf+CzYVWrElhtCOo64AB2K99z3IB4F63NzboiXgX2talPOZXt60XRDS6s3w6le
         Vy7ak0n6ulHo6oFM1xKM81/vlRq633V9yPtD+GU5qa5/6tjuDpBijo9akrXAufa1x8Lb
         2xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441189; x=1754045989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zMIKxIMeWA6Y0zyT/VEWNC40kHI/lEjExxPURm2a8w=;
        b=xQM5yYboM5scz3mFNTMEQz2s9xNZa1UXPY0NyJd7sGEs630q9zeY+E4ueoMP6ypdWi
         2fopFqDDA9LsR2yaDoxbbkFFbm0GLwqJUBnMi80mvIhyLWzmxnoCarZm3+6Zj0mQDroC
         l3ZCsFCPGDtiovkE1rhgTJlqqSxSZIxwR2dkrX//93VdsG2B/Z+fGVaT4RtBCMzD/ySP
         DyuomQ0p9Cy+eQXlkTMhzTpdjz6nHqC4gtAXI8XDCUz+0OCtg5bGjU1CvD8WPzY+EqEx
         kxSQgFmtP5rKrDmKUVSYxDYn/OYAhyDnNKUNhZdQ0i2MB699FB2bXAQ8R2EnEpH07VUY
         9mOg==
X-Forwarded-Encrypted: i=1; AJvYcCUzndxVJTDO8bBxvGZixS7PaYSS4WY3Y5CUjxN7zT4/z3IubfimhQsjkVax8QnTQFq8VYssNJRTuphaeRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYX2fZgfgI/nmfi0D3IvcotM9ke/erxVFOOHA47AW5Wj81mPE/
	5Rz9KmVqDkUBntK8uD0ob2vtjIpJnLQfbXZb4i8ds9tgFIMTbMwYlT79/bQrvyHs5qD6SZ6awDk
	YYrsfHmBuWHsAPItZ0Q9agngSF99aUXfZzu58P2Dh
X-Gm-Gg: ASbGncusNqbgBIVZJDNfcWn6an/FcuicuVqevQpdlAMGzbuSIKGg6zkwvjj2PtF3hM8
	DBTtzkdJJRIfJ/hGkKb9hlQyouYWEKewYFkGP0U/+dOcvXBND+lgTefkujj/AOFSEASza9ftuKd
	oFZ6e+TGtYNpwoZt6tRYO5gBSBEgwLHjH1Rf/3Y2dg3aG1VmoOx3oy6DGaMMINtzbSpRkBKkIU7
	1+kFOW0mWPyzxC1IQbhumkn/iAo3gukjOA=
X-Google-Smtp-Source: AGHT+IHnqQxYja1POX2W+kA/E0n2jk+M6mImxM6eux/jmZA5LUQePcIkwPQUBgG33sEbBErZ0nUIrhQvUBFLjnx7mxU=
X-Received: by 2002:a05:6402:42c3:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-614e7af1571mr97978a12.4.1753441188512; Fri, 25 Jul 2025
 03:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com> <20250724145202.7f48386e9bd6fc8e114c3436@linux-foundation.org>
In-Reply-To: <20250724145202.7f48386e9bd6fc8e114c3436@linux-foundation.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 12:59:11 +0200
X-Gm-Features: Ac12FXwXJZU2HaMIy-bMzONk-qt6j5Vfpoiy2m2ctrYhU5gV6LCZ70luYNXP4Xo
Message-ID: <CAG48ez1A7ugLHxeBeBxqH6g37fb4iQo4g-O5F519v3rQQGWWYw@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:52=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 24 Jul 2025 21:13:50 +0200 Jann Horn <jannh@google.com> wrote:
>
> > If an anon page is mapped into userspace, its anon_vma must be alive,
> > otherwise rmap walks can hit UAF.
> >
> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> > walks that seems to indicate that there can be pages with elevated mapc=
ount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressu=
re
> > randomly caused reclaim to rmap-walk the affected pages, so it of cours=
e
> > didn't manage to create a reproducer.
> >
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages=
 to
> > hopefully catch such issues more reliably.
> >
> > Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> > unlike the checks above, this one would otherwise be hard to write such
> > that it completely compiles away in non-debug builds by itself, without
> > looking extremely ugly.
> >
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
> > +     }
> >  }
>
> PAGE_MAPPING_ANON is now FOLIO_MAPPING_ANON.

Bleh, sorry about that, I keep forgetting to write MM patches against
the MM tree...

> The subtraction to clear a bitflag works, but my brain would prefer &=3D
> FOLIO_MAPPING_ANON.  Oh well.

(I'd prefer bitmasking too but the existing code does subtraction, so
I figured I should mirror that.)

