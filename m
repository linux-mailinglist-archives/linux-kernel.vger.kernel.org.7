Return-Path: <linux-kernel+bounces-880988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A2C27226
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF093A86A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6F2EB84F;
	Fri, 31 Oct 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OS9LKwX/"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F02EB5CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950250; cv=none; b=iOox05eueV3jj1D34v9vFHe7+IuUP/XV69/O6FP2WURrHXmHAMZAi2h41zBG56gIzgzd3YYG1MF5TrTB/bQ8TDK9QwNyizQ2fe78UBojv0Z/Yy8lBM39Sgc7Qkl5BzgVoaNMXOB0jR7AGhigSAhEzHL1BAja77CJK89p3Dwvg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950250; c=relaxed/simple;
	bh=lyoMRXm6f9/VrNX6C+nyCiEeZEgKdKGMwqial2YdLtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOjvl9nU4l5U2diiFuCQvgpx40/qey+NcZCekfHnpCiQS1OkB55w5Hrys745nHLpICBvPubMYIXWtHu3LiaFY3F9pNSWUV+IiYnxuvMJkTNVvrffnCfdNo5er5FnfXky1pZz6qeEy3tWmFx+apDTSAq3GQzRP4ekbm4KuGHSs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OS9LKwX/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-433071389e1so21701145ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950248; x=1762555048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYZpsZRI4LYROmtgQIPxauwwjRjZshuAEYwDGnWdS9Q=;
        b=OS9LKwX/rHbjoNUuDCf+D7Jb8NP0ZoI+DEN+yZUn6AWL2h+tW1sX+58WxisFBrlrvf
         roAfSG/EQYL8BsaMbHtyfEGoJ0VUi/cbHv8YVZ3vOnKA25I3+DevO9aWBEPE7neKO/42
         3UZg7tT+pk6HpiwGJdiuy6iZ7p5Gf2cV5WJPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950248; x=1762555048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYZpsZRI4LYROmtgQIPxauwwjRjZshuAEYwDGnWdS9Q=;
        b=c66UM3Ot9+3f/JtzdqXuxuqYEYe0u1HNO6Zyjsh5/pA0DZnWlD5htBuFUXs7FpeqZZ
         cP3twOdsNbB2cm/QBWSZ7TDGnnQtMW+VjdbVIwgvK9MrmHDQaMK/YB8yRNF/Iob1I9WX
         fCIsdXeudJ4jYTjS9LtlXzuUmI/v+P07rGiPsA7Nxq2xsfZVjXuzrWXeRI5wjutIF5UY
         0A/5Ya4ML8d0cRDqrAwqlvUxcCZdbOpr994HrI6BZfN0jcYhtGMGjTIIPcj7uMRJIVZF
         CTrteXhaoIqBhPNS0Xr3RuC21xVvnsgHWXDvEv0CJcHhXIeO8xcOB71WJKCMFLXWqBfu
         QKFg==
X-Forwarded-Encrypted: i=1; AJvYcCXyn5vMtYYk5XF6JGBeXXdV+5gg6zKm3a+nRCW5RC/oAYmrfacjHUvrVW2ek3jE9T1tu/saiCcFe4udA+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0//Mk7eDxZ6iHamJZxSEmM549SmvOZo3jpsx9vyGacpQLMdS1
	j07cE73TV3VIbfLxb43lIJsDiMqfLLvlVsgKrBOcsmLoSbXAa4//naGjLdaKYNisbhM=
X-Gm-Gg: ASbGncucqhjKMr1awuPn4Lh1LcNsHr9/a/0X5spAvNINHXH5Q00MJKDjLAZc4JyJ9vQ
	hlJjbM5hoAAndcD7cDCF0E3K+DkiawPBdxGe+ILT6Tns7bgVqwPuBSTBExapxSszjfgV1VRpcyl
	Jf7yD3UcCh80hZ7f+WQgnM6ZtYX4RPms82npE/zfnuiaV8nrAht4jTWI55jBA+4ajLZluImehxt
	XevnyuITMnrAn/Gzk8Cgqmdv+TebLtsGnxFLLe4r7smfI+nOVlK42T8a3kfHtVjLAwtOIhE3WAZ
	L4LphuPouvVxd44lMANRYibUCa38YeUhKYv2gyNPM7bJmWLT1J3KGwbVExCnehIQV2WBd4oc094
	Um/faWbnmCkkc5evt2U1bWU3/tGi1fYC0zu+LfBaEP4Zd2W6nx62dNo6VGnplWTiTIk8haCmQIj
	wSWVUAGPXLzCkT
X-Google-Smtp-Source: AGHT+IHQbq8xoN+qH3Deos3yPtiJSPDT57c1SPO4PDOvJb5EBUgTWDF+VAiwrMirbjgmdTNntAVEoQ==
X-Received: by 2002:a05:6e02:3397:b0:430:9f96:23c8 with SMTP id e9e14a558f8ab-4330d14876fmr85117115ab.14.1761950248190;
        Fri, 31 Oct 2025 15:37:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a34b8c3asm1161665173.17.2025.10.31.15.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:37:27 -0700 (PDT)
Message-ID: <993bf106-a8e7-4f71-b340-7db170ad10e2@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:37:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.116-rc1.gz
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

