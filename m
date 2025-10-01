Return-Path: <linux-kernel+bounces-839277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F51BB13B1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD84C24AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216327F749;
	Wed,  1 Oct 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShjPxmBT"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023426A0A7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335459; cv=none; b=cln3IfM3UG7gOiieiceBvOeiAIbGznCRsLkfJIi5J7WirV670iP9QT8x8hftFqqOoGRgjPCyxdgqV8ilk54jyFLl+63ib6LfG5YrJpGFePlk92sNLyP34ZUI1K25CcDbMLSFqSWd2MVHPORi9K3ByZUq4peDU+Ugsha58SVcv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335459; c=relaxed/simple;
	bh=42WEIdqkfFBAo1Dv2IyGMKfPr9BeV+nb3loEHQqymqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfHQnm/9ArlUqGa4Vb2+aqTpMEzwyl4fr/sSlt8sJpZ0+DF3o/GOB+81HQw3piHjhs7/eoKV3kFHNEnemiFekP0As3EqgTW5m46A8UZD57TDDTUwXPY4XZEg7jfkUxWuqO+kJiokOniLDbcwR32Q/B1itTtSByjdSYqQXWftiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShjPxmBT; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42d8b15548eso110095ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335457; x=1759940257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te+5NbOWKHS/5qX08a4TSadV7+LggdZYvrui5XC1Ixg=;
        b=ShjPxmBTojb+yE6Ftg2K7Jn4bsobqVuN/uCu+P93cDM7qAe+5CLzEd3KvzOVi9X+5k
         28cIzR0iB9A3BkLDRwnwuRj/phUlgsBi6p8mDjWr6vg2IKd+ZJq/8bws/O3ySCAjfPmn
         y2GaFR2pkGD/0ngwIIy/1QGRir0jaFrQ0QQHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335457; x=1759940257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te+5NbOWKHS/5qX08a4TSadV7+LggdZYvrui5XC1Ixg=;
        b=eygHg6EuxuksJ8E5cGVyKZIl+Ry5YM1Nar5Ga3GwHng4TQ/R6UzDkO90KcYHT4qcXA
         3Y0GzVb/Uac2NGvrY36mp0kZzLzT+Fl1xpdnUl60QqiHigJ4K9pi6w5mHydqSmUbnTfY
         1jxAHhRjLo8fE5S1RCGFZtGLGakeP4/VbM+0cZlktci6KKsfKv5HE7sTyM6dHw07snGg
         wWCXOvQ3ibF3qVEELLCTacrNDjXUy0cP0dtQLmpDpz1nJuH/0GZOrubc4ckF0f62sNly
         dVoJBq4fook1L7anxwsGR9QQNKIHP4qzCYe7qfrzUyVM6tYE2eBYGa6oWRCTvAaltdJA
         KCuA==
X-Forwarded-Encrypted: i=1; AJvYcCV9esaYCBwyN4JDKbqor093Ty2dDT0qjvM4ulM0LJbw7Em9PltV1K5RFM7Fo894YKCAdfcAYt4LGZsB2Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf1HPIa1bmN6nOdQpXypsQkpb7EThJ2nQVAIOqxlQhYGdQgO0
	EUTEUTsDaHQu5UJzz+FJs0EmNilkj512E1HKsJtlAgGc0IRG8CgoEaXWxXHzvoX0YUI=
X-Gm-Gg: ASbGncunC6FrFzyLtyejycg+7OGw4SQvgvvN6B4zS/tYTSTEMWWA9yhrNGH7JQwGJRX
	kRbxTtWYXRKyNDkT3W4mZ2Inh2iWoFFYiXHeL9HwJkQuu+PDD5UYMJ5bpYQs53LzCCY91XuI3B7
	9gyUuwFL+j099jPfN2vs8G8ef5YF01oelk3Z3KAqw3B01/zNuW5IDc0u62tG6W7H5gIR/Wczoup
	gvGEpcJrgrAf8d2mOVkAABh+J1MMZsIbcVX7qXSgNSZe6sg29QXzkQas+e4bxJmC/R/Gzjt2lFn
	NH7YVwSBG9APhzJFO1ja1Jja2XzOv/mVjGzWZfaCTpix5xUb9YWec+KcQQiiUqtugxRsUv5BBjp
	5TR0JioixyL3DI2oQmH+Lh2QdD8rZoLnFzbA9tJgRePcXR0lDVpp3njD8PsA=
X-Google-Smtp-Source: AGHT+IH0excAHZ+jMnE2ocUE86didFlaIgYk6DkZJGEMwQnc3kqU0Y4RCbD9igEPUrB7EaQwDn6QJQ==
X-Received: by 2002:a05:6e02:1c24:b0:429:792a:a8b1 with SMTP id e9e14a558f8ab-42d8161793bmr59555515ab.15.1759335456959;
        Wed, 01 Oct 2025 09:17:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-578cd957c45sm1392409173.34.2025.10.01.09.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:17:36 -0700 (PDT)
Message-ID: <92cf1715-4295-4ef0-b6fd-0774f4fcbf11@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:17:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

