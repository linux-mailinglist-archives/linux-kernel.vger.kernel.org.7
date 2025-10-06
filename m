Return-Path: <linux-kernel+bounces-842550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDCBBCFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778C41892B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D219F137;
	Mon,  6 Oct 2025 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJIXXkSs"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CF15D5B6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759719858; cv=none; b=dTPjG2H8rIxTr8YfyaTYD2/EgBDvkA/ens5Te84Xs8VZzshuhWiy/9Z70nNI5+Nisy7uzuRZ4rFGa7Il9qayGTeZPkovHp/tOnTQ5qm+PUm5cUXarstBWC0KWcnMkFfVSl+ryihFlfrdU+LR42+NN+TY8hPQsBu8VAIJZpLPNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759719858; c=relaxed/simple;
	bh=zrCv2LuYmCw0DiAsIUBqoGDXiizxKiHny8jAmmjwrG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBnQnfceKiAF6SltyCxT5OMZRaihYQlEBFV4sd+OBRgu3r1HEGAo8s4lwVbrmJWKSi5eBEqoVFu5raMfjRo8OzlWA8fyEtjGWyD9K99/coQslPS4Jt/lOiOICKAQOXnsqtm0gN+I4HvwrSDnxHpUamV+gtwbJsWfLve3h2fHml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJIXXkSs; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3d5088259eso638506866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759719855; x=1760324655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8HZij/mNEbJxirmDzZ6t2wS0k3yCLSvvwCRqNRU6uM=;
        b=YJIXXkSsgC2BoGgPSWJYw5kEoT86Eplto3z1sfN8z54Uy07oKHcC/hjVaIUFtaDU4A
         /7ULBpartBIlKjKPsPe9/dUQttddwyIEx20x3DFMWSWUoplHyT577QrLn35HXLdd2RDg
         n8rRlFEte8KHyrTzBmglmcCGGt01nMCrSfjAVNywtNNyp/GgoefOIGL3S3eb7Jc4Npb8
         9ETmhiySQHBx0PONg7yGkilRzWrJ734CNL1I76/0tyD5Om8nHvJm/hcLMYCfRMygAK3n
         tONATrfZ/K3hP+XFCssyeFlfDYFQ1JtqqlGyPMO2FEFzOJGeNb/Dod/mdw/rtkSobodi
         qwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759719855; x=1760324655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8HZij/mNEbJxirmDzZ6t2wS0k3yCLSvvwCRqNRU6uM=;
        b=OODEPaDNYSVj7ycNoB4LS62cFsc3/tQoDlOs02sU6bBwWU9TwixHOIsIK81Qpfhu+q
         WiDA44doSplVt9mpTHdLCJ6VKsSriW8XdTCh+5bTIt+JcR1qLAxY1R7QSuIijMVWIjxj
         6Q5ICsS//0GVJjEsASqDUHaCVQ34qmSU2E7WEO3fInZZRbPgLo3zZL6KljznHel19xEo
         HPf6N0C22SlQTHMktYXY4MCAkiu9BopNs3XURneP2dcOUf2olHyoEOyFuhVUiqx2s28S
         AHzdFr0eOqMA7gwhX1/v5CriTqQIwFiAqaeGptZgGq148kkCLMlkswHFnUZha0V8ZIKJ
         Zt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdBAptyocyv6MP+h2c5dkSpjMf8fKsLm8Nn+MPtk3nkxAPSr1QrWXsuioANENlUPJHQf8VhyGiGP12fnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwne3cbwZPMMq2OwWJdxYiHge5vOoE9Sccoh41xd3ool6gUypi
	2NvEgFBorGIcq6z3nGYbr7TfqMkQ7i87laujrECqDE1v8YosX0B+/5JR0EnJ2qjJU+PPPKg4F6D
	V2o6N8IbFSpWjZxrx1n3A8EnYICVRDG8=
X-Gm-Gg: ASbGnctNWAESAQfbN0lsZqL9eRjf+CctSKkvQDW2zsiBL9jraO6Rl8wVLpZgq7gyTQG
	i1x1TdPwN+iBWVXVtvB1J/+g/vTB87Vanm1sAps5oalOfr0tn4Uj9U0J4EDlwxZHRMRtdLKw05o
	1laEziXdcj0smd+ssIBYHBTkERy3gUECof612EcWPY63KaAn0je6HmWvuDHaebGNV2d1QZiTEvc
	BxowQJw/ZmoM5tFkg6B757MN0JfQCaYy0CELcc/CA==
X-Google-Smtp-Source: AGHT+IF3g5iOV5bBmvcCjDZVj28/wSv9TwXn03R1OV6xFO9+YKnCOgJo0QkX4WrE9j8JvzAze30xlaVLyrf8o/PLByI=
X-Received: by 2002:a17:907:7e8c:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b49c3b25f61mr1442292266b.40.1759719854642; Sun, 05 Oct 2025
 20:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com> <20251004141231.632c311d@jic23-huawei>
In-Reply-To: <20251004141231.632c311d@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Mon, 6 Oct 2025 08:34:03 +0530
X-Gm-Features: AS18NWCdUtEmwAviFScR6aUatO9T_ZkTtEYw9JwSoZ6crvMFN1TNWl_QFZoYWvY
Message-ID: <CAHc1_P7MU=BYf_8sbZqikpXpfuvAtLNJ2E_hmi-50ohoh+gQcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat,  4 Oct 2025 07:26:22 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> > 800us, 1600us). These settings affect measurement resolution and power
> > consumption. Until now, the driver always defaulted to 1600us.
> >
> > Introduce a new device tree property `maxim,pulse-width` that allows
> > users to select the desired pulse width in microseconds from device
> > tree.
> >
> > Valid values are: 200, 400, 800, 1600.
> >
> > This prepares for driver changes that read this property and configure
> > the SPO2 register accordingly.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> Hi Shrikant,
>
> Explain why this is in some way related to characteristics of how the
> system containing this chip is built (wiring, lenses etc).  Otherwise
> this might instead be something that should be controlled from userspace
> not firmware.
>
> Also, give a little more on why we care about controlling it at all.
> Is there a usecase where power use of this chip matters?  Mostly I'd expe=
ct
> it to be in measurement equipment with relatively short measuring periods=
.
>
> Jonathan
Hi Jonathan,

Thanks for the feedback.

The pulse width configuration is indeed dependent on the hardware integrati=
on
of the MAX30100. It affects how much optical energy the LEDs emit per sampl=
e,
which in turn depends on physical factors such as:

 - The type and thickness of the optical window or lens covering the sensor
 - The distance between the LED and photodiode
 - The reflectivity of the skin/contact surface

For example:
 - A smartwatch/wearable ring with a thin glass window can operate
with 200=E2=80=93400 =C2=B5s pulses to
   save power, while
 - A medical-grade pulse oximeter or a sensor mounted behind a thicker
   protective layer may require 800=E2=80=931600 =C2=B5s for reliable signa=
l amplitude.

I believe it would be appropriate to describe these fixed,
board-specific characteristics in the Device Tree,
since they are determined by the hardware design rather than being
runtime or user-controlled parameters.

Would it be okay if I send v2 of the patch with the above explanation
included in the commit message?

Thanks and regards,
Shrikant

