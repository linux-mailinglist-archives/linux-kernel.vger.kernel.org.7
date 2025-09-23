Return-Path: <linux-kernel+bounces-828899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E5B95C91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B8A7A841E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1B322DB3;
	Tue, 23 Sep 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9lwHqiG"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE5322A27
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629443; cv=none; b=MqkzTZgduhY+Ngasa4N0N4UtselialVnGFlu5IOBNrtgWVGSF0+2OwXG4bR1upO0RHc9yYPpSCa8vy1qnO71uf8yhlMHtg9+w5Z/L7rMu8/O4fGhvxsj/ofuGX5YOmviWG6ym6SSzTLmEcACFfZ3TjY1RoN5LjAv1GyxPOehQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629443; c=relaxed/simple;
	bh=a9DTXpGqgVHh9jVLGJdvu05e2qjfyRCHTw524yeXfSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPYWo2qihVVEu9vRebPfz97L9ibMJxsUVOfhQUv1V+s21PW+vcKkMIFrz+BdvKrJvViBqIqxvCKfZuMFA3bcpAztDD8yg7MWa1WBZpxAakZwNmeHWq2GyfJlj/XMRnyveseGuZv9QSe9hX1Nh2SUFEdzgWVMu0Uc1EWeGIA9q9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9lwHqiG; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-ea5b80bbfd6so4076404276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758629441; x=1759234241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq6ksWyCEtjP7L0EnAqqm+GnNsIY/ENqD77Iipk6ZkA=;
        b=f9lwHqiGIvC1t0RL0A8FIfMY+yFFEv68o+GlOFdl+EB5W+Mu9iuBAV+DJLKXYmEBqu
         11m5luBGjPeEQRcm3nTslM6pXWIZuTLY2WiAsBwzhLXb2zdjxp2Vx03Ciyo6LYDPSPPS
         WDFcEcA4YjOWfYdoCORqYg9byx0H9LmWJ2P6QfvAt8IbKV7uc1EosJq/B0+l8DbhcUUl
         rF8VdVHpXiDOUyVha8xbG4e0xQX/gsq7J8Gt6IPHlAuDkTzGfWxcBzFna6VX4XHYClB2
         he0x1dmXQEXa2qOnxhZKbsPETcMN6Mu+j2+NZZlGetc2xFgvi57yppDEcL40qy4w/g0T
         RNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629441; x=1759234241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq6ksWyCEtjP7L0EnAqqm+GnNsIY/ENqD77Iipk6ZkA=;
        b=U4TyJ/UzVaTNGzxImxMR0M4eobCIcQuuTRj5ST0H6xgSNiT3KfuOdSzYbhv3TsFOYz
         hrV0LtlPpbauWAhKN72acWiKNSKN6T0LJxsgdgS1C1R8KsOO4/TEK6eYYYmReY3USitw
         iDh/NKeCN0P3dKxYeRHJ2Iv/RzBICQs4yoO+sQZ4bAfJjkC2DELOyCxr/75BeJWNEE+U
         5bmZakySpwIXG7fQ3FLT/60+JPzVPblDIPnT4jkE9bptie2Eh5DqigM6BurhhNvdaiPf
         R6ViOV2q99hx1X26SXntwB6PjRG7BfBNP4eejbFqrTrXi8UpY52ZyAwzt+H0ddcIO983
         X5sw==
X-Forwarded-Encrypted: i=1; AJvYcCWt427yAG4JKVKv5F/4rgc8ryegDwNcfIzJn55gBYdrb7LF4UhAN+8x1kxyVM/hTDDOf4GcxfuKvKv9weY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqM+37d+HS7W2dwAIYHBwepdQc6Gb9LazqTkxWEZ7Hp8HPJcG
	6dGRHSpsSFQQCyILR6Sq5OsKfn/ktiT2upGm3w9B1glVg1QoyWZuURhtzmwxSpNUFrnfbZUh96d
	r5fKMDqSmGXmG+PyMc7TPMVP4Vwn4R70=
X-Gm-Gg: ASbGncsuncAT20zAOXiuqK8CVzCda1j5uCmhSE9lQsTYJqs/ndkloBKCaUeOLKI0/Go
	zaABhhqG1h75PPH51wvVq2VoeGAHvOEP5jhovaBD5AHUU/rYu7lhnz8QND9LsYnSGh7Z0mvqiq0
	khaygKPKHABJiZkRXHWjXf/MxdbD9J+VWq6nipm+lfKwGsiZV/fb2o+fZVPz/mLDNhAtBNFVyc6
	XY/5Qs=
X-Google-Smtp-Source: AGHT+IEijeUDqCQWWk3DlJFuTl+beAlJlJjPVnGvdVX80F2lyDoY1c1I4/gd8BqOlIERvjiXSGd/JYk9RF17BzK7I6E=
X-Received: by 2002:a05:6902:5408:b0:e93:48ae:fdaa with SMTP id
 3f1490d57ef6-eb32fab5916mr2161664276.28.1758629441199; Tue, 23 Sep 2025
 05:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923060614.539789-1-dongml2@chinatelecom.cn>
 <aNI_-QHAzwrED-iX@gondor.apana.org.au> <CADxym3YMX063-9S7ZgdMH9PPjmRXj9WG0sesn_och5G+js-P9A@mail.gmail.com>
 <175862707333.1696783.11988392990379659217@noble.neil.brown.name>
In-Reply-To: <175862707333.1696783.11988392990379659217@noble.neil.brown.name>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 23 Sep 2025 20:10:30 +0800
X-Gm-Features: AS18NWCsSCb3go_4Vz04R9B0xSiDdbLE5rpM6dRGbXTaTxjX8nxOCkMEn9KQ16c
Message-ID: <CADxym3b=_gb6o7xyozXekF4RbUoFe4h=zfegFuARFWqeWaisaQ@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: add likely() to __rht_ptr()
To: NeilBrown <neil@brown.name>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, tgraf@suug.ch, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Tue, 23 Sep 2025, Menglong Dong wrote:
> > On Tue, Sep 23, 2025 at 2:36=E2=80=AFPM Herbert Xu <herbert@gondor.apan=
a.org.au> wrote:
> > >
> > > Menglong Dong <menglong8.dong@gmail.com> wrote:
> > > > In the fast path, the value of "p" in __rht_ptr() should be valid.
> > > > Therefore, wrap it with a "likely". The performance increasing is t=
iny,
> > > > but it's still worth to do it.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > ---
> > > > include/linux/rhashtable.h | 5 +++--
> > > > 1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > It's not obvious that rht_ptr would be non-NULL.  It depends on the
> > > work load.  For example, if you're doing a lookup where most keys
> > > are non-existent then it would most likely be NULL.
> >
> > Yeah, I see. In my case, the usage of the rhashtable will be:
> > add -> lookup, and rht_ptr is alway non-NULL. You are right,
> > it can be NULL in other situations, and it's not a good idea to
> > use likely() here ;)
>
> Have you measured a performance increase?  How tiny is it?

Hi. It is a bit difficult to accurately measure the performance
improvement. I use it in the bpf global trampoline in [1], and
the performance of the bpf bench testing increases from
135M/s to 136M/s when I add the likely() to the __rht_ptr().

https://lore.kernel.org/bpf/20250703121521.1874196-2-dongml2@chinatelecom.c=
n/
[1]

>
> It might conceivably make sense to have a rhashtable_lookup_likely() and
> rhashtable_lookup_unlikely(), but concrete evidence of the benefit would
> be needed.

I think such rhashtable_lookup_likely/rhashtable_lookup_unlikely make
sense (to me at least), and I'm sure the evidence above is enough ;)

Thanks!
Menglong Dong

>
> Thanks,
> NeilBrown

