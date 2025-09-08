Return-Path: <linux-kernel+bounces-805814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D23B48DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA092037D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84ED2FF67D;
	Mon,  8 Sep 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/9am+Ju"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516742139C9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335111; cv=none; b=ArZAa62xF4C0vOkIAodb1avpQHgLqDrSmQ77D5M2DBpisJnryixPNFTnbeMpekswS6PNV2vMp0cV9W5oYGYFk8yYqiIkLf1hh0MFOl/yhzwRKaf3a5HXrEV3aneaQucONlGUP6JGXfH86p4DePhM1NKdlFUTijbDs7v8OlSKLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335111; c=relaxed/simple;
	bh=lQ9Uz44gZc2h+MNmL3Ih8V0lOqEWvWTLkpCYXRY1Tq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbx4g2REIQz6KXiP83ac0vM+j/L888id075gjXx1ObpQApJjrqGcg5gvLX+LZDUvZmPMARUkIjz0912Pq0t6t6nnXpsIrUvHZGS2LF5iLF2I7Uh1mtKU3eGf2++eLpnmhNuqNHB+yTeQGh5I08tVGV38f5vUELyym5CkOwM6iBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/9am+Ju; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso18984685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757335108; x=1757939908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjwlKwOwstSCi+pO1HODE7i0LqJoqNzfqpkGgmBotyQ=;
        b=L/9am+Ju8lWO/wNh7gZCO5kSJSvAp/IsGLsgpZ/avyT2fUq2WfrHBunjJrRD5AhJjC
         jYANep7+DpWI9l19z8VVA1QyBaREwATV5exEYtug6Kt9L8rG/p/HIYvvVt3kwRrRs/vt
         R2COwbEkgxdB6AfNfKbbflrtxx9OURjS1iImthycXGslCo7ccsc2102bmuOC3cUWugAd
         Gsp1eiuYZTRdzgppKLWXaI00RDJsi19YIfeS6F3OLfYIns+/4A4GIkuF1eS7tUE9c+fB
         G0SXNqzsTwX9HUjUkZlTc3u/A6oWlZS5Vs80Pf7vXKACZL6N6VI+4xVi2si2Itxxxwc6
         mbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335108; x=1757939908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjwlKwOwstSCi+pO1HODE7i0LqJoqNzfqpkGgmBotyQ=;
        b=F4xcaPGHhfu2d80oEBh2LIjKfd+41mXhbrj9Z/sJ26wxJzDy8nY9EvIq/nXFCNtn9p
         dwfnntxj7ZawA0bVuhm0fXjNPPR13PYFQdfpGDFnyFA+Cpyn98EXj06sNDnGUZczKYts
         fahaZk5QHqsJcDaTqKL/mT7voPUtnJ9pUTErNfGPkHKGvCsQo/hGWNrUePiEnnihLPfx
         A4lJ1ZCmOeZeLs+6hRyCxMjjYjWNCjq67egiDU0covCNR441zHrp3dYWB9qgCSBioEvC
         e3ajlwMpsCTzVIOMDpkUrNLdrpqsm6EfiN/fVNbAsqIiOUxkbe8DEsolhApvW1hylYl5
         6Y/w==
X-Gm-Message-State: AOJu0YwX5KUHjxZ/KNB9asv84iWSMP15ITQks5IinNtY0pXJgbXuKpkc
	fhW/4qTlfwkBSp+8rFYHCacpC7L2G/mhVCNgkK5c6kYD9uVGyCzlX8qYJNKVhQWYknM=
X-Gm-Gg: ASbGncuHrrSkJWvIO8VDDKnAAc7kFo0DE+nP2YQhOS/2fLhgi0N5fKaIlzZ39hTEjet
	1n1mt7N4l5UmMgAa0zolg1VnL76ggVqejN11ETIjmkmTsZlksklGbzsJvD5izs4wtS0qOO1Ymr/
	+89Y29iZMo1dw4iZ5j1mtYNHovvUqhyenITqcDF82V4hg8vhTfu9hp0rXF/NHJa+946XuE8R/Yu
	JqIxXzZ5fV/cgc3GjVtS3YgulNBwdfw7etg8hLlKLxaFS93oks8MdUHeBY8+/4vb5UWqigyAfH6
	7vuxgeWa5l2fjRjH+qTL7aUaf+B4l77DmliUewuCbpUPIqABkK7n+PLT/eamgkAHw/xG3ciED4i
	x0sdbBQPOs8j5YWUD08mxXs9n4/467ep1SZ2hTg==
X-Google-Smtp-Source: AGHT+IERD/qF4Ujm3XNjTo8FgzF3+3E0CKGHoK7rJvfoI/X4zpTDOP5F7J4Tj+R24Bc2VUv8TpcRyQ==
X-Received: by 2002:a05:6000:26c6:b0:3e7:4701:d1a3 with SMTP id ffacd0b85a97d-3e74701d5bamr3811579f8f.38.1757335107619;
        Mon, 08 Sep 2025 05:38:27 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm11009857f8f.0.2025.09.08.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:38:27 -0700 (PDT)
Message-ID: <fa9d3b0e-71d9-4fa9-8522-185ebdddcf00@linaro.org>
Date: Mon, 8 Sep 2025 13:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] coresight: Fix incorrect handling for return value
 of devm_kzalloc
To: Lin Yujun <linyujun809@h-partners.com>, suzuki.poulose@arm.com
Cc: linux-kernel@vger.kernel.org,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 anshuman.khandual@arm.com, Leo Yan <leo.yan@arm.com>
References: <20250908122022.1315399-1-linyujun809@h-partners.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250908122022.1315399-1-linyujun809@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 1:20 pm, Lin Yujun wrote:
> The return value of devm_kzalloc could be an null pointer,
> use "!desc.pdata" to fix incorrect handling return value
> of devm_kzalloc.
> 
> Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> Signed-off-by: Lin Yujun <linyujun809@h-partners.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8267dd1a2130..caf873adfc3a 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1277,11 +1277,11 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   	 * ends up failing. Instead let's allocate a dummy zeroed
>   	 * coresight_platform_data structure and assign that back
>   	 * into the device for that purpose.
>   	 */
>   	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> -	if (IS_ERR(desc.pdata))
> +	if (!desc.pdata)
>   		goto cpu_clear;
>   
>   	desc.type = CORESIGHT_DEV_TYPE_SINK;
>   	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
>   	desc.ops = &arm_trbe_cs_ops;

Reviewed-by: James Clark <james.clark@linaro.org>


