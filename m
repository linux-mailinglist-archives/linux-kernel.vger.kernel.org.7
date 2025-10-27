Return-Path: <linux-kernel+bounces-872574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF1C117C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA12B1A63167
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53932861E;
	Mon, 27 Oct 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXutbyWa"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D273323403
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599411; cv=none; b=Of+efa50Q1qm9G5fbivBs96L3IE+N7h3PbnkOgqWSSu7lmfZ1mHXmdSpIhEDf7muzVE9be+GYZ2NG12XlAtGEBlYT6MiN2QCRhNjoBny0OVS30g3meZvBbdU9XbxKYUmeSTaRilOTwYn8ETkUx2tAN7x7Vs8n5MUktTdNXZLxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599411; c=relaxed/simple;
	bh=DWnX1zOzPhdonNNHjblxPaHF1bDlcTCehEAK+AuBlz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYNgzjLeqzqxJMXWbrNasLxiAuk7c4ojXhZCjdYPB+SOEckXhV0LMl0nNfCvHQZDgT8HHIcU24DZyG8jf9TEluOjXh0HZpEkHfDwjWMCYgWvVfc7ZpyaaY4D75UJrgaj871EZbTO1K6bYQg1f/NbpctAZ9US1QQVHD8Yst2UlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXutbyWa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af743c232so4741811b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761599409; x=1762204209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2e588IPpQNnTE/fdefFVwu578KcqtJc5SaJtmTlNKd4=;
        b=VXutbyWanvs2QyGJiw7wDAUA6VZmCO21vWXhm/IUoq3GfOzwTAQnRO7/uSuD5Bmlh1
         ETcgext6dChYTGVsqR/rQ6gVx0ToM12yT3TVTDN7f9vY3hskAhtfH4S9HLXZ+pY6ihRi
         dqbmEUfnBXjWmlPIIuOzK+OGBHTPOdAN38arHN+kA52BxYSegTYycfrz/hYtVahntbpH
         Lb96LrgRrTIhqWZF7U5QM44nWjYLqOrDE6eCNfqIHu1Sbrf8eqkdY/BTPYeLP+ceqMdc
         K8IbK+pIIvNvkMWaF1ZUHGykfMg6ND4PICGQtoSGSbELppIWdWCM8x+Z+26zG5wdPtpX
         RFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599409; x=1762204209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e588IPpQNnTE/fdefFVwu578KcqtJc5SaJtmTlNKd4=;
        b=UoGItAuaQiEMHLi2FzvQ/81CnTgtKWClZUTXo89/TPAFWK++5vV+gZoNo/uGNFJJRa
         CxSohqOR9joStER5hpvBPoxwdMaLXUjGF8JmRaavDZ+wuJHAJ9q+lgE1sKXL92+l4fTS
         pTE95kluKg/LP+80uIWS2NOXYW6Z1KOjOqAFTlm2ablLU/csB6X6Pj7/1HdTXxL1a3AY
         ig7p3TqMvYV4xGWTHsSteAV43bp9lMDRCs71FZQQNDAjwBPoG77Ulqa5FnXYxvgDA1x3
         hFf8ahJHWFjJtmMt0CCkNlRfT5ujmoDyQ1ID6B7U0ikLxZCBaxErdF2jvxTvvBsJBjlr
         OEHA==
X-Forwarded-Encrypted: i=1; AJvYcCVceYuWyK9/ARi6IYxTXiiOJxhv5qHcR5oi2XgQ/Ifj4KXFGMVr8ZXgpaXifXom+LzFVQNnD+ImbmuUe4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh743ru5Wk/07SafLvWLbpnZL/1/oM/8ZU6j1FJrjpxQNyeNKE
	hKcT+ocQQ+neRG/PQOJyUfYjZdFlfu8pJzWdx6EuxNGAmSNhr3b9fgyb
X-Gm-Gg: ASbGncvNAwqLP7gh8XUfeXZeYVnzxMQKKwbWJxnzd89FGKIuKA+GcwA45UOsg3Y8k/u
	gDCQz2GdxGx+2P/HaAzLbrSmptdbz4IMn5M9ae/QvehNylU9n5hHIRu06zFhLJbkeBRi2U3ZEXh
	RltwOjjqz/wVJ12FrUPz0U4bNEYY6w8zV9WAVuFqIS5gmMRcztYiK15YP38XK9Oj8iyNt454dO0
	APZHUExzNGW+Sdn+xAQBUD4wkPYNUgNBdM8ut+jXESKdEgG1lDipxXYwQZDVfn0EMAj+sc60q9O
	eXKyf9ny2ZMA8gUukZBgnI9tTj/7N4d8M1Y+Ae3ptbP07mIuTu/2EbRObivnWQGbHQXm2ru5npe
	oLBjrKqwkqpT5tR3fT10QA+psJUo3xKcYnoFZR+4UeEz8PFiyVz8Snjs7Bjrk+3uF2w3U4UYxSd
	PxWQPdzHvs6xDsnvkmAzp/MQ4CUVI=
X-Google-Smtp-Source: AGHT+IGAcXx8rnRjjfBbyvkfw7eeVqpM0QJvdpLkgNwEN8JNPyBVKydtR6Di4SIU3+wjvCHp1ZaLog==
X-Received: by 2002:a17:903:32cc:b0:290:c317:a34e with SMTP id d9443c01a7336-294cb3dba25mr11873225ad.25.1761599409461;
        Mon, 27 Oct 2025 14:10:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9f9asm9559753a91.11.2025.10.27.14.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:10:08 -0700 (PDT)
Message-ID: <70c3a401-3fa4-47b4-b8ea-a8e5ca75dcc6@gmail.com>
Date: Mon, 27 Oct 2025 14:10:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

