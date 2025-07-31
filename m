Return-Path: <linux-kernel+bounces-752666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD6B17919
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA38175F89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B1278E47;
	Thu, 31 Jul 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9csCP/V"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629C278754
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000749; cv=none; b=Hxg7fwQX9eTSuJ7fmw08iM8WPzxjAPf7cR1j8yut3Q9B2Z8qe2dPrB9pAEhwm+356bll15Z/+/43dYDzNh3X8m/J/6EmAWnBLEW4Cq9lnOCw78+kFlx62gTQLl1KcOc833qXvsanEWLggWNlsXkbMfV9XGtjdoHPenIAHvwnRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000749; c=relaxed/simple;
	bh=VR+Uphy9mDIsNEpJMACnvfnSqHdlCUsmQ+3NZ7FkeP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRqqaxpV1Pi/zuM/dhfH5xdgAV+1gpG4UIB/lhEcdgjiLnkrIA8MAyhYWE+gZj046GENC9wcdalv63O0FtOIL+0UqRl/cfj/Y3OImOzh4GDPOT8UylcirA1RVH3i7mmYOWYlbXT3YS+A47nmwFa/Tfg+iO1ohxwu1OO8U2JnzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i9csCP/V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167afeso2047005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754000746; x=1754605546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2avQs/u8C93T263u55Hd3Byk2Z7uAe/YLQBzzdrt6j0=;
        b=i9csCP/VvDfaB1Jx9/622lEsXpm7P39EkyLwDyDC13PE0OFQxYULMM8yp89dit7Ppp
         joOvNn+eUjgOolBSz1AYW2aDU0fO2UmE4wKfc8KAVcqqtdt5PsPJbEdz+nIuJ7cyEh4m
         IUHpS8QCs4q+4hp0treSAOnez4GywXmciPjrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754000746; x=1754605546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2avQs/u8C93T263u55Hd3Byk2Z7uAe/YLQBzzdrt6j0=;
        b=R2pzO7BfFjV4LU9NAgOO/VE0wpjCZcHj/JoqzDMKnkEcdgEC8pN34Y8+dLmbxuODKC
         Go3M/5PyOChU8/ViRitGuE9vQbJQX8QW8FlnRije84dH6UOKW5ViEQda2NtcCUN4a1TW
         or8sy8fz1Gie1IWhcsWHCuffl3VBl3rWKkkdwhhV3o9uDr2WpgwPh4/VYl74uE1tm1Lm
         sFvo9dhTZuoAzpAr5BRQVQc4U8VBAgJGsm5TBTr13xxNhuH1kOB8Xx1Xk2I7jfQTpm56
         DIB/GtevpjCx3lfq/eGmFtsTwv3MlpApL4nT+GJB/qwX0Tv6+B0NX1tW1QW+UZnspTEa
         uuGw==
X-Forwarded-Encrypted: i=1; AJvYcCVOYHltP4PPdFKoniR5fZ6I+Gn77BFiYtyRmhWeXHk83n+tB5IjL46GFmCGfRSeYUr5omcmh6DA5WdK6fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajKRUaVQ2X1IzQDhF/RURWuEotniSjbQlN0z+CXnoagBRh83S
	WzWS4uBdVu+DBebNF4R1Ha5T2sEiQ6nGNEuydyQYLmtlHsLkNtrWeVq5KWyWaFAjAlQg35G5OcE
	0ucs=
X-Gm-Gg: ASbGnctZbWAf3V0i1MVuD46vxEEyQjK1kjfHm9aO9lgaDqXtU52iriy3b8PtBekGb2t
	LUvTcNCex0Q/wxmyTbNozo1sBwHHmt1tktBxGbfijGbupLmBJBzd2fBd73aCCQeqThIVi9W0y5n
	qNlkPUBwYCcSwLqs866j2HgunGq9tWYOu5shIpmMYTKob/dTgKn2pc3VGGYL6fk69rh2bGBOU2k
	PWxiJDgaGTy/CnOfYHJwPmNlzQt29/M+cq/8/uxafTsY4fFx3bX6A2oE66duP7XltfrKqD0mH2A
	AOdLcwvlVf9RaZ+CD+xeyalH+BTPscvqkXKVqtR4ybJd2vf06RpqPuXCpQixwoEOkcRGo+kw6M5
	5U418Mr/pwJfevMC1QWqrYdFd98C8nKIj1kMaayiFQqjvl516IlOQwFaZ/RWKlAg33g==
X-Google-Smtp-Source: AGHT+IFor6exdTaJIjnNNWg8QpcXIVpgU3rW9tYHF+fUv+UiLw6A1pLnFQzM/F8hsVmkRbav5BsXew==
X-Received: by 2002:a17:903:1a26:b0:240:887c:7b95 with SMTP id d9443c01a7336-24096ac57c9mr156712245ad.5.1754000746378;
        Thu, 31 Jul 2025 15:25:46 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm26899905ad.46.2025.07.31.15.25.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 15:25:44 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a8f69862so191430a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:25:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKOSNkvFxNwVRH/r7sPN3PCe26CCKmZ+4j8jROV0VAEYfJyXBw8qI4eOjFeaQCDhZKVHAce4E9o0Se+GA=@vger.kernel.org
X-Received: by 2002:a17:90b:250a:b0:313:dcf4:37bc with SMTP id
 98e67ed59e1d1-31f5de59cf0mr7700439a91.34.1754000743815; Thu, 31 Jul 2025
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731215635.206702-1-alex.vinarskis@gmail.com> <20250731215635.206702-3-alex.vinarskis@gmail.com>
In-Reply-To: <20250731215635.206702-3-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Jul 2025 15:25:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBaNJ7VKmJ5oqEb_HxEKrpRWmaSCkVejvRwjMVdvUdqw@mail.gmail.com>
X-Gm-Features: Ac12FXyO7QutJwaatVpGbTWcIaoRXNZfqpiuPLqpynloYzM1ku_IwCQ5zDIp86s
Message-ID: <CAD=FV=WBaNJ7VKmJ5oqEb_HxEKrpRWmaSCkVejvRwjMVdvUdqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: samsung,atna40ct06:
 document ATNA40CT06
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 2:56=E2=80=AFPM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> The Samsung ATNA40CT06 panel is a 14" AMOLED eDP panel. It is
> similar to the ATNA33XC20 except that it is larger and has a
> different resolution. It is found in some arm64 laptops, eg.
> Asus Zenbook A14 UX3407QA.
>
> Raw panel edid:
>
> 00 ff ff ff ff ff ff 00 4c 83 0d 42 00 00 00 00
> 00 22 01 04 b5 1e 13 78 02 0c f1 ae 52 3c b9 23
> 0c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 42 3c 80 a0 70 b0 24 40 30 20
> 88 00 2e bd 10 00 00 1b 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> 00 41 54 4e 41 34 30 43 54 30 36 2d 30 20 01 7d
>
> 70 20 79 02 00 20 00 0c 4c 83 00 0d 42 00 00 00
> 00 00 22 00 21 00 1d ca 0b 5e 07 80 07 b0 04 00
> e1 fa 51 cb 13 b9 3d d2 0c 01 45 54 40 5e d0 60
> 18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
> 22 00 14 8d 5a 02 85 7f 07 9f 00 2f 00 1f 00 af
> 04 23 00 07 00 07 00 81 00 0b e3 05 80 00 e6 06
> 05 01 74 60 02 2e 00 06 00 45 40 5e d0 60 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 b0 90
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
>  1 file changed, 2 insertions(+)

Pushed this to drm-misc-next:

[2/3] dt-bindings: display: panel: samsung,atna40ct06: document ATNA40CT06
      commit: d7c2aad1254a1b4e6d76947cbdd18813b02a0e24

