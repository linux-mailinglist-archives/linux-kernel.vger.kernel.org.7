Return-Path: <linux-kernel+bounces-856239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDEBE3985
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C59481974
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0421922FB;
	Thu, 16 Oct 2025 13:03:16 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB31CD1F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619796; cv=none; b=HviJAr2bfTynIi4geeOpuuEEs5DGA7CDVVcEqof/T9g75v5URJYV0Bm6s2wewyDqarbxAuhThZofI8HSXipaBFGbSW6ozFe98pFU5EQUf1n+oleUAQf/MPTHN72Q7Gw3JfD6T93YNk36MxV2U2cfmbxKcEmkRAtENhU7nVQuQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619796; c=relaxed/simple;
	bh=0AcPguF7DH274FG4kuspo74fxSRZ6Q4tez0YJJCGbm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At0pN31l99fouT6OqvzDxEMDNJeo6Y0jd2OkCHuAG2C8X5mIV3d/8vGMdXmt2qy+sDeqmQgrxcZc3/i0quTCE7z9GNGm+U8DCnO/FWZ3jGZSTGqxwmyQ0EQvRaiWqIPpzVnAS/6I2kssAFG2laxnUczAzFIjVykOnH0JL49/pTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5b62ab6687dso549721137.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619793; x=1761224593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdIoMomFfpw6tW8BeWtLibvojBlEBE1EJKLZQ5iP+S0=;
        b=qQn3E5D++mpN8aVLsVnjPLfC5wcIUEo8DUBwxzkWNw8v38IgZLJPVVDSYtqCi9mni5
         oy1M7WGgb/x606NoQ0JLmnI55LPFq0WnSP8NQU4BW45ppFOt5ZJgimaggznZfhp2L8dq
         aU/vMU0t7m7n1PIKDfPH829oxxlR2DVV0qghs8qLzQSK4JDiYfD3TP/cSchVx3ZcPWni
         FP6pf4n5F4nYmkpTPqNhUhyyBzkANvaiO4YLkM3ikJcdVeByPSeBPUpLDfMeRAzKF503
         t73xxQsBF0Ya4/FOoW8wpQXmPJwljOaK6el9cmMaFafSvWVrwfoLuCA0To4QPcAFDFH2
         hvTA==
X-Forwarded-Encrypted: i=1; AJvYcCVALuXTK12mMiqTw17fgBfWA67srnz9++ixUPt0kgJWA0L05KJFff/nn+ESKSqwkXqNxfgPwG5eQknY6TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGO9Ua0IZpR/usjCUEMkrfzENSOrSe0JtkxvZIJASBf1QOKZV
	tnFXmMdb4k/D4X7821DDvwZ4iSynO9itlYI8/XpDOzB4+1WmpuCwrY9ewSDIEMwo
X-Gm-Gg: ASbGncvNbxHRpe8zKNAPZRQTaVmumXA5DK4TJTwZ/SSdhs4MPeWHFRPoWLBNM4k3aGn
	cNwuHxZz58JEWsjMzO1q8o65Rzv/dfYxo1M+n830oLyLqlM8R13H6CLNens4inBQLuodkIgyuZe
	AMiWCmUW2wI5yoQp+lr7/w8Zf+qwJWC1DtEVxr2J0M9GRljmg0dhRtqq34Nt+R+JyZuY6xFlH8Q
	AcCShr8AQUvmGMnD7UVGk5lbQhiLUagXMeeSXzyPSFwr6pwkm8r+3YMom4oi2V8lwXzNkNlK1PV
	9lox8ftH23qaFyZqoQmGemDBdKOOGGSW96zhbDVj94RLnE/cWqND5I37ABECcgGW2q1tqIltw/x
	C2UD1wR8Zv24iVEvJSG2kS9mIWDrE07ePZz+8lYZeWAnxyx2sI5p/yM/0Izs2O+UJhqg0RD3yev
	OZgIoSVzMY1Y76I/5lmv7W+CL6nlP+tTRV1SE30Q==
X-Google-Smtp-Source: AGHT+IF3ncR11RIyltXgA7CgcXmKZPqAs6l6MlgynzdZ7DhvDf3MvhmsFmRgIxbaWBQPBS86OwQfQQ==
X-Received: by 2002:a05:6102:3749:b0:51e:609d:316c with SMTP id ada2fe7eead31-5d7dd501a04mr68329137.4.1760619793440;
        Thu, 16 Oct 2025 06:03:13 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc4e9e4csm6352259137.0.2025.10.16.06.03.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 06:03:12 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5a7b2a6b13bso462586137.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:03:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyocwxa5aTJ/9WQajXDJ6YpzATPYkbg0PgTZJFGhSJOcuc6qT1SCYqfT6TfdQcp+8aryQ+VuophA93kCo=@vger.kernel.org
X-Received: by 2002:a05:6102:e11:b0:59e:2c90:fae2 with SMTP id
 ada2fe7eead31-5d7dd6a1252mr46608137.30.1760619792176; Thu, 16 Oct 2025
 06:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com> <20251015205919.12678-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20251015205919.12678-6-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 15:02:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
X-Gm-Features: AS18NWBZilE682DWas3ATbTkhQVgsQwHH9LuAVhgcMxFqSN3t6GQlo6WKm_9ezg
Message-ID: <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Thu, 16 Oct 2025 at 14:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Reset core uses the reset_gpio driver for a fallback mechanism. So,
> include it always once its dependencies are met to enable the fallback
> mechanism whenever possible. This avoids regressions when drivers remove
> open coded solutions in favor of this fallback.
>
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Closes: https://lore.kernel.org/r/87a51um1y1.wl-kuninori.morimoto.gx@renesas.com
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -5,6 +5,7 @@ config ARCH_HAS_RESET_CONTROLLER
>  menuconfig RESET_CONTROLLER
>         bool "Reset Controller Support"
>         default y if ARCH_HAS_RESET_CONTROLLER
> +       select RESET_GPIO if GPIOLIB
>         help
>           Generic Reset Controller support.
>

Makes sense, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This does mean RESET_GPIO will never be modular anymore, while it could
still work as a module (the reset core creates the platform device,
which can be probed later), albeit in a non-intuitive way.

BTW, could we run into a circular dependency?

    config RESET_TI_TPS380X
            tristate "TI TPS380x Reset Driver"
            select GPIOLIB

I guess this should be changed from select to depends on?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

