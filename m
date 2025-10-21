Return-Path: <linux-kernel+bounces-862294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61990BF4ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DABC4FE708
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D027A107;
	Tue, 21 Oct 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kepdiKbI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4A277CBF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030969; cv=none; b=QC2ICpI33SDlGX3KXg5Ft3LZGSOu6f4ncnZmIIyRqWQMd1UyhMjkoCUjQSfFH1/qCbQETxCAtpuUOrnEmmAeca0zt9ZN/5oox8Hu7U+GKTIXGqaq+pJqoNaRdmpJamgKDBohmoQwKumaIjoNv+JewzriTONRlPYqLZ+B45PLJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030969; c=relaxed/simple;
	bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfvviEgi/SLHfSsrB0z/OyhAclfgKuFGR/qYetSwIsYrtEQFTzJNEQpl+YGT0lgxF3Zc1ssoGY8lt4XKjoWYBKrIUJKQ55IIAw3NgQttAzHJqsdDwGDjOzSRURednxvf7I6tdQkY4nqIrOtU0MMLwZvlQR8OAaqmzMy9AkBm2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kepdiKbI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-591eb980286so579762e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761030963; x=1761635763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
        b=kepdiKbI8ekSPamszj/hk5m50ouOSGP/DCVQg/X3cA+s1hgBv13VzJHI7U3lGsbdPH
         JgYcAOEubkUzjVUj6eiTNqHBeY5oEOaF/+myZlfTs3are917vPVR/CLnu8FWVMRsp2N9
         sKRUw4H0CgJd2J2r6gP8CPG6vHkUqfOv1xiI+Nb6QZTweh76tJ6PpkG580lDAaS6iS3/
         r4V/aLDfP6VprcNxZ3+/vj9rmKY1o/76j9Kx2fnpOFn2JoKKBHzHuGye8MbsdlFsbd1W
         qR3BJ2Vlxou7vB7qEPWrTRoMZp7DmIDe8ojEe2YiIA+hxPI9UjMGlEkl/r5ME+F8YYVH
         OpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030963; x=1761635763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQWEzVQ2sP3X3UgfzW4ijWcMIC5eMV3255ZFLSUlASw=;
        b=CXXkTZcyUrOGVLbKUyn38YMm4HO8njqQGBvB2dVyPxUvXM0glV9nZ9/vNDxBNe0T3U
         Aj5Dl7fUcs/oMp6hvvnNkRKUCjd8sFQs2tt8pXtOJpK5cfaf33cLcgIHAUqcH/S4723f
         uWUlvts+UJN3R6ReP9RtpzUHK6xr2VsgHJ0Jx/HB2D/o8XIfQIn/R7lyiqBqEH8ZviBJ
         +h+TUGjDU2EVLmn0J5QoxfwRkcf1eYmVlyNZfGPntAcRouTw6lSu10S2y8Mq9CaIqUUq
         Af+PUcSxC35Mskm2z9+8a/ZOdiLpCuBWYnAW0rzhgc6X/TDBlue12H2BZTRwmHKbrvDB
         Z0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUefwTCGW8LMxkeD+nJlIkbxHpniC79neXg1PABi1a5JIwuy3gmg+Y6vwA1xaBrvQtDZw4H0RA1/PHR8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1U3OB7K0bSuliMJU59VG/9gNxxJl+YCZGamS194+hqgXyT6F
	6myZBhQcWlOuigJFcFm1OIFbQGYbapDk9vxBRp80Ym7bO/1vtj/YgBrxpW7vY+zs/WZ769g7juy
	9M+ThOY7eTiKaQVoIVd8mz5bG1SrD7WbiB68f7simmuuYc0euN4h2Jn0=
X-Gm-Gg: ASbGncuwKRU/kt6Cq5hI/jNd1wBEhMOSjyUIfVT6SY3H2ku9V7HgZiarYBnS31rlFTY
	xA4no2PqPyEtDClvNHb4v6TaXs2UzdYDawhZZ1tfAJDvwDU2O0egcoTR0bBfaPW9rMZROmSNVAE
	uTslhI6OoLUtP0lEzyYeFi+LtCRCKLdx9AySz8ooAbYu7OAjd3/C5BPOhlujxJ9xFvF5D3bLY+c
	adQOwMdo5F8ETk+B3KzbGaagXUPdqRHnkC7QJJsOicGMgH7dtozic7vrgBP
X-Google-Smtp-Source: AGHT+IGzyDckrbb1KeiI9VS9GysBs3j9cjfg3lRF18ScYzfeA7CZmuQgIKBi5NB2RI/U9eWthIdLrHA/CXD4tCAv970=
X-Received: by 2002:a05:651c:19aa:b0:377:78cd:e8f0 with SMTP id
 38308e7fff4ca-37797abc759mr50103031fa.45.1761030963322; Tue, 21 Oct 2025
 00:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 21 Oct 2025 09:15:50 +0200
X-Gm-Features: AS18NWA5wVKiKD-IlLzPjovWaTZwReIiIH_ziKmQoyWOfM6XDCDv0q_UbsE4rDA
Message-ID: <CACRpkdZyyjLjnfqT7Vq8VvzP7bbT+b1s0y142ODEhiK-thButw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpio: idio-16: Fix regmap initialization errors
To: William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:52=E2=80=AFAM William Breathitt Gray <wbg@kernel=
.org> wrote:

> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
>
> Link: https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.=
org
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nu=
tanix.com
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

