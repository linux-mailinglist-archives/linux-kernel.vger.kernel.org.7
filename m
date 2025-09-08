Return-Path: <linux-kernel+bounces-805817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A989B48DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F0E169C34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF72F3C28;
	Mon,  8 Sep 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7z2GRsi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57462147C9B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335399; cv=none; b=mJ1nd4e7MEAp7C15Uza0/RszXdDekb43MjryENxP5NNRUCZ1oGNsl7R21rDciDXd2c/E3GiGyAwolU8FXEbkIcHHC1XR4E3gVlpBkVvVKHl6Yod/li+DeNxUejfiUO8Z9VICdIRglgMu0AUhWFNA47vzy/2iklg7YO2fXcV9Myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335399; c=relaxed/simple;
	bh=7wzXkqWaTtpbDbG1cb7HMetJwODd6HHjob4mHwKlVNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iZMpezLZN5ZmenB1+0uvQ3fEyLFPu3oW2xPQmohk5ohyOjswQxbDHYEWGEKOJLWv08Bgyex/wz0NfTfFAZ084h8nnEVahkHAQNt0Wu/gCj3Q9+slJie7/YVfBhBAAsoDgc8MPtXjNgJsozncWSGSH82/RQJH2AK8QJYdQMlsznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7z2GRsi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de1e6d76fso13910915e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757335395; x=1757940195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bv7N0nEEMIW8vc39iETSzqLknphU+YZnN2De3mvFq6o=;
        b=K7z2GRsikpUzZyhGRUpKHkplH3LTqOzovePeMVfdewQaPeKeKPT1iOrmnE5q9N40fQ
         K3CehL4U7cF3Nvv+E4Dd2EEz/Q1DSq8FArrnEUylkidUqOsTbEQfGBs44VCfliEf/vLI
         qhbF9b3JZZkA2LAp94TSTBMFuMZqPYDCq0x7pTsKd2fdjE90v7TdarR+WdhAjGyqwX2N
         7JJjfNS7jJuuSF/JaWbiVvZSfk5eXCQYlOoLjjuNlrOFj5WoVME6IgvzPMF0bHv2mrMY
         Tn2095Kn7tM9ialUvEhGn6CUAK1GOQJQWG7/oHPzqq1SZHkj8Lnd2ZqPrMwZ9OBQtUt/
         Y9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335395; x=1757940195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv7N0nEEMIW8vc39iETSzqLknphU+YZnN2De3mvFq6o=;
        b=LXRqUAKfUCUyIUgHpUmGKhdUG3YsVL+VG/0uNftgqjnWb1JH0o6txhiokm+m5MxvNB
         C0U7ZOJonelwU4zucjOCCKONuZHgoK9mUlK2kME+R9P6jlJO7TDNex1AmJ9j6w2A2gh9
         7RZjk138i2vHvZcFm03eUTjHKMzDboVh94ZjjLhEIMMvA37LLOHcAC/eXkRNlRBPIwLJ
         zLTbySqcSs5ju3RiH1XVt9eeHuMhxR3M/vRXb+kid+yCzg6thJ4qifZpmkDJaRso2s32
         oDDDtTg6e0nzZb3adGN7utDAnrHMZxqWroG49BGOpb/loPnHb7Sve3OFSBy2qnRYucCY
         fPDg==
X-Forwarded-Encrypted: i=1; AJvYcCWKklhVwO9AS1Pys/IVWmUKuVILpciRHUhdZpxt3fBOUKW+EqeBkUuBAVXODwZHpOXYcXEl5ewUw97ea4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9UPzKNbWaSU10oipQidNmNk3IQG22h2FO41ZS7Qu0964637G
	uvwBY9SGGxgVPll2K6dyc0Za1ILdiBohkPUSfNEPzMIcjUs9Yu8wdFz2dYbNRfTvxxc=
X-Gm-Gg: ASbGnctQeQztGX0rMC3834FiWVm7h+tVcXsB9Qa+VL3iz62jg3lQ4AmkBSZPqejzmP1
	8uNjVQPnHfUQlfDIaZn5S+IEAhTqs92LUT8YkZkPvuxh2B2+66qFbWDRL8Iv1Vr9NUmobAymi39
	IMW3r5/+LEhGcIAjlnoq9CDn6VRH5oIrKWslbhDiblZjGDInf3A/WwJOWXF95XLQO1BIF1kcWvF
	dkzu0+M5n4V29y5cA2aYwfkj9L8C30CzfbvIToJ5ryVX54rCwdkECZMvdotqjqv3v8T0am7lZg6
	Q9S7UUCyYLQbNKahr9nufx1PFp6IqijSPPn5KHZ/4XrjdgJ2+/vpm+mLjQxPTjQhdWKf/SJ8ZCf
	vG/iVh0XbHTbxcwX1VeOO+AHu66oj3Mn6L31adZGmoBsXONdTLhvg9BfPdCPAMIlwSO/r/o14H3
	oYOjP+y4n3aqYp
X-Google-Smtp-Source: AGHT+IEJWmUPrNny8/8KXYUnfyYJBB9DnJE5RKBe2s1VGrnXN7x8ilawMOISnApGgurJ/wJqGcwbVA==
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id 5b1f17b1804b1-45dddef7fdamr61319805e9.31.1757335394504;
        Mon, 08 Sep 2025 05:43:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab832sm438407955e9.23.2025.09.08.05.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:43:13 -0700 (PDT)
Message-ID: <f0d72eac-f842-4060-b197-ced20048b34b@linaro.org>
Date: Mon, 8 Sep 2025 14:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-ti-dm : Capture functionality for
 OMAP DM timer
To: Gokul Praveen <g-praveen@ti.com>, linux-kernel@vger.kernel.org,
 u-kumar1@ti.com, n-francis@ti.com
References: <20250812105346.203541-1-g-praveen@ti.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250812105346.203541-1-g-praveen@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2025 12:53, Gokul Praveen wrote:
> Add PWM capture function in DM timer driver.
> 
> OMAP DM timer hardware supports capture feature.It can be used to
> timestamp events (falling/rising edges) detected on input signal.
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

