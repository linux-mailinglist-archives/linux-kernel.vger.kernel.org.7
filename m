Return-Path: <linux-kernel+bounces-724556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426ADAFF443
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394581C82488
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2358C242D7B;
	Wed,  9 Jul 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IxR48/xL"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D8245000
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098413; cv=none; b=XmePeB5m9tfV3jlHGm20zMeWLi+uW8vI/4MOGukb0LUGE0y1K7piK7YSF3MxjQZVbzf52BcNA5pZSaEf1cda4P1axfP7VmOn7ijJdKOJXUm8s97D98FEDhH4voWQcxSSjiFrvtHjSFX+E8NHroUmDw7cr2h03Dh9/56hnp9xgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098413; c=relaxed/simple;
	bh=E9Q5ZD8hLPIv4GGP/IuhXIhHJdD5qFjRVobn8MvJD5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhBAqdb/OktlUltBWkV+A+UH8Pu6s2+LLS/A47HnSlgmRMh4mgmQxvIz82QaIbS9UGav29PPz80unD2wPjDpcTUW27rMR5WYaXje0FjdOQ2nJyAkQtG1P9/BhpYnADRlhd9282jIXKCj2O4Fo1iJR8xp9+8dy8gMZkriGuTXwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IxR48/xL; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so18772839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098411; x=1752703211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85sUwqG3UTvSBY9eq2mbMCJ2LiIG5KRrSnwcZNLE650=;
        b=IxR48/xL8EnhT/cxQkFDKwvxI84BORiqPKKbQPC9HE7f4+aCA1wCURRHq2w2R7H052
         xcepm3nCpIsXXDxNQg3uXhqj7bK31aiKMEE57e1om03VVPd/g2xsGnCs4GrP2EunLnqb
         tw4VLpBE6m83NqEGWl4IPNs3cl74QY6ZDNA/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098411; x=1752703211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85sUwqG3UTvSBY9eq2mbMCJ2LiIG5KRrSnwcZNLE650=;
        b=IdBMwqJcbk+khKOidGdGhiT4vWkuLG/k5/c5yFYady8xlAxrpnmZbItctyfH383AkG
         lyFTKXB85HyktvwphekiS2BbAMn/eD92OrOecaxHE7fwnyYL6r+JH+kgYDY+61oStbrL
         v7HCb6I79Tr48pNKPbNGJaqN1jPAipRRkYMuQjMjY9kKCq4AeA8M3IHjDtNnoDwZ1cLM
         M5UbwhdSI90Kejn1zVBZ4rmLeasnNJ4WToOrfZ5ejvgQDGYZwg8uNQ5mRQBhD50LsaJp
         UAojcQQsyHSvgyL3NEERoo50MBPd9uo28Qg0DLVY3AszQgytwgtc9qyfT4Bd4emJQjiV
         XIUw==
X-Forwarded-Encrypted: i=1; AJvYcCVPXF4P+HeC0wU4FNBCwe99UMQoz5hygusxsyyFWPAIrLeBJrWZw2PMXepvDpAbUYDhFGL8w20ZzZB5TEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjxOD4YbS1wpgfbky67gzhv287qeTQLdmOf6X19ruchjs99ai
	vnGTKiaC+zzDyELkOC7xCnVNHFA00dkbtv3VIdKv5BczLcIYVdgrttAAgBVHURWnm+U=
X-Gm-Gg: ASbGncuCYYxj5nuk4w0ysODbQAXCzBdl9S3n8/u5eYcaQsd+JjUmcizQ+pRiurEiLjD
	NY7zyhvfkDP+YcZXPFmo18KiAT5Fo6aQMHD96pJn+tcCDFNRdLit9R7OjMQ97HDOr6QE9htM02L
	EPIaSzkyTW4CLI2Q4B0+z27/I69hXr4KdHppSvPurdDCcjJvm5Zj09A8/Rc3oJ4CNBe8j+1XAZr
	1E+gnprGI7LByYenZwHWkpb9ex72xWGyoXi4sCYyRF0y5z5Smz5AgGwQ1uOxwxxXMQuRsIJHbm9
	9PFWP67TlsdN4auDfieV/O6iLneKariuepH5bK2Qot+3gMp+hnD+2EPGpiwPBYMqQO3UoVlVyFF
	OfRWEEsd8
X-Google-Smtp-Source: AGHT+IHun6TfsfnEv/6FmCADt8kyWi0Ooqlkv+w+GZgNdAI9IkWYVqmqHa88dkbi68Y4nRcRs4o3SA==
X-Received: by 2002:a05:6602:4c82:b0:876:b001:2cb0 with SMTP id ca18e2360f4ac-879663b35b9mr178724039f.11.1752098406062;
        Wed, 09 Jul 2025 15:00:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b25536sm33365173.133.2025.07.09.15.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:00:05 -0700 (PDT)
Message-ID: <903f7d9b-74dd-418d-8016-264d60cf6af9@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:00:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/232] 6.12.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.37 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.37-rc1.gz
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

