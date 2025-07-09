Return-Path: <linux-kernel+bounces-724570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB4AFF477
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0C47AFC92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70205242D8A;
	Wed,  9 Jul 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+X/+IDN"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04723AB86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099133; cv=none; b=QV5qOZQv+Qd7uYgxJM8GUdouIwjrwGGvjw485nRvPq9wNvxzYWYJaisxIqNGN3ntUR0PvKzJ2YVu7tinx39tjzIrpHYzm1pX8GwOs61yzbOpeG16Fx9+cv04dUzSE4ViifXEX1+IXE6LZCrHQpFkucIZP2um+tCoO6xL0p5qfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099133; c=relaxed/simple;
	bh=BuNQ2mYEgeP55do80Pv8brcXDATJKUwOVb1q83oWXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUZbjfbwkn+E8BcpiL51FZ6oavwPaaOA3rQu6f3CDOaV84hfgjWYEg1Z1M304fQYrrqdlylIJ14hZOSUHKDFQFasu/DZtKqXMSXUkVLMMSYhDKnBqfKwoXb1zlbI33OxRX3Agt6PcgbTC4GO3F1GVPnwt8XR0/OToR7cA8GE7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+X/+IDN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso2010315ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752099131; x=1752703931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIxrKC669NC+k5Q2PskeXiZ3z1OvgkVukHTfy6+bNlo=;
        b=I+X/+IDN82xp9qgiblUQMIoPwRk7bbi1lCVQhSan2ILZctDPWaB8OYM364r7tzn+2h
         Bzet52gA74afzCWMB09TWlcj44a4vv3eXFMH9ojhgYlITxLbqq/gmV5HRoBpCHfHEuMm
         USS6NqWfSDD4I2oHdRQzPfFhqxLZ0Nghx3Hbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099131; x=1752703931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIxrKC669NC+k5Q2PskeXiZ3z1OvgkVukHTfy6+bNlo=;
        b=HSMHB1eVT8j0UKU6nxIMMAUi6tRFv2hQ+FergZ9b+suCYVw7psONYozbi07VZNAUOb
         2irAEwXlPoR6/pgyIEtDuq7TGfLHTBL3zbqYwtfT0l81qH1hmdGqb5zQLp+0WTds1gfU
         DfunIlvJ1yKPYzQO15p3ZRsadvMP2pDDjLWUlW51PzbschvYXZd18d3L2OcKcM9vrw61
         ZTAHWaB0Cx0VybUixDlgstJvf1t2GNBaNwYUOoiqhSzkU/GvW3+WLEojHvaufxI1R38A
         yl1czSNxQSLU+QypiZYTmqVEBhPKh7rwxeOlFycniJEThXWWJ3WYaPeQeJtF4nrxro/5
         3o/w==
X-Forwarded-Encrypted: i=1; AJvYcCV5BB08qzeXt2uaTF7L6/54qlxNr5pASGiWTo2/vFkxGt36vjFjOIypxLkQ2BlrIZQ1HOQUe88TldKKpXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRt6WBtC+nIaKQyvqZoRexTQHmIocWx8En9bxisU7tpBd4jc+
	MAVkZys19xviUSM/DdJmRJBNKQn2tcvH44O/zzARaJsa6iRAmuPeGX8oeVzlOhYn8IU=
X-Gm-Gg: ASbGncsRwecpRc/mGqAli02YHDzb0Yoe+4XQxs2B8V40vM4LRHR0NCtyAJ3ODozAq1/
	tkjWofg0aT6NAvxazOyxeBYoHoAJMcg/KxDXw4/VgSXmvyUJspMIxMWdDzcgZqZ7feChrbGaAEQ
	ijHcrV7N61CT4VIxL6C70ff9to+KlAdtmT+6K4WmN9kB3Dc8wbbPyXsE9JqbZdl2k5YkuQFCZZi
	UdiH+l29fKi6ei2yqMlTSppJ4CB3RJIR9v3H/BTTRvT+b4kEr6+LYbnbjnQHwg3nk3f2yi072zy
	1uXs4kLvNq+gir24noEHq4MdiCjCODBmBp95XZBgcemiRxaUlOj2WJjlj3w7vivvWLunobk168Z
	CEhhAgMai
X-Google-Smtp-Source: AGHT+IHaIzZWNqOEEpYPr9Qs9PHjSIXPHby13nHFbqDrTCwo6xB3iLAn/fUooRUkfxxOIKQ+Pk7Eiw==
X-Received: by 2002:a05:6602:14ce:b0:861:d71f:33e3 with SMTP id ca18e2360f4ac-8796938fe79mr35681539f.5.1752099131134;
        Wed, 09 Jul 2025 15:12:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055659d231sm45091173.52.2025.07.09.15.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:12:10 -0700 (PDT)
Message-ID: <0e3d9928-cd18-4683-a71f-bc7b0d9a83f3@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:12:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

