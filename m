Return-Path: <linux-kernel+bounces-852521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C2BD934C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94DFB4F9229
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA413112A4;
	Tue, 14 Oct 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeRbIqUR"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB23101BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443429; cv=none; b=TWWV0J1qtnvVEWLQB0eL+17+N5mQu5oFNiqntzBKY0wyDjfXnUaLlh2xbSz918wNw88Im94LQ+BBQ/a9yUGCc8Px6I0y50oZzS9MQfGlFbOVtYYXba67XUbOqWY001IZJuCvKlLHZK7vWdPG4Xd1nI53wpl9LBA6EjItKetLepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443429; c=relaxed/simple;
	bh=0NzeDm4YRr+qmfFJMboOlJS287Q0PmtLlAQtT9HyscU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ld7lgnZKs0Ymqp8KXBvHpLRg28TCg0qnjcgaQwlfRmBEKImHIpVffl8Eahx/QDUodbHryejj0EIDdJE8YMIsgrVztP0jtiFm8A6eoZCH49K8tfT5EJH3sXtwjFZiB5/4Z4lyIZDfX1fttTpcGlyy64ey7RDCSezJQPvPUdlXoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeRbIqUR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59093250aabso3971933e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760443425; x=1761048225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NzeDm4YRr+qmfFJMboOlJS287Q0PmtLlAQtT9HyscU=;
        b=KeRbIqURvSmDKHLD9BjfyIl86pAK4C1iZUq/tjbs9bCMuphFQdxqW/bAwAcKUAv6Lm
         t2wwL6yXnVXaxgrF0sLYb737SQ8RdSXjPkeXO5507NRFOtJA4msOXarJBHf2TSkPrEfZ
         pxFqUgNRQ7AKGBqXyiDY7KwpgVVKEutHHW2tS7ahbfy4iBGKMRlFQyzT/5jYpbWmfRXe
         lf/ysQHLr3QRASu7pWgUnhdiN1VaT6ddwnnzRTyJY8hWJDGJTH7ftYZHxcgmQyuu+m1+
         +N+7s27oeoUcsRHx5dygwN8+RN/TogsDtRbxTubRDheKks491Bi1l0+2JQtjj6ZQrTq6
         7KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443425; x=1761048225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NzeDm4YRr+qmfFJMboOlJS287Q0PmtLlAQtT9HyscU=;
        b=ZV1q0HyerFe5+/R+QXbdh6ljUW5ACN0VqK0VgcIxCkGuFLcCiQTUu6VSnNRv3IBSY/
         4jwQzGr7uAS3yFf129HOQoMZ6y2LWD8oSfabvqxQBwfFVhKl1hNWtFWiPMoaz5xYQD4C
         mI05ONP45sJihECFMjM1+2TZlyxIlywTALtc+/UdCw2Pp9JxbjtSgNbjKIMBOBP5vwij
         tWzuGNg6zMJ0UyRAmeTzBZRfPM9HEDcvhR6gU89ZzycsFDoBNEPl9+IrEnmuNUd8fUDG
         jls1tDKl3Gp3S4ZfYJT0wWDaRgNuQdr9qoavh7vp64C5LGFFoFs63KjdETj2qluST2ZF
         G5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeP0EFTDt0ZmP1MEj4JgEK8SNBrpVyu4qDCMqUOQhXfCJw0/miteTuEUsjfS4sL7HleLYYeCtTgKMEk68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2WLsnQrTMwJTO4bYblEGIHh3IkOQfs8vq75yEgNmmJQuSSPH
	ZUY1oprdyJrTyDRsfkQKbjDmpdoEbBaeVtlBxcM70koBKI3sPeO7WbJaWLGfPXrFDi+9cUKDP1y
	HW8dYNo1CRsWYyYY7tdL/cIRxuByF9ztVaAkccqY3yA==
X-Gm-Gg: ASbGncs3gcJD8pZCCA0qlHAM1QSx6OxyhjksAiMD9V5s8A4wtDZIqIQm+nWOHiXF5Hd
	kcPlZjjAKJhC7kLRshPDP4Rkm9ny780WCVOEHa1noSnWOiRSj7Pkvzf0EaBtvL5LMV5wppt2ywv
	l7vYCD75Dk62saw1N7F4XTAbet2F0UgBqN/x5ELsoncW+lRjSzUHWo0HOl1CNS/QK4syVIRhkzj
	ur5C+uMQvQfjAel5REQAdMzevFIbntPDuB4f9KY
X-Google-Smtp-Source: AGHT+IFD0BB7RH2Ep9aDetjvf52TraFr1nZFUAFZVtaRLq2brbGFG6VPJ0RQdb2vqcIUZBE6o0FGikD6X+TXoiS5UhI=
X-Received: by 2002:a05:6512:3d10:b0:58b:26:11da with SMTP id
 2adb3069b0e04-5906d8ef684mr6189769e87.29.1760443425099; Tue, 14 Oct 2025
 05:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008073046.23231-1-clamor95@gmail.com> <20251008073046.23231-2-clamor95@gmail.com>
In-Reply-To: <20251008073046.23231-2-clamor95@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 14:03:32 +0200
X-Gm-Features: AS18NWCj_bKF0VIZCo40xgE2nZcym7DwrLVXQ08YjlTg5hV9lzx6rx-fa2x4Vss
Message-ID: <CACRpkdb74fh_eFCd0MM4RK1_KtNRugLPp2yMA20FrpHq+-o6YA@mail.gmail.com>
Subject: Re: [PATCH v4 01/24] pinctrl: tegra20: register csus_mux clock
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 9:31=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:

> Add csus_mux for further use as the csus clock parent, similar to how the
> cdev1 and cdev2 muxes are utilized. Additionally, constify the cdev paren=
t
> name lists to resolve checkpatch warnings.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

This patch 1/24 applied to the pinctrl tree!

Yours,
Linus Walleij

