Return-Path: <linux-kernel+bounces-821662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD450B81E67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C203A6EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24C303C93;
	Wed, 17 Sep 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="twuEkCiE"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E4302CB3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143565; cv=none; b=h1Dp4SUHZioTCkgO3M9PsjuZQ/HgkBYvMLw5uJaBRnkaF4lnNzp/u1OtpF0/OgjppsBoABzq5PlPbVD+/W2AXlBpUjjuZD59ytUl0KsXE7iHjnV/J5gdEPRwCQ8i7kWqRSW2F4XLVF35Wd5AfD7/9J4IL4WSZECzf2bhs9a4seY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143565; c=relaxed/simple;
	bh=/pZUpGBHTmE6mbNDSvYncRjIgMqSNBgKDeqYVc3dpF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqUW4XDEdrqnHU8/G+EIjk2zy9iOaEJ7P3GUpqE43PaSA2NKN2HQAplKBGRnFI+4pxIDntNRETG877uVsYfGcdYzNQZ5EOZpZYK8OiOeR8RfTEd9IEHC5S21rR9FNWEcdXDQ8kxCMuiKQYA6wNZe3nj+A23IUx9PdvyofdgzE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=twuEkCiE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cceb749d7so85394fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758143561; x=1758748361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iSXIXWGlC6CrncsGDJJsV/PQ7JiHZCG+7TpNAxXWjQ=;
        b=twuEkCiEHfVrJ7qx/t03Z362603PQqJOAPvpoIOXzav7JaH10rdLMewO6otJpjlDTY
         BguiDXIZ1lKXnuow2eMYQylnA5LzIc5IRB5nR/sXvAvIcKzTipQFOxOxW//PNoWB9nZX
         2dGye2XVlabnzipZmhjR2oo6dxrNU7StICrJrgUadKuEhysMuEfaRyKzERoijDSkV3B+
         IFRnnVsWuDIjzId1HBY64BM1FflSzTqkEEuQ9bfoqU8XbNM9A1CcA4Li8fy8jpq4QtOx
         Pm9Fi+yglZ2FAaeh+5rNvd6fLrjSHnyNkPCPqJS19ZZUYBAs6BTRKV0l2InRpjjzGHUo
         +hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143561; x=1758748361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iSXIXWGlC6CrncsGDJJsV/PQ7JiHZCG+7TpNAxXWjQ=;
        b=UutizsQeHZQFzfvxqxCJXbotM3VjLA3x0zj/PyP8XroOO2Wa5Apxl4T5ReWOUCk+KA
         Ve3UgE1Bl5I/NTERK+Rf5+S9LDJAjnObrM4Oe0oeMCkOLcMTI8Pk2g6V9V28295D3MoU
         FVfqOTnySmpj0sYWnt/MW6xU+krNrBnRjvjexKs2QkFITOckmp4lpIETQ1KfCBrQQ4Rt
         7Fix8+MIZ4R/OWSqGD95+JCGXWcA/pYIgA3bVv6Ple3DZAZfVr6qoEap9ocQAUHLuUPM
         tQx447ylKq+iglSmFJEIOfH/1brUFALBHKSgi1MefFAIFMB6hoLDYcurMj7wzZDQ09D9
         xyBg==
X-Forwarded-Encrypted: i=1; AJvYcCUndpos/ptiCw1x+GY19HVnYq0ihzW+LxmiihhG072BEE1vGPg5E3xUP4V2f2UdgMHmfvpjN/8vX6v80zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MMR4oA9oKWbS7z9RmPwKRseHIKk0YhZ6Gizsf0FAx+1dxxa4
	3jJZ/PMWCfg7QJWLfwtQtZX+g2l2pnZ/0NjziKBd+f3FDw5F2wcylJiJ2Cktul7/5Vg=
X-Gm-Gg: ASbGncvvn74jgTVkhUnejBn4HGEPjeidhYE+2wrmABvqbH/WnNLbbug0NngXLk3t2mI
	KNPX5ZDxo3yhDuIan/20TP0QrURjTd9QSaLOFLrnDlu+5lABDJ9PDQPez1kAEkOxsZvaqw0M0t5
	G6cSgNjYLq+Xhg4kFMwcqs7PsSeBVP/xt+xcYqzaMtx4EtBuNSIM7da6mSjC8PL5dwwPCwgwi8Y
	ijMr7Xs+8KUDNtbzfyv9lZVhFpsyhphy543Hgyoe/h8LyXtQL+zFvt+P0nFgwNBHGaaWqSsqCmc
	xWcxkQfa6fgDagvu3AYG87IxmBXFDe3kmXYQDPlYYiIswAHrZZEiEL3HNuuqBMq6VYpuCYTqi3x
	WERhA7JfDvo+4xstfNb3W+VfQq8WfyP9dZDG2n+svytxQ98jxIfAl62uW7N0WtBAe/C1qornssu
	JGZyc22ecQFd6hy7x3dxzhurRWCQ==
X-Google-Smtp-Source: AGHT+IESyBoa6fy5Yx804lUnxEgI0bjSNyCE0o/DwX9crp+DsZQn64gew1ZEZemPRgXYgahL8sIKxQ==
X-Received: by 2002:a05:6871:3294:b0:315:ab22:8833 with SMTP id 586e51a60fabf-335bf629019mr1908198fac.38.1758143561391;
        Wed, 17 Sep 2025 14:12:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692a973dc1sm252607a34.30.2025.09.17.14.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 14:12:40 -0700 (PDT)
Message-ID: <3a2096ed-a12b-4e36-aa3b-cec3353bb39d@baylibre.com>
Date: Wed, 17 Sep 2025 16:12:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: APDS9160: fix missing type
 definition warning
To: Yixun Lan <dlan@gentoo.org>,
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 4:02 PM, Yixun Lan wrote:
> DT validation will report missing type definition warning for the property of
> 'ps-cancellation-current-picoamp', explicitly add type definition to fix it.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> I got following DT warning, when running dtbs_check
> 
> $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- dtbs_check W=1
> generic check all files
>   UPD     include/config/kernel.release
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/work/linux-6.y/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
> ---
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> index bb1cc4404a55760d3f2ef3818d8f5c14782dc5b8..f9c35c29fe04c3623349b636a0dd7ffa4ea24a14 100644
> --- a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> @@ -37,6 +37,7 @@ properties:
>      maximum: 63
>  
>    ps-cancellation-current-picoamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32

`-picoamp` is already a standard property suffix [1]. Git blame says it
was added 8 months ago, so maybe you haven't updated dtschema in a while?

[1]: https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870ef1362bb711925f4f3/dtschema/schemas/property-units.yaml#L92

>      description:
>        Proximity sensor crosstalk cancellation current in picoampere.
>        This parameter adjusts the current in steps of 2400 pA up to 276000 pA.
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250918-60-dt-iio-apds9160-bdb725db100d
> 
> Best regards,


