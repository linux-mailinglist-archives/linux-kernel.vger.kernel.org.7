Return-Path: <linux-kernel+bounces-767298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A7B2528E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCEF1886E52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76699288CB6;
	Wed, 13 Aug 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6CTcWZ5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C23F9C5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107575; cv=none; b=PzKyeuS/bt5jrChYmVhbVlaIG8UHpOw4ZYci3DvxM7dixkz9Lu8z42v5+c1Mz/Eld0kbZAXmo6o/A5Hs9uMG8qeMTVveIs2wSBpezQVTDFKIViTzgcx3I+zjWY8+CfriTLMdxVSHgB0WJb5sKSncdbIgX8ogX9SUWXc3bPeZQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107575; c=relaxed/simple;
	bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eluqZ0EPQ3gI0RTx70zA1lHAl9hkUQ2uzVZUmtCVEeOZ7HYGp5A6evva4Zkxt51+Ip2AVD9NW5DZe8Yx70s1Denr2kYanRQkp8B1VUYklReJjGLt23WMkQsgwoW/kn0r3PwmL7WtyZj6aLNbIOr3be65W7+gERq4XNPV7KI9XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6CTcWZ5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f53d2eso528315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755107574; x=1755712374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
        b=K6CTcWZ58DID4h9eXIOH7nhraN2XB4Jh/MmZyisFsqiw6koR0hUenhg42sdoo5anUH
         m3vAiA3xLvjuiZJJ/FwF0Gb3+mNrwDF0YLwi1fnY0Z1ytT8okF+kFWZ8ke1UT1XfsrJW
         UI7QdyvfImq9r+Z9rWHAP2y/wgof3OA70nPmslFujwLBj1Oh399/E5Sfs9zwSnjJrE65
         4frrqaHz4q4xXoSxNH5lr7dRk3fskvUqQymYoN+/Tm1MnqfkoK/AJ0xU8Cr2DUa4TK6D
         /btOISbm9lYQ2YTF+sXM2k4hX9DkjixeMcXqLrtct5fz0JGKXQOi8g+7yJzORj2fO25T
         Qnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107574; x=1755712374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji78IdZNhw+tyn0C82W+5KGqdcZryFZ+BRRkAmDMhWs=;
        b=q6JoEmBgAEnGmImbjLZiIk45F6+6jbBc13OUBw+HCCmdne+74lZavYLWZ4z3R6Qe3H
         MKWJGCP0ZEXB1hItu06heaNeYkCf0XySP1X9I4iprGMTMoj0HPbg46HuiZTj0s+bGyhm
         CUJ3qa8Miw2+GuE42Y5PwNyckiIBBC0eo3VQQAa41O/drTuN4WbwmHHtwwo04QlI29Wr
         AQtoOwbVNcT4NIOmChgTqKBluxELCPRx5pWuA7At1a+yod0Io+UWnCuME0YysYvrTdvG
         AA4S6C0R0RrPi3NN7jFIDpHf816NJy610xjTy93qZtfdjgmIyKkTXrzWGtzXqwdfPR6H
         4Udw==
X-Forwarded-Encrypted: i=1; AJvYcCW6AHPFpvLPBlFGHIanzttU6NMmF2geHgRkOF62HGCly4Pu1WGaHwkSeoNn8atl2oTI1Z9gSBgwQTIS0wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHkIf22c2+hcvUNwWm8ileJs1NCsbOueXY4Iqh1xIIdSJGiEE
	DmN1wPjokU1BrkVZVwOyugvJLzV10Grqjy+aFDKaFoiWRlpp9KZ5oq/+Fy2fiW2R97iTU2gpaHg
	aQOHPuNZXhCYTFXXPqRgtRl1CFrFoEKQlYIOnCoTK
X-Gm-Gg: ASbGncu2Ujw6NMw7KHwB54KepFS7R5+yD0X7XSIBiG1KBuqH7tEq2mYFWEmrVLEUEZm
	LeeEboQz9Z17O4/izsGvyO3QJcR+bWc+Z0BXm3vIJTdjg8kJbek51jkWXEOboFarPTeSlYWP9nZ
	pfT+nQ+PVzS7CHs35K1cqyUM5IyZzMihmH5w1Nbasny1k4vGkRJZW842iTNcuB9tUSQfLEiF0D1
	oUPuQ2JtiMVgFfiWEH9O4iOK24c5BBXpBjP9PkM
X-Google-Smtp-Source: AGHT+IEjHmDo4KPuA+/sveZn9muwONSBB7vRZtalH5GKSOG3QX576o8Vh9ZDPiB6/QNN0tvmAzFaIqy1EEDsLN+ydVk=
X-Received: by 2002:a17:903:2443:b0:240:4faa:75cd with SMTP id
 d9443c01a7336-2430d1f76f0mr60472055ad.48.1755107573058; Wed, 13 Aug 2025
 10:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
 <20250802092435.288714-2-dongml2@chinatelecom.cn> <CAL+tcoA9Lvc4Cj9zjWVx1FzEQA=d=OnvZRDWA4nE_1GNbEDaRw@mail.gmail.com>
 <CADxym3bD17eL0U0sQkuSZZgNtg7gmvzt0YAA+CiHf9Lw5-+awA@mail.gmail.com>
 <CAL+tcoD80feEhPA_1L7D55UqkRuLSnZ-Kmmdab5J2v9K6uCzTA@mail.gmail.com>
 <CADxym3Zv9+6D0hCEx1KzvW+oAQW5oEDgSHBQPyRjHodezH9O1g@mail.gmail.com>
 <CAL+tcoCCq8Hc3R0_75wZxHUiZrjhfS-q65XFWM69F8pcoJPdyw@mail.gmail.com> <CADxym3bBVEKRNa790CchSyH-WPeXmv9tjTxtmYyJamQv357zKg@mail.gmail.com>
In-Reply-To: <CADxym3bBVEKRNa790CchSyH-WPeXmv9tjTxtmYyJamQv357zKg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 10:52:41 -0700
X-Gm-Features: Ac12FXyx4ErcNKN46eBhzoLzd9zfhqbd1nW9uycrOSGUwjzqL5UmxD07HY05yoA
Message-ID: <CAAVpQUC-bPPar5Q-AoW_sZYrRfLF9Q7Su+163EfmYCBOjqohAA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, kraig@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:55=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Sun, Aug 3, 2025 at 4:32=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sun, Aug 3, 2025 at 12:00=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Sun, Aug 3, 2025 at 10:54=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Sun, Aug 3, 2025 at 9:59=E2=80=AFAM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > > >
> > > > > On Sat, Aug 2, 2025 at 9:06=E2=80=AFPM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > > >
> [......]
> > > >
> > > > I'm trying to picture what the usage can be in the userland as you
> > > > pointed out in the MD5 case. As to the client side, it seems weird
> > > > since it cannot detect and know the priority of the other side wher=
e a
> > > > few sockets listen on the same address and port.
> > >
> > > For the server side, it needs to add all the clients information
> > > with the TCP_MD5SIG option. For socket1 that binded on the
> > > eth0, it will add all the client addresses that come from eth0 to the
> > > socket1 with TCP_MD5SIG. So the server knows the clients.
> >
> > Right, but I meant the _client_ side doesn't know the details of the
> > other side, that is to say, the server side needs to keep sure the
> > client server easily connects to your preferred listener regardless of
> > what the selection algorithm looks like. In terms of what you
> > depicted, I see your point. One question is if the kernel or API
> > provides any rules and instructions to the users that on the server
> > side the sk1 must be selected in your case? Is it possible for other
> > cases where the sk2 is the preferable/ideal one? I'm not sure if it's
> > worth 'fixing' it in the kernel.
>
> What does sk2 represent here? I don't think that the sk2 should
> be preferable. For now, it is selected by the creating order, and
> there should not be a case that relies on the socket creation
> order......would it?
>
> So the socket should be selected by priority, and sk1, which is binded
> on eth0, has higher priority, which is awarded by the users.
>
> I noticed that the net-next is open, so we can use Kuniyuki's
> solution instead, which is better for the performance ;)

I'll post a series next week when Eric is back.

