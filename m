Return-Path: <linux-kernel+bounces-844680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5114BC27C4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E883BE499
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD9229B0F;
	Tue,  7 Oct 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7f2+KZM"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1561C8606
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864688; cv=none; b=hjetzrWRGw+Qw85KDrhidOHCTXmf2V1U6ZrkZm8tIAKNdVUa46CQU2eGgcB6i1O4Eafbc1kjn8UrWp1hqcYJ3zUCGbYn0ZaUFMjvzohuGRzmmMcQfw8VqMzw3JbEBw9hwpvsMZxWKGyo3WdrprOZcg9RgVuZ/fIr67wjssr1Q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864688; c=relaxed/simple;
	bh=c3t+aHhOX0sarnkVktCMNDd+aJo1Oiag+yfGXxQfFjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpIMxf5ZTI6whwkmiMqDX9TgKq9vOoe4VyncIO4YiFK/QlanpJ7uab7npctHx7M02f1higCUyTrTrHJ5VSFfV7YFq2Se/8sxwi2gu1+JviMsPNRmEmJa2cc6veG6glgFj9zWI22wCZn6qyCvBmTcBI+Fkf86uNglvNLQakn+BBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s7f2+KZM; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63bbf5f77daso4350687d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759864685; x=1760469485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w56vpyq36HF8RpsGhMYvJCK01J/8OiGiiJ7vKt8zJro=;
        b=s7f2+KZM0pERfV+X1Edolsait8/hONhFfWX7TqGZpPVxdPZqnAptkkyhddMeeRQnyr
         kr/wPh1/C6sIekZLIRH5ToP8GUDiloNLjzUS+MF+CtqZoST6p8eQANN6RMvznO8Scnrk
         SLRysQY4Efst4PnRp/scmYwTHyUm8m4Bp2FP4hdJreA5wgzEEQ7iLB43oYVKvwZaEciS
         GlBfGmUOt3ZLTW1KSWCbxVlNGyv8I4+uK7T0+NWOLU32CFfRM2veu/9hHvx+WjseojjE
         BiDsnFkWVZA1POhbBw6AZhIWMy1HTUWuEoNmFgoLNdLcPeDim35CkpptzEXXMpuod9JW
         vNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864685; x=1760469485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w56vpyq36HF8RpsGhMYvJCK01J/8OiGiiJ7vKt8zJro=;
        b=HRLTxYOujDUlx11f8vVfqGmpvf0hM7Bj9CwG25OXgz7EZyTHo025RouxWIx62we76D
         rqQ5LN2XfU6NRsi0VVV7aNedHhl8unqqsTfE8JF6OlOqsJtqyKWpgBYu9ekD7C2Q34u3
         5w8u8ZXSrT8geLhI/98Q/T6tg6P3hoXZBGBIctPGm8/nnAvWfMGYmcRdURsXQ50E935I
         s47rONPDM5qWKFoCx7L3mRwb66X0gxVnbHG31j6eByd0BomRIv/uck2tFLY98ylOriJs
         dd0m4BAACUzCqiaRJ+bp2PmyYC4pgqgeb94ZZy00+YGDeDjwY286yiUP5amuFvhXgyOe
         uYXg==
X-Forwarded-Encrypted: i=1; AJvYcCV//a8Q0RdIh5oXmUfUqRp7EeAUPVNzNIpUVOS5Z7ezh0rCmPPHKz0jgb3gx23rwBM0HKpv9+Qi7QixXVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR97xt+siZpfO7pWA8VZPGDSkACIpp+EZM0GkpPymFYHbmywY
	MDPDJih0+t0RjGrMpiTdT9eJdo1D+kax8IvIHMEYMOh1/tCEnpsR+7v1tOg8o0K/GkFvqJilNoG
	F9rAFv5Z8GSmDOxdGgvAxGt0OhLKl9TflY+EKeCUSYQ==
X-Gm-Gg: ASbGnctFTtEU/bqhfvWSXwfVY47AwZw+CPy4CwyDAm/fAU42c3AoUjESulubBqhDxRM
	248MnI+tRql3XjtZtxWljh1Hb28qMBx+dL8oljYklFXeiIouUAPi/6ydKecC9urnbDovB0VIL2W
	C7Gh3FyHFmWwbwJ8WZBlXR6rfA26P80vJK+DyBeRykzEYGesrV6zDOjLw4FHCvV3gZH+PAD6O5+
	WlhOWDVs/ObQnpf3UaT2xwMRcQ2rUswIQ==
X-Google-Smtp-Source: AGHT+IGMX2m5vC5IgwIyyLUsmiZiXribIWN75UHjEqcGSweB7XgIU8ixi33FHOzX5pt05B8rZ7NfuKMui5fZiPzZq0Q=
X-Received: by 2002:a05:690e:429a:20b0:632:9d08:e3ec with SMTP id
 956f58d0204a3-63ccb8d82damr755481d50.25.1759864685141; Tue, 07 Oct 2025
 12:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
 <CAPLW+4kAzXmd7mv279wMJCT0gVP5A+2Xe0q3MgX1OENH5PC2dQ@mail.gmail.com> <a09b6b493b41bff39000df61dd14693af8b0f053.camel@linaro.org>
In-Reply-To: <a09b6b493b41bff39000df61dd14693af8b0f053.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 7 Oct 2025 14:17:54 -0500
X-Gm-Features: AS18NWDVKcO3PeRXDNI0DF_p50lDT8d8A_Mox4i1JZNZGvpUO0f_-kjnkIWXx_o
Message-ID: <CAPLW+4mitF8rDcKdp3Bgs7sF88WbV981hEkM0LiTqYKSLN2_Jw@mail.gmail.com>
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

On Mon, Oct 6, 2025 at 1:36=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> Hi Sam,
>
> On Fri, 2025-10-03 at 11:59 -0500, Sam Protsenko wrote:
> > Hi Andre,
> >
> > On Thu, Oct 2, 2025 at 5:33=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszi=
k@linaro.org> wrote:
> > >
> > > Accessing non-existent PMU registers causes an SError, halting the
> > > system and rendering it unuseable.
> > >
> >
> > I wonder if this issue you describe here is similar to what I'm seeing
> > on E850-96. When I'm trying to read these files
> >
> >     /sys/kernel/debug/regmap/dummy-syscon@0x0000000010020000/registers
> >     /sys/kernel/debug/regmap/dummy-chipid@0x0000000010000000/registers
> >     /sys/kernel/debug/regmap/dummy-system-controller@0x0000000011860000=
/registers
> >
> > I'm seeing "synchronous external abort" during regmap operations
> > (judging from the backtrace). Do you think this series fixes the same
> > issue on gs101?
>
> Yes, but for the system controller (PMU) only.
>
> On E850, it appears to be the same and there are many holes in the PMU me=
mory
> range. You can confirm using debugfs by manually skipping invalid ones, e=
.g.
>
> dd if=3D/sys/kernel/debug/regmap/dummy-system-controller@0x00000000118600=
00/registers \
>    ibs=3D15 count=3D1 \
>    skip=3D$(( 0x28 / 4 ))
>
> should give you register 0x28 without SError.
>
> while
>
> dd if=3D/sys/kernel/debug/regmap/dummy-system-controller@0x00000000118600=
00/registers \
>    ibs=3D15 count=3D1 \
>    skip=3D$(( 0x4 / 4 ))
>
> should crash.
>

Thanks for the details! Guess I'll wait for your series to be merged first =
:)

> >  If so, I'd probably want to adapt it for Exynos850
> > later.
>
> +1. Note though that a custom regmap is used on gs101 for the PMU in the =
first place.
>
>
> Cheers,
> Andre'
>
>
> >

