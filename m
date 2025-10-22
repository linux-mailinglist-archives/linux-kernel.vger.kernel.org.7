Return-Path: <linux-kernel+bounces-864763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C43BFB7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CE24E6F49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87496311958;
	Wed, 22 Oct 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbkwqpvg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E5320CBC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130590; cv=none; b=ulo6pOWdrpF2Fh9Xp/upnl0zu4U4JyX+vlOFyDmtsv1wPCTNzvOVIlsuxria2ovmfr4xKKJTjqbEaIs8KHNJnp17MQ1c7Fl5cIT3iOrcRpQvhwwMMeKGNQZ+TLtMk4Jh9Y57+D/jGOoUl+e/E+pV+iCaN6TLqg8NCFCn3VteXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130590; c=relaxed/simple;
	bh=dUV0ayqZiPaf4NOTXVPmQKKkCug+aByTSr9dcbRPtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh2GpQ/4yR0y3eI4QgLAiCqYeoVXkxGWta5622KYegcoiHMW+hCV65UTAGyiNhm0n9Y2iEX/Dt7R4kiWXTq6Z089IN/j2iAbnPJRXLwfVvFan/a/HS3tTg6/zr7D8mzAtZDO5o7X2vjpvhE0vSnjUWse8JXScJLVk2HSCGGYI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbkwqpvg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso12037085a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130586; x=1761735386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0A20oHPdwlwvYfXUnWJzAAzNbt9Wdmj/9G6WPspGzo=;
        b=XbkwqpvgwNgAqVFgu3Ij22ZaZIg8Dsa3XApkKeXwBwV7IUEsgwYc/0UTGWI94O0iBW
         nTI0adKhdcjmcORNyvhFS0/OCgQovU7TmEo842ofiGyAgVFi3W2IBwjBJ48Nmwhz6bSl
         +JXnaK6mRP/WKOC/9zS/GjNt+eU434E8KIz6eUNSvv8CXEYsQ8d/Ju6JE8oeXxLa+jaa
         S45J+dqY2sXL8dhqdNcUodIbyr3sA1FkFMHiXC8PTdpaGKcs5Ch+6YxyYvx73jXqB8ca
         q9QKQCt/G4koBFf12sK1+MasypKXaqKO6psmfFi1uYRXc5Xv1u29vY5clVDeAyinWSHR
         61DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130586; x=1761735386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0A20oHPdwlwvYfXUnWJzAAzNbt9Wdmj/9G6WPspGzo=;
        b=ZKedbvovv58MzbvkuBajZ3ShCF79LS5h6lGvpLynwODj6+wAZF42u4ePEWmLpnz/ud
         pufC5rqUU/P+rcWhBrj0ArV0T5wUaHKiWJs4REiPhE32uj+iI9buoalK7Erz9zSvH8At
         av5rc4lz1URSypO4Se1f8lLK6oqTONDjRad9FGXm0kop/XlCCnH6g6Rr9DHIaVak/O+V
         93KTWPIC8Wa6YyQcsI3z0Z+9NqFktJ2g90qAD88eJ9hfQLe4BPjxVEiNeIaxhaTl1b1g
         5NEN4clpv/b/9RPJBYVu2Pwlq443lw4Xi9Iwv40mKllO9C0kKKfjvmA5S+7UwCjfMEAu
         tTWw==
X-Forwarded-Encrypted: i=1; AJvYcCWED4FE1fvO+Tk67alvByuEHs7DHSQ5vnivsSdA/4GGDimJhKPZ5Y7u82Y+dPBQfO64DCfA3P7xxdJN9Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlV8sLS/o2IJHHushyIJkSuIgVaac4XgGcBBjCzxP0BK1rNqs
	duMRZX0Fwvos3EktFBCjmZX6pssz2BeiNF4SV0/bmoOz9nSPuxGLSR29
X-Gm-Gg: ASbGncsH28l4RGXUDeqYP5gynRJiI5jfDkgDPHfbI7aNwQb7WXhYczw+EefCmoTOhog
	w6c+3JlD5h3bbiKa4xsV7tYsWWCzrFN1AVp5c8eqTntFWkqvP1YExvzBRzYT+e0VNm2JAyMa9wa
	hUngnST0QelIoLVmAIsMXZMHVRS6puOTVpEsS7aTjGXo+TmACrY/5RaXv9IeR+Cu5xEs2SW7gLo
	dlpYWxGrNr2wroygoVzQsoF4Qp9jYIqDYFuzWzqOGM9BD9PrfJtMamongeUlg/HyRKIPelTWU3t
	MnaJDb0r/6hM9rOk/sS2n9uFXPdFNw7hvme1OfuvpHu5Yyliap5CWFi4eiadWhgZOzKpC2s4kjz
	y6ZoXoI0Cjm/FWzQvZUyWgzE5WSk7AIMc3CNUVFjvO1US0yRMsq7/c/qB/TANgsGC8JMgIRvzII
	TvzLjfABfLxU1ImpxozoSHBTC0phgYdYmsBqxoo99+XfwXpA+L0MK7Yan3hAQcpRK54ljEwIA=
X-Google-Smtp-Source: AGHT+IEdGRi/hFagoGGgzKcGR3Q9DoSBThXuzMQp+xb2RQm2aipBLwQ9bktG/U+2WDFiA7eALZVStg==
X-Received: by 2002:a17:906:da09:b0:b6b:a82a:bbbc with SMTP id a640c23a62f3a-b6ba82acfb4mr887771466b.33.1761130585840;
        Wed, 22 Oct 2025 03:56:25 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-79-17-196-24.retail.telecomitalia.it. [79.17.196.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm1337364466b.56.2025.10.22.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:56:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:56:22 +0200
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com
Subject: Re: [PATCH v7 3/3] arm64: dts: imx91: Add thermal-sensor and
 thermal-zone support
Message-ID: <aPi4VqxIF/hltDC5@alb3rt0-ThinkPad-P15-Gen-1>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
 <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>

On Mon, Oct 20, 2025 at 03:00:42PM -0400, Frank Li wrote:
> Add thermal-sensor and thermal-zone support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> changes in v7
> - new patch
> ---
>  arch/arm64/boot/dts/freescale/imx91.dtsi | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> index 4d8300b2a7bca33bd0613db9e79d2fba6b40c052..f075592bfc01f1eb94d2a2bd8eea907cc2aed090 100644
> --- a/arch/arm64/boot/dts/freescale/imx91.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> @@ -6,6 +6,54 @@
>  #include "imx91-pinfunc.h"
>  #include "imx91_93_common.dtsi"
>  
> +/{
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tmu 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu-crit {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert>;
> +					cooling-device =
> +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +};

Here you define cooling-maps with passive and critical trip points. 

I was trying test that by enabling CONFIG_THERMAL_EMULATION and setting
the emulated temp via 

echo 85000 > /sys/class/thermal/thermal_zone0/emul_temp

By checking with mhz (from lmbench Yocto recipe) command I was expecting that the 91 start
throttling but is not the case, Am I missing something?

Thanks,
Alberto

