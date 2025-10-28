Return-Path: <linux-kernel+bounces-874576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A03C169C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D9F3B2188
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F9158857;
	Tue, 28 Oct 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IraTZj/W"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B32261581
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679671; cv=none; b=YIH4GFhXwEvl5QSRMrRcBk3o8vQU1iKnZbdtYQgNp8aUX0UBW1BzdedAVTrfPUfpIwAphdagq9RX99CSOpUcp4ZNi6/9HsFjJIzb3Z3Cj/Xvux83moFN32/bDGP0Oz70tUmnSLHO1cX2uAA8LFt4yfTcqQ6wVyYvbzrPO6n2hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679671; c=relaxed/simple;
	bh=e7za67gpaMzXAAnduU0aQ85fcHm086VfI4xydx3Us9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6KmfHjV/Sby4jdYKoKzcK3kx0F9z+GvCczbIBxtuM9MoGQWJ9a233kw2+GAVNTwIkf9b2hXGwSlUTF/DhgEzuU21Su+nx6/hiORwHYISkbb+ZrSvgxUSzXSPAI1g2BojMaz6LBzgRx1B9fAx3Jj2hkcSuXIrvb31FdgpS2Qn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IraTZj/W; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430bf3b7608so67532895ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679669; x=1762284469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV1bENIf0l3RXjjkTJnnKUbQWBjIIJGeXOMl9S4eqCQ=;
        b=IraTZj/Wv9BoUoZuSYE4Ylut8J8Hj1DLpUzhFWE5Bmzxee5FVXzhHA1XbMdhncDrSL
         JsG/StAvHnnn8s9FaNpzvbdQUtEqH36K95X6JOvdWqfaWkf4wM3/nBk+eEVcuKY7AZKl
         gewz5yZmuShSq1rf3WDMsl8o263BCk/vu0k6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679669; x=1762284469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV1bENIf0l3RXjjkTJnnKUbQWBjIIJGeXOMl9S4eqCQ=;
        b=VQvqaKqzQ86OJmdU1oN3crBJxRmoEOlMPqFLgUJSgYl679POdaXM+L5Iu9DtoNLFKt
         cnhNvziuJ+Jk75eVpsl70D97jp0Wbm4hTuYO43H81gZXsZps/Y/slDzxg0akci99ugr2
         elAlmrByDPoDwIb1vHDFJJ8rawGWoNN+/gm01nT5FBDOk6WVOpWS8vNj5fR1kv5G7Pb5
         S4AmkwPxutru5T6KLVJrJkj/RnUa9ZNQTr4LBBB21mh6y3n7bSsvoMypCnYsMZUWszKa
         P7GRaK6vFUF4Dd0Q3AeKCh/AhE/UG4m6D6cxNeAHLdq7/MPQAyWhx6URFfDqqvdDYDmc
         icyA==
X-Forwarded-Encrypted: i=1; AJvYcCW5bAqbDs1cb9zOf5NWDMOQNiMS1+sPjyXF1b1tRK+3wq9a3+Ni2QWUW21awgkrM7zOtzmQ6tkJJuZW+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mNLr5nAiliL2cnOV1UP2pZt9Kc5IEv8Uzd3QutfdpZHN3dni
	PgHw3cnVlJaYDi8DX+uJfhpYv1yv82hX/GRT4k3l2crNvc/SZ478QAozImsSWZZeKUs=
X-Gm-Gg: ASbGnctkIc7cdZLY57ROJCVhw1UHz3tA5vle4g3GW2QQ2VEUqLX/Y20jJ29yZK1Za63
	Z11izktxpfNXd8AdKUfEuVEB4fw+iV/PdgjEngJpMarqaDi89Jg+MSrbkApafd7JYV7tKvPW5Lo
	im0KjQFxdgKd2vVpN31R+syR/T8esnoBElVWflpf8zdWEJANSVxIaD2tZa165BpCx5wOjRkz0AK
	g40EhF5PfRAZgvbXhG89dQqLObqNbCllzXkFriR0tSc8hm+Lpa64AO8IhBJ8PDKgPJr6uxvs39E
	FuzOjKjBs6YdWfV4JmYQ/jAYBPZZ+qxzIQ9jNxi65k+lW21rkYFpLS3WGvPILw5YxOdX8455sTD
	IbfVIHh0PxCGt9BkbJ7eWpjdLLjUtfmQ4cYddkSFMPGVE3pA8uU48n5fNwX8DivLL20he9LSEqn
	TjPTWYu/xGmBdx
X-Google-Smtp-Source: AGHT+IGCnaJwEiI5H45X8uH7EHHZvYqawVyeXkrh+JuUvou4c5LieEIEgsLjfsVja/uVxA+aAgX1bA==
X-Received: by 2002:a92:cd8c:0:b0:430:ab98:7b27 with SMTP id e9e14a558f8ab-432f9064bd6mr5104435ab.20.1761679669136;
        Tue, 28 Oct 2025 12:27:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dc10bsm4734334173.7.2025.10.28.12.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:27:48 -0700 (PDT)
Message-ID: <cafe791c-5f00-43f2-85eb-f083c499f978@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:27:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/224] 5.4.301-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.301 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.301-rc1.gz
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

