Return-Path: <linux-kernel+bounces-751842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B9B16E20
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D6C56377E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446AB291C36;
	Thu, 31 Jul 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WedJKqHi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AE27BF95
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952853; cv=none; b=ijbwHBhbnbxp8meJVGrUpEXslLtl2zBDkUsN9SdWTkpdke9e9VVeI0I8beBd62JyH4TNqoIY3KWyd9v4ewvN3X0znazJjETSB0peRGW+oeWuc2fdzyy2hC3taQJG67Rk/aPURoPkvkmgzVILtmsSEDu+KryBEa05o/Lr5XK3frE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952853; c=relaxed/simple;
	bh=X1kwN4TxmRWzdYqOdxnTc9uBDdqiUjDYqZ/TFo9+BH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxA7SmY/fhDAPFFAQIpHI8yapA8Me/7AWC6CI/Qe+XwHhoCnKOQbVQ972lLlDPn9TsM7vr+XnDY2mpijkFi+3M32/KvaLxTV7/N67gor3MosibDDzdNQ3UTRTFuB+UAyKZnh965jbaexYsU4KoGDenkV6tsvCB5E2KXcaT7bX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WedJKqHi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso1099751a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753952850; x=1754557650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwTiolPuRjB0X7WycrdISjM7D8xvIgiqtSrCy1xiYo=;
        b=WedJKqHiPIL79Mad3WXB7FaDL4PQ+UBv6fKEkw4J0zftsWYJO053xKv02QiP3/wSai
         xJCMMtoXVONNjjoN06eXlCxuruv/roIfBgMwTU4l9etuLMkKMLOC0fxxurOBL1qg/6iK
         DMhL2ly81gSJPGcfp1pBfzt7XAjsqhE4Hao7WJZC/kJD7bXRe4r15ARt6wNPUnws3Hro
         EtCSa/rjeHm3VvCSdDmbrsjaVVT5zlS4rh9nCWfVEkQeAbv7gtYpTOqbGjcR+p/KA2gg
         CFj62EZ0z8FiISx5Lg1fHMeoKUEWLsaUAA0cX2nfvdr/kP0nmfBh2xdu2xSQbX13JOVs
         x9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952850; x=1754557650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwTiolPuRjB0X7WycrdISjM7D8xvIgiqtSrCy1xiYo=;
        b=bfIaxkAiFxN4fCNpbkNLeLIV0jK/jqAAguPqRBcYkZ5apX+rwXJj0tk5vjLbV/il+V
         H+VtfjHrPgucdaKNj7YytiyEcGDbwf3LcWB0qPH/cJSXy22XsR1xjaV3hhtyFOwoS3AC
         eg/seW5/fqH21fMAgcyaxZmTOkVOiZARfbq8OLdPRDWk4QnznqrAgS6NPgYjABT1hSKG
         AtpBsu5biqnj4JpYC0TBgc498mgNa5zUhoL4dhdUBUcn/nNlntiq8ThbuPn0vqB+W/O/
         5yCf5MuStmyzg888b44RemWAXi/utmv0X0GX1eD9349c7fSjnHxmgfopHuz9tsa8xO5B
         M3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU+7ycx6HSu5eh0jPR03h8onRF0ebgqkz0CNtUyQmeThlnoPaw2qH+tJveO4GWwZz0QTpjLmdRemU5BhKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9izTsMApF/3Pc/4i6ddzLgE73Y1cjt+TMr8qeg7y6JWvuh8fE
	+E2lSJj5xJRuAef7PyXubNbLeqYRo4QQ2pf73M2/EjLNcxH1h7U7S/nJxLMt8Z8Wti8=
X-Gm-Gg: ASbGnct9dHazoFYcwXu644+6Lb3246UgV5qbCxArQilngtRkGV30tkVIiGXHCvqWZ34
	5AecpjgiKl9+J1pBK29aglqUJK2IYEIwTjCuZCv9V/omVxR8g66/9Y/1hGPTUWRJN8nNhxyZQvO
	zbhUdYxFN1kjyJnNiLem+4Dsjj926qrSFs9byGReVxEy+VicMZLYbUzTgZ4tHfZZbfo1uidHmjX
	gW5STBkQMfiarK0+M0b0ys+RtEVP6duoeVWAkV0/JpVTQV74hPW5q4PFVKb5pBJH5wsNCT6tBBk
	hZRHuwR+3l2mr5Krzq7BKIXBJkart3LZXq8h3WoWKxAP8uT7EZn3rmQ0NEe0cLOHCIHgSRWSh2R
	KIuuEJ8egtoLKfLC7qLuBpmbKucs7kw==
X-Google-Smtp-Source: AGHT+IF5S+yNfX8PIBxcKUES4hdUNnQZdC3WoBiygEE9/2AzPO8Uz+wNH44HGfFrLs0jY6f3kUBr+w==
X-Received: by 2002:a05:6402:7cc:b0:615:4fdb:2163 with SMTP id 4fb4d7f45d1cf-615871efbd4mr5310229a12.29.1753952850302;
        Thu, 31 Jul 2025 02:07:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm764095a12.25.2025.07.31.02.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:07:29 -0700 (PDT)
Message-ID: <7b4d7b89-a69f-453a-bf9c-d0ccdd12d76e@tuxon.dev>
Date: Thu, 31 Jul 2025 12:07:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload
 command interface
To: "Karumanchi, Vineeth" <vineeth@amd.com>, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
 <8c34af6e-9cd0-4a2a-b49a-823be099df55@tuxon.dev>
 <c810ec30-51fc-427b-b6f5-15c3284c0ef7@amd.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <c810ec30-51fc-427b-b6f5-15c3284c0ef7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.07.2025 12:38, Karumanchi, Vineeth wrote:
> Hi Claudiu,
> 
> 
> On 7/26/2025 5:59 PM, claudiu beznea (tuxon) wrote:
> <...>
>>> +    int err = 0;
>>> +
>>> +    switch (taprio->cmd) {
>>> +    case TAPRIO_CMD_REPLACE:
>>> +        err = macb_taprio_setup_replace(ndev, taprio);
>>> +        break;
>>> +    case TAPRIO_CMD_DESTROY:
>>> +        macb_taprio_destroy(ndev);
>>
>> macb_taprio_setup_replace() along with macb_taprio_destroy() touch HW
>> registers. Could macb_setup_taprio() be called when the interface is
>> runtime suspended?
>>
>>
> 
> Nice catch!
> 
> I will leverage pm_runtime_suspended(&pdev->dev) check before configuring.
> 
>>> +        break;
>>> +    default:
>>> +        err = -EOPNOTSUPP;
>>> +    }
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static int macb_setup_tc(struct net_device *dev, enum tc_setup_type
>>> type, void *type_data)
>>> +{
>>> +    if (!dev || !type_data)
>>> +        return -EINVAL;
>>> +
>>> +    switch (type) {
>>> +    case TC_SETUP_QDISC_TAPRIO:
>>> +        return macb_setup_taprio(dev, type_data);
>>
>> Same here.
>>
>>> +    default:
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +}
>>> +
>>>   static const struct net_device_ops macb_netdev_ops = {
>>>       .ndo_open        = macb_open,
>>>       .ndo_stop        = macb_close,
>>> @@ -4284,6 +4316,7 @@ static const struct net_device_ops macb_netdev_ops
>>> = {
>>>       .ndo_features_check    = macb_features_check,
>>>       .ndo_hwtstamp_set    = macb_hwtstamp_set,
>>>       .ndo_hwtstamp_get    = macb_hwtstamp_get,
>>> +    .ndo_setup_tc        = macb_setup_tc,
>>
>> This patch (or parts of it) should be merged with the previous ones.
>> Otherwise you introduce patches with code that is unused.
>>
> 
> Clubbing all comments on patch organization:
> I see that patch series gets merged into 2 set only.
> 
> 1/6 + 2/6 + 3/6 + 4/6 + 5/6 ==> 1/2
> 6/6 ==> 2/2

That should be good.

Thank you,
Claudiu

> 
> Please let me know your thoughts or suggestions.
> 
> 
> Thanks


