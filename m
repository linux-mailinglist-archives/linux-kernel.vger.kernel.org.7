Return-Path: <linux-kernel+bounces-894143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC97C49591
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07274EF075
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06272F5A34;
	Mon, 10 Nov 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRxCRWZr"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22A2F5A11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808268; cv=none; b=uxj62XOFVy36QZfJZuJFK2nZYJ8uKLR6U+acZD+tUEbL0k/Q331TXuDnoc/HIfgrqxSXEl4Q0iwFqmkwqmjlaqXTZZdcsuqhE9GvPYs5kZ7W5L+aoqjlOUoqHuYFIJ/AuJDv5YKlV45RVQkGX4aEDXkA2snNSOZmEGLdOI2f1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808268; c=relaxed/simple;
	bh=EMkFach/QW4lYNE6AmvM9HnCCahChKAdwsSK9+U2fRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEE+hSqbEgRlf7Q5oVQOhJlGJ0iJf900D+TVumTf/fbvcnY5EsqCl+vIVrT14Ua4SBzUtkYolb8Oha1n5vMb8F3dBzQaqbvPyqR9aQl+fMPquZF31cJPIGzzPTpo302VhtXy2hiiIwVgxdLbzICBzVuf6HiJSkedyLNWNz8LdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRxCRWZr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37775ed97daso1617431fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762808263; x=1763413063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh/JsKiFmpvDenrO2RV6pyacRnngWdajIKt4QMpWgfw=;
        b=NRxCRWZrHXnwtg6qXEtxxQ+QMCxgBV9+plu1durTIcxBiM7+2UXavjPov9hOqOv5mu
         4dVdgTTvswiNadLbAKzX1oJEBfaRz8Ug/SKcCUkbPrQQj9foRQB0z3JHhESku0vxfw+c
         tzC3N/oCcoGD+mq9Z0MwI2/lYUbtoPKWsmretsoyPDUFGqDXa+c0Gwkl6POiEPnflJ7c
         85/rweXlKlreJ//KppqbmBNvZoSAi6peMnSFaCxryGFQPQTJ8PXHyey/qAYvuNCt5GvB
         CefYiSRfPdBmZw0NiYFgBF7zwJQpWc0/CWHnMxzcMDQCmJpBQIWhquvlu25DVS653mNY
         7rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808263; x=1763413063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mh/JsKiFmpvDenrO2RV6pyacRnngWdajIKt4QMpWgfw=;
        b=A3WpuA17oMuhQ3LOFC/T7A/bURjVwrll6hSufZ1qzXCXEr4ZOGLV8KcsHIhObyU4RH
         Z9C1r3qH5KhaStrTVyv7P6NzYMjhKHyQTKe/dP5qHN5v10W1YOiKBDew5j84bODSV5CH
         FKrnau6uRWxSbeqmuWw3uvKZMbLzIbVp4ZVEbeP0Sc61EX870KpIW28vbfUI5mMBJ/E7
         uw4OeklijHRQoO4MtYQCq72TcuIDS+wvvq61dJfHOMz2v6FCCd6o6d9AN0mZNOuRp0iy
         mleKRD4utoAmKAOlUIRtm98Rnj+vjZnF0bZAvRx+fyAc2xxokhb60TjyEc/LPJ2Pvaoi
         sBEw==
X-Forwarded-Encrypted: i=1; AJvYcCVgplmWQ3MPYUVVjgnMsv1eC9bh4MahvX+AaOMXvZiXbXDCjbUAACPzDsDSiMzYmgUQb1KHL6kZDSBoDgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsEyRXAiGnpEyp9H3HtnwAd/KE7mvqceAxFyul9FBI/hLtP6Q
	2/7B+hPupEFQDLrwVYA2tqg2iJRhytmEhH1dKw00Ewb/tM8eG0mhs36/pKGfmaZYmAPpSrsh9DU
	zIq9oH5iXKNWzkPo6053FJ06A8mI/bcQxQlEU5G78dg==
X-Gm-Gg: ASbGncuPYseSE0vD5X4/k9R52qaFaMDIwBQjefnMWxDyCsFM9OdYMZTVJp/+xIV9ze+
	hPT7OunciRAvX4+kYf1weOVOBJRkDeopyEHwlcRmjJSiyubIUBE+jHeSRl/Y+7r0CetnAQDVyxD
	Z83v9Bz16+Q2n1e+s6V0ArvNP35AwYBhqyfiUJamieyitv+tV/GNyWjqw2TF5/easCjL9d5chzx
	OAks/Oz9yF3yLeLn06O8dx65Rtouj2o+mGfP/e8pqsGWxurGOLI067UziK5l67jQDyx2gk=
X-Google-Smtp-Source: AGHT+IFHiFVtHs99mXmuYb2B2m+2rnv0hdsnrgmUGdiZxDbZObBH5hPXt0Fy2L1RfDUF3gekviGcSla2Cs8MXuCvEww=
X-Received: by 2002:a05:6512:31d1:b0:594:5d87:af7f with SMTP id
 2adb3069b0e04-5947459355bmr191945e87.4.1762808263115; Mon, 10 Nov 2025
 12:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110202748.10090-2-krzk@kernel.org>
In-Reply-To: <20251110202748.10090-2-krzk@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 21:57:28 +0100
X-Gm-Features: AWmQ_bmB5CQero0WghGpIbdSZsMKfEtwVkS8ALsJg7LOxphzKT9kTeNJBD-rCAM
Message-ID: <CACRpkdYvPS=WDLuUiEovtSsY=3JDqjb+8kKDZK2=FTj4n+qs-g@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.19
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df567=
87:
>
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.19
>
> for you to fetch changes up to 3cfc60e09bdc95483875f0b63cfdc23aea67135b:
>
>   pinctrl: samsung: Add ARTPEC-9 SoC specific configuration (2025-10-13 0=
3:02:21 +0200)

Pulled in, nice to see some conclusion of the ARTPEC work.
Thanks for handling the Exynos pin control!

Yours,
Linus Walleij

