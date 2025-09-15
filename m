Return-Path: <linux-kernel+bounces-817047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A23B57D17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78111208227
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE5315D39;
	Mon, 15 Sep 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKTYBij2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05626313297
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942867; cv=none; b=IfyS/fdQj6tDPphddqxOBD8yfLF3ttxJk6Ap92vpLF7yu9upxSAwrl5Arw2qZ0uJrdAkR9BKhhayBzCKVgodQIxsIO1rcLJCpylo3UqSx6D1O9l4WRBdi692vgTWPJKp17L77qjSnGpEQwKjkRB8fDryHhhcVk2RMpTX2+KNLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942867; c=relaxed/simple;
	bh=1WwEFBivcQFPvdJ+vG/cDspUtw0KZYVXb0gEbIG01PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UodcmQNNAXywi1510MLHK4rrgB8FlWcNcCRITYJ9bC7Ufj1BUM2mHdcpoPHNLhkKFuKevu2cf6IImKmWFi4KrJHVDd2ngopbVKaOmvMrkqqrD5+/hU4cSV1C3h1FyiEfbdXDQN8n20Lh/z0njvrkJyXnsy1uc0FfOR9WEjCsDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lKTYBij2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336dc57f562so34761371fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757942863; x=1758547663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WwEFBivcQFPvdJ+vG/cDspUtw0KZYVXb0gEbIG01PM=;
        b=lKTYBij2O3pMpi2AcDXY+M40VeX45EF2CLelfgvchyufncj09bmPYm+614+btVpY3B
         y9TwHbcrGq5hIHWBtc90nB5gvMHxQKx66U0nm4bdbTSUWOKaHInkfLEfFZr3oub4kGoz
         VMmdorBtTzbuVMlIB8HNtrldIJFS7Y9XVZ/dRPB/N1u5SnVTToxDCdnPx8Jz0urkDell
         bgBbsICKedonDw4rtV20JWEpvBAMiph45oENUjAU9EW2CytvsdJDmURPR933Gj6+Dxzx
         hiNKe1+KnViMJypLfNO5bXypgJoFHetxMbl0UPwf4U9LJ86b1p4ca3TwQdtpBYJUU5qp
         jrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942863; x=1758547663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WwEFBivcQFPvdJ+vG/cDspUtw0KZYVXb0gEbIG01PM=;
        b=tNoBUV3NN1yDrWsMLK+hQdrHmXEvdfz1XvXupTNK3zziTAfVbjK0pfBMrpI6uYWC+U
         nFSgHw3az2SP7oC3HlDutdT18drM+oYjtD5pAFODk5JZqZwVJO4fpE0J39XJ/pYwP22J
         cp6MUq202jRlyJ9fGvyiIvp8afDTA7YGv49NKcDqgWaUQ+jac0T3G0D4Rf3cn/4HzBF6
         HAecMikByDNOqLRAbli37pCaQrL3zI+KneCLDj3zZOzhH2xTK+zOCNucC8KiDrL+c+kB
         VOn/hBh/cCgv6Pd3inpxwnkyCZI+ykbSY/QZdD11m1zpgmcbQOIv5X+STfuzy26rdJiX
         GffA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ityi8iFI/lUDssyeZCcVauXw0wg7Mud8nhnHUOujzMOJLf+9xls4rgjH9sbnPMV7imdoxrKTrSDnAEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNKY/SGNJ1IXNeAPbbeleiUMDdX96rdtbO+dGx+s06P9vht7E
	+pS+Xp8lvrdhScJ78mWZD9vGY+XXPMJKhb1WFHC/ChkVH/HrXONl2fEAa7IYiLb0bK/S1W9GyOA
	Gx+umS3O1UFOXYcSN2NQwhqYIGSdPQeWJFtywnaLMDA==
X-Gm-Gg: ASbGncvsZ2cmEWPZULOIz8eNYvhNtVJ94hYHbpGRGnL+NtfJ+EgzFhqnFjku3KiOG/h
	HrqcLAiP2nroCECo4ThB/lZ+ND8k4yo1TwhabX8ItyzhJTR8CLIMJIKHZbTGCQWyiVDCia4vTyC
	cLAjauhsxZu4StGo4N/EevpujdKjzySrA3hEKkKCY+eZ/Sk5VABrCXaaBtznikNL7QlCM2ZD1Kk
	AhBusOG+FywpLaU/pgem4Gg6J+b
X-Google-Smtp-Source: AGHT+IFgfjmqMYnXOIaWipd/39zNflboRpCuHneAYznmUhdiyLjY2HbEympVHUYJ5CPB0u2c+tTL66iGf/QFYqj40GI=
X-Received: by 2002:a05:651c:40c1:b0:337:f40b:ceff with SMTP id
 38308e7fff4ca-34e2b95873cmr28261471fa.0.1757942863077; Mon, 15 Sep 2025
 06:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915091007.28438-1-brgl@bgdev.pl>
In-Reply-To: <20250915091007.28438-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Sep 2025 15:27:31 +0200
X-Gm-Features: Ac12FXyYyzxwYwBXKfmLtOHF2Eq5B6VfMoLEYuKJNeHENi3UziVmtNkXhN3IsyU
Message-ID: <CACRpkdaBDoED+maFVbiENcOruCCtmRe=wDfkRtthuqqrQoY-FQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: nomadik: fix the debugfs helper stub
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:10=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers
> in debugfs callbacks") failed to also update the stub of the debugfs
> helper for !CONFIG_DEBUG_FS. Fix the resulting build failure.
>
> Fixes: ddeb66d2cb10 ("gpio: nomadik: don't print out global GPIO numbers =
in debugfs callbacks")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509132232.12viPUPB-lkp@i=
ntel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

