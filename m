Return-Path: <linux-kernel+bounces-790693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA62B3ABD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23026567E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3D278771;
	Thu, 28 Aug 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcLlezA0"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BA288CA3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413603; cv=none; b=KpLyvZBDpbHpeJ8mBaqFatLJ9fwduXEeZJO3b7ZDezMbF7A72eXY7OLA6GWTQn5sDP9kpSqMZrY2dkETfYhsTZdF00h20SMkp3ZmfgbUqIX5tKDBH35agSxjNItVWFhgWc+xPcVZRLtwPBjpGCu12u/E4oK7dCaNdO9p5QPmNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413603; c=relaxed/simple;
	bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv/RDrWmyX3i9EZATyBduWEyZwUk5zhvIeTH4Np8WojUXboNdd+VVbKBCPGHCVObiKnUm8MRJiEqha/k0yaIZ36uenAfJea4WTXo6sZiS0m+Dl3TsKhYX8V7BWT9BCxQ6yYEaMG9zlwIAmzuSZ4BHgVoDkZri/hp5FSvud2UZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NcLlezA0; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3367144d196so12977161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756413598; x=1757018398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
        b=NcLlezA0C/RKlvpmTFfuTKj2oVT7oabLqVO1bvl4XzZepWbF5LipnuAimHWJzYbRCp
         Dy3J229Ii90/ShZ4rJe0VrJYKhdaZoHER+zW+ZDl5vxb+n+WA1uJddXYf1ho3w2Pjp52
         Qal3wsSsT/AmvxWC/yMCiC0+INM9MO8g8LREg/xsz+YWpWNN4KdbgYW08vb58tWOuJYt
         fWGJFvT1x4lCliEO/N1/60SkNufd2sLZc+m6swz0acRkDdC1T3q6RCKXGBOGEU2eewfM
         bYOYGeQ5xjyc8UyWqkPSuNYCyJvM7b5/wzDaidsg957X71LM5UVkscvcdh4w0HTH4qA9
         qn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413598; x=1757018398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
        b=ZXKfKjkPkIa84XCgcFWlw2ltuJefHdxCR0vV/1WG+au4NutgwI74Kmza+SouXZfZJr
         i2khzqYUEI4XZEcNISeCQDUY1wW9cXfjl+bTohm+cbwDzTw7iadwDn2ryFuV/aPtw50/
         ZNlzEVRzLPDPoF6XApeFgkYO4xgUeRHPZqvhoSx3D8eWFwWCxpdOIyG8zjye1hmbN65N
         Eq98wLlGNRWd5Lz32JX4fN0Sms6vdwMb614/ybrPDm645KgK2M9h0IUZnWFsW/0q95S3
         tSR6HYdXNN9Fz5okacKdxubuJiHBbF1VqIxpGgVijawOTZtDfmL6kjfP4LfTptGLxhSm
         wTkA==
X-Forwarded-Encrypted: i=1; AJvYcCXm+weUL3Mc9JDLhLLvW+UmK63TcjqY2ubwHDgVSB2JSTxsucowlVtpRDCQTFk3qOX0vhck2agrtQeCmZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvJyko5Tuaj+fhqXGZZfAHyRKn5NIdrqcoj76j/mIP4DRWrOi
	gtibLxNz9ZLGuqXTjwVmLqPyWWj7PEUTOa029tE2O2KLc7VNwokSvs7iVneaYetCTFQ4jw7M+aI
	frV2fdbt8Yp31f2aj2IlVrhdutF6VUChz8qglWh6uqQ==
X-Gm-Gg: ASbGncsj3C6Hsu0R6CQ2g/evANPUKbgAixI3dSqNv1/c5I77fwCxdonRe7w78lnihjL
	CXykrNrdkfVbdQhBCZmUuqXe9svubMr9/yE2YHTexnR69OENvxDHQfj4AEGkFkke7iiN3bPNMK5
	Crn70ujLESfS2czWnDgCL2OPXIQ7D8oaikudpNrnUT6lX1HLIcUTfARvcsXzW49leyQ7Pj1RjgJ
	OX0XRXMP+xHW9Qczg==
X-Google-Smtp-Source: AGHT+IFyEWOuQG1fDf1ksdaTJASZAGtsBlaDN9tGze2bxNvZnscAfatszOqEDWcWQi8cu6lP0CXjxEkjw09XegfiPKU=
X-Received: by 2002:a2e:bea0:0:b0:336:af88:ce61 with SMTP id
 38308e7fff4ca-336af88d0efmr5543851fa.40.1756413598261; Thu, 28 Aug 2025
 13:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:39:44 +0200
X-Gm-Features: Ac12FXzQsryYs9cHpNdLp9yIX0je4QdVRt-NW8EFXmMKnqh-BUifcsfX0FEg61k
Message-ID: <CACRpkdYBZTLpEGS+7m_B8MrFtUvh+0yaS0bsen4jkUcf0C8gjw@mail.gmail.com>
Subject: Re: [PATCH 0/6] gpio: remove references to gpio_chip::base from
 debugfs callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:54=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> We've stopped displaying the global GPIO numbers from core GPIOLIB
> debugfs callbacks. Start dropping it from drivers too.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The series looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

