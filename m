Return-Path: <linux-kernel+bounces-773931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2CB2AC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C2D18A40EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD7623182D;
	Mon, 18 Aug 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky0zabez"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F633251795
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530247; cv=none; b=U5VhZ9wjXhQbGuEWFi6RXHPNYYaQYuF/YaVDF7ncOUjQK4jHxOivDxvvHsafcLDHaULn8lX0wo939i/n3t1BUGAGxl8Hab5KqKBDg5prM1Qcul6z0dA2599C5tCtNtoVKUKjBOB3wlrLdy8Db8J5EQjn8SuZ2qrCrDZJAJXaG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530247; c=relaxed/simple;
	bh=57TgCTUzq2WeMoiCZcm+8XUFjfrW9B/gu5wfo9wb4QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAGw0/nuoQ23kNOuokjKTeiY1kIOhFldfCsRvPpOMgZ2S5gJT5ANfaajxDkgdBOuz+nKhv/Zv2BljCg07y1I56M4TFXbaKXjCHdOuwnRTHxSgR/Esui/S/gaZiWaHY54KI4g1+64oCg/LrYzEX9udiRD32eQ6uC0Ug/jZYaIuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ky0zabez; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso20207485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755530243; x=1756135043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruLwnYHr/tBzoBul3RZxZxSWPFtDBWMLZzMZDWq7rDU=;
        b=Ky0zabezibiUhlGoPyxGYX9+ryKC4iqNLppKLCz5DHvL/f0KYpHTtfkyuO7W/K6m/4
         uXiuxInsbLhgmurSi04hUGyI8TEPiE4hcR+Nkee1UhB+LoGPEBoJFC+U3nQsvzxmGWTN
         IiY0xV4dJSDqlqkzRuVUZGSSSVbEvaoWrKkpgethdcshEBRlxPBA6IVh16KrxboOO3Qv
         uFOyuD/oGx6Ivi3oBaXzY/90B6vlUW9A53YwaCuCcgTuJNjteWopekUXBumUM7Xwu9Y7
         9XTBLTn0F61M1/PP77LzQ97VaydDPZgvPAh8vT+waqUtXE6qVsRcGiOEmWTDis4F/ySZ
         A7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530243; x=1756135043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruLwnYHr/tBzoBul3RZxZxSWPFtDBWMLZzMZDWq7rDU=;
        b=gKWfMAYXV2Iy7eBRlDYoOB1dxhYoazKaI8HdUY4j2OP9QWHvYc1uxPA59mw8MdCBTX
         F6Mmu/LHvMLLi2+QVQUJS0oHs/3GjKVl/VJParRboQXRL72oVhxvnvixLhfeKMY46+5O
         eePC17cIBc9He4RvaMt/MfQRndSro8azqi8svJRWhoq5cQ3ijrJ7VeYCqGCp47VzXgEP
         BFvUzDPj2RQRU0M5q7UbhBMZdg9wD4B4ddX1gANruaA8XH6AUaFYlZJMaz6Y6eX/QH2u
         M1LqCORJMoDNgKPbcZtHqAMsQkt+Bn5mQDwmdhBcuEOpkiKRg/i+1MLEkzcGrsfKWzOw
         pN8A==
X-Forwarded-Encrypted: i=1; AJvYcCWH+xGEVhP3jUN6vM1NGZiVE+CBpPLyG8JQRbnqI+TAkEK0Mco5HUaJHEFUdr8KEuETVa5cqLiDhj9ltn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWsS2VjhGKXsfOyM/+AGC2YStSsY003nujS/nuaUQbwlTZGpL
	RLQV55vJrqrxxKdTk/WxjE4fFvrD18nxD/kMRJjS7XlamItV9bniCV/OHQ1JAY8QnvQ=
X-Gm-Gg: ASbGncsQDG+jwHGKx/TDJUPmTqArRECiGyLCY7Y3ez/t2+7rWlfmQycwY28f4nDcjFk
	yj8RwLec/06MhxS1000GtdfGq5AdIOV6FgAL09MYWvefsB0sMTs//j4+Zl6hwjb77bkWU/N0RzE
	p2mQxYSuGQ7ss0xvUbAUEft/Aysi3XsR6nI7ry5ad+llp+OHmpx7XCc6BGERVedxsuDI0meqGeL
	XQTPduekKQ36eLCoWsklgoYAjUVsME1QkwY51PpMVYR+2LXdVirX+KPkvSeuYZv6tSIRaApSIRe
	nQsMuqoH4lGI5MEb8Q1St1lhAoh7IO/O26D3vGFGxwV/hTudbIe+QgHshMMHjvy6ClaJJpIxZvr
	viWMCTqbQ7Hp9AHFY0/ZnujaozEZ10kuWEzrb6VAkBwv326qqefltF3r3T7/2+4YMRAXTWrpoRE
	Zm7g==
X-Google-Smtp-Source: AGHT+IHZilA2/hfOmnugF7xNO2vU8LKQeJJYan3o2cZZIRQ3JL1zMo3LM0oL19y1UKFY669tejoA6g==
X-Received: by 2002:a05:600c:4ecd:b0:456:1846:6566 with SMTP id 5b1f17b1804b1-45a218573e1mr102634755e9.29.1755530243510;
        Mon, 18 Aug 2025 08:17:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c42:c1e9:a3ae:dfdb? ([2a05:6e02:1041:c10:7c42:c1e9:a3ae:dfdb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cfed5sm172006265e9.7.2025.08.18.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:17:22 -0700 (PDT)
Message-ID: <0e40af2f-bf57-48cd-9485-5321a05c909e@linaro.org>
Date: Mon, 18 Aug 2025 17:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/thermal/qcom/lmh: Fix incorrect error message
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, amitk@kernel.org,
 thara.gopinath@gmail.com, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250710175426.5789-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2025 19:54, Sumeet Pawnikar wrote:
> It was showing wrong error message as ARM threshold
> thremal trip for setting LOW threshold thermal trip.
> Fix this incorrect error message for setting LOW
> threshold thermal trip.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

