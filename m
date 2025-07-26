Return-Path: <linux-kernel+bounces-746834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB8B12BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBFC4E620C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDC288521;
	Sat, 26 Jul 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="tus2HBMB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E7635
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552817; cv=none; b=MPKAW7iTn/Xew/Od0/V14AJLqRiKuzM+0YwQbfyOiIdtn4yvoTd1Qf5YW29xAOXcKNgoHlwkeRgK9PUyzAO5WQWJR9cpWY0MTE47nRDcWKG0DcVW+s9IyZtfkGk0U6uueNrc2ULxg8/EPRt5cteuBnshTxeEc0635IYfCoUrVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552817; c=relaxed/simple;
	bh=yvcRHhXuYyD4nYec3hWl6gxmG7DKCLk6OOfx+dctTQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAgphfavGfkS5vH+Dty/SVjW4JW+GVC4qMgV/SwPb9404wmffTmdRFTpoNpSYIMwIRZj6eOYKQjAY9Odm/IdI2QU3a/wzPQZ+725pOSDY7xDj1qbx9S9xaRduj1i3+XCB5EaHdcISUdSqwh04n4MRSBbrQPyhAI1iSrtLmBcGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=tus2HBMB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456108bf94bso19003755e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1753552812; x=1754157612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvcRHhXuYyD4nYec3hWl6gxmG7DKCLk6OOfx+dctTQc=;
        b=tus2HBMBku01iiKI2US7H3d6MuUDuJXPlnWVF4b9XTSfkBEN7cd40NSgzoPxnui+6E
         UMNJPS0XXg2arKHV6k9EYYlND/acVc4P/egn0osh7B4GGu9prtc+d0bFPs8mOuWG+Hr2
         +cSpzaSi+vUX2UegoMuP2ZNug1qa51hki7qjJt1hgqJ1Mhm8DRLgP8qRu4j4hkpTw6jZ
         yi8XvjA/COj9p1SWeTSKzwiWo/yoZLzvKbr9C53Azu50s1ygM3Vx+VkIWpELvXjoBYVO
         ZBQfeNsWJhU8npsFtRipiwBToAr8i1Oo58lQjuL11/93lsegF9XlbQ08J50S1GZoDtVg
         CdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552812; x=1754157612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvcRHhXuYyD4nYec3hWl6gxmG7DKCLk6OOfx+dctTQc=;
        b=ulMmBAo3kE3mtom3+dUZml6VxCNT7pogLt+4nOKMIif/AIuz8zTKvT/YDxpASbUnHO
         x+vDiAiFHpZkKIU+YRxKaAmjkjkAursP+TYiC/uIzitR3vYbwMK2NxGPVpcmHd85P4Eg
         aaHxoCnYIMRL6CuIXAke2KEGRoASIZSYckTFW9+nrRnqkkzWe9EYysaXQYxvxUWavd/g
         WxMYd/x7qqmHdSkDkXJ+tJzdNfFGArnfVm8etjQfPqzwEQwfMGuZJqPltdLwPiFDqv2s
         xm34bL8IRtdUyIWyP20+3D0vbt/CDK7JFt5pWwqu8zoMONFeUWEc48g6qEfOwpmTNTTj
         y5qg==
X-Forwarded-Encrypted: i=1; AJvYcCVHw0mLn+3iVPKtYxc4F52BMK/bNvv6/jPN7vd8QBdDqjhqpx+D1GoDLdKla8duq8RilaIDIOLCF52rqhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkp/L7RJaGdwJolQoJMVoL8P6aBlBDhLHTllaS3cMBhDeO+Wg
	vCbkMxi2ynMcCj/EGwtGo/t2doF9110PUB+BqZW+uelapeHT6Ns8s2BXTw0kNaRgNBU=
X-Gm-Gg: ASbGncvcKduZJ5oe5nKVw1sho55ZVnMqy580jT5f38rIpWvjuZWESPBix+VicGVT0nV
	WMA1wYFjHcJmzJB5nAyUv6384ZKhtX6eqgWFEKBBKp1qriK1bRciEVDrjnEwuYPAq+CdkmHPpB8
	06V657MydSxPYxCrbMGfe51oX6YyBUbcpGPdO+9UHO1Z4+gSMaclC70fkJwkZ4OGFyIMnsKY/8W
	31EJNuG6bv07ordteo2N+CiEb6u8SSl5urrRNIpKtdSjggZuVglJhDW7pzF+fDvzEL8aVLrNRY2
	dGfcE6htuQKr847S1X/npgT9YSSQo0bKcfxkk6QPIwqq9OCL0iMMZfzCR7MbPxUyk+KpKbwVHcj
	AGIZj1I0zMC2JV3V37hj1ohQ+gxoOZH2DmSnI+Y5fX1zV3I4nzNtrSPFSAYG19xrsZ0gJjRrk+3
	DRtUPI3ow1sjpF
X-Google-Smtp-Source: AGHT+IEflhfEaAlph6QytLsmeVZzt9JsNjEPC6m2JqYaPbPelQ7eBKZoO5O6AvlWzFTa4x0V7hT1Cw==
X-Received: by 2002:a05:600c:3514:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-4587667a7b4mr43141945e9.33.1753552812037;
        Sat, 26 Jul 2025 11:00:12 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:49d0:43d5:5891:26ac? ([2a02:1807:2a00:3400:49d0:43d5:5891:26ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac58045sm37621935e9.22.2025.07.26.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 11:00:11 -0700 (PDT)
Message-ID: <a9acf284-d55c-4c8e-9f34-c2feb26a446b@hammernet.be>
Date: Sat, 26 Jul 2025 20:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: spacemit: fix resource leak in
 spacemit_ccu_reset_register
To: Alex Elder <elder@ieee.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, sboyd@kernel.org,
 dlan@gentoo.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250723132504.66273-1-hendrik.hamerlinck@hammernet.be>
 <ed5fcfec-6330-46e8-a302-5cf1d8b3a9ce@wanadoo.fr>
 <d968eb77-50f2-4d28-a57a-112c87dff8bf@ieee.org>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <d968eb77-50f2-4d28-a57a-112c87dff8bf@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/26/25 14:57, Alex Elder wrote:
> On 7/26/25 4:16 AM, Christophe JAILLET wrote:
>> Le 23/07/2025 à 15:25, Hendrik Hamerlinck a écrit :
>>> The function spacemit_ccu_reset_register() allocates memory for an
>>> auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
>>> these resources, resulting in leaks.
>>>
>>> Fix this by using the appropriate error handling path.
>>>
>>> Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
>>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>>> Reviewed-by: Yixun Lan <dlan@gentoo.org>
>>> ---
>>> Changes in v2:
>>> - Properly place the Fixes tip.
>>> ---
>>>   drivers/clk/spacemit/ccu-k1.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu- k1.c
>>> index 65e6de030717..5bb85e32c6cf 100644
>>> --- a/drivers/clk/spacemit/ccu-k1.c
>>> +++ b/drivers/clk/spacemit/ccu-k1.c
>>> @@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct device *dev,
>>>       ret = auxiliary_device_add(adev);
>>>       if (ret) {
>>>           auxiliary_device_uninit(adev);
>>> -        return ret;
>>> +        goto err_free_aux_id;
>>>       }
>>>       return devm_add_action_or_reset(dev, spacemit_adev_unregister, adev);
>>
>>
>> Hi,
>>
>> I'm not sure this is correct.
>
> I'm sure this patch is incorrect, and the original code did
> not have the stated problem.  Thank you for calling attention
> to this Christophe.
>
> Stephen, could you please revert your commit of this patch?
>
> Thank you.
>
>                     -Alex
>
My apologies, I am terribly sorry for this mistake. I was convinced that
this was a leak but was not thorough enough in checking it.

Thank you for catching this issue in time. I will make sure to be more
careful in the future. Sorry for your troubles on this.

Kind regards,
Hendrik


