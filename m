Return-Path: <linux-kernel+bounces-745908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC2B12055
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AFF3ABAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEE273816;
	Fri, 25 Jul 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1bMarjO"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95F2BDC33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454711; cv=none; b=ddtSR0vrLfC2i4DCGnDq+nytoUVEtugvf8AtCGuEV7hhcmHf6iFgcCkNqHq2mdcliqnvWaAXD4Ob8zaIHGJUhJzCodQkpjcHPSDT2X5PGjzZDXRpuVyoAYVmhK0btXLeDhSymz6ixuePa3IWUMIW9BblD2ccbgbO0qm8AHI1CqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454711; c=relaxed/simple;
	bh=GYKBpq9FRQ18jqHqTPjo8RGL3Z7flutdQDL/XiPX4Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te+W+USk+kiPHuA7EwPSBTEQfQQxZJLTPHHkWGFjkBuaC5Q1HjFTYJQLzQ5y8Y/5GRiTylzbdh8neRX4j0Sjkd4QghqEpHQ3tKwlkxtBfCvdze7cW1mBHxpuTZCpoy4Wkfag9/NId1k2rCf92slPMemkU+/77cUJbseb3goqPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1bMarjO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so8789a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753454707; x=1754059507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIq14dJIVdG8Em0IZoGynxSIJDeMyZzA0yiBWzPg6Xc=;
        b=i1bMarjOD2nPzSlQlGmd5UlgjCj5p6rq5vLtU5o3stYuELtCZUBAJF2TWvUzCeSBQz
         1pUsquFs/Qp7j3+u6ZVKCU5K7udOSTRkFnKaJoI+vcq6X4dDdY3JAOD7JXjefR4uJ7oz
         +m1YykRENzwyLx4uzt9Bitb6laEjaW5nlYebV1/2LlFDrW1bv4QHA20VUpG/Z4WZGhrA
         2qlAoGo/E26NZtQoGlYkq+VzrjrCGucgJwgArQrO0YfWHoAEp49rEViB4aU0gZrDplII
         9e83UCBMvkyAd+x/IwqVnG590tmlQ3XGWQHUiMA7OgGxpIf9FZzzf+0YlWm9y95dwZEs
         I+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753454707; x=1754059507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIq14dJIVdG8Em0IZoGynxSIJDeMyZzA0yiBWzPg6Xc=;
        b=avxo4vvL+OZaYGvcaBUx5HNxaTL0wAUUKjmWmXtF99kaygUibw9pkXxu2Y494HuJS+
         +4P/GMM4dtPlgwxr9rH4BL5TcT3OABSEDqaNZh9EvmZwta08Sbug1p6LbgXXBE/qgwpN
         335ZyIfonVFphUDxVxPYi/nNxub5NF8hnujbDJ33OddvuUcw1qUn5d25fec+5XQblr+j
         oRy0r3EPKg6NU3UpW1D+VpotuHc9tuAlb8hejhh9DnVLN8M5SCCDnv45/WcBH+cwD4ew
         OrYtOXCfkJf0Cyo/7E7f/kt60O5hjZnCMHNqZD1TFsqXxqfCs0z3I+J92RwpqN+fQbW5
         n+iA==
X-Forwarded-Encrypted: i=1; AJvYcCVPvTXPW53Eq6TJD2dfngnJzFZrTEakxC06EIEuIu8m01/QfTxCLcU0MXoFJRJr2UmM9P6znfGj/dQVQ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT013Ib6B9ChmttNoglpKdVZkgW8SgyanpsLpfHYTgkmJ62uT/
	n9TDuj0CU/R4M/L3Ai4F+BcoahIvnfaxCmBxgEARTRcX94We0wS6RCuu1Fs0IzCEW8ZObeQZFzM
	RD4ywivmzdzPob5XCNG1mK2Lp19thdyzolBPN8N3h
X-Gm-Gg: ASbGncsw1gUTXhsfp2/y1YJOXB0kg5tb5wywNdM0dvKomfFh2fHMZ21h6nEzjGmOihj
	ExFp8D0pcVSVd16kAYoonISrQsVA0zAcDT826pmq56u4pVpx5H5s3vRjimXpcrtq0CEQGuj8PPd
	IlM67keuSVpVyoswkQOqrz6yGUTSGKrliCAJgAlxeYHyn3Huz17Y6CopCG5PHLTm7p5cI7f2Fqc
	7Dmz9cAHVKHkanTbq4CdSv3lA81F/H7UbI=
X-Google-Smtp-Source: AGHT+IEYQbZPuNP3paaUxn8jeMegpNMd+Dg193eNXtPsbU/sYQfNMnRC6dvCdmFyXtMH+mXp7L5rpb7LbQrPR5ksMss=
X-Received: by 2002:a05:6402:1d89:b0:612:ce4f:39c with SMTP id
 4fb4d7f45d1cf-614e6e4cfd3mr86568a12.0.1753454707041; Fri, 25 Jul 2025
 07:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com> <1d849190-214e-413e-a082-d7f862b653cc@suse.cz>
In-Reply-To: <1d849190-214e-413e-a082-d7f862b653cc@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 16:44:31 +0200
X-Gm-Features: Ac12FXyb-HgzDpS3DcrqFBWx_FgxxiAo_cGOTd9j55tu-ioQwhxjh8xLSbmTJD4
Message-ID: <CAG48ez23CPO-m6kPaEs8kLUfRVCN+QMbsEn7BocfaJuq=gRwaA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:11=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/25/25 14:16, Jann Horn wrote:
> > If an anon folio is mapped into userspace, its anon_vma must be alive,
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
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folio=
s to
> > hopefully catch such issues more reliably.
> >
> > [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.=
com
> > [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.c=
om
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Changes in v2:
> > - applied akpm's fixup (use FOLIO_MAPPING_ANON, ...)
> > - remove CONFIG_DEBUG_VM check and use folio_test_* helpers (David)
> > - more verbose comment (Lorenzo)
> > - replaced "page" mentions with "folio" in commit message
> > - Link to v1: https://lore.kernel.org/r/20250724-anonvma-uaf-debug-v1-1=
-29989ddc4e2a@google.com
> > ---
> >  include/linux/rmap.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 20803fcb49a7..6cd020eea37a 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -449,6 +449,28 @@ static inline void __folio_rmap_sanity_checks(cons=
t struct folio *folio,
> >       default:
> >               VM_WARN_ON_ONCE(true);
> >       }
> > +
> > +     /*
> > +      * Anon folios must have an associated live anon_vma as long as t=
hey're
> > +      * mapped into userspace.
> > +      * Note that the atomic_read() mainly does two things:
> > +      *
> > +      * 1. In KASAN builds with CONFIG_SLUB_RCU_DEBUG, it causes KASAN=
 to
> > +      *    check that the associated anon_vma has not yet been freed (=
subject
>
> I think more precisely it checks that the slab folio hosting the anon_vma
> could not have been yet freed, IIUC? If the anon_vma itself has been free=
d
> then this will not trigger.

The point of CONFIG_SLUB_RCU_DEBUG, which I'm talking about here, is
that it allows KASAN to catch UAF once the anon_vma has been freed and
an RCU grace period has passed; it is not necessary that the slab
folio has been freed.

You can see that working in the linked syzkaller reports - KASAN
tracked the object as freed after slab_free_after_rcu_debug(), which
is an RCU callback scheduled from kmem_cache_free().

> > +      *    to KASAN's usual limitations). This check will pass if the
> > +      *    anon_vma's refcount has already dropped to 0 but an RCU gra=
ce
> > +      *    period hasn't passed since then.
>
> AFAIU this says it more accurately and matches my interpretation above?
>
> > +      * 2. If the anon_vma has not yet been freed, it checks that the
> > +      *    anon_vma still has a nonzero refcount (as opposed to being =
in the
> > +      *    middle of an RCU delay for getting freed).
>
> Again the RCU delay would apply to the slab page, unless you talk about t=
he
> CONFIG_SLUB_RCU_DEBUG specific path (IIRC).

Yes, right, the "RCU delay" in the second bullet point refers to
CONFIG_SLUB_RCU_DEBUG.

Here I'm saying "If the anon_vma has not yet been freed" because
that's the only case in which I can reliably say what will happen, and
this is the main case that isn't already covered by the first bullet
point in a CONFIG_SLUB_RCU_DEBUG build.

> That said, I wonder if here in __folio_rmap_sanity_checks() we are even i=
n a
> situation where we rely on SLAB_TYPESAFE_BY_RCU in order to not touch
> something that's not anon_vma anymore? I think we expect it to exist?

Yes, we expect it to exist. That's why I'm not just asserting that the
anon_vma is still considered live by KASAN, but also that its refcount
is non-zero.

> Can we
> thus invent a CONFIG_SLUB_RCU_DEBUG-specific assert that assert the anon_=
vma
> itself has not been freed yet (i.e. even if within a grace period?).

That is essentially what I'm doing - checking that the count is
nonzero verifies that it's not within a grace period, and the implicit
KASAN check verifies it can't be in a KASAN quarantine after the grace
period is over.

> I was wondering what actually does rely on SLAB_TYPESAFE_BY_RCU, thanks
> Lorenzo for pointing me to folio_get_anon_vma(). But that's only used
> elsewhere than here, no?

Yes; the point of this assertion is that folio_get_anon_vma() and
folio_lock_anon_vma_read() (which show up in the stack traces of the
two linked syzkaller reports) rely on the ->mapping not being
dangling; and they can happen in the background anytime as long as the
folio mapcount is elevated, but they only actually happen sporadically
(in particular under memory pressure, which syzkaller apparently
mostly triggers randomly and non-reproducibly). If we have bugs where
the ->mapping of a folio goes away while it still has an elevated
mapcount, then instead of randomly getting KASAN splats under memory
pressure, it would be nice to detect this reliably. So I figured a
nice place to check this is when we're decrementing the mapcount -
that should catch almost all cases, except ones where such a bug
happens because we somehow leaked both a mapcount and a refcount of a
folio.

> > +      */
> > +     if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
>
> So you verified this compiles out completely without DEBUG_VM?

No, after David's suggestion to remove the explicit CONFIG_DEBUG_VM
check, I looked at the definitions of these things to check that it's
all just plain reads and arithmetic, and removed the CONFIG_DEBUG_VM
check, but haven't actually compile-tested it.

