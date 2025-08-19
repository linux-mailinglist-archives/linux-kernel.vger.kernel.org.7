Return-Path: <linux-kernel+bounces-775731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877AFB2C421
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C5189F8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C83314D2;
	Tue, 19 Aug 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EP98dYxp"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3A2773FA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607720; cv=none; b=Mjo/zqKDrTXHFlSTas3V/6GxEQ+ZbXMWerxbUwacOmwuBGMeBvX1MJLYnJ8c5sHXC19rSbYltzmuvdTtSWM/Ut8Kq0AF3yaSPvD3R+j7BC4EDRJROdqVyRobXzhKRF6SQfAzPflVWbQLmcR5qteBWaJOCJDM0QQZoIT6e7taG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607720; c=relaxed/simple;
	bh=+6Vhrw93VOWzQ8j3tGD9sppz9syXEpi1MpSMIFUFmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEKrwZYhRswadObkM4ErwrwP2bnnI05VbC1V7liSGTaZvZ+9xmTrc6FSAkLfOyPtH/K3w6GDooq4+rYWVLO/PFeoBrtjh+rtv8qGJLji12/qFgvg+odz3R/JNR40HyqZ6EBtwK/Md/D/yWg2TOMSJ2MCXD9xZK82vkTTvd3sc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EP98dYxp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce521e3f4so5655687e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755607717; x=1756212517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Vhrw93VOWzQ8j3tGD9sppz9syXEpi1MpSMIFUFmk0=;
        b=EP98dYxpzmtibQs+zlFeXRRt9o9ZWSVuZOJOAODtuPZERH7IuxPw8roLklRHqr5zCj
         FioHFrhu/t3/A8ARxXBYmoR3qY+RBcd3l+C/w//iIxTcmqGgoeT8ltMllTACcyhM9USX
         wuZP0DFYz6iNz67kCXEd9d0MAqZ6BOBHTQXUqa38v4uzc6/+NApXBt9hh/forDaYfkmg
         m8Sfll6sSzC73ynooVGZaV2mGlzfMmllrjW9W1oHy4Bjcw4AAQ1ZeFEyxwyIlsXu4O/B
         ltqzGRFM4jNTzUXqy0GV0YkHFm2KYNHw+gxE5eMyt5/2wHm0AW5RZIWd4HUjXZR3z1Jw
         GfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607717; x=1756212517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6Vhrw93VOWzQ8j3tGD9sppz9syXEpi1MpSMIFUFmk0=;
        b=HCHlGNF8soPvxIS1MnoHZeSEDcPD4XJIdUwgSsBxcJozzlSNB0zset+3mYpKvoR0me
         Jc/bOFGkwdo5+iE25fsnoYt84TlI/RaF+vdzYsh0L0pc3O0QmR6q5QMCs0SWe2zDwrDE
         w+iFxzz9aACYP8iRNuz9CqMx6tB4m8fzWKAQTao8v6UWU0yMh9Ma0y7hJuQJqIFr4E/B
         0JPlJ+bsbtSd0ex4LZY1BrIzs89JX6/DaxTLqWpLm045xiBRXOjRGNXilnPRQD43svgL
         x6lVG+OoapA8aP/FCIojcGRUXFfjGrU8gqkNlwYAFsZ0BKkOWbVvFJvzS6WoHuw2Uqwt
         3M9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPT3dm2WmXxzmlul6auRkJh+OF1qPJWXpEaPBXnj47bIJjlgabgSZTlJkMFlP1HLAuogQVHRK8YrphjzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXa4s5lGVld+MKLFDy7UyhzKoVnbNPhIqYJ40HBmkUlN768y0
	GcNMj2MTj2K91TO2HO5xoJlXhEz/tfmx/mviWvEXbAMq/6NFkr+gf3GGkmZ35WmmIGSgsK0O/Yl
	YPe89zPhkbwj2Xwo3szSGudxrOhSZe9SM7C02THEE9w==
X-Gm-Gg: ASbGncszaQ26wxTQvLx2U9yUWGPN9YBIHX29s+BoDb8PQXGuuzSTK6mwaSuKx7pkIA4
	O8qImebNrMxiJq7FunA9DGPer09ic7cJjtTPUCI1A09EtKiLBaGQOj5qQeJvgo9GK5MV+lYlmZZ
	ACtggGbXZSlEVBRxRvSiCW89oOw7CX6AXqvUhOQtDx15RifTJ7CbBK4HWSwZ8YoRm0Twy6O4NY9
	VBOx7iGB5Ff
X-Google-Smtp-Source: AGHT+IEO5Q5KeoskGlIms3cL1kgpuG3Tin4R0ZiCNdWP8xfdXObPNVgZbMj7ADZ7hK5rm1fZ0JhXKv53ilShdHoEsxc=
X-Received: by 2002:a05:6512:108e:b0:55c:c98b:39c7 with SMTP id
 2adb3069b0e04-55e007fa342mr682379e87.55.1755607716665; Tue, 19 Aug 2025
 05:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815111733.79283-1-brgl@bgdev.pl>
In-Reply-To: <20250815111733.79283-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:48:25 +0200
X-Gm-Features: Ac12FXwdf0zGZXcVDNksVHGwqoT6ebJ9_yJJqxs4KUELxDvFXNTsRgKWa3ehq1A
Message-ID: <CACRpkdbzu9fvfvCV2BqhN7goUm6KLHbP1NCjQiFj8sqqNxxVxA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: don't use GPIO base in debugfs output
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We're in the process of removing unneeded references to the global GPIO
> base number treewide. Use the HW offset instead of the base number.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

