Return-Path: <linux-kernel+bounces-768459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0120B26139
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A181883218
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9362EAB98;
	Thu, 14 Aug 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fU3mZIT6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A582EA15E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163980; cv=none; b=tbbOG2hkgFagUOAUxcVXbYj2atETb0qZuXFuocf4XJ3vfBGwMCvmN5vePleH4j3mSvh0c2ZPbJDeWH6528TU/h8D0JYE9HDZtuzmeX0jIvGkozRDnhl657huKYkztUMYIi8PJxTtYUT9fI1NurTKrVj7qeFohcpeVj3wpn4Erto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163980; c=relaxed/simple;
	bh=Ddcf2otYVNARg/taorSZLAtQAtvhMThscR3wOc9nohs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBOn67eagSrKqBkxgyNpIvBwyVxLGqlOavWstzczhuuCsnLqdVa8VxDFjhXfTC+Ph72WmPKswrdxlsyBb8+j0otfaMP4ODMQQfFobofJtQIaWHJiSqomD1MOlOqwGOmpYh3vOxkrHYRf7ObCg/hKtALEMM5cL9ReXthMSmor4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fU3mZIT6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78d5e74so116910366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163977; x=1755768777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PgWqN4timfjl4cZJRm42vhchyn9UqvfvoLN2gf4TII=;
        b=fU3mZIT6gEwgZDiGnmaheocxclu9gw4fft58ddiZWBISqEEf1hZSUMK2bBmzVFqS3y
         o8L7noQ4rUy5x1mZ6SGh0Yque5vYLKcVI7gvHvPDsdiBBrqQOGqVQlOMWQcAN358uiv+
         yexl7lSVNGWTe3wUFwitSt+MeJGvMQUzn0IRB1zBXpIEh8ZQBAuP3LnQ+Ivv+qE2pkGu
         7XpMbiuDTHBW1pbGKBSFg/0FB4MI2GZuZdIU1rKzcAIMnc/NiR2bd4JccGfaogSsoyRG
         d0qsEhG1DNFdLJZb4CTubErfLgrnNYrC4WbPnogJLll0V43Tu60njrJQk6qcJuRF9J82
         VntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163977; x=1755768777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PgWqN4timfjl4cZJRm42vhchyn9UqvfvoLN2gf4TII=;
        b=XM7M4yavA/rMDEjdorrVGNiqOoFNgNjbnCNtqYAsCDAbeLKXvXvXhzoo5LzPvtzt2P
         T+ThspxwnJKCmRDcJZ2AoysXZDUv+Bda7nXQPlCyy8agcz22vxl6kHaXBP+0YDJo+zTC
         otaN2JH6eBUyeVqTbjdck2b2TtT7gCzO8Ch5ePB8P6KtlRKWArubQL23nvcDEIwFh/xI
         /qGDVJob4KivPLjrKx0rbM4EoEakDSKcAmKWtb0XlHA1IhyymyWLbQCuf5ptv0kDYqR+
         qyBWrOpJRApnG1+oaAXe3ZvniUEhBl56egjL6rr5goULj0FVD2ng1E/xd58Z1BIwkThY
         ic3g==
X-Forwarded-Encrypted: i=1; AJvYcCWIDqfYtJGsdoQmNfDUoo1L8990Qx1CHupqoiInE6IsO2PtE514FC7oAU0inHx8cDco5xP8uMDfinAvwEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Evw941PXTnO7NdClrhcuxcHSJtNYXbFngAs1hfL4ckN8GePB
	1F77dlKPLy8ptXMU73ceuOAj8PzRIQiFEuv3Htyp+kE1hrbmjaoXFigNOLFBQg0OvBBWLVu3EQV
	1NEBn6MYET0uDDdOm608V7obxdm3EsAxtWWw8nH1XEQ==
X-Gm-Gg: ASbGncsdRvlzqRcdzUDuqggjWvxP6eTSEiUlMV919CfTkBWtz9H7fWOMPn13XYd5ehY
	OeMlNqKQ3KiDMdbRu2o9FGzLsM591GQPG96ZKr/4F07Lcs4LGxkFbewhiu3dgaTXpspEXEdBTQW
	HHruAavnQDPt+gjGT8v6cgOU9S9Etrl9629cJCXKnfUBwd/KUsxHeRICrvR8vZPwH9xIWqVquf9
	Q/FUyxZOdgk6fQWyXiE+YziJTJffuO6SSjjcPo=
X-Google-Smtp-Source: AGHT+IFrAVXvmsSi7GbBhU2lB5DsCLyrrz/JBWyYAZLJ3h+X8DtQSjG9apEyelCtFkio9GsKeQdg8qpPOGy++jb/RKw=
X-Received: by 2002:a17:907:7e99:b0:af9:e3d3:a450 with SMTP id
 a640c23a62f3a-afcbe02ae07mr165697966b.6.1755163977510; Thu, 14 Aug 2025
 02:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJwk0yBSCccGCjX3@stanley.mountain> <175506979055.8476.10658684000717777329.b4-ty@linaro.org>
 <CACRpkda_-JBGTTh7pLd+MkoVyCCKDqTZm8t9vaxWMWDE+sGyLw@mail.gmail.com>
In-Reply-To: <CACRpkda_-JBGTTh7pLd+MkoVyCCKDqTZm8t9vaxWMWDE+sGyLw@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 14 Aug 2025 11:32:46 +0200
X-Gm-Features: Ac12FXwz2T5b5IuGlaWDfV_45Y7w640Ir8a_Q8gAQw7wKqwa0C0dwbE5i-RKcEo
Message-ID: <CACMJSeue_3A33gQjkN2T0=G14faWs7NaXK9sEy=q877w9f+-AQ@mail.gmail.com>
Subject: Re: [PATCH next] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Richard <thomas.richard@bootlin.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 at 10:42, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Aug 13, 2025 at 9:23=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > On Wed, 13 Aug 2025 08:38:27 +0300, Dan Carpenter wrote:
> > > The "> chip->ngpio" comparison here needs to be ">=3D chip->ngpio",
> > > otherwise it leads to an out of bounds access.  The fwd->valid_mask
> > > bitmap only has chip->ngpio bits and the fwd->descs[] array has that
> > > same number of elements.  These values are set in
> > > devm_gpiochip_fwd_alloc().
> > >
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
> >       https://git.kernel.org/brgl/linux/c/148547000cfc1ba8cec0285726833=
3d08724b9cc
>
> Do I need this for the aggregator immutable branch I merged yesterday?
>
> I have only merged that branch to my new development series, if
> you need me to pull in a new version just send a new pull request
> and I will use that instead.
>
> Yours,
> Linus Walleij

No, it's not a build-time dependency and it will end up in next anyway
from my tree.

Bart

