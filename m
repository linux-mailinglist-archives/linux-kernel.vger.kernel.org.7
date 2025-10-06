Return-Path: <linux-kernel+bounces-842524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137BBBCEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BCC3B2C1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BD1A238F;
	Mon,  6 Oct 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN7+/dor"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434B79CD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759713420; cv=none; b=Kro8E/J2F1xc2SkT6en6pFJEHzbybaEKhinQMRfoaAENk63bMaSTMuQvGauIpPV0XKUBf7JlQa6VHpaTEmqtU0Kox7hm1jUM4YU/OKAU9okhedgksw0JaMobKeRFfm+KSIAuMTwCicy1PnMUGfsqxRpCsL/BSiWBzFxoRuoJGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759713420; c=relaxed/simple;
	bh=0UGJqdPjjCSY04L6+CBMhmuXVEBK1Sf1gwPF3gCekqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUIZDjzsk099XUt0ARUd+fGTb52TTlcE4qPd8H5VgwzPRZ3PDmSU9WOrYuYN6I0PDcKIo26VVbAypcK136I9L9IDvRYzGgKdYXdSAYLLGMspTu4FmiBrHStrDqStYdJ3c7RmWpvt5APggwMTEb4fki/v/NWed/fP3M4bgr+ooMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN7+/dor; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so764625366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 18:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759713416; x=1760318216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbC1EOPE95OwfWLT6nyxetzcSIKUAu0yCntrWn74xYs=;
        b=EN7+/dor6Zz+YDCMvkpkxQuXNnZA4VzY3+Jmj10izNyWgh8idoIE4ia+flBqQEpgt4
         aNKK2Mq+ackEhZ7drG+ab4/iMKeuiHmfpH9j1qsfJ537yRegXOOnX6k00FGxkLO/hBQo
         3j1OHUB8GVTCPoNtytggr0ZJvkd3EgbWDii3hV5umzm3DnBP0YHhkc+AEjQclqwvB/lc
         UXdwObSqwvGFWpH6EoasPDI2DBNlqKiAsXQeZ1sPDHlwCf3gLcKkdfUye4j6qf4OLtP8
         pTHVFTHKlIsUMWqjF4i2b2154RGvIPZdPQmEFZiOXMP/5KGN96waoRxYLJcAtp3vU4ej
         IbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759713416; x=1760318216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbC1EOPE95OwfWLT6nyxetzcSIKUAu0yCntrWn74xYs=;
        b=MLCamKQp/ueoaiY80MyTzMAPBQ90nTkQlrRN8nZZjSmS0Pmv/e0ieCWI9Qh8MVPLQ3
         G1/vG5wu3H6AzaItW3T1tL4O7i2rGXKe1WgoGteT5l7lZaQ1dgKthXzaVz+yi+p2ET1Y
         I7TUdXfVisVbDIFWgdywsxG/iHELUj5yIt/9oNMqcamMqx+tmw/LETf3OMYh7qZ1aqPx
         JQsBnG5vsPK/nUjkJDWgg13FKN259AsowUHcDkKbQL6RJ0BvHQhToUzl7s/lCr/33NE9
         az9vpcqINk9TejCbuFss7La5VM5yL0Qe+sguUYPa7nqdWSwd4rTWmCHbG44YRWpueVg4
         MAdg==
X-Forwarded-Encrypted: i=1; AJvYcCUeYVs4kF0d7xViK0vH0v2HjqHbgexTDr6YWGDJbwtEHJiJqKoZB9FVlmH5i2YEIgg+df/61DOxo/xBZl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rA38xha5k7h7DRsXvRmd3qnWNddIX5b1pLYnoKBRUjLWl4KT
	SfcgMgBUwr5eNW6x0UvEgOzVqrMaJdfzqDI5GHPkKU1VJmJdCP74xVe1rd5Q5+MQVF70SvjjwKW
	vGMlYaFFFsb810R4Gwb9UuqxOk5+a7Rc=
X-Gm-Gg: ASbGncux/iS7tfIeDsWlqq9CooBnIOG1lDDMTTJvw4TmIgMoT36U/MxyfGIQdGIe5sm
	1vWC9dABwiwfhPi1hdXLEijDUlt8qRzHRRuib+i00KIJvS6LRkxs6FbjTSf3dOi4ylTL7/FoQ+m
	dZ30YPelDzqlBBndtiykdQofC7MbyTyeZ4zKl/fkBeW4JlG030OVJF2BFNGji+6SJfg+h1y3+xb
	5sETpSDmTT8IJUckrq6cfPuDwBUtuEpSvXsc1kP3hezWA/naGhTFV5LAkPriR/RX83omZ9Amw==
X-Google-Smtp-Source: AGHT+IEN51PEeSTCF3pWahfeOfpD9DykFpJzQEp+le9DBdwXfyV2kiw7brjPn8wm9xu5wGh5W76O7auORpiPFFlU+5Y=
X-Received: by 2002:a17:907:1c84:b0:b3b:78a7:6220 with SMTP id
 a640c23a62f3a-b49c4296104mr1414678266b.55.1759713416142; Sun, 05 Oct 2025
 18:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005231526.708061-1-mjguzik@gmail.com> <20251006005642.8194-1-hdanton@sina.com>
In-Reply-To: <20251006005642.8194-1-hdanton@sina.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 03:16:43 +0200
X-Gm-Features: AS18NWBfwgOLHulFdJnl7zfAPTI5kQEdChxeEzyE56yQDRW-IlZ1BRNNakFCakE
Message-ID: <CAGudoHFi-9qYPnb9xPtGsUq+Mf_8h+uk4iQDo1TggZYPgTv6fA@mail.gmail.com>
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
To: Hillf Danton <hdanton@sina.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:57=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Mon,  6 Oct 2025 01:15:26 +0200 Mateusz Guzik wrote:
> > Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> > and unlock_new_inode().
> >
> > In principle the latter can clear the I_NEW flag before prior stores
> > into the inode were made visible.
> >
> Given difficulty following up here, could you specify why the current
> mem barrier [1] in unlock_new_inode() is not enough?
>

That fence synchronizes against threads which went to sleep.

In the example I'm providing this did not happen.

  193 static inline void wait_on_inode(struct inode *inode)
  194 {
  195         wait_var_event(inode_state_wait_address(inode, __I_NEW),
  196                       !(READ_ONCE(inode->i_state) & I_NEW));

  303 #define wait_var_event(var, condition)                               =
   \
  304 do {                                                                 =
   \
  305         might_sleep();                                               =
   \
  306         if (condition)                                               =
   \
  307                 break;                                               =
   \

I_NEW is tested here without any locks or fences.

  308         __wait_var_event(var, condition);                            =
   \
  309 } while (0)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/inode.c#n1190
>
> > The former can in turn observe I_NEW is cleared and proceed to use the
> > inode, while possibly reading from not-yet-published areas.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > I don't think this is a serious bug in the sense I doubt anyone ever ra=
n
> > into it, but this is an issue on paper.
> >
> > I'm doing some changes in the area and I figured I'll get this bit out
> > of the way.
> >
> >  fs/dcache.c               | 4 ++++
> >  fs/inode.c                | 8 ++++++++
> >  include/linux/writeback.h | 4 ++++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index a067fa0a965a..806d6a665124 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, str=
uct inode *inode)
> >       spin_lock(&inode->i_lock);
> >       __d_instantiate(entry, inode);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW & ~I_CREATING;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > diff --git a/fs/inode.c b/fs/inode.c
> > index ec9339024ac3..842ee973c8b6 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
> >       lockdep_annotate_inode_mutex_key(inode);
> >       spin_lock(&inode->i_lock);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW & ~I_CREATING;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > @@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
> >       lockdep_annotate_inode_mutex_key(inode);
> >       spin_lock(&inode->i_lock);
> >       WARN_ON(!(inode->i_state & I_NEW));
> > +     /*
> > +      * Pairs with smp_rmb in wait_on_inode().
> > +      */
> > +     smp_wmb();
> >       inode->i_state &=3D ~I_NEW;
> >       /*
> >        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 22dd4adc5667..e1e1231a6830 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *ino=
de)
> >  {
> >       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> >                      !(READ_ONCE(inode->i_state) & I_NEW));
> > +     /*
> > +      * Pairs with routines clearing I_NEW.
> > +      */
> > +     smp_rmb();
> >  }
>
> Why is this needed as nobody cares I_NEW after wait?
>
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > --
> > 2.34.1

