Return-Path: <linux-kernel+bounces-857989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6826BE8778
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62409501AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453062D7DFF;
	Fri, 17 Oct 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML3YeOoZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C201332ECF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701984; cv=none; b=mnWHMZ1IE5I3P1kQJoDdGc6dFQEN+QmRMGBNS2KLgEg2gqgJdFxV8b7XPzD5W84xUqYCKGuHwTRRUA1hiJeToRxc+YgG0tPdYhl8iZ0W0fR2ev7zJF50hroPhnEWBj+ZCZ4Ra53TpkJC8et7+u7JDCFzbMUxahHQPno1ViCGbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701984; c=relaxed/simple;
	bh=SUzpcE7GtmXGvI8wFQ0DdKbyJGu0fVJWNzJBCAVp96w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpaJhyI+DPFo/NNF+gCs1uszSJqyZTwLJW+5d3XKtwe3b1SpmTfCjW2EUhkrCRbiN9QDD1sv0pPHiqWvfkUYV+l7E+umOjS3NC78VOYkwsTzWq5kyYPEcTMDtcKHqcWfb683fi+TEjVyIlLH+0roauY+TWPQSKkMGRjKd16jBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ML3YeOoZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760701982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxfvbcLLu67MIwlxOvZ0TKOWYqHJfoFEyrjda7z1bsQ=;
	b=ML3YeOoZU3J9lEjDbUryHfLAW1qv3Gifh+qMCHFaLyMyduByb4sxp0VXOUoPEiAO+Njqdr
	eJ9ue/NkwTGHwrEzUMbuipqIYzvade7+1JcTiyuEFmDUTCvYQbW8pIkeWSHH3MOsByR39i
	q1QZB6SNRFZJJDHvcS5tc+YqPHNM5k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-mW5Pr7ymOmGt2AhT7Q-dUQ-1; Fri, 17 Oct 2025 07:53:00 -0400
X-MC-Unique: mW5Pr7ymOmGt2AhT7Q-dUQ-1
X-Mimecast-MFC-AGG-ID: mW5Pr7ymOmGt2AhT7Q-dUQ_1760701980
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47107fcb257so22319565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701979; x=1761306779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxfvbcLLu67MIwlxOvZ0TKOWYqHJfoFEyrjda7z1bsQ=;
        b=fMz9WhpP4uBkXCl4bwf1ml/Uh7Sqp70PY0TMU4luTNQ4JzrD1O08lTUkaNtU7AHU/X
         vcDfX/NaRaQYpNNTrf+xUGmDRv3ccug3+uGYLszwtoDhesbpo5QvgZM+paZ0rqsIFY55
         j5xMxKOFglnYloaeHiBZXxEk/ggggTzk5465W7xL+Mfhy3BVGwuLHY2CH82KpmpnRJGL
         V7cIZm0ib44gqAoqEsxHTMlX5kBoV9fdJmrcdvjOAX9auVanvnEyF5BtqRDfGYfLvngV
         kUcK0XSCa/qC8xL5/qJ2WTtP09BTV62AtOD5AVxr+Y/ZOoxcyFUwcIEA3xV4Rd37F+0f
         VywQ==
X-Gm-Message-State: AOJu0Yy+JApObik+tTouuQ+FP95CAonaeOAZeRlpixd2d0pVv3Hts59O
	0t4ipt/09WWslExBFDd2UnrNPhJypWRQT38easzKXBJT48n2pHQzmP+9hie5oLvkRA7ONBlbsQu
	zE2RoMlzDtghZlm4jos9KuUOyTD/9pVUM6ZHZ1OYfFr5gvwuAGaVOX20eKH8DOdj9PBfvENtwD1
	hOm2Z9AR7mi6gSilDTZiSGTkJ9MPlKe36wmvMh6VIB
X-Gm-Gg: ASbGncsEpehx9P5oga7eP5SstqxQhPeCh+OQ8IsmBRZhgr4+n+U+/zLgkeKVM2w6Vy0
	0vbMlyZV6E4LdiBe+ewpL5r/KQyVu3BKCei4ipPx4LSHmW/7bZaW2R/e8FLxkMySEidl626/394
	Oc1ddPURcEAn/GNaR2nez54v4H2LHWwE3WaPUf8EGR+ONAGLh31y6GEpWp1edPWMGd1UXvXFZi2
	rFBx2Ta/rSkXuS0kg==
X-Received: by 2002:a05:600c:529b:b0:471:350:f7a4 with SMTP id 5b1f17b1804b1-471178a400cmr23491395e9.17.1760701979575;
        Fri, 17 Oct 2025 04:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywczK+EIpYFNZr6LFF+2TgMnXQ228HOGM0S1gJjRCt05BeFqbOEfG8iq+xaitGHL34pj0bRg3/qZRX9c/GpI=
X-Received: by 2002:a05:600c:529b:b0:471:350:f7a4 with SMTP id
 5b1f17b1804b1-471178a400cmr23491215e9.17.1760701979206; Fri, 17 Oct 2025
 04:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016084301.27670-1-lzampier@redhat.com> <20251016084301.27670-4-lzampier@redhat.com>
 <87sefj179h.ffs@tglx>
In-Reply-To: <87sefj179h.ffs@tglx>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Fri, 17 Oct 2025 12:52:48 +0100
X-Gm-Features: AS18NWAyr_OiJTgLStN1G7hKO9txtKoLZhRKznNbGHfdcjMfX9CrDwQ5omJQ6-g
Message-ID: <CAOOg__AHpFsxU==JPX_usRnkJSL6agadsGZUxdh0L0DriFwcQg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

I'm really sorry for that.

On Thu, Oct 16, 2025 at 11:16=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Oct 16 2025 at 09:42, Lucas Zampieri wrote:
> > @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] =3D {
>       ^^^^^^^^^^^^
> How on earth did you manage to screw up the hunk header?
>
I was copying hunks over from one file to another to avoid
format-patch as it was screwing the email headers, after that I
learned that there's --[no-]encode-email-headers in format-patch for
that.

> Applying: irqchip/plic: Add support for UltraRISC DP1000 PLIC
> error: corrupt patch at line 116
>
> >         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >       { .compatible =3D "thead,c900-plic",
> >         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +     { .compatible =3D "ultrarisc,cp100-plic",
> > +       .data =3D (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERR=
ATUM) },
> >       {}
> >  };
> >
> > @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnod=
e)
>      ^^^^^^^^^^^^^^^
> Ditto here.
>
> I fixed it up manually. Please be more careful next time.
>
For sure, wont happen again, thanks for taking the time of manually fixing =
it.

Lucas Zampieri


