Return-Path: <linux-kernel+bounces-800714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D244B43AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E56B7A7308
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404ED2EA480;
	Thu,  4 Sep 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1DrHh09"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EF2D0C85
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987207; cv=none; b=hx8jJcVtGMTYAa6YqeSqwKhT4Uc5Y3AJP0xq/9/duvZlQpCHLCnqz1F4YykWApVJZBlXkX03MxLrpUkDCNQ3HMi/IVoPiMor6JRa7esbJaUX9xYZ2vugZ9YgxoAEJp7w2IcCQr4r/wZCsA8SWlxz583EH0evRQ1AcaGfnaWqGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987207; c=relaxed/simple;
	bh=JAKt+DJHLvgwPHMPIJfLNVW9BnFW7wAb0S/uo+VBz5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpZ2OcoRgL0o56/Hixr5zoGIGzRdqOvunX6ZDZwz+n+YZpeQ7V5MEPxk74CV9htbDnkRHayAoa2zvoMKNt1BhD5uE/kDZgQmuCvt/mzlyhaN0mZi5vWsym0yWX5mKCHR6GYO67YUPol1rLBabkxFPXuGJycfqB4Rq5tFifRGL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1DrHh09; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so6540455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756987204; x=1757592004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFkBz8t+kCT8UUeu24okw56fSQSLiELatilmrdAB8x0=;
        b=l1DrHh09ye8Qza7pZH2Y1Ty3psD2ZdoLbyZK3EDCyzpbs44gmwAFTBrSkQBcTDmjI2
         PwGM419Y5jdTjn4v4b1pZR27/LgRGNNd64o1lGYNmq2BlHS/ov3IPGQ80GAMV4ka/D17
         2+Q00cwDWh+Jeq3EP/FwjZ0a69RMp9L9DwE663Wo8MozBYRL2LNgVZO1YKEWYKCjAdY+
         4AZJOglUObMOlk4o0cCUihsHj6HDF9R3oXm4eqsR7rb+nkW2N6nLZ7Vt6DC0FC1kFbPC
         EwKZft/9qiiYgP93xMCHhKoullvtK2w3PG57/rI35LuvmBhhX6QiCeG0tQsTF0DxBVTg
         03EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987204; x=1757592004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFkBz8t+kCT8UUeu24okw56fSQSLiELatilmrdAB8x0=;
        b=au1PP8EjBoAEN67rVYv8wlTN1aNcX4cd7aKG9E55WpLSOVYzzPaTVtV0JCvU1bjntF
         XPnPippCmZwo7Tg3e/EuXTH+L5Vr2ku2VHxRlItt1chazKaAbq7NnX5h7d0z7emYjWdr
         5GDXye2b9lopoEX0Y7yNAFe4TBtR9yE9JiljbQydheSTuH8D+amtAJxWFv+mk4ybkC7t
         9UXudCb8fYuKfGAu0q63ev/rz3fT5qmrELPMwY8ttzuYzhmmidzJM0PErzbYf19x0AJK
         +kNQmfvJgqYk8bpstVbmsIUxCUXPJbimlQRXmVSgS+xpkknltrvz6Rhz0+xoDd9CnIku
         2vyA==
X-Forwarded-Encrypted: i=1; AJvYcCW1dr4FcDNi0DoopIA8nA5w9pJJ2kykikXaOrReFnZ7LLNBOvDAGO0eq+PetyAtOIIiiNjKTM2uvOcDWFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCftvcCeX1Car1YNP6reO4dbMA9b0BOJJmcIG6b+Vtxugt7hA
	lA10iefnPaE+6DFpBqJKzS1NhBBiChHkcyMk6zpO7GdAnjEyFCCu1q0rpOndFQ+h9ao=
X-Gm-Gg: ASbGncuFgKhbVi613LZkdEZFaF2oA2TCLXHxLLMfQp8SFrT2IBxBj9TGqjiTnZzGLjp
	sdOd1YrocxsFKcWEiXU7YtYfSG+JZj9TazZQEtNM+vND+v8AqjcCNUw1XLHTI4+brVL2f22dXmW
	SA67ZqALkAz8OpBFrL6u38zy+v468vHHQeMAmrip/1vFnrtJ8oeo7Muv1qgC7+IkAehdPREmMh/
	nhWWLCTJjDDaqTm/Zqnifvnk5YEzEOOyxOxatiZ+KFgt7g2Y3s5WQ9OezZO0GUZy4uSASS8Q836
	trNv01Eg9jV7txHxwyhMkIh48zdoXlZWSEvumg4s1VyuhAlbrBHa/r0JG0j7meUOB/idDq1OgFw
	Q8cBN6hHYpgmrjWS3vu2/MpuFRmbtJP6UV7tqqg==
X-Google-Smtp-Source: AGHT+IEeJr8/W7i384dfItP0nBlu/2Q4pZvcih8lGi8Ow9/IMWLIJQ8ZyVlqeIZXNl/vx/mclRKwsQ==
X-Received: by 2002:a05:600c:1f0e:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45b855335a8mr163914835e9.11.1756987203568;
        Thu, 04 Sep 2025 05:00:03 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm151251345e9.19.2025.09.04.05.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:00:03 -0700 (PDT)
Message-ID: <5f24d286-629c-404f-8e0f-aa01e27bcb80@linaro.org>
Date: Thu, 4 Sep 2025 13:00:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: perf: Fix pointer check with IS_ERR_OR_NULL()
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 11:53 am, Leo Yan wrote:
> The returned pointer from .alloc_buffer() callback can be an error, if
> only checking NULL pointer the driver cannot capture errors. The driver
> will proceed even after failure and cause kernel panic.
> 
> Change to use IS_ERR_OR_NULL() check for capture error cases.
> 
> Fixes: 0bcbf2e30ff2 ("coresight: etm-perf: new PMU driver for ETM tracers")
> Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f677c08233ba1a28b277674662c6e6db904873dd..440d967f5d0962df187a81b0dd69a7d82a8b62ba 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -198,7 +198,7 @@ static void free_sink_buffer(struct etm_event_data *event_data)
>   	cpumask_t *mask = &event_data->mask;
>   	struct coresight_device *sink;
>   
> -	if (!event_data->snk_config)
> +	if (IS_ERR_OR_NULL(event_data->snk_config))
>   		return;
>   
>   	if (WARN_ON(cpumask_empty(mask)))
> @@ -450,7 +450,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	event_data->snk_config =
>   			sink_ops(sink)->alloc_buffer(sink, event, pages,
>   						     nr_pages, overwrite);
> -	if (!event_data->snk_config)
> +	if (IS_ERR_OR_NULL(event_data->snk_config))
>   		goto err;

I think the bug is in TRBE. It's the only one that returns an error 
pointer, but only for -ENOMEM which would normally be NULL for alloc 
type functions anyway.

Also it's assigned to event_data->snk_config which is later NULL checked 
rather than IS_ERR_OR_NULL in free_sink_buffer(). Maybe that path 
doesn't happen, but all instances should be updated anyway.

It's much easier to keep it as NULL and make the fix in TRBE. It also 
wouldn't need to be backported as far.

>   
>   out:
> 
> ---
> base-commit: fa71e9cb4cfa59abb196229667ec84929bdc18fe
> change-id: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf
> 
> Best regards,


