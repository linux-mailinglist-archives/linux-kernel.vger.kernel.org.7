Return-Path: <linux-kernel+bounces-841570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A3BB7ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB861B21A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69A260590;
	Fri,  3 Oct 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivlYDj1/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162C230BDF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511637; cv=none; b=ZUb/fxV0zpaScW7wOloTioxb9KO1ZOcpTXYSpDETqokRBAv3JASYhv7nYGdgfTT4eHjIfiJGgQm6RxwMFc82eC3srUImAhIoIA34tXk4/Hb9oe9Pnn0+q/Ks/qqoDqMBf9JHJD0QicjuU5WAl04E8/2NFX39Bz/6DFbe8n0shAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511637; c=relaxed/simple;
	bh=V2yDQ9t5WRaCCFVniNPFFtjcU+Z93008Qn/4tgTMN9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfVEuQ/xNAFx72AevdFMjLmDsJU3C2WuPZPFHbjppHhOUR6XUL2UkW/GaIr1MKN4ClV5u6F520AGNfReOJOOYwVuu6aTm4j9JADfPTB63ka+j1RS+kyhXiMsmL0khIOomErKQNDqwqfAkPn6HLPKpqEIjEulm6cBoQq2aMbFntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivlYDj1/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781251eec51so2126127b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511635; x=1760116435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9aHct2AGSJyqUdy/hqfaZO5vGD3Tcs42UjzJUIOSD0=;
        b=ivlYDj1/dhFAma/WWtSkFtWQ6jd+0wppWAiwlmEiUpPR9eLGwD540c2O0xlnLazw10
         z5ayio4WIji0JlbaXCrNPjtOlcWcUoO1ksQo8hU66H6UEcmri/S5OiG/3WX7NscKKPgt
         K/uVw89grNFhfpmSMckkGFZOpD+gzS/hpheKOGpR3G7XxtCtSnR3S5DS5bAr/nOgY3bn
         X0pL5ImgLFNwE43PFsABK7lpmD7T8Om4LP+Ubz85VZqg9D2sG/sJN7teExQr6VP/8mmc
         mV2ZkD08dnGpd9N3pyfuFYtSDws5FZNOoViMLGXk6kspDEMQd2jiolYKANroinlG29Y0
         9LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511635; x=1760116435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9aHct2AGSJyqUdy/hqfaZO5vGD3Tcs42UjzJUIOSD0=;
        b=UjFpQ2BIxqRDa+8/f15AKBt2BST8BpASuDxS4x1v7j3bhayoz9OjfYtqSfFe6u7LWE
         fL/bxVVqxXGv8JnM0nc9g19fCiVCSqsCbq4lCTRKuIVu2AiKML4gY5pWhWPgTb5Oy6ic
         Y6iJNLGlMMqUQWcijlvAUdgRYWy23JThEPT0lZe+NNLf70xFIeGHMqw+hcN1pIMp91+I
         j2YIJoemctv++Rjwl9NlwocRagWR93Flfaigmy8DQG10LWMrwTlXK6RxQ4Ur3PUL5jUN
         DhQMG/VqXyONDKT2n2r9hZHA/Fgmi3JYE+iNzpXhX8NOyLD/Fg97NpZfxRMui2LCRah4
         gOZw==
X-Forwarded-Encrypted: i=1; AJvYcCW8oYxi7PS1Gihs6pOfbBCC+6X4FPwOzVZJAbZweQrJcvSGR2A5O1cypEzxeq0O7fD878L9V9JpyFhL5ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8Ew3O/OcgAJB3I2ly1msez/K4oCTdEfkU3KDyeKvZ6wlA+K5
	fokVpWfdFTwyJOVi74NMDVpHB8iBMlXlvp1k90MNP+vCHIHRUGvgCCot
X-Gm-Gg: ASbGnctJJZrHU0NQRvEcRnqWhNshC5hyC0chuVuyBqONBUJlAMiPRILUGMGNt0aE6+f
	EmNYzEKJg7KLS+b8C1BndNNl1juL8KmpeVv/q56wcROuRNKjHARTsDidCrGQPtq1OjyD6jO/v3/
	rvrSwTU8n2LiDFrjTCZWZonOY4MXZMXat5mACw6MqqwZb3Ce4J+kifOUci/t+ZcZv1faLkW8/a2
	HpTTYP6qlxRvHe36/0QvVfGRJhynx44hIeYAW/2JpiNpFtn5L1/PX8rTXOB/bgG4qshdevJLLV/
	xVwJjfu0oIii4z0deqPHJGPh8XCwelZl43OotCwrvH8iNI3mEtjL534800HQmPbYoxTNqTK3Gyv
	tgNL8S0p/CWV7xp303NOQJ/TUYCc2vhkHrKzs5HH1Flijikunq06BvB89Wzkeqq5AVYHZd1D+i0
	ERuPb3C8qkO1Mv
X-Google-Smtp-Source: AGHT+IGYxcu/7m4cInBmVlBcaknFm26QdLjuVZE24mLFzQf4XQmV94nPh21u2/AfgdOkqw3I9aKJhg==
X-Received: by 2002:a05:6a20:6a28:b0:2f0:4f71:c478 with SMTP id adf61e73a8af0-32b620d8f50mr5346720637.46.1759511635156;
        Fri, 03 Oct 2025 10:13:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0209005asm5517750b3a.81.2025.10.03.10.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:13:54 -0700 (PDT)
Message-ID: <f9c844f3-fc5a-4e66-8547-754f73e33af1@gmail.com>
Date: Fri, 3 Oct 2025 10:13:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


