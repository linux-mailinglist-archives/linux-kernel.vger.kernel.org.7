Return-Path: <linux-kernel+bounces-829794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C058FB97DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7765D7B5043
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77623153598;
	Wed, 24 Sep 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ek3ZKN11"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1118713DDAE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673551; cv=none; b=bmOiWJgDVbZB0ZEz3P71KvmzFs0p00ZE+5+TzqnjzPUeL6OSs5AshPOIVdSMtSw3+l+w5fxBKjb587I/XUBqZCv2Bo3ZLqQz9qCLZZP81pHykKold6bWqefNakEwv7QGqWz0VvzJ9F9uAz0ML79jW9LY28rByJ8EeSx2uc92em0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673551; c=relaxed/simple;
	bh=5moMFOSWjJHQFSqbTSHVzZPV2Ozn1SebUST8B99iuVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV2saRUYcFZqeoUDgw3Oj51w62AB5/LOf3a0/AptCNRw6m367lJV0iW2ZLlfSvrB9XzmJlX+oDJmJL5QCQLR10xMyDEQw0zIgk7nKi8Gs/A+rZ8kYEjKGtp3BJJLA/b4ZJXuHy5vBjZBEdqEwaTyL5Y9LOskvyEw4IclZzqgvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ek3ZKN11; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso240889739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758673548; x=1759278348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dt+syD8YMODVOGHzdazoi5hpOFsjySYX54UJ/Bx3CFI=;
        b=Ek3ZKN11alhv4UBgjw6yL0U2NvuE5KRIfeQBOG4vuC00RG85ZKvF20ZlkA0kc6HigO
         LI16Bm8fH/ruzSFegJDrlZtqGaQQSRctgljTROIaTzGoHvXNTcBYenzztICy3/f01Ym7
         t4Td/LpL1j9X1xWWMNdPwy2wb+0KYSAkY6xBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758673548; x=1759278348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dt+syD8YMODVOGHzdazoi5hpOFsjySYX54UJ/Bx3CFI=;
        b=myAqk3GS9xxnQx1sghYek9hjK187rPwCOP/rxajLGu90rSWm4c/1WLvZcrL5ekwzq9
         g07bptjYssgnV2q7OCLf4yZfjPwt1IIDVEkXAicVR+6cGK9Sd/A/Niw6vCQuZ0SYG1z3
         5zbvOoN8PHUKYpZHgql/Sk3cbK+h7YnmInHtYFlUoj9b7PUIkHe4YjBlmvubRhT5Ga48
         aXcpwjOQHzgTUHRtguiY1Gp/NkbffP2W2zmmInjBqK0GZG+SiwCzLPjxsgHd0rMjGNg0
         8XruXhf+PVlbiD/N2agGKnCG8Z95fpXb2a5ejcwX+rI+MVRH4N02FMvAf2A0tda8GLbo
         5G/g==
X-Forwarded-Encrypted: i=1; AJvYcCUsJjOzfHEhqteFq4y+h+cJT6M2V/vvQWtx66OYb417jSKpk+LmwHpf7NU1Vg1lr0sqFIWI0we+EH1dwVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3f5yFcUpRzz46ysEn94VCx2o1UZ9E3k0m2F+IWunm5UTTRFWo
	sGt8NZoRhk12ugcJrrkry5ZAO0bQTW07jJOCPq/EK2gtnjYRzUu3yoO68Sv4pnw6l68ho9/w+Y0
	iWrGX
X-Gm-Gg: ASbGnctjZDiF367N5cMZujZsFbSU5Rcawkq7bKidXCz63fwxTtqrHAXV6OyU+/+rqWE
	8M1x48rJ0g6MWSxTH5/6IRtRzadGK3Ibqdq/OSqUBtsFuUE/7g60i+JxZpuNFpk6XFGHP9IEu6A
	nk03U89KyGHS6hL0i7Rei4ifhXSBeYJ4CXj7N/VZExsXl3C+Xw+bFkyJ/zfZlbIGOR6qKyRujc1
	+RX2hcuTEMLZePTmHPeVdKnWv+7GMHbvdpuzTFDZIBO4ytqowNkJ4a6evfEf1zRDIFoh/uJtEu3
	35MaH1SIiXtigChiL3FjyVOqrCBKdydX71HGX+4MeXX+SVUvAwg48oLo3CC/U1WPJGNat9IET0b
	t/L7yH260nNuGSsJf3/suwRJ/owoG+F7Ox8k=
X-Google-Smtp-Source: AGHT+IGWLxq+5GJO0TmX7pMwInHGmPQWK7BTkeoJyzyK+KqNZ0MVQTr9S3UBmomwYpmD1Hz99wjo1g==
X-Received: by 2002:a05:6602:6c03:b0:8de:d8df:e1ed with SMTP id ca18e2360f4ac-8e1c2f313a2mr866414139f.8.1758673548081;
        Tue, 23 Sep 2025 17:25:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-561261bdcb1sm2206193173.63.2025.09.23.17.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:25:47 -0700 (PDT)
Message-ID: <b9749593-7bb0-4ac0-aa9a-f8d68566a585@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:25:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
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

