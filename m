Return-Path: <linux-kernel+bounces-881811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00269C28FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324AB3AD094
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D31D54E2;
	Sun,  2 Nov 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXVG3SUf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7652566
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091164; cv=none; b=DVtEPbZ2f8qzwKad4N1cHaB0HTNvU9Ypgo4AA3BA4Vn6iS7L85ybLnjDlcMt2XiFWofHRliSOq/+f3sK8fTUrxCjc8HDQaJEIMG4XzlYGqXUrP34q/a1MwbFVrZY00HUWzkxYzlSHNsmwUqGcMCqwOiTzpbG/FXpp2frIrnUnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091164; c=relaxed/simple;
	bh=jNItuRhavCC2zJCafsw69HX16W0ocJWm4TPNXbQQNQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJwKGj79VMiQLDXfEKYt8MPTcVbXJPnaZsJCOoUYAQTAkKA2rR5glqegec8+c+Nl3zGSL22Nc4mtc+xPeJcYUMKUVl8CIwm0Q5xDnXo0qolcIrWB1vlCXhuZOxLqPhGGSPTW7eOzxwoHitYEtH7Ft4Z5f55EtBM9B4RVsWQq9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXVG3SUf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so834871966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762091158; x=1762695958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw3S9KYKQCs6CdacIU3IrV9hQ+3vjKqALVZ6UycO7uM=;
        b=eXVG3SUf1UJv1YFNoDznELugP23AQ+cjhAN36hoZ3ABW+jPDlUD7plfeS7UPZaOVf2
         wr2IesaR7wC9mOjFx5S3BfIi8BIahjxHqE/CN+n4fkOJ4lkBgZcmMJjTXNaQObvNiAT4
         erR/9I6wnvoXHuXwLOaJjm8g0FE6RWwZnzDZpEhnkeZJJi/4DuvPhiqBjHYduK+Aay7t
         B2ItRpzq7DGwLV7vxD2jL6jbPQy81nKEP61DldCegOJhtAVmJLeS9bwMti3/q9IAN/BJ
         VMeh0k72R4ebUt9vf7tj+YO73w2OZYK1ygNdc2I6AirrAHcgGtRBY+WlzWlyFBtqtByK
         WVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762091158; x=1762695958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw3S9KYKQCs6CdacIU3IrV9hQ+3vjKqALVZ6UycO7uM=;
        b=HJlVMZk0lzGKDoKWKGi3MIraSkqMrTl92bkO2zyna19D3RmiMWbcKqUAr56Zn0AJ3+
         76OqXAROEDBWWHSrP6nPeM0eWDjmzmc+HIytemRU0MmzFCzo3laKXXWqPDBMNNU+VEYr
         ze77bb0V6xyfL6PQdpLZVQPe0B4XQ5O5opG+40OrZwpP63uxgLLkHmXxvlOj8paxpzUN
         kYLMlk0gPfKvt/EET2ey6yvsj/lhTzWrBXIPJdF6xCEhotmkM82vYv+y3KDS+v7kH7iP
         sihTLPH2SdV1quN9sCr0iHucAm0gXMxPJT5V6kEu16xW7EebxmAusyObLmYXXCjxDZJF
         9QzA==
X-Forwarded-Encrypted: i=1; AJvYcCXkrxV0Q0o3gAR6T9futHZc38iCZwrbTCR/yN+1ojezbcMGPvcXYY3inTMi/ZB+rhdkWWUWcXgslZi1B9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFcW0WO5cuh1QgsPd7+JgI+9FS/54H0v4oH7lB10jT1+q9frX
	VCw6hvaC1+aM+uWZckEaxHK1qq+FlR+SN7ec7ozoD75k/6cPPJ7s0GrTuIVawKxJHAXWFDeyq3u
	wuAP/I2KsrI5oW6HuE9H/erNCStok1O4=
X-Gm-Gg: ASbGncteeAEP/uK7pozq7nVsOL4QAuIF0+olk31E9OfH6qAsAlPHX17+IkrCVkpNY02
	7mprG/Ngonyc6k9OoBq8Tr5K1dHFPKcbOvOF3cXUpg7ghF0Z7i+4Ygxd+WL8ZLVMC6eAk6Z+OM2
	aYkVCvUsoWKPo9PCtJZmR1pr1h1fJPzATEKcpbDWUA/9R4Av53TqPZApqAbdz050OXPMHKP2mcy
	TlY3FssimzdO1/GF0My7nqSR/dKzeoFrliG3oydWk9gwOTqHK1/biiZyWQa5YoxUCE4Xg==
X-Google-Smtp-Source: AGHT+IGqghQc9gTYwkiV88BkHnLam8aO+LAS6X8ouZBTmZ7uz1rfP6jEkO5biLJ/wtXdRPYGfNZvKjEKAAhqEyh++gU=
X-Received: by 2002:a17:907:72c6:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b70708a1c37mr939497166b.63.1762091158174; Sun, 02 Nov 2025
 05:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030072752.349633-1-flavra@baylibre.com> <20251030072752.349633-7-flavra@baylibre.com>
 <aQMbb6BUBHQUXX9y@smile.fi.intel.com> <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
 <aQNs8VVoStUJ6YHB@smile.fi.intel.com> <20251102112958.435688d5@jic23-huawei>
In-Reply-To: <20251102112958.435688d5@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Nov 2025 15:45:21 +0200
X-Gm-Features: AWmQ_bnoR5A-A4QhwUAXufBnv5gAwBRIfgnbDoKWsoumHD55ISAtUFRF5CkD2HI
Message-ID: <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 1:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Thu, 30 Oct 2025 15:49:37 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> > > On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:

...

> > > > > +       *val =3D (data & reg->mask) >> __ffs(reg->mask);
> > > >
> > > > Seems like yet another candidate for field_get() macro.
> > >
> > > FIELD_GET() can only be used with compile-time constant masks.
> > > And apparently this is the case with u8_get_bits() too, because you g=
et a
> > > "bad bitfield mask" compiler error if you try to use u8_get_bits().
> >
> > We are talking about different things.
> > Here are the pointers to what I'm talking:
> >
> > - git grep -n -w 'field_get'
> > - https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas=
@glider.be/
> >
> True that it will be a usecase for that, but given plan is to merge that =
through
> a different tree in next merge window, it's not available for us yet.  He=
nce would
> be a follow up patch next cycle.

Yes, but we can still define them here. Dunno either with #under or
under (namespaced) names, but still possible to use now.

--=20
With Best Regards,
Andy Shevchenko

