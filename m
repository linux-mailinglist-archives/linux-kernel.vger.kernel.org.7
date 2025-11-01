Return-Path: <linux-kernel+bounces-881213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3922C27BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BAD3AAB2C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90752D0606;
	Sat,  1 Nov 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTDvP6vd"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379A22332E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761993146; cv=none; b=SAXGXT1FcUx4zFvO9wkpZ7BES+7f1xWS3reMoyZr/Ey2oQ5LdYtsVLawD+FXcpMlttnnWY4sfyQByXDJiPAX0m/4Duoi8gZcF0BikJ20ovPYzGxfKqURQBiq6aDhbMJAS9l9BcSP5ykJZDvrxs0TsW3tVaN7f090n6FujIPKpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761993146; c=relaxed/simple;
	bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGxZ9DnoWoewLlHoK2dHddu7IEC3dJ6/9usoD6Ztm5ZrDOuSrR5AoS2kCdsg01m1yyQ2a/9CRrNtmsoXAdNrco4A0ANtROh7GTeMFYxmtRwWgNyPKVyHVxUJ7Zwy7oMbA25XjFh4omETZS6EBqihybGKYlka5P4U10GNHd7dlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTDvP6vd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcab6fso30656327b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761993144; x=1762597944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
        b=HTDvP6vdVU8kcVnbzwHDne38aBP8Ech07+/JrG6AtwYp+OBxqBAIFinQ7lQ5w96GWv
         DudLlkwR8Ba3gpwTQUZMScGPhxOPDsHXnXgspszaEQagiTV4i+HeOSQmGJSHRlu8RSiH
         AZ4Ni+JGTp4E46mppmMQdpZ3/tfDRoItuJQ2sJdTwoRgcNlZpPkCG0QaV0zMMafsmkTq
         RUrkWTuMixC9rBwnEaanfTMSUOciASChFFDzdtKHCS8OotkZGScaKyO2CepygMqvtw4z
         X7Ycvs8JKWtpIc9+Gbt24fxrXURhG/qanhxkmX3yYbEFJXAqOaiM5mF+AzfpBeIK6rM4
         l0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761993144; x=1762597944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW6qcg1RDligTQyOy0VygB5sP9HaChJrDCwpOTpDTJU=;
        b=g3eEAW7MLWBk302kJM+gxvj13JLqguYeHtdKtdPrEEd/d2d8seIo/BWeMR7KHh0pqd
         fgun2nawJmotQ4YynTkPDX10VfedQVWRzBP0Jd2PkBuavb+xocLnRAsTP/ldEX85nxO4
         x89lVBd1iPol8iERRdvBhdGYsSO2rmvSdDROGT/3eylH9NQptMpn/1Jzkvf+movGyNmr
         i1yvxyCxIEvhyB4pTdhGMty0WeJEHXvy9hk+ZcKGM+qp3v+xpq3uP8QXY3SdM42SzQRz
         goHwY2CttkNgnt/wCcxkTHGyBVR9io6fMlt339ttyojSYrg5NtscRF093gNwMDQr0wxM
         Hhyw==
X-Forwarded-Encrypted: i=1; AJvYcCUp72/O71Q/pk9em0a5no/j4cK1O82ZRBumpfRaGhy1JIR1laycK1lOuo8XFN0Akap3IddE5cXI6TXMJVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBZQQ0I5NTWNSZ1dVXVlSyDASagj5ecSapzrs6a7LVBs+Sjic
	m/CYf7a1+fuA0eQ19lSUunEVU8dGC2Geo8JFnbdMV6nkM1L5vGvJrJtYr5+5gRt6o6mRLmVH8Cl
	ByFMMY02tAa1taTHdgy6jI6SPvclirUA=
X-Gm-Gg: ASbGnctjyeE7cDhJ3quwZyOTgltwoWsXpdyE0BPlvTnl5YtWQcXegJym6I/Quomx7w4
	0guIhAgSNgxO0HnJthJzx/pSycRU1PgdtzyfR+GgCm6iuYGVWEdPf/MkfL7eLuK67tmjZAfjURh
	Uum78suK70Xu4m9UVwPgkbXwEzSQ5cN24R4itjPiKz5b6g85gQIAGygdNdKTe5wHQGjNjrNlWn7
	UZzj6zpS7U2OVNEp7jTMTx2bCsEcKzAZcjkqDcAISKjUrHNu7y8hzsMXww=
X-Google-Smtp-Source: AGHT+IE4cJ5tKilhXPYHarL/WwSTpAKLEQP79/c9FgSYQlPHxB3xnuqal+6HSN9axzRSzHDWtwI9mVnf08eSqkii1DU=
X-Received: by 2002:a05:690c:3684:b0:781:64f:2b3c with SMTP id
 00721157ae682-78648597eb0mr58171837b3.62.1761993143661; Sat, 01 Nov 2025
 03:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027211540.dnjanhdbolt5asxi@skbuf> <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
 <20251029181216.3f35f8ba@kernel.org>
In-Reply-To: <20251029181216.3f35f8ba@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 1 Nov 2025 11:32:12 +0100
X-Gm-Features: AWmQ_bnrLkeoI865jzvdLW6HrNZUoAZzlwQYas0BUbzxlrfDK38hIgzRoi2f-jo
Message-ID: <CAOiHx==WU5BiaLBP=vcABV2vK0efVKKi-A0Qq0XUbfLNvqaBbA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Oct 2025 11:15:23 +0100 Jonas Gorski wrote:
> > > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > >
> > > Sorry for dropping the ball on v1. To reply to your reply there,
> > > https://lore.kernel.org/netdev/CAOiHx=3DmNnMJTnAN35D6=3DLPYVTQB+oEmed=
wqrkA6VRLRVi13Kjw@mail.gmail.com/
> > > I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
> > > which makes any consolidation work in stable trees very complicated
> > > (although still desirable in net-next).
> >
> > It's for some more obscure cases where we cannot use the Broadcom tag,
> > like a switch where the CPU port isn't a management port but a normal
> > port. I am not sure this really exists, but maybe Florian knows if
> > there are any (still used) boards where this applies.
> >
> > If not, I am more than happy to reject this path as -EINVAL instead of
> > the current TAG_NONE with untag_bridge_pvid =3D true.
>
> IIUC Vladimir is okay with the patch but I realized now that Florian
> is not even CCed here, and ack would be good. Adding him now. And we
> should probably add a MAINTAINERS entry for tag_brcm to avoid this in
> the future?

Oh, I didn't notice, thanks for adding him. And yes, I'll send out a
patch for that shortly.

Best regards,
Jonas

