Return-Path: <linux-kernel+bounces-793443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D0B3D371
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6183B97CF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2EC8634C;
	Sun, 31 Aug 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YCsrnuh9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBE257848
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756644959; cv=none; b=A/P+oY6G4ARsv7XkKD7LCgkDxTQQUNQL1L88bbuZe8aF9UmgtNAS+ykUSku1bPFxlflpqZyksGxIhVPucut8ucBXHpSVNJu1rhkQnBZyb1hX25gPwlohdXfj3fwDhsQ9wxc5WKeGLeq+QLZTDFrhsRIhqlqnvXkar05clXiOs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756644959; c=relaxed/simple;
	bh=kQt5ZAHwLEoOMcqUxZJRYUW4ABPDrG3OFWpa0JEgif4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8xAI2kXOg5Y54rEHTGCEHTSH2J5ZdG+3bjkET6EuJPzQXZNCj23x53Pznuhb7MhvYhLCyQoofYZS4mL/QIWiaeFiy7bYEh76SesccPR/7dZMRzeGhGx+xOYLGNLaEz9GdS48ILgFvk5zScklpAnnvl9ZLhRcK8j/WXdbdMcH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YCsrnuh9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso50164e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756644956; x=1757249756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi/Fu/AVii1gBs16M7Z6P1XZ4bS6zvGwg2JRMC6pZNY=;
        b=YCsrnuh9pTqZlfy7c6Qy849mQzW/frPpodxbRsBcEd8V7UwZDGrU1c1DB/fmXecX64
         btpta39CQq6ODInJeoOQIMhPvQwH1VmATja1yIi55VyPcE/GT8nwAhzZ8HyRfsXLURgz
         9LTMjdMMEQnF9G4CLOpx74MxoUhaHDkVr2FS67WDHMFnJYmJqbXaONugRWT1H946uSe2
         j8X2c6TjWzWVBTXhBTIZLTiSCcMUTnR3Apsh89O+Se1t31fza6nADsBhX9Kl8L7P/r/W
         NY6SYf7zqXKQ0Cs4/05rbQvJDiC3xjPkdRYX5nZJHbg4BKLHn1zqZx8qvGqXWMVYkuU2
         NeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756644956; x=1757249756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi/Fu/AVii1gBs16M7Z6P1XZ4bS6zvGwg2JRMC6pZNY=;
        b=LC6/9ficjbFs8T2j29O1s9WhBjBK9+tKk2IfXLaKZPcDPxXxRJ+PtAjPpGvF/WeMRV
         9d3vnfSrjnLMLI1ezVmy+xDxkb5/OzwJxpyImALVIH1wsFKBEgbiilznpqIqM2icf+N2
         8Hm/zSeuA+eXM0tcceytRjUeI8AyCy+j+WhVEVhXQ5Bs6IhNu1j7AHV3FnSiMY0ndQXt
         UWJOBKYG7L6EaKaXPoPauvvONbWFIls/E9ol9cToI/kh2WLGMGwEjvaEXMbFoRiORKIX
         6xqv249tMz1Whi70axo11rVHUl/oVnHI0WBFGFevy1TDfP/vPvteFK21uGtM5gJ1m1aF
         +0uw==
X-Forwarded-Encrypted: i=1; AJvYcCWV40ewWVtcVLUg7Z3bcn3mF1QJQOmqVU8YB5Whc5h0H28N2LpxuyM3m9V9uwSvFL2tfPXeJA06O/vRel4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFA66RJIJ8ZBkVZlPA7arLxUfZM+F8RzTf2JgSZekW495erVq
	nFgKFPFk1x3NB3BJ+xU4icHxGJTOCYko8PoFQH2TxpdkQvs9Q8w/bFJ31UcJVtgEbjwQogrQTlj
	8fnEaZR4WkYAV8zak4Sn4XGH6k7dNPQnpjijT6BMRcQ==
X-Gm-Gg: ASbGncsxOgYH4L48OXk8Zfn2vYddgL8rx2cxVDzvG/hhpO6TgfdGoIP86F8iTyS09D1
	NHRPbbN+TH57vkly2wiv800UNgRBJoJFCPcbpW9lVlx+ZgBIIU/FRmxXNMiF4Pjf1kLiYOmdMUA
	xGD/5c9TN0RwKG3PVbX0AQUamsx6LKSp8hLkzIfenYLq3TR1MzqHZDt0MzmYjmexoIUAlJ4Plp8
	HaO7Fjr8yevJi20Dwe1pmyQB/Zr8gQnSL9MJXDur87jek4=
X-Google-Smtp-Source: AGHT+IHniTXa5/4UjcWJoEBwBQbEyZw/BW9AAZMM7U+Hb9xB55u2uHi/PlTM610ZTLzfQpPenEMzKjZmWLh4kF49NLk=
X-Received: by 2002:a05:6512:244b:b0:55f:3c07:958c with SMTP id
 2adb3069b0e04-55f709240e4mr909229e87.37.1756644955560; Sun, 31 Aug 2025
 05:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831030855.957707-1-alex.t.tran@gmail.com>
In-Reply-To: <20250831030855.957707-1-alex.t.tran@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 31 Aug 2025 14:55:44 +0200
X-Gm-Features: Ac12FXyAQEHnGX5GrlT1HPWQ5rbSTaGU-1EY7XEDobHljDh5pDPBlDId2SDPZLg
Message-ID: <CAMRc=Me5L4XtriaFSwcE9Vqri+6d+Rfn-4FzKUrN_VSOgfA_WA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: tlv320dac33: switch to gpiod api
To: Alex Tran <alex.t.tran@gmail.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linus.walleij@linaro.org, shenghao-ding@ti.com, kevin-lu@ti.com, 
	baojun.xu@ti.com, linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 5:09=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com> w=
rote:
>
> Changelog:
> - Changed reset GPIO setup that uses 'gpio_request' and
>   'gpio_direction_output' to use 'devm_gpio_request_one' instead
>   for legacy support.
> - Convert to gpio descriptor for use.
> - Better error handling with 'gpiod_set_value'.
> - Removed cleanup of reset gpio as gpiod api is now used.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---

The fact that the call to gpio_request() is still there made me think
immediately that the conversion is incomplete. I looked into why you
didn't change that and noticed that the global GPIO number comes
through platform data, specifically: struct tlv320dac33_platform_data.
That platform data struct however is not used in the kernel -and even
the header that defines it - sound/tlv320dac33-plat.h - is never
included outside of the driver. Seems to me like the main obstacle to
completing the conversion is not even used in mainline and can be
dropped?

Bart

