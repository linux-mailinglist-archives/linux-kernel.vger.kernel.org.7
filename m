Return-Path: <linux-kernel+bounces-792870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9873B3C9E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BE294E2469
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7D264FB5;
	Sat, 30 Aug 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/W8q4Rr"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA0230BDF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547316; cv=none; b=Xmas2d++iPV3wvesjN3mQ+GOUDZlRaVd+WwIgA5ZS3pf87dfAf+q5vk+0D9dualllCyVXkGw0vlq8tuAML7NbRlEqRz3cS3tYL1EIEC7W2beMfcIzD3UbJHu9qU9r72v+3vLJut/RWMNara7pum61KGVtwFxhIk88JP/kOYDxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547316; c=relaxed/simple;
	bh=k8rdPyp5NnXLNmLAM5692d7carYniAWw+sO8SLajSu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLcbxoWZvG+QEV32GLIm1cX6xuNEoyFrs7vIfkIfcynSsfGckRxwCip3GuHQH5QMFmX8u0as56y/hMRr6VGU2TJOueXBF4jzUeABpyFdFy35Y5whZQLdX8YbOD9GvOpCpzHCl/ZVc7TkOoMjErzBoJzI4yjnPfRYsbkeEitOzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J/W8q4Rr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70dc6d81b87so3648076d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756547314; x=1757152114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O53sSv19BO8/CcZChzTjPzbh29PlzUTaZHAX/6sSM9k=;
        b=J/W8q4Rr5C8UkZpWwr0ZFGNhVXyp6LGrYIg2z1c0BWRLZH/NYCQWilPUFS3NtLxVmR
         d3XM51SlGycN65Uubmu0ICOUjuoNf7drkMHc+8JqFrqv6s5QvhNc0DobbB+ziJZG7pI8
         Erwg3NoHN+TnfxN/hxJfnr0AmnK2xXCBv8VeuxtvB/9fYp/oKwkD+w39/PM7gN4r876/
         f4IWQYqdkkl8gev4bM6KHaHtJ9iXNzkt6mWZ/72zM56zJSJAipjCv7zdzFQx+uYq13wh
         8Xm+dbE2MNIehYJMuRa10DAQbgrj5ry+OO5Q2Qmu74oeI0WIz59bLnZZgpbC7Uy3pAue
         hjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756547314; x=1757152114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O53sSv19BO8/CcZChzTjPzbh29PlzUTaZHAX/6sSM9k=;
        b=J48LlIQDg5zjo+qwteyZp2UWZSrveaVfIGONDwb6o3yrVmTBLMW5nhsHBs6oqabZyv
         j7kUbsJe5uPpAMfGOnoUaspSOcAdsRYurqaRVjFpaNhmOdYokQQ2uVBVX08gafEfal3a
         OuqCOZopLa1vPmpH52S9saLElnAbnZQ47A/pbVvbig4li2iLjgGUaDyfpFMFA8Q2SU6O
         uY3wmXMHEBFvBTskmG7j4iNT6HTISE39WGz7tSpH9/V7qJwtDnQOoEWt+HNdeMDyACR2
         ZwZzuRp8TzecmQDf2hTAaEINQBqMfqvbrCMoR+iYaxiZULZddjHmtyPQA87leEqJAE8B
         LZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ3W+iK+ICfOQqlUONnVpaIUx1d8LV3CrLZn1fem4cfroA7z8FZPIPhCVRtuyRRoknxs2MBKAw6wTbqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLc1rghbVwOR0/mWvX7sVvmJu/g5eYDX9Lt2QcYI7caU4FXOIT
	F8jW/+NBwzel+imOGulO59QrR+SGut9/UXejtJmJ1J9hSC6rwcoHzenLgzQXUb9izvbvcUZHCw8
	nivWmKdpHKH0+xtdIBYJGZ38UuKT3rz8R2IRSLGMEqQ==
X-Gm-Gg: ASbGnctlb615gmaCgSXw/gNpLcS8Iih/U/7IhoK47q35DujkpCQkMkxMnZGUmty56tj
	lEjJrdDwjvpheLBXi3BoyVs1t0Z+J3h0CAhIVJ+3yIQOU1CJ07b2EDeOmjbnkBDGxBaiPoHrY3H
	TqNIEPfFf3XFOfZYk71dKNP2kwc/aaKq91ya8fzThSryiAnKhM4OxaR2fbaxS82zlvyLq3pkseF
	KHN+Ng8sugyRYb0
X-Google-Smtp-Source: AGHT+IGE0Py88CGitXRrUiODaco5VRpXPPZYcuL5qgF4c2qTNFu2t6a/n3uB1c8tKAquQX4FMnnHmvhUsQyxAUhJNQs=
X-Received: by 2002:a05:6214:d8f:b0:70d:ee9b:9cf3 with SMTP id
 6a1803df08f44-70fa1b8793emr30990516d6.0.1756547313850; Sat, 30 Aug 2025
 02:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829131346.3697633-1-anders.roxell@linaro.org> <20250829232132.GA1983886@ax162>
In-Reply-To: <20250829232132.GA1983886@ax162>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 30 Aug 2025 11:48:22 +0200
X-Gm-Features: Ac12FXyHu3hHuGLZl4KhxlWVoLXmzpAgyCiaFhzljq-f-0aBvo2YQhrSZWoV0xY
Message-ID: <CADYN=9JgDeXByZy7PhUyaY091775G0Md+QvoFMb7AZa9vcKQqw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
To: Nathan Chancellor <nathan@kernel.org>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, dan.carpenter@linaro.org, 
	arnd@arndb.de, benjamin.copeland@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 at 01:21, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Anders,
>
> On Fri, Aug 29, 2025 at 03:13:46PM +0200, Anders Roxell wrote:
> > Fix a critical memory allocation bug in edma_setup_from_hw() where
> > queue_priority_map was allocated with insufficient memory. The code
> > declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8), bu=
t
> > allocated memory using sizeof(s8) instead of sizeof(s8[2]).
> >
> > This caused out-of-bounds memory writes when accessing:
> >   queue_priority_map[i][0] =3D i;
> >   queue_priority_map[i][1] =3D i;
> >
> > The bug manifested as kernel crashes with "Oops - undefined instruction=
"
> > on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
> > memory corruption triggered kernel hardening features on Clang.
> >
> > Change the allocation from:
> >   devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8), GFP_KERNEL)
> > to this:
> >   devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]), GFP_KERNEL)
> >
> > This ensures proper allocation of (ecc->num_tc + 1) * 2 bytes to match
> > the expected 2D array structure.
> >
> > Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under =
drivers/dma/")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/dma/ti/edma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > index 3ed406f08c44..8f9b65e4bc87 100644
> > --- a/drivers/dma/ti/edma.c
> > +++ b/drivers/dma/ti/edma.c
> > @@ -2064,7 +2064,7 @@ static int edma_setup_from_hw(struct device *dev,=
 struct edma_soc_info *pdata,
> >        * priority. So Q0 is the highest priority queue and the last que=
ue has
> >        * the lowest priority.
> >        */
> > -     queue_priority_map =3D devm_kcalloc(dev, ecc->num_tc + 1, sizeof(=
s8),
> > +     queue_priority_map =3D devm_kcalloc(dev, ecc->num_tc + 1, sizeof(=
s8[2]),
>
> Would
>
>   sizeof(*queue_priority_map)
>
> work instead? That tends to be preferred within the kernel so that the
> type information is not open coded twice and it helps avoid bugs exactly
> like this one. See other uses of devm_kcalloc() and "14) Allocating
> memory" in Documentation/process/coding-style.rst.

Thank you Nathan for the review, that makes sense. I=E2=80=99ll send a v2 s=
hortly.

Cheers,
Anders

