Return-Path: <linux-kernel+bounces-815978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D599B56DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E674188AD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF421EEA5D;
	Mon, 15 Sep 2025 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iavoOrCx"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E486344
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899800; cv=none; b=RC0wSaX2o3Mqi/TKIwSHE9M7PuJAUba6V2Vwyp0VOOTn7dS2wmETJ4S0NiZb2oT7kfMGs768AE9y9Vas2airzeGFlIFiDQEi4y4OuJvW09NUtHlC1g2iUyvcKSXpCBS7WpRy23oR3VsoDWVUc431XkAotlvYtDLhj1FXHJuu1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899800; c=relaxed/simple;
	bh=SIBmZjwUZmHYLCPrr5ugVC8w/l9Y79OesJDCx58t09g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdbwcwLNHhGvG9gHkDdtgZowecJWsTiogZxarQCGA+wyMAT8bHXX2Ko9RXRfEZjQcYo49HxtOJvGOdmGSM6EICeUqLEp3R2tOgk/Kf58XV66HqVbzpeGqwHbH9dtylUbzsI25xWASl+lb/43PvqNsxyVjlowi1IWl7KE6WxcLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iavoOrCx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07d4d24d09so369594766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757899797; x=1758504597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u0GU9zpunlYgDR7KLSIVG3HwW3hCg8jpufLwB7anXs=;
        b=iavoOrCx7SA3bIeMBrkXgiQIhAAjQsSjSOBLqC3sUBmkn5TsNcbshzBb4ntXV4IV2Z
         vqO7QYceMfinwtJNwoDCmMouWTlrKT3U/o1yCld0lNNX0u/NDD0giCj03aCkTxTf66ev
         KZhflPUQkxh6tX1I4Ro94jJUFwiT4a0ctVVkZLHTbSLMpHOcDloyn7PlACobMAzF9i6Z
         76s/8u6CvXiLyxvub/PtfmdBrGX3GwrBb77vz6ibJ+luMI61RMqRdn6SfIUFEtZ6nfSI
         qM/US+X2oTfaXP5sHxHqQ0uPOa3ofAhVmgva6YWJBTMeKRoJqubKRAzyIYWz3LyS70Tg
         +iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899797; x=1758504597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u0GU9zpunlYgDR7KLSIVG3HwW3hCg8jpufLwB7anXs=;
        b=o+Kd53Pk/bUcb7DRuFgqH6d4WcCmZEql/4ffe3po9/LHiTwCOymaX1jwEiawLyfBiU
         dR6nHsqPWw2OSfS+OZCtOjOo4FrcCc+vHvXHMxhHFbm6NnoismAS+TlHBSVISle9G4zj
         o4OlPl+Dp42z1mJ06onkATQ8ZRMCM+fFnzbkLYYUavSYYocmILgpRoVmkJ+1t8CdAx8p
         ILHeajiIGq+4SVZjRpG4ROL7JKaQCkFFikR8KpxfuytffOoI1v56Uem+Kn1F51LQIHUi
         Faz8qYWJK0EKW8qLabxxDYgB3IROZPBPos5PEWuZdifkxgM/8ZAJOUEnsdqZs65PGDQK
         f9jg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSxrSAqtK6dhtVy9aOLqVJRDAyM4EPfv6vbGwDQ+SYBCipxriAVXsHmajQCZVNIuLq/gB2/KGco5VOyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFtO92Fp4zndYiOD2AXjnurw3ejY2OQaPHObIFUlA/gIZcx2H
	0t9TuKan/1BXPML3OApwAdsdVWEbRkbUXj3guB9lpmQmqZmfENFSEnY+nTxmzTq0eZum9zvn88+
	Leoy4Tpt5t03ap+fbEya9AjHeeR6QEzM=
X-Gm-Gg: ASbGncs6Z6YMS5x6g8g0Mb/2cRusV/G+ci/L1xrZx97e36W9I2z5OnmCME7MUr+LWnK
	1OfC40aKI1rX9iPH3a1GeBhIlnSr4FSGtvZ7M43cvRN9ukRBpdX1unquK/79KUY2sojQcP5lHBz
	TNQyODqr6Rc6uAT9ZccaNqO8WRXE2OTEUW6mOVzuwMjYZmX9JqE4f7qUfdyr9itHrIZZlhNFI5U
	+tUMyt51pdDbCiab70=
X-Google-Smtp-Source: AGHT+IEovASZ6fHgId2z3DKDfRSZlBXyJ/uL8tWcwiJjc9GP8x6Z+l6WaYSQr9gZrBIzuPBJFeIy3E0+IvPt2BevcDM=
X-Received: by 2002:a17:906:fe04:b0:af9:29c1:1103 with SMTP id
 a640c23a62f3a-b07c3a7be9fmr1016371466b.55.1757899796907; Sun, 14 Sep 2025
 18:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com> <20250912213531.7-YeRBeD@linutronix.de>
 <20250913080018.7032-1-hdanton@sina.com> <10adb9b7-ea19-407b-818e-79061a067e13@redhat.com>
 <7cdb6f45-de42-4139-a050-b318a69ad86d@paulmck-laptop>
In-Reply-To: <7cdb6f45-de42-4139-a050-b318a69ad86d@paulmck-laptop>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 15 Sep 2025 09:29:44 +0800
X-Gm-Features: Ac12FXzc2J3H8PIjkQiX7PMWUJiBI9s_F4OKqcHcd-y_NGfPWwAlLDUchnIoAQg
Message-ID: <CAErzpms5jFyRq_biXrLXW=QwCkCVL7QC5B2rHorm6CAsieBf_A@mail.gmail.com>
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: paulmck@kernel.org
Cc: Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 6:05=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Sep 13, 2025 at 01:23:03PM -0400, Waiman Long wrote:
> > On 9/13/25 4:00 AM, Hillf Danton wrote:
> > > On Fri, 12 Sep 2025 20:33:31 -0400 Waiman Long wrote:
> > > > On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> > > > > On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
> > > > > > On 9/12/25 2:50 AM, pengdonglin wrote:
> > > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > >
> > > > > > > When CONFIG_PREEMPT_RT is disabled, spin_lock*()
> > > > > > > operations implicitly
> > > > > > > disable preemption, which provides RCU read-side protection. =
When
> > > > > > > CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations in=
ternally
> > > > > > > manage RCU read-side critical sections.
> > > > > > I have some doubt about your claim that disabling preemption
> > > > > > provides RCU
> > > > > > read-side protection. It is true for some flavors but
> > > > > > probably not all. I do
> > > > > > know that disabling interrupt will provide RCU read-side
> > > > > > protection. So for
> > > > > > spin_lock_irq*() calls, that is valid. I am not sure about
> > > > > > spin_lock_bh(),
> > > > > > maybe it applies there too. we need some RCU people to confirm.
> > > > > The claim is valid since Paul merged the three flavours we had. B=
efore
> > > > > that preempt_disable() (and disabling irqs) would match
> > > > > rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() wer=
e
> > > > > different in terms of grace period and clean up.
> > > > > So _now_ we could remove it if it makes things easier.
> > > >
> > > > Thanks for the clarification.
> > > >
> > > > In this case, I think the patch description should mention the
> > > > commit that unify the 3 RCU flavors to make sure that this patch
> > > > won't be accidentally backport'ed to an older kernel without the
> > > > necessary prerequisite commit(s).
> > >
> > > This change also affects the dereference helpers.
> > >
> > > #define rcu_dereference_check(p, c) \
> > >     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> > >                 (c) || rcu_read_lock_held(), __rcu)
> > >
> > Right, this macro will need to be updated as well to avoid false positi=
ve if
> > we decide that preempt_disabled region is a valid rcu_read_lock critica=
l
> > section.
>
> I suggest that you instead use the new rcu_dereference_all_check()
> that Herbert Xu (added on CC) has put together here:
>
> https://lore.kernel.org/all/aLlflTV_SDwMB7mq@gondor.apana.org.au/
>
> This way, people wanting rcu_read_lock() and nothing else can continue
> using rcu_dereference_check() and you can use rcu_dereference_all_check()
> that takes rcu_read_lock() along all any other types of RCU readers.
>

Thanks for the feedback. I will send a v2.

>                                                         Thanx, Paul

