Return-Path: <linux-kernel+bounces-763593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E9B21739
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5496C190722C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16542E2F1C;
	Mon, 11 Aug 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESLVDkVp"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992342E172F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947255; cv=none; b=V8DXO0Q8ZNRk2pL5Qlp6QSXLQvRYHR+y0AXNQHQhzICjP+TueZpbFAhHhdRY6/Yra7cywfhdAT1Vb/AlCk3clxdaEbBCsR0nj9ffDjgJTSjzSVEKvszTyPgEB3CJR4BQIjExY2R3I1sJJbLc/fbYrwRWLq9i5K9LONdxFb2/d40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947255; c=relaxed/simple;
	bh=cfqDoAzab3n961gl8WpgvV7hI7vMYyFM37VMNyvVuAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1NK/wDxOtfhcJabDWqSmwKulUnBLF91uH/BGnwMd+0TRIdBkPRv6IWgWSKw58RsMh5Lth2Q5FBrto1ve4fJRNYNRrqj8vwX7UYEoNgDpkO234YAzWR570zzXiOO2jBzvyA1YX9JRianIF5jpHmXuHnt5huD9lH8Op/NfdZhJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ESLVDkVp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2794877f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754947252; x=1755552052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a22h0n4F0ersJH5KHpU8SjX1DIiGxVRU1qnMUbwzwPY=;
        b=ESLVDkVp/EiC3woUeRifpYEPFEDDDTiozRvZbDRZmMJ3Cft/rVYYhPHim3yCq6YLnm
         SC2DCmrtHYuZ5Ep+EhqZ0wrPtvyEP1384VgvXpELrU9emuskjXaf+XsZq+FffeOoiKPo
         ArL1qVpZ24pa4gOpmN+0F0BYK4E/zu0HvtKod2JJAOAwQDuFYLQ4dRMUKhXn+dBmMwB3
         5ZwntBSU98W3al9oqR+ehUl95SpGHYjPcL5vzXiRB7Ku72pS9XZFZXfNvDvgnlkEu8mR
         WPV7xymOSdyeKj3JywkKiKa0SUnBt5XUVFi8iKKBbMefGzdecnir/HTy5ukzSr0GLVg+
         7RCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947252; x=1755552052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a22h0n4F0ersJH5KHpU8SjX1DIiGxVRU1qnMUbwzwPY=;
        b=HSPPo7pemuI3Cyxl8UU1z3lrS6l4PtsMQXeGprMA/gYWmCKh8igG3TwQ+aBQBfCwJR
         G1odBT3oAOPOUOACauPjxnCijJf1P1KTl/m8CyqYcPMSkUDIKSjtNrC+r5zBiXF4Vp89
         V+XH8pFgMp8FEVREoCZmC2p4RLC5iqe9PrGb4e/tL1n+ztYsLgGF/j9PZOn/fHIRys4m
         wB8fOst+wjnC3EWoAYqGILjIcVPC4tC7s+guX934SGcpikpIx5tMFnZh+UxZ4IJvXNOA
         Zi9oUdjRTbxibv6vdZ8J4Xms26r8bSiLTDxDgtEF1VfhMygLZ76XXWXeqsmr3O1laa5N
         XPEw==
X-Forwarded-Encrypted: i=1; AJvYcCVF88zBSNa4rjuD7q/6mQ3qgNU5k61qyhrbk8iiXOIrMVMDhW2aaJPHpylWy07RSHdvbBAlGIo7PNNcoEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxWSFYHF2MWGQFOUOeAjWlaHWU/i5AiSiTfsEc7mAfuiRSqiO
	O41RvRT14F49q6mclN/Lz+8HGfS/OGH80d7Zi/QP5YxjIzP36OdPWV9VNGcCtnMqak8=
X-Gm-Gg: ASbGnctSL7rJ2hBzE358i9UVDlYdtzSEE7+9814W/nBuBq9HhAuW75+ARg19ofS4nSQ
	ZBA+MLFVQICpps2gaolwivMq0OMvenj1J4x19H2Pzl7KNvCp5LeOzUMqk+kbbj4EouB83PKQb0t
	irmLxDt84odCKBAotqvzMcONV17HUPQesr0WnSZTj/hvqzqDqFNN3IkszloATCS+m9B5uND/K1I
	x4yFtnWZM71Ot8TDRhEewvAJfBainTPkEVqX9+Ms16Oig/0JhWuAxtLSDh2ocGU6IO71An0wU6U
	M7iLLZCjeJAz7ZGga9CA7FnTZlqFouTgtRpPp67uFcasbOvKixcCIQJ+SkKg2IGmL0AaFl+F1mQ
	LDZMVvnOYRR1hS5GDzSldRILgd7WHfCxkZI2SYiWbl63fsKGb0KxMoL2wY4hBMw==
X-Google-Smtp-Source: AGHT+IFgvm4HXttFbfS6Io8u3RnoRmgzJRkHCgD+GWgq4k+QoqkEFTnni/7fyUNCj4FwnE1k5pCXmA==
X-Received: by 2002:a5d:5848:0:b0:3a5:1c0d:85e8 with SMTP id ffacd0b85a97d-3b900b4de4amr12408716f8f.22.1754947251775;
        Mon, 11 Aug 2025 14:20:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459ebede65asm220858905e9.8.2025.08.11.14.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 14:20:51 -0700 (PDT)
Message-ID: <a2fec7ae-7f5e-4440-8623-41e89433b7a7@linaro.org>
Date: Mon, 11 Aug 2025 23:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
 <20250810185221.2767567-3-daniel.lezcano@linaro.org>
 <p5pwwdlrldqdkpqtfvgo3dz2liz46ywy7crjfe4nybxmrhlh55@b6v7lccczczs>
 <47ed1b83-9ace-475b-8279-6c7f394c35f3@linaro.org>
 <ejua4dgtdtlpr22xio6sywhaiyfjrjwdf744s73fz4zxhxyhrk@ep7o37hzwzvv>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ejua4dgtdtlpr22xio6sywhaiyfjrjwdf744s73fz4zxhxyhrk@ep7o37hzwzvv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/08/2025 23:11, Uwe Kleine-König wrote:
> Hello Daniel,
> 
> On Mon, Aug 11, 2025 at 11:44:32AM +0200, Daniel Lezcano wrote:
>> On 11/08/2025 07:18, Uwe Kleine-König wrote:
>>> All variants (up to now) have .has_fltctrl == .has_fltpol. Is there a
>>> good reason that justifies two bools for the register description?
>>
>> Yeah, I agree it can be folded into a single has_flt_reg boolean. I can only
>> guess that was done with the idea of sticking to the reference manual and
>> perhaps having more variant to come with, eg.,  fltctrl=false and
>> fltpol=true
>>
>> Do you want me to merge these boolean ?
> 
> That's the obvious thing to do if you want the new variant supported :-)
> 
> Unless you know that there is such a variant with .has_fltctrl !=
> .has_fltpol to appear soon, I prefer the simplified handling with only
> one bool.
> 
>>> Also I wonder about the fuss given that the two registers are not used
>>> in the PWM driver. So this is only to prevent reading these registers
>>> via regmap debug stuff? What happens if the memory locations are read
>>> where the other implementations have these registers?
>>
>> The problem arises at resume time.
>>
>> 	/* restore all registers from cache */
>>          clk_prepare(fpc->ipg_clk);
>> 	regcache_cache_only(fpc->regmap, false);
>>          regcache_sync(fpc->regmap);
>>
>> Without skipping these registers, the kernel crashes on s32g2/3
> 
> That's a useful information for the commit log.

Ok, thanks, I'll do the changes accordingly


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

