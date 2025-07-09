Return-Path: <linux-kernel+bounces-724557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A7AFF454
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34AB3BA5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD2239597;
	Wed,  9 Jul 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J1yZ4Q1H"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81201A3179
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098543; cv=none; b=GbiHkUtv3AxYeXy3t79QGPWRLR6UGMCCMpJnHfQiHfwfhtPt1FWBVhaIBYFiUJGxBQcAUAaiDTlBcLwq37+1/FxGCXU46h8jPJxX++D41q8k6Sknm7ist/8ctNiNiw3f/Hk36mWmWvPOI0wom37VU3sdMPyWQiTEDhMb08WgWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098543; c=relaxed/simple;
	bh=g+VRb4yRTwwhPbCi5o2N4nNzKovgla+sV32t4ygzyJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0biX6mwpqJ//WGlYI7AIbPPtv4kPlFAAobHvKQAmPBVkbJ8sdhhll4pnHOFbrFTySBZaMMva1m6pHooXVWfrNg7UyrZzr/c5QDaL9B/HZ2d6Eb1/yGMcQTd77+9T+wyrQwzhzpGN+NxGrah/KvvzafTWWIFQdLq1kFMogrO608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J1yZ4Q1H; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86d1131551eso15571139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098540; x=1752703340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM92HEH5zfsbI+DNlrhf/9uf+uKIrQAwzHfs3x6qnuk=;
        b=J1yZ4Q1HGHdir2/RplwokvcqUoF8sY3AMCJQ/baGoQkYZWVIbUpTnbuCbhAZ41toeR
         RlzKSSHg4lBCEw/Fe3RMw1jbd4m5cstyJVGlmQ2oWsbRrOK16YVYd/cjLllm4DMxKSP9
         WMPMxTQFsAeWLlmv7GyrpDEprW+X451AOWZLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098540; x=1752703340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kM92HEH5zfsbI+DNlrhf/9uf+uKIrQAwzHfs3x6qnuk=;
        b=rW5qwgUWSKmmrC5tXtmCYzuS+MoH1mdrgeq6Zk7lJ/Dv/Q1AhyZiaFx94//pcgOOvD
         OH3RSiboKaIt6FTuesBfi8PQa5Fr3E73YTFrDLzfE109R5BFDQijMO5Ys8wCgxwHLBEZ
         F9YiNVhu9i+FyBS6nyVN9/THimfJqVWr9gqCurvdtY3eaHuV4Ccjq4srxwQHZcx2vBVi
         ZAgRQVQPHS/paUaWAo+hVcfUQE+5w65fq0MPHnMn3qKjd5h401PaYhneWTJtla0oFqrF
         5O7Y2PAx9dZ/heM2UUQTH1vIGFKSL4GGf4A039ld34xEUY1B54f9NIEJ+AJ6v2OqV/zf
         kWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqA3xynQbmFPGTEqXjukgsces2PgnMkTUIke0JJaPy3XyY8mqF+GSLZlXYhaeLrnk0lfekr5rT3ioTLSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHL/3vEHGingyjzjjhLfZ8rBYMFY7mBNrnUah6VHYv4+Ec+23
	VwGkef/RJbJ7z1gXmaiQyZuGyGNZVkf22SaUU//Vb0OGaMZybiSBEG3ls9CMyvEWtzA=
X-Gm-Gg: ASbGnctFixEV6E8NnylGm5AUEZxlMgmKCG+OV2+t1YiQJ7vJB02bIj07i8WP08YsW0c
	I0FFGFVE4TBnKd+AMHUAE111AAQM+QLfj/VLL5fuZNGzhKztHh9Tb7QqMFDXDEl030XSLuaJuHt
	ktxovW1zfCnrUne42k73ncdkZekR/rTaFX4vMcFPLPw1NtEeomjEKngII+ODo2jerTB1oEbVLlG
	VcAxMnG4BrNLp8gzNKgTOv+pL7EaNDY1FbLdLdj2WURrtb1HQ/oFmt2jF3zZUMo4HaCssb2qDzL
	fEhwcovtqhAOmPTPavb+96tvSsuzNYKlhF3m4q/tAlRAgS0iiFmDjOdP0hVeJtAtEjUX05SQFg=
	=
X-Google-Smtp-Source: AGHT+IF4t0+0q5H3KEgFPgq8481bxlPOMTECM1/CqaWW3At5iyB3YCAM6l6cXFj7NdHfrSCvWvJWfw==
X-Received: by 2002:a5e:a607:0:b0:861:6f49:626 with SMTP id ca18e2360f4ac-879662c069fmr167682139f.6.1752098539767;
        Wed, 09 Jul 2025 15:02:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b0ec50sm35376173.119.2025.07.09.15.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:02:19 -0700 (PDT)
Message-ID: <3bd4df4b-24dc-4700-a7f5-4c32c486bb94@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:02:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/132] 6.6.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.97 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.97-rc1.gz
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

