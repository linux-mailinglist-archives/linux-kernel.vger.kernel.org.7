Return-Path: <linux-kernel+bounces-823422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E8B86621
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75A43B5FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0C2C2358;
	Thu, 18 Sep 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPRAHUms"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D19274B4D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218874; cv=none; b=f3Uci2lz7gLeVzExodm9XIABsgPj8QdzWOVHuTxBpD7edkv7LOQpAylWHLjIndUBXK3q+rFFbCJRVINnkYF1281qy5FO69wjTJGBi+6GLQ1cnmmvqo8xyaMdF7KEnnIyRuf6Ggr/g9b2xeV+4tWRvWZ3kgdJ9LMkG3zAZLrx9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218874; c=relaxed/simple;
	bh=Ihox7KjQM6+mVvo9UNxDhOw4q7HzSGfp98T4jh9xaNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkEAhAPmqz9VBl1riISER8diYLjzuhpcyEZ6hSKS4IlIJJCsSVABAUJ+kGpwEyoTJ/pL6OB5tX+GD2YPp087y1IIn+GuqnVAyfq2evVODwFEw4+8bYRSQjiXalLSrERithek5BwFRry8d1zyBNeimSvJt78EM0O6qV6kC91eR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPRAHUms; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cde6c65d1so12557665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218872; x=1758823672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDyW9VZMla/yzNH/VDc7UN9+phUtlhbd8pbrMSV+Eec=;
        b=VPRAHUmsnlXw+pPD5TYXKseWRncD4Il1wLQ/f5eShPmfbPqI3oFxfkOtPZQfNrNO/b
         KaE+VTMlhitC9wqB5ezT5PKDGsb6kptvURBGkAYqrYlDU3pwNqtMS/JwmxqmK64O79CH
         2m4CEoWBv6eqsrjK2z/4ljOHfNHE3oqCWsX8tp+APHcBI/M1yvDmqcEWueSDYM/G3Sbo
         VFyvEoX7RKLzCa0Ia07tu4668jEccVxA26zViFeEfjY9PKQDuimhmvvLePEpweN/q5Z2
         6f3rJbTljdJK0Yg4v8R2AD3mEvR6LWOtvBqHcFKV6MNg3zFM2zJ03LS4D2PgYZRZYOpc
         c9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218872; x=1758823672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDyW9VZMla/yzNH/VDc7UN9+phUtlhbd8pbrMSV+Eec=;
        b=Ab/Nsf2byKgcRMhF8RmvWEcL4IDl4gJ0bCNH2hBrklFUA5Wdejmffv7FB1k6m5yQaP
         O95m6pZY2vsLO2fLb1PqBO5OvtxLuUrYaxnsm5qjjGuj1DrZR7Vxx9SO3H0m6uM+/HYs
         C6t6Hqr5HQ8j2v5iQtTMrymmgAitnWtja361VzyZUWnZuhGP35e1RmWSE/JpLhEJihJh
         IjIJLjy//mk/1EBAN4AkEs0qiOR7AHPAlBrdt3jkCy+IrErj52gziJkhGoQxGJcliFUa
         RI22Qw2kHdvntTOPKY+vj0DVS+dBDTXNjyJJsI9AXpKfwXRePEkVBneM2s68z0pJ8r/d
         EAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6EGa7MNCPt3mu9a/CGXLkJivWECy+3WMSOuhUAz0ohwV5GNjIQOTbq3v75CohaeKCmMV1z0ia/+aBsEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+1yZJtg4AxCA8Uqns06+Y9JsCGJXqF8RDBe8rzJ2nm1t6kLd
	qlFTmASoNq5pBZNbZjU/d85BEwKYOJqQkTn+w836VADdsjwp7LG5gmLRNKJIqg==
X-Gm-Gg: ASbGnctRy/LaK3mU8JPyHvFG4w/BJZj8tWLMOKcSP5vwjPe3HsyVKx9QSkSIBPnPkgk
	pOM7gHwQzCHBuSqEGbQijkwXc6TZTM2IR7YY2EIoLVSSXxdt2TJmQfJuiLZZIOe4pcqN+LMg9YX
	JIKNPI2k3EiEanMdZwW/n5PDP94yu6+UccicpXjrEhEGLPLgNi4295us7z3tYPfMilV8VU4BRmk
	cuPYjaMd2V3rXtM+OOKsIFnwRyb745diXzxLnrCE9ebFl5CxzpEoxjb9p2w77CwqOx2ZO0ouy8k
	xdfimeqWnHICKl0qKY1VIsAJGcrEpjVNgNpobRnbUelJKTXHaZlg1Uw8UK04XSKIqCqf06tg268
	r6y+6oqaHZK1TdhsFpWQ2KX8rnbUUvDqs9EhJxdrJfkemyDeY1PxzRl8o/4llKo5Jb8OKzuYpPP
	Po9oKb8a4=
X-Google-Smtp-Source: AGHT+IHnYW9s9Ywm+C6BymDJxSBWvQwRe1XoOyZiFCn75JFtSI+lA2DVnxrrNWW5YZylSz+6+G1gEw==
X-Received: by 2002:a17:903:384f:b0:267:e980:da59 with SMTP id d9443c01a7336-269ba441db0mr6879635ad.20.1758218872257;
        Thu, 18 Sep 2025 11:07:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5510fd4872sm1270927a12.32.2025.09.18.11.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:07:51 -0700 (PDT)
Message-ID: <10179c40-595f-4dd1-abc1-d6ccdd0ad7fc@gmail.com>
Date: Thu, 18 Sep 2025 11:07:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123344.315037637@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


