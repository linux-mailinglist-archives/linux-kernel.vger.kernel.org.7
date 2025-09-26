Return-Path: <linux-kernel+bounces-833742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D888BA2EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B823847A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DD28D8ED;
	Fri, 26 Sep 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAn9C7tE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202521D585
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874881; cv=none; b=u8AYEgkvgHQs8Hx1kurnQxIbkyhpNu9YMheCzaQLjHj02hfyd3RQ5lpvWbI2F5dkVXr3Zo/H9AzMpCQfZKli9Pr6EN5G3uwDwZEBHa41A9joXPcd5PKckMUWAUvOrY0WpMCRPipQ3KB9jIFuab2Iux520kt3jQf3hMISFGP7C/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874881; c=relaxed/simple;
	bh=HNadxYrXKBxG+es9Wwf3kkJTuTewMLB9poqxJhntsfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irsoO06MfA48tioM2M70Ja+IE184zVAKKNwTpBiP6D+gio8Digl2i+8+wAqLXVeB66Qk56GYuBJYgDAW/eZua2lr08iAkxJ3IIAYLtbhTCjX1VhglXWW7f1ahPY7tFfiFIX5mh37XC/mI2Wrfk+98IJ9tMWmonAzyPDdDSBgSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAn9C7tE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso1268183f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758874878; x=1759479678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtlOdHVQKyDFwlgLpYjWciIJdDWqMWEqc8oTUdiH9po=;
        b=rAn9C7tEShSkFpqpEGjuWwOa57MjOlje4O1s1JeylKQvWc8qz/t9NC/4aLns5DwGTW
         TBPK1F39Syr66HI9D1gKpkoKmqaOyZXrorikh5s6W8pejbRMDP1xSod4DMs3DOBKToc2
         xBzx8spYZS7iK09f88WN1+q7RcEx4lsLV4sal0Srfj7MgQtWawqGRw04kaDR8n2mp0AW
         ROLqqHC0CjILgPvH7jr/iLEh9Wf82tsd9B96ap9654TjX8oQph63lGlB+InPxmD/Uez1
         KHm+itP4VOxnLRxoHmnpEJzr9znemCuwmpQQY7LIxELvzOqLD6m90NvizdaWt7g7bPHB
         7jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758874878; x=1759479678;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtlOdHVQKyDFwlgLpYjWciIJdDWqMWEqc8oTUdiH9po=;
        b=WvEmohKiOb/JXpMNXAHaI4VpYoSzRbi2YDrpEW5zthhxCLM9vqGw/ea0jlfHoEaT52
         smHZZn92cBh+w2+LQw8s5pFghWALDNL61p7ClJFYy21BdJcm48rGTp1P+mJCuvdZPZci
         hV1H8gmRVjwnenrFTlAfYThwV1vyXQnZXZ9KHNq3J/nQBL0MvRtP+qA/KDudB9ROA0/X
         J74DYWYuJKLQQh6UaIHMAivN21f9eCCGeiD8KOdympQnlUtGbxxSj6B0K30GTl0j6Ryp
         0+Wue4TufoW6WBmKoN6zZEkof3BBrVk0MiXHcRCJcZSQOvNrwGSkYrwKuvdUAvcteUyh
         IZEg==
X-Forwarded-Encrypted: i=1; AJvYcCXCut6+N05F9SOozPkUJZfvSFQ6/844McdofkWBOGsUiTGSa51mQvhXUokiJOdbN5se0NQ6QJVZ4evgvYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNA0Tzh+pbPlrI6Ia1CqEV0ySMRsdtJfI/6St4GzyP/u4OXr6
	Z4vp2tb9qXDGXNd0ALkwnpV2TsdbXCaMReVigUu1hVja/eA1oIo22kyTlNIDB+I39oY=
X-Gm-Gg: ASbGncvWFi5YtTpqSdt8bIclSaN3v+rDVs9f1FMTtDV0ts8tTdSpfxqiaOFuBPaPmeE
	YmlX6bHSHlM9vIhj0+xhPCFTMewuFx7bOQSyv1ZXmK89mfhVlOZyNufJlC2AgYC5zFWAngFjjdj
	1crQqvFF68dMUBGYx81/0Is579g1ScydS8/zdgG/Vx68bRlGhgQltTvURhG31ePOGJRt49j9CqL
	s9VMqSdDoc3OnvirIqNhTzYY6j47NJ/a1Wuofl9At+kqOiCY64Rx10imsVnK1G7CQYJe5q3HAiT
	6Y2PklsRk8YkTmteGj/Hgs0zT46fyflebwWcGVO6WPWoVRp5f/nt5p8ta2NAIg8H0ezvsQftInR
	zf3dbU+Qu82hEAGus47XO7+4CI45i0qbdTIKddd9CPKIfc0Svg5P2ZrHx68W+N6dpDceXKfMHNy
	y8wlvUivZ84h6ayynEdDHSxhs9DC+naOM=
X-Google-Smtp-Source: AGHT+IFnD4bbmtza7gIkFTVOHPWGUxGK2GEJRJeFtGzkAHojXdJuptg+w2G7NqbWxgBQIDg4CRmB8w==
X-Received: by 2002:a05:6000:2308:b0:3ea:c360:ff88 with SMTP id ffacd0b85a97d-40e4ba3a4e9mr6134848f8f.31.1758874878274;
        Fri, 26 Sep 2025 01:21:18 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm69822625e9.2.2025.09.26.01.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:21:17 -0700 (PDT)
Message-ID: <2c915fe6-a6c4-4814-a7ba-8f9682775951@linaro.org>
Date: Fri, 26 Sep 2025 09:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform: arm64: thinkpad-t14s-ec: Convert comma to
 semicolon
To: Chen Ni <nichen@iscas.ac.cn>, sre@kernel.org, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926014345.651176-1-nichen@iscas.ac.cn>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250926014345.651176-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2025 02:43, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> index f721763e13cc..1d5d11adaf32 100644
> --- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> +++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> @@ -401,14 +401,14 @@ static int t14s_kbd_audio_led_probe(struct t14s_ec *ec)
>   	int ret;
>   
>   	ec->led_mic_mute.name = "platform::micmute";
> -	ec->led_mic_mute.max_brightness = 1,
> -	ec->led_mic_mute.default_trigger = "audio-micmute",
> +	ec->led_mic_mute.max_brightness = 1;
> +	ec->led_mic_mute.default_trigger = "audio-micmute";
>   	ec->led_mic_mute.brightness_set_blocking = t14s_mic_mute_led_set;
>   	ec->led_mic_mute.brightness_get = t14s_mic_mute_led_get;
>   
>   	ec->led_spk_mute.name = "platform::mute";
> -	ec->led_spk_mute.max_brightness = 1,
> -	ec->led_spk_mute.default_trigger = "audio-mute",
> +	ec->led_spk_mute.max_brightness = 1;
> +	ec->led_spk_mute.default_trigger = "audio-mute";
>   	ec->led_spk_mute.brightness_set_blocking = t14s_spk_mute_led_set;
>   	ec->led_spk_mute.brightness_get = t14s_spk_mute_led_get;
>   

This definitely deserves a Fixes tag.

Then add

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

