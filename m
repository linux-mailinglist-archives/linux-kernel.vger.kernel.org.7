Return-Path: <linux-kernel+bounces-864636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9EBFB3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A085535670A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82B315D41;
	Wed, 22 Oct 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrKHwu/4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8D313E37
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126886; cv=none; b=WU0veUM+k8ijKx0DU7V0EZ8wUQiNOV7uziWZdaw449w0qcNWMyFbdY0myZOVr/QNrJ8VcNXP8Q4i+tXHO7ZmRfzsCEBnNfeFPWysBqSHlXCqtkcorGUVs6MVfMdP63xaXvCC/dBJ/TvUEbkPwT0rdIEsfSXGyEy8O5e3qczR+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126886; c=relaxed/simple;
	bh=HB1y7cWvJVBaffceb4N2grQDkRK84MOxaGljtCDtKQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOL2H0eOiX4dVIC3d1cicrBDaa4QJwQ/vx8zL65HE/IA7TW4hNCrJo+bCmPXKJwrYKnMnTYhm3Xix3DbTQrjGjiuv/beGyXoE43byTWh6Fd9l01862oeAhPKhf7u6M9ehIVmdtVkIJZPztCKVtGoDYpK/cc/4Hw9cO11SfRsI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrKHwu/4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso8875272a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761126883; x=1761731683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/BE3p8f/tb4AmnzEBEYSIcdIiv74xFJHBlZnCilZ3pE=;
        b=MrKHwu/4HGuNYZRe9NfyEn/r6PYiIzIyDjhvEywd38xFpAjXvTbeBjxbJb9ncwGMA7
         BmgGTxiqVR5ujIx2nyrueqN6Vh5Hr+uOqHnz0b69YfDJhqlU0ytNKMLcwXeRkyYhayUU
         NQJCY1qYsAmw45rDACQP/EJfWr585ufAc2XgU82MNMIJJUanEEmDDwJRHiWea/JR95f4
         2zO2l3ZIjV0dRlmrKr8VFcokTlx7n2bW4aTaSpV2xSKY5/Lrz44BVqx25oFv4qVu4ffa
         qtHre8Bn/CTMSJ/rgPL5luimvWFH429lu0yN4wyfxjVou9EZbRo8f/umIGycNlEl2SmR
         /LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126883; x=1761731683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BE3p8f/tb4AmnzEBEYSIcdIiv74xFJHBlZnCilZ3pE=;
        b=nDiV+tSMtRY+NglpWSN7NabbfuUbJv+gYi6TBmXW2Fu42Azo7SOFUQ/H36SBblWqgn
         TjHki3yY2wfBZEmnglCQNwINIKQJhzJfEtKSsxcu/oYDwzPTF/Ph25RXcrA9KMrPr3xM
         Cm223ipknRV9lmN0YRCWz0PI/yHRu2nPDiflVm8IUcednaJt+vM6HWoqZ1UtvJwA3O0Z
         zErLdaii4I3JNL3u1qMlwfGa1IqIXwEnx+oDVT+agI8dVQTlv2mx41dgrDqsk42wNueK
         RqkY+e3lGFXDyjeMkU3Q4N/PSdPuUfIuXuBY9KgT2VnXvUFkFvvXy5l2apq5l7QuXWXL
         MYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8cTID2dJUx0qxd39PXrcrhXP3p51GAx0B9+bFuFGdc31LwCG2g4DfZICnYr7qMPis5ygpjlloUK+p4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFbgvtIHdnt13bXM2/NWoZgNF6RtF9O7ie0qgbP+KSt/arTkX
	QxeQ215I3/Ms6fbXTR7XulyyFwCKbU1MDnNbS5BuDRFbkdHSLJu30acE++H0K7dJyzh6tABZPkn
	NRiB5c3ocndmJay78hoq0fpjyIoqtKb4ZUyf2dcqPFA==
X-Gm-Gg: ASbGnctbeTFZ6EsHmsgbw3OWE+S4vdLquT20SDsEExVAkSCy1VFkfT7Bg3La9Dka7dj
	pmODmimuFvAxSxrF47fiNt4/n7sqPAFA91g3afw0+sTSrWSdT+n4H0dLkegHR+j/NnfGaGLPUQE
	APNTYwRY1uIpJBaYOg06NlcBvgBChafH78DH9sSQ6bcY3Sd6qVqtf9AJHWeXRWQJPDcdrRg3P5G
	eixeWVqfesCaWJXReOEEHxtYa9jchoLlr5/KrEsijPqi9bt5IbFT8vcmdYbi6zYK3Sbk/1Z
X-Google-Smtp-Source: AGHT+IGxvyYJRi71ypaY/f+2tvs/h/Gx3CtsJRVjqydJdRQpedqCN+n+dBFxLmYoHUas/Vv3sBj08NYXtnVui6clXA8=
X-Received: by 2002:a05:6402:5212:b0:639:dbe7:37b6 with SMTP id
 4fb4d7f45d1cf-63c1f63081dmr20417683a12.3.1761126883450; Wed, 22 Oct 2025
 02:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021222955.193323-1-heiko@sntech.de>
In-Reply-To: <20251021222955.193323-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 11:54:05 +0200
X-Gm-Features: AS18NWAUdMZHC3UmuDzl3MkQoA2Eup4bT1W9-ZX5g9xcPcRU8J3IcH9rg1TAlQY
Message-ID: <CAPDyKFpGC292uOpWh542_=yS2XP5tAUWiJhj6tp_CPVrZ5VKkw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Add compatible string
 for RK3506
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 00:30, Heiko Stuebner <heiko@sntech.de> wrote:
>
> The dw-mshc controller in the RK3506 is compatible to the one first found
> in the RK3288 SoC, so add the RK3506 to the variant list.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index bf273115235b..acb9fb9a92cd 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3506-dw-mshc
>                - rockchip,rk3528-dw-mshc
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
> --
> 2.47.2
>

