Return-Path: <linux-kernel+bounces-744531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20051B10E16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025781CE7C79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4B2C15A2;
	Thu, 24 Jul 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v83bsusP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D828D849
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368784; cv=none; b=Q52NltzPPTKBOUVbs/cLa8YQkkulAn2ly5zD5sM40cMvvhs+OkdLzJkM/yucI0ABhYwJ/uAjhyqGWvlLLG4FGWSHsmm4sTZk+RX0RZFbBIVxf1LUGgFC6BWsauXSPnQJB9T/ogLX3jMd4ugkC8+PmLvWlC5fS44Oc5QttUmbFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368784; c=relaxed/simple;
	bh=S/FyytTfMgRSnZg3KrJcOq6EumufjAjpeJd8TYBsrjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnpKfzx8JTV4sHZ+nVybCOnUm7ps6Ymsv49njo+igwL+IcfR0sbmECxXa2sjQOBh3qHchXWgdZxMQik5q27vZzeZN5Vpy7OLRR/f+seSB8FQ2r4zk/ttC3n1oPuxbBUEAPmks5GpwSJXIHcrbH8M0oA1m/97aAUK+X64n6Gpim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v83bsusP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso12707a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753368781; x=1753973581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5W6GQLMfYZFiEJ+Qoi5McfZK35xrop1Qe9F9Xdkh50=;
        b=v83bsusPbGmDtbNySSDnhaZtcjklFKqCNranbIZj7Fb5pDGyKs0YiYa8/jLikKCRaY
         +Q05ZKbFaAgeP9as78MrXQOo5iiUaKxm2oDGWIRPqmvrdtGqyDknGrqnMvk8dBjLC0EW
         YGxE5Prmwlc57QT2ecFYOlU/JCD4wYbbEzuSbVGC6uTi4Q88KDN8JxZSSHIqOq3lAqtl
         wE50MwCuMl0XvwG1oo+zZO0rl8SOCv7gJh/y58HpLz8MWkVqJW0ug+2vPI3ij6AdMXRg
         b3RXV8oVBu19kbjxdOQ8dTQZCcgyywrHHj06Y6fB6maumuXF1nj2Ep/oZFrpWz20ZdfS
         tWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368781; x=1753973581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5W6GQLMfYZFiEJ+Qoi5McfZK35xrop1Qe9F9Xdkh50=;
        b=Z8baOsumHTeEyjWTb5ltiz6+y2gnNwG5rZit0NV+2S2U2Ou3RfY3lqzH5Nqg3Sf+G0
         dQOjWVqjZIXPW/9VPrjNlSNa2LSSw9wHCcVOMvpUy5XWAvDSqo4GLwZrhq82mjmuGO04
         MKHIkXTGfUBHEFDAVhqHVLBROw4CeMb1JJCHmw+ukKVIweCO8NMjLWMVaQQsUsVp8Hlh
         VLdSs20lCslWRr4M29S/wR7UxDHstk2zjvY81LSd/+QDh4Ml3NpQk7NYQIk+D+aaHe7t
         2Pe1ZyxypVTfmb92U+Z3HPiNMvcwpg3NV5naogdGV5CjHDRkJdY+yThFDi1VqbzBPiEG
         8uSg==
X-Forwarded-Encrypted: i=1; AJvYcCXYDukLbRVaGZ3gcLNZfO5TKdDnerg9jXehBYkUc/25QZ7mnQ+xkvmmio4oLHVMHCN2F3Lo4tGIws10skE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygr8mbFJi7gBcjm/GTpO3RX79LoBRhzMfD5nJcEed2Rdmsvb1G
	K1zcbRVIJIsNDsFha+3Ie5VdrODYasinFW+YLg1joLUbg3wiIW7peguI6OL7RBHE4sejURsAk2r
	FCpeZIigez68wuju4ofH/rowtdKtCxK/iRrehpDmE
X-Gm-Gg: ASbGncsfYfq9XxqR66QOuX8zEgUkZz2aGtG2lH8f2H1sQpcV/21EiFFkjFp9YCM/CBH
	5c+prMvipvI0t9ELtjsATn7Ht9z6wS0NaCU4Q8S0IHOy9kKoZfRepInf5dWhWXgTdtl42KGUddD
	KSa+b66ebHZ0ETs1wlNUf6Nz2xbdsK8EX7kreLCAL5sGnMekkmk38AhcT/dFekoHc6ja3zTpG4E
	TySh56HzDwC1dQLG5VkxdfuiZOUgNbfCtM=
X-Google-Smtp-Source: AGHT+IG8ssWzr4F1L4YOk9MwdHJTG8gIMT6wpGrMN8VvukpOQy347mf79eESvOL6r0KZ4TeqeaeflthxQsKBM7CQsWU=
X-Received: by 2002:a50:c311:0:b0:612:e537:f075 with SMTP id
 4fb4d7f45d1cf-614cce4724emr83262a12.7.1753368780520; Thu, 24 Jul 2025
 07:53:00 -0700 (PDT)
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
 <CAJuCfpEVrpHACx2G2=Gq7YadxkA-DnFpFmbUij=Xr1=w7yrLbg@mail.gmail.com> <3be82198-a992-4917-b5ac-b93bb0474ad1@suse.cz>
In-Reply-To: <3be82198-a992-4917-b5ac-b93bb0474ad1@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Jul 2025 14:52:47 +0000
X-Gm-Features: Ac12FXwFNgc4NqgCdpxxbB8pJw-RXOG2gFoiHeXshUqdIsHwIesk51LXD1BpTvo
Message-ID: <CAJuCfpHQ501HBBQjm2Qvc7dgr93uH-=bgukXHJzpkJRk4_x7SA@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:45=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/24/25 16:29, Suren Baghdasaryan wrote:
> > On Thu, Jul 24, 2025 at 3:53=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> >>
> >> On Thu, Jul 24, 2025 at 10:38:06AM +0200, Vlastimil Babka wrote:
> >> > On 7/24/25 04:30, Suren Baghdasaryan wrote:
> >> > > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> >> > > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> >> > > after it calls rcuwait_wake_up(). What do you think about this
> >> > > approach, folks?
> >> >
> >> > Yeah except it would be wasteful to do for all vma_refcount_put(). S=
hould be
> >> > enough to have this version (as Jann suggested) for inval_end_read: =
part of
> >> > lock_vma_under_rcu.
> >
> > Yes, definitely.
> >
> >> > I think we need it also for the vma_refcount_put() done
> >> > in vma_start_read() when we fail the seqcount check? I think in that=
 case
> >> > the same thing can be happening too, just with different race window=
s?
> >
> > Yes.
> >
> >> >
> >> > Also as Jann suggested, maybe it's not great (or even safe) to perfo=
rm
> >> > __mmdrop() under rcu? And maybe some vma_start_read() users are even=
 more
> >> > restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-o=
nly, and
> >> > use that.
> >>
> >> Agreed that doing this under RCU seems unwise.
> >>
> >> I know PTL relies on this as well as zap PTE page table reclaim, likel=
y these
> >> wouldn't interact with an mm going away (you'd hope!) but it seems unw=
ise to
> >> play around with assumptions here.
> >
> > __mmdrop_delayed() is a viable option but I would hate adding
> > mm->delayed_drop for !CONFIG_PREEMPT_RT just for this one case.
> > Alternatively, we don't need to be in the rcu read section when we
> > call vma_end_read() inside lock_vma_under_rcu(). We refcounted the
> > vma, so it's locked and stable, no need for RCU at that point. We can
> > move rcu_read_unlock() before vma_end_read(). However that's not the
>
> Seems correct.
>
> > case with the vma_refcount_put() inside vma_start_read(). We could
> > change vma_start_read() semantics so that it drops rcu_read_lock
> > before it returns.
>
> Looks like there's no other users of vma_start_read() than
> lock_vma_under_rcu() itself that we need to care about, so seems fine.
>
> > That way we could do vma_refcount_put() after
> > rcu_read_unlock() in both places.  The retry case in
> > lock_vma_under_rcu() would have to reacquire rcu_read_lock() but that
> > retry is not the usual path, so should not affect overall locking
> > performance. What do you think about this alternative?
>
> Sounds feasible.
>
> I guess at that point it would be cleaner to combine vma_start_read() wit=
h
> mas_walk() into a new function that does both and starts with
> rcu_read_lock() itself so we don't have the ugly scheme of entering under
> rcu lock and returning without it?

Yes, I was thinking along the same lines and maybe we can also move
the vma->mm !=3D mm checks there too, as Jann suggested. I'll see which
way looks better and if I get to a satisfactory state, will post a
patch.
Thanks!

>

