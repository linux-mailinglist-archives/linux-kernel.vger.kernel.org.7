Return-Path: <linux-kernel+bounces-758837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D3B1D46C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9D65640C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67723B629;
	Thu,  7 Aug 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY6WGZPD"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86511400C;
	Thu,  7 Aug 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556479; cv=none; b=gLTuUNVaADFItx7SMkuYz7r/8wz8oajx5bQ1SzOWlHKdVEKkiUiJqx4iwyW3APH+M+grwUvtdDZNYUG+cFx8cRAOc5e/cm6M4u2uaDmLLtceeE0szqGEQZRUffAmV9Z5eDNsAU9R7fDlzlrNKXizEbPwRmeAUYc1VYuFCUzyptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556479; c=relaxed/simple;
	bh=UXzuKK0SXZzuuW76ghNzmiNIpvyQpByfO4po8zV8dgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7/HqGngp6CJusiCZ6OooibjK8+PunrhlNSn+KgQ7/0M3mC3TT0zsPol4p9ZrfIfEytNcZSQzN95OVURtJ3cvDweZwsHBq2CqLfvD0u6Xv+5aoc74DtS0MP4p2EfPH9iBJIzd5RuqUFPVAKVRcjLK+DFkxRTXyTaVo+u1pv+yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY6WGZPD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7086dcab64bso6991177b3.1;
        Thu, 07 Aug 2025 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556476; x=1755161276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVf9LbLojcCuAhT+ga1Vyf947M38uWa9Hm3uYLCKQ/w=;
        b=bY6WGZPDnrK2H7GoO7MeqRtn292thEhcN4wBlPecpThcYLxMXKqWrtgZCVgbM5UK6w
         CPaRs10LjU3qTVvFUs63LRAmHoMx+RzhyP1dJ3lMlcjqeZAmG5WZ1Rc0VCKqSBhHmlm9
         JJbfHeqb9BOu/EfjvzrAd1eyF/tbsDU1BmsnhenV+cBb+Jf3bD43ytf7pRThE3np+gyf
         4VBwOJBVuUT/7Aht4CDVx7b/S4s7QUqQODHRcllT/zzmGhNgRKnRdI12yak1qU6jW78x
         4h4+aHWq9fLaB0mG0yPFw9jZ/j13f4pBauOnffm3A4HyDQ156mWbEV0qq0GMfNNgHeXm
         pUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556476; x=1755161276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVf9LbLojcCuAhT+ga1Vyf947M38uWa9Hm3uYLCKQ/w=;
        b=Q4/6COBygLWAcKrMuEPeFKYflWZ8Ztu+PdVpNHK+2K3aVcZJlyp6P3hKNaRyGNOO65
         glNDXglovR0AULMwpL+5PaQN7cavBqWPB1Q/iwlBLekcG0TlH/SAlTlIWdvilLboYiCt
         PSYcDllK1MyzlsXbfk2zz3Ew/g1MSskvoQd2eKP05r6oy3RUOD6/cPVK8UXVYzwtp5UJ
         BCfgNwXTBNKCM7jz4h0kTe7NF16fihBfOcR25jnWOxAJjJyckxD5oHW9b0BqljBxxWJm
         nHWZ0HM0BI8dD7gyKYno+2vNRA2WqLkhc0tkExe2x7GyHlxrnA6sKOaByzgLrgRkvgEA
         YV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVT5Nw5MMPLX6dYtlPdHOkPDwWA85AO8kFg6shK1r81FwN/KPxIpkaUmgvJQo9xGW6bSujoxkQBuqIj@vger.kernel.org, AJvYcCWGqT5IdXTvhr20vQg+TTi2PFeFO+mHnEpa09eXGQFX0YKXg53yckQ4dWs+UkLVZJ/8FyCeu6cxpy0pTzYW@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfOR0va5f9xQ6UtiyN4EFUu6XY39bieQUU0DjzWlfiBzw6kUO
	kZWvRQUZ6Hgag1oaSgCuq8hUt6ULU9ZcNtVl4e0HVsnKvf/CVvS8m5H6ppX425ZcfFyyI/oEg3Z
	ukyZJiyNup3u6dF3SVCqWu77o7qXsiyk=
X-Gm-Gg: ASbGncuJL54e6EbrKkx3UIfhi0XE6Vb/IKDMZicUeOnfLqFJgSkrKbw3ItMCQE8saR8
	Pii3hLaORWNijzhMWocb14U+eaxujnVLhlYtzpncjCRZN5SSw/dVJPB//xu5zUKOLjhpelViQXE
	vWwzCVGV0XPT6A/YvotVkz/DPvrKfNlHbMLG0ad7CVs/MIYHXP5j8/2Xasn1g0eHZiDNLWvY8DV
	RufSb5NdATvvquSEOsRM33WFlJ/yTEtqvZUaJs=
X-Google-Smtp-Source: AGHT+IEF1Rgl4ol8b1AK0WWialQnOn9GOQ4H+uDN0nCUOKmheNAVCVpOijMHFOdF8iQRgP3klAdSVLKEPQEyQTej/FU=
X-Received: by 2002:a05:690c:9692:b0:71a:22e1:b351 with SMTP id
 00721157ae682-71bcc7fdfb5mr76969767b3.24.1754556475564; Thu, 07 Aug 2025
 01:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
 <20250806133824.525871-4-rick.wertenbroek@gmail.com> <20250807-inquisitive-speedy-rooster-0a8488@kuoka>
 <c86bcdf0-f692-4263-a597-f8e36a53e8d9@kernel.org>
In-Reply-To: <c86bcdf0-f692-4263-a597-f8e36a53e8d9@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 7 Aug 2025 10:47:18 +0200
X-Gm-Features: Ac12FXxEzSnPsqcq49lE9KwQoWiI6TiOhTQgKrxWtGYG3DN0QkxgVCWP6jlC5UM
Message-ID: <CAAEEuhpHmW9hji91tbQ3MMhBZELCYc_vA+Ra3oC2W+Rf8LLC6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: rockchip,pcie3-phy: add rockchip,phy-ref-use-pad
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/08/2025 09:54, Krzysztof Kozlowski wrote:
> > On Wed, Aug 06, 2025 at 03:38:23PM +0200, Rick Wertenbroek wrote:
> >> >From the RK3588 Technical Reference Manual, Part1,
> >> section 6.19 PCIe3PHY_GRF Register Description: "ref_use_pad"
> >>
> >> "Select reference clock connected to ref_pad_clk_p/ref_pad_clk_m.
> >> Selects the external ref_pad_clk_p and ref_pad_clk_m inputs as the
> >> reference clock source when asserted. When de-asserted, ref_alt_clk_p
> >> and ref_alt_clk_m are the sources of the reference clock."
> >>
> >> The hardware reset value for this field is 0x1 (enabled).
> >> Note that this register field is only available on RK3588, not on RK35=
68.
> >
> > Then you miss restricting it (:false) in one of if:then: blocks.
> >
> > Also, binding cannot be after the user. You need to reorder patches.
> >
> > ...
> >
> >>
> >> +  rockchip,phy-ref-use-pad:
> >> +    description: which PHY should use the external pad as PCIe refere=
nce clock.
> >> +      1 means use pad (default), 0 means use internal clock (PLL_PPLL=
).
> >
> > Can't you deduce it from the presence of clock inputs? IOW, if the
> > clocks are physically connected, is it even reasonable or possible to
> > use internal clock?

Thank you Krzysztof,
But no, if there is no clock, the driver deadlocks, it needs a clock
to probe correctly.

When there is a clock physically connected on the pad, you can still
choose to use it or use the internal clock, this is no problem.
The problem is when you have no clock on the pad (as it defaults to
using the pad) and the loading the driver deadlocks the system...

> >
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    minItems: 2
> >> +    maxItems: 2
> >> +    items:
> >> +      minimum: 0
> >> +      maximum: 1
> >
> > More precise:
> >
> > items:
> >   - description: PHY0 reference clock config
> >   - description: PHY1 reference clock config
> >   enum: [ 0, 1 ]
>
> Eh, no, rather if this stays as int:
>
>     items:
>       - description: PHY0 reference clock config
>         enum: [ 0, 1 ]
>       - description: PHY1 reference clock config
>         enum: [ 0, 1 ]
>     default: [ 1, 1 ]
>
>
> > default: [ 1, 1 ]
> >
> > Anyway, default 1, 1 is pretty non-obvious, so this should be just
> > non-unique-string-array (and property should be like
> > rockchip,phy-ref-clk-source/sel).
> >
> >
> > Best regards,
> > Krzysztof
> >
>
>
> Best regards,
> Krzysztof

I based my patch on patch :
46492d10067660785a09db4ce9244545126a17b8
dt-bindings: phy: rockchip,pcie3-phy: add rockchip,rx-common-refclk-mode

As the option I add is extremely similar, it sets a feature in one of
the PHY registers and only applies to RK3588.
That is why I used the same style as rockchip,rx-common-refclk-mode.

Wouldn't it be confusing or at least incoherent to use enum for
rockchip,phy-ref-use-pad but not for rx-common-refclk-mode ?

As for the name, I used phy-ref-use-pad as it is the name used in the
RK3588 technical reference manual.
(Similarly done on rx-common-refclk-mode).

Best regards,
Rick

