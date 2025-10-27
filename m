Return-Path: <linux-kernel+bounces-872660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF71C11B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BB25627BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469B2F12A0;
	Mon, 27 Oct 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5q5hdt1"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C92E2667
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604462; cv=none; b=hIYoz2jJgzS8Lhkosmc5zsSG2ZNCG/y/EXf5qvfl6/5R/o72e4fOH4Zi3ijp0yUoNarPsWngxbecCaIjyXJwz0S2pGzW+XCVjGrzROVIE/O/HYIptyWKJCyz8Wt8xAkmTcKJT+6qVZI9NptBRDSRdm0WYrEcbl3BDjdP/Jgd3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604462; c=relaxed/simple;
	bh=6FK4Cywp2kPqN6IZB7Pn8a9qrx5ElGyAJ2bbf8tmYpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lsl9VgrOjGuebvBAYTQIfV1SBjuhdREVYW9uXG0QlBlM9KexwVdMuJaVKxIuM/9Qe77srro/f7+pOMsI55EDTeuGrgCZ7KeE7pq2VOXR9N/gXEW4n4ZT6jeEszCOBf1bWkyjVYu0Tn1pRdGPo3NHoVWI11CxaEL3Ide9fjojCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b5q5hdt1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78617e96ae1so5533947b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761604460; x=1762209260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FK4Cywp2kPqN6IZB7Pn8a9qrx5ElGyAJ2bbf8tmYpc=;
        b=b5q5hdt1cL9wVjYbAkH1AYKzJIgDa5TsWEjX8dyjivJOfapORAREYYvKyA/iPWm2tj
         jdLTg/5lfN55rkoJPgsEVGdUUKXpnBalcjBCv9TtrNcFVVjF7GtDNvgnSNmVkkIaYPXX
         hpudTMw0ZlFb0tm9eSu2JnJQUikJ6zvK8L86g2qIJIf79h3o34sKAoMSgGLTUlqpgwX3
         1TlTTn4jYV6lUjIyYNmvhByncI+JbC3ej7P1WNKFYhjzWg0Nrp8AEllBjroEKywayMr6
         C7hDksahGiwpPgmSCsPbroAyx8bvOirouB7KbQG7gjXbTgpmTH4QdM/Hwct/DAefQ9No
         nbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604460; x=1762209260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FK4Cywp2kPqN6IZB7Pn8a9qrx5ElGyAJ2bbf8tmYpc=;
        b=GysobnggwtoN+KJRbFwOycH9daUa+l1TJlaQm+QUtFf/9kppHE5OyxoidlvFinJ4oU
         4TvCsl9I8Jov+1rpmNZb5lIvP+1soH1Q2iOhC6TRz+z2/hSspNGhwKt8dTeZ1hRPluOS
         J+a0dKt19XYFKLko/fdSzMAqqvUXGzm2ZfnxIdqIgseWkmnIOOVmUZJDmTjLxN4vjeHL
         RislcOPV5z2gYuPk08EOVzvTHBE8FgwgGm6CkOKXNrXln5Z4e2KHfQerPcD5BHg11gn1
         AJ4Z+quuiFDrC9UBWddjkH+1fiQR5CvyZS87dwm+IJ7QnKLNrK8Lydztgdl5mnxInOZ9
         TM4w==
X-Forwarded-Encrypted: i=1; AJvYcCWXhKRiglFrSREN6Z0dZwc/pEvJd5sMbOSfWmq38xelryCafCaShqpX4Aetgp6IuQoHHQRQZBK2glBXboA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33DVp7LaqEOUaeMrbPRLj35r5Q0Z+fctvKBTHOL4DFLVYiVh6
	l/ErHfEswuCqXJ4tNtY2ezRC0RKxf8tWmWvZ5opOC8dacgzNecGyWRdnTUn+i9DHT9gJgDy0/Km
	M93kX5CBVtpgb1Ftebt3H7PPt0p18/L/dd1f/qDhzcw==
X-Gm-Gg: ASbGncvy6/DsGitPFyCHuoDzTFz1jLbHai1b5+n9TACeHtAoRdPdDjeOmdaW/Its4n3
	xE7a7C/nb2Fg2S55jMCohbzVOD0M+QNypj9x3V7SlV05D8xUbf/hGYkiw2/jlNlgjURUU226LuR
	23XjV56GgH1QbsfL42z+9ty168XZR1LJfuFA3iR/RVf9z0rMbPlid59+dg2E3xEF3pTdJTLVehA
	dlgHIk6EJTY/ybwEF1RYIa0YbV/bKXCV3CDHLm/KZOe+Uxcu5PCFJQFQdvv
X-Google-Smtp-Source: AGHT+IHFxrQwcIAfHl/EDjyJgU4+jEXTaSyjinBJCcTfFFs/TuXmdRuhxaYs6OB/9vERDl+26CgqDxFOu0ooMCeyJi8=
X-Received: by 2002:a05:690c:a00e:b0:781:1c1a:98f0 with SMTP id
 00721157ae682-78617e5fb66mr12794187b3.18.1761604459817; Mon, 27 Oct 2025
 15:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761564043.git.mazziesaccount@gmail.com> <e8d0273bcf0ac67382e17c40be87d345e28ac06c.1761564043.git.mazziesaccount@gmail.com>
In-Reply-To: <e8d0273bcf0ac67382e17c40be87d345e28ac06c.1761564043.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:34:05 +0100
X-Gm-Features: AWmQ_bmCeM1hCEpCcloBtHCP-z98b1djEaHpBG8dS_Pa6X6P_LL8sPGseuESUz4
Message-ID: <CACRpkdbfjqbmy5EbLApee3p9TEsEzBKOcGMrbspeWxqUc_niiw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: power: supply: BD72720 managed battery
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andreas Kemnade <andreas@kemnade.info>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:45=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The BD72720 PMIC has a battery charger + coulomb counter block. These
> can be used to manage charging of a lithium-ion battery and to do fuel
> gauging.
>
> ROHM has developed a so called "zero-correction" -algorithm to improve
> the fuel-gauging accuracy close to the point where battery is depleted.
> This relies on battery specific "VDR" tables, which are measured from
> the battery, and which describe the voltage drop rate. More thorough
> explanation about the "zero correction" and "VDR" parameters is here:
> https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohme=
urope.com/
>
> Document the VDR zero-correction specific battery properties used by the
> BD72720 and some other ROHM chargers.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

From my PoV this looks good, and makes it easy for engineers
to read the DTS file and understand what is going on, so after
addressing Rob's final comments you can add:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

