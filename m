Return-Path: <linux-kernel+bounces-829798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E2B97E07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E538F1893A30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF94146D45;
	Wed, 24 Sep 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2+ryMD7"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6113BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673798; cv=none; b=is71sAz5V5cDNdoK4aJaVStw8Gauhp4tZZVzWVHjZMeujt8oug4Nf/bj65OIHwn0nRoiQy0oJsRvFCj0PvBJghKfSDUEJthsjZiT3lkjEQVXuwlGlpsHJIVWMpZLw5p1vNwTdig0geLinBP+hjmxJWpOgPjNVUE86t+apNwDoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673798; c=relaxed/simple;
	bh=naM04PjuUlO+xdnHVfVxnmrRbVNoRT3anIgfuBPTHfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghyWLzT526gcyN9sPS2jH1wftbmehCUK7OQ6b6cV6cEqkYmFh+M6KtJPzIAT5rKcbgIsjxvXI/4gXqZ2yUdU74syL7FtMh24FcVdp73kLFJNWZcnegMd0bFzcy5lgxFYFmjm+l/jssfLXGU1g6IIyGIT5YdK8nn9ADExwEhwavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2+ryMD7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8d593793af1so18728339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758673795; x=1759278595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWZ9/JruCDlDknEZ2K8CsMBaKtIxwhOiVHBk73OP1Ik=;
        b=O2+ryMD7Z7N6VMkOcstbP16pGAdvlzfyGULKP6Id1FyImoWriO84Mnkc/EbaWf7251
         0QlhNWBrObKvGeE7r16ePynDHmspQF4bVexUjaOu3Q9fXOyEv6MAnAI2JURD7lgrFKrH
         GoQvni2V47S/SWp4qLy+LSoseJY8oEly6vxfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758673795; x=1759278595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWZ9/JruCDlDknEZ2K8CsMBaKtIxwhOiVHBk73OP1Ik=;
        b=ALe+mNoLszwa8/vFvD+Yk4gFlYSgIA34Z3GFe2JsvKRMZn5/rqg1dAjHjv6X2pJt92
         kJnKwOAGyONLPMr/CtkPMDaTo6H6j8qohlK0gLBIrj7ALuW3XSUb5HtP6fqQq29/o7un
         aHsZAx8OTbOHD5tPo5J1o23lOi4p780hvllK/yxUPa098HPLHs/e11g5mEJy2TWFua5p
         55wb16WpHdOZQ6+P4qMvrw/OX/A3aK0OgDso/q7MZQVD9vfJdTr/ZhteWbBuAcTgTV9A
         5GVBfrfguyA/lYnvK6Ixffwcd8FZm6A4uf8REqhLsA/3PEvHIqdpUgjDC7n8qYb3XkAf
         w1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWt1pSmWHCHEdtJ/+nHX18p6NMt4zdcbAQf0UAWiMIUsWjSxH0QM73K0ee61JbCnL0WhtHEj2lx7E/xrgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rHAXhnaLpy64s0XLcYuILtI0A6NuXiyWLSQhhlcbJZB6zLbx
	xAN2TcBSc5Oy2+Tmonq6FcFmCkPL139NcjAaZzJ7IeiSrhMGg+A0iIhxqVNCJFjjXzA=
X-Gm-Gg: ASbGncuU43jrl3RbCbLcKbmIrTyrWvRviiM4bhbcK09woDW3XThUl24ck8pi3zvkkzS
	NAfXDvbMzHVlLnZUcLRtkl1vIORk3tn69MElSFiKduL8qad3jg9y1NdmQzW4kWYtWrTCssMMcSC
	4p+gqEgMcRYo1ypaf3YZpo9HtQrXE+AuvGXN0k/oee5y7c48no4MfFerlclKf6rv4aZPBTDEJjg
	Cjuv+hH3ks0UI/mMNcPJPwKKQ7f5ZQIByY29VLZjrjSYNPGKedO4Qaua63BHVZaWbpZY/LoJA51
	M+t2CRHHtX6XdOJsOytONH37Mv3UagKpbcaz26hM5YcbNE+B8HP31Ff3CNe0tFPQXXxCplFDMS9
	am41ypY+dibg+U5aei4qocjeJSchRZte70RY=
X-Google-Smtp-Source: AGHT+IHhU+JZu2aqGQA0/LLnFJk70f/QV6Wcnf71guu/RWN01PgptATucxSvf33EjWlyaZRLKAvMrQ==
X-Received: by 2002:a05:6602:641a:b0:881:4b5e:fa9d with SMTP id ca18e2360f4ac-8f543776c01mr106084939f.0.1758673795487;
        Tue, 23 Sep 2025 17:29:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8ee5e2af876sm50376839f.23.2025.09.23.17.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:29:54 -0700 (PDT)
Message-ID: <9c0b57b1-e749-40bc-8c45-0658a8b5c960@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:29:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.108-rc1.gz
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

