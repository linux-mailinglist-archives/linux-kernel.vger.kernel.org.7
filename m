Return-Path: <linux-kernel+bounces-858895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CABEC2A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BC6425409
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5486352;
	Sat, 18 Oct 2025 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgmskAGl"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602A8634C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747076; cv=none; b=Hud2NiWl3CaG9dvKOoE39oFua/38oNn6VN3kvDvVf8KllGFjxp7OSOUjR3ez3U3DexfP1n5w6mhChNhmOhM0e60hGBYel1w6zvlT6oVgMMLQWDP8u7ygrgQ9QoGcGZ+Pej04yeHYV5O6wWZFk+m0zNw4FI6zllmfKUWCzYmOtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747076; c=relaxed/simple;
	bh=U9IrYANTsLnJeSvCr1DnvWP2LKuNICWu5JtEQxnWi2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWtvgNX4J629D/RhoUtXtz8hYc7NiQ0Fk2P+jbBngC+8jxTJHNDOXPoWyGhhp25NxtUJEEp7SZ5u61M0jc3KVVeajVhqVfTiIQ3aL/JE5wsJpy830vuKgaFG/0tyBm+HDLoIgMFOHZLtDHwHoPVQ8ePcnoP6bjZpC35Uz/q2kZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgmskAGl; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-92790f12293so121948639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747072; x=1761351872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnmqLG6mD8qqWt7UOjgypO2NRulVIOp0w81YmvKj5/o=;
        b=MgmskAGlDarCSTX2cpYtvVL/SZtJsXEAJz2U5IuviCmBOvOKIs1fOpkLd/xg0N/sOJ
         +J6IJstL3RxBxa7oQRcuvRN2edfO3Bz5QIG2yosM9fdi4GPdj3MOEI9ShZptCoBeTUh0
         yvTnwh8WxLwb9ud7yufGD+E/7qjDJALAwSpRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747072; x=1761351872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnmqLG6mD8qqWt7UOjgypO2NRulVIOp0w81YmvKj5/o=;
        b=EU9VMajh2kUfNhhy0iZ7aTUWLD5tcYuFE4FSYRc8DVvVhJ5gBFWR40D8xUm0szsXcy
         lEb1RthYuvDKqiwEVAC5Zdn1dgEGCb5+FOaMefSVDnV4s8y6RxHrG9Dozj3yOq92ajRK
         1F994r6eqFeOtIr8BwMGWRKpMIXB//AklP5jHhiW/8nnSZDOGWpQMiUW5wSEZvNtpQqa
         gGli6xbTTYmITYWSj1VyKGMYaPGEqNwYFc3TP1Lz+H55xu/9uzHXzBU+YIUcuXy17312
         +Ma8aWwQWlu/7ke2LrbB6fn/zY+NixjSLn1M7+e2NE/kALMvZzd2iKvH9xb+/UOYDtvK
         HPug==
X-Forwarded-Encrypted: i=1; AJvYcCXnCEtJGVEQBHfLrzFl5GvBeCyY6G+ps9FvIr58XoslIHyftA2AAe4nA+uWHhOgUxTfsAZme7ZVlvJjIoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUl8CuiV6LqUC6fUk9+ff+i2uxuEv9hMDGGSM5WQyBrQp6CrGR
	GmWbaynJo2zs0BJ4L4F9fd9GE++U02PhwMf4MOAvLQmMnJHV/vBe+BCi87DpR3lZawU=
X-Gm-Gg: ASbGncuY82KdnyNRmPKS53E04q5WfmcMhGBWFCfigUXe31LUTP1mrV30Genyaba0omD
	GmgJrOYBIKdOfeiNCpDLM8RZ7ZSZmTLRSri6J9oksRy9EoS6+12l8zCuf73C3D62SwTbVQA33Fz
	Uozuxh0V9FmxU7Jy5NxT/jLYBtwIxF9t4ApKo9HJo70E3epfTyQM4pHVzi2YOLEZ67PhlJzG5+h
	0ZYh803Pv4nyfZP0CBptwk/2gOXPDvFH+oGQXU/WGtV0t0JS82GtJuMVCARvXgFBrUXiqNBb3xJ
	H/tGNUZR2Ai9jeTDxsyr9NJ9J2cjgYqLbf+/L6JdRleZO3KNuyQzyimQ3xUxwuOsGNWHatLaoBM
	JRw/il+TE7NukTXidZjjNw4+6o5V4ErUA7PlMxZ/k4shtxNMVqE/gZ/DwxOgwM8oxQrXYhXJte3
	k52N8Tqkmxz/8u
X-Google-Smtp-Source: AGHT+IHx8toFL4okOKYH1BcXiwIuVau+vE6aOwtifNCHVZJjzx9BtPHT8riQx+rY+R82cWq9XNmtlw==
X-Received: by 2002:a05:6602:2dc6:b0:93b:ac2b:d63b with SMTP id ca18e2360f4ac-93e7634f25emr896183039f.6.1760747072392;
        Fri, 17 Oct 2025 17:24:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866cad8fsm40199239f.15.2025.10.17.17.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:24:31 -0700 (PDT)
Message-ID: <bcf10471-28fd-4949-89e7-fc1fe9e5df94@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:24:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

