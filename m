Return-Path: <linux-kernel+bounces-886542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3AC35E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FC93AB505
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411F322A27;
	Wed,  5 Nov 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et/WpNDu"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B622D978B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350207; cv=none; b=W/eoxVBDSEeUqqhWBXGeyjt4UauFoyl6u3Bui1T6RA+rRDIBBs13M+N2mcw9Z0ssY7FSrWp96PwH0vR9OB4OFBXjKX+NTGa/MNDvgpMokXYlVledpMyN+oGK2wjYxSOu3Q7g2OMWfqln/VkRMRFUtghPQc1/zWUx8+OSvLlK/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350207; c=relaxed/simple;
	bh=wl8A2DXR+C0pnXcPW0UbASdUsbLs9ucHF2+GxYlGJ3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=du845US6kosTpWiwsnknU/3e5ZrdbxoW5Z6AI0/FcNGFJxTJH6+qZwykUjRRbTBcp7svVpzPFxwfIuelyKIyVqsVrlPIHVRaT2VHEBsjBVrsR50Fjqthi2j17FlIoP/F8KvwiIBRZvxYarghwxjiztXdggSlcFMUCxc2dmgv2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=et/WpNDu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47114a40161so18599875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762350204; x=1762955004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4K3dJVe5lLpcJfTZtDwSagN0YqK2cfHhQuSVAYVTc7Y=;
        b=et/WpNDuf92feqrP0JMxlQlmcSsfDqkvDifubtZvHTbKOVYOcjofKN3ujrbduyE0u3
         8K8IZd0xL2tdYn+QqwiJSkqyiZzuzVkH3d6/cINnVXE9JsLVNPECTPsEuQsRJwJd/keb
         a110bE2pHj8naYBMlWrLkb/S316oi0KOeU1Pjh9fw0yCAwaFAgt8NLwXlepHyco5N/cN
         lYzQg3cY+JPA+fCLBSqUVDR0Eqy26STrQeEwWyzXVVXWdeenB0mi9TzWJgxx51iHBZFt
         GL6HUWaMRioY8Jm9zLRT8Uq/Ib3Z/2hv2963YrN1BXkglrWottZWPyfH0SSQqa4WIP6V
         w2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350204; x=1762955004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4K3dJVe5lLpcJfTZtDwSagN0YqK2cfHhQuSVAYVTc7Y=;
        b=JovdiLReli3S0r/8RasBzioTOly7HHZX3i6NEAmJpVQX9DUnR4UH97XyhqgPtSJTN6
         gJJej4MocDiIUWtgy2K9vt3H+JZ2SufCTMPjBCoF/vzW9fo7gqgZWqPkKLgv96w4BJV7
         Dpz9cN9zegVSgQbOE1zpqtak5sraYgF/6PfJ83/IdWf+1PnS3zSErKczMviQZ8kR6Gdx
         OKWs816Glo6uikzrUM92BBRrsSyH/SL59XZyWRTqX5R9mMm2dcV2fy/cHBcQN0+fyGQd
         hp5XNVrEm4lvWZRZY9wkRHYkfZs3N/hvDje0RaJmI5YlzPP8MSGrbsZ7ZsY1s8u2SH/c
         XSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv26PE+mBbvWq6gjo9v3xSAUhyheEyTOTYiCYg6EMrhKgUd0KUmvPZJSvZDIe0AtyLkEZTGZCaZBGMBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2HNuuib0ftfzjYJSvUozAaFFWo/57hmTlhA4Kr5R+caXCnZ0
	HXiQNI1BJg8hVUL3iXRAIwVw2rDh6SM6Q7ru53yipoh2NXVXfNmCNZAFFyz5hqeRjfE=
X-Gm-Gg: ASbGncsnMFQjvC15SB4LewHM0Bz6i7cUtuIC50Qhp70AOgYGt21pHVO48ih5vBZq9SR
	hvJLosKTub+IuAGP6QTBCK520QDmOkZIpKuwHMQPLa8rsVUJAC2uFv1O7hyqBunA+uRxzsJZzn2
	ZsUaQugm+Qi4K2J2GhK6QcPCKo/4JLH0a80dXIwN3d154AJVJ5sYLeq6nZ9DH7HwW3NlzQMUXup
	m908AlO80O9Xad0vCNMwbaPV07LmtUqhRUYCLM105LRLNLUbTZZJ1fa1YqLt75IrygIyMAJgC7w
	VaoLD41/cCnd4hqTIckKgUVuB7DXn4kbPQB5SL6SwmWlQRuw1uFDgtdUM5Vo7TFzq4gdi9zvxc+
	jRr34sPt8k7dYd9CVdy6lWapB0TrQSRHg6/51PV3u4xDLdG3m0xO7Wh6C6cZuY7LcldfK+IZlbw
	rLQdaTOlgFlhY4FnMZJkzzBTzinJUVFEDCIhpWZ6ef9Ki1HXk=
X-Google-Smtp-Source: AGHT+IHDXWfkY+bbILWxnbioob/2tB8n47HhZGEJXTXUkYhUI52tv6zh/j27yN88PXWGU5Qb+IKObw==
X-Received: by 2002:a05:600c:310c:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-4775cdac841mr28782335e9.7.1762350204186;
        Wed, 05 Nov 2025 05:43:24 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477558818f0sm45495645e9.0.2025.11.05.05.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:43:23 -0800 (PST)
Message-ID: <9c7bbb57-eb21-48f2-86ba-1932889e17f1@linaro.org>
Date: Wed, 5 Nov 2025 14:43:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix double deregistration on
 probe failure
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org
References: <20251017055039.7307-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251017055039.7307-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 07:50, Johan Hovold wrote:
> The purpose of the devm_add_action_or_reset() helper is to call the
> action function in case adding an action ever fails so drop the clock
> source deregistration from the error path to avoid deregistering twice.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---


Ah, right. Good catch, thanks for fixing this

I picked it up

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

