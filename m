Return-Path: <linux-kernel+bounces-838988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F2BB0942
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9078C7AD019
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601D2FC875;
	Wed,  1 Oct 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HUfgTKlY"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E272FC871
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326801; cv=none; b=teWfYoGEMv5HWi6drcBOCvUeF4S6X9CdNeyPh0FTMD8AF1DU+RD6i63tWncD6Vqg6EgqQ0xsHZcBRCoCFqSBYh1bqHwFw38agJ1sgZCoILPTB4DubVMnEo1g7CZXEXrN5CWmd9gfnp1TL5Otnf2KuHahvK5FDAzOIN1Y5bEUtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326801; c=relaxed/simple;
	bh=HKbSceL0DqvzVkSf6+zthbI4p8KdIl+ZOzq+TUc17ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PukM7YVYBP7iUjezd9zC42Fbs9f2qnRd9xhPR2D/d+sNE8uPz6kr2rCYxPIImzKStEycO+r2RLpUn7MdKcFl6e5mdURYlEq1r+ZmmA4LyzDt+FBJwKXjS1AMp/bxHfHmVyfOgWmOmd5wksrNFgJPhnIR/ZsrF+vEACOS55Sgnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HUfgTKlY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3637d6e9923so70924341fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759326797; x=1759931597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKvM2O7Z2RHzNxkLRoLXZKV8FObDukkA/ffySi/dWJQ=;
        b=HUfgTKlYyVnJ7X1ZPU4BQieTHwWZxcpgiOjQWpJyk28jeRbcttMC8NHUtrBLFEHrGz
         E5PVoqB56vzqIPnOXJr1ZQHz4ElFcUenbNAEzz7b8dVbxoGEYE8JmBCfmj2x4DweV3jg
         BuK1k6EFp6q0M8bLBuPwGmaySRBukzqSB6MD2N4k+sKp92Ifcmo9A1mvqtzkRgPN4ZVk
         fpwHo9+3bw00uZG8WtvvTjpJiqrHfIuISeG5S6+7K87SHz7L9H06bLuS4hVSCuPH5cE3
         atKETBgXOxL1UDJ3AUwHIJarIGecYy7SoBTHXjnLw8s5VfkZ5KGnwvtC58H6nCXE971P
         GsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326797; x=1759931597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKvM2O7Z2RHzNxkLRoLXZKV8FObDukkA/ffySi/dWJQ=;
        b=ep0hnk948MIhVA8uQcWHasOQ5hCWdBBBuq9fS2BOzKq3mtsAo2O3DXyX68WqK+C+cb
         oXjqlvMAlydn9+FonGX/ZPf6FyVA7yDY8kDtdDIQct6ojkETcGLC/M62OAY3Pprg1a/D
         Dy8VGfs3nR0qT/pBzEYkvOBJf4gOdTORjuB+UyaqJuG3mS09nXAqlVYalvb5rkORSS3L
         /2yniFmUyK4Sje/8Y8Ghy9YzUZjXfTWGp62rx538efDtONaK1XgpdDZrqW2Xy9UXmREx
         4F0CZWKOW1hOUNtX6QRWjEjEOhStuPRr609B8m3xTM3Hf9IX3jcL06/s6qc7cXoFgjX0
         RMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkwna8pSvM0/e56f6ZV1fy3R8JSLskP0jHbse/lPPbdkpGAVUgj81gXugnRuV0P8ckREUf8qGmeZHxkYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlBe54aAadSbzAw9vWfrlE/Ng4NCqsWA5kIJoc1BzIYb0oVy3
	eGtJeUdU8BoTWMBmfGIfHOqIre71fbiWpaCOXfl+nBhIVMdxYo25O/ZGe0CxTqCs9s8N4WVU3eH
	EdGqy8lWXPTm9uNVwRbKgRGgSGWYfWM02vHymhUOXBg==
X-Gm-Gg: ASbGncsEjKB+zUtPkvUyXF8pMANo+Pe1JUF4crN+EL1QUN642BkOOzGyGnCEyDkvt+z
	NhMiCFOTYQeOwcAzxOzkqyImKOnmFeR6jzB+c20vZmJwRHspeIWvzlktzSL7VJz4NyniwPOxzqm
	1dqXpZM9lXDVGWGTde1hHGStAYKTejDwGDFkH2e3zvMHWOATBJNQIPX0M7lvlqnsgDKtlq/9bhL
	gO2eKTY2FyoaN2tQUv7WnQlbFRsr5pNjprGsAI8ABcxtCpR0u5U1Jii4mFmvdc=
X-Google-Smtp-Source: AGHT+IEawILhQN5Tlcl9p5Mjqx/+g8BzI0MIHHSa+12Xe6GG4A6vAQ2TFwAqsdfR65LWs2suCvY9l7MTmjpZSBMVUHs=
X-Received: by 2002:a2e:bc0b:0:b0:372:9bf0:aec9 with SMTP id
 38308e7fff4ca-373a70e9ceemr10229771fa.8.1759326797528; Wed, 01 Oct 2025
 06:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com> <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 15:52:56 +0200
X-Gm-Features: AS18NWAmCgokIXZ1UkEVryOtNua26Mh7SEmTh-56Mvq0WRalU4tAqLsD_FATkks
Message-ID: <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:10=E2=80=AFAM Viken Dadhaniya
<viken.dadhaniya@oss.qualcomm.com> wrote:
> +
> +       if (!device_property_present(&priv->spi->dev, "gpio-controller"))
> +               return 0;
> +

Hi! I didn't notice this before you're returning 0 here, meaning the
device will be attached to the driver even though it doesn't do
anything. It would make more sense to return -ENODEV.

Bart

