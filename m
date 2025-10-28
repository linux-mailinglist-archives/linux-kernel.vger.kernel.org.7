Return-Path: <linux-kernel+bounces-874046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB698C15672
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BED5418A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC82236FA;
	Tue, 28 Oct 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPyfYolN"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97F33C52C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664613; cv=none; b=sXfGW7zm+0NOffsaVjUZGpgNwCZnsHw0QM1OCS2r+TLopviFeWcAq/i5kMXJ87gJxkQ/KbN220fQn8KyMBs7Hbq+TQ+SCHWaBTOvcde2kzkGHnoyi+gj6Xfp8jOEQWAWsR/2DFRw4x+spUyG0HppkzdDtc3xq3E292fS+55KimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664613; c=relaxed/simple;
	bh=hg4xnG3D9oe5szchW8eNQAlT3g6qwwp1crTxc6XCduw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYAxrQZX7fGXD1zy8N/YZ0bPI0ypj8U7ORh/J3XPUyBLtyz6qa6KkVl2Db+KLbVJmzWXltmT2N4yVhrRTZfYo6Q0LUE+HD/4+qcG95KkJG1UJkVOjCYVtodxxDA+iJLdD2ffeM5REIa1A9PYOv4OiCt5UJoP53fQbzk3GJlctZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPyfYolN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so33500095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664610; x=1762269410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hg4xnG3D9oe5szchW8eNQAlT3g6qwwp1crTxc6XCduw=;
        b=SPyfYolNQ9YVwr3FPIIQ2KZkcMH5u5tHJPbw9svyuVZH9QHAlBF7Ts79VlILtPA0y6
         Fh+TbnXyyM70e9nz8HetPXLK4hjpNfC0Stkc+Dv+qXecwak+0teEsTIPKDj6qg1KFIXh
         CWwGfBZe0UE+P6tTZjLZbJ6Lt3ATmU8W6ZfRmy06z8g2GmoMGlUREbZ1cjviih+3TZVw
         UAtYc3Kthhhnygg2t2XT5gvmbOWQGoaSdLINjqO4qb8OSHfJx/jH4p7HZlcjaLB1fA1r
         j6JawhDTi1dlOKhmgsjGUvNHZx+FFVhjaAFVL/wKvMplKQVJoek35jVLfNpFpuL4kvRg
         6QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664610; x=1762269410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hg4xnG3D9oe5szchW8eNQAlT3g6qwwp1crTxc6XCduw=;
        b=DogajcXhcvUb6yu0FmJcG7g0DZAEcBN6wGTPS/Gah7nMxyuau3xLq3t0z5krjHiREy
         /hoIhRkZFs3FbVUW0rA9noef1iZp1fAXDZvwIRUehcsScbJIBlKw/SCPmj40xxsLK8B7
         0qF/xSzGC5mp7u5eMQpi2LJoYpHTa32fFMwDN8Eqxq+2JBgBUUqKLyqkbFKAM4kglQss
         l8QN5co5gSNOQRU0VkhlFT1ZsAFir/DhHct0TvPVbMU2imPyKKMHLXVGEOCoylcjmIiq
         bNr4FO0PHdeZ56UanG//U3+nH5e2NnPOWw1XY9wg7qbCI9cQmNRFeASociMpxGpQqUI1
         ir/g==
X-Forwarded-Encrypted: i=1; AJvYcCUR6p9MaDK21ufdVvIpKs6yPjN7GImgaS2h1mvKu9VtsjmR+899RewKZLesctiDWDyPKvFEy+BTNc0uc+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3Mdqu5XubQA1abIqb+CA3CqAWJtNCFkLH1KKdPI4VGp92rdV
	YKq6UpZFzGqi5OnY33PSZSieNXQVNBOeHO52+O2IFCsoBFbjpxfmMxS2
X-Gm-Gg: ASbGncuTsEV8aJ07WmcsOfhS/MUC4F4HVXpc5l6E9YPZ2L3b4Ox7r5F1rcG/jZW6prl
	PWHIOKGHaUEFNjo4zOdKZiOwDxqR20737L4oR62EMYvGMe7JUlxgzIwnKKt10NsBSIWwbahbBNI
	JiW3gmvgyRemXyYTfmfI+35FYSIdBF1DPORkHgy3CvS3aEkyGHfzXcAk5WeYNIVYmXlZckueHVJ
	0kQ/xddjNk0GvltHdV8jqvJXx3Jh9TWx9FNToTFoVgjiq+IAzvgDCo/T7/cEx3B5rDXHsh7gSik
	Q2nFXp8CY05l3mixy4qDVfpmQwvPD0hdf9y0Z8Fq03D8zoyE28M4mvUnbWNcmlBq0q0ZdQWY/iO
	fKsagK6CadBe8qP/idTc26rvIPj43JfvTBRLklsuTGfBUJtc2fbUnmFKf3CIER7Dqb3SM70XMXr
	UXPwBl4p/w
X-Google-Smtp-Source: AGHT+IF+PanB4W1EBP4jF8kQNFwxGvqk9PUQavsE2gZgcBQZMBLBZgscU/FnRbajZ+bZT6qmnINonQ==
X-Received: by 2002:a05:600c:34c8:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-47717e512a4mr27410425e9.23.1761664609669;
        Tue, 28 Oct 2025 08:16:49 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbe5587sm249073515e9.0.2025.10.28.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:16:49 -0700 (PDT)
Message-ID: <9e4253955100998826b36834632b2326782141ac.camel@gmail.com>
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: wens@kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 15:17:24 +0000
In-Reply-To: <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
References: <20251027124210.788962-1-wens@kernel.org>
	 <20251027144327.09f59982@jic23-huawei>
	 <aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
	 <5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
	 <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 22:36 +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 28, 2025 at 5:22=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Tue, 2025-10-28 at 10:04 +0200, Andy Shevchenko wrote:
> > > On Mon, Oct 27, 2025 at 02:43:27PM +0000, Jonathan Cameron wrote:
> > > > On Mon, 27 Oct 2025 20:42:09 +0800
> > > > Chen-Yu Tsai <wens@kernel.org> wrote:
> > > >=20
> > > > > Some IIO drivers do not provide labels or extended names for thei=
r
> > > > > channels. However they may provide datasheet names. axp20x-adc is
> > > > > one such example.
> > > > >=20
> > > > > Use the datasheet name as a fallback for the channel label. This
> > > > > mainly
> > > > > benefits iio-hwmon by letting the produced hwmon sensors have mor=
e
> > > > > meaningful names rather than in_voltageX.
> > > >=20
> > > > I definitely don't want to have different behaviour for in kernel
> > > > requests
> > > > and for people reading the _label attributes.
> > > > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/indus=
trialio-core.c#L1232
> > > > would need modifying to allow for the sysfs attributes to be create=
d.
> > > >=20
> > > > In general I'm not sure I want to do this.=C2=A0 Datasheet names ca=
n be
> > > > exceptionally
> > > > obscure which is why we've kept them hidden from userspace.=C2=A0 A=
t least
> > > > dts
> > > > writers
> > > > tend to have those names on their circuit diagrams and tend to have
> > > > datasheet access.
> > > >=20
> > > > Let's see if anyone else has feedback on this suggestion over next =
week
> > > > or
> > > > so.
> > >=20
> > > This is an ABI change without
> >=20
> > Indeed...
> >=20
> > > 1) proper documentation;
> > > 2) backward compatibility (i.e. there is no knob to opt-out the chang=
e, or
> > > make
> > > it opt-in).
> > >=20
> > > In this form is definitely NAK.
> > >=20
> > > If you wish something like this, better to have a separate attribute.=
 But
> > > the
> > > problem maybe also that the same component (or 100% compatible one) m=
ade
> > > by
> > > different vendors and have different datasheet names. This means that=
 the
> > > new
> > > attribute may still be ambiguous. Hence I see a little sense to have =
it,
> > > rather
> > > better to have these links / names to be put in DT schema. At least t=
here
> > > we
> > > have different vendors and compatibility mappings.
> >=20
> > I mean, we already have labels for channels so this all looks like a bi=
t of
> > overlap to me (though I see the temptation of going this way). For
> > extended_names, there was a reason why it came as a fallback for .label=
()
> > [1].
> > For this, I'm not really convinced for now. There is also at least one
> > driver
> > already exporting the .datasheet_name as a label [2] so maybe we should=
 do
> > that
> > instead (again, I understand that doing it like this we only need to ch=
ange
> > one
> > place...)? Otherwise we should clean up those and that should definitel=
y be
> > part
> > of the series (if we even consider this).
>=20
> Thanks for the pointers. In my case I think either solution works.
>=20
> The axp20x-adc driver currently provides _no_ labels. Would adding labels
> now be considered backward incompatible?
>=20

Jonathan should know better but I'm not seeing any reason why you could not=
 add
.label support for axp20x-adc (exporting the .datasheet_name for the channe=
ls)
instead of the current patch.

- Nuno S=C3=A1


