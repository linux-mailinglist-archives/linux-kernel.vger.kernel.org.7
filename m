Return-Path: <linux-kernel+bounces-869759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3244C08AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918321A6725A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7628C5D9;
	Sat, 25 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFqJgRg7"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6702877DE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366334; cv=none; b=ncLarQ8I6yXzkMQ1a0TCE6j2NaUU2/vENMxnFLpW/3fDcIerl4GGCAoCZqPnrVL6boLiXytv2C/Fv/2srFLhoQyEa6Raniw6NwKSYaXF3Ri+wvS1e0dEsRyzYsjIScPOzp1GdS8yCz60NCTNQYB1MbHCNr7B4LK3mDQOxbqMMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366334; c=relaxed/simple;
	bh=T024JLzezhn/owYdSKp0XfQ7RUhl+MWD6QiZ4czgoTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVeqGdwH/Sn67GS3fM+txIvP9/po8PG3TBtXTuD/hKvkprKfp671t3yUmAzTC80JW+mxAWHEXShcsmAMzDievqpccD3zSRQKkLw7MT9v7d/WJ34jOOqFEnt0hgufX4HXrgsH+XVa6dkwupKr0gGZKQibHcDP7hdx8MAnoj4yJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFqJgRg7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6cf07258e8so1951596a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761366332; x=1761971132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PhHVYAu3GoqB9tOUrtNyZ6VllNlvh/UDz5NmlzDI5Q=;
        b=iFqJgRg7x7Fo1rz1p8+pKieCPkhrL3BS2MF89OhPE7r0JL/6wlo9IAelvf4k2azeqc
         O0UXytki9B+y32dHL5VxdB8YiOTCRQbQo1l/dgENFDil3hBvzkatwbHKwLJFAqWdY6re
         8dLojOWyMCA9mM5k+Z4n8RbzrZm5sLJk7yB/xF7vemfrdnXW5pI2Mw+DpHd9EliDRrEk
         lT2WUSMD/yLad/PRK+3Dx4+nvr5ut6iGtEDDPDoib1jJemib+YhMgaVBGRblIKuO5+VK
         QK25ESKQct1ldcYNNc5Y90Dx9mDTJh6+jShh8fj+ej44jc56vMl3VdFIJt/x2ry52K16
         3eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366332; x=1761971132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PhHVYAu3GoqB9tOUrtNyZ6VllNlvh/UDz5NmlzDI5Q=;
        b=c4MleUe41TXH3zZweJN1d31TI1wvau4qUBILIEWqhr5qKfwRVFF1ZZ2hXb8uCrym89
         tjHivjOp0AP6xO23ZgeWz3rdnlfBj8P6fttDYbvgM8hPrxWEVkTz2LKPmDsgTXp/6NDH
         8SzjR0OmZB3H70t5Bo+Mh0thVmRp7/tCVC0eEExydyBKu/krqBb6dM+P/msczqPdSxs8
         yJKAFOrRQuLh6lblNVxte0tEplHV7wRJskDoNG6c1nR1odSjT8OWK3cdWf2rFnkFewcS
         JXgAUxr7Q0JolefnYQMXP+FbIV6hFCL/K1IifuqNRkPzxMtm7u8CWkJtAobaLMK3IS5a
         QVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDwy4Eyq3LM68ucWOjZ8ZgjBYk3LjMBJpDoMZAoswCxKT4kY2nl2Zjt1yLNn1en1HzP784auIiRQzBHpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpwlZc2WNU75Kn/rCwpTYggjLh/HOO5LFd1q98pDwBg77/V8m
	D2Kg7oWg6MPwP9cRhBtDfSnIxBOLp2lTcSgXXGGyMVYrc9Y1cPzp+smWGfCUPYpTZ9xJqNfZrYV
	8i3IM0eDnUbccjeEOwsqQ+ZU7rOQC3fcmUFh7uLbL
X-Gm-Gg: ASbGnctkMk090TGNxCceJvSxJH03OnhaKaOkP2ZdiPMHM5VEWQCG2VkBlyYKO7zc8Ea
	B/0Sw1AHHK3CcFCcefYb8zzzT4wrig9+gbl6lDSbz/8HNpO1+EiKAerto5J6YqqWJhQMLimGXdO
	KDDBqeeHDSZ6TzOaSaL6vXot1IhZC7QhBPvM9rrEXt2EZKKCAtPeER0IQZCMo63i2HJKuIKjGIn
	XsACrqc3olSANoOV+RjLHkBOGtSplJrVC9tJR4mxTCywrlwsGLvXgA2/byYGApJhs170udxAFDx
	LsOXqUqgP9TnleszRCc8/I7SbA==
X-Google-Smtp-Source: AGHT+IE3YSxNIMuDra80sjllPz1FMOI4xMsMGSHUumbJrsGzXTOGgEeAdl92i/4ykKaEWjGEn4MI+t4Ip6reBjO6l1o=
X-Received: by 2002:a17:903:2381:b0:266:cb8c:523 with SMTP id
 d9443c01a7336-290cc9be17amr377871245ad.48.1761366332191; Fri, 24 Oct 2025
 21:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUCx9MOJobomXXBcXsCNgSn__U3mJp8LFxD515o-boyr=w@mail.gmail.com>
 <20251025035147.2094258-1-lizhi.xu@windriver.com>
In-Reply-To: <20251025035147.2094258-1-lizhi.xu@windriver.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Oct 2025 21:25:20 -0700
X-Gm-Features: AS18NWBRmH_2lAVRSFK1FC1NYFaseykjicIslllLmdlBt_n_d0eBcPdw3LG8pXk
Message-ID: <CAAVpQUA_CqqUfoJb=NaQ7YnBUbW0UWQS4W++TXwRFekenkDM8Q@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:51=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> On Fri, 24 Oct 2025 19:18:46 -0700, Kuniyuki Iwashima <kuniyu@google.com>=
 wrote:
> > On Fri, Oct 24, 2025 at 2:39=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.co=
m> wrote:
> > >
> > > There is no synchronization between the two timers, rose_t0timer_expi=
ry
> > > and rose_timer_expiry.
> > > rose_timer_expiry() puts the neighbor when the rose state is ROSE_STA=
TE_2.
> > > However, rose_t0timer_expiry() does initiate a restart request on the
> > > neighbor.
> > > When rose_t0timer_expiry() accesses the released neighbor member digi=
peat,
> > > a UAF is triggered.
> > >
> > > To avoid this UAF, defer the put operation to rose_t0timer_expiry() a=
nd
> > > stop restarting t0timer after putting the neighbor.
> > >
> > > When putting the neighbor, set the neighbor to NULL. Setting neighbor=
 to
> > > NULL prevents rose_t0timer_expiry() from restarting t0timer.
> > >
> > > syzbot reported a slab-use-after-free Read in ax25_find_cb.
> > > BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/=
af_ax25.c:237
> > > Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> > > Call Trace:
> > >  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
> > >  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
> > >  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
> > >  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
> > >  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
> > >
> > > Freed by task 17183:
> > >  kfree+0x2b8/0x6d0 mm/slub.c:6826
> > >  rose_neigh_put include/net/rose.h:165 [inline]
> > >  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
> > >
> > > Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> > > Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > ---
> > > V1 -> V2: Putting the neighbor stops t0timer from automatically start=
ing
> > > V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
> > >
> > >  include/net/rose.h   | 12 ++++++++++++
> > >  net/rose/rose_link.c |  5 +++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/include/net/rose.h b/include/net/rose.h
> > > index 2b5491bbf39a..33de310ba778 100644
> > > --- a/include/net/rose.h
> > > +++ b/include/net/rose.h
> > > @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct rose_ne=
igh *rose_neigh)
> > >         }
> > >  }
> > >
> > > +static inline void rose_neigh_putex(struct rose_neigh **roseneigh)
> > > +{
> > > +       struct rose_neigh *rose_neigh =3D *roseneigh;
> > > +       if (refcount_dec_and_test(&rose_neigh->use)) {
> > > +               if (rose_neigh->ax25)
> > > +                       ax25_cb_put(rose_neigh->ax25);
> > > +               kfree(rose_neigh->digipeat);
> > > +               kfree(rose_neigh);
> > > +               *roseneigh =3D NULL;
> > > +       }
> > > +}
> > > +
> > >  /* af_rose.c */
> > >  extern ax25_address rose_callsign;
> > >  extern int  sysctl_rose_restart_request_timeout;
> > > diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> > > index 7746229fdc8c..334c8cc0876d 100644
> > > --- a/net/rose/rose_link.c
> > > +++ b/net/rose/rose_link.c
> > > @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh)
> > >
> > >  static void rose_start_t0timer(struct rose_neigh *neigh)
> > >  {
> > > +       if (!neigh)
> > > +               return;
> > > +
> > >         timer_delete(&neigh->t0timer);
> > >
> > >         neigh->t0timer.function =3D rose_t0timer_expiry;
> > > @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_list=
 *t)
> > >  {
> > >         struct rose_neigh *neigh =3D timer_container_of(neigh, t, t0t=
imer);
> > >
> >
> > What prevents rose_timer_expiry() from releasing the
> > last refcnt here ?
> The issue reported by syzbot is that rose_t0timer_expiry() is triggered
> first, followed by rose_timer_expiry().

I don't see how you read that ordering from the report.
https://syzkaller.appspot.com/bug?extid=3Dcaa052a0958a9146870d

The only ordering I can find is that kfree() in rose_timer_expiry()
happened before ax25_find_cb () in rose_t0timer_expiry().

> Therefore, in rose_t0timer_expiry(), the reference count of neigh is
> increased before entering rose_transmit_restart_request() to prevent
> neigh from being put in rose_timer_expiry(). Then, in rose_t0timer_expiry=
(),
> neigh is put before executing rose_start_t0timer() and the neigh value is
> set to NULL to prevent t0timer restarts.
>
> The case where rose_timer_expiry() is triggered before rose_t0timer_expir=
y()
> is not considered at this time.

So this change just papers over the root cause.


> >
> > The t0timer could be triggered even after that happens.
> >
> >
> > > +       rose_neigh_hold(neigh);
> > >         rose_transmit_restart_request(neigh);
> > >
> > >         neigh->dce_mode =3D 0;
> > >
> > > +       rose_neigh_putex(&neigh);
> > >         rose_start_t0timer(neigh);
> > >  }
> > >
> > > --
> > > 2.43.0
> > >

