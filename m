Return-Path: <linux-kernel+bounces-838779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE7BB01EF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7D188F3A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DA15C158;
	Wed,  1 Oct 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pz8/tY2W"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2022C3250
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317547; cv=none; b=kbmkoO8QXTHkrkj9XE7RPWDcPuhSb/wdlTVLzNLx0ebUDfDXvPJV9wcsSj0jK/SsgIwJZ1DWPtO6JejC4/uI7uzYFkD11HcRTEIbt+U63c01/Erdx42k50DrsCp2jXsqOkyXNy74HwSg2ETFDRlDFkvAekyPbMihnBbctx+3SIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317547; c=relaxed/simple;
	bh=1HFBdPH4nuIY6H6y/ZojnkMEpQ1m1rGMA+QhLTxwZMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGB9uX15jUOhn4SGn3vM/vk06omx2Jff/zTtBqBkrhqYJHxleCKoE4c/GW1UCdI1ORuUS8yQ+/TasZaFWIj8vugYUAfyZGOIFmqCYTEvoo73wSt3MyRwdaRgs1vmGcc9yg7kASOws7BiraItE9MwVtx2fosL8RWUwV5qE0OOl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pz8/tY2W; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so64924641fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759317543; x=1759922343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzALmU9leCk7b6gYpUMB7NSJN6+Tl6di9Bbt+pXEhZg=;
        b=Pz8/tY2WHeO3OFRM/UQGLGE7Ilxule3+QElQwLZQR0zfOx3uo4jw4ogCA9oOQ1Iggp
         GMCon4idiaqvEu2nXW71zOTkVYFCyBff+W33OovwPlR4tUYwc2X7R0GLI15lBV+r/n3E
         8+JC23Xc1cuDdF2y8olns7eJvGjG4uyGCC03MZXvt3zULG346ic9PzTBZgwE05OEvD5o
         tV9Ed7FYneS8cvexWhyvXGgf0Obd9bE6yvxD+Ba72dv163ktRMMUCDkUBZBp0b0sdWlY
         1EmEr4trX53xFV5Q5hGQVib+85Q0BFBERK4Xk4LVPf/YAZGCJAjuGn/fBYbmIKJiAmVG
         N70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317543; x=1759922343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzALmU9leCk7b6gYpUMB7NSJN6+Tl6di9Bbt+pXEhZg=;
        b=rJkMJ1MN4fQfe+6Bli4fWFO5l6IJHIDvA3Kr3PdOpuJrKsu+6bX1xVPEWARqx36Tg2
         DsMiTaK9pXmvJG3JvPKovUVl0OGm/ndeouMReBQHEwGxTMWTUHiMmee2PeJcwTgnfQ0a
         TyOClrzMEIQ0OyzeFGSCVyaKZylpO49H+TWZRfj5zjdkCMOEgs6HiyQbYytTLv2QVuYJ
         q1T7aQ43cqoJ9RQ6hYCJE7o2Dcyb45OEyOv9rooHgS9ZvtnV0byF3chtxoYqOKmxBnzP
         cCHpeQ+txrvxRCgPObLKPiTY48sD8EhgRjjG1+/e2r2+YNpWBIfaw1XIrx2zqTvdlJP8
         TdBg==
X-Forwarded-Encrypted: i=1; AJvYcCUz+CqgUiIPBk2H93gh++ygSjmnBrhUrG5eLjQBiP0/PcImZOCDtuY8BA9RGXbNVlVwI+qoUc5gh4lInWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfJufQlwaqE8QFbT5sDn1PIYgccVJNt/pPd1kSK8f3FCvq2+7
	3uSwEVl3xzQoxvayUaR9U9Z91JaN8oSUHFnII6UPRC/Am0A0QggsicR9x9kyWpGZTcb6zNGH6ZP
	czIu5oBR++T9zpW2t9YjX5IACKwojhK2DXgyCBIjYEQ==
X-Gm-Gg: ASbGncumDGK4wijMCYrR9SrIyftzzWPKD0+3S9OF3tdaBRnGlVMZnP5iXLe2nKN21CP
	zSEs3azvF6nwgGr00DT6pky1bbAC0nZi3iydOBPyoFIkEBr0UP3aDM96l5A2QWI/IIWtMDMqFnV
	BHx0knNQ0tMoXmnIF0r0C+Llh8DX3bT90IN4gQP9K5Uoi0X0zd7sZ05n5uiqc5dl9ktgg8whxXq
	1qhtMfn28icsddpWn0hMkcMB4nL+Wg=
X-Google-Smtp-Source: AGHT+IEjhWzPMlj17Uy7qd2LicirAASApXwhCe4VbKO72/os2UztLtK5uJY9uTbzBv/l7QF9CdPnWL/3cGWP9kZX9p4=
X-Received: by 2002:a05:651c:1988:b0:373:a537:69f6 with SMTP id
 38308e7fff4ca-373a74c163dmr11755181fa.33.1759317542967; Wed, 01 Oct 2025
 04:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <5331035.LvFx2qVVIh@fw-rgant> <20250927-spoon-yearning-c1a8df796173@spud> <5926760.DvuYhMxLoT@fw-rgant>
In-Reply-To: <5926760.DvuYhMxLoT@fw-rgant>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 Oct 2025 13:18:51 +0200
X-Gm-Features: AS18NWBS8-yzFEbPE539-aBIzutpc2mebsewYlTX4Q1OfyH7iUd46IqQowJM_Kg
Message-ID: <CAMknhBGOpODxmzU9J9nqGDKGzn6KKFV5Ed3okLvecKtHhNRB9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 9:12=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
>
> On Sunday, 28 September 2025 00:31:05 CEST Conor Dooley wrote:
> ...
> > > >
> > > > > +  lltc,fb-voltage-divider:
> > > > Why does this property have a ?linear? vendor prefix?
> > > > Shouldn't it be adi to match the other property and compatible?
> > >
> > > This component was originally from Linear Technology, before it was
> > > acquired by Analog Devices. The new properties and compatibles have t=
he
> > > Analog Devices prefix, but the "fb-voltage-divider" property is alrea=
dy
> > > used by the LTC3676 and LTC3589 regulators, so I left the Linear
> > > Technology prefix for this one to avoid introducing a new property ju=
st
> > > to specify a vendor prefix change.
> > >
> > > I don't have a strong opinion about this though.
> >
> > Do they share the same driver?
>
> They do not. However, they use it in the exact same way, and I would've
> liked to factor out the handling of this property in a future patch. This
> would also make it easier to handle other types of feedback pin circuits
> and have a generic binding for "regulators using a feedback pin connected
> to some kind of analog circuit".
>
> For example:
>
> Vout----+
>         |
>         |
>        +++
>        | |
>        | | Rtop
>        | |
>        +++
>         |
>         |
>  FB ----+
>         |
>      +--+--+
>      |  |  |
>      |  |  |CCS
>      +--v--+
>         |
>         |
>        -+-
>         -
>
> This is all speculation at this point though, so I don't mind changing th=
e
> property to "adi,fb-voltage-divider" and handling the different compatibl=
es
> when it comes to it.
>

Could we just make it `fb-voltage-divider-ohms`? The -ohms suffix
makes it match the standard property-units suffix which already has
the uint32-array type. There are a couple of bindings that have
`vout-voltage-divider` without a vendor prefix, so it sounds like this
pattern is considered somewhat of a standard property already. But I
think it would be better with the -ohms suffix. For example, there is
already `gw,voltage-divider-ohms` as well. But there are so many
similar properties without the suffix, it is kind of the defacto
standard already, so might be better to stick with that rather than
making it even more different variants than there already are.

