Return-Path: <linux-kernel+bounces-853174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA346BDADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402A319A46E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0930748E;
	Tue, 14 Oct 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNwgBZ25"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90607308F1B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464366; cv=none; b=IgrEWFlvaKgOXkcrR1147cOeTD3YxLuMhrM2k9dXEmmwBcZCMvBBLnHDoudnDj2cB9gDNGpQOlP2Zm+eZSND7BmhxGEu9f9V4W/Y85ol/XCPKL6XLF/8ZSDFCYoA7OZxVnrLqNkQCLcy2sH81oWg6Z7Gi/boSJitYIWFine03/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464366; c=relaxed/simple;
	bh=Vk8hTPSpCZlav1c+s4Whx35A6sxLw90BVbohmPvOMCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liWMKad7ZYIrL88xMpjoYMuLp9ytifbn0aSnCb72aiNQGbu7zFgqAtIThF2ATM3WXynyMRUAF0PwptI8xQL8A9+F3q02+OuximHBzVdWGRtr1wgsS5015tFy96tniG3daGwjgmeD+qNVHGF7iX0y/nKBjx1XB2ajODQ3xKLowWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNwgBZ25; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so164513939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464363; x=1761069163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGxq/8VkxT40k9wgER3vpLBqBiF/8xTWMryj+EkLgt4=;
        b=DNwgBZ25P39+PSjhMW1xeeESU+UlIXe5mtsZBHJcGVvMJVxNmk8MeVNM1ItNhXafF3
         PKn6V8v1QDfvpPRSmbSw24b3BxX7ENuGFwctvOk6XS7+nm9BgzK6hOrbyQxprWPk4y1K
         RvtjY9AAcVATGm0vPz0H7JLaEX2gfYm1iE9rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464363; x=1761069163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGxq/8VkxT40k9wgER3vpLBqBiF/8xTWMryj+EkLgt4=;
        b=l14dsw+M1zbUBjzCZUOgMGkrOTwKnltoJxf+FQLJ+i/ccafT3EtA+nQTVLCJ9bZCgZ
         y9/7hqyuuOGERAYYISkSlBIVsbth7w66KoFr1mnJqjKp5ciSUzB90Qow/Pw4souA4isx
         EEYdjIoEuBanhgTaZUCKQK3VNATYI1rJ8MB32sDm3MK7nBEqe6QlbRVI3Wh2rpn+PslJ
         w/3t9XUz/Tkze8oh9P7rwChNC3piL0inxV66UkGRakOQ4JALwcjLs7ek6kJ/GtB8C3wS
         7lp0h+YA2LQI32PT3AE0h7MwML3t4PnF+Trk3Wfxqa4gNw9YmM9gKQVDqVnAaOnvyb2v
         IoEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFPfvL5HkxngzO1HQDWXvmY8OzZMOhJGkSShn7IidMlpQdJHItLeN3Vd+JRb11zSvxt0pbNlt50jXhE4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwSgDmmiNtnUzCTD1OXRvSSB/PSjwPnhTsKbrpEKJDhxfbFDq
	F9IebwjyD4fO+7hYieB2vLDcPl2nNh/M9Oyjn5iiwYjGgEKcSXKmJllkOEE1SCRghQs=
X-Gm-Gg: ASbGncvt+CyeiF+VIKa7u3+g5vPS0mmmGLbSDSx06plQy5ezWP+oqpPM10TN8bTZcYK
	DZMxgTFELpahKxFUYiuAqbk7OfXPOeUcJh0L1YENJLurB1QYtjtz7EkACQfySKGC6qOrOVbz8SV
	Ku1tAWRVS6ebi0dOQySAt3lx7sVMfoH2LsGxYcXu7rg6RJjXOnfaCBcj+nfyZg7dq4WHvYiATGI
	0XncTA+jKrgXyCMrpRxF5S1eOznY54XS5OWo3fgQj989zXCZZvsjHbggyYkjW2fuy5xl9+61CIV
	kJF/0BzkCJ0GeiLE4xM1sURpvOt5qeGa7c5z0R2Gpq2+PFs3BEwClk5Db8Af2/4dGlHGc759bB4
	kHS5Wkf2rb1OYmAXB45hK1ybGvT1Nnm81nNMNWnFYRc01QDbMBOfS0/ueHafScxNZ
X-Google-Smtp-Source: AGHT+IED4NsTeiB2tjQZ1qN+qgCtT8LJzFvJwI544fSE/j1qtAtUcoMqpbm1m3kTi+yIqsP0iV05WQ==
X-Received: by 2002:a05:6e02:1fe3:b0:42f:95a1:2e8 with SMTP id e9e14a558f8ab-42f95a104bfmr177063845ab.24.1760464363522;
        Tue, 14 Oct 2025 10:52:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a7c45b1csm4645205ab.40.2025.10.14.10.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:52:43 -0700 (PDT)
Message-ID: <6e9ba617-8731-4a78-bb56-eeecc6a25897@linuxfoundation.org>
Date: Tue, 14 Oct 2025 11:52:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
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

