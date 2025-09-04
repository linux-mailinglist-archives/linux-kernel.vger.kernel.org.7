Return-Path: <linux-kernel+bounces-801563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF4B446AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BBE5A321F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8283272E45;
	Thu,  4 Sep 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6SvjqDu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A323D7FA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015157; cv=none; b=eixQ7awVfXoawkbC8ju8noKmBJHo9Vh+8WkGnL/KCszV4dkGrrs5yO/6HEGTOvd8a5M9iraqCPPJ82+k9B7Hdw3Yu1zjjHi/jzJ/ZR+jX59fLkNmlFNYiyOyfucn/Kq4ON+5mculU5gx1q9mfxH5WdHFKu3HBRGXrwnKu2+8jCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015157; c=relaxed/simple;
	bh=hzWQ+NZvkCjPqaF5rQWuE+BV3WjbZDFdOwhEuuB25rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/DtwUOi7wfAlL/QpLHb7HvsIuQ93L9FJEzvxFh+OLqqsxzxgCEMXNDDN42Njr/SGSJW8KLGRLOtsXanU24VrQt9drBMetqDt1cf+CZToMxGh4AZXMyyNBLPClEkOtj2QTn2HVPXsAw/asw2/fQG5jNkNS0OemwXCm8ha1gSnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6SvjqDu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-337e1ce5dd1so10984161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757015152; x=1757619952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzWQ+NZvkCjPqaF5rQWuE+BV3WjbZDFdOwhEuuB25rY=;
        b=U6SvjqDug2r3Bh3E+xqa4ahbWya/SCsScNAUzYXo7STgzFY7SGDUVbJeGEwcP9uyLy
         yh7VoojAACI/g0vl6OpsjytJ5BJAu5Ve91rGKNEecJJ3DGeO6U9I1zjeOIfTFY1tKYaT
         E/HE1uZUECFVPxtHclhCgxXxMAeO3Qwo7HLVWP2mqXoP7IGdhPjzUybgKFLlwX1bRHXJ
         MlceJUyuQB974GiA7zwJ4xLi60HKG0XUtRSR7nJNSw4aTwBonuH3jGNcei/MxVfp9G2p
         y8C85NKksNxhBFDNgHw1AopZssg+8dZDHABoj12Qs3jMsiU3XnYi5lKVuzC7iyxEfIXh
         3gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015152; x=1757619952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzWQ+NZvkCjPqaF5rQWuE+BV3WjbZDFdOwhEuuB25rY=;
        b=hv3wd1JYPCjIPebsZ/zZjcLv344yIW7d+BG0qH35/fyW0iiRcF4fuBP2V6nZj1JTbn
         EwEeUd3P4AipRfdN429fjAB5MaEiKNU++WUfZ8uzLnIcbXODfd3wHO17je/c7210R0Ja
         j34Q4tZngnwATQK3+FXaTrtCCpr6CUxxGc6i+yzF8zp0yM+6RrLhfoDs3Ptm/KaHlnyG
         8m0JM55zLK3IzLm8RSVvYLFWe70rt6Y96yIpGGGqGde5GhVjoziKWgvAD7Mxm4j3sc8t
         dZZfhk3ti+Nx5x8rzUdO+3zWwj/H/vIic3bRyEvJDV3pz4GtZCXJpHGd9D8EDUPkd2Zn
         J5WA==
X-Forwarded-Encrypted: i=1; AJvYcCXgsUyKC/heoY9LPfTUeh0p/tUvTKgorTfY9lCnGAIUfKntzuSlJ9564fxukd46ebKYH5ihcIWDOVkya6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HpVseogaNZOZEkvtc6bEIvL3+QhMZ3K6Sakk0TBWQ+3xVcmO
	pXW+0KXqWjbhVV4c5ndPo6SX6Rceh0tZWWm0Pt1D6VJeLq8BTHJ9sbPgALkkebrezesDZIrmGdc
	+dMs9pIlnwIx9AaMuQM47TGSuRgbFmqVT8YaiHHjFww==
X-Gm-Gg: ASbGnctejmShVANBUPgOx7IoK5KCazbu9RHSNx/3LBj/8HBpwzaTbgtSDX6TO7Hz1Yy
	H+wRmriv+D1tl6bA7U+P3qFnQTDR9FqM9KahruGduCwYSoCgrgsRUcJUaqg0PLSIew/cPu3JzCh
	plzFUNbPOLGg0tn/+lUePwP4s1VgjfcbElbnlTuS/fGBI9WZHoA2yFJisOYKNOfO+tabfgMyhiu
	Sl6Juy7rPUWi7GHxw==
X-Google-Smtp-Source: AGHT+IHyOco31RUv2Oe9cKuPvD0Htgm4IoRC25q2CFRrREw8Wo2WlCc9mBvTU1sMDJcN9tENLMEe0p4jJKwMHOJBxZ8=
X-Received: by 2002:a2e:a54c:0:b0:337:e460:bef6 with SMTP id
 38308e7fff4ca-337e460c680mr43543631fa.10.1757015152027; Thu, 04 Sep 2025
 12:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904013438.2405-1-ziyao@disroot.org> <20250904013438.2405-2-ziyao@disroot.org>
In-Reply-To: <20250904013438.2405-2-ziyao@disroot.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:45:40 +0200
X-Gm-Features: Ac12FXx4X2_pNhzcdcYEzziDJRvtowb7CpE7cKPonDOwSax6LARZw_4oRio8qGA
Message-ID: <CACRpkdZfruCqEzN-sMtxidh_e7JM1e_LG3JKaQ3ahkDAnx59Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: gpio: loongson: Document GPIO
 controller of LS2K0300 SoC
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, 
	Kexy Biscuit <kexybiscuit@aosc.io>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:35=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:

> Loongson-2K0300 ships a GPIO controller whose input/output control logic
> is similar to previous generation of SoCs. Additionally, it acts as an
> interrupt-controller supporting both level and edge interrupts and has a
> distinct reset signal.
>
> Describe its compatible in devicetree. We enlarge the maximum value of
> ngpios to 128, since the controller technically supports at most 128
> pins, although only 106 are routed out of the package. Properties for
> interrupt-controllers and resets are introduced and limited as LS2K0300
> only.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Looks good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

