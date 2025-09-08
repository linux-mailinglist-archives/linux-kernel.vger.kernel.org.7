Return-Path: <linux-kernel+bounces-806871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD35B49CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D484E67A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AE2F83A3;
	Mon,  8 Sep 2025 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpHirkak"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F12EBB8B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370938; cv=none; b=GkXVzSskltbcagWRGjUdvHvMfPkASeYZ20pXFoVl+bity5smqbTs+m3JywCCaX5q2eQ4/+2dMVT6xi3atdsmSyQ/TMbQW5Jn7LSOXa3ERzxF141w++e/kY1EKYfyIY04+otqT3lBtqHCEULf/26kFXlOJ437bCxH6vCkbnHmtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370938; c=relaxed/simple;
	bh=jokPdzy+QFXUQhnXK24Nqj86DGGIIehQPhNMfk587v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ8yfvtEFgEH4K3VsA+YhIuT7Mf81JNyn4AaL74uJxaES+VJOEUkV9SPgpfO7BKSpN34Zf4qpZouZhGowJly8poCkK+ypSQYeKrlep5p3La7AVgOedsh4/OgjNBFhsmSY8e6c3F6M+7W41sR0fMR3RELszYY/K2snojrx37PwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpHirkak; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3feb74a1f4eso12893485ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757370935; x=1757975735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bjV+b3hh2hO3TSHHe7wU0vMi5wwisl90Tr3zOtLYr0=;
        b=NpHirkak2Q5dLEaisU0foSDso301k3+q0qjpu/W8/T5qxPTJLoo9n/SehqiMFieuHG
         ORpzJoIeVYrpQ2g/SBIdDzC0MymBva0ogcHUszr/1WFcuGmcVDGUIk3rX9G2GvTKGJ/b
         /pQftPq99rG6u7umG+SuiAS4GNkADoNQeexMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370935; x=1757975735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bjV+b3hh2hO3TSHHe7wU0vMi5wwisl90Tr3zOtLYr0=;
        b=KvzvUsKebzdbrUMO8l8rKvsbxOw1eWRLtRJZAIZO4czpDXdUHHSXKovRrkQzxm83rw
         lgVW0wpBVnjF0SXQ7mcTA7oa11CQfacxBL53zIogvBXWOeMJ8i9+92Mt0JiQbqBnsIls
         aDLXjsbnHlEeP+i/1wPOAPymOD4Gr78RTiQYICf5U7KRjTzkuH0enLSWOF2uy4vlnNlZ
         Ox5EwSNA6nhfw6BPMC/QPVLSOSml3UJyK8YB/LWDbGZ8Di9Cdr6Vg+M0yzPYHLIuiXhj
         WmO8Q6YI0BQ42FPPh5SsSqOFt1uUDKZ4uge/EE9p1IhGu8X6IPnaiUMuG6v2HaWUXeXE
         qJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD52KdFZkPPIcCBUeV8W68KphnxBjei/0KyRPWNvcS2BIpSYN4h+H1aK9tzGSoK9SQhechJ6XYXKVhUv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZdK66dlFNb6tHVgqbyWV6TVkCa6HWaR4XKj4oqvGPMMAl2v5
	rxVG95p8cPf8YuB3LqaBj6cbcoP5Vzu+jKakXLM89Hu8T6D6N33aoPEXiJLWsSG3rOw=
X-Gm-Gg: ASbGncspwc1fTZoO8UPigLd/TXir1FW5Jvi0+1zzCIAlzihrTOTyVfUS/YSMB7lRx1R
	bsUXpcTbl9cUip5qP9ltk38XRQRDJHvk3QjPjkBj9Xn3JqgJWKTHhoOMgXZlAFiaCFraOGqrP9a
	K0QRX0mIVSP1BSLepIJhH4mI7iKbVj50xm41iHhQaaBwuK8KoEQQOpMoJ4alzVYvhU6wKB7yc+u
	s0SoIscsP6cKPOXzABoJHyuL3mdjSwaBh5Lmeu0R+cdnYk6qz87ia+48tY+YloEU6PjprqnhW2b
	5IlN2vIAqFoRkJsi+OZMJc5K+tnTjvMExILOZxHfccCwQAikneoRXzWNJRcrbBuAWGjVxQEbQRu
	2N+yLa7oTZ1XACj8Tj/hXosYkAUNysIBDHr8=
X-Google-Smtp-Source: AGHT+IFkKB76IaSWWVxO1VqoPC1DAvppF9S5WYqdz/wBv8g28ZnA54hUe3zUoEpuXFiSeVDiy/Dncg==
X-Received: by 2002:a05:6e02:164f:b0:3f3:82da:29f2 with SMTP id e9e14a558f8ab-3fd877813e7mr117569685ab.24.1757370935586;
        Mon, 08 Sep 2025 15:35:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e723sm112127645ab.7.2025.09.08.15.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:35:35 -0700 (PDT)
Message-ID: <76c82c3c-9d76-4f74-ad44-a6ecad0e6590@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:35:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

