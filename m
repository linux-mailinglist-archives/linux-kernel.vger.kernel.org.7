Return-Path: <linux-kernel+bounces-753815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C72B1886A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46987A4459
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197E214A91;
	Fri,  1 Aug 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inS6GtA1"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B720C00E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081964; cv=none; b=ntOw6zerfpjdjE1D7d+58uGC37QyOiERv8shmSH1ysICQoTWmw7JMGReAM1CXTK3Ns9NZ7NKV99KxlnFYioWfvZY34mKlooTYJadyIZcMzYrRCDS0QjNV2qlrpeGZnqM+g2YnNwPTP0HLygxs7yF/2z95MtHcsJ6XqqdYUDg3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081964; c=relaxed/simple;
	bh=zinTPD9UNIfaO9lLXZzQqyYrRAHoFMqMMtDkP7g2iAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kty0QtOyV8JUBbaPNzraQfvejHx3GKwqqB7DvzmExiULU2x1J2CmAw3h15Mnx8c5kmKBDcKtsXeP8JXAt+tcmtYdQmK6r2l/tctYfPXCP2LmvmJFBft2HjcZTlx8wVRZOrHULfbiqSu51Lhc3vnd0iL64NmO7CNwCEVHR0a9ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inS6GtA1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71b76c2f903so9207467b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754081962; x=1754686762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqET3yrln63sKOqtKsLCt9GeuSdg6kTdsyx4gEPoi98=;
        b=inS6GtA1pZ6gz5x0kEz/36G7tqAdQLFYMncO+Q+Z22wrpCJ8Yj2eh0zorHIhobgZeQ
         0uqoRnLRPzlLYEloJFW0sMHqW2ocNK/uUbO41eC3vSJgcMBBGT1mdXOQM49osLvn4CNW
         bq+ZwYX9niDkYKP7eNRjl6sdmPuAi1SmhfYcg5STvbNlA4+5Z+Lr5ctqgtmwM311H6Xh
         Igt9Ij6rYGqKhGF4AI5zI6vN+gWNKJC5KtRvskhwPN4F6bRgwlhnziVv830zjFv0+Sb8
         XyL18XKlPtLA0zEWQS3X++PQZs4RByGRwIZEZanBdg2aYylGGLXPNEOoEKrWUnBx7qxf
         lURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081962; x=1754686762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqET3yrln63sKOqtKsLCt9GeuSdg6kTdsyx4gEPoi98=;
        b=cc803IjDT8BQOfXISMBHtzvjVJbBGu9aL5/QuNW/8UhJvkfDUkhR6ACUdCUxrZFenf
         UQ/M9f4Hfoahk5DbUrCYdk71mtkzMMIByd4NLZMZ2oh9K1a0+UH7u/g13A/pOOlhhNMT
         Nl+2xd+X5jkdsjaCOcGTAYR1Od6U0M0axf5ROJvs5ZqYhRuMjuAknKbwB6ShSdooQ7EH
         MD9MKEtIRVtOlsu+6VRQo8VDPoM4mkb3Nb/uiHHTyB44fWzeHynje1VP3Lgt5bDpMm6S
         rSuBxXWx/GAAJrErW7bFh+zKDZW5G1p4OeWRYOEcDnkE7w8IoftVEaLNr6lV7+jgZHD3
         XJbA==
X-Forwarded-Encrypted: i=1; AJvYcCWhh77s02jPAGD25WYJW5nqEDt/8zyEPCBrnJBMyKs88wemY+vjrgrqz4xb4PrIJnLSyDgrqC27klSseNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIBCId8Ifrx59h1YLLRoG3ARNCp2Ik6VEGp2YKKqsIwp5VjFH
	67sBFz6L40xooVF8NINtg+Ew+0Jwmdi6Tn1+6idQQ31YpCjF/pb7ezk1gTi+ay7Iq2MfnfLn316
	wInEyVkQjFeDki/6rUInvq1Ui3BFNH/RtWo1CJaQcI0qU/o/pX4cvvPY=
X-Gm-Gg: ASbGncuJkkb+EAKC8PTfIU0CjWDf3645VrrZcgdnL9I7ILF6RP0Ul4d11WuNdl8FJaH
	bMvv/Kh7gOVpAWAnqHlX83XnNHN39TZsIdCt1w+B73aDslOBFg8WpwqPRv5VAPwXMi5hRpD+yAs
	ygfTW1a7diosMJDc+I/87X4yPumzV64HqebZyZH0eK6NRwGY7LPc8jcgITylE+oHzOfoumtkpUs
	6TtUkL93tRj5asv
X-Google-Smtp-Source: AGHT+IHKd1jJXv78xY/0PrFBxMZydcsWN552v7cnDSpVMcUFX+EeAaX4TfUi3JPVYyXTGczQLE+cROOwGZIJgBxNeNw=
X-Received: by 2002:a05:690c:3101:b0:71a:186:59af with SMTP id
 00721157ae682-71b7ef85224mr13019307b3.30.1754081961974; Fri, 01 Aug 2025
 13:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074253.1884111-1-ivo.ivanov.ivanov1@gmail.com> <20250730074253.1884111-2-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250730074253.1884111-2-ivo.ivanov.ivanov1@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Aug 2025 15:59:11 -0500
X-Gm-Features: Ac12FXyXKS4Uf9Z3hgF_FjM8XlnTs6lt758RvGFER7GO1W1HQaOxbu8Nf1Gdh5A
Message-ID: <CAPLW+4mesdhGf-RnQ9S6m_gaxS7hgt3=WQwoO-+Be=CuNiBzxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: exynos2200: fix typo in hsi2c23 bus
 pins label
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:43=E2=80=AFAM Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> The '2' in 'hsi2c23' was missed while making the device tree. Fix that so
> we can properly reference the node.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi b/arch/ar=
m64/boot/dts/exynos/exynos2200-pinctrl.dtsi
> index f618ff290..5877da7ba 100644
> --- a/arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos2200-pinctrl.dtsi
> @@ -1438,7 +1438,7 @@ i3c11_bus: i3c11-bus-pins {
>                 samsung,pin-drv =3D <EXYNOS7_PIN_DRV_LV1>;
>         };
>
> -       hsi223_bus: hsi2c23-bus-pins {
> +       hsi2c23_bus: hsi2c23-bus-pins {
>                 samsung,pins =3D "gpp11-2", "gpp11-3";
>                 samsung,pin-function =3D <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
> --
> 2.43.0
>
>

