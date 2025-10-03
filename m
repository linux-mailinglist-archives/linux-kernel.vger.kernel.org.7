Return-Path: <linux-kernel+bounces-841374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 991EABB7208
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C854E69F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A2207A22;
	Fri,  3 Oct 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tmd5B7J0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E6200110
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500711; cv=none; b=U4kDly0Jb2l/A3vxF+bUd1VqPCJ9q5CypgBTURXO4yKwPr2tWDHpSqm4/QThkhl0awMoOmsw/+N75Jn15iRio1NhvLoZO5hJy8O0l0EHMd3WcH8bWUxom0qXCgejK5UUSigtW3onf/ZaWxG2QFJ9RL0wnL4svhUdx58rVElV0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500711; c=relaxed/simple;
	bh=ga34MQLMl1SyMutFNVq6TRklpM6M66gamu3P72fJZvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hntiNK30TU/bfYQZ0gHJwLqpQ5BXkmtm0+d/zjfIMXZ0gQQOa01N8HaaElMpfwblVEaV6Vy7rE965bYx+RYxoYQm1M++kTCtBV6pCvzWn97hOtnGr2BUtqDAkDgo7F4tPpjvi+waYC/WVqiTbg8W/UBblllUzonBrrVrT4K9WLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tmd5B7J0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3ea0445fso12576595e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759500707; x=1760105507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxPR9K0HC+xbwxtRa+T+WvGGIp6IQ59ISiN3ZkhzXyI=;
        b=Tmd5B7J0/tgVN5vSizSbddWSNpmfLdPWD9F9lSqwKt+m1Nz0b5nwqfBRMXsJewGlK0
         FPnrtnzGhyKDtigVZ+uxr8dSycRjX16AClTbmaD+5fbhxdmcGoNMxh8eh4yojqR3E3IO
         rKMty55jMpUJPkA0mfGnp8ghWi+lu0JXSVt8xEyBef0OVIN9e7l3Q0Xb8QTPv48b7SuB
         OLc/UO9oQad2Rr2K25lDR0IOAT7ls0diYLYqln86oeFvur4jqfrvK7bbhOiFoCgEDFia
         eLpXmFrDWD1IHqsweiKvmQ92CC0l7li4FMb4AeXfxzCzdNsWrokdvMB79FVFWw0jt5V/
         +o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500707; x=1760105507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxPR9K0HC+xbwxtRa+T+WvGGIp6IQ59ISiN3ZkhzXyI=;
        b=ZHxpLrtOSILQhKTPM/kJIHcaGEemdwQpK8wSFmaeZrXs/NgrFvUZeb17ooeetxhQgX
         XjaKJ8HTyCAmsT9AaCWwpBNO9zuqUzVh7OC/ygpNl/sIDF2ua8zLtZ7Qcz2w6zBfzrki
         rvB22PVgNWAKnmJupTDtONw8bAAlpmE8LlqOrEv6Yga9jMRCJuSDO2U4R4l5/h8sKQ0Q
         v/vKYuHb/5sX7goR/shjD++XyI/f1G3yN15r0jBCLaLh+fR4AKDxNOM4ebTL7ZntsWwr
         vqb4Fp2+9CPtWs+oSOi7KVoF6seUhjISxJs2NoHhXfplkX9dJ59yuuS5x3coVvrqntsg
         CWog==
X-Forwarded-Encrypted: i=1; AJvYcCXoFun0Ta9edQcRk+TZEak07Cm9CA2VT0ST9cH0a+MVXJdfEtWBAr65JmtTP4JvEHheouMOtRiO4NnFi4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjNRWDkyg6Lm1jKiTL9ns9nQrOhU2epEs35ZTwU9UlAfNEdb1
	xg4s1TLb6qsRUw9q7wLK3yZ7DX/s7I8eHGBkMsXZ1TdZVOQ8CDBmEaxCHwQQqNKB/Fs=
X-Gm-Gg: ASbGncsniaDOO0ODvGYyCj7RgTvY0Uglf9BqV7JCxFfw1NkfzEdWuB3kEuy7n1v4BEL
	OX0mejDAdUJSrtM8qwuHb6fxoR007QcFYf+DrzRG1gN550xSPYVTNo8M2zHzug8Yo+o/exRSQTV
	aLXAOV+kswAFz9ehjb9HA5Z4mFy6Ngz78ZVblqtX9nX9hTsCOE2runQtc3uhFSlIunPCFoluBFG
	vjkErsNfZH5rlJyiW+BrUwFCRt95ri5d4CIksCTrf3PpakqCcnho1iSM9u87BbuaDHWYR/u98Pi
	lO0oxoJd6snJGjfSvfBFFqrUs+zptYaqLSFIKBpHA8Zt7/Iyazqq6v2hXDvCYugaFnqMb4EqPp0
	EBo1kfGc8XjixpFdE4BizxtoRiriPkn6GQEr030WxYWNFKdDIRs7zjiNYT4OyFBMjqua5mMQXnd
	K0pBHPrE0aXUTgZ0sK5ABd12AYod2iiUJJGhG9KAzyVWB8+02rlxU=
X-Google-Smtp-Source: AGHT+IFYIJUsAi1mTEgCo5N2hnwJFhkd6+46mapxkLBHuXxqoKtww2lCr6Ocq4qA5nCWxX0PP3pwNQ==
X-Received: by 2002:a05:600c:a11a:b0:46e:711c:efe5 with SMTP id 5b1f17b1804b1-46e711cf13cmr14022415e9.19.1759500706645;
        Fri, 03 Oct 2025 07:11:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4c79:9d67:d5bc:d285? ([2a05:6e02:1041:c10:4c79:9d67:d5bc:d285])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm133764065e9.14.2025.10.03.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 07:11:46 -0700 (PDT)
Message-ID: <59a02980-3d3f-4baa-b466-271121a97a2e@linaro.org>
Date: Fri, 3 Oct 2025 16:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools: lib: thermal: compile/install improvements
To: Sascha Hauer <s.hauer@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 13:40, Sascha Hauer wrote:
> This series contains some installation/compilation improvements for
> libthermal.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Emil Dahl Juhl (2):
>        tools: lib: thermal: don't preserve owner in install
>        tools: lib: thermal: expose thermal_exit symbols
> 
> Sascha Hauer (1):
>        tools: lib: thermal: use pkg-config to locate libnl3
> 
>   tools/lib/thermal/Makefile       | 9 +++++++--
>   tools/lib/thermal/libthermal.map | 5 ++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for the series

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

