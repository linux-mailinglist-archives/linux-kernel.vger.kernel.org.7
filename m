Return-Path: <linux-kernel+bounces-848849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1CBCEB0B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899124E650E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925A275AF3;
	Fri, 10 Oct 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDP/9T42"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0532750E3
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134902; cv=none; b=oBFAnUZpmSqaeuC0O/z/mq+C1S40ARlsTyPwxERB+dQdZGXyGQ+5fLioyFBdKSxOZTmlTXOZhCBHeNm9Y5pO+dqW7jKkBSLpevabQ1BQyJQzXYsfsQpjqdLEP+FbGF+ZkvJKfWBtGOHC+WNNigDKSjF4XqNnzFXL5TWjDMd6GKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134902; c=relaxed/simple;
	bh=XhP/COLjObDz+ZGPI9jHrKcT9w6Zfqb+6aYc6UIknSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZNEU7q+fZr8Dy6oCKuseUMoPxv13a2Y10VpAe/9R6iI8wMxtdf8nugJAr1la8v5X7oO9JbRvFBF23ZvCPnyYSapXMP+pBcu3X4Ak7pHS4lUGIbaJ26sCQGhwt+/korFLqUdZ6GCixu7VfIvCBr/0kNvljCIIBj39fFyl9Ok/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDP/9T42; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f6e0bdcf7so19958385ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134899; x=1760739699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XN8BJ2wM10+ueceH639Pxl3TfZtOWY8UGM70jB/ZlU=;
        b=dDP/9T42hjBTOwLrz5iyBZtdmpoLadYP6g1PiyqTgBfk2heNHoHlB2Oif9LFSzwaO/
         iZZrj7GnvRXllUKTczi5NkY9g0LEceJMobyxTIlK5Ub4fQWhQf9n+V5bzImJ3GY/bWMn
         wvZaBKwv3dhijnS2R6CY/KDkdmtm75SGs8NQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134899; x=1760739699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XN8BJ2wM10+ueceH639Pxl3TfZtOWY8UGM70jB/ZlU=;
        b=vstFV+tPWEE9Fu5+Gur/o1dbn2DtzI1FfIGy+rvPg0WP7njFDY+PVSc+dH6lzFT5Xx
         Ic4f8t8R/ZzFCt+zn/il+F+15AsrgupnCaAlRhlUhKVsLbF8NQurKG7VUriXeAw7ZIcA
         EtZEhiQUfohvKV54Y4s3b2zahQMIzdTP97yKxetxzfT6vm+Z8lcC8Gq4QrQmI4hdyIOI
         3Uegwpfrd6BTKUqCo14Ylz0ESArJShf10vO/cwJB29W6xLCtDjfuuL8b0VZJi1HGw6JI
         3gUOXt1g6XCavav86eGTwXtdbpjuWiZlcXFNHWtBTJIFT4LA9V2NQL2bIlMSYTVuGHOZ
         ZP+A==
X-Forwarded-Encrypted: i=1; AJvYcCXywfZeQuM5eSoQHOpP19mmGz86naYc3keG96QGHrSzlD84RV8C/ukf2bEMeQJZEwPpT8Pzfg7L58QHPf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbXZIimygwk84eCatN2ofH/5fW48Rudy1u0xmYsum7AlAvHWt
	wuMIFoS2t6hHsuxYsaP1uFPdb3MWP3c3zRgbTq1411bHLNrKMA6h9CnfoWcqd7SlYiQ=
X-Gm-Gg: ASbGncs4pnZ23At0bqv47a4HrrooyC4crnb/W8D+bl0EacbJ/sKNcTn5Z3tzf6KXZY9
	uvJ8IEHrTjSuPDY53Gx0aagXBIb4CzFvW/4jBVZZU/Ffh3mI2TgonL3hQy6uciuphHHGv0BnMnm
	TEcc0j6LlJ8WuqQbF4lMcUerENZti3Xh9LpzHwKMiZfQDIW9oEbfmWLCbLePJFPrsSSSl9S+WZY
	18r2AUJXY4EytRPX0bb0pAXzJCyd4ty0L9D465NYBXctWuv6s955+/vWOZAsXLMT5Dvv253iafP
	sjk2poYSfJFgzqtmZiLlXDMMSHX4ZwUpHwpX+ou2TPfXLjCnVkkI6yxj1xT69UCeF8uwklJhqOI
	ca947CdBhnd/fs0OJJT78LNK2tk/MI1sngI9umSt4e5kyZD/l0SWrzw==
X-Google-Smtp-Source: AGHT+IEaOdM6AjtKS6UO4o7mdcrBSBEqizYrTv7AtuOpOFMXKvh2X+ICbaotUhVQZwNOfyX/mRTl/g==
X-Received: by 2002:a05:6e02:2286:b0:42f:94f5:465f with SMTP id e9e14a558f8ab-42f94f5485emr99584845ab.29.1760134899305;
        Fri, 10 Oct 2025 15:21:39 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90367296sm23828295ab.30.2025.10.10.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:21:38 -0700 (PDT)
Message-ID: <1c714af6-fc9c-4de9-8f8e-347c3ca14b34@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:21:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131330.355311487@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.111-rc1.gz
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

