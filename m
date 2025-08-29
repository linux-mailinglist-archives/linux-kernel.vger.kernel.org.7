Return-Path: <linux-kernel+bounces-790901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFBB3AF08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B0F6836E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5CF13D512;
	Fri, 29 Aug 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7leSx88"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBA74059
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427052; cv=none; b=a0d3W3wiOnmVa2OY9AvfR4EWPyshEtg8Yhk1WOdwuqcBLiKFBh7e/dPQ8bJHG3EaRs9lCcZqWHibrxMdYfW7OZwvUqX908AX06Ohkx1ajJlxgeepntWp3jCjkcv+e6K4hsZqQgrmtXynIF4BYUbPhYv7j1dwXStG53UGneccVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427052; c=relaxed/simple;
	bh=l9aJ5vAy0cIDAse2r2+5caJoNFmnG3nzBYGw9ufbcv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXwLyHV0EkqTf9RaymiG8ASecMLe5/A0+lV4FgAaF4cfuNkP9R6u9CrwjEeWnKK/LqoCMjVp8DI++KRlH2dVuY1enmihm9jQlvYp0ujWAc1PzgahWQaHvDaPOR+Sgq5jCYtw2Gx2IuhfJ9/dEuZFLaqoYG2gp/mks+7pWE/7A/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7leSx88; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso4931a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756427049; x=1757031849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb0y9vtGTZ+dzUMPugM8yqfICr2GysN5pwXfEC/sNhA=;
        b=Z7leSx88RX8RzM8I4ACeu1/NydR3KAIP0AFGFmjZH42ZiwfxNCYeYB8gDASPYQvSAF
         phxyRAom+El4mcWH9jep4VoesDUh771wcfo+UBizRnLmycl87/uQJpTemwITPAlkNeNh
         b/zfjifyvwrQXBGYnKJeTpt6sLEbqUr6k/qv2DDP2+qoQdwcFiP46MzVLEsqCFY9iOSr
         DOMLPx0ReCOLkQWsZu2G6rv/JtmzE+q9HDWCkdmWWRf+Gf+yFG/6dqOUMAO5y26uanAQ
         h/0zhfQqlq1wPzzv6EQrK7VG0C0b+iluo/fOleZ0aM2c9uhsvyobHW5Gt/PS9ht7B4u1
         xdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427049; x=1757031849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb0y9vtGTZ+dzUMPugM8yqfICr2GysN5pwXfEC/sNhA=;
        b=pnkFd743aQXiB+DMpmo2xXIoUdEC1LeDIihZsj8RLN0asUTgC3l86PdWbAR5V5ozqC
         e3ukaMnbM0V/lhGsIqVWu6Bg52d+/VSgv1/tK07NY1mQV3R7aMEzccxoA5C79eXe6SDh
         Yz3Xjup1aug7tOcu/RTpyWS0RD/0bz+0q2T93KAhkTwLl4QN5yM0p8jfdClpMoNtw5rS
         Kz3rNoR9smJI7noVSxBgkmfPvjlSb0iD8sPEVMgSEq/nM46TOE5hPqvXicrKHXw3KhNv
         KF2evP4kirMzcSOE5+y7GjRrxqaHZ1DEifaW+5J4GJNDjADTKI2X65N9uIgHBEtLwnGf
         OXMg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDDMiN5Ltr23De0BwSDqVI0/CJUI2i6Ryy+iinAGUEbo9xWrkTkPVdgGkRi29ko/51Ub+5OwgBTWXHpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJkrGVe3Dqbtp0JwmuTxOXYAWStlXMl6seeyeDMpGNT1GTZxd
	6Sdc4wK5PR9+VKmXEnlJDkdye3tQwEbQ5hIrnmxjqwnkGa7pewSKYeiGXRLiyRQrKBi4HDeSn5u
	KIkwdvSAfhgxuHMbFcrleOlbjSHaZUTcXn2UjD6Er
X-Gm-Gg: ASbGncsvA+xh0BcrqwRwHo3aGyfqra5IYfPi0LKgOUSpwlne/hRqWS0tywjwyZiT7/c
	Cwjqs8HOKLT9fQvA4tUdRa9H8qEOMfpU6nKfDogJ9fL8mfx//UVncyQtBqKTs+4hlO6sVyB2oqd
	MACiiagLh447Bsmpb17Co2myCsaluFKz2wP81wqSdLCPlfLkrUasIAeJ69LfY26nOPREzWOBNSX
	virDMoCRIl0qq0ipDDJBejzwJzx+Me8FSX+6h8QNLRy0HA=
X-Google-Smtp-Source: AGHT+IGHd9I0AQLS1rXEfAJmvOR/gyxXdVZywIfUPo//u1+kPAq9z38CCUP9OBMIAZG26vl3BjzMxE43SXhsiruLtFE=
X-Received: by 2002:a05:6402:2398:b0:61c:32fb:999b with SMTP id
 4fb4d7f45d1cf-61c91d000e6mr569462a12.1.1756427048570; Thu, 28 Aug 2025
 17:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com> <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
In-Reply-To: <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 28 Aug 2025 17:23:56 -0700
X-Gm-Features: Ac12FXxW3K_Bg6VMteJaxri8c5NDc0ZgxIw1US5qRGGnGagV8jf0XXZ2DNebdpc
Message-ID: <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Aug 25, 2025 at 05:19:05PM +0200, David Hildenbrand wrote:
> > On 22.08.25 19:29, Lokesh Gidra wrote:
> > > Hi all,
> > >
> > > Currently, some callers of rmap_walk() conditionally avoid try-lockin=
g
> > > non-ksm anon folios. This necessitates serialization through anon_vma
> > > write-lock elsewhere when folio->mapping and/or folio->index (fields
> > > involved in rmap_walk()) are to be updated. This hurts scalability du=
e
> > > to coarse granularity of the lock. For instance, when multiple thread=
s
> > > invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distin=
ct pages
> > > from the same src VMA, they all contend for the corresponding
> > > anon_vma=E2=80=99s lock. Field traces for arm64 android devices revea=
l over
> > > 30ms of uninterruptible sleep in the main UI thread, leading to janky
> > > user interactions.
> > >
> > > Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> > > folio_referenced() is the most critical (others are
> > > page_idle_clear_pte_refs(), damon_folio_young(), and
> > > damon_folio_mkold()). The relevant code in folio_referenced() is:
> > >
> > > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)))=
 {
> > >          we_locked =3D folio_trylock(folio);
> > >          if (!we_locked)
> > >                  return 1;
> > > }
> > >
> > > It=E2=80=99s unclear why locking anon_vma exclusively (when updating
> > > folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> > > with folio locked. It=E2=80=99s in the reclaim path, so should not be=
 a
> > > critical path that necessitates some special treatment, unless I=E2=
=80=99m
> > > missing something.
> > >
> > > Therefore, I propose simplifying the locking mechanism by ensuring th=
e
> > > folio is locked before calling rmap_walk().
> >
> > Essentially, what you mean is roughly:
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 34333ae3bd80f..0800e73c0796e 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1005,7 +1005,7 @@ int folio_referenced(struct folio *folio, int is_=
locked,
> >         if (!folio_raw_mapping(folio))
> >                 return 0;
> > -       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(fo=
lio))) {
> > +       if (!is_locked) {
> >                 we_locked =3D folio_trylock(folio);
> >                 if (!we_locked)
> >                         return 1;
> >
> >
> > The downside of that change is that ordinary (!ksm) folios will observe=
 being locked
>
> Well anon folios, I guess this is what you meant :)
>
> > when we are actually only trying to asses if they were referenced.
> >
> > Does it matter?
>
> Also another downside is we try lock and abort if we fail, so we've made =
this
> conditional on that.
>
> But surely this is going to impact reclaim performance esp. under heavy m=
emory
> pressure? It is at least a trylock.
>
> It's dangerous waters, and I'd really want some detailed data + analysis =
to
> prove the point here, I don't think theorising about it is enough.
>
> >
> > I can only speculate that it might have been very relevant before
> > 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_=
anon_exclusive").
> >
> > Essentially any R/O fault would have resulted in us copying the page, s=
imply because
> > there is concurrent folio_referenced() happening.
>
> Fun.
>
> Thing is we now have to consider _every case_ where a contention might ca=
use an
> issue.
>
> One thing I _was_ concerned about was:
>
> - uffd move locks folios
> - now folio_referenced() 'fails' returning 1
>
> But case 2 is only in shrink_active_list() which uses this as a boolean..=
.
>
> OK so maybe fine for this one.

For shrink_active_list() it seems like doesn't matter what
folio_referenced() returns unless it's an executable file-backed
folio.
>
> I really do also hate that any future callers are going to possibly be co=
nfused
> about how this function works, but I guess it was already 'weird' for
> file-backed/KSM.

Actually, wouldn't the simplification remove the already existing
confusion, rather than adding to it? :)
We can then simply say, rmap_walk() expects folio to be locked.

>
> So the issue remains really - folio lock contention as a result of this.
>
> It's one thing to theorise, but you may be forgetting something... and th=
en
> we've changed an absolutely core thing to suit a niche UFFD use case.

I really wish there was a way to avoid this within the UFFD code :( In
fact, the real pain point is multiple UFFD threads contending for
write-lock on anon_vma, even when they don't need to serialize among
themselves.
>
> I do wonder if we can identify this case and handle things differently.
>
> Perhaps even saying 'try and get the rmap lock, but if there's "too much"
> contention, grab the folio lock.

Can you please elaborate what you mean? Where do you mean we can
possibly do something like this?

UFFD move only works on PageAnonExclusive folios. So, would it help
(in terms of avoiding contention) if we were to change the condition:

diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..1638e27347e7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1006,7 +1006,8 @@ int folio_referenced(struct folio *folio, int is_lock=
ed,
        if (!folio_raw_mapping(folio))
                return 0;

-       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)=
)) {
+       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)=
 ||
+                          PageAnonExclusive(&folio->page))) {
                we_locked =3D folio_trylock(folio);
                if (!we_locked)
                        return 1;

Obviously, this is opposite of simplification :)

But as we know that shrink_active_list() uses this as a boolean, so do
we even need to walk rmap for PageAnonExclusive folios? Can't we
simply do:

diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..a26523de321f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1006,10 +1006,14 @@ int folio_referenced(struct folio *folio, int is_lo=
cked,
        if (!folio_raw_mapping(folio))
                return 0;

-       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)=
)) {
-               we_locked =3D folio_trylock(folio);
-               if (!we_locked)
+       if (!is_locked) {
+               if (!folio_test_anon(folio) || folio_test_ksm(folio)) {
+                       we_locked =3D folio_trylock(folio);
+                       if (!we_locked)
+                               return 1;
+               } else if (PageAnonExclusive(&folio->page)) {
                        return 1;
+               }
        }

        rmap_walk(folio, &rwc);

I'm not at all an expert on this, so pardon my ignorance if this is wrong.
>
> >
> > Before 09854ba94c6a ("mm: do_wp_page() simplification") that wasn't an =
issue, but
> > it would have meant that the write fault would be stuck until folio_ref=
erenced()
> > would be done, which is also suboptimal.
> >
> > So likely, avoiding grabbing the folio lock was beneficial.
> >
> >
> > Today, this would only affect R/O pages after fork (PageAnonExclusive n=
ot set).
>
> Hm probably less of a problem that.
>
> >
> >
> > Staring at shrink_active_list()->folio_referenced(), we isolate the fol=
io first
> > (grabbing reference+clearing LRU), so do_wp_page()->wp_can_reuse_anon_f=
olio()
> > would already refuse to reuse immediately, because it would spot a rais=
ed reference.
> > The folio lock does not make a difference anymore.
>
> folio_check_references() we're good with anyway as folio already locked.
>
> So obviously shrink_active_list() is the only caller we really care about=
.
>
> That at least reduces this case, but we then have to deal with the fact w=
e're
> contending this lock elsewhere.
>
> >
> >
> > Is there any other anon-specific (!ksm) folio locking? Nothing exciting=
 comes to mind,
> > except maybe some folio splitting or khugepaged that maybe would have t=
o wait.
> >
> > But khugepaged would already also fail to isolate these folios, so prob=
ably it's not that
> > relevant anymore ...
>
> This is it... there's a lot of possibilities and we need to tread extreme=
ly
> carefully.
>
> if we could find a way to make uffd deal with this one way or another (or
> possibly - detecting heavy anon vma lock contention) maybe that'd be
> better... but then adding more complexity obv.
>
> >
> > --
> > Cheers
> >
> > David / dhildenb
> >
>
> I mean having said all the above and also in other thread - I am open to =
being
> convinced I'm wrong and this is ok.
>
> Obviously removing the complicated special case for anon would _in genera=
l_ be
> nice, it's just very sensitive stuff :)
>
> Cheers, Lorenzo

