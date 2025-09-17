Return-Path: <linux-kernel+bounces-820977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC2B7FE79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4455E624744
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C882E8B6B;
	Wed, 17 Sep 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="RbBATuLO"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECF2E7F14
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118141; cv=none; b=R4JxlKgSMr3S+cm6x8kS/2fDa8icRSbPUzGj1o8YfoIZQilY2p75XDrzrjcGL/3/HuZ16TvdAQM7RJDDcU6C71P1T6WKZiNa/tBr/QT4PwDYEdFEzB5M+3XsJT/3FXDCzBWZIQwfMORgjZF5BmKFVhWXcL3PQ5PaGu+5YlLrZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118141; c=relaxed/simple;
	bh=y55jVHTsFdR0ohUFnQ8BSywHTKpU8ilitRM6NGPy960=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdGRgKybnc+5Xjz/+5/88mncIqRUXcmippM8giL2SIaf7blb5c1eFKAa4shUiKCoUYsFEdqF6nPRTZxTG7gVlgvVObc+iifRbmfdV8SRyK/Uh+/u9FNOR558VfTuWDa+Npw1Z0iEgiTAEloKfrjrKIOl7df0WCuVm5yU1+vWK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=RbBATuLO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88f1b8e448bso252972139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1758118138; x=1758722938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwXs810vPVolctqhE5kX1kHC5K5g0mvG5ftVgYqmopk=;
        b=RbBATuLOQ58sJ2hqNSLuD/4Nr7sHLcauJzrwfJceWGoV60JHpxDKEoltmtB5pfCWo5
         cSrEKXUBbwtuiyN4XHCf1njv7BsVO0reueEzAPb8fI75X74HRSZBSmc1Q+z6h4OSLXHj
         YQKXrkBBqQ7To1PQR7XzmkNS5QSmG0VXll/G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118138; x=1758722938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwXs810vPVolctqhE5kX1kHC5K5g0mvG5ftVgYqmopk=;
        b=KFU6Pgnrtvi6ShfAKLaVydJuq62FlLPDDswanwWEEI6S9h70LAVZZrdzp6jnzNYFuT
         Q2NaiL9TAbpcaEz2w/xF+YRBdWzwU+pE1hDAXuCKSmm05RCx1hJrzcCScpb0HARUciGU
         dj06Tf6ECq6mL+i+puamdZ9/ZYFVLvB3vwlN6vb6ceBvtNtZ1Hen56OVcLttYwN80qbv
         tdpYjZ1bmPoW98F1rbj7ZgXXqRYafEzDOTCVahn0XHLxM1JPLu+N1FYAdExl0vGkSnyT
         0jwAf/p2U9DAuLgbks39tU+kseZopb59yHY9bt2FRhpXdOHIxH5tapoplJCsZQ6A0DBk
         LW0A==
X-Forwarded-Encrypted: i=1; AJvYcCVN6HncCgkmLwL5NvkcJkdr572YWJf7De+C1tbw9xKMkq2GLJ5e7OBqIlizEWnja1QhiQQa4PRlfV8GmX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHUPLKfu0ZKNc6cKzNYWX8WDtXIKlpa/rp849vB3GbZ5+sfJI
	6iCVo8XaQLfpAn9O+vgRjJwUoSb6YrRS9/vPkt8LtwqYXPxI2fK5DATR6pJB5g23Gw==
X-Gm-Gg: ASbGnctvXS8m72lh/ZZ2+0bN7HM4EZGQzIXkbmCipMt1qARrLLPAfenfuVJrynERJrk
	l0wTffbpO1qKlJTCMCe2mR+4VE2Sf+rjJ8N+XZ2IXG3CARJnotQ9AmZmuvkR3tcwHK7iy1Iwmmx
	B91vWoeYCkqrD4pRw2opzvfQAbrdwODbAxmWjiA6E+Zwal9JZFA1hTJ6bppX0CFEYc9yf6JENqm
	JHwBBDa3KiLKU6Uvz/4Yg+LlOkI5XRa0+opnAfv+hdeZ8IPOg4wFyfI8p2P2gfJFYaZMWYxUE4V
	bdE7bQD1f9StI9dhDs98Fn73mpfC81U7Xn4U9Y/rbFnpCZvDh4IBxl9pZyGjMaNZ87zpOyQFFHM
	ugvql8Lit2hfFES7ClqEjiVSORMlhMEtiHnQ60IL0xtLrk8sWNv+TU+8qpTC1GEw=
X-Google-Smtp-Source: AGHT+IF/fBkdFTD3FTvzdS8tc8bIkj0IKqMAIt/hH+T2GkDeQwHL7JRVqgSvOipa21x1SDVuYYQNaA==
X-Received: by 2002:a05:6602:3412:b0:890:1f62:492c with SMTP id ca18e2360f4ac-89d1bfab247mr324144039f.8.1758118137550;
        Wed, 17 Sep 2025 07:08:57 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2fabe0bcsm648019239f.25.2025.09.17.07.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:08:56 -0700 (PDT)
Message-ID: <99168e94-9f32-458d-ae3a-55d0dcee3dc7@ieee.org>
Date: Wed, 17 Sep 2025 09:08:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: i2c: spacemit: extend and validate all
 properties
To: Yixun Lan <dlan@gentoo.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Troy Mitchell <troymitchell988@gmail.com>, Alex Elder <elder@riscstar.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250917-01-k1-i2c-schema-v1-1-bd276b366d9c@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 10:38 PM, Yixun Lan wrote:
> Extend the K1 I2C properties by including generic i2c-controller schema.
> and this will enable it to do the DT validation check later.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Tested-by: Alex Elder <elder@riscstar.com>

> ---
> arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dtb: i2c@d401d800: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'pmic@41' were unexpected)
> 
> Link: https://lore.kernel.org/all/20250825172057.163883-6-elder@riscstar.com/ [1]
> ---
>   Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> index 3d6aefb0d0f185ba64e414ac7f5b96cd18659fd3..226c600deae142413277117e25baae09f0918381 100644
> --- a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> @@ -9,6 +9,9 @@ title: I2C controller embedded in SpacemiT's K1 SoC
>   maintainers:
>     - Troy Mitchell <troymitchell988@gmail.com>
>   
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
>   properties:
>     compatible:
>       const: spacemit,k1-i2c
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250917-01-k1-i2c-schema-faf6715d7b88
> 
> Best regards,


