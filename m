Return-Path: <linux-kernel+bounces-871818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8024C0E64B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D875F19A3E82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE23081CD;
	Mon, 27 Oct 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUu5WbYO"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F117A2E0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575130; cv=none; b=dijfE8GQdhrVr2cuuhFSs5roYwF6cWrHN6WI3AGlcyEPRkAnGiuuCkQetxLuOH09QtkvW5EvgRDsPc+iHZBCMI1a6w9GEmZd1Ok0mGzCyu9VA4GxLK8Q4Mnxkh4KRHKN/V50URO09TV0lxS8S1v6fCj4zD36d3MUw1zhQmXCTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575130; c=relaxed/simple;
	bh=8gX5haGEaKgw6pCwmevwN6A8saqB7JzAKqHfC7rqR6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1LrzVb6EUOPmrhg5oG/qwV7fcadX5R3lCW0z4PgF+6AqLPLIHgeKuatSISOEDbheM5OV4qMgxlHucuaVJqy0ZILv+JxUXMNTzfRtxFH9AC3UXV2HDw14Ib4oYk/vQ9i68xICUmOrQ0zsuBnzf60inkmAG6VL0RVF30OWq++WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUu5WbYO; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92790f12293so216101039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575128; x=1762179928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibf+3ABSx5r7lgRWTSUB7cDn6WANPW/J4RtLU/qefqg=;
        b=bUu5WbYOBoWWHP3now79uOTz6dTlht8V6MANIcN5me1ypp6N5yZhug8eXemgqn3Fl3
         M3cOSPHFfQCqD6JJELAFj48N3/IiRfSwyzS1fn/KrMeNdqxfOiHH1sxD5GvkdWYB3O9x
         b1EnpqSvysXeCY3+dFbIUXVqHYNVJfUmYyjEP7iM5IvMLfwCadTP0+gaUIV+zxy/v9xX
         nG1r7B28ThZPQNN8SLMDiW+V9ZT37J3y87iuKPCoF9afOw2FWyY/PqXKCLJd6dzmipjC
         a4B6EW0CD3cj9eIh/q60fX4CA5hbuyb2H0ceBEC1Ly+o3pXL+xasuhzJhtVyDN8Iz6Wu
         HYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575128; x=1762179928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ibf+3ABSx5r7lgRWTSUB7cDn6WANPW/J4RtLU/qefqg=;
        b=kVL6x033jpPZUHfvP+xxeJmJP3S9HGc3pqA2TzgF2CAxsP94r0KT383H9wMt+f175s
         /1jOMLHmeMaeKtf/M31D9E68WH5WASeFE/ZrR8UHlwUr5tbv10qqMbn6+16J/X6EcSBv
         hffbATHPPCKjZ7HQduPNUhAayqErHgbLSyi0CdwtgcGX6HMMKfPh0t4zBrOfKl1UHb8U
         xp6pGn2P1YwVpm8Zcx+zDekSpMsn2sZpgxkd32cMuHDN+K74bbSGOcfLPCSa3ykjp258
         18VhGbpHsA6qDbOgbfaAMF382+TbZHHx51COhpiZO9/UfBtWAIGKYGRC2pgvqeEcPXL6
         Ntjw==
X-Forwarded-Encrypted: i=1; AJvYcCVsjMTGwlUb7wbi6FMV3U2bBiCQ29FFlW4PromU8PwNsuK36LQCUECBg7sWesTcSJ9+me93v+lQvxBC56U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBF9yTA56wbw2dHc0Em22mHXjXEjNwkQYWxTcuAXR0YwNqDTb
	i8x9z/APp7rLbXofd6ZUKthOS4Yk5ATK/l4J2ZkwCzwX9CpZGnk6qlIQJL9d2q2qvdZ6gjLoOW5
	AclVmOOi7V9bhLHHt68qifsguaONkibjPHoNmDT307g==
X-Gm-Gg: ASbGncufRZGZNO0+FoEA1em99nA5DTk5iZuGGx+Me428HfFUnY7FtSxOczMg1b6S9LX
	2ENMHieNcuXKDPJbezTs+uMSsBorpooMLpOrYGBxoo3lyn/oNPOQZYlO7h8rqauJCFJwOGEXIE8
	UWpCikv9M9U+FJ8jwzaHBZlLp8kyIzn5bsmccFU5VqEi60qXpaB/PPsWBrqfg6Ne6kbmWoFJFUs
	4iGfp9xbnuvVCABqe8kGwSbTlHNYSZp27gWzTFO5fp5bJTKZmb8KTwA1FLmpaaxAO/mNHmD4wgq
	qMIX2xzGjBnKW3nZgg==
X-Google-Smtp-Source: AGHT+IG+ramOGhDm0hNpMb4NhRFM65FF+qntSa+5P5btaxWyWA7JocsXzbQ+8MRuHRSW+em8Izl7xs4//9AX9u6sHcY=
X-Received: by 2002:a05:6e02:370b:b0:430:ae14:e2a9 with SMTP id
 e9e14a558f8ab-4320f868ce7mr3400015ab.31.1761575127525; Mon, 27 Oct 2025
 07:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025171314.1939608-1-mmyangfl@gmail.com> <20251025171314.1939608-2-mmyangfl@gmail.com>
 <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch> <CAAXyoMOa1Ngze9VwwUJy0E7U52=w=fQE8cxwAviGm53MSQXVEA@mail.gmail.com>
 <6d4f0ef0-3c6b-417e-82e1-d7f2635f6733@lunn.ch>
In-Reply-To: <6d4f0ef0-3c6b-417e-82e1-d7f2635f6733@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 27 Oct 2025 22:24:51 +0800
X-Gm-Features: AWmQ_blsedD_VGSCMIbrcFFHUeaUq4nY8YYlwCu0aKfrXC-hpHTU42A_9BpYPrI
Message-ID: <CAAXyoMM6kbTE31Oj2uDEmU2_XVR3nR0UmFaT+LCdmcapne+_7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > > > index ab762ffc4661..97a7eeb4ea15 100644
> > > > --- a/drivers/net/dsa/yt921x.c
> > > > +++ b/drivers/net/dsa/yt921x.c
> > > > @@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv=
 *priv, int port)
> > > >               const struct yt921x_mib_desc *desc =3D &yt921x_mib_de=
scs[i];
> > > >               u32 reg =3D YT921X_MIBn_DATA0(port) + desc->offset;
> > > >               u64 *valp =3D &((u64 *)mib)[i];
> > > > -             u64 val =3D *valp;
> > > > +             u64 val;
> > > >               u32 val0;
> > > > -             u32 val1;
> > > >
> > > >               res =3D yt921x_reg_read(priv, reg, &val0);
> > > >               if (res)
> > > >                       break;
> > > >
> > > >               if (desc->size <=3D 1) {
> > > > -                     if (val < (u32)val)
> > > > -                             /* overflow */
> > > > -                             val +=3D (u64)U32_MAX + 1;
> > > > -                     val &=3D ~U32_MAX;
> > > > -                     val |=3D val0;
> > > > +                     u64 old_val =3D *valp;
> > > > +
> > > > +                     val =3D (old_val & ~(u64)U32_MAX) | val0;
> > > > +                     if (val < old_val)
> > > > +                             val +=3D 1ull << 32;
> > > >               } else {
> > > > +                     u32 val1;
> > > > +
> > >
> > > What David suggested, https://lore.kernel.org/all/20251024132117.43f3=
9504@pumpkin/ was
> > >
> > >                 if (desc->size <=3D 1) {
> > >                         u64 old_val =3D *valp;
> > >                         val =3D upper32_bits(old_val) | val0;
> > >                         if (val < old_val)
> > >                                 val +=3D 1ull << 32;
> > >                 }
> > >
> > > I believe there is a minor typo here, it should be upper_32_bits(),
> > > but what you implemented is not really what David suggested.
> > >
> > >         Andrew
> >
> > I didn't find the definition for upper32_bits, so...
>
> You should of asked, or searched a bit harder, because what you
> changed it to is different.
>
> /**
>  * upper_32_bits - return bits 32-63 of a number
>  * @n: the number we're accessing
>  *
>  * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
>  * the "right shift count >=3D width of type" warning when that quantity =
is
>  * 32-bits.
>  */
> #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
>
> I don't see any shifting in your version.
>
> And then i have to ask, which is correct?
>
> How have you been testing this code? If this is TX bytes, for a 1G
> link, it will overflow 32 bits in about 34 seconds. So a simple iperf
> test could be used. If its TX packets, 64 byte packets could be done
> in 5 hours.
>
>         Andrew

I used ping to check whether the statistics match expected values and
didn't realize iperf, I'll check that later.

> but what you implemented is not really what David suggested.

Shifting is clearly wrong here and I think they got upper_32_bits()
wrong too, but should or shouldn't I give credit to them
(Suggested-by), if I took most of, but not exactly all of their ideas?

