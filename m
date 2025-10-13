Return-Path: <linux-kernel+bounces-850564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034FBD32F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26453B56C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F6274B39;
	Mon, 13 Oct 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlWNxiPs"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFC2F7AB0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361754; cv=none; b=WlJNTlUc/ylpPh2rbX80Btyrvt2iqTFPSzMsrQUQmlmV0j2Jc5cH3I5A0hkmhaGSCNM6ycM5+3euVCPHqdl7yxfZ3rWYHNkzwX/qi+TR1DQLTIwIHaXQfFqI76OTkhLyhTIjBeJF4xJ7FKMfUoOJWm1fHCzlEbTR2zdcKrQ6YQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361754; c=relaxed/simple;
	bh=sdzCugawJR5yomrCcleyfBYzimfdjcRqs5/JBcSkuHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCjci82cCApb4+obGZa6Z17gVXYEdxBVx63aOaIKlTMai+B7y7IFP9FlBlBdaowqOC5tI8oHFUgoeaVXTFakrlItmgeL9K6V9VQaoDe9u7n/nWZ8GoVDUeMMasgsOivHWXdb9yhc6lht0KM/CS1K9HqTVUX0j/VEtxsNujs1uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MlWNxiPs; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so36377231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760361751; x=1760966551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdzCugawJR5yomrCcleyfBYzimfdjcRqs5/JBcSkuHA=;
        b=MlWNxiPsjoo0T5LCyUP28n37DcOLAOTwWD+DpAzc/pTf5m45ZZ3AZ+Buo+GB8bIglc
         Lgp1k2WnYYKkQg0OUYXBeLtf0rlQnQa/c6kqICN0/Mg+62isn5k1eH0C5V42RNo8uU/2
         O89YIu9wvAAKaDjCQQJNow//HTUopI7KCxkDecV+++eQlWZBjgH9mvfFON/bs/djnRjw
         m5qJzRJDkcrlOw83nb1kBM7KZe8soPgcJAyJPooExhtnXEdJ4beRh3tnwrLrx2ffZ6Kd
         04fvOXjhohsZtsSaXsVNpdE5zD3blxtpUIzgN1pkPK3g9JvciggUbR3G/n/FjrgHEjXl
         0LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361751; x=1760966551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdzCugawJR5yomrCcleyfBYzimfdjcRqs5/JBcSkuHA=;
        b=vOr+kohzYjrJudIOrPrVo+5Tmn9+V+JVlB1ZBEfVk7/BgqPJhQiVWuepmh0nNTxvqb
         uC3eqiHDuv8qmGo0MTFAcc/+I8d8oZnUzXAd+qjZllgagwqJ1FJQdLhZ7XWv5jJGy+Ht
         RxT7INiNMWBrlrWdl8fFNn+ZXhnxRZPCNFzkytamGPGSOgu41gfllIYWj/K5NOZRDVbu
         WF7VNU88jCuHdktOK3CMZCLemKfFeFIV7oWkzK777Xoti+RCWmo0zFq1mnm+EklAz1ah
         m2G//MbvvU1qJ9//eR7ksN6fsux/ietLSveqEJ3NTnEpWfkxTdRIlS4aZfV8ZB5R7Rvc
         FISw==
X-Forwarded-Encrypted: i=1; AJvYcCVlgyLQR+9aiuXEk4sq3U50crv2RWoIf70xcbmJ57zSthcOZ/Ec3cexzw119dRAcWaS3YCZeVoBKJ9/cEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEFnVDMTdZE8HUL+x3dO+3bPsYSZkHTqVpzj9h3prSSKdLlse
	kj9/8qzz+yn6J2458NqZi6Ter1fu6hYOBIHJ1u9N5nS9Q1ceJOycvlUoYHPg3ie6n571QskZUVq
	ihtQd53oZLmutStbW08gXrnSkgd4SemM+EmrOZm8W6A==
X-Gm-Gg: ASbGncv1oBbOfTVqOyTOYxEvMSeNiu68UXaGPJXqRDok3XE4rPb0Bw0fOQ8sriJVUx0
	LsV2Fo7R15nTDbChFlfSyVJUrTwOTKeoCYDDB8DaoIYqDKG+f1MAsiQgwFODvj4nvpv/bWK1d1v
	7LGsNgDeKd+aAoOGeQmePYWkbKgid1zzq7/KLI2qTpLYhmjS6h60s3rXxNluHantxXN9rDCWEwQ
	qOo8nszlZ1+zb0I05EYpP05k0IrgPd8XTe59ZvD
X-Google-Smtp-Source: AGHT+IFD3AIgRgN4jBUJbpK34gX4OpQi2/Ld3YOLcJ6oyzzxV171xkOqcylCUzBUtIlA/UWCtsK+8RrigJBOPn6Q18s=
X-Received: by 2002:a05:651c:990:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-37609d72cc1mr56226121fa.16.1760361750851; Mon, 13 Oct 2025
 06:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009132651.649099-2-bigunclemax@gmail.com>
In-Reply-To: <20251009132651.649099-2-bigunclemax@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:22:19 +0200
X-Gm-Features: AS18NWBjzabyAo7Iwc_ab_T7t7lGvRr7MIu3O5SMdfRGHuDa0E6rCvILh5I1Oh4
Message-ID: <CACRpkdb4HDhN6G9JSe093jeBe4__jCFz_+r1grUbHwEr4Gt1hQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mcp23s08: delete regmap reg_defaults to avoid
 cache sync issues
To: bigunclemax@gmail.com, Dmitry Mastykin <mastichi@gmail.com>, 
	Evgenii Shatokhin <e.shatokhin@yadro.com>, Arturas Moskvinas <arturas.moskvinas@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andreas Kaessens <akaessens@gmail.com>, 
	Zou Wei <zou_wei@huawei.com>, Radim Pavlik <radim.pavlik@tbs-biometrics.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maksim,

thanks for your patch!

On Thu, Oct 9, 2025 at 3:29=E2=80=AFPM <bigunclemax@gmail.com> wrote:
>
> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> The probe function does not guarantee that chip registers are in their
> default state. Thus using reg_defaults for regmap is incorrect.
>
> For example, the chip may have already been configured by the bootloader
> before the Linux driver loads, or the mcp might not have a reset at all
> and not reset a state between reboots.
>
> In such cases, using reg_defaults leads to the cache values diverging
> from the actual registers values in the chip.
>
> Previous attempts to fix consequences of this issue were made in
> 'commit 3ede3f8b4b4b ("pinctrl: mcp23s08: Reset all pins to input at
> probe")', but this is insufficient. The OLAT register reset is also
> required. And there's still potential for new issues arising due to cache
> desynchronization of other registers.
>
> Therefore, remove reg_defaults entirely to eliminate the root cause
> of these problems.
>
> Also remove the force reset all pins to input at probe as it is no longer
> required.
>
> Link: https://lore.kernel.org/all/20251006074934.27180-1-bigunclemax@gmai=
l.com/
> Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

I would surely like to see some Tested-by on this patch because
this driver has *many* users.

I added some people to the To: line who recently made changes to this
driver, maybe they can test.

Yours,
Linus Walleij

