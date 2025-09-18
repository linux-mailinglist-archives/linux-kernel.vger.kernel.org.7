Return-Path: <linux-kernel+bounces-774431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D3B2B222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3881683FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F42737FB;
	Mon, 18 Aug 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zp1zUkKp"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C825F984
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547985; cv=none; b=Ip4TpL5SHkRH64C06vvE3xs7WVSfhKd432DODBgplJjnwexSrh4qM8MuK50mcODONJCmwKvz+DJ7GAsGkCwmYLMrCnMruCYW/BPGjjZwsHZwe69MTP0watJtmbOIkXDOjIl3JSCxa5QXJvhwFWHOK0wTzyhDI0TaxZE8Lp1twp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547985; c=relaxed/simple;
	bh=VAjCSTlcEEGZlPyyXMdHvI7J32g8GhLs3Msg9ipZ2NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAc+9q+/pKL84EYvRx2w+W+Z0KsN6GSO3lp34ZTn+7cjT9vw5UBaF9ZMC61/ObVPiGbMGev3/Z6m9oDPmEBTyYCaLGZlymWnwv95Uv89NHlyNpmJ7HeWbHqnmcd6DYhytMJ23TbHFUUNTTwl5fC1bMsD1slpR3STIfUsUIkdIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zp1zUkKp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432d98463so41215339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755547981; x=1756152781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRl3ccManntYJKAwiaCT/1BaRhYkoYTuAWYVQSgG0/I=;
        b=Zp1zUkKpaljOSPyhUiyg/AxM51hf3GwX+THI43wkkwglf4eEBk5QbfOM+hPLkIiKd4
         hvEI9qP93/XvEI58Hv5r85NmvdUeuYKKv93FKURkiD+AgmyEfXV3ngYOuW+4BzFCYVuf
         wdGczBUbMRw3R5Q4rPw6KEE+EmyhlVee6cxTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547981; x=1756152781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRl3ccManntYJKAwiaCT/1BaRhYkoYTuAWYVQSgG0/I=;
        b=RIYD2ajKQMkf2/QV6c+4v+sJAF7jp1lMbkVSrrOkIZrcRDBH8tfJomswwYeESAs6ml
         MwOXNsZYpdfrEWW5x6EwNnBencm6FCbj8dtPPnjnOT/pzA0KjwiKZe7gqPWpx0b+BKB6
         K5mbnGU0CWBmb+oAoAcgVBj6yqk4i/yGQ3DNorBE/kwIScV8xMNXAUsQ03krNCHg7jyi
         cfBkP3X8vnRso+xoMDFZ+UgRkLGrB/x/n928JU7aDanx9rYqVB8S42t0J4H4RfZPXUxs
         L5H6iCO03cSK6H/uPeJMOLy8PDsgueQO8IYf7l7t0uCIiR297sPOA/QpfI9VOy1Z+kEt
         uOfw==
X-Forwarded-Encrypted: i=1; AJvYcCVnYi/WaH+NXl7LqIxnH2TS2ExHu1kXAXaqc9mYPE0ba6yafqocdKc4d6dYdiIjbaeTTAae4MQeFbAiP44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvccJfdAMpZIQfojI0MlkV+kaPiBv9hNtdbfvZg1p7T7kc0wrA
	JbPWyqop6CaSQPjMTAQ7T7UGPEaBpYAUCDVIyguUacUvx4wlVZi+GwzLogTW0ui2UQE=
X-Gm-Gg: ASbGncucaxzhkiv99BaOJfF1qum1/jPbAZqW52+0JawMeFVkYydcz99N4DAvTN+3OVJ
	vFcl5CLeW30L0Ycoem90oQLdKPRMptKotydaxmQ9TI342He4zaKGOZCv8dYbm7aBaGaf7QfAysD
	20hmg4koM3NiWJNsE80REB7smt83+HXj4n2/pgex7Ilsix6IY0AFQkTibix+xW0frAlqvd9yjnK
	F1UrWbaZsCZ5g3Bd7AhcuAVRpbFVjcLlIdkhiNSC7xNRY2BBncH6482SetRDkKRfcXSdcR0HrAl
	w36CN6gJBxNVfzUVYRValmlNUSfqK8+8s655M9s5L/lzLWQjh/mkiSHpSA/5trEBRM65FUE+iyF
	q/TqhQZ8XjcPRYOERje266kvLRIgdFEh02bk=
X-Google-Smtp-Source: AGHT+IGjlhq7sguM+xWvT5IQPoezITIl1RzzNEuyUyPKDhMsTlph7rxOfo7GdwLsAfa+UZYwBXDIyQ==
X-Received: by 2002:a05:6602:2b8e:b0:86c:f3aa:8199 with SMTP id ca18e2360f4ac-88467024bf4mr102010639f.11.1755547981176;
        Mon, 18 Aug 2025 13:13:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f8522b7sm336762039f.13.2025.08.18.13.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:13:00 -0700 (PDT)
Message-ID: <d9476fd1-2ad1-4dca-8f97-342c9f781d3a@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:12:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 515 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc1.gz
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

