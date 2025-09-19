Return-Path: <linux-kernel+bounces-824961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2DB8A923
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFFC3AAB18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E991D5170;
	Fri, 19 Sep 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq/n2zKT"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4B5C96
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299525; cv=none; b=VEhZuc33q8UL72y8GRr6VpBqcsu2sZ2XzMZlTe0pNaMxA1p2pc9ZnQqYT+C/aOezATEyc737BqnxlUVU0VJSWFn8JL8xVs0M8UbObtUMlwiBolbN9p1VnjEh5BcrMPIlMZQFOaAKcL4PL7Il5rEQzCRQn3NjsmVzxKLU8an+lZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299525; c=relaxed/simple;
	bh=ULcb+FE9bT1bV8ajTFOQ1Xgw3/tTX2YNU2J6QFlnqKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFEnXQeavy4jTpHm4YcanGavgAgAwjfF1r4cSDii6MzjcioGdzQj23ntoINrrbsN0QGbEAHgelDNh1EbKZNcVMhfn95URYPI1H7s8pTReO99LnoID17593+Sg3stNDtLjol6WDGBsfwdySOqPf2ooCBY5cvaw9oePaxX3N+nUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vq/n2zKT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso555317f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758299522; x=1758904322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3uHcZporxbBE1WPZdYvszS55+oRtlQmqDOxaEQ2fa8=;
        b=Vq/n2zKTQFX+wluJP/w3zmFLOaexzmXG1I0dyhCh07YWeTn3ZZTbpYlZHw7dzNrcuz
         PCzlHtda1cMAzsV32OcWA1tw0RHLqq6jYgEL+1QwjPgeNs5aDtV9RXWYdhuMZD1d6Xxv
         mEP1OQA1hTm2Wan/qWR1T1mRM0SEgWR0+s40Mzpvu3awIXlMJaNm9V/y323S7ma3BJgN
         p7JeDJeI6NIJ80MO3dB9+0y5LGlXWzUTRdQ8ibcsq4yq7zDBehhh5f2jheILa9ae93g1
         ND7QhPs6tqvhjs3+/xlbCH/azsOtsVF+GtSheexSIePiin9+nWN8CRctk5RVHK/W4H9N
         epmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299522; x=1758904322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3uHcZporxbBE1WPZdYvszS55+oRtlQmqDOxaEQ2fa8=;
        b=eTMSg2PdQT37+GCMcKtmsE5OPo8ESoYH/yv4ch9+mC5xuWJWP0q9t9rLK2LJ66UnZf
         NXHFP3H9gWcyBVnkupCDqTrbznhVY2C9ziGwx79wyZF3YkGPS0BmEPmejodNoTUu9PVg
         h2MVs5QiC5Cxja73cisWrmmra1t46VBv2PAawtsMvhSq4Ww9Hw7t+9WILcJoW/0d12Ja
         xFvXlH5F3Vkl5+nWAzCt06xbWH9O5JJZvNqpa6h3N8wReBe9H9VZWcpE17HpiV5kijev
         JtbR+iGJgvLfxMWnkx/VCDT1Y7xoA/J71pkIjSh6UT7e83JZnWyKlVyLi9Jx/7ypl3Z5
         0ArQ==
X-Gm-Message-State: AOJu0YwY6wmmBTG0LwU6rVTcM7e0CUCcqb+/1Xv5m30ozBFzNPOadLWA
	gzA6BNqJlFUHG4gZqVvjqTVts0QS6pVcL/IVBcB0NYYRNhK/fp5OTNOo/JShSi6/5x8=
X-Gm-Gg: ASbGncs/xtpvmL4EJI5XkL9DnDwOFJ0CGEbEOJLWu5zvV2mNYDGVGU1AWhxBmDRFQKy
	LVPHGdHxiojT2xcbhruDIpv6dvxlMwe2xV1T7tdxZHRqc2U2gUIkcUVNsKbtIo1zDE0zx3fy5eh
	rGGN3bV/9tYQBCQ9IrnKNYc1LZ72hwDchHIJThtAWcLs4nd3vumHsPZjX326LbzVC+sNXFuxAu7
	sjJaMNb6zRizmCt4tt+WY1/6bBAPv4VkTtueI5LMBAt5q5ol90mJE9IIk2vmPemMQ0IRM+o9HDD
	nIuU/xQar5u9h/bY339NveUDMJ3dWo8ItfIffyYdpAoONkZzOsGdYtMMK/yzwOYZ1LbKb98+/Ia
	AjxeX6DWBUdWzu6EJ7tiIBO08DMW2ZFTXdbbMnaA+j2FVrO4ImPff+5I1vpO/V9KtH2fnmkzdsi
	cqqw==
X-Google-Smtp-Source: AGHT+IFhk+LOiZNH/rRpRXbN6bz0btV5zhKbIxziWw9SsXhSe8tWkBYWko3E7XSIWr2izSKCXzAcxQ==
X-Received: by 2002:a05:6000:1ac9:b0:3e7:1f63:6e7d with SMTP id ffacd0b85a97d-3ee87ac9b1emr4152734f8f.45.1758299522399;
        Fri, 19 Sep 2025 09:32:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm8619569f8f.60.2025.09.19.09.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 09:32:01 -0700 (PDT)
Message-ID: <5eb98f0c-ba81-4e7d-9484-d88ba9ec5f86@linaro.org>
Date: Fri, 19 Sep 2025 18:32:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: exynos4210-mct: Add compatible for
 ARTPEC-9 SoC
To: Ravi Patel <ravi.patel@samsung.com>, tglx@linutronix.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ksk4725@coasia.com, pjsin865@coasia.com, gwk1013@coasia.com,
 bread@coasia.com, jspark@coasia.com, limjh0823@coasia.com,
 lightwise@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com,
 smn1196@coasia.com, shradha.t@samsung.com, swathi.ks@samsung.com,
 kenkim@coasia.com
References: <CGME20250917071322epcas5p3b25ff15ee16f58aa3101f2fc44b554cc@epcas5p3.samsung.com>
 <20250917071311.1404-1-ravi.patel@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250917071311.1404-1-ravi.patel@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2025 09:13, Ravi Patel wrote:
> From: SungMin Park <smn1196@coasia.com>
> 
> Add Axis ARTPEC-9 mct compatible to the bindings documentation.
> The design for the timer is reused from previous Samsung SoCs
> like exynos4210 and ARTPEC-8.
> 
> Signed-off-by: SungMin Park <smn1196@coasia.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

