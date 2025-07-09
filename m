Return-Path: <linux-kernel+bounces-723117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D970AFE320
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBEF5677EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB438280004;
	Wed,  9 Jul 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brUiE9uF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929B2797BF;
	Wed,  9 Jul 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050918; cv=none; b=pXGVzs4OjmdJ4AZmzMJLunL6LppKCVztyeOxBnXAnP2YpflncmiqV/Dj2TYs0Edbsrb1J5lov6ifCmNLbyU3ZGProNvbBrrQbrUDGybEerjl3GSlQORvhufqGRX2jN83wgNwv0tQLQJ4X+Lpr20q2OeL8ItWx8DhyvqFvUAbgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050918; c=relaxed/simple;
	bh=m9w/1QL/K+Ntt/mLviD4FdzybkCSwlcWTYLY5PyR1w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPoUZd3LtzbNw1MwdrRUjAQhNe7brgXXwjzYLU4JSvWZj2q9R6SmJX5aWGMFcmDWXvUUOA8NitubwshwVA/8hrZeGS9DKqndbmh73tamUtYUVJzpwhTPEHMOHXzeO+7TghFHOkifg9HxY6SfYfvjZVnP1c+uadqdyn4yltxWgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brUiE9uF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso11262301fa.1;
        Wed, 09 Jul 2025 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050914; x=1752655714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As+iZdwgIfJIachU2kJw0qfJ3dIIY6BahSxZStPrJ2c=;
        b=brUiE9uF5yQbYGf8yWlILxNm0pJhoBA+znRgkxERiAMTDwiuUvuxFLeyICsihxJAF8
         F3kJQbP5g8+vf3gfVYrkf/ZfZi8R3I4nj4kayXGpLAcJx8X1KZlLo/taF9VJskSKVOsE
         v6aAe+bMhZjQTBuYXl9TiOCzu4B9ZIPRGGsHVq5/EBqM6vMuV1IcYQuzO5H+6f7FWnRV
         mv9XKZJLFzEAlvSWosINcjLYc4ykU5P2Tv6vDBuYb7LFZgtiBfiZCdJOT3a1na3aFB+y
         HylpWhqwlOoJ9y+u7Kv13Og5Xq55+H0JIUwmYCOOyaSQb2IhJT/NAApGGB7O0Ux6k2po
         bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050914; x=1752655714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As+iZdwgIfJIachU2kJw0qfJ3dIIY6BahSxZStPrJ2c=;
        b=b71UE445OhtnzZxbYvL+qWZKkCj0atdtaZq5XrozOpYGd50h3pTwnPZtKgQ+jUYyxa
         uqdOpwaKMYVdi85I4Sugo+CcsDCWrRu7SHJGiEX+ZI1kgSluPm8AAnWP3H8F/sxtzFhz
         wEIhRsEAwIX/o4C+njVPQ7vJ/ttO2pRvAVnYpY/2EFW3rpIMVmv29KH0U2HjwNz4we+H
         hsdZcf3UtAIWnp/D0HuWXC48vlcdiT4I2PYp7dpcoWN1gMmz5VOeTBFcUIGs9G9A4zjP
         HAg34fCWUgg6bwa1sSWdWImRODn3Xiokm4FyHYVO8NnEIC6czv5saQ1eOqVusJ3/9d72
         hNcA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oSppzUalyG7idJ8Fd2eOIu2S6ZeJe3nkSD8n1TXf5q/3gArI3jFAlXMN/faVxCdK3YLxhk70Ey74Hs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5n/aJXyBavBiDsyxpRvzGVxfOcQEg0mPSEnpY9kVuecM645s
	8JsmpaM66PQ7NBwZ6kf1auLz6Zu8CK9J3RFiC/qrAqA+jLbagZ+9R2jI
X-Gm-Gg: ASbGncv6WTtHGRCdYvMcW9fcX3hXfiIfQrNMJL1Czmu4e/vIGQj7O8q4EdbypwC5XX9
	a3JBqdRkUVBejsTeNxWcorcBTJG4gao6d1ZHzlYa9972asFN8BIvCrCUORDw97rDQLp6Du+YwaV
	YjCHnhZ8us5Do0AiTo1UOdegiUbBcIBD3YZM4GM59XewSGG8NYimYo5gHHZyV9676IHLVwIY4U/
	/dm4wYSv+VLBWLVXHC9vIVwHmBLT7Wf2dJyq+2aObIiGuFvMfM+G86SS2wDq7WqG0kKgWrM9nQY
	mlOj3zobIBDdAuqrxOBHxcVav1Bq8fS/jXdspbyaIghiIfywQOVdbCvK34Rq7T1Qkf06DKQ1NwE
	bfNVxEbCjU1cOLveDtqPFJQ+OAOCdqHyvaR/Bvw==
X-Google-Smtp-Source: AGHT+IEEFgTDRjfUr+HWV493/GshiFRMSLrjmfFDMULM9BFHJ8VPgLkYu8qkG+cn2QM2bj02N3U6cg==
X-Received: by 2002:a05:651c:2117:b0:32b:3689:8d80 with SMTP id 38308e7fff4ca-32f48519358mr4615561fa.18.1752050914038;
        Wed, 09 Jul 2025 01:48:34 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:8bd:44ed:dbe:39ab:66f8:7790? ([2a00:1fa0:8bd:44ed:dbe:39ab:66f8:7790])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d8dccsm1904273e87.66.2025.07.09.01.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 01:48:33 -0700 (PDT)
Message-ID: <e1ef050c-9679-4571-a4dc-581bf005dab7@gmail.com>
Date: Wed, 9 Jul 2025 11:48:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: configfs: Fix OOB read on empty string write
To: Xinyu Liu <1171169449@qq.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 katieeliu@tencent.com, security@tencent.com
References: <tencent_B1C9481688D0E95E7362AB2E999DE8048207@qq.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <tencent_B1C9481688D0E95E7362AB2E999DE8048207@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 6:55 AM, Xinyu Liu wrote:

> When writing an empty string to either 'qw_sign' or 'landingPage'
> sysfs attributes, the store functions attempt to access page[l - 1]
> before validating that the length 'l' is greater than zero.
> 
> This patch fixes the vulnerability by adding a check at the beginning
> of os_desc_qw_sign_store() and webusb_landingPage_store() to handle
> the zero-length input case gracefully by returning immediately.
> 
> Signed-off-by: Xinyu Liu <katieeliu@tencent.com>
> ---
>  drivers/usb/gadget/configfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index fba2a56dae97..1bb32d6be9b3 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1064,7 +1064,8 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
>  	struct gadget_info *gi = webusb_item_to_gadget_info(item);
>  	unsigned int bytes_to_strip = 0;
>  	int l = len;
> -

   Why are you removing empty line here?

> +	if (!len)
> +		return len;
>  	if (page[l - 1] == '\n') {
>  		--l;
>  		++bytes_to_strip;
> @@ -1187,7 +1188,8 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
>  {
>  	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
>  	int res, l;
> -

   And here?

> +	if (!len)
> +		return len;
>  	l = min_t(int, len, OS_STRING_QW_SIGN_LEN >> 1);
>  	if (page[l - 1] == '\n')
>  		--l;

MBR, Sergey


