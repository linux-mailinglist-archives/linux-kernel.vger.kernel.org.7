Return-Path: <linux-kernel+bounces-722493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8DAFDB49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704463A8369
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E922331C;
	Tue,  8 Jul 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xkNnuUkT"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF01B4257
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014723; cv=none; b=RfAVwK0BF112C0hoJTH6oNjNtvM1azXJV7wFTzjVxYcC91zyrSzb+TnSctt6I8QNfySxnqBOw7xabjBxGGryVTdEGJITTwMU0Y8ROSkpvPsQYWAlh6IfKN57LoOWgHPGT6h4tMd5yVh1R2tK2548jh4aeGxplJJzpFDRL1sfafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014723; c=relaxed/simple;
	bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HekqSQMw8bimy6vmSchXGd3vkw2fcxtfGhTVDx08ZBFg4Bw1GoaMJWUms7Higp623C4vcFnuckYvwhzq4zs3j0i3St+gM2TcJZKyfxOkjs9xu5gtW9vZBJtkCXMhIjdIpkbODu41FVEfdy3n2WWHmdVVrpI1n9hiiaeY/jQnLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xkNnuUkT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d3f1bd7121so504941685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752014721; x=1752619521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
        b=xkNnuUkTSXSlowD2leQObTIC1+bFD0PFYh9R8ADTAi145U8QDNadtsCX/TaHiHO69m
         5A5Hehd842y5vwT3qRni+I9xFWM8D+14keEOyfdv7yrNTuSTBIrR3I+Zemj+9MkMcrC/
         vAOtGf14ZaR9VR0f1/gU5+qqVr8tNU8bN/PtflQd5NU61a8WoP8HaNqLkaUow5pKLPf7
         QKPRTgVTwkELPJonndXix/dWgudjoBfR9GAe+bp1c4vwRqycFwqpA/1DUfZtexwOiKHN
         lYvacY0Z+zDdXjYF7lncqOeOj93FzNINAZtlNl7KEUDvudmrI9kC2rZZ2igpFdtPTPUs
         UHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014721; x=1752619521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJwTjYDiDL5so0q+7rAas2zAmmOieSLdwGqq254e0BY=;
        b=qaK8hESy5qFH3of/3wlR4kH+Ku9CP1Ap3QH21v4s5JpA0XrWbVLIkTSyJ09G1Y1qOo
         tzebGSGyNw+/Mh8cIO/+ksQBxaOt2GWeWTAKghJZ1NMiz0hp1JHEyBf77baR58bnA+Dk
         WurtU/b8OYw6yliXlf0c83LMH85KnQYn5XPHGch8RJGPbTLOS69qevN5mQLgY0ChUgF7
         U63rg0Xo8xcvofanrK4xwuhRDGkGHDnHCosAtNNrp3IzG/TyAVQ5GVq7wn0PbweYEcpi
         heQQexhKDzRkpZueO7DSCx1RRba0eoH/3UO63MC4q6/myqZ/iUek+sIUz44ISz+PqoQl
         u+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXfDtdOzjTOACfOcR86VhjDNHy6rC/T+nFyui2jQL9QDYimp3v2Vk8e32ze9LWYz3m5dYRvCWiaMKNhM3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVEqeBfYHNFf0XO48TqcrZs9ZH0UymudKRY3qyeQOS4UPvwTM
	0q8sacYWKXYi03J8lKnpZf4CiZbQQ6IMM3LqvQrhuTjnoIZqfPLMkPw+KRr0ueHEalA=
X-Gm-Gg: ASbGnctFWO/ibzrorNgZ6y3pVfjZcN/kfbkPyxmNZIW/fyax2KstKQesc8UFgXdk0aZ
	7aJK8+EVkL7dK4CGmBcc3MVll0NmHBTT5dbYkVtd6sqzyX97fUTtEztQrm+WNifV/Qp4axZgVnO
	jdDxveud/ddExD6eh9Z42/hh6PByQfizi2jW/2bBmx929AEeTts1k1gKU5wZftStYFahK+ZHo6s
	wIwv0YdHEgp11hZk3VXRpKNsnnDeLJmFdwj0qvI672QMHznmn4cy3oolGJsB/H2ZeGb5YWC4m6z
	BKHKNYAywlJhSLgNEKG5UAYBUVDMi5uTKIjBRAmn8wAzASAOn64Rljtc6TG1tI6uaGVUbKxt1xC
	P/TbmxIEH/FzWIPZIRB7uQ4FUc0N5Rb3Xpvog8NY=
X-Google-Smtp-Source: AGHT+IGaSttCcjmFBXaIxysGtD3+QOBaV/hmFGxA9/T2lYKyhnz52dWB4G9cv/PM5KVkkeqmFpNNpA==
X-Received: by 2002:a05:620a:2602:b0:7d4:5cea:83a3 with SMTP id af79cd13be357-7db7e34eabdmr79423285a.34.1752014715845;
        Tue, 08 Jul 2025 15:45:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdc4623sm842482285a.50.2025.07.08.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:45:15 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:45:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>,
 netdev@vger.kernel.org, victor@mojatatu.com, pctammela@mojatatu.com,
 pabeni@redhat.com, kuba@kernel.org, dcaratti@redhat.com,
 savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org
Subject: Re: This breaks netem use cases
Message-ID: <20250708154511.58862605@hermes.local>
In-Reply-To: <CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
References: <20250708164141.875402-1-will@willsroot.io>
	<aG10rqwjX6elG1Gx@pop-os.localdomain>
	<CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>
	<aG2OUoDD2m5MqdSz@pop-os.localdomain>
	<CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 18:26:28 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Tue, Jul 8, 2025 at 5:32=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
> >
> > (Cc Linus Torvalds)
> >
> > On Tue, Jul 08, 2025 at 04:35:37PM -0400, Jamal Hadi Salim wrote: =20
> > > On Tue, Jul 8, 2025 at 3:42=E2=80=AFPM Cong Wang <xiyou.wangcong@gmai=
l.com> wrote: =20
> > > >
> > > > (Cc LKML for more audience, since this clearly breaks potentially u=
seful
> > > > use cases)
> > > >
> > > > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote: =20
> > > > > netem_enqueue's duplication prevention logic breaks when a netem
> > > > > resides in a qdisc tree with other netems - this can lead to a
> > > > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > > > Ensure that a duplicating netem cannot exist in a tree with other
> > > > > netems. =20
> > > >
> > > > As I already warned in your previous patchset, this breaks the foll=
owing
> > > > potentially useful use case:
> > > >
> > > > sudo tc qdisc add dev eth0 root handle 1: mq
> > > > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 10=
0%
> > > > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 10=
0%
> > > >
> > > > I don't see any logical problem of such use case, therefore we shou=
ld
> > > > consider it as valid, we can't break it.
> > > > =20
> > >
> > > I thought we are trying to provide an intermediate solution to plug an
> > > existing hole and come up with a longer term solution. =20
> >
> > Breaking valid use cases even for a short period is still no way to go.
> > Sorry, Jamal. Since I can't convince you, please ask Linus.
> >
> > Also, I don't see you have proposed any long term solution. If you
> > really have one, please state it clearly and provide a clear timeline to
> > users.
> > =20
>=20
> I explained my approach a few times: We need to come up with a long
> term solution that looks at the sanity of hierarchies.
> Equivalent to init/change()
> Today we only look at netlink requests for a specific qdisc. The new
> approach (possibly an ops) will also look at the sanity of configs in
> relation to hierarchies.
> You can work on it or come with an alternative proposal.
> That is not the scope of this discussion though
>=20
> > > If there are users of such a "potential setup" you show above we are
> > > going to find out very quickly. =20
> >
> > Please read the above specific example. It is more than just valid, it
> > is very reasonable, installing netem for each queue is the right way of
> > using netem duplication to avoid the global root spinlock in a multique=
ue
> > setup.
> > =20
>=20
> In all my years working on tc I have never seen _anyone_ using
> duplication where netem is _not the root qdisc_. And i have done a lot
> of "support" in this area.
> You can craft any example you want but it needs to be practical - I
> dont see the practicality in your example.
> Just because we allow arbitrary crafting of hierarchies doesnt mean
> they are correct.
> The choice is between complicating things to fix a "potential" corner
> use case vs simplicity (especially of a short term approach that is
> intended to be obsoleted in the long term).

One of my initial examples was to use HTB and netem.
Where each class got a different loss rate etc.
But duplication is usually link wide.

