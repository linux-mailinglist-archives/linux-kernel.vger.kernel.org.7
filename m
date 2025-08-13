Return-Path: <linux-kernel+bounces-766937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC6B24CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D73B507E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F862F83B4;
	Wed, 13 Aug 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N161Xgcq"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A52F83BF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097640; cv=none; b=ZSRPjlPFk9XBqlUt87BEAdJRpODObXiVKZlR75d9IpiYJZdOZIDvJhP6ovtqW43zCqvRMUwZx1MF++FtxNXIYfvfg68zZcZZ6hPxjOoCxxn/G9exmvAH6p/oS3Q/sApB6UBAGydJZRj5gpaM2CHAv7fcsCenOgNPiDDb+bz0o6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097640; c=relaxed/simple;
	bh=8r03NX+r9x2k65wyMt7AIvp8WP7OUAczYufIB8H2A3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk3jqUHTaXclsto/knE4brYPY6rJm7Y+nEL6EV1smcSnw72e18wFVjlO2wVay60Iub0j3y2cPNB8NkzbrUFln5VpNby1EwDpDmROuFL56sVDXu4Bbp7140csh8kIBNp78zGNsyHOQmq9VOuJOkIxFEVmN+HJOXP4PiKlZOTVzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N161Xgcq; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e547e3f36eso14476515ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097637; x=1755702437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BES+tZqo2SQDVT+JlFy01sjWICy7VQC+Fxe6pE/Yt90=;
        b=N161XgcqDvyv2hYx2Brw5L/qQPRuICvPICItsxpLXZZI4knufLANcsx3d3faZoOcfU
         HIYJwMYov2vbnZco88zMlcf51y1bj9btk+gsc9l58Ca8aZ5JxQ1NlTfmJDMHSTBnRrGD
         C2kn94NVl/QgHb6a7s6yLcejOHZfPMnRFIW1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097637; x=1755702437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BES+tZqo2SQDVT+JlFy01sjWICy7VQC+Fxe6pE/Yt90=;
        b=K8J6ky1GEF43M6ijRlfqsuGGmHp13rJB3lf3Er3bSaEyLbb9YrliXSAYmqZLgSSmrD
         nZWtRhndukxAf4d3zOr9f9M2uGk4ui34UwIJMP1GcvROiCOc3qDN8WIuM6/Z84rbGPjJ
         WI2W4vxXT7QCLY//j5DOMP3wJc1NDxFD6f8of3tPZWgBVCAq2YD24YBXmt3UOZB4h/fh
         tbfl1fl+GqQF41AwNxfPxmfWsArYK/lILB/4Appntd8WvGsf+RyflnYqVjUUoWByDF1B
         10UWEjdjnu+Ich7sk5yIE9YhoD0HS/zd0pwQEDF4xcm0/5kd0rq6Xu1FmweOa/M1agpC
         UrcA==
X-Forwarded-Encrypted: i=1; AJvYcCU1DaLwLnXqUbOy+EzVNY1jjRoqigjYeZMXe0pLRGGjcNrsu7oLL0B0ICNQn5ckwJANqBNqO9l3EKumt4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF1gkqZQR5BW+tjCMrBJdtU/4HQwkl7QmpGNdz5LVoxhR34i3
	LMcc9TPG+Dz77s7+UhOTZRglqOVWz/VDasAMLYXGFPffKg7kqjhQPo81H6ZSXpfuoeWL3+5Rcmw
	sG1u3
X-Gm-Gg: ASbGncsmrOAg9Vb6LvvvPvM7Aj1kUlP5IwJgXfrQIMpeiGlYfGH6NLIYdRlR+Zbou5A
	K0+O9Q8obfYJMlGcI7E4vLc2pfgQNPqFrQT8SqHp7I4CCAhj5VPkS83V4RhMEOUj8QWco57PPAN
	R/ZLDeFyU6gNeEVp7BifqEPq73GHUexkHRorWEL2n1B/IxdrWNQq6C2CGl1omPRPSZQKcTr3pg3
	BiZrXkvqlsHX6rqHNKeUG7WNWMKvfurrwbyCRAapQ/lfIDFnveTU9AcNhjfmQMHACu4MYrtYBh3
	BLz4fNLzL3C45skCHi4IpJnBmbnLLym7FariL2txsqQq8UNm5Fpc7zLi9VibEi9fCozNyGAtUBC
	D7RpdCl7lhVaQV97mMvKly94Yd2WepLyzuQ==
X-Google-Smtp-Source: AGHT+IHnp8n/7OAU4jNs9ZCJvpQIeiaA6sLSad2OkT1KrPCLwJcVRh9VXs+acczXHfHfywLoggsTbQ==
X-Received: by 2002:a92:c262:0:b0:3e5:3d13:5d8b with SMTP id e9e14a558f8ab-3e56738ad42mr59701575ab.7.1755097636513;
        Wed, 13 Aug 2025 08:07:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e542eee208sm42577175ab.9.2025.08.13.08.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:07:16 -0700 (PDT)
Message-ID: <020677f5-bd18-4801-8b41-ad294a14ca66@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:07:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

