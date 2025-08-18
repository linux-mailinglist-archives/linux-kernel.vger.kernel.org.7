Return-Path: <linux-kernel+bounces-774448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D9DB2B25C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F075853BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEB22D4DD;
	Mon, 18 Aug 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTYJxBWV"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB22264AB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548880; cv=none; b=eFppt+5q0TCejkB7dwlXlxxkns8uJsKIAaMyOun0kb/5amhdWM7ckZ77wUBaZi15rXd+Uj358qyC2za7KQDxysic/Gg/XLHabsQ+jxloLCVwrSgzlY2YbTFNP+1b5w3KVBzP7mWwfU6pYu5DXYzunkKcPM22PLFTAQApKz2/+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548880; c=relaxed/simple;
	bh=hDooSJaE5aEbmAO+pjBnSTkBESSsm0eOvdKkpZB3s5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jaqi8l/6AflakQVEuWNvtNrHphbgaKoj2zeNUHJ+1pZW6xgJWkhyDzGU9VQLULucPzQGtnx8OCrrXfq8SlBpS+IB9xhk+k1KdcH9/zSNqD2/7dJAv6pjP8yTsQzgDNO7wxDVlIt6yd6lKpXUywgq9CLQ+QcNY5tKfzD/6LUK2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTYJxBWV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432ccd787so290628839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755548877; x=1756153677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hwb/sGg8U9KLGwojJ2PDXhY5l4YEOf/IhW5l2o/KSE=;
        b=NTYJxBWVauydObHkz8as1kw9Ed2ZawmRTcznqy83DF4+LOFXhaddZHM+JBR0SCvVxk
         GfmPSs3e6BtcPgeFaU01zcXtDOjofGplfHcYZWhypAG0Z5VJ+fpISmQeWD7dWbbpxFHB
         UaknzkpXQMSqhDB+B3Z4g19MkTe6h7IHlmmvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548877; x=1756153677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hwb/sGg8U9KLGwojJ2PDXhY5l4YEOf/IhW5l2o/KSE=;
        b=p0k9Hhz9S5ArSBodpkvY/XgYUHU5c+XJejbmdiRgWZBoVavwFSZsmfuyiQPRrP52cP
         X2gwslkMCcyaeFNu3CTrem6EGYXlFV8o6S21bOwikI9x0JkpfDlObmAwbgth3hniBiEZ
         TIgNN3woBWcBwo+usADn+ZFo66HXQp+Feon6fqBygtU0TFCYHtAmehRrNF0jY3uPkaLp
         p+mtVrAzKS0Sr4l5KTJRwyqzaAjtv6vfQkBN4ZR7sSjpKh2XCU/ltQoqHGNwLrw8M6xP
         WiH7USpQWhn8zC9FgAuUTvpqNb0UV9mYOPIllF5wtnujmkn5kQvNfx8X53omFh4/ZoV8
         U4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoUBIFBl9wgXDzD/G7iHJvU1vQBuRdoGdTg9/gsje1xHHTx9c+tg+zqQfWHnveSZ8/S4waKuK+H//DqcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDl9k+10tIND3UbSLT+5ya3PqNRFTUPguqzr7vO/RG6+Fxej0
	7hU2u8NWFCjl4N2llpXVLJDhcgj09BjcSejfzoMet/P9zKDjxeehrf8P6zAUoQjfgZk=
X-Gm-Gg: ASbGnctrccqafijqow8rEcHB7h4xz6o+c2Yn57xaUXPbxbzFhuqOmiEHaoWFPHvt6u4
	3wydeJYujiydbhHIsf9g0+8jM809DBvpBTTyduMqvPQHBR5sEtTFLRTdJ24SllWr0psDcZTODlz
	1B2qiOJZ++KxXeZTSVdby+DPjM/hHhDrTu2KclepWsXIR+kTuXOs+lbpE4b3D610HRMTzQDwbLy
	oC0O1bsR5UETgPi0gtq+7I+akdxJUJHppYeYqPltr+9Uch+ds+G01gkp5o5Eln2G88RXAZSwnA3
	CqbUJW1dvqHapfA2SJUBCWcg4uNNvJ0xMzOfGyX8OWt1eXBrEqZzVi2blhGLQGcjE3wz9z9dlOH
	A83njPUY4R+BS9Kh7EIJMm62hZ1uGzPevf2c=
X-Google-Smtp-Source: AGHT+IHZEEvzNoKlVVqwlC5w6deqnH1DrBO7M/07loW+8EGXwxTGSXrkqC3Q/AULvCwD0f2HNqrD6A==
X-Received: by 2002:a05:6602:3fc1:b0:881:85cd:d08e with SMTP id ca18e2360f4ac-88467e825c4mr5673839f.3.1755548876979;
        Mon, 18 Aug 2025 13:27:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f7a37sm2823835173.78.2025.08.18.13.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:27:56 -0700 (PDT)
Message-ID: <e8442465-7ac2-4c1b-85d1-676ac5c8fb8b@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc1.gz
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

