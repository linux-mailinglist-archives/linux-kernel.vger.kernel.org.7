Return-Path: <linux-kernel+bounces-820230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C401B7C70D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4842A6481
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D43090FE;
	Wed, 17 Sep 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcDhx3lr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501E31BC83
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097469; cv=none; b=gmhR6N5/9IP6DTJj6E8TiYiLRV1+X3hOGI1YwSFtzUFmEVHkRH+aLoerGQK0Rr7SjIGahBr00znbmIS2n4TTRPNyQa5wreewQKUVvfKT6G9ru1LkrYA8sUR30ouVibtGbuUpYo8XuZ3P8G++RiEXBENIcKzh+OWnwz+v/ggEdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097469; c=relaxed/simple;
	bh=epw1I1hiABYxVKmrHWXBrgO+pAN3VLqtrs0eauOyI8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSwVrtAkaZNRuOGLVmTspSDWQD7oYlIxLLM7dM5ceWIRU3GbbkZjiQ73DVX8Cr1eFiZvM8USrxBRpf4QgJoXvnK8LcO+X1pRRpbzmtM/YwDzrx8mAQdgcF2gj8TwMmdyhS+ylMtjtfPS3Lt1NVIcdeP81GBkqp9vNt5C66L/iaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XcDhx3lr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso69815815e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758097466; x=1758702266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fat9xSXuNIZQF+zN9gSw7UW2xhmHEfI+kCDSXFTHgwo=;
        b=XcDhx3lr7Toynzoq3Mc5l1Xiwu+daTOB6TzXpn1GAQR20lyeOkZGrC/g8uN5n1BmAy
         /rmtmW9ixoyDyzVeuxqR2535O8IOqGpFS3Uo36gZWrt4g6X3myTXvdfHo/N4bITAMgRQ
         X0QMQWnquGvlQtBtzXxC+DJn5SCV8SbhjfChwcpP3Wu4EDprjX78XmSQ/OKvmrqVxhIw
         r0SaG67htLGCLS5IjBrFm2Zkg8EIhKV95BtDzARJqOCtDxfompXQdWCRKDwwLyR/JoHH
         j2O95AltJ67p+mf2oKsFXD5i0PdFh1knsoXD7Vy8J0skRSd8fOo/cnOZjjEGclGGHAMW
         QfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097466; x=1758702266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fat9xSXuNIZQF+zN9gSw7UW2xhmHEfI+kCDSXFTHgwo=;
        b=Lhmmogs01d071N1Ah6fv9E+wmp/yZWy/Tfcc0Jfx9s4d8SF0OnqOYcnWAtXSx/tphf
         yVlXeLQSDgMjoVkc3b5cchB69sJ9RxtyUdNMnH1jQwQPGpQP5yMHB2App6S2cCKVjA1m
         c1kFFHfuNBYCEZVG4skZf/cZGstXiY/jIiCs0+SS2/kRwtxF02ta0i5IsttfihX4f7M1
         Wg14Ya2roLDvdxzX3ztzWvdwCGMCu8KNprUGkcTtOV1dMTEawGmOxctHVN93VWnpqhSw
         qm0HCRRO+KyCfKcWTy8XDB6EYkdtxybP9YvwZPsM8FMaVPeiUWTgz+943fL6BYQVv3Ms
         uT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTHxX+etuHXBpEbbDmF9YWa8agfclHpk8KzfHw8NDu0S1ZAVPr9Z4g+uq0Eju2E4G9O47nga4431xkUzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAre9e0J8Kr02B30QTClmDYoEXngepArG6lhjhFnoCgeDJAN4
	rn4c/+6JOf4iAJ/IM+wBXJvu4EQgb0YMyWhTScAgYnANVIoN4+XvNR1zlXZeANU+xYU=
X-Gm-Gg: ASbGncsB/oh71R1J4XcFZ26iia48hHDUTlYLBXsW6gxQOmgG6l58CRdrbqsnx9kiToe
	zfCIKAYiN2m+hVpjuXVrcJGHLuKIgfWAzh5OjjAEL9ZiuitN6uqergXQHXSxchVVJaiHeGTDQrI
	+kNHo8/sLtcfSZF3VrCyY/e7njip2KlhUviQHlOZXo3d87dbs1jphmFWzYnWDJ6VlNnFV8t7DFt
	tOEtPYlbVdTydzqQ6g8jrLFNZbN/lqefPby//Jzf3cghxL4/nkFxBINKECfWSNe6Tl4VKhGSfkw
	qyJ5vm7YFPI1vyb5h+A5l9t7crn05mpmhxnwwYEdsUKhGkdLknMW0yooBL9e6ByS8TaLNo7lkLF
	ot74q7U9An05ukNxIa4h5NvqhC1SPqc3X0s0OvfqUwksS9UO+7yNCpBf2HDCPcs6cyjXiEZ8oT0
	6dQA==
X-Google-Smtp-Source: AGHT+IHDM1ajp5dnj4hE5WJdoDvDAOqBUpvkAj4SRucliE22RxwxuBe+9NIxcpC8TM95fIkuGUGV2w==
X-Received: by 2002:a05:600c:1c82:b0:45c:b5f7:c6e7 with SMTP id 5b1f17b1804b1-461fc6674c8mr11774495e9.0.1758097466105;
        Wed, 17 Sep 2025 01:24:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4613dccb4fesm26674005e9.16.2025.09.17.01.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:24:25 -0700 (PDT)
Message-ID: <b2098a76-6596-4361-8ac6-1e4a3c462e2a@linaro.org>
Date: Wed, 17 Sep 2025 10:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-tegra186: don't print
 superfluous errors
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
References: <20250813190657.3628-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250813190657.3628-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 21:06, Wolfram Sang wrote:
> The watchdog core will handle error messages already.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

