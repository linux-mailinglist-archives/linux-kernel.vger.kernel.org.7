Return-Path: <linux-kernel+bounces-785436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44072B34A99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A23C1A880E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED4220680;
	Mon, 25 Aug 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/McTJhK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8627AC5A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147579; cv=none; b=BPE+ITaWGMZsTRFbKJD+BB+Wc+dKTW04CPbSnpq7LwBqCs0nqD3RRsmzs3nmFfu+isquATqgeW4vENv9wFxl9ES4iyXI0U2tZ91cYlZUleFDLdUPxOzxWJ8LfMjYaSrPnP+6P+ck4xY/dh6pgpPwJHNVmehEio0W1Q9mLS4Mg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147579; c=relaxed/simple;
	bh=1rVjBKaqAtGJ7WGcRNXs6qEiTjzQCHGq3DZxYKzKIgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNjTlmnqb0KWuGBuTwUbdwXeY58o0ciUHEHdyJUMFaSSl8jf7wOro2X/2tkGHlAVcYW2gBSMPslCo+5Mly4MCkzL6WOB89G0mamZkNzY7nJQEvBqbHEFeD9VnMplJR0Aq5gIuUkMMy+UjMNjCPLTQHYkotIqnl5P7yWM+U0txAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/McTJhK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c386d3510so1916a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756147575; x=1756752375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux5pqSqp7hAlsWtwMgovrQ8ypY3OKI7YYVef7eLTz/k=;
        b=A/McTJhKGpciL5JJ50VEmjbsCGp3FwNVNHO9fHv4l2aPDCK5c5TXQ3nrESxHkMqR5p
         gs8kVkjsARJ0EVR2lYHbV0OmM+RFAE/OYAs3LG9oUgfg2HwDwzPIkZS/SYhzdC6tEOQ4
         orkHP53JIkugNifMOnnissESoo5vb0SMsQpZYNmfoyO3kUSgsmAPzK2IMTXHid/lnf+4
         M/i6HOQsRK2HyiM8QLJ08FDveq6sJ21T6yuV4BRUKABt5ne+47jBUBjZiTjQ9TYHKZ1n
         XU0zn0MsMrei6w74NTjeJALsl3vOkqV4xpqoI9/n3uk4cGHLUsfjBTuwmxH1zlolPJDH
         +yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147575; x=1756752375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux5pqSqp7hAlsWtwMgovrQ8ypY3OKI7YYVef7eLTz/k=;
        b=RrCatiaH6pXJ9/PrEaZriwVGA5ah/VhAXPL2Z4bAlL4kMhn8VmxQVEIxBzlrM9jg3L
         SSHbFxMhFrBrfweDa4O8JqL+D3hYTXez+LKeT+HHsAUbUroIlRgWT7QIbc2kxlL/rlwF
         cXZ6zgBBKqLexdPwScASzaNhbCo40rvqz841yjN4q//t5OtptVJ+xlD0T7ScooVaE4Sb
         RJFIlHd63BbCo5rlpwkmtQElhCWBTzjDb0qxMsGke0aILPLiRi/JBlAPAGX+tl3bqRfs
         wQiO6npR8vht7xISuJXfvISKgYN25ZU2wawz7RsY4rbLW/6hEattPsUFS9GDa5nr77QF
         YTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZh1VHPsdxczzg95Weg+C9Z367CtzJD9DKaFbyoY4L5xTbzL07O/jizpy/qU1lCn9BflBYHFLtakIKHe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3zr5qO05JHHre+3Fz3ZIjYQCjxYD292Po5eM7CTZXb552MuY
	J22efRMFEjK4ME6y7pE3RNEVRVvvRYR70LTxkYpiBh2w90kW1Uk0356I937bBs9QX0eUKuloi45
	aT/pI0BZiX675KCK2wukFArJg7FtPdUShn4F5DCaq
X-Gm-Gg: ASbGncutTLb1+t0DgJW5IXB9/C0OnR33qxoOY1BUDs3AGijLJRsQHSnK/jISl66y1bx
	wNM6M4lrjrTxjJiV7pf/E9pX6bBWbe+DunP9eQcB2IhNkL27+4GoYaU20yQQ29sAIxgT5YtHkQV
	XoH3Yu0/c0pjazFH+TQmU3iMDsSS8Q9/E3t3c0A1h/W+9jm/P/s/w9HumINUt6CfsrcHv0bBX0K
	j4jtUOSx9Ksb70Ww7zKdK9fPcSNvKwUxsrcpM3S3xVS
X-Google-Smtp-Source: AGHT+IFN9zeyztDK/DJYMBoWFLvCgU9cLZ58jhAV5frt/msh+5bP2f1s3CZwTmmQ3aTs+zi1KZm3UYRliuOoFyk86Pk=
X-Received: by 2002:a05:6402:2682:b0:61a:1922:32ac with SMTP id
 4fb4d7f45d1cf-61c8efaf08amr11498a12.0.1756147574955; Mon, 25 Aug 2025
 11:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
In-Reply-To: <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 25 Aug 2025 11:46:02 -0700
X-Gm-Features: Ac12FXyprwIn2v9rZSqr_G5ifLlee_clYu5PD3nxZlWW9msoXVKrPNU4V_wu43k
Message-ID: <CA+EESO5Phk1W64mNm=YG8E1oNEXENP94cd5FUuq0PhcUsOe7+Q@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:19=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.08.25 19:29, Lokesh Gidra wrote:
> > Hi all,
> >
> > Currently, some callers of rmap_walk() conditionally avoid try-locking
> > non-ksm anon folios. This necessitates serialization through anon_vma
> > write-lock elsewhere when folio->mapping and/or folio->index (fields
> > involved in rmap_walk()) are to be updated. This hurts scalability due
> > to coarse granularity of the lock. For instance, when multiple threads
> > invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct=
 pages
> > from the same src VMA, they all contend for the corresponding
> > anon_vma=E2=80=99s lock. Field traces for arm64 android devices reveal =
over
> > 30ms of uninterruptible sleep in the main UI thread, leading to janky
> > user interactions.
> >
> > Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> > folio_referenced() is the most critical (others are
> > page_idle_clear_pte_refs(), damon_folio_young(), and
> > damon_folio_mkold()). The relevant code in folio_referenced() is:
> >
> > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
> >          we_locked =3D folio_trylock(folio);
> >          if (!we_locked)
> >                  return 1;
> > }
> >
> > It=E2=80=99s unclear why locking anon_vma exclusively (when updating
> > folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> > with folio locked. It=E2=80=99s in the reclaim path, so should not be a
> > critical path that necessitates some special treatment, unless I=E2=80=
=99m
> > missing something.
> >
> > Therefore, I propose simplifying the locking mechanism by ensuring the
> > folio is locked before calling rmap_walk().
>
> Essentially, what you mean is roughly:
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 34333ae3bd80f..0800e73c0796e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1005,7 +1005,7 @@ int folio_referenced(struct folio *folio, int is_lo=
cked,
>          if (!folio_raw_mapping(folio))
>                  return 0;
>
> -       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(foli=
o))) {
> +       if (!is_locked) {
>                  we_locked =3D folio_trylock(folio);
>                  if (!we_locked)
>                          return 1;
>
>
> The downside of that change is that ordinary (!ksm) folios will observe b=
eing locked
> when we are actually only trying to asses if they were referenced.
>
> Does it matter?
>
> I can only speculate that it might have been very relevant before
> 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_an=
on_exclusive").
>
> Essentially any R/O fault would have resulted in us copying the page, sim=
ply because
> there is concurrent folio_referenced() happening.
>
> Before 09854ba94c6a ("mm: do_wp_page() simplification") that wasn't an is=
sue, but
> it would have meant that the write fault would be stuck until folio_refer=
enced()
> would be done, which is also suboptimal.
>
> So likely, avoiding grabbing the folio lock was beneficial.
>
>
> Today, this would only affect R/O pages after fork (PageAnonExclusive not=
 set).
>
>
> Staring at shrink_active_list()->folio_referenced(), we isolate the folio=
 first
> (grabbing reference+clearing LRU), so do_wp_page()->wp_can_reuse_anon_fol=
io()
> would already refuse to reuse immediately, because it would spot a raised=
 reference.
> The folio lock does not make a difference anymore.
>
>
> Is there any other anon-specific (!ksm) folio locking? Nothing exciting c=
omes to mind,
> except maybe some folio splitting or khugepaged that maybe would have to =
wait.
>
> But khugepaged would already also fail to isolate these folios, so probab=
ly it's not that
> relevant anymore ...

Thanks so much for your thorough analysis. Very useful!

For folio splitting, it seems anon_vma lock is acquired exclusively,
so it serializes against folio_referenced() anyways.
>
> --
> Cheers
>
> David / dhildenb
>

