Return-Path: <linux-kernel+bounces-751841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3EB16E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE37563023
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10028FFE3;
	Thu, 31 Jul 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H72m+yrc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C97275844
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952840; cv=none; b=VBPeNCGQaF5yynbVXbape52YDyCWs4gGZlbY1isRBrJ+OXSsLCY5c1UZO10vC8TUvCrnqZH8n07IVio4/0pPBQw9DeZWJ/bUYshiTI2FRCa1vYLjPEf5fbHlLPsoiCJcy0euaS9jJHOmS+VH9ZE4n4cOki4hmH2G4/7wa1iv3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952840; c=relaxed/simple;
	bh=WcDfXVLMMz8sgX9OeZwUfq7M7Rtbqrz5/Fp+VLACIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbKXkldTskCvOeleUxNdfXHCTuUnS8HOGmUqL6UolAUGPkQbXcWC2LR88FV083ebY/FN8xXzkeKQypGPIZm1bMVAnpHpmIcNHJKH2puCBqp3kpObwQShVXfrpBePPMMg12aDMCrdYfPy0UPBqJN0fUITIoBcLN5hgv7SHKOVbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H72m+yrc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so296498a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753952837; x=1754557637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9+jJCHRVMdv8TOL3dTnaLXuCseXbSFSKejYbGwQdjc=;
        b=H72m+yrcsqpi4jsG+QwMeObofFyiYX7ttOm8+J9gXpRPanemwTsBfHXV7h0qbUDn7j
         r9y7iLfvcjs7/OrS9q3pVj7n/0TWnoWTYFU4y0rJIHUcKhxPLrCWjXMbPnKSMYEaAXi+
         vHY51gPw0f/6PC4vemA1cTQAPUEkoChihOC9Lzky8dme/Ak2Ca/9b2fMc2G/bPvj3MWQ
         V/v0P0xCynXzbfEZm6vl+QvME7wxZuDhL1HIkq1pq0TpVV24c51xBUTKVaObUPIy8atD
         WQxFcgfZeK7Hb70n6EQuU0E3Zpd+K9ttPeV42ETqIl177SogsS+8+ljibZXDJXIPqOBG
         oa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952837; x=1754557637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9+jJCHRVMdv8TOL3dTnaLXuCseXbSFSKejYbGwQdjc=;
        b=CrBhQoSVvVQZNZ772Dkw3vUBfheOd9P7oAp/l00Es9UYWME4nOiCLY4ogZQTnhLzz2
         0oDTQhYEzQzFuugs24Sz9clpA9rgkcTfwSe3G64MWHn7GGBKW8UDr54jWJfGC706baED
         iLhOZW0wr7vJiMDPM0pixlD+p5rsCsjVPimXBA3qJsWTnQNPK41tDHSjUNMvoS/gafH9
         JlqIXay4LSpub+QPAWlB9bXcqV9XJYppgghy0EpmJb9y9LS3ufd9Sey9PMMRaN1mbwZk
         Qob6F8ye/RhUyETgqxH0VuBE9BEX0UKM146m6HD+nd81IZIZMMhd9nwtGZ22TZ9Sy/u4
         vufg==
X-Forwarded-Encrypted: i=1; AJvYcCUrEzpzYE5D++AAJXmY2hI2/4nWyv3hQXhh4CrxF1v0bQM6tcKoLilkmPfOCbPKf22aPyyyjQCKOA3hYeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJIl0yDetJ8b63AfrfwB2U/RREkQL96NYLa0GbQcLJzXgPEP3
	gKupM+raBrC5oTyZfxKUwfoBO8qaD+AkB8W1SGkTbDhyHpSlNOYrHa1LdayEThDVoTM=
X-Gm-Gg: ASbGncuu9PS6M+/nZiuQkwFgITP9szTQksghRJlhReb1437P25798iJIu7gexpiEQRr
	rfbzInrFZzSgNhuZpO7QVPEpkuqzbhrE86jTr7UxDyPbJZI30BubRmiZertVpCpLYk4TvoXBLaq
	9fwA13jktDYyGQIju60POV2MNWyUfC5Ha2Hu7xGw3G5aucoLKNeNkxAzdAWf9OPyUNhBoQDAhGl
	To6HRTST0MUOQtoLc335MfjCR0XNTOqbM9x4Eiz9O74fR4wycOdRU63hVlhAITiVcsoUNo/bQWm
	9iZ2nmhRi16rkk/AvbFVvqg9W3SQFtA3Fyqo7aUlt7ABz96pG+es5u3+6v/YOpuj3Q6VMYhVCxM
	JZyZxcO1QrEkLSGGH+0riKsvlDppqXg==
X-Google-Smtp-Source: AGHT+IE997x8nYTycvu/BnY+UyTrfIr0figlCHBXehZMXWgIeEYUDt6OKtoUMSjGpZcVTqZcAvbR1g==
X-Received: by 2002:a05:6402:2802:b0:615:f76:9408 with SMTP id 4fb4d7f45d1cf-6158727399bmr6963737a12.32.1753952836898;
        Thu, 31 Jul 2025 02:07:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7ac0sm797219a12.35.2025.07.31.02.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:07:16 -0700 (PDT)
Message-ID: <61d545dd-c32c-4cc3-94fb-53954eee365b@tuxon.dev>
Date: Thu, 31 Jul 2025 12:07:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
To: "Karumanchi, Vineeth" <vineeth@amd.com>, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
 <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
 <c296f03f-0146-4416-94ca-df262aa359d4@amd.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <c296f03f-0146-4416-94ca-df262aa359d4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.07.2025 11:59, Karumanchi, Vineeth wrote:
> Hi Claudiu,
> 
> Thanks for the review.
> 
> On 7/26/2025 5:55 PM, claudiu beznea (tuxon) wrote:
>>
>>
>> On 7/22/25 18:41, Vineeth Karumanchi wrote:
>>> Implement Time-Aware Traffic Scheduling (TAPRIO) hardware offload for
> 
> <..>
> 
>>
>> as it is used along with conf->num_entries which has size_t type.
>>
>>> +
>>> +    /* Validate queue configuration */
>>> +    if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {
>>
>> Can this happen?
> 
> Yes, GEM in Zynq devices has single queue.

I was asking as it looked to me that this validates the number of queues
the IP supports, which should have already been validated in probe.

> 
> Currently, TAPRIO offload validation depends solely on the presence
> of .ndo_setup_tc. On Zynq-based devices, if the user configures the
> scheduler using tc replace, the operation fails at this point.

I can't see how. That should translate into:

if (1 < 1 || 1 > 8)

which is in the end:

if (0)

Maybe it fails due to some other condition?

> 
> <...>
> 
>>> +    /* All validations passed - proceed with hardware configuration */
>>> +    spin_lock_irqsave(&bp->lock, flags);
>>
>> You can use guard(spinlock_irqsave)(&bp->lock) or
>> scoped_guard(spinlock_irqsave, &bp->lock)
>>
> 
> ok, will leverage scoped_guard(spinlock_irqsave, &bp->lock).
> 
>>> +
>>> +    /* Disable ENST queues if running before configuring */
>>> +    if (gem_readl(bp, ENST_CONTROL))
>>
>> Is this read necessary?
>>
> 
> Not necessary, I thought of disabling only if enabled.
> But, will disable directly.
> 
>>> +        gem_writel(bp, ENST_CONTROL,
>>> +               GENMASK(bp->num_queues - 1, 0) <<
>>> GEM_ENST_DISABLE_QUEUE_OFFSET);
>>
>> This could be replaced by GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you
>> define GEM_ENST_DISABLE_QUEUE_SIZE along with GEM_ENST_DISABLE_QUEUE_OFFSET.
>>
> 
> I can leverage bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET.
> And remove GEM_ENST_ENABLE_QUEUE(hw_q) and GEM_ENST_DISABLE_QUEUE(hw_q)
> implementations.
> 
>>> +
>>> +    for (i = 0; i < conf->num_entries; i++) {
>>> +        queue = &bp->queues[enst_queue[i].queue_id];
>>> +        /* Configure queue timing registers */
>>> +        queue_writel(queue, ENST_START_TIME,
>>> enst_queue[i].start_time_mask);
>>> +        queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
>>> +        queue_writel(queue, ENST_OFF_TIME, enst_queue[i].off_time_bytes);
>>> +    }
>>> +
>>> +    /* Enable ENST for all configured queues in one write */
>>> +    gem_writel(bp, ENST_CONTROL, configured_queues);
>>
>> Can this function be executed while other queues are configured? If so,
>> would the configured_queues contains it (as well as conf)?
>>
> 
> No, the tc add/replace command re-configures all queues, replacing any
> previous setup. Parameters such as START_TIME, ON_TIME, and CYCLE_TIME are
> recalculated based on the new configuration.
> 
>>> +    spin_unlock_irqrestore(&bp->lock, flags);
>>> +
>>> +    netdev_info(ndev, "TAPRIO configuration completed successfully: %lu
>>> entries, %d queues configured\n",
>>> +            conf->num_entries, hweight32(configured_queues));
>>> +
>>> +cleanup:
>>> +    kfree(enst_queue);
>>
>> With the suggestions above, this could be dropped.
>>
> 
> ok.

Please check the documentation pointed by Andrew. With that, my suggestion
here should be dropped.

Thank you,
Claudiu

> 
> 
>> Thank you,
>> Claudiu
>>
>>> +    return err;
>>> +}
>>> +
>>>   static const struct net_device_ops macb_netdev_ops = {
>>>       .ndo_open        = macb_open,
>>>       .ndo_stop        = macb_close,
>>
> 
> Thanks


