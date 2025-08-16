Return-Path: <linux-kernel+bounces-772199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512EB28FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6301C25AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871A3009E8;
	Sat, 16 Aug 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnI0MfoD"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D82F7448
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365363; cv=none; b=DqA69DR8fQph4dtfN8W1gN2qJ+MK4U3QCw8SnQvpO/6oJWmURYXAdRRPlJ+HopuW36YQyrnNQElgATomq0tWMZIO+52dcIiQI6oTOqrYbSUzzUMS3xMtUOuF1a7N3zrSgjPYSrDR1qpope3klidjhbLvQqIh8RBMu61zyUR2TLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365363; c=relaxed/simple;
	bh=N7+bvANbkNhrvL4ERM56Bdgs9ROg59ZcIUOKIv5dcY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPUWzMyQ8wMEP7wm1Viy951173iCgIkHUrO2B6ptPGCC0hPNp0yyEjY431/rdkUfcbadoSJ0CnwYdTy4VPBZTaCyg+UDFAMznyEZSLwh24+NFe9pjXHcwAqPuhz/WVHGnFt7ie2A3voQK3+IB1WUOPB1eudChtZ/ldr9yJJ9jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnI0MfoD; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e933f00bc9bso444086276.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755365361; x=1755970161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+5JiFhhalBPjoGGIh6ZSZXsJU98iPlc8m9JpyheZsA=;
        b=rnI0MfoDrlFK30uELp59NGYocfNReI0jzEiwooetNLdYHSNTVeJNji1HnmJ7REBlLn
         vN1n7as6DONoOAyOoDTkNZ1N3iFlo2sjdjMlIxu4n5E6SU56ZuWfbtXGkJQvOuDU9o6Z
         uLtOIz/OpdwIYWbNFziclsk7uCNODnDbUAUORRTGoTXDagv8SZuEKOIxo7iQOY6STnXx
         Rz/QOmT2ymeniq0du6wUWiySqnxpMjwoP6vEbleVH/PM5SWG0vNWKI9xqqn6pSbq6KoL
         ODcihrSja8vDahqeOA4ksmEaP6erUKYp8Yv2glICN45JRsGE6YsmPmjX7haRWkiUODGb
         un5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755365361; x=1755970161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+5JiFhhalBPjoGGIh6ZSZXsJU98iPlc8m9JpyheZsA=;
        b=Ap0u8JLHeVIXRiCY70qVb9o62PUN1jQEJngQv8UVuSXDwn/c24cH09TnhYsdFIdMbI
         QUGk6I5y+FBLwffVYq5D8lYYZVrO9KJ8oetQkY1kQaNfqKhG9RUpXZsGBtlRlBIRm0TH
         qkZPmaRAREY7EgZHKCV7WBmkxGNIuN/Rs2CgdUEVlbPB7mEvaPiO+kesCt3Shl+wRYFk
         J+7EgMMuqv7bBVnUWRj6yk0nZO/UWqCqSfDjjU7DM0y22lZr9w2K/eW44yLJBVdC9KX/
         UZy7i2hSQ4Sj3kKtVFENOpVo9ZhAp89CcRaS88QfX4vOFFBUm9KM39+HGK/O56G953en
         zSfA==
X-Forwarded-Encrypted: i=1; AJvYcCX0g+dTb8mEh2/k6swY25ofC6W+v3B6MLDTKnjS3kGB/0qho+86zsfEZqYUoxOwtFM50jo+kWOMox/QSGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+J9XSOiNCfPdxCvONAOpkVMy4auxvNGFskXVbyNwvR8tFFM4
	PsivIhDoaeOzXwO6IA4Rqz6YBahjEAyUyvGYM+xeIwcly8EG3UIy0qe63yEYdYv7fZcL+JilQCV
	12pd0o3gv+0ctN1+uNlUVyhlcXU6KoIojsHHwR5qZHw==
X-Gm-Gg: ASbGnctmJUIabeHY0WET1J+rtwgngNMtgLCuuP9IFUB2jSzd6WTA2Jzq7ZYT5A/93Me
	NkoPcAVZraXyKWaYuOyQY1HxwWr1mK0RBUMVPVOBgJplpWkvxrNzlcs7A1NJ8EzERSm0SbC1ncb
	gh/8hsWVCuCACW2qxCAAQW/X+HbnURjyuSfaHbDIlIMGRY6GIm4cCgt6XVqb4JsDULrbgMcOBhJ
	O/trrnSHwkZMi6Q
X-Google-Smtp-Source: AGHT+IFKBARxb/1Lma7PB89ED/9p/HJkaU8vopGLHCicm28KuK1UNdWyaBAVqg1jULjq8b+Am2EYtjOBcHLlU/v8Sbs=
X-Received: by 2002:a05:6902:1388:b0:e93:21fa:9945 with SMTP id
 3f1490d57ef6-e93324ba44emr7765313276.38.1755365360807; Sat, 16 Aug 2025
 10:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815070500.3275491-1-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250815070500.3275491-1-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 16 Aug 2025 12:29:10 -0500
X-Gm-Features: Ac12FXzpvr6khCWsphPS4E5tM2OfJSpyb2n9DVhgj-nq125n0IzPALBV0Zd32A8
Message-ID: <CAPLW+4mjOmi4BM2zOPcR6GH=4ngA3FisotqFXXGAbHOghQ4x8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] arm64: dts: exynos2200: introduce serial busses,
 except spi
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:05=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Hey, folks!
>
> This patchset adds serial busses, implemented in usi, for exynos2200.
> It's missing spi, due to me having troubles with reads when testing.
> Serial_0/1 have not been included in the patchset, as it seems like
> they're encapsulated in usi blocks, but are the only implemented
> protocol and/or do not have a dedicated register for setting other
> protocols in a sysreg. That'd at least require patches in the usi
> driver and bindings to add support for.
>
> About the naming convention for usi nodes, I've chosen to keep the
> downstream one instead of relabelling all to avoid confusion when
> cross-referencing the vendor DT and to keep consistency with clock
> names. They're labelled the same in the bootloader too.
>
> Best regards,
> Ivaylo
>
> Changes in v3:
> - drop the serial_0/1 patch

Why did you decide to drop it? As I understand, having a serial
console enabled can be quite valuable for this platform bring up. If
you don't know how to add the related USI node -- it's ok, can be done
later, as soon as the serial works without it.

> - add r-b tags from Sam
> - increase the size of all syscon to 0x10000 and not 0x3000
> - change description of last patch to be more meaningful regarding the
> usiN and usiN_i2c mess
> - s/usi6_i2c_cmgp/usi_i2c_cmgp6, following the TRM naming convention
>
> Changes in v2:
> - add a patch that switches address and size cells to 1 in /soc
> - adjust all new nodes to define reg props with 2 cells in total instead =
of 4
>
> Ivaylo Ivanov (4):
>   arm64: dts: exynos2200: fix typo in hsi2c23 bus pins label
>   arm64: dts: exynos2200: use 32-bit address space for /soc
>   arm64: dts: exynos2200: increase the size of all syscons
>   arm64: dts: exynos2200: define all usi nodes
>
>  .../boot/dts/exynos/exynos2200-pinctrl.dtsi   |    2 +-
>  arch/arm64/boot/dts/exynos/exynos2200.dtsi    | 1433 ++++++++++++++++-
>  2 files changed, 1398 insertions(+), 37 deletions(-)
>
> --
> 2.43.0
>
>

