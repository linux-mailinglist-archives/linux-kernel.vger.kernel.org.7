Return-Path: <linux-kernel+bounces-807589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08DB4A685
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD13542F00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4A24166D;
	Tue,  9 Sep 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCVUCu/f"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED90279780
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408671; cv=none; b=M7iFIs7DPU0/neXUbnDeW89bVHsrggO5+btFOv4iCPaF7tdX6vxPF8Yed63i3tsoUaj5vYN+xAqbCt3dHcfwVYj8c99hVM6wnbiIJfXsTRn8uSmqo+mj82eYFxTqVah1EmW1f4ZGxrQRZDdLVs8BtYaz+5fcOExAf0TLcOWH4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408671; c=relaxed/simple;
	bh=npAdt2MXok2VEU//pTwTqp9KnuJyLtKd07PIs+LRgEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu+kcYXfNYzY0mWhxWYubvs232sU/85X4L7Y618I/Az0WRXb6WQhQghtU3cjzfLVdzBkaM45u0fIY6pjAxqemhvVKndPPziAIavxeNMBHj9zMRC1q+Bf3HgNIlgbDGihsKgpYRYMwJnCRn/QlkW55EkRaKZepetDRk7120/YZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCVUCu/f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so2682450f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757408667; x=1758013467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDNp+09RRMXcmw2av/GSmihaAI/fIen6tu2gvQNcAWI=;
        b=JCVUCu/fp6yR1IrNYsHraxRSYx9kTcKv9QiB25AKcJham0grvNt1q7QMn6cjAjNCL3
         XwtH4dUd04XzItNNWYeU+SfSFWn8U2WTmyjrHj8imOiaIO8rYpS4NFN6cLIxtOj37PKv
         UBDKfnZ9KI2NmMqT+8OnGvxSll/pMIQDQqZ7/WV2fDoUzcYNntuxyUDVfrOVEr8PuB9G
         nSRUwsvzosB6RsPMPNe5JGljEXJUJsCeOuf3ReXB5MztxQ1AtQ9YJRdGH1yj98EJlt61
         TYyRAe7JRXTvRTKU86UNA1Eas1wxf0P4kNKKTOTvB5c+9XuY+yiGaOC0jIusngmAh05g
         9jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408667; x=1758013467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDNp+09RRMXcmw2av/GSmihaAI/fIen6tu2gvQNcAWI=;
        b=Tkw+kl5obA0KubGZ9aUtAm05Gj6Gd9w4B7hp0QGBCjiUtPsNDloUXTNAfRRgIZVFQ3
         dO3O5sHj52/MXiL58N2oW2xNJD6drnSjIVMwaTtm9i7rYMKFOYam03/df5QJg0l+Gw+q
         0X9DPS1X/B/Z2pKawPcoWPGDYEDDKo+GMCaMvQLR4J6ERgtM9JblI5YwSiNh8i1+prUK
         5eGpCJilwVEqMC+QDCiM0MqEEAG0sjeqEngRumQrOcqnE8r3LNuKJKPljI36TTbXTcZk
         V61eU8OjCPmTTvZ5urKrQG4rbJ3/jfzcIaxColnGTwTAIAZTzxfczDGn6wmhBcs7hUr9
         0muw==
X-Forwarded-Encrypted: i=1; AJvYcCX5WSQDd4WROE1yPEkduxcfELQGbynybeDrK0FxK7FnqNCCl1GFxVZ2/z3soivCdzsDx7WUcRj9GvpFQS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPDN5lgbrfStaskpR1tY10DZumITJFncqRD19olhh93sUy+qd
	1KkPO6rnY3DX85shYDSaRuixt2ILToodYmp1VPyqgF11zdCI2UpTo/A+B3Fe1GNPrEA=
X-Gm-Gg: ASbGncsGh9zCUi7U5YJLohkT+2f31eMFa88aze3n6AQjKHgdaI985jthVrTeROMPKfx
	m7/+P9CIpvNdIR19i5H9tYS4JtQwmY3m5tIVcoFrF4EOrjgjbB8mUHaz9PioL+xRLdqFrk8Aunb
	o4L6LOc0DSVKVsOU0Y5wUGbiQG6wc/1H2l2bcw8XcP3gjF5ja/RdUbB30uIEOYgPMrSXOrT/bll
	jHHMyZ7SVtlqo0VuXvYClnimRpQ2PBvtfPjNzClI2w7X3DVfh9L6tho6bAEs7fwGpAaz5HlcFZT
	c0Ok63CYfTAt+g4dMxha4NfqXcgzBMDj8y/Jlbtuq4rvx2crK0u7qUv0Pjvu0sPCk6ai926DjGN
	BIssk68kC/JDmkyYO0eHb0bvaQlDMxYQnnn1vFBllAbARjYtMFgG3ybYw5ws8dKRen61cw0MPDe
	NgHxCOEmXVSkrz
X-Google-Smtp-Source: AGHT+IGpok2rbe+PM/m3BufdeCo188/KOxQEw562uyqXa+yKjY0Jrvcfkxzp0puKcXaQ7WzgbjFXkQ==
X-Received: by 2002:a05:6000:420f:b0:3d1:5869:d4c5 with SMTP id ffacd0b85a97d-3e641e3b134mr10268242f8f.17.1757408667499;
        Tue, 09 Sep 2025 02:04:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:545e:637a:28a6:9ede? ([2a05:6e02:1041:c10:545e:637a:28a6:9ede])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm315163425e9.6.2025.09.09.02.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:04:27 -0700 (PDT)
Message-ID: <47d31043-f25c-487d-9676-928f391516ff@linaro.org>
Date: Tue, 9 Sep 2025 11:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
 <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
 <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 09:33, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 05:28:09PM +0200, Daniel Lezcano wrote:
>> On 03/09/2025 13:48, Andy Shevchenko wrote:
>>> On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:

[ ... ]

>>>> +		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);
>>>
>>> 1 >> ?!? Did you want BIT(channel)? Or simply channel != 0?
>>
>> Yeah, BIT(chan->channel) is better
> 
> But is the above a bug in the original proposal or not? I mean one wanted left
> instead of right shift.

It is actually a bug, you are right it should have been left shift

>>>> +	dmaengine_tx_status(info->dma_chan,
>>>> +			    info->cookie, &state);
>>>
>>> Perfectly one line. No return check?
>>
>> Ok, will see if the IIO DMA API has an impact on this portion of code before
>> checking the return code. However, the status is often ignored in the other
>> drivers.
> 
> ...which doesn't mean it's a good example to follow.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

