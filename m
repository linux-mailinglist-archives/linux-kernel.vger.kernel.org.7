Return-Path: <linux-kernel+bounces-869835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B2C08D41
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53DB2351113
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34F2C17A8;
	Sat, 25 Oct 2025 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsxhePH/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C0224FA
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761376565; cv=none; b=cAGlUk0z8CHcQ6kS3yTC+lDxyDRGAibPplhgpNimLJpdXkc+W4KZfD5zIDoC8EQ7gLAwmBxzyhiiUSa9aWqacp+RPYahkJHxrJmcVMGHyYyRT2aFRdPQVLTKqeqpn7C4GM7o8K3QBsUUXyco6147jmf+DaN+TRKCZ+HuCSY9x6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761376565; c=relaxed/simple;
	bh=biEA5MpSib2IYJUahdExDpnVZxpN4RYOjrYtsmVXVdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLiA5yzJ9iPsXcjBwfIgnjfRQ02Yr01khbe6LZvlHdGgpkLd75QguHerZRNbyfWuEtcZ7HwkTgLvsMT1r1T6LVpC/5kKaJBM99LZ2oZw+3He8vLUZ+sq0woa0GndD5sgWVlk50o9fVGM46B+cOoYE4BU7Gq0mxC/pqWGbbrdOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsxhePH/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so42067465ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761376563; x=1761981363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svbY4zNoxF4qCqZuyqm3Pf2YrS++BcI9qAc5aeejeds=;
        b=nsxhePH/FatANoHhNcLwFtxlVJAiB8hMF6tHvD6CjmizjnHz3iMdKrnq4F28qELeis
         Xp6ElIAYyL4DmkS5TBypMa2Uh+QORfFpCx1evfPH4vYfibFaeaeTT7kbX54Jdwa6b9o3
         eGhHNUhCjqvyXmBj9FtkZThz8Q31ZuGtOv1mBBMjyYwxYC5CwWHVIyxfPAory52fAMJ/
         WJVw/XdUHpuqK6IsPdZh1dpkbcnfBUtPKwFEYEcMSCe6FgDsm9yyi3hjgA6I9er+QViu
         v5k3WfiY5WV9xdNfJI7S+GPXkjTRhuZQ3UryV6XTZZFvpveGDDFUVCodgPoJSw3It9iY
         wnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761376563; x=1761981363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svbY4zNoxF4qCqZuyqm3Pf2YrS++BcI9qAc5aeejeds=;
        b=A1b06aexI9ZN13aRMAf16+iRbewgSXxrKkU/p6+KlId1DHuE2zbkJAESMMr7ennB4s
         qYmU3fnd1mIEcaTIryUIb/uDtLIr9DzmbXp/oTI55+jy8kkRzQkzetmShvC+gSeQdgiS
         q22Byi4md4v+B4nOzU0RdR1w0NKH96H6x8PSPCA1p6nms0wgxNDEFOew9F6M17mXCazh
         GvFPLQmTarFiSnjGFv9JtMANZJ5L+juWGRqSZ15i9RnGNHcf5gvQLjUor/SLs2KHs5uS
         U6hrJUin3D7sprVH2mZfXW7yFE5mgVGJCmaGT5M1fkbCKfXCNxc4uutJg78ZYOFK7msq
         kJgA==
X-Forwarded-Encrypted: i=1; AJvYcCWitkDCrsM00y6eIblasld+S0Wx1ZZGd/4lNWfII9djNUE0TqbPgrXhSmmrCzjSqAXR+gHXMkAfCEAtdE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpM2WicMzT0YQ6X8aCpK8GXxo+joNXjsEP+UCQ6wLRPrQaC5m
	OaDjkf3SmCBNy+erWiYfh9FmHJSZxayuj5GAMY7hiVRaD0NxKjClPc+0PhMWXARo1j0nnIz+3OP
	crI0a8erPO6GOQHrhexZNFH76nkVAy3AH/aaE2i+U
X-Gm-Gg: ASbGncszPt1RdW49WnRPbObzvJ+rnyJ+NA//KoFZNFLiZFy0OBJhRrEjes5mDVYGc+L
	ldkvHPYru+fSxY5XQDEdC+7c5IStjtobF7jb/ePcj7MPqslcah93lk3Fe9M/Lf+xssp8XSeded0
	T96u6JrQJ4hovYBz5a686MSlUyys3FeEhDMHvHO0f2EONUAk+M8oijISNPC2N9StCQ9jiatSDeB
	g07wzUE4EbZJfOcLZV9Gqfpn8XC9N0g50K+kzlgqT7clJGJgxtmLe4Zty2gH8xYlB5WUrfqcvKE
	wtOeeejcJGyBy9XwjObKAB/xEw==
X-Google-Smtp-Source: AGHT+IFrWwE9daGcrnOfrKeIJ9mdYxb9a2TtdwZpEtwG5NORQI/kMcHd2F/VG7L16reRUqtaYYJKSGRr0DNq7pJl2L8=
X-Received: by 2002:a17:902:e80c:b0:290:2735:7285 with SMTP id
 d9443c01a7336-290cb278acamr426432255ad.47.1761376563027; Sat, 25 Oct 2025
 00:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUA_CqqUfoJb=NaQ7YnBUbW0UWQS4W++TXwRFekenkDM8Q@mail.gmail.com>
 <20251025064624.2972311-1-lizhi.xu@windriver.com>
In-Reply-To: <20251025064624.2972311-1-lizhi.xu@windriver.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 25 Oct 2025 00:15:51 -0700
X-Gm-Features: AS18NWD0aLvE28ntXYp7r9GroSd8L7O3b06gP8_GGwZZ_4MXTHaYRgFqmkW-eeM
Message-ID: <CAAVpQUAEBgTZF5GMvRgZybC0pHUuaN-4JBaff79L6AABNKSNWw@mail.gmail.com>
Subject: Re: [PATCH V3] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:46=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> =
wrote:
>
> On Fri, 24 Oct 2025 21:25:20 -0700, Kuniyuki Iwashima <kuniyu@google.com>=
 wrote:
> > On Fri, Oct 24, 2025 at 8:51 PM Lizhi Xu <lizhi.xu@windriver.com> wrote=
:
> > >
> > > On Fri, 24 Oct 2025 19:18:46 -0700, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> > > > On Fri, Oct 24, 2025 at 2:39 AM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
> > > > >
> > > > > There is no synchronization between the two timers, rose_t0timer_=
expiry
> > > > > and rose_timer_expiry.
> > > > > rose_timer_expiry() puts the neighbor when the rose state is ROSE=
_STATE_2.
> > > > > However, rose_t0timer_expiry() does initiate a restart request on=
 the
> > > > > neighbor.
> > > > > When rose_t0timer_expiry() accesses the released neighbor member =
digipeat,
> > > > > a UAF is triggered.
> > > > >
> > > > > To avoid this UAF, defer the put operation to rose_t0timer_expiry=
() and
> > > > > stop restarting t0timer after putting the neighbor.
> > > > >
> > > > > When putting the neighbor, set the neighbor to NULL. Setting neig=
hbor to
> > > > > NULL prevents rose_t0timer_expiry() from restarting t0timer.
> > > > >
> > > > > syzbot reported a slab-use-after-free Read in ax25_find_cb.
> > > > > BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/a=
x25/af_ax25.c:237
> > > > > Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> > > > > Call Trace:
> > > > >  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
> > > > >  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
> > > > >  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
> > > > >  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:1=
98
> > > > >  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
> > > > >
> > > > > Freed by task 17183:
> > > > >  kfree+0x2b8/0x6d0 mm/slub.c:6826
> > > > >  rose_neigh_put include/net/rose.h:165 [inline]
> > > > >  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
> > > > >
> > > > > Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_=
t")
> > > > > Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.co=
m
> > > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > > > ---
> > > > > V1 -> V2: Putting the neighbor stops t0timer from automatically s=
tarting
> > > > > V2 -> V3: add rose_neigh_putex for set rose neigh to NULL
> > > > >
> > > > >  include/net/rose.h   | 12 ++++++++++++
> > > > >  net/rose/rose_link.c |  5 +++++
> > > > >  2 files changed, 17 insertions(+)
> > > > >
> > > > > diff --git a/include/net/rose.h b/include/net/rose.h
> > > > > index 2b5491bbf39a..33de310ba778 100644
> > > > > --- a/include/net/rose.h
> > > > > +++ b/include/net/rose.h
> > > > > @@ -167,6 +167,18 @@ static inline void rose_neigh_put(struct ros=
e_neigh *rose_neigh)
> > > > >         }
> > > > >  }
> > > > >
> > > > > +static inline void rose_neigh_putex(struct rose_neigh **roseneig=
h)
> > > > > +{
> > > > > +       struct rose_neigh *rose_neigh =3D *roseneigh;
> > > > > +       if (refcount_dec_and_test(&rose_neigh->use)) {
> > > > > +               if (rose_neigh->ax25)
> > > > > +                       ax25_cb_put(rose_neigh->ax25);
> > > > > +               kfree(rose_neigh->digipeat);
> > > > > +               kfree(rose_neigh);
> > > > > +               *roseneigh =3D NULL;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  /* af_rose.c */
> > > > >  extern ax25_address rose_callsign;
> > > > >  extern int  sysctl_rose_restart_request_timeout;
> > > > > diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> > > > > index 7746229fdc8c..334c8cc0876d 100644
> > > > > --- a/net/rose/rose_link.c
> > > > > +++ b/net/rose/rose_link.c
> > > > > @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh=
)
> > > > >
> > > > >  static void rose_start_t0timer(struct rose_neigh *neigh)
> > > > >  {
> > > > > +       if (!neigh)
> > > > > +               return;
> > > > > +
> > > > >         timer_delete(&neigh->t0timer);
> > > > >
> > > > >         neigh->t0timer.function =3D rose_t0timer_expiry;
> > > > > @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_=
list *t)
> > > > >  {
> > > > >         struct rose_neigh *neigh =3D timer_container_of(neigh, t,=
 t0timer);
> > > > >
> > > >
> > > > What prevents rose_timer_expiry() from releasing the
> > > > last refcnt here ?
> > > The issue reported by syzbot is that rose_t0timer_expiry() is trigger=
ed
> > > first, followed by rose_timer_expiry().
> >
> > I don't see how you read that ordering from the report.
> > https://syzkaller.appspot.com/bug?extid=3Dcaa052a0958a9146870d
> Here's my understanding: See the two calltraces below.

The same question still applies.

What prevents rose_timer_expiry() from releasing the last
refcnt before [1] ?

For example, why is accessing neigh->dev in rose_send_frame()
safe then ?

The commit message mentions that two timers are not
synchronised, but the diff adds no such synchronisation.


> [1] Line 111 occurs after rose_neigh_put(). Otherwise, accessing
> neigh->digipeat would result in a UAF. Therefore, rose_t0timer_expiry()
> must be triggered before rose_timer_expiry().
>
> [2] syzbot reports that line 237 generates a UAF when accessing digi->ndi=
gi.
>
> UAF Task1:
> rose_t0timer_expiry()->
>   rose_transmit_restart_request()->
>     rose_send_frame(.., neigh->digipeat, ..)-> // [1] line 111
>       ax25_find_cb()->
>         if (digi !=3D NULL && digi->ndigi !=3D 0)  // [2] line 237
>
> Freed neigh Task2:
>  rose_timer_expiry()->
>    rose_neigh_put(neigh)->
>      kfree(neigh)
> >
> > The only ordering I can find is that kfree() in rose_timer_expiry()
> > happened before ax25_find_cb () in rose_t0timer_expiry().
> >
> > > Therefore, in rose_t0timer_expiry(), the reference count of neigh is
> > > increased before entering rose_transmit_restart_request() to prevent
> > > neigh from being put in rose_timer_expiry(). Then, in rose_t0timer_ex=
piry(),
> > > neigh is put before executing rose_start_t0timer() and the neigh valu=
e is
> > > set to NULL to prevent t0timer restarts.
> > >
> > > The case where rose_timer_expiry() is triggered before rose_t0timer_e=
xpiry()
> > > is not considered at this time.
> >
> > So this change just papers over the root cause.
> >
> >
> > > >
> > > > The t0timer could be triggered even after that happens.
> > > >
> > > >
> > > > > +       rose_neigh_hold(neigh);
> > > > >         rose_transmit_restart_request(neigh);
> > > > >
> > > > >         neigh->dce_mode =3D 0;
> > > > >
> > > > > +       rose_neigh_putex(&neigh);
> > > > >         rose_start_t0timer(neigh);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >

