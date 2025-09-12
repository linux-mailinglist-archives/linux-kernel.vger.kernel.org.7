Return-Path: <linux-kernel+bounces-814130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F728B54F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4EF1886B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833230EF65;
	Fri, 12 Sep 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi3FQcvR"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13130E0D1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684089; cv=none; b=eVxoTMpxukO6vLECSgbt+fNHNWO6MzkGBaKUvwx02oUyz4W92etriYkM2rsfB4oXVxF7x7SQ7eWdGhNrT3t/HddA2vdlbkoDcv1C8I8tDVFTgpzAb2FnYwwOf6Tjb8VjX2B10hRrUjneGkwYoOKmEHQT/Ck/IQRnqpV0CeT+ySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684089; c=relaxed/simple;
	bh=jBAJnWbm3U7P7Cjj9/LDsEwkfdx+34ipvAwi6e6JbN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmsZ6WZB7tJ8oIl2+QXEwx2F8z2OrHiT80HnTYXhzQq+Q3POc0RkRIks6XDDYtbkppMwhWhAZmw1yUwCSKtwWlgeQlr7Pd57dqz43BnKCMZUtS0BJdJBRYYVcDdlig/7/yrHHW15che90+6p/OLklci/nh9BQeF56qDWPMI9mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oi3FQcvR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94d678e116so2009361276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684085; x=1758288885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mZtqMj7Buty9BX5eJg7ubUn79cX89LfYOj/ik3ZHLw=;
        b=Oi3FQcvRq0UCceorzqvufvSeyjtXGQhRDTMwu0dZ66xbAAEgaUYN+bXC/WJhCoJiXA
         ROs71+l4unXx5dNfUfJoH5TxNstsOcBHdmtr+c6wE6PPA7Uab7z4+sDD/bvxfUBawpDc
         VXRe5rOC4vanfTmRx+wSyBK/4V7TAacKcdGSJuR4+QNdo7Tg/VieSrCXPu9qJZ8bTx/R
         NLsSP1ZD4O8s+LF4lRIqVWqGRP/rMy5uV32BssFd96TFNZ6NPSLylOuSM4zAkPE4tmRQ
         MdeNiYz5e9XAYDVikY8T5qzaGx8VrgrwWXSeWFJbBRazGgdgx7UJfVaRX+88I8rIgJtZ
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684085; x=1758288885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mZtqMj7Buty9BX5eJg7ubUn79cX89LfYOj/ik3ZHLw=;
        b=JKH9mwM0rS4yEtMC3Omf/ICdRD+OzYfCOAr22BkkP7dMPsy28IiUouAVH3m/n9tWTI
         x7hbPHgdPxs3k8navX6cSmtNOJJMWiIzzlHxbrNorBU9389HkdPaxioUAbRHnU44YcQq
         zFvBo7vkSgQ+Gs10UWsAG1m0oey+hIcsRsqsJ/HozLAbxq2OOD83dEweQQS0t6fYyjfh
         ez1oBwjWKOBdyiHXfoqzv3eFLG7gGOotW2aARDbRicrtuNuY2bkR+TYG0Bn8YVhIOYcQ
         xLkrMRGXbJAG04gmWUfOUKYJgmflbezs/hWuhgH0F5Rpll/xnnPVFDwJipredC3XY6S7
         6fPA==
X-Forwarded-Encrypted: i=1; AJvYcCWaLyeOlFwomVb1n3p3W/C9nowfJVjuX8A0JsYUwjzSvyymrVlGrndQ0hD2KjL3Ng4n2jBcVoQ1bsQU1JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSpDGXnjnLpyMrtN5Vy40uFEvg8L089pvVaW94WpdsDalf3Yw
	2F86GAnLam+U6/B/H7Zgeugll9pXslbBHwvLGMnUbFmGXyfXE4T1FiqgwCJtTO1G/wYXzEcF/OQ
	R0ObGYSbr2UJwf+zwNb+oOtlLx8sEaWqddqgHNL8P3A==
X-Gm-Gg: ASbGncv1v+lAhnJAUYSBtN66A6ctKJrwtVDDDeNYLfd4M3m3yFWuLeFba5/eLu9/dch
	FsQW1EDanFpTC4k1bEzXgY4gRLbOUqxxXj0GWP0iJdVi9gq2wlXzpwsG8kSqxrwUU/5GuhsekDv
	TBLhI+mG8pV9dZQpnImJIkRGZF7OeAtTss0zJ05vn4kZOPrNWpe3Xb0AQ1xpWEgR4aC1Tv7rztt
	ylLd6Jk
X-Google-Smtp-Source: AGHT+IF2QK5PvgUDodJDMy1anuNhy7mAPtH2+u/Cb/GRw6eKlaFsdB7czQFqmCkQDIeivB9L2qowVeqeZqmayZt5HLU=
X-Received: by 2002:a5b:984:0:b0:e93:2d7c:96f2 with SMTP id
 3f1490d57ef6-ea3d9a3f50bmr2300108276.24.1757684085343; Fri, 12 Sep 2025
 06:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
In-Reply-To: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:09 +0200
X-Gm-Features: AS18NWC26DOvm0iS2ScvulN5VJ9F2qVNM2KeyrWRgOgPMN3f410QETMn0vlg0XQ
Message-ID: <CAPDyKFowahX41+XqhQHmBcd9MCxkfo=pPSpdFinm4wHZSONJaw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-pxa: Add minItems to pinctrl-names
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Sept 2025 at 12:51, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> =
wrote:
>
> Some older boards only require a default pinctrl. Add a minItems
> property so these don't cause dt-validate warnings.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509030625.PBgLIAwG-lkp@i=
ntel.com/
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index fba1cc50fdf07cc25d42f45512c385a9b8207b9b..186ce8ff4626a1eb07633e08a=
eb6322ae2eb25a8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -44,6 +44,7 @@ allOf:
>            items:
>              - const: default
>              - const: state_cmd_gpio
> +          minItems: 1
>
>          pinctrl-1:
>            description:
> @@ -61,6 +62,7 @@ allOf:
>            items:
>              - const: default
>              - const: state_uhs
> +          minItems: 1
>
>          pinctrl-1:
>            description:
>
> ---
> base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
> change-id: 20250903-pxav3-uhs-fix-9cbcfd2ec0b1
>
> Best regards,
> --
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>

