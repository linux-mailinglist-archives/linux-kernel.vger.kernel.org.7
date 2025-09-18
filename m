Return-Path: <linux-kernel+bounces-753915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3378B189E9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE003A532B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64721CD15;
	Sat,  2 Aug 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFz66w5k"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3117BA9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094564; cv=none; b=pE8r+aRZ+GZNErA8ofNv1qMYSccjyhHM9jHwzkbOX5tsjn0ahgT6MTfxOxm7A72p7Z5HxFOzVC9JuDrYcx6HxH41Be4SG+fYQudQbRrRV/L2sGn4xNplYxBrcJ4SDtsaXwKUF8HzsoIw9SliTOqJQfINY0PRgvkiAoFuSUMPIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094564; c=relaxed/simple;
	bh=/e3HiXOOhmzJYdmEluxt28mSjbsOiXAfIZ5KId+BGtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfF8oJc30wPRa4nVop8eYE7ZCljSyt8evFQ/HDOVGVX0HUQpMvTLOnRFzSmK2lIqnnhxfq9KGfQjGSNgdkGHLTIVUakz76jvM2l7JqaaH09Rsi0ZjSRKt9Rl1jTcfvuH9egLXGug5ujRz0SXh4y2xqyc0L1PyEnRBLoDYmDDqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFz66w5k; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71b6d27113fso14940217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754094561; x=1754699361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1ukSKhmtxKEyX7FOOTcTRSkRm/xtlj9BuhhycLdVw0=;
        b=DFz66w5k0qUmNTadhV4g0/lKF++F8G2fPKsYyWmgsWy59GYENDqOus397dwEKeDtWq
         WTgkiHHzQwgerX/kippvJnQE8syFnRfduooO5YE1FWnd4+FokY2JoHaFeakDqiDRv2Kl
         PV8FrEvrYTOkIo4XAoyHlnOubUsbMGkyoeqGrcj1JxRsnFbgYbiYrBckDCP60RQ3Ziq4
         D/B5Zdn0S2/sJj/Yaka5RfBAdHDGFFDAu0pKAjKqp3hFmnAlrza4OXcuvSd6AbYxmuMD
         Iw2mlYZiiV+3nVKJZAk7rmKrniXZUJx5KRel/6++6Xe9nRrffySm9kkXobU9CBvFzSHw
         jRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754094561; x=1754699361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1ukSKhmtxKEyX7FOOTcTRSkRm/xtlj9BuhhycLdVw0=;
        b=qHS1K+byW5ObZerKgtPPPNxRD2EP3YFFzxBM6d0cHO3l25VFvpluMiABOk90hldTpt
         SU+E30L6ipjQiLspkvgvx/uaUlXYZx4qc9Z1/Z5QZOvEQSxTeNjg6wraxB7OpoFUzarI
         CtcUw047Sni5hgjhJGbJe2ReWxrnh1UrLeFc6X9eXZIkMc/vpv1DwEkezSuEWfmnCBnZ
         p+NfjntfXjjOd3PqGwd2T1htuEcdLf2QmU0KiTefeBlz4vOMHmqAbRwqXW5Oc1G1sQ8G
         3Ep3dZFNP95Pt98puXjUIFI6iL5O9KOBjLjCXMOj9JwBrTbft/KdTyr6OmV6wGdUi7hC
         gnVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpmHKxy8zw3djkTUoPPo0LKjch0zFchYkjTwdlbVkvMxBUdfup7HBNINtq043V1//49VToFbxddDGlq04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7E5ijC6X2x0FOR9W9DJUlzkWj26AGeV+6BJOb7o1CCq7oSdMD
	LUpqb+tmNgxFxRDv5Vjhucun+7xHKACc9tDFYXCdgiex+wpUC0c32YCFE7JkQvzdMqgxBANfN1b
	Ocd2pZh4aXz4HqRBOh8FnuUu97PSh1UFVXgQVoYvQdg==
X-Gm-Gg: ASbGncvNLB5TF3BdjgyRl+zyNIjMY0TSdOA3BVlnMldUgivu9zWAwf+0VHQzTL/Z2NP
	YjCxhaQZ+eMSUZLrWcUOVcFrsKwifz5xnv66P5kYLdjhYpGq4uaYqO7cBzi8yi7cdNyB4ZgdnU/
	jBcjlsVytX/AEp9uDL+PUkGjijJc+EeFmbn3aJ5tGkmeaytqB35cyOAjNJYLqMcGobcTPznQYqN
	OVKUQ==
X-Google-Smtp-Source: AGHT+IE8ocrwfW+jYi1b+PwwdH776i/4xWR5LD9i+ONjyo97j81erbD7o9iAQzRF40MbhmQx3aXjuOwbFFA0dvMS4Yc=
X-Received: by 2002:a05:690c:3343:b0:71a:38ee:1ff with SMTP id
 00721157ae682-71b7ef4db59mr22292567b3.25.1754094561179; Fri, 01 Aug 2025
 17:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074253.1884111-1-ivo.ivanov.ivanov1@gmail.com> <20250730074253.1884111-6-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250730074253.1884111-6-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Aug 2025 19:29:09 -0500
X-Gm-Features: Ac12FXzIeJyXP9m27_ER8_SL561hmtMLHZi1Z0J-tLh9l2MOkqp5S4hnFCva6J8
Message-ID: <CAPLW+4maFxYv4RrvzUXWwteXAVm64ocj2LSAgtM6RMtzbM_p-w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: exynos2200: define all usi nodes
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:44=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Universal Serial Interface (USI) supports three types of serial
> interfaces - uart, i2c and spi. Each protocol can work independently
> and configured using external configuration inputs.
>
> As each USI instance has access to 4 pins, there are multiple possible
> configurations:
> - the first 2 and the last 2 pins can be i2c (sda/scl) or uart (rx/tx)
> - the 4 pins can be used for 4 pin uart or spi
>
> Such configuration can be achieved by setting the mode property of usiX
> and usiX_i2c nodes correctly - if usiX is set to take up 2 pins, then
> usiX_i2c can be set to take the other 2. If usiX is set for 4 pins, then
> usiX_i2c should be left disabled.
>

The whole naming scheme is a bit confusing: one might think that
because both usiX and usiX_i2c have the same number (X), they
represent the same USI block. I can see how they might share the same
pins, but it doesn't seem enough to me to justify this convention. If
I'm missing something, please help me understand why it should be done
like that?

> Define all the USI nodes from peric0 (usi4), peric1 (usi7-10), peric2
> (usi0-6, usi11) and cmgp (usi0-6_cmgp, 2 pin usi7_cmgp) blocks, as well
> as their respective uart and i2c subnodes. As Samsung, for some reason,
> has decided to restart the counting of usi instances for cmgp, suffix
> labels for nodes of such with _cmgp.
>

Yeah, they probably meant to number CMGP instances, not USI instances.
Because CMGP (stands for Common GPIO) is actually a separate IP block
containing:
  - 2 x USIs
  - 1 GPIO controller (8 GPIO lines)
  - One general purpose ADC
  - 6 interrupt combiners

So some USI blocks are separate USIs, and some USI blocks are a part
of bigger CMGP blocks. And instead of using "usi_01_cmgp" for example,
they should've gone with "usi_cmgp01".

Usually it's recommended to follow the naming scheme from the TRM, but
AFAIU you don't have one. And the scheme used in the downstream device
tree looks like comlete garbage. Anyways, I don't have strong
preference on the naming scheme. Frankly I'd just do the consecutive
numbering for all the USI nodes in this case, like: usi0, usi1, etc.
And add the comments when needed, like "USI from CMGP01 block".

> Spi support will be added later on.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos2200.dtsi | 1361 ++++++++++++++++++++
>  1 file changed, 1361 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos2200.dtsi b/arch/arm64/boot=
/dts/exynos/exynos2200.dtsi
> index 22c6da907..f83e6cf24 100644
> --- a/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
> @@ -7,6 +7,7 @@
>
>  #include <dt-bindings/clock/samsung,exynos2200-cmu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>
>  / {
>         compatible =3D "samsung,exynos2200";
> @@ -314,6 +315,76 @@ pinctrl_peric0: pinctrl@10430000 {
>                         reg =3D <0x10430000 0x1000>;
>                 };
>
> +               usi4: usi@105000c0 {
> +                       compatible =3D "samsung,exynos2200-usi", "samsung=
,exynos850-usi";
> +                       reg =3D <0x105000c0 0x20>;
> +                       ranges;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       clocks =3D <&cmu_peric0 CLK_MOUT_PERIC0_NOC_USER>=
,
> +                                <&cmu_peric0 CLK_DOUT_PERIC0_USI04>;
> +                       clock-names =3D "pclk", "ipclk";
> +                       samsung,sysreg =3D <&syscon_peric0 0x1024>;
> +                       status =3D "disabled";
> +
> +                       hsi2c_8: i2c@10500000 {

Why not number all the underlying protocol nodes using the same number
as the USI node? Like it's done in gs101.dtsi. And maybe even follow
USI naming scheme used in gs101 in general? Like, sort all USI nodes
by unit address, and then number them starting from 0. If some other
USIs are missing (like I mentioned in my review for the previous
patch), add those too, first.

[snip]

