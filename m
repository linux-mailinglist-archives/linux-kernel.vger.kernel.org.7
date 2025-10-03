Return-Path: <linux-kernel+bounces-841555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C97BB7A31
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D3A04ED638
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3292D47F5;
	Fri,  3 Oct 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwklWhDu"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4024C692
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510766; cv=none; b=AORjWwVK8/Zh7ouan0IzwjhAxzR4BctoIm3SzV6iEkVCUcVRExUf2oWuf9pfgVuPN38YOMGljHc4Tcon7bdqyK5/x6M+U+UVqvTbUfzEtkn+t8ukbNVTs3PnLuxjOAIE8j4H2BgV3BQXnl4drrkbr6L5sdSRGq0uqCXG7mH8knI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510766; c=relaxed/simple;
	bh=DgPDGYkjFCaTNxc7D1DJckR55ZYwlv8zv8mAnZtpLoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvGoHj04VSm/sofKnJ4pEiNHHe53PhYl1gdiKvP4JzaqPYhQZjJjydxSXnrQJG1Lh9cmaqDMlLmpYWbYHza5XpXng90igp9Sfox85xjPq04yayleXhXtLJGwTibXeVNhI07IZDyVnDjmgxevOkGyaBXSZwG88pKlSmkZOTMNPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YwklWhDu; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72e565bf2f0so27969537b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759510764; x=1760115564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey2hQl2GChdmjWekqgYe2FevyryAIx9lLcUl4a62x24=;
        b=YwklWhDuHh9ioqPOC66/o73AAaw6cZxSmzzj7tuhydJyRLCWX9ovQzCzS0DVPXr6NV
         5dXmYTQTPYuFy+lg0Qpk09IDxSSCAvsh+qlTG2Wr+5HHy8LU3MTC0Vf5WjmOEZ5EshoE
         qi5JIV+RsC1pZD8MnAsl5i0HZrual1ZYaaNlAcE4L/6vtUi+0J49BqbL9dTczUWdhE6P
         PMKBWRYhFha+IVK/ghopzhowXNW4whKH93kMns28pNbAGfPZUTvPeUtYyUI2wyMfX/7V
         CPwklE6x+Iz5ByRcgtsgDmUhyvCs8KXHofD0ZAyZpO4IQ9FKggrUwWRv1ZSTqJcIIXs3
         /kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510764; x=1760115564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey2hQl2GChdmjWekqgYe2FevyryAIx9lLcUl4a62x24=;
        b=A8mRP6aWvGalzevz2rMrvxWYn6qkPiVZpOrm0bDiwq+NKR7lTHsScTXSFmQOp1bZGP
         S5KwjzcRSiWtXDwWTaLgrWeCcRQOx3O4Z0uDgspqr/4gQ0YbIwf3Q/1NOQmHbB0QumT6
         6mikcwWE8oe6i5NHRVNOWrPbB4Qh8MXydJXZRLEMsQ7Tq/Fsd5vdH+4Ur65tuX28IVK5
         xbvsKvM4dj9IDKyB0c7WWZlRPkcjl3kxw1nVlnBmoAxveOtWcOTbn1S1NF9b/mTRKyOo
         Psaudde/eRw8Aai+tssFcqaRyxXn7yQT4EaFRXtkDQAkXxrtIx3NB7Pt/xO3QlgMBdBF
         DnpA==
X-Forwarded-Encrypted: i=1; AJvYcCXxGlvUdXxot6BaT9O8CPO6UYMwY4SI1KnvWDAFZY54AjrsdQ1K1HnoWApqcSsr90pkLdH5kdmC09JZzJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/OD2x2MiMXJHQQVPMxrHrhVA5P/bBWEOk5Th07WH7KPTV4O1
	ybqLQFMcOkMaDXm32U789cOK9GX14i9NUk3uqCmaUhvqSIrR4xoQfsC+NPD/FYDT7MdEb/2Ryat
	F4Xr1FtKXhZMMNy8H91khH5yauF3/Ivt3myuU86zRXA==
X-Gm-Gg: ASbGncsQ43w1vTcfny90c4Yukacfeqa2FZUKzC2XXa34TBPetSrDn6XuOIpXo4AsIth
	hpGctaF0WOpW9M8K+hgzFItMOPZJbrRAGPAfH2ZO4bgjR9jEOxMD5oP5T0yyfOosBOgbh47iDNe
	R13vKM0s916LmKZz7qefSTDQKi9jw9pJajNxZigEpXVhiLVS7L8DXkheD1gDpD9+CqUxpXJVzxW
	UrXC/QItsajOC4vSWV5b2wAvXibjxxZJQ==
X-Google-Smtp-Source: AGHT+IHOSCaya5j1WrgfD13q7VBprpuwNz0wIhGHOie5nbBRnqRTXp3Veun2JVFCeXU/wA/r4XvdbDN8sLUyI69MuWU=
X-Received: by 2002:a05:690e:5c2:b0:635:4ecd:75a4 with SMTP id
 956f58d0204a3-63b9a107887mr2589211d50.50.1759510763543; Fri, 03 Oct 2025
 09:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
In-Reply-To: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 3 Oct 2025 11:59:12 -0500
X-Gm-Features: AS18NWAFV0JyqToeLM3t4qinDcAm8LWFKJnGlvlSB4Xv1Ko_x1ir3nxFWFGI1Xk
Message-ID: <CAPLW+4kAzXmd7mv279wMJCT0gVP5A+2Xe0q3MgX1OENH5PC2dQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: samsung: exynos-pmu: gs101: avoid SError for
 inaccessible registers
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Thu, Oct 2, 2025 at 5:33=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> Accessing non-existent PMU registers causes an SError, halting the
> system and rendering it unuseable.
>

I wonder if this issue you describe here is similar to what I'm seeing
on E850-96. When I'm trying to read these files

    /sys/kernel/debug/regmap/dummy-syscon@0x0000000010020000/registers
    /sys/kernel/debug/regmap/dummy-chipid@0x0000000010000000/registers
    /sys/kernel/debug/regmap/dummy-system-controller@0x0000000011860000/reg=
isters

I'm seeing "synchronous external abort" during regmap operations
(judging from the backtrace). Do you think this series fixes the same
issue on gs101? If so, I'd probably want to adapt it for Exynos850
later.

> For gs101, we can avoid that by creating the underlying PMU regmap with
> the read- and writable register ranges in place, because on gs101 this
> driver controls creation of the regmap.
>
> This series updates the Exynos PMU driver and gs101 in particular to do
> just that. For gs101 this is easy, as the exynos-pmu driver creates a
> regmap and we can update the regmap config to pass in the registers.
> For other SoCs it's not as straight forward, as syscon_node_to_regmap()
> is used which doesn't allow passing a custom regmap config - those SoCs
> are out of scope for this series.
>
> With this in place, invalid registers (by drivers, or even plain
> debugfs), are now simply skipped by regmap, leaving the system useable
> in that case.
>
> Cheers,
> Andre'
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> Andr=C3=A9 Draszik (3):
>       soc: samsung: exynos-pmu: allow specifying read & write access tabl=
es for secure regmap
>       soc: samsung: exynos-pmu: move some gs101 related code into new fil=
e
>       soc: samsung: gs101-pmu: implement access tables for read and write
>
>  MAINTAINERS                                 |   1 +
>  drivers/soc/samsung/Makefile                |   3 +-
>  drivers/soc/samsung/exynos-pmu.c            | 136 +--------
>  drivers/soc/samsung/exynos-pmu.h            |  11 +
>  drivers/soc/samsung/gs101-pmu.c             | 445 ++++++++++++++++++++++=
++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 343 ++++++++++++++++++++-
>  6 files changed, 797 insertions(+), 142 deletions(-)
> ---
> base-commit: 5eb97efbe6a375944984e7fb69bb632d2879c841
> change-id: 20251001-gs101-pmu-regmap-tables-8726ac9f853e
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
>

