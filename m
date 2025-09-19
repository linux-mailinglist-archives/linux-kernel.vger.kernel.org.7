Return-Path: <linux-kernel+bounces-824881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30257B8A5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877FF5A625F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79731B82B;
	Fri, 19 Sep 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPHAfUDd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D531A7FC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296412; cv=none; b=b6dtrp+wSQsOCKrszocKLr6XRUxa1cdpbMJwXhuxQj7satWfPXncI9jQJJ3Hik62XwqNddV+vJFnFXHV+kET8bipPjWGzeH4zc8rYvEzY6AT+GkJyIPEokBeGo80unu8SNGn+aswVSuibHE0KaOG/l+HE+C+oG4zhOv9037FDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296412; c=relaxed/simple;
	bh=xlyfj68UTIz6kURnqgzznzyubwaDnjAFQK2Dyp3Ar98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faq1ugZ6uyPyJKMrtXf/suhC8ZBvBRrZgBib9RAvTZNooQtwJ9sDIDwzaxUPaHYYVikXi2mfTRFPEEoOu6m5/eXAwiAa5alP9s/A+K77ILFYvxghYPOjsLksYUCAG27Gzvh21+IB+u3zQh1sKuNYrq0TTUmon8WDw+S4BDDlzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPHAfUDd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b35e176dbso46948e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758296406; x=1758901206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ny4YeOUQ6SJeOcdkVzBU+J+zALLv/bmY7hQjTyaoqpE=;
        b=zPHAfUDddoexEw3n4O0q61SKuroVrsmPpckv6MAXSeln4a4FYRNRVvd8bWJFGpWeeo
         uLqYJOYQrEwbIpk3cAyh0LqQJ6ZdEUHmgw6nyHsidNLLTBttL/YJarTGVosjmzlLF6rn
         TdwEowabHAbiJkifVqbQbgsRGC+7LnlMSGk8zd/9wmuEXeHWt+JJgh49dICNywuds9u2
         uyIMIm4PFR38DXWP3rg68DT4+a0dqQ4MyverEqMYkH/mEsT9KjkjXzFJMU9yAt3mGoHp
         bqnBV06kDW6Vy6pTX3UgN49ulpRhzMrZMMtQe8/j1g87iSMCycWxg0PR/HN1ghhm/H4u
         qYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296406; x=1758901206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny4YeOUQ6SJeOcdkVzBU+J+zALLv/bmY7hQjTyaoqpE=;
        b=gTWrEn3hlAve0HIv4d+ZJ5SJyHxs8ALP0U0tIEW72V2OffqxZcM7aBld+aHNkd5wae
         Ke+slq8SRVwQQap7hyhJ5m47OkVz+/H8dF1HEYyB9cOm6E6Xq3nIWrFpGJAlNYmaJN5S
         lf+ekRi34tdHWZ379phET4sRv8LeMQXNaTXLtWPmd+DXPqcwWX8DNFnYhVAov5rgmoCi
         Ew6zAheO+5PbgT0tanet5yHFSNC6uwUdwpESKj5XcTAUnj3JrgjkLV2uY9hN7Fqvf12B
         vSHqL+ji//TcRJOt9oGmBX3q8Hk3f0yoRS3uPclg8lB8/oDpQjYBhG+g99JgajT2kdj+
         xTMg==
X-Forwarded-Encrypted: i=1; AJvYcCXK07eWklHWRrJqNQn7ar+P2veideTP2pmHOINEB9w9Zfu1Xtn9KxJOPd3rSH+QEkC/2vzhDrmCDkdImBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2eL/bKRHORtTuuGRgHgmTeow8XuD5C9Eeb0EkK4v3Kb/bmM4
	ILji4u/wMeRaq9KItyEeEjHmCM4ieOcTdFdyb6rWYVFH7U9exx6T7ShLlYXbZitBeLY=
X-Gm-Gg: ASbGnctw7I8dsW5KY7fN2eBrAicnZTbZJf047LOZsGl4v2cwrqU7899rVrP/K76yQDG
	MeVVaAfgrq3Enf+HurUAIHO1uidsSfvWLAIzIn8HCzDFdenC7JeHCpnGzdQrV6lnygks4O8BV8b
	8mkW3wjUztH6YK8iOL0yZ+1MM1ruYDAOoAkKQE+U/atUiLDzyGdstwfM6HdN/TIf7xo/jb7Sk+L
	Xgl37/vczljYJB0+ijYM507PGm8oBOj3/5WBP1DTYcijbM5R9Sam9ACXeUphPNT1w0Y/N242s1m
	yjSpbGdAjVRiTAwagF69dTz6NWQJ0tHXsxA9cbmErUc6sGsf8E5c3mhoing2gQrp22BqwINAG3j
	bSb9ZLAcGEV9h0RBywxhpKFlLuvKHxMDfwvw5mRr+/LoPLbWBUW/WU68lahsVsqiYgZ5NDCD4kx
	xXQw==
X-Google-Smtp-Source: AGHT+IGqJck6LcstS4NmmCegoanyc2XQaxhlYv4R/aMb3C7/Q4mLfE5SNfvUL59aj72O8yd3QXIqkg==
X-Received: by 2002:a05:6512:2356:b0:571:eaf:aa64 with SMTP id 2adb3069b0e04-579e05c65ffmr1339653e87.20.1758296404201;
        Fri, 19 Sep 2025 08:40:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-578a68e87fesm1480557e87.60.2025.09.19.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:40:02 -0700 (PDT)
Message-ID: <8ca1cd7e-e7c2-4a25-9b5f-d04c94d7915a@linaro.org>
Date: Fri, 19 Sep 2025 17:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: register sensors with hwmon
To: Michael Walle <mwalle@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250828124042.1680853-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2025 14:40, Michael Walle wrote:
> Make the sensors available in the hwmon subsystem (if
> CONFIG_THERMAL_HWMON is enabled).
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

