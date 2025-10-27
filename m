Return-Path: <linux-kernel+bounces-870797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E3C0BB70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585724E90D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D02C325C;
	Mon, 27 Oct 2025 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlRqLj2y"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C629BD96
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533543; cv=none; b=TDJvqAVvdi6CqeaOLf+BD9E9jefZOWiq6b8w6v39L58MBnaTml1OMcZDPdFZsZvewfnogTLIBR1TaP81onY+hlFqDN9g+oF0BZYABCP5Ioe0k9hidy96mlyHy3j2wcIAVRk0CEwW6HKNIyIfGuqFfCPqbCBCSN4u367BKy9SXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533543; c=relaxed/simple;
	bh=ixZLGZjFry1T0cmh+FTStMPELYyw70sUjLfToqyoKUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI3uneiQhVyc8MevzxiC8fNhqThGBRJJTAD9oJNkw3vFHFoFeHjQ84ISQfiIE79Lq0hxFALopAEmg2olhUJZQA8ctzn8rjxhCy6CWPAePG6Uhsimx/b3MMcSU6B5ZfKpyAmGYNgWUtpGLy1FZ8OdVzMtbhvHIXuurpuF5LPVK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlRqLj2y; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93bccd4901aso402630139f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761533541; x=1762138341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE6y7O8WL73HJ3QvP/fJ3zDTO1kKIXbhxHyXNZ11HVg=;
        b=NlRqLj2y+VcuPpXF88Cdu51N3iaMtTqeTgYkkBy2qzw5FLugAAkyNP7t5tJiafmthS
         en6MT7fMf6OOhJatSE/enfjkLVxmILVFzg2c5DnDUjBsBPptRGZ9aM6Nyhg0fsEtdRh1
         wyKmYeuhdMS/fGvNxxkJ+DVyXmoK9+5EhVs4iiK6Q67WOucD5XZgVRmXUR7h5TSisXmD
         0noVH5DKNbECnCzT8b7KK8bcVRqPhskILePB/F96PpnolC4sKns3CJbC4pfE6VwzJdwz
         gIGONx7a05o64AXCGV0UXfeKtoDORKXp5tLCMZZN2eJaNGOX0DyfJdDyajO00zISTBlU
         4X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761533541; x=1762138341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE6y7O8WL73HJ3QvP/fJ3zDTO1kKIXbhxHyXNZ11HVg=;
        b=WsmV0/mxlQN2UuDadp3cP1gCoVQd3yf/nK5luSE5Nv0W1bLW9G60K+K5fnBKEyNYAn
         45k3dgPfsSgqh02hQVgrGZB216MqyWtuKnOrLEkwShuRD0E48P8/j/RZ/p9LYdFTtBUG
         FVL1O/j3Mw5aa4hUa2Zrh+OVpuV0jvwzo419urXnuIha/nzBStdjbeiiXqgbajAAVYnv
         Ty3YZvHbhCIWmmuUBX7D7mCzaowNeKS8WD+S0z7KMIF9HQoh7P6KTh7U2QwlZ9929RrV
         YKlrmGPEpfGJFEpWuwPwWZ5RIeTa3xzao3xplrkYi9pNRo2ULDzLpH8wNCi9Ot5Wkvee
         AFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv1Y5fhTaIqjGxYO+tY3VwZrnKSlZbv6S0Y1gTjOsFp8Ln5j6NqtT+YKTYdeB4YqRz27OinS5bIVRZbMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc39RJBFRuk76uHXBNiu72b9BLLcU4/mR+owZMslPrdv7p4TMU
	95C+0tAvQxpOEWbQ6fKUIKqKmq4TTjDTuBQBM6jChiQ9RbfFuGjv0SUGVwVA9rtvjJgucUH1cJm
	UvmOj20yBrk4AdihbTs3LzR4RMvKQ4us=
X-Gm-Gg: ASbGncuvz0Yc7fQY3AB7XGk04S0JYVQp2QvOaO+dGNwdgKspz0aaA+vINyWVHvC1McL
	x8apWy3bsn9N614yqI9fZ7rOVAkBwWzYY8fhIr4jE7yvzWyEzIDtlriMCRU4GxmzNzwBwciuk6h
	pUprthZK4sc3bPWhtSmIMWCnlJindS72JDCgUQY+7GUAvE9E/PjGLo3PIROybHZrcr4Qh8g9/kD
	BDSQeZS65ms4EOtKl4pluQiEAJ7Q65DN45rRMwzeFHsbyonDEYNM+HRMra1p2pikW5VM8wneBtg
	kngbp6cw
X-Google-Smtp-Source: AGHT+IG10Fz0lVpen9pTnjXcu8h81Dafdgs54J6+i61Y49zuCOckPnrbt30eiGcCoPzXPId17xhv8r975Vzt26iCPxs=
X-Received: by 2002:a05:6602:1508:b0:945:abea:9f6a with SMTP id
 ca18e2360f4ac-945abeaa434mr218426339f.19.1761533541221; Sun, 26 Oct 2025
 19:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025171314.1939608-1-mmyangfl@gmail.com> <20251025171314.1939608-2-mmyangfl@gmail.com>
 <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
In-Reply-To: <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 27 Oct 2025 10:51:45 +0800
X-Gm-Features: AWmQ_bmoPfYcUgstOTVsBidY-HlYrCdpiI4nXRFeg3ioqHavZdYa2xUj2m6lvcA
Message-ID: <CAAXyoMOa1Ngze9VwwUJy0E7U52=w=fQE8cxwAviGm53MSQXVEA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:30=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sun, Oct 26, 2025 at 01:13:10AM +0800, David Yang wrote:
> > Reported by the following Smatch static checker warning:
> >
> >   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
> >   warn: was expecting a 64 bit value instead of '(~0)'
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountai=
n/
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/dsa/yt921x.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > index ab762ffc4661..97a7eeb4ea15 100644
> > --- a/drivers/net/dsa/yt921x.c
> > +++ b/drivers/net/dsa/yt921x.c
> > @@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv *pr=
iv, int port)
> >               const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> >               u32 reg =3D YT921X_MIBn_DATA0(port) + desc->offset;
> >               u64 *valp =3D &((u64 *)mib)[i];
> > -             u64 val =3D *valp;
> > +             u64 val;
> >               u32 val0;
> > -             u32 val1;
> >
> >               res =3D yt921x_reg_read(priv, reg, &val0);
> >               if (res)
> >                       break;
> >
> >               if (desc->size <=3D 1) {
> > -                     if (val < (u32)val)
> > -                             /* overflow */
> > -                             val +=3D (u64)U32_MAX + 1;
> > -                     val &=3D ~U32_MAX;
> > -                     val |=3D val0;
> > +                     u64 old_val =3D *valp;
> > +
> > +                     val =3D (old_val & ~(u64)U32_MAX) | val0;
> > +                     if (val < old_val)
> > +                             val +=3D 1ull << 32;
> >               } else {
> > +                     u32 val1;
> > +
>
> What David suggested, https://lore.kernel.org/all/20251024132117.43f39504=
@pumpkin/ was
>
>                 if (desc->size <=3D 1) {
>                         u64 old_val =3D *valp;
>                         val =3D upper32_bits(old_val) | val0;
>                         if (val < old_val)
>                                 val +=3D 1ull << 32;
>                 }
>
> I believe there is a minor typo here, it should be upper_32_bits(),
> but what you implemented is not really what David suggested.
>
>         Andrew

I didn't find the definition for upper32_bits, so...

