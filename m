Return-Path: <linux-kernel+bounces-838464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958ABAF393
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5455E3C6767
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC882D6605;
	Wed,  1 Oct 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZaVY9S4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19417A305
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299766; cv=none; b=MwrH07izNCO/G4MNP70mbiPMbmt3mkTPI7mQvLr4Paw2O4Wjc4UdHI0AHo79FhqvXQdlhBrKq3xTNLAWs5NlcjN6jcB8BzbonfAz45O7390F2+z6j4NV2XOv8A/wKj4ZbVPJBod9nB3ySlbA/+o7p6jzBNs5DHOJ5hcyhSjHwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299766; c=relaxed/simple;
	bh=Jkzbo1gBTocRzXpJgz6IdpcssNc9wqVP/s/XEKzd86U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxZcvSRHg+qrrYt11VCUy0xiggspDAoTMtCG0C4yfU+CVFWR9THZnUM9hmoe4QewowGhrxCZ3Rhr6ydrVZkNi4pyCosheMIeCmdx2eSgqKgwmVoN6LDmNLq2npJXXTp9zOQkIH3OVedGgp7pJu1MCDvvEvVsx/Ur8hrbOznWq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CZaVY9S4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57e36125e8aso6354813e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759299762; x=1759904562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkzbo1gBTocRzXpJgz6IdpcssNc9wqVP/s/XEKzd86U=;
        b=CZaVY9S4oSydABjyp+Ci5j9z9JeXtil1JpfPMndBo0Vv1puuRJIcgFW86eowoh0y/B
         /ymCIbbKbhXFAZbC/CyHArIhqDMEEXwKxoByiDYRxn32Tfb/T2/sBN5DGWbjM1UYrkoF
         3hpg3iCuGsms3zVGm8FwTaMKTw/UZSm3pU2pyKJeeM0O7F/g36iwDdFMuwigqAAnqb61
         3oqY7IZfRYyWU3GH/zTnl3v5v/bw/zKHGVVlLwAakIMkvCkifxsvKwrLnWBRR7NOoRjQ
         qldOZXcG1p1qDoYPh1/XTrYnp2189iFyF8zeegRC+F18IhnNRkk4BD751IT702CV6CaK
         C4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299762; x=1759904562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkzbo1gBTocRzXpJgz6IdpcssNc9wqVP/s/XEKzd86U=;
        b=hWNkgjkvgPNnSxrJC/qBbcJ7Fk11t+A/LKWU5IrSL3tzvxFFuQZfGbXKtwnQbxLBU/
         oiddyXFkaJTwAV9DdY2I0DuERcTiDLAVW1y89O+q1myN9QCks9N/jl5mG52T2sgtjwus
         Hjd3spDbdj2SknB8qt/AYdSQhyb8QSwHQO6l+vXbA1KvRsOttw1BwrD8DRcozDgkwHWJ
         tGE93LeucLEkg9F/Are3BAnLeNEJ5PiViNbzc+FuGLoCGBcEiXCskhLIuYYKFZPMtJKu
         WSt//sIgSGju3WpE/OBDOm5xP5vsjstRP7DEz1RMFY+/r5d3yPu8YGZpJni/7U02hAqg
         pEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0NCTHICIhJRY1Ieuxygjxl4dhdcx1WTq+XD7/qeDOBMfQMtWlPTzYWBDmmPs2oYoDpdT2UIDfvCqL7oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE7xXnrngKQ+XUiOQo4n0h+clCSwvPKIfmhRtbEe7cwz9sIIr
	gMflr+IIMrlgjcaOsA2TLxYIoe57PLwPY8ptHQm245GYao+hd43pGqTkwuX95Htwx8FrvlQ/U5h
	7sxzhtuvBxcEkzCfVn4tqOAxq+vrxF1isDa3JatONmA==
X-Gm-Gg: ASbGncv5YMuabtgU6ofMs/OywV1Yt0cnEwvjtpNweTI2TF6v52qrRvvxhaQkPxLKboN
	WmVSGiVctfbD7zumz1kmtbwvgynk6Dtabr2ImdKsH4HKU9mbteEhb5B9yC67ipOpOQ8bKmcB+KE
	V62smkIBLARBdYMW4XSxC3XeDUbAKGeLOKRk7z64WGRpDURP92b8gvDqhdVpiWx9ITobyi4Pbi8
	iVyaIfeekeMZT/5WEVhBc8Ns9Q6dQg=
X-Google-Smtp-Source: AGHT+IFDxYob5oKkyC+td6gReKhRgBQ0qAzJ2bKwhcp2a+hxMNqK3eKLU5W8xv4pJwFlU3vH+EYVG2LSKSjXnLZrsrk=
X-Received: by 2002:a05:6512:31cd:b0:579:f0fc:429f with SMTP id
 2adb3069b0e04-58af9f7562bmr691627e87.49.1759299761748; Tue, 30 Sep 2025
 23:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org> <20250917-gpio-generic-flags-v1-2-69f51fee8c89@linaro.org>
In-Reply-To: <20250917-gpio-generic-flags-v1-2-69f51fee8c89@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:22:28 +0200
X-Gm-Features: AS18NWArlnL3SWUPzr0b7NRywCYEVXigtEYCqqstGC-_Umyd9moG7bazfHNJA2A
Message-ID: <CACRpkdYHcTcMXB7Z=4mNjXuj5N8fRQXA1CGSgoTjVRuAw8+Ovw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: generic: move GPIO_GENERIC_ flags to the
 correct header
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:54=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> These flags are specific to gpio-mmio and belong in linux/gpio/generic.h
> so move them there.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

