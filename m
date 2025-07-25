Return-Path: <linux-kernel+bounces-745910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA4B12058
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2454DAC42E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CA1FBEAC;
	Fri, 25 Jul 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWdvEDL9"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A68F4A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455049; cv=none; b=IgHPMXV3ZCSgZCZy6f2ROerlUY+S6gBZlAWI+VP2e4jGsyFuhkycTLt95vUB98ygRR3mBafprWXkTefx1+aryL7ApbDi/FSiNUCFhO98/CM/3rnclofqWqSpsU9R47K8Fnjsvx32fbtk3ZIsg3HbRhiT2YysBCcgtd5OZmRukOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455049; c=relaxed/simple;
	bh=IvhFYq2tREBJCZ0NcuR9aBHoNzB7laLGZd3zaqlq8lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKtgqzHyStu+A05lERz52EPuTq4FKKzbeLf0zLrQ2xPQ5NIikXuj2DXWw0LStaaSTS8aw/OXfmZjnDl8R3dYOo5T5zsPYdVXq8Iw+/6OLzlx0nzTPVQVGl9YUOMIUasIAOjuG+rjypkZiaMKJ1p7gb54rXrZj4Sq0sHrmsiig64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWdvEDL9; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e2ab85e0b4so14577175ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753455046; x=1754059846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2PbIGc+a/gZTMMKJtr8RstRfsm9zqsG3+vNqjqL52Y=;
        b=JWdvEDL9zZ2Wqf3aWvAI/CwrslNyv324s2+Z1k9gARJebbkjI+t0E+R+9uuDMOreha
         Tjnqlm2x1TFDgayjHfAURYHnEnRTctHSFfJfV1hrjpvodj86uBh1C1C1hvK+r69R0MiP
         sNyJ0tvxI6jzMsTgQdD8rKE3nFEb1jpKaZ8V+PgC7hyhsEjs3g532Sxu5gB32d6nJVkf
         S6mG/Me6dnPaCG8hGTyvKNkVm/3578O31XbzlSfdoYqEK02kQBzisgJqPu3yF7T27P0R
         7qhWtl0czN2zmpRShNhRUu2lMf7TmovqUwgUU4zJuO8YmuPNtvtZG4PtwJn5rwTHewbq
         V/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753455046; x=1754059846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2PbIGc+a/gZTMMKJtr8RstRfsm9zqsG3+vNqjqL52Y=;
        b=D/6WmqyBRLHpx4/0pEPVMQIgbxJS6OSNsFYFpgn1xjGnJ4iipoVS/osCDhFndMjil3
         ru+aNzQiLY/dTmMjG2eYDJhcszdb8pHtq83DLRvdOhn7SHAegePHon9KQx+f0qTTy1hx
         N5SvHxEJMF5V74dcxhmsywN+uFPKf4MPEnNXXjA6njqxnAmq9xAp+SjX6x4TyYwERAbT
         tuUxuNMK0o1cFVTfAZ/+JUgvGFluLdd4aMcOu7yscsxUzrofXmT2eTbPpHHPCvMzUo1+
         O1Zsbof2Qm2VKYkdLjxVPfDbHauMQuiZzAJKj0RX0zbSHwdLZRdqXlX+9OIIS+OwTuCY
         VTvw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDv+5WjydnZb71cVo4LRQF082ks2wLJe91uoXs+3Kb+msivgUJxWxuP9p1rb6zmbSIG4bFYOpXh6VT+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsq4/2xysaGpE0CAYV9Hgru/OuZXr7igWrlZTSwWKzxZ7RxqX
	V17UoQmnNAA2+rKEfKlBVuBMNCUAgqVP0w7FaLvQ9/8pmA4iuYO1N75ouEkWLR2vBIn0xqlzE1w
	bQFYhUjpvD5hyQmZhihVmFeOBtNuHo1A=
X-Gm-Gg: ASbGnctUf/VbX09Tm5/hvDGtE8XbEjYKbacjVwcs/CgXdoWYVmMEDUcmJ8Sx1khwVTc
	zhU3/P6kUesynL2tDfEpCLvvfKiX5HFw909Y90QOzLGa1i1m5Hy/DjRBrjPEDWYg6+AnkaIplmV
	hlX6IpEouaI+4CILzfJx7TgceGo2FFe8C6N+ENsXgfA7iiOyzzjEf38luNChwHdgqx06sIr5FDK
	nxZ6yqsv16EOEeE+crePcD7ZH9+zDOErVYZ3kREAw==
X-Google-Smtp-Source: AGHT+IFRzmYs6EmiZkuesiMAP3zE+2KV9b7NZ3L3i3a7m6FIAIMbSg+NeigJM4/DilwBYPj/ty6HSP8kU7onrYpm8bg=
X-Received: by 2002:a92:cdaa:0:b0:3e2:77d9:f8fc with SMTP id
 e9e14a558f8ab-3e3c46dd0a4mr35574835ab.10.1753455046337; Fri, 25 Jul 2025
 07:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725070310.1655585-1-yschu@nuvoton.com> <aIOKeClm/vOPp4IU@lizhi-Precision-Tower-5810>
In-Reply-To: <aIOKeClm/vOPp4IU@lizhi-Precision-Tower-5810>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Fri, 25 Jul 2025 22:50:34 +0800
X-Gm-Features: Ac12FXx4WsSVfWalX7mN2__A0yXzNtFP8iAww6WieAg6rByE_Jzl78D7P32UgS0
Message-ID: <CAPwEoQNfdit9fOiUY-WzQvS377nEqBu=s8S1zqS7tdSZfQeCHQ@mail.gmail.com>
Subject: Re: [PATCH v1] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Fri, Jul 25, 2025 at 9:45=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Jul 25, 2025 at 03:03:10PM +0800, Stanley Chu wrote:
> > From: Stanley Chu <yschu@nuvoton.com>
> >
> > Prefilling in private write transfers is only necessary when the FIFO
> > is empty. Otherwise, if the transfer is NACKed due to IBIWON and retrie=
s
> > continue, data may be prefilled again but could be lost because the FIF=
O
> > is not empty.
>
> why "maybe prefilled", please use certain words.
The original code didn't consider the retry case, data lost happen in
the retry case only when total write bytes is larger than FIFO size,
not always happen.
In the example of writing 17 bytes (FIFO size is 16), the last byte is lost=
.
1. Emit S+Addr/W
2. Write 16 bytes to FIFO (FIFO is full)
3. NACKed due to IBIWON
4. (retry) Emit Sr+Addr/W
5. Write last byte to FIFO (data lost)

I just need to prefill FIFO in the beginning to make sure FIFO is not
empty when HW starts transmitting.
So, this patch adds a condition that prefill FIFO only when FIFO is empty.

>
> >
> > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/s=
vc-i3c-master.c
> > index 7e1a7cb94b43..34b6e125b18a 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -104,6 +104,7 @@
> >  #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
> >  #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
> >  #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
> > +#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
> >  #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
> >  #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
> >
> > @@ -280,6 +281,13 @@ static inline bool is_events_enabled(struct svc_i3=
c_master *master, u32 mask)
> >       return !!(master->enabled_events & mask);
> >  }
> >
> > +static inline bool svc_i3c_master_tx_empty(struct svc_i3c_master *mast=
er)
> > +{
> > +     u32 reg =3D readl(master->regs + SVC_I3C_MDATACTRL);
> > +
> > +     return (SVC_I3C_MDATACTRL_TXCOUNT(reg) =3D=3D 0);
> > +}
> > +
> >  static bool svc_i3c_master_error(struct svc_i3c_master *master)
> >  {
> >       u32 mstatus, merrwarn;
> > @@ -1303,7 +1311,8 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
> >                * The only way to work around this hardware issue is to =
let the
> >                * FIFO start filling as soon as possible after EmitStart=
Addr.
> >                */
> > -             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !r=
nw && xfer_len) {
> > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !r=
nw && xfer_len &&
> > +                 svc_i3c_master_tx_empty(master)) {
> >                       u32 end =3D xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SV=
C_I3C_MWDATAB_END;
> >                       u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO_SIZ=
E);
>
> if prefill to FIFO SIZE each time, such as
>
> replace SVC_I3C_FIFO_SIZE with
>
> SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(readl(master->regs + SVC_I3=
C_MDATACTRL)).
>
The free space is SVC_I3C_FIFO_SIZE when FIFO is empty, no need to
check TX count again.

--
Stanley

> Frank
> >
> > --
> > 2.34.1
> >

