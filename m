Return-Path: <linux-kernel+bounces-895178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6BFC4D2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C7F74E8923
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDB34FF6F;
	Tue, 11 Nov 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C53NiIEy"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71B34F479
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857808; cv=none; b=YjLB1IVa9tHF/MiTAac8Td6IbpOL3jjaSl51eo1dM4Oa7FVvy+nIBLpdc0G7JjlhfOXOcMET7HrzxQT7f/Eba5+SY+gsDmQkoKCYvaCYoUWKR1gUyNfj65dfR9BRL08nLs8ulXy7w2FQ5u+igu0IhC2avqMPRVEVNLB7peqjWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857808; c=relaxed/simple;
	bh=5ui5TMnYOVOvWRbaK5ZQq5BRT+yh6rrNReDDZ55MO/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnQo3r1Xsf9hxV2TTScHqdT62Q+T7FJwlww+yoa9UWFGXp3o3aFze7AU4pYc7/1JQVLwW+jtwUS47bUD1lk9nmkRj+atSiG0yRjh4uDBwyehfxC3wpPePs8jj01laM26RxJFr+hkchYh1p32/mDfRWDK0H5GoIw9LiAkYXYsjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C53NiIEy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78802ac2296so10683327b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857804; x=1763462604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ui5TMnYOVOvWRbaK5ZQq5BRT+yh6rrNReDDZ55MO/g=;
        b=C53NiIEy6+OE3sWwhigESKCaB9aZBDoeFlaqT3RMCLORlSpkHTg50jTkTRl6nYW3gx
         rYKSJxcfLXfuk8ySghcQ7PG63/fJiRXSmd1ClPhya/uEkS0AgsGl023phv2FQXgaAFgs
         t3+IXo3rxBYryZBq76ax77QYYLOI507Uy0Ryuoa73+4rSRaPLUYrVqZZIRfChidxc1XR
         FWOh4ThDObYIEU4GdruMOoI9cS5q5Ht/x5lKKW2yebjNyGEHmI+Zrgn5EMF8m96v+dFl
         J7aM7/HCNdg+5yYDEsy8eZjpiH7QpLdERyPeBAp94FFeLB+8YeceYl8aydSYC72BJNT9
         nG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857804; x=1763462604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ui5TMnYOVOvWRbaK5ZQq5BRT+yh6rrNReDDZ55MO/g=;
        b=oFbpq/47alPAqNctvwOCiHfPu5jfhdBCtT/BuCSu6XWvDuy2qHoSCJnecrMjqVAdyb
         9hiCosnXY97e53sHEdHtSpnhIUEJn8QWFwwN7gJVfck/m61vd806kHbLFDjcBnzPg6mX
         ZJEEkh4tZp5YTBxS62OHf8p83/s1Cpu04P4Xl3X7ZrZdAcmbDATlwc0SdgB9Rawbx8wL
         Oa55aZ+8f8EA7Nk54y4tOpY0n5aNOAue/YAc4zTRZr547Y/y9cjzFhDxYGiKdTOT81iw
         bF7pEVZwZyyy1Z8PtGfzo+gRUEScoPDGxad9Q3E1SwhjzMwCleYmbniYd8ENTcOh7Y5l
         wTyg==
X-Forwarded-Encrypted: i=1; AJvYcCXUEP4g2lGbLDrs9vMkqktN2q63csg9jqqE4joVlgaykNSJgzZ2LelD8ml+pMLoplnYQmz7hxZv2PnkEoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5teK2tbYj0FONVU6xKkChGW5RaYqO9Wf6WH2yq0S6KFtfW5N
	y+tZSqcm9PCmqHZMKxF1cZghxQDkRABqTMdoP7b2K5AbBBR/xITzCCKkBy7N/U18R8xTiQrod6h
	T9sIH6TYqoleQQI8UK4AHGgSgBUT1CfNH1PYBCEmYSQ==
X-Gm-Gg: ASbGncv3r5Z+9Nfm0X5kArnwARXI/GTJJcSQRpYaODnDU0s5TAJdrWzYqco+tYGUe0c
	TKkRWhRuJGnYJq7I+Cdj1Vyyjd2PPFwY0qFOBy/8ySVhR1oldBRT1cqO/qmpMTJWxLtCgK9fWS+
	v/4kNYws60rTNM1XhOALMLP7ikULucQvbiGPI7aPW/JSaEPqgL7BbBeV6nEwAsAGEGiemBT6b1a
	z2m5cF6U42tGl6sIMy1zSFDsN7RIVZkwsq53Yg4so6AdL48YVUgrvHdrSqj8TfKFiqs8/s=
X-Google-Smtp-Source: AGHT+IEzf7RfCe+CUiwe51rQWA4HYxWkXb8u+xLvSy8sgIDasS0jY0uVlkjQd1JySagC9Zi6HIYv6L+HM/XcKpRnSaA=
X-Received: by 2002:a05:690c:3341:b0:785:c08c:d39d with SMTP id
 00721157ae682-787d54504b5mr104136687b3.57.1762857803858; Tue, 11 Nov 2025
 02:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-4-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-4-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:43:07 +0100
X-Gm-Features: AWmQ_blT5oSFL37n1q5J1-YrABo5OT0VdTa69W3o0jcai3WIlfGp5Mqx5NECKoo
Message-ID: <CACRpkdYH01pOnXs-jH5mzfT+THtHcQDoCKB02hkGaxf02nm96g@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] gpio: shared-proxy: implement the shared GPIO
 proxy driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add a virtual GPIO proxy driver which arbitrates access to a single
> shared GPIO by multiple users. It works together with the core shared
> GPIO support from GPIOLIB and functions by acquiring a reference to a
> shared GPIO descriptor exposed by gpiolib-shared and making sure that
> the state of the GPIO stays consistent.
>
> In general: if there's only one user at the moment: allow it to do
> anything as if this was a normal GPIO (in essence: just propagate calls
> to the underlying real hardware driver). If there are more users: don't
> allow to change the direction set by the initial user, allow to change
> configuration options but warn about possible conflicts and finally:
> treat the output-high value as a reference counted, logical "GPIO
> enabled" setting, meaning: the GPIO value is set to high when the first
> user requests it to be high and back to low once the last user stops
> "voting" for high.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With same reasoning as for 3/10:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

