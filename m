Return-Path: <linux-kernel+bounces-849916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D65BD153F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C7189062E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C461993B9;
	Mon, 13 Oct 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cgQp3Qka"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304F8248C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760326772; cv=none; b=pI7I8mDw5YAzS4UP5Z2aAUGCFhnf9tnHSxwZrfNYIFpv0kfyCIu+2tfSqnXxkbIAEO9VZ/W4jvJV8i3L03hm8t0o/e1wkGbCusAgm7FAzOA5kPUBgE3jigxeyjlZZJJ0OTEZDqtnV6GIwXgOpzKvDwsRF6bbn1831OW9wKsyuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760326772; c=relaxed/simple;
	bh=owj08b0snyaJu7Z/ej7b3SQvC/kEJHb7oUnIpvI29uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvX7p6iXhqyaJlbcMLxlVTnIEJGP19+GzzECDO8s4mFxIKolie87fIacIBJWU2K/Fyy+cyNF3ywSVjqxcPzXH9DAqTsOIjDQ8SBwaKA9jN1QWlZJxox8PpQbnQJhOGSln8uyf1Wu2iwEBLk+kFR9bp5EsGQR6Hgbx/GASxp1+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cgQp3Qka; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a59124323so4068600e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760326768; x=1760931568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdYDMI1cPsHPTmJq6cygabE7rcNaTT2li88ZbEVvWJs=;
        b=cgQp3Qka/x6i3AoSluKpRlBFHcEmQ4PC3P4x3yXBfxs/nhH6T1X83eN0zHxltby9gg
         Bb5df5TyaEj8XLj/7glb8uOqrvK4RF6UMSpz5mrB5aiN/S0l0TwUTR/dyPETQdh/tCp9
         zf7eFm7q7XgWXtKPlFwgepDsmMexHH9Z5nkdtMsQj02k5gIjWGC4nbgBaqbJR/k7tVgM
         VSaQUwIFV70mAFddU1UqDA+4QqMCbwCbD0WynIZ3QWyHy959TLdAMYIXRQpwy6JSW9oX
         gMuisz14TG5TUom6JtgI4561fsvEV4lcQjqDSClZevJq4E67To0J2lPFgP550+LBIAaq
         rn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760326768; x=1760931568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdYDMI1cPsHPTmJq6cygabE7rcNaTT2li88ZbEVvWJs=;
        b=UbjHjKp2DTsY3OIemwOr5wZsVkiPdMn5xaVnSB3mkQ1ZRfzNBE8Tte6K4UJhCdTID0
         SZ4pzptWW2m9jxBTMy8lPzNMZVzA7kGFLrxn3E/EtKfGNrWFvJr3yA85Gvv7pnp2POeL
         UwT8DUS9vpkxcr0xAY4snwHt1faX7C6By1SRl0VSQSOPzNDMmaZKD2gh9FH0Q6cSUhP9
         S4X1Mbrr3mCiBt1qW8A98UCOatn0t9T4LniimyHb0yLRpAcpZa1JX9VW9a8x7m16jFQQ
         cAD9k5VLxU6dbhQkSgrpyHPOfeDWSB7vM84FXYqfWsxGZngmz8EKYCwDTTJULuLsdeJT
         aV2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjxLhNtdxcRx4UkrW2OwCjfvO9G6eniuPwY5s5TudjUVO76LH8gDbAuZSzs+88i4AowSTwv2POMOfaBO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3dAP4+HjQ3/xX/nFyNHk9ehXWnG1sMBkS4te3HO/TH3ECuSS
	+rajhSIzzZMiAypH4cOaym+28E/JyKH6zSAbHF/pqpyH3+AYmWl7uZMHXq1Xb9aPMljb8D0wGto
	qpHw6oSBwVhoKGFcaAmSob8o380qhFFrYHK3alCQ8RA==
X-Gm-Gg: ASbGncu4xolY6LXDXaurWj+uhKOE6N0y6Sk4WreK8+jn+0bnhcNvtWiTc2SCJHFPb/3
	fBkHzVf7AXeogSvPP81QnMqSZjiQzARWOjad9lP3SykEF5/MJ6/33bzqJJPWRjjKoc1wAV2hz0U
	hWhXy/tr0IrTio65b1+jmTC38V9OFRl6MFnOX29jd4UjXFNv7sYs0wo4JWOBWzjOytd60sf0BAZ
	4xRfvMMzd8ci9uEy5ovsNxnM3N11unSqs6O
X-Google-Smtp-Source: AGHT+IG90Qs1cuEh/SOfMtoLKRBVLNz8WEj78axMy76hDwp0zuW58bmlhJgm6WrlO/WHIWexRZc5ywYS+8FNmR+AxyI=
X-Received: by 2002:a05:6512:6c6:b0:58b:274:d04 with SMTP id
 2adb3069b0e04-5906dae5fdbmr6328127e87.42.1760326767858; Sun, 12 Oct 2025
 20:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155746.1558731-1-guoren@kernel.org> <CAK9=C2UrYg+sHsDqkmz7f7KnaREU7hXF4rbON002cnAti_pDXg@mail.gmail.com>
 <CAJF2gTR9VbOcBQOfF6Tqsp00289mypYExi2iGeKhwTu-iDS+aA@mail.gmail.com> <CAJF2gTRwW+0-nAvagfBf8U9vbUWocvCaNfYNVrCN+d2hYxdBYg@mail.gmail.com>
In-Reply-To: <CAJF2gTRwW+0-nAvagfBf8U9vbUWocvCaNfYNVrCN+d2hYxdBYg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 13 Oct 2025 09:09:14 +0530
X-Gm-Features: AS18NWAR5tMxamwivdBEhgrVec_x0u_27L-8bMr6wG6pbIHJBE2zcpGixkVg2YM
Message-ID: <CAK9=C2XT1S=nb5LPVUJ=_2NtHjx1ABrwzjv2G_edYzFi46bA+Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add pgprot_dmacoherent definition
To: Guo Ren <guoren@kernel.org>
Cc: samuel.holland@sifive.com, david@redhat.com, yongxuan.wang@sifive.com, 
	cuiyunhui@bytedance.com, luxu.kernel@bytedance.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, palmer@dabbelt.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:00=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 13, 2025 at 7:50=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Sun, Oct 12, 2025 at 11:51=E2=80=AFPM Anup Patel <apatel@ventanamicr=
o.com> wrote:
> > >
> > > On Sat, Oct 11, 2025 at 9:28=E2=80=AFPM <guoren@kernel.org> wrote:
> > > >
> > > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> > > >
> > > > RISC-V Svpbmt Standard Extension for Page-Based Memory Types
> > > > defines three modes:
> > > >
> > > >  Mode | Value | Requested Memory Attributes
> > > >  PMA  |   0   | None
> > > >  NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
> > > >       |       | main memory
> > > >  IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
> > > >       |       | (I/O ordering), I/O
> > > >
> > > > The pgprot_dmacoherent default uses the IO memory attribute if ther=
e
> > > > is no asm definition, but IO is not for main memory according to
> > > > Svpbmt rules.
> > > >
> > > > This commit corrects pgprot_dmacoherent with the NC memory attribut=
e,
> > > > which satisfies performance improvement and prevents using the IO
> > > > attribute to access main memory.
> > > >
> > > > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > >
> > > I had sent the same patch on Aug 20 and you had provided
> > > Tested-by to that patch.
> > >
> > > If you had concerns with my patch then you could have provided
> > > comments but you choose to hijack it and change authorship.
> > I didn't find your patch at first, so I sent it out. When I discovered
> > your patch, I gave the Tested-by to yours.
> > I've added the abandoned reply to this thread. Have you seen that [1]?
> >
> > [1] https://lore.kernel.org/all/CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WME=
GWrw9ERRLYYA@mail.gmail.com/
>
> This patch is on Sat, Oct 11, 2025 [1]
> Guo's Tested-by is on Sun, 12 Oct 2025 02:07:34 [2]
> Abandon reply is on Sun, 12 Oct 2025 14:11:42 [3]
> Gao's Tested-by is on Sun, 12 Oct 2025 18:00:36 [4]
>
> [1]: https://lore.kernel.org/all/20251011155746.1558731-1-guoren@kernel.o=
rg/
> [2]: https://lore.kernel.org/linux-riscv/aOtR39pl5xjyYHn1@gmail.com/
> [3]: https://lore.kernel.org/all/CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEG=
Wrw9ERRLYYA@mail.gmail.com/
> [4]: https://lore.kernel.org/linux-riscv/031395FE-C51C-45A7-85A3-CC4A25EB=
6066@gmail.com/
>
> I also asked Gao to notice your patch and give it the Tested-by tag.
> That's why you got two Tested-by on Oct 12 after two months. So, your
> reply, "but you choose to hijack it and change authorship," makes me
> sad.

Please have better coordination among yourselves before
sending out patches.

It makes me sad when people blindly send patches without
noticing existing or on-going work. Sometimes it also happens
that people are already working on things which they have
announced in the appropriate RISE WG or RVI TG/SIG.

--
Anup

