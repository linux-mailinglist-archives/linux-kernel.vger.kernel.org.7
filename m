Return-Path: <linux-kernel+bounces-773942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A24B2ACB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF87218A73FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674C2561A7;
	Mon, 18 Aug 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u06rAZbl"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529C255F28
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530541; cv=none; b=bsyuXUeuXDvV6VrbZu5ACh5zt+6Ghs83XFUDoVV9mTEcIADIOLmXwZWPpmGnCQQUMN7U9j9zgpym6ErVUtWSzq/0bIvIEesL4hXbcFa/S9/VyH+sOVmdnAiEX6T6pbOgE3vT7WZCSNj7UTs5u47MYdqpwAQqW74X8rg6RUBx1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530541; c=relaxed/simple;
	bh=TZB6OzqRHkfT0at7DfysjFW1dYU/QwDxNcArpH9FPJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDKcb3B06CGqell5fXN9Ah3Lc3OQg35SgMiOZuXfd/kAjb7gVofiDYmcqHD5h+Dl63Fi2EmmQq0pfNd8RFLUChVUFpBgBjmHuDNczXPyelboCwxwXX7TK/vGquKfheXek2ok8KFk0bghICWFhPnl3S4bdPz+gkNQlSyzthZi4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u06rAZbl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f8ef379dso35836441fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755530538; x=1756135338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVZcBNGwpkq+v3DR0vvpafxBkSL/1KeRhlI8oyXPu5U=;
        b=u06rAZbl2IKE5aHqI29nVAjfqYPmxsWvrYsyHBlAY+SwekxsfWfAGIC8oAlGGBhBOD
         wugb5qxb3xnEuUyB8rXIbkTNNY8fdDdsbNTIc/Au5PBccylFzxKaJosRKuhoo0fJHZJG
         NIlWCQ7Vtd4B2yhHdr2A7aOtM7LnoqyPru8SHYjAZVk3u/K2WTVWF8VUTAAeS3t1rto5
         zyiy9gXs4sZ/3SLQ2tBq64TO64PUhPUC8CWNb1kHMFwD9sihRygUxt6BIyA3SaaULwfg
         2RvGGxV6djsdbbsQBJg7tWrbdJYxzxk8lNdguUDp6rMxHPJtwI2sf18JqKPZYLGnlP7g
         kuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530538; x=1756135338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVZcBNGwpkq+v3DR0vvpafxBkSL/1KeRhlI8oyXPu5U=;
        b=BrwIdnjjLbjLTTYr5gy7q6LlUG0EvqX949slbM+C3iA3vrFwAHJTd97ijjE+ZQD0nz
         JvCxGsi0fEp/5CBAghe0WlhcnZ7gLzN3pZpkdzx6DiD+uNReoET1Lvo17Y5eibseWzpK
         Yrqx8OLA8wB3Y41mmZX2fLeNLUIswCySGn7+KVySzoLMoXFr56Xj5f7prD9190RT0W51
         Ag9q//sQOTaqT049u5tfznsjCrfawogL1tdTrIl2Bf4mm8NQj0trBNCndd3cvAT1i8Jz
         SLG7BMIPKCqIlIwEOCjCFSB5AYK8gDofT1uYsBfYu+JrUIkFYWcHY8uey9GGxydMbDa3
         spDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLi6eIv6HlWRSodqION5B0tCtvHEIJWi1ywLqqNpVCp1/Gh/XRuYpX1hHmpdlGb6R7w6PxKPDA7XIEGp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30OtNQUMLzvjGXRoskyA1GZJcst8q25lQLE6dFix+98W8aUje
	ep+mH11w/o4s37mefPv8N5O7vJGOysJNKX2VaqoSGWeKdFMi5LKEXt1JngQY7Dw2HZGrMno3LWX
	+mxf5eZhWI/jeN6U4U8SNcFGfZWJRTJJJhlZ1FMzSmw==
X-Gm-Gg: ASbGncvplJs8m3OTc2/00HVmQ8oz+GVC++whsQS12bvBEp1fV+8nQ+ewNPYSMTxGDQb
	EFbe3UQ7DKgvBGLlH9F8k7xTcuwiM6KIJL3E0CGGW9loN1zCIZPYVnZZX00J0HAY6reAkVB45oV
	bRHajPi5DnPDcguFETx7eDPRjCCu74zx/SDpBmCfv1UYK7fCGFQCHQ6V86pZSIncwbRcQh2aW/0
	CunGlBKU2tK
X-Google-Smtp-Source: AGHT+IEuIn7Pd5TPUO8L66bFb+S5ecBGsVI6khVLYk/8B6wK0KvSrOChhN5fjVMUxuyUcCqgOaWvaaAbYkhBGXf3lsc=
X-Received: by 2002:a2e:bc1b:0:b0:333:ad65:c4bd with SMTP id
 38308e7fff4ca-3340990b5cbmr39999151fa.23.1755530537596; Mon, 18 Aug 2025
 08:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-mtk-dtb-warnings-v1-0-6ba4e432427b@collabora.com>
 <20250801-mtk-dtb-warnings-v1-8-6ba4e432427b@collabora.com> <CAGXv+5EHk=f62+KiLo-aWMcd0-q+_59kno+uOW5rdYaq5q+5tQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EHk=f62+KiLo-aWMcd0-q+_59kno+uOW5rdYaq5q+5tQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:22:05 +0200
X-Gm-Features: Ac12FXwpejZ0ETsmnb_X42vgeTPsfQZWI7EY17l_sz1-eYnLo5UFkub2X4VrxBw
Message-ID: <CACRpkdbWctNH0XJfcHfVJM9Etp0WCXpdyhhyaQemH-Xc0LDr0A@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: mediatek: mt8183-kukui: Fix
 pull-down/up-adv values
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ikjoon Jang <ikjn@chromium.org>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>, 
	Eugen Hristev <eugen.hristev@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Julien Massot <jmassot@collabora.com>, 
	Sean Wang <sean.wang@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:38=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
> On Fri, Aug 1, 2025 at 7:18=E2=80=AFPM Julien Massot wrote

> >                 pins-clk {
> >                         pinmux =3D <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
> >                         drive-strength =3D <MTK_DRIVE_14mA>;
> > -                       mediatek,pull-down-adv =3D <10>;
> > +                       mediatek,pull-down-adv =3D <2>;
>
>         bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
>
> and so on.
>
> ChenYu

I agree with ChenYu, the more standardized properties are the better it is.

All the custom properties makes sense for an engineer working with just
that one SoC (like the SoC vendor...) but for field engineers who have
to use different SoCs every day this is just a big mess for the mind.

The standard properties are clear, concise and tell you exactly what
they are about.

The argument should be in Ohms though, according to the standard
bindings, but maybe the value of MTK_PUPD_SET_R1R0_10 is
something like that?

Yours,
Linus Walleij

