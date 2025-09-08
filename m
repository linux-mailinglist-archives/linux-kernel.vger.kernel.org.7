Return-Path: <linux-kernel+bounces-806885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F46B49D20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49B21B208E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773942EF643;
	Mon,  8 Sep 2025 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbC0xkR8"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7152DCF4C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371931; cv=none; b=tZzx2GcUBKFU98GtkwtXegniLHVjeTcmu1XYNBVojemuU11bVJ2X32Nmbj1ib6uK06CLmzzcAx7/1fcR5ECnyujYdxdrPLAZnyByFkoc34l4SMYUl1SC4hyZ9vsJyB64dq6c8Z5PvCbEtvlq9Vk7NC5FYKZhkdzFPmlbxDtUcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371931; c=relaxed/simple;
	bh=hfXJRklhNrqNgOO3gqE89RdVEWhgtTk71OX57h5wA2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXk0pwkRlV6CakfTwv7iTOMQC0tq/m1B601F7g47djb8pA5XLQtn31h914+93vflIoMzzYt47oNdC/ORNbCCFsKSor5IhbMGwfouqESkQIsFVERo66lv1T1zRXisQXTLQborPcsGscUnLMBshfzAn+9li3asz7yQLZIP2aXw5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbC0xkR8; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-40613af807bso10193835ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371928; x=1757976728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K80z516Bkbs5y8nHg9W5TbWub0+guzt3PhdAiDrzrS0=;
        b=IbC0xkR8Tc//ihHMs9bNL5jF09t9Y+VdCautYVZJL9hypI095UFoNFfPhgF0gNkGdv
         B70ufS1SPGIXdX/DRIJ0GLOQEUSB4q14XCBGKi0D2frDFlSQdQqWkjzmxvTyPDPKmfRf
         Wx9TrQTNsxvGfeL1Wat67AzKhkmjFG+FRXvvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371928; x=1757976728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K80z516Bkbs5y8nHg9W5TbWub0+guzt3PhdAiDrzrS0=;
        b=PRE02GzXDL/fv1ZvjKbL7PV8crH5udq3r4oQQhbDgCHN4NeQJ/d4Sh+kn/4zlHKfjZ
         eSxWiVzYj4VzqhQIvDzuoXMOTnasOCEOVXVUa0AwwQUKK4D7unQrzwBx+F3/bx4Yl9Zi
         Q8q+X9fi1aBQH5+HJBj6MqR86MMnZisfXWs8+LL9pXQblv5J9tOI9GcuXlQS/n3w4Gyj
         yCPh8aXdr5elcwKX+/yiS6SfblVmghjANbxKuH5g6i4iDmf8O3WuuE+Rza0NstnDekVM
         huWNECKulVMdjRc+kKL2bTtGnetwS8aDHZH0IOa0HA+wmC7t7Chyq99a83Ac58yLzGkl
         x1CA==
X-Forwarded-Encrypted: i=1; AJvYcCWwSntwyFhz7rXw6PIfo1+zQbTtWGQlS8fVGsyl0KZNVwo/Vhn040iDQh1qeyh9+WiXYiVQcneiobxwbc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYwy/wB0jN9OYc11Yc5VCLMw5dKjZogPfozwN31Md6XxdfUq5
	Ky5REeKzD6A2vLvDLaSsCpL+IurlUpUQTO/Jj+2aoA5xRzx+Eg7XBLwiXBjKikym+Yc=
X-Gm-Gg: ASbGnctgv/zgZNVLUi7QDItOJf5fYX0c6ybDS+mNbMmudc0+pAjz93QNYcPve6EH5e/
	n/c/qyE4ZsTCpUeieFx4T+3JXh9di+dlJkx/+xZ5Iu77PstOzCGsCjgfq5ziaR+JU8rZpGGjD9J
	Kl8TkvfVkL9SBLWhM+bSvCnwOIH+00lteM0X7x51yMrjeXz7paZuq5mGDDM4wCFcu5CRojPmwuJ
	vM+om4yij6GD0+Lb1V06kZ4PL4+S+VoFNef2ddRKPUjlaziwsWaxKfrBWFYhwCQ1NTK+Jthgucn
	oepkQn+ra0DGgmRuuHgcMYL/IjkPuhJqg2g81JRfVyQx1ZWGjwJSuP349N/rClnE/+Hci2F6rU2
	9xgKLNSTpkhDjrRJCCFkzvhV4ioVDR+TuiPtHhsBpwC4gQw==
X-Google-Smtp-Source: AGHT+IG0SswkXVluvMIZNs4Sx5AK4Z0SqnwhuqTZrY+edeQ0Pv/2bKDY5ow0cu/a/aQmpuNgAXzn7Q==
X-Received: by 2002:a05:6e02:19cd:b0:407:dc0b:7ba2 with SMTP id e9e14a558f8ab-407dc0b7d0cmr83195055ab.3.1757371928306;
        Mon, 08 Sep 2025 15:52:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104c4caa4asm4555133173.41.2025.09.08.15.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:52:07 -0700 (PDT)
Message-ID: <3ad4dd69-7a3d-4708-bbb6-308e7d1b4183@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:52:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.299 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.299-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

