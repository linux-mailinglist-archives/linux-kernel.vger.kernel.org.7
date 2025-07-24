Return-Path: <linux-kernel+bounces-744496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD2B10D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A117B9CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6EF2E5428;
	Thu, 24 Jul 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22ZpNB7p"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F782E541F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367399; cv=none; b=lbEm6EG9Ei2ZZVcVYebztzrlU5+oCpKaptjNfDZkU7sRbN073Ki/2I36AyuGuDqjpWJCku8gd8dsecYJWN59HtjMqUtSHaNlmSF+7L9mcPHoAutTlmqdPS432RCSlTOPHbBQuVKDYRIkMpj2/GRq32bGKx8MfW1Lvy0n9981TUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367399; c=relaxed/simple;
	bh=Zm3GWu27PL8Ou4KIRUdlSpQpRr+ffaqvTuKRCLmF1ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzShmUI+4WB/nnCGjWaFTE3BJBChX8ds7jCGsfulYdt65v8vfhBg3VpJvYgLUFbL/QvQDukbxF5v36bqIDP2Mp3kuI4QtFeJdEiFgTW5gp6Sq+5tdFaPWTGWFuHLzjPOYg95Utdw0MI2iZGWNLnKTwB7iPtKolc3lwzsPn8WwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22ZpNB7p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso12332a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753367396; x=1753972196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlhcpDPJ/zf5PjQewozCSVSh7GoDUgf457I2X0B4PcQ=;
        b=22ZpNB7pOTGTBcak60w/k0Vzh3D+a8ZPQ2H+xaLCaYLIZiPXDAtUZYhqIj1wuy1Cmr
         1yOrh2YgVMeXHm5TOSHDOBooHMwdX5TTYiWfupWJqav6PWwTexxCFJcKjLBOZsMB6XJ/
         uMcHuOSdjn+99YgfbnF4FoypVBTE8kN26PNFZipPz6ZmHtLASsZyXRVweprFcj+K6k8d
         w9Abe2bWE33SlSjMwjd71IbHOlRQk+e3iP5vhawz1PiyUAjkAEhWNfcQV5Cu06rAEiF4
         TesHKrXwxHtw5CVjSsmgTFPcuC0XAHVabJ2xV05eo4CrFHu/gzXlzteBnu//17gDg/2i
         cQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367396; x=1753972196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhcpDPJ/zf5PjQewozCSVSh7GoDUgf457I2X0B4PcQ=;
        b=RVKe9jBLuxLCIvarprfjEPaVBESR+uwgLyUk73cSQ2VZsPZ1I93F1lortZeYJKvZNJ
         3uYn3k3UML6NhXVWvvLtKoalTPRc+KkNF3ykkwkzu8C5l3fatWW1+tcMwFBHCDBmkjSQ
         o7lPhsbCC5VrmlzmUbnydMl8S10PYlR/kcKqqtuvwlio7fjggNeXYFwEEJZgwMHm76al
         5XKqEQGpoijtYzGYoynbpxab2JLdlxdJMq/l5+HJ0C5OJMpE2ktH1qlWSAsw53RMQ1Cw
         RvAeCQwBH19nQJfwkaE+3/65hq+OrgxO3KILwnzATzK9+lK+mYKpgA3Z00qQ5m5WTyKt
         O+FA==
X-Forwarded-Encrypted: i=1; AJvYcCX5lDYkiydYEroZ/aj6TroxeVHop3BmQg/uzsg2Q7f/nz/U3JfjmfX/PGoQGBzsgt2rSUXz2lkAv1/bW+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+/4Drl1MrAodjgllMnjxlO+V9aKGhMopRBaYXc+OW2x7VMFs
	QSK10UplaWlnKbG4OxPHTOKOVW0Fo9oPE0PVE232w1+yTBq+3PT+PDTUsEEW2PwjsemeRMfQ71H
	2jioEbmFbxm2E0AJ9I67JfZibsfpeBTAq/3tkUipt
X-Gm-Gg: ASbGncuKcqJoJr6yHhv9Db5qy6H9IyMVTSDkUym4vExNQzLOWfYCSJDRjQx2Es/ghNB
	6hwNbGiG/YJBFLH9BHXapjUC0yKztTT9OZTrSKE8MeJ7oULKv+2ZW2qe9EVQCOIwAeh0vwJrkmo
	ENnx2KJhMz+OQlS36GT8Yt7Ncx9GisY474JRjaissXVD4FCYqHlKEeeZzUzHHqdfBdxaqRoUjAk
	kd3pNe7s1vTTrGAvfWW/TUgCMZgbVdZS+SDL5tbVRGf7ZpR
X-Google-Smtp-Source: AGHT+IFnzfnkL7IMifLfz57vgfmQBM0IvNePvt8oCAV9PXZXiY5Zcoi2sHhp40dEdBN6gXkrNPjSmbr628hsdVXAWto=
X-Received: by 2002:a05:6402:20ca:b0:60e:3d45:c65a with SMTP id
 4fb4d7f45d1cf-614cce46f4emr80233a12.5.1753367395396; Thu, 24 Jul 2025
 07:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
 <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz> <dbc20783-0ff5-4902-bd73-e9282bfd87ba@lucifer.local>
In-Reply-To: <dbc20783-0ff5-4902-bd73-e9282bfd87ba@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Jul 2025 07:29:42 -0700
X-Gm-Features: Ac12FXwkwryuiZ7qVX6VVH1hTJoQ17odUJToEjarcBlX6QEUdlzMhlFWhWvKrTQ
Message-ID: <CAJuCfpEVrpHACx2G2=Gq7YadxkA-DnFpFmbUij=Xr1=w7yrLbg@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:53=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 24, 2025 at 10:38:06AM +0200, Vlastimil Babka wrote:
> > On 7/24/25 04:30, Suren Baghdasaryan wrote:
> > > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> > > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> > > after it calls rcuwait_wake_up(). What do you think about this
> > > approach, folks?
> >
> > Yeah except it would be wasteful to do for all vma_refcount_put(). Shou=
ld be
> > enough to have this version (as Jann suggested) for inval_end_read: par=
t of
> > lock_vma_under_rcu.

Yes, definitely.

> > I think we need it also for the vma_refcount_put() done
> > in vma_start_read() when we fail the seqcount check? I think in that ca=
se
> > the same thing can be happening too, just with different race windows?

Yes.

> >
> > Also as Jann suggested, maybe it's not great (or even safe) to perform
> > __mmdrop() under rcu? And maybe some vma_start_read() users are even mo=
re
> > restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-only=
, and
> > use that.
>
> Agreed that doing this under RCU seems unwise.
>
> I know PTL relies on this as well as zap PTE page table reclaim, likely t=
hese
> wouldn't interact with an mm going away (you'd hope!) but it seems unwise=
 to
> play around with assumptions here.

__mmdrop_delayed() is a viable option but I would hate adding
mm->delayed_drop for !CONFIG_PREEMPT_RT just for this one case.
Alternatively, we don't need to be in the rcu read section when we
call vma_end_read() inside lock_vma_under_rcu(). We refcounted the
vma, so it's locked and stable, no need for RCU at that point. We can
move rcu_read_unlock() before vma_end_read(). However that's not the
case with the vma_refcount_put() inside vma_start_read(). We could
change vma_start_read() semantics so that it drops rcu_read_lock
before it returns. That way we could do vma_refcount_put() after
rcu_read_unlock() in both places.  The retry case in
lock_vma_under_rcu() would have to reacquire rcu_read_lock() but that
retry is not the usual path, so should not affect overall locking
performance. What do you think about this alternative?

