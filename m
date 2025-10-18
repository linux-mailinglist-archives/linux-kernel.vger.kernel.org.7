Return-Path: <linux-kernel+bounces-858896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606DBEC2A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3220B428010
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A62137750;
	Sat, 18 Oct 2025 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wl1kk6VK"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D226ACC
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747114; cv=none; b=M09coY/0zBlAs1oRWVd5idb7IeEN8T5hNOxjdRd/m3BRB8O1R6Yg0nF59X0qZDOxRiN5HHemVhHmc2LJqcS/y5EqBWRl+WaIQTTspbR01aKtCP/4nyaZTDW99D/1Uf805ZJQRZHAMZIkzfhPirAs1ybkVoE3tkxDq5bX41HUd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747114; c=relaxed/simple;
	bh=Boo5q2fEiDnb5Yw1TGoo4/sU1WYR+nze8bhNsT/TMYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQXuOqxFv7v+JMk1aU52Jpj3Fg2ojkJJ6DvAtF4kH2W7CN0JuNsc2mji8pLfAajJvPDVoda2AicaxVBzc6jdPRzit8ssZlwpdxBM5J6WK62uqWJ2i6oy3zRqeiFaHyNMranKRo0I5JjqzATVAsaOXeneI2ZUnkgVfxEPfovY7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wl1kk6VK; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-93e2d26fc82so226152439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747111; x=1761351911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5OIGFJ3C3vAizbGtOqivJi6yt4VdvmhKJruwm5miX4=;
        b=Wl1kk6VK/w8vC1QrV8iNPCnov3fKqRBaPvSDAmiI7OfNW532RphBDUB7gRiXAgfO+D
         9uAuYcq4CndAsl101ubUI7fXtfRtdh9mfCMD+z4sQTLPmuj32NIQkQZ5zDqDL9gIILfl
         9buv7UFEb3v/iNRC37G9i6x8SVnKtaFJow/dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747111; x=1761351911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5OIGFJ3C3vAizbGtOqivJi6yt4VdvmhKJruwm5miX4=;
        b=IC2eQDKBgfc15gxixL5IhUgnuZvs3A+A4MtfWeVS5EydSD6S5IHMR5f9O4Qk3gW1QD
         YJ6LI20THavqfCbAp/KZcMH46snlNsKFC6kJ0jeCl0ApyPtpfRQBLDcbE9G6SJ642sLk
         XyVcPN50RxP8PtX9S6h/qnEaZLpantY0pXnOS57+Xvx4Jwum0OiQMD8cGEAcQ2ZJOudD
         S+5rMcDCfnGzmTNtKcdOpLp5jE+Rn5vktCtlTKyE/L8ETobJVKALBmaQ7vqBai/Q03U6
         rY+40Pxsjmmc5VCeIx5V7hAXsdNAMSYRA6RODyL5b0pomdCfZV5s8n4+iX+HSF4VsM7G
         ILUA==
X-Forwarded-Encrypted: i=1; AJvYcCUKgFbpuapd6SrwasLzjIeLicL+v7dESTJof0Lp55C772/6h1bR7J1rxHaA1ohSdEO8jejbo1ofxjFdKEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOc28ISxC2w+pvI6bqsggj3U9pC97bMRteO84KpCu6LaFjci5t
	Hcq92VpmXSiAJqZJ5VcA77YzWMpNZA2+NojxSldph4lDWkWIa2gFmr7yyGhfLmRVXEQ=
X-Gm-Gg: ASbGnctqajP9qDmqVG8WAK5JtUTfzY3cM9YR+o23BWkls+j3XfwATeTKeHDtrXrMpLM
	12wSBtsxIElU8n0hdn/A/NC5oe7+PDlwfGV1dv5ME1zxUg0Y6joXsTgUDx6nwVJApY0iJ+g3Vjz
	ntPPHmLc3M0qfwVuZS3ZtlfQ5lD78pQo45rmW1NDp770OFnTBGFa3J/Qw4mvXMxpv4TyuE6HqWL
	mY82Lys87+GYI3LMWDdkKJFwVXxEC2LczABTPCel5txAYjB+hbYcDRus2rDyzuBcV6IKBPqCpd0
	c4F1jZ9NtwiMKsYha9Vwk1zh0SqdHoExOMPd17AXlYCeXD4TzizbzJMvC5aVh0q7qRFsKPe5Pq+
	w1bqXnkQZg9IynHwoClinyQPSoSQiTHFw218HNLMITPDsiThZkbw1VTqG6excHnyQrXJtj5tNv7
	MQayNcwh4zmiFP
X-Google-Smtp-Source: AGHT+IHppeA2hPs8LYCDhLY7KevVOdanbHpjE2XQVUuhdAl3Pt8S47OrsMyYRzUyr/ymQV62yGgSFw==
X-Received: by 2002:a05:6e02:3807:b0:430:c0cf:7920 with SMTP id e9e14a558f8ab-430c527bc73mr79338755ab.19.1760747111397;
        Fri, 17 Oct 2025 17:25:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d06fa6c5sm4829095ab.1.2025.10.17.17.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:25:10 -0700 (PDT)
Message-ID: <1d63e732-bd8c-47bf-90f7-def9d7235d06@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:25:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.54-rc1.gz
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

