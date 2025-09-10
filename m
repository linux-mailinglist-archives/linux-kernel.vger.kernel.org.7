Return-Path: <linux-kernel+bounces-809995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB79B5145D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E8316ECCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936E30F806;
	Wed, 10 Sep 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhIeVqL/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB5309DCC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501273; cv=none; b=HSX5QECtLZSKtRTNb/F/LNM+VQKlmF6YgzN/kfJ3n+b8airRCEiN42qyZZD079StWnIUum9RKuFK+lGlJHmgm4CeK0aucQiXC9YUqibyYhmKeQPYUD3K0Lz2ZNkWRFS7SiugEhw+FT+9vPj//3NoPMH4L5QxVdE8BvXYJD1CVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501273; c=relaxed/simple;
	bh=9Hp9ejvaQMN0Yp/1s9eHGyHfNz2szACAPW7IT9Burtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRpUEcL642n4iWGfQYq+SBkbovUqKXWIOyFphGS4x8+FWeG80Gs4iu9K9YeMxCJeuj70jw5HQ5LnTAU117j/pV8IpJ2fOXrH5xZMrrl9gDKqTBtF96qJ9Vnow/6Hrj0v1WmsDEiCaeCWz019OxvIU/YMhn/a24D4qSgZ1a//L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhIeVqL/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61eaa4f6784so1142654a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501270; x=1758106070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hp9ejvaQMN0Yp/1s9eHGyHfNz2szACAPW7IT9Burtw=;
        b=bhIeVqL/T0gEMDH1DqojWdGbjnKGFDMCA3fRtUfjrM9Beb9ncUQ7UxB8SlnSdfpkEU
         mekHaigLdvb2F/aiwLZd6FktV0Wn0Bb1/N96Nb78Jz8/Jj35MWiCdF3bSD3l+g/8Mhf2
         Zk5CGkTO1srYe0uzL2UyAtG7py3ElKiYh+86RQdXdQuzwVRkKVCdUr4lw8Lw3yC9RAou
         bn6N9xcRw5UOVPVBha00iJ56n6KSv5OzZmptfNKtuLuh7r0EgjDKRuB+okxLGdqqGKbw
         NT3PeMO2b7hbr4SZinMkNQMjFC1/Ampjgr0ynnmJ40gWUeKBVZdSZ7dfpimcD61XKpDE
         jt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501270; x=1758106070;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Hp9ejvaQMN0Yp/1s9eHGyHfNz2szACAPW7IT9Burtw=;
        b=AwQvT48Nsp+nCsnqt8+nhSTTXBkBd6S4dUJaFabe0VGBvAWkHIVmRIJ3vTOiPPZwEU
         ftzx0IL8NlZGRIYlqPgW3ruJyVsgUPdlOOtCdUKVz1QWsyAKKd4+vg3WskFGYMmu0iV/
         MtvM2mHqYyyCod9oMkXc9NplULKSogimbxEnFrDYdo9C4IqW29WtUCKYkO/hQQiZyEYr
         ACgGkrKA7LPBddQrr4chC3KR8yHpXW3EszWDEVok3iOL5JkD+LnbO/JVbVv7sxe8znmc
         iosOfJ7Eyrhk3gV0/0X44LgNzIpRRSQ669XvI+/DI4JhIIH2ZXZxOh0mbUdzwGc+S7Gj
         W9KA==
X-Gm-Message-State: AOJu0Yx7D9CWmYyKFh6sj6krV91lKpwTDOoleabzinCGkUxuj4D8pa4x
	c/uK5ivWFu1HN7ujb3hqLi/xvorfVasQSshuM3CLe8yXweFitqUEeG5slyIYdIoqkzdIl3zZrKB
	DUS+s
X-Gm-Gg: ASbGncv/hSlYc0CjjeZDI3W9l95rf2TkSAyt9oc3StvjYfoYC1FSTU0TFs3yPNAO7qh
	xivz+pJoqiwmp7SMGtdIWkhDWkQTkofs5LXx8VtLwfAMa0gB1EDDjBnGp9jn5yz70fAg9NqqpSo
	JoKyXDVf9lH7Jbyx/msrRk3GMtGlPFigwrThv+KYqEc5cmvbyegdnB2hJ8X0uDbvExWjhP2p0is
	AyrCinhijGcht3rCGpNGDgrr0XZUubbLpq1bAWy5TJ0DE/H49oV675vjUaLRWuSgi2/zrIjFZPk
	ggBt+z1BAQJ6Uj5nG8xJD+MEH1KUm2nUXUUOuHNTuO9RB+vVaEaClhRs4r/BSNXTGQ/9HMsWPmW
	M42AzaMtn3A+4F2DH89h7QIasvt98I70LZy63gEltH9E=
X-Google-Smtp-Source: AGHT+IEtrlqjfQ2FykxeoxLOwp0RvmlUbcK7ZTNxgfqDcDiY+m0P629zQJQOgd2W2fKCZCm/oWIZ8w==
X-Received: by 2002:a05:6402:42c5:b0:61c:b796:6e83 with SMTP id 4fb4d7f45d1cf-6237a42fc43mr7772122a12.1.1757501270531;
        Wed, 10 Sep 2025 03:47:50 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830451a0sm144342266b.21.2025.09.10.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 03:47:50 -0700 (PDT)
Message-ID: <115e4411-587e-480a-b196-a15a7187d486@linaro.org>
Date: Wed, 10 Sep 2025 12:47:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] memory: tegra186-emc: Add the SoC model prefix to
 functions
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Aaron Kling <webgeek1234@gmail.com>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
 <20250910-memory-tegra-cleanup-v1-11-023c33a2d997@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250910-memory-tegra-cleanup-v1-11-023c33a2d997@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2025 12:44, Krzysztof Kozlowski wrote:
> Replace "tegra_emc" with "tegra124_emc" in all functions to:

"124" is obviously copy pasted. I'll fix it in v2 some time later -
maybe some reviews happen in the meantime.


Best regards,
Krzysztof

