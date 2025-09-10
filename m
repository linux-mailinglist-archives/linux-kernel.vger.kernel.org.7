Return-Path: <linux-kernel+bounces-811024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE6B5230B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC801CC1DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65542F7ADC;
	Wed, 10 Sep 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfZr8weE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11F2FAC0C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537660; cv=none; b=tAZkUqUZYGzQIpojIGDCQMihIK3K1oSxOtN1LwA8mcw3wp1x0K9rMKNgKjyjtYPfCY8KWSsQHRq+J21Il4Tmc89HR9U1Yq0chcxglIEgaEwaYB6OzLH01HqXT0hns3nXy9eM3XlK/u1Pgx6l0bMB5MHw6VcQLxbKUFSjuM1k1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537660; c=relaxed/simple;
	bh=ZEcpykoDvXOpYaB+2kfI3cJP0yHLdZM+Vguo0ayJir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=myziawv19gjELeXkaKk0bKmJqiLlEJKQuHNvkwsdKVgsQFzKberx1KAzLYfw3nvvGtxwrA/FsG/Lf1IG2s5eJNU9rmPWz8EZOVd7MuCioSfSsGB24X91JdZvYojfJ0rl3Q7EB2GNIjbv3oOhUxZcPNcvJCG5CjUaTZE2K4Bj1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfZr8weE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3dae49b117bso51993f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757537655; x=1758142455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGyBuuqykGpjKmWVjyvuUErzIfxP8EZ388iFMPKDEVE=;
        b=sfZr8weEe/Svffz9nj1rS19MzkNOswhsSloYV2MCwfAF9ZmhuE4RaOaprsWimulA4i
         i1ZT2OTNy0WDolQSXV0IKj/fjWlJ69uenM0WyaLuHvu/Ris2l8gLYfmvXlwAKwHDR5uQ
         gLTvIkrFvjq1MyStZGwfdJzETsLjj8m3b4zaVwa5PZBsqDuy14gEU24nA3NfO6Frkpux
         dzUTRjb3Dg8bjr/Exr3ZB+7UfukwzLX3pKOFIqMFgpDansMXuga+7kaWuaVhCWmR5eFq
         6XUyuegtHxNanW5Bh7LoCU8B4FmramdUfD0MzhFa/FX33X8v0hds6cOaojI/t/urR/XT
         iHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537655; x=1758142455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGyBuuqykGpjKmWVjyvuUErzIfxP8EZ388iFMPKDEVE=;
        b=oKXs+pbnHPEZnLWkwWo1opBCd6VuCAUWy9H7AdQsU4Wjl7GhubBw2RJ+JcGzh8piDP
         obFKUSdn6D/ihnAodkOUOkoZKuGssQm8uNMutRSLFtdcnPGJ0wGsmnPouisfQFPuDeqs
         WVTZPe5b6QtnyrHHmPC+gVYLp47KqJNyU2RSPjelnVygjWl3kN7Bzaw1MevaIrdtci14
         l4KIQG2YUQhIZAIqoYP+L52d5q3V11e5vkYo9TBdGbHe+8QM9ZtBTQ+siIjJXaxM0WcC
         4JkrAICzBsL+K420SNyfnWCTrt0yvLNARFx7hLBOFnwM+idVSsddcyGsWK0S1YV2xIVP
         qeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbu5Llg+o2sZKjUf4oP7W4WZJ2zVaavKbpVEP9EHjW220fSfl+sV9C9Bjsdn+YNgdIkIMOTAtTTClpxT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoWI3xO89zQiuu8iWj9rTP/1aWc1qGPqpyv2oySv33bnL3VFP
	uZXTwDthoTt4CMavLF4R1mcL1gp7a46kHSaz1rSa7pL19u90ijdwku+sf5+zh3jx0/M=
X-Gm-Gg: ASbGncspPFm+QAZEzba65TjeHHgB6UtMTyuSEyWe4pN/IrapJvrAXeh0iUDBRYjYOXO
	BQrgiswNPbrtCQGhNtJIb3YHBgVcNrtW291xpRP2z030PaLSeOLEqHTC7qdiWj+sR98ukFYpZjF
	X/SKkovr+8gnXoNn55Ac4BLWybmIh2HXzJlcpPovMfAGXdF2OYMOx9POGGsMmuMsbp7njNBCu7+
	TvdRHsAMZC0ejroLsZ1Z8VC0M5M4eXf6GiUTaEyCZwbMtiKUAvV5mY5nDxVG1aObj3UipNlmsGf
	IxORvmXYpRMMixao3qaCc9+2vq8Cqd1IEoO6B+cy9S1aZBYJs4XfTM5ifSpywtwYLFo2ABxHMol
	qisFL6+3lcSOl+Eb0DnNkzXP8nQzC5HiZOYpcU0/FfpW2/pDg6GzPU1XVqrG0Elf5/ErVXz25qo
	VFJg==
X-Google-Smtp-Source: AGHT+IHITa3qEhstFjSZFoYKlPG+V2cGYS1jAFxy6suweQRIhurUKS/GcMZKFd31Rr56oTDCDehMSA==
X-Received: by 2002:a05:6000:4283:b0:3e1:734b:5393 with SMTP id ffacd0b85a97d-3e6435551d9mr13456719f8f.28.1757537655532;
        Wed, 10 Sep 2025 13:54:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9717:723a:79cf:4f4a? ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm856045e9.20.2025.09.10.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:54:15 -0700 (PDT)
Message-ID: <cf020451-115a-471a-bba0-4152015e7173@linaro.org>
Date: Wed, 10 Sep 2025 22:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clocksource/drivers/timer-rtl-otto: enhancements
To: Markus Stockhausen <markus.stockhausen@gmx.de>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, howels@allthatwemight.be, bjorn@mork.no
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/08/2025 10:03, Markus Stockhausen wrote:
> This series fixes some shortcomings of the Realtek Otto timer driver.
> These became evident after switching to longterm kernel 6.12. Devices
> were randomly rebooted by the watchdog.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

