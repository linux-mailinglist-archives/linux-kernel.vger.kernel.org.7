Return-Path: <linux-kernel+bounces-775743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F3B2C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9661D16C492
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB533A012;
	Tue, 19 Aug 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mngec7y8"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565732BF4C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608176; cv=none; b=J7+vcsElfdjJ92ymV00Uv/oT/x0lSDdEsc/26yREC4U3kL6ernUE4LIbc0yYIGR18DaVBk+y5cQ+ABjvnioqgbG+ykOv6Sbey5IsF+AO5Qsr2Y77zhtgWO3VfO4FViia2+LMbRw98H1oimJHqFDsq+wwdzzBAWHVyQ7Yc8z2Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608176; c=relaxed/simple;
	bh=jz0QOg/akzSjE/H2JWtFn2TjUHHbmNYxDvqdiKH5wjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTlxAzS2Tb553kJ1OK0zVwxcxeUWA7hCzc7hsuiIX30CUAccnJw+IjqRBA6OJt9qEpF/O7j6Dg6zYev0wCPw5r93WySzcUsjhScC8jxo5WxvbyZiVczH28hoBjp7MT9XOwiAaSG7iy6Ar4zwgT6QbNJPWrbAfm5b1BwUMH+5UQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mngec7y8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f8d1ecffso40186181fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755608172; x=1756212972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz0QOg/akzSjE/H2JWtFn2TjUHHbmNYxDvqdiKH5wjY=;
        b=Mngec7y8BQP4xvfWALWD6RzLqBvh4Iyw6amqXKQYGZMT6S8DehFMRaxmgFHr3sEpOo
         Oaj3FO/6Cq3d310OXbGrVHVXKLk/ZoK3LJxVumQ7OPlLrvXV6clsfB2Xxh9M8JqwCkj5
         LMBuTi+h2oCslNZciU0Hd5pIG0iiCjUbfTrdPXLYKU2Alz3HN6mWgQopJQrwNpZS5icZ
         BiN+0AmmUf2QAMuYMD7otAFYl+JUOUJLfd/NHY17YAHcddMVLmgRWUm+ifZFBaC3HMNb
         g9Cy4bu3BjMjJXTqJWY7La/fCehusSFhFQVdjsh5v84+4EmTbY6TjKpxZ0NJgLIRmjar
         +4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755608172; x=1756212972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz0QOg/akzSjE/H2JWtFn2TjUHHbmNYxDvqdiKH5wjY=;
        b=vRDsTTR1vJuOAY8Cd/qhYarpAiuYkkL+86MbNCBsj6VWc2jm0v3WQk2ay1J2srgwTm
         cDz/piFEGO9RfMfxA99QQiydR7/tIzVGHWsuI7ecb/IiSwgympblO/hIJZ+XGinSX+XL
         CZvHW2ChZvhFddX8Ag0AfOnymjE6QT4MyW1hPwx0DbjlbhqfXf3vUAh9Ga55pwaHbJFI
         +eBg1P5QnBjIvtqk34b0JChvEGdSoqVywH0iCUBeJio/oR6urbuHu3kwdLvltQfG3NxT
         a9vXobSobT1ny4WDn0NZ0Hy5c4sJoRaAByJoCPFkQKw8PBgWvWKv52XF1rIUHjesjRaj
         xhEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoaxuQ/woD8C4Y7jJh0PElZgb8r6fZdgyb/bZZwuEufhm+M2GQgNw0sf7P0BKOgC00MI9gH3HOkDwWu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Y9Vs2Yflimc6i0IXg16qV8jHRllvtouQZwb9Y4Lfjoso5o3M
	ZWJygM2wmLN35p0fMcF0IeppaEZsme/GxmDFant7KWrqT19TEhjg0FtyRTdGHKPBOuBPwgt/zW7
	mE/M4PMLYjobngSL6swujlDm+uvDKq4+i9KTpLJEnnA==
X-Gm-Gg: ASbGncvREabpkwwCQMhONl9vHHn/WbCSAgul4sdMzzpUDNXB1/frnLPGC4LnPDmwn33
	34q80D0viLkHwAF+J/899P+clEQixuoofXBzFQyWZs1PhLg4nCLpEg2HYA6oUAexkiZyieCMBcX
	n4aAKCUYZ9sTL0FLU5SCH85jgZbm35lB1tKIOqayYDVjOPtsjEu/6CMVOz30713vI0k+OErx8bx
	V/xm+j5diaLDMimlQ==
X-Google-Smtp-Source: AGHT+IFUdE20zyrUEk40f2kUzg2iU7WpPNLkuJOKXQXp3DLrjB3ncJifjSzbF9DsaL3zu7uLvfHfbMV3X1spc0EVxok=
X-Received: by 2002:a2e:a594:0:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-3353050e1e0mr6448301fa.13.1755608172324; Tue, 19 Aug 2025
 05:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
 <20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com>
In-Reply-To: <20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:55:59 +0200
X-Gm-Features: Ac12FXxA0aTHF_AbE4XLBFhBLRwXcBfdoeDod62FVE4dAtkrcQvpYv97-QS9ik4
Message-ID: <CACRpkdaeAqD=mpG4y16CPKwJ=pjATY9TxeRnXR9abziCOQb-0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sx150x: Make the driver tristate
To: Fange Zhang <fange.zhang@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	xiangxu.yin@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:41=E2=80=AFAM Fange Zhang
<fange.zhang@oss.qualcomm.com> wrote:

> Set PINCTRL_SX150X config option as a tristate and add
> MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate information.
>
> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>

Fair enough!

This patch 1/2 applied to the pinctrl tree.

Please funnel patch 2/2 through the SoC tree.

> subsys_initcall(sx150x_init

I seriously wonder about this. It feels like this driver should
be a pure module_init() device. But other users may disagree.

Yours,
Linus Walleij

