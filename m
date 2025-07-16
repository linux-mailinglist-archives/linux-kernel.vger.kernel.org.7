Return-Path: <linux-kernel+bounces-733761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC7AB078A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433033AB05E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D72F50B1;
	Wed, 16 Jul 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWKtPoKX"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E62673A5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677495; cv=none; b=r0OUde5oSrNfdyC2WgHUtnbl/sRY9Zee0m2nCq/Tdmtvwt0NAQ7bxDpCcCWtSp9e1Sj/kz0c0nn+KfA2DuxsWGLkMcs9Zdgc6bwUt7UxAh0wdlxtdWLVrg975mVRnA2z2RBVSTkJLP1gwCN3t2/+UEll0A4aa2ULVPKwcS8/kM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677495; c=relaxed/simple;
	bh=ykpYMgCTCP5IA6crj9QAcn4gLod+08HVDpTkohc2frU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUh3ZsAW/DT7tyYVtsvFi8rKmalXhmTyABS7ckRWaScFQMKWyhUUaK14Q8I+86Lt4ZlJC6DNDaiJb6YNbOk3loHE8y2UDakYpaIRZ9NMxPOl46Iyb1BDSzTUPzRsBZqCvFwZ7PKbH4yCM5a/utKyn8yY0jTqb7NBipMBPjc+TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWKtPoKX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e13a58191eso56758585ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677492; x=1753282292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ4fgAdCXaMF+X8p3B+OtFN3EJU615/xlwO/KEG8q1E=;
        b=YWKtPoKXZ3Vde6eL7MndhJktHiShRpDDOB1qChT9cFdjqKjCW8ve9tQvd8D87V/ykA
         dhryQLQ4JK/SLv2GdrwLlOJnfwMT5W7GHwMYkXUYaE7Y/IJLQHgbaIvQwLWY1O2sTcTp
         J3CwtCrLVOFswyTRUpqmEwPKXvvG98KW2vwPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677492; x=1753282292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ4fgAdCXaMF+X8p3B+OtFN3EJU615/xlwO/KEG8q1E=;
        b=QxTpown7WDjAYsfIrt9da3fVy1QU2FpcNY1Opn6N5OL9m1E2Dlv94UTfYkJK+6PLl/
         87CU8cwii/+5fUMvktgRgXQUxEuh9cTg62CRS8DfUtFxZmYTTXfNMLZ5wvT7gqYC8JTv
         kmbDThNIUoQIAg0LMsOu5okMF3G88IlbfiEW5e9yI5W+gLfoVY810Rp+aoV7W3XK7P/7
         LOVQSCH2hwahhwHU3Mk2Oa+WT/6rB9f8p8CcuJoQkSsFFLeS27EP7dvbAFKYzhyF9cm+
         /tWTzi/c5GkQTdQM2bW5/Z35IplyzaFpclmPB5yEPKnRnQcjiN4AqQxD2SgrWh81uN3D
         563Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDySSR2USC5A3InhErxFPPO69ovxYOsj5yz/KZRaO7U4j1BxiushuFXdajEbVJB0qsyhKF/fs3bHt15xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeECW3JxDfMt0rcSPEqIfFdVjyAylc0857xtjbo86tuCoPYJI
	dSOW6oM8CftuGA0GeYXW6jYs7dqlVD26dxGuAwPmr8SpB+BPffI0OOy2+AAMrngFVaI=
X-Gm-Gg: ASbGncuHNnBxWtejRLAJEjCTGbZa1mTyP5c/HxoLSJUrFe+BKwi3x/DF4IG90q4PKic
	OOt6AtCkQHg7U4Z6io+hTFs7QXbviCIvBUZzpNbUPahpelhLYebQ0RTMYBZAvBczC4NSAcNB9FY
	m8eLX+FoqxGSvhTZhy9enLTC3LQk7pHdgipt5bQ2oUrFVNJJTG49cnZYlVfJv9L1HiUq1rl2qQW
	bNwUTO3s7NkaOS6BQkW/Hk+ZsXf2Ne+38da2Mmb/j7ih+P92eGqupUlZBdYqm9PhFMGrPZo1A8H
	ZHQ701dadlXnKv9HFqBCUgApFF37Fz6SD1w8a5QqltniAHNN43uOgNdvU4kJHHhj3yvlRXZ6hdh
	LcS6C7B5MCxQSk5B4o/HPJAEnGleKLC1Spg==
X-Google-Smtp-Source: AGHT+IH2P5ahWBwNlpCIsyRgQhzxMyn4xcRyAWIOS7heh/HEDYEdDgo3ckJ9w7dS/5M/k73/Vil5rQ==
X-Received: by 2002:a92:cd03:0:b0:3dd:ce9b:aa17 with SMTP id e9e14a558f8ab-3e28251fdb3mr29219435ab.20.1752677491760;
        Wed, 16 Jul 2025 07:51:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620aad0sm44817485ab.34.2025.07.16.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:51:31 -0700 (PDT)
Message-ID: <a5582e62-274b-4c61-a9fe-9b7ad0b87970@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:51:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/163] 6.12.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.39-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

