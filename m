Return-Path: <linux-kernel+bounces-893148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A007C46A48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F5B188C502
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734830BF77;
	Mon, 10 Nov 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="au0iY8Va"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF8309EE0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778245; cv=none; b=m6iFRaH3OKFTHUV0WEX6Xpp0xpS6M3iSTJn+cGQx38n1+P2SRAiOqmjTPnFBXQy0U83lUvnEGZ6tCmbXWdGWd/dWPlk+NXvQ6Yq6lpG+RSs/FQk337rwuMMRbF4DmS4CwazSyEh27tM+GF3bvSZNVK5ABfPZKuQHz/jdn6zO3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778245; c=relaxed/simple;
	bh=DEySSnbf6pYP54dW9sTqUDBM3FZFHwfqhe80nyGUkWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAnq6pDGz/0Cs6SNszDsjaNvzZYsPC4MAbGTDjhiNYqeez8A11nPLb8rW1EeID8f3NfNbJJ8TwXfNicKSCkGchUWYHIm30xD0IWhXABZKU8U8W36CywNKsP9jLp5HkXAmXxkBDFQqoT4QWhlgCzwWOD5tDaPoAceqs/1tYc//DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=au0iY8Va; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7277324054so423121166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762778242; x=1763383042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdbKsB+tMJvagrMvYHn0y49jacarMu1zTyH+h0jj2wI=;
        b=au0iY8VaqzcgwAubBJlRJgmPEdSXrPxASHhHbJZCRsjQ5kh8I6QPhINUgU9eI4GlZB
         Uay1TMIZipn4Zcnrw1RXm5AXv3veJy9jERkUC3dQObdBiAjVFfaoWanRsDKl2TTZtkgh
         RTwYR3/SxPdH7f2XPjPsEPw0uE25dzNdsT48OzesH+/Y4+PdpwniVUrYWzlVfe0wHeaX
         WQmKdXanFE8YCh2n0yElu4IsruqBB75x1MjbhqhvSXEtpNfAgTk0otKjzJm3QvHLJFoY
         SxDJSW2rF40zvHs8WXrRxYr16G+wCsPKciGJQ2G/ph3J49nwQRg1s+8hovqk9wxpyNu7
         T+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778242; x=1763383042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdbKsB+tMJvagrMvYHn0y49jacarMu1zTyH+h0jj2wI=;
        b=Q76tj4UoGAx0qxz5YICCazm3UVW7ZbkzmMSX80OgEW6Gs01B9JZtgqnFvDJ9650bB7
         5TRNYq5ZYnOYZll5St0XMLFsnApkS6vZurvJPm45souDWtHnwM2Yiu32kqi6CHeUPql4
         a7U90ERYR51OQDHCGBRvkGHmc6rcuPsbP+j3TkFZMAg5ynrxwdLUBjJ2O8+RbT22Zv1v
         CNLzHINeb/dTonBiihUFtvsMmA02P/96C04DCwnRglB1kowMumV+orEqrR3Oyo5XlU2Q
         CDcwVwxCma+vnGh4Pf9+GOYLpgyJfcdVSodzwDFvlVOulCfB6B85+E52YZgq5027LS6Q
         DSgw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdG/llsbiSZGZUhYZTPkmquTsmkF17ck0y7WN5CP19NoF7jxeG1yjuX57gEsKW5fLGj9kMbuNUphgnVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsabjU/WIVLxNseZFhpyJ6vHan/ZxUvR+GDNbcQwaPWB8qf+8d
	ktkQ1PhSF9WYY8QHAi0kc26dMQvE4dzuboyj8a+oB27OnodWFgPiecQ6QsIPuT8jKjpdhhViSZ4
	0PuvRrwqd/fFcHD8b1iu5d63erm1Hc2msvBx/l4Z1Aw==
X-Gm-Gg: ASbGnct9j+CcLGBgp5MSfBF9Q4B8IboTpumDsBKpJ8ncPD6cVNrSVFx1C4Sr+RaaIGq
	KlkMPrFD2Zao9GRg9UJycd+swZGE3xCrskgxPmjy1ZUvUDVYiClOnEhvvBks9XHjR3dTqAZc9zi
	XVtMDO6LOScZ3z+BgwAH3bm10zSU/TjeDmSr50L1rBsR/eZsMorn7Btg+r/wJhf+mM4y/QcQ1Mc
	G0xDF+HKW+RWgmRLOLlo9S61zfCGF8yLrHRw9zUpzpySASPe+XbBrvUiBo31/nad1l+r+Y=
X-Google-Smtp-Source: AGHT+IE8R0GEPpZSZEercv3oXNopblQ2LRLU4GoX8SS8pCTS+917rMgdDv/cyw05AUmS6nbzIs8krxRmiMby2Y3ip8U=
X-Received: by 2002:a17:906:eecc:b0:b72:dc33:3d36 with SMTP id
 a640c23a62f3a-b72e056d8e5mr574165066b.49.1762778241054; Mon, 10 Nov 2025
 04:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141936.1085679-1-robert.marko@sartura.hr> <20251110065701.rch4wjflap3vicjq@DEN-DL-M70577>
In-Reply-To: <20251110065701.rch4wjflap3vicjq@DEN-DL-M70577>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 10 Nov 2025 13:37:08 +0100
X-Gm-Features: AWmQ_bnmKGMttOuykPTnFw9koAKzfig9Ix0aGoP1qnMvwkAAXQmuYEVNFMiaUPs
Message-ID: <CA+HBbNESaT7SfgJPE-MTQphDQc+vcZUBn5mV+yFq_iqk+PcakA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sparx5/lan969x: populate netdev of_node
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:57=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Hi Robert,
>
> > Populate of_node for the port netdevs, to make the individual ports
> > of_nodes available in sysfs.
>
> Sounds reasonable :-)
>
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/dr=
ivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > index 1d34af78166a..284596f1da04 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > @@ -300,7 +300,11 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
> >
> >         for (portno =3D 0; portno < sparx5->data->consts->n_ports; port=
no++)
> >                 if (sparx5->ports[portno]) {
> > -                       err =3D register_netdev(sparx5->ports[portno]->=
ndev);
> > +                       struct net_device *port_ndev =3D sparx5->ports[=
portno]->ndev;
>
> This line exceeds 80 chars and can easily be wrapped.
>
> > +
> > +                       port_ndev->dev.of_node =3D sparx5->ports[portno=
]->of_node;
> > +
> > +                       err =3D register_netdev(port_ndev);
> >                         if (err) {
> >                                 dev_err(sparx5->dev,
> >                                         "port: %02u: netdev registratio=
n failed\n",
> > --
> > 2.51.1
> >
>
> It seems wrong to me to stuff this into sparx5_register_netdevs() - there=
 are
> two better candidates, either: sparx5_create_netdev (where other ndev var=
iables
> are assigned) or sparx5_create_port().


Yeah, I indeed overcomplicated this compared to setting it directly in
sparx5_create_port().
I will update this in v2.

Regards,
Robert
>
>
> /Daniel



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

