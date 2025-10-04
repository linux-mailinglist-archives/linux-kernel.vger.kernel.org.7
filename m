Return-Path: <linux-kernel+bounces-842113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B43BB9057
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 650344E5EAC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830028136B;
	Sat,  4 Oct 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0WabFMu"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1B27FD72
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596910; cv=none; b=mr0+nVsP6tlm94rw932XCWB9XR7nePLEvPhVgxkJogqYzK+I4HsxK/qUstB7rb3MTz5bhb43tV5SG6Cwh+m5bzLgA7HsYZuOGcX3IwU10acT3r1a+nrgCunKxAco94bCw320kvS2W78Ha76VweQ3RvK7ylYqXpIMc2U06rGPUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596910; c=relaxed/simple;
	bh=tsjBUA8ELBDzVXfzKmYIZr3bArGX2DI1so1CZI61+Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ5HT1QboJ4ki9rzzOezBB4JJft0nC/QpDKf0+F7BTR7BHJFL9UlAHzaIhCPLhwufSRZhy4Jkgr3KT4SUyCxx4bPo0xMiyCxD+eaT9nVgufyPySoX4H6yWJIccqGygTflbbJAvk4FhjJMlwRzk+JSWDQrJhxbebBGJddXYApiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0WabFMu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8cc0cb783ffso316736139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759596906; x=1760201706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgjgiZYlZMYzFou6GDp7zcb8froC/z/pnBhyitJ+ZRI=;
        b=d0WabFMuO/UXNfsKaaVkGaAp2PkCMNee7B3gs1NJhRhoFCYNNQ7Rw2IqXd/7B833Zd
         3IeOTkG1rsSEJvBCO0vb6kTbirBhn2Ul7ps8W6LOYSldZ3DjFAjDFa4TwheGtMIY6ko7
         DJAm/5NX1uDmu4lGwsRbjEd/vs8DHHuo8+Bi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759596906; x=1760201706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgjgiZYlZMYzFou6GDp7zcb8froC/z/pnBhyitJ+ZRI=;
        b=tzFeLOFPWjh1nNoZavLz2J8Rhjqq1Ba1d8EWHsxI1DxCFoalX5pdhCZmMXi9zFiwZH
         gtR3LBm+P7CbCEZUBGOfyijCyQqeH8aZxy/hOXo5TQJQlZcThvtr9t03RF2BmlnqHUth
         fPF6eh+ScrKl6ei66BGuY/8jz0bU55QVNMjBvvCvwd9qJNtEVwh2L6x1l08krKIxivD1
         QnpoCcoqUBrlKCqnhiOpvSDQn2ckBRVHnhe8yu/nbYKV0SrgJdjgdLSXDN9kctn+XjwM
         GRSV5X7syXYKIYU9Rq6T8MGXB+fQCSmR38Wov4kohBZJM8vsRF/PhViYy7eQh/cEz/jo
         yB9A==
X-Forwarded-Encrypted: i=1; AJvYcCWSTaqLvYM9RLuRpj2FwGIu9JlQTot0je87810vbRwAksSKcayqZmEx8/vdSh8mswf88T9Cl5yWh47EUsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzAKIZ6RohOhUNcx3hrnJG5/0n1wcOcJZTvTrYvVG9TY/5JGZ
	43+EK8Wp2tN1jBvXKbBvd/HHhZ/Rlo7vgrEqX/wWc9WVPZFPUgIoLgVUZ/X8Kz5Qfvo=
X-Gm-Gg: ASbGncs86eGmBcON+eC7nOcMwku7l/vxDee7rHWYQOX9qwVI/M2KJanBNYxhk4OrqKC
	zUCO4L45Nje4o1n83WfKJImffK6sEMRXKpxaWTDaW4r5uc7oo0s9fxmdYc7BoOME5ih6CZeyIor
	yLbK6Kuj7U6XIq68P+5jeaHYOpKkFRg6x9//wpdZjcLcPOw7rbV1M14Bj1iKBQjP3RZOrQXVCL1
	QsoC7rNbdFfa/mnSio2tPaxFxXA02w+06vzzlEdT+awySFDvDzZsuXw/cU861jRV5fYruDFtsOp
	gdlVp3gpdECi139ijdUJNEwKNB1DQ87CoIUqKebfp364FJiLMVLbF14t9IuzcmyH+As0vIX3Pp9
	z0SIWHSoOMPFYrgd6j6ZeVHiIHIMez/qH5eQpXvfw3V+azgKBAvWtX6J6Krly2n2AX+BI8THeTe
	lLVCYC
X-Google-Smtp-Source: AGHT+IE6YD3b9wlJCqIM0+EJtLwGyyXpMTh1kGQiDpelqE7028RMdOYvJh94CXHwN6hfIiH86d1R1w==
X-Received: by 2002:a05:6e02:3788:b0:42e:7444:b019 with SMTP id e9e14a558f8ab-42e7adfe854mr95756255ab.32.1759596898253;
        Sat, 04 Oct 2025 09:54:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc83c5sm3108334173.45.2025.10.04.09.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:54:57 -0700 (PDT)
Message-ID: <7455752d-da89-44d0-9016-59c6a9b7b53b@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:54:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160352.713189598@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
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

