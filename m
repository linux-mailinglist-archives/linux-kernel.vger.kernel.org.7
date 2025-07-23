Return-Path: <linux-kernel+bounces-742391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6AB0F119
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5979117DD14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53AA2E427C;
	Wed, 23 Jul 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vI/7kfJv"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05D2E06D2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269807; cv=none; b=KKaQvRUxFZFIQEEBtL57+HyKg1r1mY7ISTH/coIoNMm8eLjhIngQNxzpNONT93dWGfS/DJG7dLBX1k08JC7aq/ueAioflBFK83icnyZJEh6M4APAfNDVRYzWw9KFFWgmv4NssuOylD/UgD0d3sPhacBMmp8GQ6jxrRp6AhWN5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269807; c=relaxed/simple;
	bh=ZPCDtPuwf8qirJAt3wlVNDagGbR60GfYw4v1OF3Stm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLq6tBLHKFsjzjeK/SY5sXhnECMN6T2j3TB8ecMZMAB6d6cuO1HHTFXooKo/fnM6MILaEFwBPnBCUpVtBMe14sAzQbn/kErYoT3KbTwDh7LHfLy28VNzw0HLnEdIGpTN/BVyJL+RZ6IaO3mencZbMsevtOSSh4wK8wJQYava1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vI/7kfJv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b4876dfecso8602101fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753269803; x=1753874603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=vI/7kfJvLVIhMRxJkH+UdR7qp267BJ7blx0UaHBH/T7eb9+4Lm4ksSTJpdupgKDzJU
         FK4p3ATdZRRklT3nKhnSmw83IqlofIfsO3ErzyCMf4Q3VLc+ZlWnsnaJELiAHLvmhgvv
         08RlALSSq2K82Fg+xcIyuyFtmQvNC+iGFAqyExXVrnWmi8zGfuhuV4WXpi8GNJNP7zUr
         uZ3U1FeQbExtGk3vlQSKmkMmFw/7isxUaAypccIGWOzcqh8HEh4smqeuC2A/YWh4K6XC
         HYSgIAUDYtqAyvh3bgCHfOBknVgmsGj+CEfFrxdeDHI9Zi4mckq3VOKtKlg8gddxf2W+
         odDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269803; x=1753874603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=xFJMB5WC2sj6hmiaWxrWV61b9WgoBqVIaVkqwtkvJw+g2/cguQXt2bvbgMeoVq+jNM
         7cXSMXRRQ4e6C53VMMwx3K9sOsrlvpqCZqhGKDFEql7HRxbVU40i/ESLvzmLLfa4k4BA
         1qjFTG9A8Yjw9tQcGJaInEkqWd9v+F85ep/HpFNRjZXlwLSd/ZqQv+EA9NhNmgi7qJgi
         rFjEvpBEq6PyX3eJw4GKf3IfMlRishTr0XMCiK1KmJyM5mdZii2GkJt5xwLaH42hWEzg
         wNosIzmNDfMHtvxyqAcF0tbbtsAnMEYG6Z/Ozos69GCVGG05tFw1JX2E1xFZ+qMc7vsL
         65ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwslYbwhN4tatzPD6DfhBbqDTz7SrH2qjWtt7m+ZE7P5s+nCsYaeuNCyFEXrk7LoPBKAz0y+dJyddCf7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2uWn5euxxzuPigpSzvQY8kLTnxElT1woZ/LX/FLeuA1Ol+EW
	3sUsA0fDn960fjFYCnfj44DF/AZzH3EiAHGGoT+kWHEPeFuYOkqQ+0dObFy1+4kuNoPAvWWlDEM
	NJL7ejWznSiSaqcBuoQmeVRfTVHf0yWQcE3+xV0fV9Q==
X-Gm-Gg: ASbGncvjl2q8Oxq/oDCoOWETFOIp5RqPsm1V85ALiYWaOJ25ryy9ro6yI/Sradc0+v4
	WG1+X79DZwamyl7smko0Vj0QfB2+9eSXOYDZRH/uVLjK8/O5UtnIjejQYJOUfjNMWfMWXrqqN6/
	SLx9TczVa7KUY4uzHefnFZYJZHuB4mEqpl0epd7WLvLjzbC7hwtcmZKoGkTgwvlyns2uE1lVAbZ
	t2sxvE=
X-Google-Smtp-Source: AGHT+IGJe5Uxr9HPFMmzv6FKaMGGq0DeXYb8MEs6LCeEdkH2Ux3eyASfDB2156qvlMRtXLw+FwseABeguK4wIAj2U48=
X-Received: by 2002:a2e:bc1c:0:b0:32b:4441:e1d0 with SMTP id
 38308e7fff4ca-330dfb33727mr8322611fa.6.1753269802839; Wed, 23 Jul 2025
 04:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com> <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
In-Reply-To: <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:23:11 +0200
X-Gm-Features: Ac12FXzMES-g3RTrhXb0FNTMk2mTyN5VcSrw3I_gOJGbbpbB-aPDVFXKwi-6bIg
Message-ID: <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, p.zabel@pengutronix.de, 
	BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 5:43=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> The PCIe RC PERST uses SSPRST# as PERST#  and enable this pin
> to output.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

This patch 7/10 applied to the pinctrl tree, why not.

Yours,
Linus Walleij

