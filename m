Return-Path: <linux-kernel+bounces-840645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE204BB4E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538373BFE97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA0279918;
	Thu,  2 Oct 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKawoDk7"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180ED277C9B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429932; cv=none; b=Ngl0B5pWJ+GcTtPMhQ6lWdUfMCZoD9jWFU50+TKyjSnIPAWAZWx5dPhts9FreEDMiRMzH20qqijqPLy9uzK94qQq9cfjK7k5G3F5U3y7H8DiW2JT6Rrr+fnAaB/R1URYEbD2Vvj+u9Rx2vT7jW8uXMFIm18e7ZWqbizxA819g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429932; c=relaxed/simple;
	bh=UyDRhwIZr0wQtDNdqpTYj4LFriGBJZRLGT/DA4pwCg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH+yHI1+f4A0iRfIhLdIBNSYOvdRDugy9fcYkzF0fMr5GMLJ0acLoR6OGRnE5RZ10G/K7NLFMvQR5hbx8e2boaY5kDPbNV2ZhSz0T5YoDqf80pcDkiWxq49fN54ko/9Y51+QuMfX7IQlTT7lgGk6jvtet/zpWuTGZALqGeho6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKawoDk7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so885659a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759429929; x=1760034729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xG0CcI6s1hgPAwUG8O/9m8f6+Wz/D5AR23LZQVr7Po=;
        b=eKawoDk7chzeMPvdMYx+EtN85XUFz1AnhawYii94uLI8U69nJZdhsz5cOGy0e0dCqm
         bF9Mc3oi3eZHN+6GJFX+Jb8p0fPXn53rAabYgOCn//KtA0iqSWgkMra+IqqMg/+QYDRS
         uR2OLvrNIgae1s8j2i24IydTAdOg239y3CeQ3Lz0jPs15cnN/Mjw8J6+W4fJHFGYjiLR
         A3ZPhmRpnQexXiQKZ2hZES7LmoCXWRGqU84aTdJyW85upg1axEl7ZtB53kJoihIuS4mb
         cP/wlx0GfLtSwCw2g3e8QOAyNeLiXXKC7O1DV/Tkt3Pygi6Qbr0bWScFJMxWTeG8gYW9
         6gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759429929; x=1760034729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xG0CcI6s1hgPAwUG8O/9m8f6+Wz/D5AR23LZQVr7Po=;
        b=pgkxdkBbeBwdbd4u42mRDxrwHqtZQlnNKpT0U5mkjOCXvvk0tnK7Ve8+G50/7Tbfkh
         nBzxQQLX5CsA9dzgoCUy/yvHxRhsKTJfwysL6Qi0sf3DBjaCfuE3e7gQNaFxgXloxKGC
         qCZggAYASnuF7SnagPm2YCN/j78vDUK46Nsg+h6zEF3AO/iZYSd3J43+ywATt/Q4AE0N
         4lIsH5Mc2AOY88+kshrcJGX+/u1ruomZRVZokytiMfKn2Zsb42JCsnvo0ptWMKnkOwNd
         9867oOwz3pAYWaEz2Z040OrWmQ/s47F/YLK4eDA6NSeGSg8UmQFC9M+A4q/9FPTL+M42
         ZvCw==
X-Forwarded-Encrypted: i=1; AJvYcCVCwgmh4qdFxfK0hT8I70tHPhi1c32rTzj60JnP55Dpss4EY71m94eZGbIIUTEtubfpNLCQMVwLdPcvDuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlM5w3yaUk0rf4L2dKYU6X2I+Fy79QhgcEI8jEgUxIeMvHTV6
	s9b8bN19v9VxV5aVTsCMrDRKGA90SGOLVHAbBvlaGdokygGHJiwBtqxb+jMZNt68viIW4arL+A9
	rnIjxe9cGxzsjVYZguw+yU3LsQ02PT7M=
X-Gm-Gg: ASbGnctsP+h7Zd0w8m2MU6H4IN5Q6nENIRBbo637BxDARkYJy1rK2ZorRn2/fx989jT
	FDrQAl8ksJrSl8yrG0xGaQklQP3BA/i+N9K1/axCVTWQfpsEFlkH/RoYRfI6UMtav1I5rOOTTg+
	vDjOQi71dRYf8LPG7JXbNBEGB5R3/xR4dRVqpXUx+qkeJZiQgDL0b8m2+3TNh3Zrv6tNXEZJsDj
	9AeBLai1TREoVXW5R/EaUUiVCnl0ZHtDUtvmKzUo88x7q1fsghBI70ybyrOMguYLe8Rfv0K9VYy
	wa/AM0KswU5JVmBm2w==
X-Google-Smtp-Source: AGHT+IEstN7kMZUYjY35DUMyOR6/5I8AHe5nv1wJrlRFIJk67TwL0o89K8lWPuQFmVis/Y7cpKJ9BygZB+7IHAI5vYo=
X-Received: by 2002:a17:903:4b08:b0:26a:f6e6:ef4f with SMTP id
 d9443c01a7336-28e9a65e62bmr2322505ad.60.1759429929219; Thu, 02 Oct 2025
 11:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <34901d4b-0fa9-4a86-b8b1-9c9dc5ed0e2e@gmail.com>
In-Reply-To: <34901d4b-0fa9-4a86-b8b1-9c9dc5ed0e2e@gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 00:01:57 +0530
X-Gm-Features: AS18NWBo8w6ka6isASgG_CEDtwSQpfX2F1TyKo17vjYa0mOH_V4nWvDlLzsdOF0
Message-ID: <CAL4kbRNZNYHdwy1jLREEU0Bt9Tsy7oS-LXU1oi33gNLBj-OUUw@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion. For this patch, I opted to handle the
fallback locally in ppp_cp_event to keep the change minimal and low
risk.

On Thu, Oct 2, 2025 at 11:46=E2=80=AFPM Dimitri Daskalakis
<dimitri.daskalakis1@gmail.com> wrote:
>
> On 10/2/25 11:05 AM, Kriish Sharma wrote:
>
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Introduce local variable `pname` and fallback to "unknown" if proto_nam=
e(pid)
> > returns NULL.
> >
> > Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  drivers/net/wan/hdlc_ppp.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
> > index 7496a2e9a282..f3b3fa8d46fd 100644
> > --- a/drivers/net/wan/hdlc_ppp.c
> > +++ b/drivers/net/wan/hdlc_ppp.c
> > @@ -339,7 +339,9 @@ static void ppp_cp_event(struct net_device *dev, u1=
6 pid, u16 event, u8 code,
> >               ppp_tx_cp(dev, pid, CP_CODE_REJ, ++ppp->seq, len, data);
> >
> >       if (old_state !=3D OPENED && proto->state =3D=3D OPENED) {
> > -             netdev_info(dev, "%s up\n", proto_name(pid));
> > +             const char *pname =3D proto_name(pid);
> > +
> > +             netdev_info(dev, "%s up\n", pname ? pname : "unknown");
> >               if (pid =3D=3D PID_LCP) {
> >                       netif_dormant_off(dev);
> >                       ppp_cp_event(dev, PID_IPCP, START, 0, 0, 0, NULL)=
;
> > @@ -350,7 +352,9 @@ static void ppp_cp_event(struct net_device *dev, u1=
6 pid, u16 event, u8 code,
> >               }
> >       }
> >       if (old_state =3D=3D OPENED && proto->state !=3D OPENED) {
> > -             netdev_info(dev, "%s down\n", proto_name(pid));
> > +             const char *pname =3D proto_name(pid);
> > +
> > +             netdev_info(dev, "%s down\n", pname ? pname : "unknown");
> >               if (pid =3D=3D PID_LCP) {
> >                       netif_dormant_on(dev);
> >                       ppp_cp_event(dev, PID_IPCP, STOP, 0, 0, 0, NULL);
> Would it be better to return "unknown" in proto_name()'s default case?

