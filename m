Return-Path: <linux-kernel+bounces-806880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E89B49D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96791B2762A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA72ECEAC;
	Mon,  8 Sep 2025 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="db29rrud"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8082DCBE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371271; cv=none; b=E82fvafk0v+zIcrjOkkYEtMg/5g05ZbO0YlPy8Yc6A8ZknGFBEGdFQURo0KsZZRtbLiBku1bx474DFG+jgwm/hLlsE9/EWnjJdRsHkclWKsLGUaNbLdaLY949OI5V37cvNyxPb6U3SIkC90zSbG+HcGaseUMh6Nad6QPA5vy6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371271; c=relaxed/simple;
	bh=fSqFCqqM3AfsbXjLxbGREr5s7O84Qb4Z6tn5ZtnOX+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLCV26QRwpwI3/g8diKH0Pp4BInJ/TT6+cKYzsdZPh+z6EGhcOJqyEnKFlJo/F4xP1ZCxxfPKmRHPf33pNAcVKmZ0V+snPO0PShLoXNiw6yyvx8OiVTaNr40Nyx6Alzg+FAfLVNiAMGekGQv10XnepDP8fXNOhYVz+SMbbqZTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=db29rrud; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-40b035b23c6so5646045ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371269; x=1757976069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68HWy37O10tqXYXKmGukX5WuN1MUrjL9lhDEm4zk/jk=;
        b=db29rrudK4SDjPl66cmsSi9HxLFiwW6eFeq+FQCnBBAomGdS+9N3v2pvQt0M2UKeeK
         qp4/jWHncluDuYUSaXgelQsV1hFS7bwAgo69t1ONpdBMbkiix3sn3hx6wfkZkvLP8vmn
         Czt5d7h/mVhVxmc5pwBnX5BgEH0Hwwe63f89c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371269; x=1757976069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68HWy37O10tqXYXKmGukX5WuN1MUrjL9lhDEm4zk/jk=;
        b=k/1WVufn16wyILu8yjGdyN+stU0OVnvcmA3poExEAmJUaqXmfRLUxmuRy9BBPnfsXi
         cUFa/KPANU7qFvEplzfxzoX9yWsXDJrvNxSADCRAb4BxEumW07uS4ON5syF8eFMMjlZQ
         l4Xiynzz+bFWHOTLb/sKTTSiNJPFgrtakuctwpj0lSVDYrMXjlrd6zW+Y3w3FKCMdmwq
         8DQilCXtyO6Yf2Voz/LEL2/AchYAiR2NV8JvTjfOg9XN7MPrGCGG9tDp2IFz69n2q9hB
         q3ELnNHHh6Yrulv4rESKeVoyn6F51x6JrnI3G25M9+Y4ObipS0vvJXbPzSIXX6Algbm6
         O5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzMiS/oDubYSZjeGwykjIVjH02nsEDwwGCyg8Ikb9lreByj5O7wXE0fUC1isYqQZLvNRQHdwCLk04Kjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lPrjstRy5VXGKTwVuU07c7sxi3J8yRgZIEFxHbgrxoOC3h0w
	fs3zd3BDaaO+lxQL8NUl/tHDkmry0aZp7LrnrJQhrtsYr0+Rdjw+OHfHwwP60ac2tUE=
X-Gm-Gg: ASbGncvtoZWpHlufNf00dTMGcVoNCFZF5WL2FirHEQIzE34WZCQjp6ZuWfLHTcr6tAa
	ZR5GoXL5s97GYtlXs8XTV4wQwFIDbsAFhIfWkdrGBr5EYi0nUF66hd7dWvRQD7pz4ePiFbejmYa
	XAFmvUYtsDgnFUHMsrz1T/dnk9n0xatAHtNf5U6/Xyh4+lq4m3gJ1ixAltRMRxjz+Cqdkdez6TT
	PUN5bv4v94kb3dJ3QmcYLAy96+ELGYPkGBWpA1Et2kDQqORe1QYdptQe5eLg77wDF3hafkpiBq7
	1Z1HQM9MR5zWo1VZT5A1XjNTETgE1jC5vYnryp/tJpaWtqSfUSJ6azgiUVQdEB/oXuAzjWTYOep
	tJBo4yDmdTvJfKgb/CT25hJiJJy5Yz3ak798=
X-Google-Smtp-Source: AGHT+IFWCsaTSHUpmf8Cx1hvBeqVbtqoKD11vWy//iwDgAihm5QVuVHARPtrG8fFcTTACW6fAA4FvA==
X-Received: by 2002:a05:6e02:1d86:b0:3f2:9ebc:ddfa with SMTP id e9e14a558f8ab-3fd7e252fc6mr118637925ab.7.1757371268960;
        Mon, 08 Sep 2025 15:41:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4007fc6c9bcsm28400385ab.14.2025.09.08.15.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:41:08 -0700 (PDT)
Message-ID: <1d872101-6e5d-41c2-81da-db7dadc6484b@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:41:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.105-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

