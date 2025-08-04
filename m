Return-Path: <linux-kernel+bounces-754922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B1B19E98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9401797D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F624502C;
	Mon,  4 Aug 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVmowYvg"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35532522F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298781; cv=none; b=KGOeE7RNa3AHhuCqhsY3OEZlvzKHccIYHTU5D+FwzpXbvs92X7Uw+k4b48uqpI/NdxYX7dqud2hthn8OtUtAWlscFoTN1P5IHnzx0RDbI4hAXRMhRccPneieg2PS87HxJiN2MsGEX2mZwsdz2NOpRTASEntp2fwVD1onr4nzd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298781; c=relaxed/simple;
	bh=YCPSfVmwz6OwQdVLJJqmOjEhJsAYC5HtquzjTzb61hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKh4gL74R/kh4bIgc+H+uEln8Q8V2pHxxx1eIGrBlHldawtkPBfZS7DPMpIAU60f+J6hC8GnIX+X1yeLzsJo/dOXRshjPjgyoKMvF5IK5kWfrIskNU8S7VwUZnK0CaGIGLZy1BVOhXAPTNlsDL3Me11xsqdkkBd7/pK0erPufpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVmowYvg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso43075735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754298777; x=1754903577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgAy2zyC98iaJiwc+SpP4UrYhxP1LHYLkFxMcv/03Yo=;
        b=fVmowYvgtXY+HpPXHzfbtL0QLf5IGBhia0yK7v4OzMhsfTDD6DHivKUwsDr7U7WEf/
         vkyfjfWwIx+asXm5Il9xdog9XV8N3c6Vmq/+tnt7nj4zOuOp4DuMMs4Pvs2AKKRysV4L
         phBXpncJ8hNqAM98fYLGdaboSP2R8G3nCYfFHtQwD2TG198IrwqO2iOV5G+6RfRWBVEW
         YoJqX1kZdTN0zEvyB5T2Tm47sHltNenwqP/Q0XlFFgRA3hUXCazdZlqCTXHiE3OQfyyy
         DlU48J9TfqOFfdYa7hphQSI9OrKufFxrjbmmbxxBrssGQ3ctwJR0RWVHHOa7YIj3BDpZ
         lQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298777; x=1754903577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgAy2zyC98iaJiwc+SpP4UrYhxP1LHYLkFxMcv/03Yo=;
        b=l/06VEPrtaf5s3At05uNv6gb5qxs7e9eX+3HK+XFxF/buywn44PpJUduaXE65WcV9c
         sSTwlEXcxil9bwPQ0JwNlsQMRd/hODS+hWROmQ8B6VTWXV44YyI8ztdkna82SwcHeMRh
         yunzY6MRkzX1s35JcTN2dEd1X/VYHuyoi2A0FOjmRcBCswq7aPE63NJ5eQQlr9IKSNf+
         20TshTIzCPRYQibi9DB3+YRl7UNk1e7SVk6pQalIyOwTD47EGRvw365VVlYo+oZ8UDar
         oT1VCdy42FYg2gGI4SY8so8k8cJosplwtp4Avxm5ljZ78/SIPsATV7iQUKk1fjIrWfe9
         wiIA==
X-Forwarded-Encrypted: i=1; AJvYcCVcpZlonhCc23z/FAOWat5qkAl0Rqui8xmdysSuAk3GRCgS36kqWfMbbj02K3hlNFsa8o5OSPunO8Q2RxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAigznUhAGVgOiN5kI0qPvPVWD7CD4NXXKrzMxVFyQL7Y4Ewx/
	XN92hAER/Cj5nMtMw6BEAxL2ei6lvy/1CtpkETaz8p6PADIlNrRg2f5ziCTdw2cIn5U=
X-Gm-Gg: ASbGncshFZNwrZtHUVcvgm4KKajhPHeqSdQj/YfxgZ0zC0qNRI9ApRltrGZWhUKAWkV
	/9VB4coTjENb9BnYdnCixP4woCSredhZ81q9NPX2aAxJ2t0IQTkTKezoegqKlxcSPxkWyF0T7l3
	S54yK8fVNiihtMYJheBgtd2SSH/lhg43t0zPt2/DO0NynP1hcktJ9bQPY2IX9LG5HOA02KI8DgN
	CxdCeIY/HWqC/lOH9wWbiqaIoaIueaOnqPT27X7FkvLXFY8jfY3vvgPc5Y/FBSE9ZrwLEDOdga1
	zAldowQH97X/PsmDYtYP8BC28uK0F8Hk2aiiR6QhtULTbF+VV6l7WJvMyyDJoBZZihSroKaYeTf
	N7E9ZjsnjNUpoF4+PoQpXldt/a19+gm0gketHiic7jGtbsKOpRkzk4HJEjb9jnw==
X-Google-Smtp-Source: AGHT+IHhdd9XITv6+V8awYBZpVjHL1YUYi4nLfHovm3Rpvfd8FiBcVfIpSCqdf6YDMz7VItybe47uA==
X-Received: by 2002:a05:600c:5490:b0:459:dc81:b189 with SMTP id 5b1f17b1804b1-459dc81b3c6mr17184665e9.31.1754298777271;
        Mon, 04 Aug 2025 02:12:57 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b8e0846777sm4903153f8f.48.2025.08.04.02.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:12:56 -0700 (PDT)
Message-ID: <437fdf05-296e-43b8-9894-1da429dfab1a@linaro.org>
Date: Mon, 4 Aug 2025 11:12:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] clocksource/drivers/vf-pit: Allocate the struct
 timer at init time
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-8-daniel.lezcano@linaro.org>
 <8d76fd30-57de-40b0-a847-4b84c8d529c5@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8d76fd30-57de-40b0-a847-4b84c8d529c5@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 09:33, Ghennadi Procopciuc wrote:
> On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
> 
> [...]
> 

[ ... ]

>> +	ret = -EINVAL;
>>   	irq = irq_of_parse_and_map(np, 0);
>> -	if (irq <= 0)
>> -		return -EINVAL;
>> +	if (irq <= 0) {
>> +		pr_err("Failed to irq_of_parse_and_map\n");
>> +		goto out_iounmap;
>> +	}
>>   
>>   	pit_clk = of_clk_get(np, 0);
>> -	if (IS_ERR(pit_clk))
>> -		return PTR_ERR(pit_clk);
>> +	if (IS_ERR(pit_clk)) {
>> +		ret = PTR_ERR(pit_clk);
>> +		goto out_iounmap;
> 
> This does not revert the use of irq_of_parse_and_map. In my opinion, it
> should be explicitly reverted as part of the cleanup phase by calling
> irq_of_parse_and_map.

AFAICT, it does not make sense to undo irq_of_parse_and_map() and there 
is no revert function for that.

However, calling free_irq as commented in patch 20/20 makes sense.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

