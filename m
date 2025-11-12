Return-Path: <linux-kernel+bounces-897539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8F0C5337A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C174222C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115B23BCEE;
	Wed, 12 Nov 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAxdrjkp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A7224B14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960942; cv=none; b=MGIbEIitjfnL5uuSGcHqop3UTnXJhLS8Hx+LdgfL/VWo82Y3DIrFo9hTlrxidYRjq2McruOU7BfYYGWKmsocFFI7+UskXeXXZeqGcUIc8I9+n9+jmXSD2/ltnpeFtHIW72hOQbdiWyfI1BRZDHMxbUJaKJ5prVGTjtUMRmAmrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960942; c=relaxed/simple;
	bh=WFyfDv8/VQhqxulaMv35/Nawd/nWvOcExPHLxYi1pT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJaWvDLbaKz2ccBXQYOwCYOn70UBtnwbg7H66So+PbCQzT1ZbgA2VdOn3PMnRUMnh1lOPhiGO4bZKpTimeWlmT1HedblpxoAy4p9RY68cxBZHgj7MioAsOI1dJ2y/ONd2++IChKAs763ybJBk3ARw7kT94QmiSySGukNC74VHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAxdrjkp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6310685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960940; x=1763565740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5P9hVRbx4wPte33M7hcHk6+oIwViC0UGSmzBYhFHLI=;
        b=bAxdrjkpkrks+YHlSWXXCG3Q9xdoXRxu0N7K/BV9v+tMmLmW3ZdtQmWlYTBfDF8FL5
         JX95iH2XmaBcmAzNJCjoAJ5/Tmf0rhc7PEs1cl7Gmr+29MKmuaTrKJAYsWUF/6/LfJ6g
         J5ZpDpA6EpjZZksI3VRBe7aATBcMJe7DCjR0lmrQ4YJ2SWfkqu5N42vz14W8SfQjo7dc
         KpMwMLiIX5O6hyNZWo+r/FEAH5jzM2uDszMpOEvayG3X65vxQsjuFyDh2MLXqYdZ12T0
         odSfbJctJyvJc4kNwbrP0crwNesecz2pAbjXebpF92ECIYkRy+x1HSV2y7OiC9Hg2hTw
         HZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960940; x=1763565740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5P9hVRbx4wPte33M7hcHk6+oIwViC0UGSmzBYhFHLI=;
        b=oKMxwvYYdRT301EHG3wIWkmY1YLtke/qvn0KgSLgF+kQmE0D85nVuHe+VzL7Xt8XP8
         TWQwiuyd/dsiaaL7L4DsRzwb4j0cjeUlSNlk2H1sfvVAUG7JdKm91edZ7pdiwZJIt8Ij
         k3v1IJAePHjRYhHuJWFWowVRVqcZKRZs45n7JXdUhz2UQnq2PSs0Cx9f1IhHcApD9dh7
         CbwXaxupX3ktb0ULqYw/3seuo6Frv1IaSYevJ0SYUUrUir1Vu/M5vvezTgCRwV5UQpdz
         tdseFPD3DpnxsXBTpb2Y4aH1+qkgqMkoBXKxovOoZwGJPfET1n6htPvodxlxH6MyR+by
         9pWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+qLRTqoySIKBdmxRDl6Q27s4tRwCF/yJUcvze/48NcHUyooBjoup+aPHP2ifGyokynp6vixfOhKoKw6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD39/GDvA/GqkwSUUMeGtCSyVMO/g/1PxNqUbyu/U74mBg2grX
	mXoFTnuPrKBpebaAFOBaSUmwKs3rlwfUfHCxlVbfy7VqSuk65zXGluSSVsvz60RmIsk=
X-Gm-Gg: ASbGncvbifJT6sE+VQ3pNSUyWWhsT97/nHbV+7D9fVNNX6388OzBVsV7hYTPo7tSc5F
	sfbfhO6R47RY5tT751GbqfCmqxme4Qa9dBwPALzXlh7ZAtllHCEw0JE1VwzCJVZjrhSH1LNsQqq
	ELQgOpddCYoah5yRcJrsH/OVbqmamDpG8hTadZWzim3m6q1KojnVR0n6Qclh8GxwPO9VOsQi7hO
	SA4zRvuKKaZnxby5dG3pLKZVxIFdBwCB33MOwjkVvYpXsdkeiSqpx7Zt6e8eWL3SK7Ej66W0D8q
	px4g2lVwQf3fwTnBgNuMFqJ2W3ZmyfT81vx4mxN4i1QaJVTvDKwjP2slXZt2T1pCLB8F8p56yjD
	rorNPfsPmlsJgnViTZub8YPVwJf/1KtRurt4QtcZxU2aWFhKI3MLyelLxJSlF0yvh0A5PKiM7j9
	dzxLXxoEmoF2bFkzojjIRZB9NPrBCC6sOWe4TeEXhmWaAIYOjUkxtV
X-Google-Smtp-Source: AGHT+IGwwenUJ0F/WO/zgoeG4aEMiYIBCD7Bc1kw4/Qbk5pV2u/UjSyruuNtKsuqPGua+pTCng6lWA==
X-Received: by 2002:a05:600c:4f12:b0:477:639d:c85b with SMTP id 5b1f17b1804b1-47787061d42mr35222465e9.2.1762960939616;
        Wed, 12 Nov 2025 07:22:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47788932374sm16400975e9.0.2025.11.12.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 07:22:19 -0800 (PST)
Message-ID: <c0714d56-72e4-499d-9f81-7676628c4453@linaro.org>
Date: Wed, 12 Nov 2025 16:22:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251017054943.7195-1-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 07:49, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function must not live in init. Device managed resource actions
> similarly cannot be discarded.
> 
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about this so replace it to catch any similar future issues.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

