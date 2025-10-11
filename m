Return-Path: <linux-kernel+bounces-849161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB2BCF514
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 453D234C063
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929C276050;
	Sat, 11 Oct 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTz6wyv4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FD26E714
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184986; cv=none; b=Sl5zhNYJkwLzYSljdm23HVjK7MDjM71VO5N4tpv6vzYE5jV2CuryH6VCSRWVGrnVw/YVFhOjhOMKgcLZWSUsCLcGOQeJrnWDqyUGk0BLi7QfbNTZBi9R71v4aVHR50EnodzkBhfRXFKwAW8wjKkCEfE7kTVMtpADi1U+cljhXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184986; c=relaxed/simple;
	bh=ZI5TPYuH5aD9kbrYTudi2phDOrMMRofUz8Yd8NjZ24o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf3XLttV1g3mP7AKWHeHc3OI5/JWVtzLbgI8GJgjlc4o5BCFkJQGHkeSBS/kihGA3bpTNpppXiz2jeSejJ7C0MmL+egBa3hLqReGqUq/HymyCR+Y/Tzsz9SkfQGLuD52ylqcXWksg+PGLKhJUNIOfrrEHwMyXogNrhqE/ZVB0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTz6wyv4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso3635231e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760184979; x=1760789779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyZodhLATiu/3uXx9NUchp//hn18ZJQh1emvghIBVhE=;
        b=nTz6wyv4OTCIFS5KZDzHaTfWcm7iYS8otbfo/6px1hY2ppiF66VHb2o0CXGpRY7Bio
         2hiC6lZrVv7wqEUEdx7i0JNCFtkiy8mHCT/tRyGor59OA0h13hEYZ+gJnryi/hIdA17K
         0uLMLZLh/NNIYbWdvwrqwQqocExKN56KnUguqQMierJOuSKmyjHvySxIhA1ei+M58+fu
         KX6Fp+ItvmdTYixk8gUhFAj9+zNcsjMdBNxCUw+N1ZlvVPpcFGIH2zA420TR7eTE/rZr
         EvhC4n+KMoCHEr3AM1cF5RUgOUB7NbqAlH5PUQvKZCVTICw82IRr30KpNWNzicxKBkkB
         MtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760184979; x=1760789779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyZodhLATiu/3uXx9NUchp//hn18ZJQh1emvghIBVhE=;
        b=Xs3VumcTLWfVYh19A7VWyvdGOqbtwjY+5DeGDZO+RbVdv5pSBL7W3qC6IJ1jOiBZn4
         nQRtelvMfcn6XEt0RYFJl9RJD5DVJl4jcTAtHWEz9ehuEztdRcAHsxutUMv6SXS76vr9
         +5vsiK4Fre/URAf0LJc6FGHMUdnb5ZnoObMIHPZXyr4qQpkiHBHhNqCwqS5J4pMY6ezq
         wkWsoFYTPPJXw2sU3mhie8+yPPsu2dyB60hBycyfn2ZO55pnG8fj2WIyzvqeeZsDDTV7
         ggREeyRpiy0Dw3vIvYxnhceJVQa13/wbGZ/wPE2gsbWhL5SBoZn40HUp37Ncal6VBFUK
         WMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmLSPc3L/R0friQIIxbWMVGUFkQl6xVSG80IGaQiQmflB8LLXemQSMKw4c+gvYL8MgUvn5Bi6shW7jMuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyR9U9uG2SrsrLXb/9ysRisqg0NJvHxOHm0xjNkOpfGtV8ei4c
	QnrWLUObNuduTVuCQWTuP58Da2H1xlc8N5byKTA2V5voi2yVDWobb4XE
X-Gm-Gg: ASbGncsZbvhJ/Hi7yEIwiJbPEoUd/WJiJP6X2SCJ3PuACuUXxI3IlQutt/uixOPWGI1
	jNu7NstrDGdD7B5OvlqpmXZhwLPlv19GmvPZXMjmVgYyG95Vqesflyl3erUNaOIDcU4w1tmOPiX
	OIYVtaHFs+nM5iysFhkOzUI2micKWLLN28wnLEStqP7qA2YJ4t9gRz7I/Pc5cZ1rkJvbe/0CAIe
	PmA/QtDJt8P00u1XGm+DnJrdjLCFM2bDrZt8f7csk2xRqjvgKb5ayfeYmW74OMZS0gyWds155s6
	LWWyEF++Hg4igeGaH6A3/fzT227fYEcJYtNhOE42onZePrm5m/SH3PTGWei1Rm0H/f3VC5rPzzR
	Ol5QA5HgCFbJSH6TeRDZ7747NvaPS/uGd62X6JFcV9q+sbN231udDw8f3OZJGN3As
X-Google-Smtp-Source: AGHT+IFdHSvkObU+tPl9CDJXrWAsVL6tubVC9+zULoMNnufCMnqy+TEO+WOSC6ej7Kbq74CPdF/EkA==
X-Received: by 2002:a05:6512:3dac:b0:586:7f:a141 with SMTP id 2adb3069b0e04-5906d88e732mr3805999e87.18.1760184979187;
        Sat, 11 Oct 2025 05:16:19 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908858456dsm1862610e87.124.2025.10.11.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 05:16:18 -0700 (PDT)
Message-ID: <6f6fbebf-bdb6-402d-8aa1-9f33eae914ed@gmail.com>
Date: Sat, 11 Oct 2025 14:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: leds-lp50xx: allow LED 0 to be added to module bank
To: Christian Hitz <christian@klarinett.li>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>
Cc: Christian Hitz <christian.hitz@bbv.ch>, stable@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251008123222.1117331-1-christian@klarinett.li>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20251008123222.1117331-1-christian@klarinett.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 10/8/25 14:32, Christian Hitz wrote:
> From: Christian Hitz <christian.hitz@bbv.ch>
> 
> led_banks contains LED module number(s) that should be grouped into the
> module bank. led_banks is 0-initialized.
> By checking the led_banks entries for 0, un-set entries are detected.
> But a 0-entry also indicates that LED module 0 should be grouped into the
> module bank.
> 
> By only iterating over the available entries no check for unused entries
> is required and LED module 0 can be added to bank.
> 
> Signed-off-by: Christian Hitz <christian.hitz@bbv.ch>
> Cc: stable@vger.kernel.org
> ---
>   drivers/leds/leds-lp50xx.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
> index 94f8ef6b482c..d50c7f3e8f99 100644
> --- a/drivers/leds/leds-lp50xx.c
> +++ b/drivers/leds/leds-lp50xx.c
> @@ -341,17 +341,15 @@ static int lp50xx_brightness_set(struct led_classdev *cdev,
>   	return ret;
>   }
>   
> -static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[])
> +static int lp50xx_set_banks(struct lp50xx *priv, u32 led_banks[], int num_leds)
>   {
>   	u8 led_config_lo, led_config_hi;
>   	u32 bank_enable_mask = 0;
>   	int ret;
>   	int i;
>   
> -	for (i = 0; i < priv->chip_info->max_modules; i++) {
> -		if (led_banks[i])
> -			bank_enable_mask |= (1 << led_banks[i]);
> -	}
> +	for (i = 0; i < num_leds; i++)
> +		bank_enable_mask |= (1 << led_banks[i]);

Probably the first idea was to have a bitmask indicating which bank
to enable, but it ended up in having array of bank ids in DT with no
related adjustment in the driver.

This patch deserves Fixes tag.

>   
>   	led_config_lo = bank_enable_mask;
>   	led_config_hi = bank_enable_mask >> 8;
> @@ -405,7 +403,7 @@ static int lp50xx_probe_leds(struct fwnode_handle *child, struct lp50xx *priv,
>   			return ret;
>   		}
>   
> -		ret = lp50xx_set_banks(priv, led_banks);
> +		ret = lp50xx_set_banks(priv, led_banks, num_leds);
>   		if (ret) {
>   			dev_err(priv->dev, "Cannot setup banked LEDs\n");
>   			return ret;

Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski


