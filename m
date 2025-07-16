Return-Path: <linux-kernel+bounces-733771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE27B078BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7E63B2CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90426D4D8;
	Wed, 16 Jul 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTHj70jQ"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E520262FF0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677778; cv=none; b=PRZECiHRcAK8dIqv/fYvH3Ny762I//5V722lSyPGjEFIW18wcwS+KGlIC1rTg5S74mqH46xYJfq6KN6ADvyYSXRMl0OS4Rnu3FBqnUSVLSIzuDN0JlG5uhsn6GhsDMLYcjWFeO5dJTFqbxD4ybO4w4G66rlQlpUNwPN7foECXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677778; c=relaxed/simple;
	bh=nMYQIUNNbhxTwKtjAj7dPAqrvTYfVjiLl0qUeBv56e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKwan7Mdz8pSN3XCaQGG4iXBAgjvoSqQscGupIurY2HhwUfqXCIRgwEevWut3Bu2pLPF+jxaVoguhsTv40E0pbqYcThE+635N/ff9CUrZqhKVnfgQxitFCrtfF2oTORHM/82JezehMFtuPV/gmikg1g4n1wKsHvIYeiCAyuQARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTHj70jQ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso43336515ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677775; x=1753282575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUVr6thTEstHKrPJDWmNddZkR2T0nuJlZaUbFO1uHtU=;
        b=QTHj70jQReaTfRtyG8dY3OJPqQvFUD0uknEAbtb1vf62TeLepunSX0R2RVJL7X8X5v
         a+n6f3pwJhLe1hwQhE7mFmFBPpytQSxPvthI0tv2/W7HJU+7SlkQ+7Q/K0nivrbthEvP
         4hS140nZwavwzQa3aBnbX/yDoOUnkq0MvmuEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677775; x=1753282575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVr6thTEstHKrPJDWmNddZkR2T0nuJlZaUbFO1uHtU=;
        b=uv/TVz9/NtzHBXnml2/ZZF1eDadJV1J3cfrXqds3Vj2LUPPlMpgEsS/NsQ16bVXG70
         Dm7h+ElaJBM6w7SCDMYTf0dxCMj6tTUG0NUkJ4ol6jQD8wsfLg9ikzeLsJPRFFesqwC8
         5xx1lHN7sOZIk4BEVCdf23Sxuld7T5skEiVRsvoZr8gBCQucKlMUKeWzTXH2/2XwHR5g
         P2Bu2K7F8sANcR/J412ChMOiE01BB5kXlxcmryOO8QCpHnEjhjB9ZKVCdPT32mEHOJdC
         Jb6wN2gqhmZw/SBFKN7+LPUmvfZMq+M0AhNHM2A6cL9L2mjQPnaCVlkThm9IUNFcoMV+
         7+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX+fTLSJkkxFFmG8Tg95FcJ9xzRStl/q7pJlzqD4I4lfs+ZmvojjvZm479apaSikwrapTdKN3S7VrV6Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+zwV//UqRBJEavqJqkLzo+SrnVcIAJTgJbQ0qmsm4B4zEScn
	jX/gZ3do/TFF3qFQnyfVyzFnr9vfERP++c0P7q2Cm2NN7Yx3YUCWUTjfeewwa6AbHt8=
X-Gm-Gg: ASbGncvzPPESzqw8SdqLW5k+IMJckvFG61iiM92T9f76aWcXp8BoE2dvR7qR0KDfV8K
	h/CF5L/Z/efmSiLBk9ZH8UYW7bvZ75U/+P9Xp/esaUi0ZF6X7ByZRCq2YWHnp2zaAxMwkSTb5tY
	U91qQXDKvSCb7CGHHAhO+RrrPi65bjYM7TK+yLFQhQwKkbv1T4LUe8a0dVHxJVZOdb6eOZIIelO
	qhDY9KJpXnaBz0BwIPsDjZrOfDndq3TfmHFVyrEi5QjuftHyt9ecuaE8IYR1GSYDE+Fy5SwzWwe
	gMXL4IJietwRPL+ahGexZ0Z0pZ/0e70sy3GuRsy8G/r5YfHC51ZSfHigneqpLiNeJA9ThEoM7Cj
	sgSurVwZ9bwD81odVJ7DcGetjtZihYOUsgQ==
X-Google-Smtp-Source: AGHT+IEUsiRokRBvipgW01VTedaC+V39tgfxnOQkDTq4jt3Hr6rMqeQ3rVY4UYjScrCHYSad8Y0i/w==
X-Received: by 2002:a05:6e02:e:b0:3e0:4f30:c951 with SMTP id e9e14a558f8ab-3e282eb1858mr28608415ab.14.1752677775170;
        Wed, 16 Jul 2025 07:56:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556536065sm3075868173.26.2025.07.16.07.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:56:14 -0700 (PDT)
Message-ID: <3f0cc5fa-149d-430d-844b-dba70a485ffd@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:56:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/88] 6.1.146-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.146-rc1.gz
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

