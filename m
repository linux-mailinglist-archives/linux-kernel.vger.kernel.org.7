Return-Path: <linux-kernel+bounces-853139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF7BDAB91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02356403067
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13B2877E3;
	Tue, 14 Oct 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pz016Vad"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A6302761
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461111; cv=none; b=k+rY6GP5Z0WcyCzu1wWiaT+2XnrCnmD9MWVSugBTR3/HdmazGZ6Suxb/GNnMdOMqH1UPKP80rCZwkoWom1DJCPQ2DlRPCMIB65pHW41T6zs/HOv06r+N8VDdDqx8W+dfgdjlhFvFVX5/3abcRaYyF9EJCcs6g9UoNGSWASdsE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461111; c=relaxed/simple;
	bh=YsyUZHgi1wpE/vvikQRglq+UzixFkapYZ/q1X/Cvgvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrDoKMuj674RJL5GWsV9lWVFVZRqNMzeWLbce8Uh8Wm7kxCy4YB+0rHntCdFjPrTULov21nK2aUFAizU9Z9XvCtxTxuxD3HipASi2jScn5Ht+ArdzI9pB3n7MHO5cbhsVustRE36VtYudwIyPCX4IsIgxbly4PwjlGupftWKdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pz016Vad; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9194a0241aaso211799739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760461109; x=1761065909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uv1jmh2eVmOSopdUqtY+w8Wv8v5i6enZZ9ZLD535XmM=;
        b=Pz016VadKeqX6h0q61li9LvHotGJ5c8iwMK0L7/J7LkMBtb5OgWmJBNDaOiRJDhJz9
         BVFaJ5euH7T1cEWcASANOmCLQamYIOgZSAHVxBWmuw/x3gzdh8nktjdjOb2DiOqTYkNg
         puoCRzlTrMsc0TWaZThOQwHdFIMiUWb3KGqvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461109; x=1761065909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv1jmh2eVmOSopdUqtY+w8Wv8v5i6enZZ9ZLD535XmM=;
        b=wVmMjsoJkRHiIn9h0kuo+EY+ceA8em5+2Tc8ntwTvXMAaPj54yGIs3YvKdQwuXgs3U
         OGErzUPzOVOyO4EYzWZdmAxPUmqx9j7lP1bKmYr/I2HJavjaGKKrcxb6zItt54rf9Iy/
         ANsrPUmWdpHm4GXP+gIOac8WxjCEN6iyqnUglCBEedl2BFR+G35asoQ01ZnFuH0AY3Wu
         fxa2OL4bWVKw0FTQruaDV64C4y+7Wx+qI6dMW3RML9/QPbIN3syuC3oYPL9qjBat4KOq
         Nh9MIe5t8/y6Ka/o28lKcG9iHospNNi/1UDhtch4V+22O0UyEXz6FXlELUvCDCK6M4Xm
         zrEA==
X-Forwarded-Encrypted: i=1; AJvYcCUo2BMqJwCLQgUDE4cJ9H/fOMe4tE1OdtB4St0qF8d7R7e1jgRtiL6lnO+fVhbDbv3rXuXVZaNy15rdb7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGOSC8IJeg3gTQAMg4it3NjBlUi5Qgvm0qnyeBzKrNIogx2hs
	0CrNueICtYTyHayyyh39wYLmMkgI6EX1gnPg59xR0NFUQBHdxk8F4gmS0TZLpGMLdEY=
X-Gm-Gg: ASbGncsslov7OxIPFj9szR8xULIagWc+hG1KbqDpBnj+Iv6s0Te78Ge2Lumv9MmjXId
	+LOS0JOmxCevAdJmj4Kc+xiBdcrAByuCzCgiVCwN/+X6vE9W73oLDnb/xtvDH1jWUv2Y6CRFORl
	xipR9IIKwnWu0pvl0kLwj6dDFTrihJBPAslxEqd0QApA+EUCd2o2fFxM9VBIDZB/UTloCASrPTg
	FMCbcZoguYZ+x6a0eQO6gn09ScT3p0H1xd9ndS++6Ut1d4695T8xBL12U37+lFtoUXHci+3nHnb
	QDJBU9Zby8mnFJaI5TWCWcH4JavMnltpaZE0+L5A9VoDo4ltAviKwtWl7TnjpLN4vn5vGeG2+3f
	B0sguhLaQNVzt2ipKEZ2DTdcjbc2fOMJd0Vo0JZtaZdsvPkuH8bmlDwDhoCCrcK//U9a9ddkVDu
	o=
X-Google-Smtp-Source: AGHT+IEpt/iipPZMrqhw1wAspnajPgF214RYw1OdoUghqLh/7sXAtLGEGZrEJbe94Pt4al96RJkdQg==
X-Received: by 2002:a05:6602:29d2:b0:8a6:e722:a9e8 with SMTP id ca18e2360f4ac-93bd189ad24mr3241436639f.6.1760461108974;
        Tue, 14 Oct 2025 09:58:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a63c81sm487119339f.18.2025.10.14.09.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:58:28 -0700 (PDT)
Message-ID: <1263d6cd-f9a8-4558-9c59-57f9b5503473@linuxfoundation.org>
Date: Tue, 14 Oct 2025 10:58:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

