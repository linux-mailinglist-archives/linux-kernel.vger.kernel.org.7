Return-Path: <linux-kernel+bounces-857596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B05BE734C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B464019C5F12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE529BDA6;
	Fri, 17 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMsbfSx2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04915286411
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690279; cv=none; b=shsN3Em1v/xnSHgWBzUymQGWaTemihsjOXSX5yoQ776cNxvPnIK7vVfXZqokeEguJmfC0oFAYm7o2QIKreuLMc1PuE28ZeqkVO/5TP5hC8tQbz7NrnXaNgWzQH9PgYd97cqRqZYs2kjvQZcfbfqgc8G//U0xHiZqHb7d7C36rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690279; c=relaxed/simple;
	bh=lU+1cO3Zwc0zGD7w3qerML6V2Pgt4on4weQv6NRLb7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goM/I1A1+cEGBdYyHna9FW7sBl/FnVClx3ChmOaXRKyYxo9Ay0a7vR0leT2k6kPS/4zGnfT8VmlOzr1c856pfc2fgXlDZWoVj0gJB7VB0pAjpxYy9v3idIw/H5dBA/6L1L0HZz5VPf2x5N1ZLYPIUL2DyVoGKRkVcEy7lpA6wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMsbfSx2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso7207125e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760690276; x=1761295076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om9V2LjmdpVk1UDFsC2kQmy7iCE3RSKHplIPxsp5GZE=;
        b=aMsbfSx2yq9Lz6ljpzhUmmQ0rH/icVRAlrvz4o4wiI5HwIvGZvEPRtN5NotRhjiT1m
         Ij5kNUegHtQ27tSIsJDDzgDuoxW22IR+7m/zONlVu8Ar5xEmdtC1uDEaY3UMcvzFxVkE
         /CsW3kNHCk3m74wo9GviaF/kg6KdYKQ/0wEI+E90TnXxcm4O2eM4ugRxpfwVMjiPwE9e
         7r/t9afbq7d5AooWuaxa3JtRWjJ/Hwbp4PovINmxSFvrDMg+Jj4zjcYHFqynk5ujsK5X
         Ch2x3zDtjirhyRz67ilpt40evUTst24eavc+Xg0zTSbNZKKund94P/OxbKahQLRsdZFJ
         3k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760690276; x=1761295076;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=om9V2LjmdpVk1UDFsC2kQmy7iCE3RSKHplIPxsp5GZE=;
        b=LH3JL8jHB+GG5p0MZRen8dThGnGp8/hHcv+ZNw8QcxThKMOVFS/s14ZwUCPOYZXIje
         Eq6IhIJeGXnhX6f6ktNl11a37/Qu5Z9lkl2Pec6PLe4J3EAwKrTSGLyHgcTEdW/mcu8i
         HyyArjOiBjAtoTJqLLScBLjovTUg+TmCo/6Op04e44Uo3CjcUoEvjCVc+iJ+INGXLRXU
         qB3KWAfHd56Em7g+HWKkLnCfCT3//YhP3OIwLpCjHayvF7e7qOWfvQhKqLJEUQvqpj5P
         9/8Oc82/sd6XqlI0OQ3StURE6NhvbSaGly+Kfpi/fdEeUrAENIuXxfGDc3TV1BpLKBou
         eClA==
X-Forwarded-Encrypted: i=1; AJvYcCVOlIMWV3Tj/wBLv9hpxTLxsBOSgLco4ZbDbdcaR/6lojL5t/9t0uptA81+6SznICtGwEsZ+WnWyx2KkaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9bvQ07cWVVxPUkYmEtSG+8CbrtRPY/6T5jRUw0hMlpDE+yfq
	FZAxeKeBWIRa85sryGtT2lZh1Zz0NEtAvEsgktRbgGfAUNgKuXMHa9rgQt9cVmMD8gs=
X-Gm-Gg: ASbGnct338QS4tdNnBfmyDwKBwgcWU2yYIrG2nDBmDsfj1k+nHxLfUIscy47nCU8gpa
	OGTRX0UkY5LMqjZoUPs63wUjueGDIZ3qgGffuCAcxM0Js0knXw73BnRQrbzBG3lcHJJme/QPq11
	/A0DZ1iPBCCRJDxEIU5HoKblS6GrlrgVr+oIol1m8TS+PQgu/nXJjK/3H7dGs8h2C+lsks0Ykr/
	UVHBHFFqpEZmRy9UKLbyaPLfFAii7YkXYUL0Z9t7XgZwzkD49b9v2qxZ+8gm6sjJ1oN05Fhqfuy
	kk0HkjVDMpkrRcBXkQeOn9ZD1IrSCkv2UKWo8mRB2jwbXV6cnFLh/8GXqAXf5NlFAPfXTHr2GSM
	Gx1f0urlQbEbBzIOjygnrkxRpLEMWjBSFasaFs0YpuWwGRFLdwrF96iRL9jN8f7GS5+2X85Z9Gx
	+XfdqVEMDOy5cO6DJ7lZks6U1VyP1kjkZZrvEQFbg4TwEGRQKJihRd
X-Google-Smtp-Source: AGHT+IEoeP6jDjWGte8b53CU1YTjsBnCCSNfMgJsOHoHblW0l/uJG1CiY59Ep03ULPmXcMaAMIM+Cw==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr28504945e9.32.1760690276296;
        Fri, 17 Oct 2025 01:37:56 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710fa76fd0sm38682415e9.11.2025.10.17.01.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:37:55 -0700 (PDT)
Message-ID: <41f3b22c-2882-42e7-bbf1-91e8cf93ba21@linaro.org>
Date: Fri, 17 Oct 2025 09:37:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: drop unused module alias
To: Johan Hovold <johan@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017060435.8524-1-johan@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017060435.8524-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 07:04, Johan Hovold wrote:
> The driver has never supported anything but OF probing so drop the
> unused platform module alias.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index d9d770e5e7c6..c93aeeb5ab20 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4545,7 +4545,6 @@ static struct platform_driver qcom_camss_driver = {
>   
>   module_platform_driver(qcom_camss_driver);
>   
> -MODULE_ALIAS("platform:qcom-camss");
>   MODULE_DESCRIPTION("Qualcomm Camera Subsystem driver");
>   MODULE_AUTHOR("Todor Tomov <todor.tomov@linaro.org>");
>   MODULE_LICENSE("GPL v2");

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

