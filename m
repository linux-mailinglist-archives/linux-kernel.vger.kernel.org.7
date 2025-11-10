Return-Path: <linux-kernel+bounces-892851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4ECC45F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF276188F20F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194530216D;
	Mon, 10 Nov 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVT8DuZt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240F288C22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770663; cv=none; b=C+tPKW/B5blS6ubHzGVxxRALWKy4KCejOoQI0/sA+r7GR5vujcphfo20za+A8WVsvTLkBkviRqpGw+X6PDHa13QaMqCMnQyUy5bwpMDrDKhLwQad2FEWqoGfcY8kzEmzxbzM99ZvbZItuBbiIJmwylVbFglAiZP/sFHoby+eL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770663; c=relaxed/simple;
	bh=GISx0LVyM2/QgivELlFUbtboVFx5/0Ttdw8BgePqXok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SosQ0dMroXTaalNKnI/PL1gC/9SxvOQpkuCgaYrgr/4H/FdmXeNCL6tKjN/JEM/WJhjJdVBTgH6osMmDsEpZw+LMT9WFaYlJ98WcEFBLP1VYcbAHB8KikeElV4hnCm+kqTqoKGyM46vnLuoqDCqLTbCyBqzCKlV4GlVOWkp83K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVT8DuZt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58b025fce96so2362603e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762770659; x=1763375459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU08++yZFWV12YufiFjJiqJethik/+S6rZcQDhNnBws=;
        b=wVT8DuZtYqJGoFHtBH+2Yw8BycLbNfKvuz7XIoCaZ2aYIEJABKzAS9INK3go7kiOXO
         0x/EvkIXjfJxrIMvEmTROhOjkITQ136CY2l6r3qYLISernAVQeFJYpAF7bnJHI5wP4/A
         zh1ayRfklvpvp7vxCd34uTLQoyg777PuNg6tRlcc5EynL2eQEmy1rFeXSK4zcxiYSLdL
         BgMfSF0S/GS83DqGvO7YdqNkyLrMnYuJu4j8xteFM+Pseof4PvStY2PabnNFdtz5YHmK
         4CNNILVl64/8gR6uTlGZk3B6oXytOaqv9ZuF259AqNf2yiy9x9P+hCPFm7IqpjpPH3xY
         LYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770659; x=1763375459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QU08++yZFWV12YufiFjJiqJethik/+S6rZcQDhNnBws=;
        b=MEltxjFnE5w7oqdsNW2oi6frgLXc/JOBaSkN3LVdPLOkRgg6EGBGREKbFyZD+JKClV
         Y9uCBJ6ZWB2mbxRnomajsBQ79L+q7a0/c5Wv7yBYFFbJNQPoNhKQgJir3mm9zi4j8TSc
         waMaYL5+eimkhKhhdaHSUQ/Qmrv8K5iovPh5ovapQHGzJgOE1tjyUDjP0ojV9vbBIDXb
         1LKHD0gPeT2GUXTifvqaev/jMsFYFqZZ97zxDagQZ1FvursqGbc/LeUHqFCJtzixW6AX
         /hFqXY0UcGZ08IOkM0LMXnvv1yycvAvlwOUKWDRe00s89McauZ71M26GgZtnLVQImX2d
         VGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCULrWettrmvjIvo9Twm62JS36AXkCqKpjUleeDrkIxeKlmPwFDMv7sNKjZK7T2+MqEgMZsOPeWH9Xkw+6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKryqPr1ZQqgjsVkV+lubRfko4Kxrw0tt1PorKFCtX3W6W12v
	e0OS0W5NkNYQZWvr7aQz7bKPSs7c0DG3MXhD92O5HhYu7lt58nOTP+3n3At6nd3mXYzDWtLwem8
	FX44pvlekQgfsrGY6iP3ZTfIqEc+FGZIQHc68klqtwBcDkw4DQ152
X-Gm-Gg: ASbGncu4ccTijsKzlk8fcdbUQNzn0S6nqfj0EwsYRDWI3Yr6M/BRj4oy1IVS902x34R
	f31Rl8QfGQGGvWELB6TAdZKQDt975r3B0FFgR0p26CmFuFXw+OmFBg9uBcrRzXKzZZlNXXz+QRf
	HRTxb8GjL8t4qntSl4R7SZlUwvxpuonmQgmK1CcIzdzMP7OTf5M2LxYR+lNmekAGlM3lxw+hP+U
	ZAyaFA2ayyEMy6nZ9eGxMx+6CwZl4cbs6+8/svw9jq853qulFAUijcAHOLjaCSzNtvdx8w=
X-Google-Smtp-Source: AGHT+IGIXbIku+5fYyzKohAAT6RG/P8U2C7G8e9kXvVMEvCfF8edHPq84Zw+IaV6jNgp67Ypm1mnZzGXPUSxOGgBk6I=
X-Received: by 2002:a05:6512:3d05:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-5945f146395mr2089860e87.12.1762770659287; Mon, 10 Nov 2025
 02:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031160710.13343-1-antoniu.miclaus@analog.com> <20251031160710.13343-3-antoniu.miclaus@analog.com>
In-Reply-To: <20251031160710.13343-3-antoniu.miclaus@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 11:30:33 +0100
X-Gm-Features: AWmQ_bn6eI5FE_ScZi7BjkTK0y0_CSDlwCtPcUJZzvZroFx81ufpj8BGANUbJDU
Message-ID: <CACRpkdYdtcnxyP4xVsqVK+geurEOEURqZO5eLC96YMqh1sE5Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: adg1712: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antoniu,

thanks for your patch!

On Fri, Oct 31, 2025 at 5:08=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:

> Add driver support for the ADG1712, which contains four independent
> single-pole/single-throw (SPST) switches and operates with a
> low-voltage single supply range from +1.08V to +5.5V or a low-voltage
> dual supply range from =C2=B11.08V to =C2=B12.75V.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

So tying into the binding discussion:

GPIO means "general purpose input/output".

I am really confused as whether this is:

- General purpose - seems to be for the purpose of switching
  currents and nothing else.

- Input/Output - It's switching something else and not inputting
  or outputting anything and this makes the driver look strange.

Yours,
Linus Walleij

