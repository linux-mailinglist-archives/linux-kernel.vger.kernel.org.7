Return-Path: <linux-kernel+bounces-839268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3BBB136B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6700F4A1508
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B427B33E;
	Wed,  1 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSAFeM4Z"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E79286D61
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334763; cv=none; b=dBHQT7n4MAnRyYgEfsCC8L7lj23oV26MgblqEk3YJMderXJp+t2xQXtgPzu8n/En8UWV8p4bsuywBo31tWN6QJvIxQw/HPFWa019Pmp3U68VmNXaHlfSRLRj5jO4wfIuf8gkJMx3H6tRFTc4GJTgmo4jT+HB4DwwZoInQdC8mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334763; c=relaxed/simple;
	bh=VJHEaNZgpUqWWb3y7GCl9yOli6rthjNjxN6lV8kjhCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzAOHk8QYvg1hmRvTApY9aze/fCauvmYYl7OGymWXBOawhIzalC+P8sYSOw5+IXP3n2QaVU0Ni264gPpEaFov7j+rRhM/1M67os1fp+fandHzBIRdaTTFJS7LzFd+ti5J8JVSp+7LldaWu5no+Q3GFBNIhFxqVqDy7grbXeCsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSAFeM4Z; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42d8b15548eso16225ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334760; x=1759939560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcoX46bwfl5dQYwcLHAK7OapTp8NlFOAbc6NCmLaSLA=;
        b=OSAFeM4ZGlo4fJWksfZhr749AZLbZ6ebGTQMgar+oipRBk0YiimQewEu8LnrXqxTnD
         OZDgwh8nPTm2sPi4uUwABYYS3kh+92XSvybo7rcowxCLq5Vu29idnz8EQdd+FgxjnUr8
         jbPxAXc+8Vd2EXjsB3/CCb0g6hRG6cIFt4mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334760; x=1759939560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcoX46bwfl5dQYwcLHAK7OapTp8NlFOAbc6NCmLaSLA=;
        b=tKJ8wSspMx+5l+FCjyXIID/jUyWQDNeFbJuSKB0bZ6iQ1seeDoCbeKMvFnlSQTvyo+
         2eGgFsEVX1QiLHp+ddpCrEcN2K/0JP23gyeBL+3UxO6218UHiY86H/FCTpPp3clC/qvx
         GcWJOoKw0lbehf80UhXqhcfo+fuAsjZ/OYWRheLTRoShOo5EWz8YDC95ZmM2YWdhuVIz
         Ah+13Go6Np5KXF0RUrEhX0wJcZfdxPqTvA2aIzdmfqto301fD0NopvFoXCm6G9JD5Ift
         QUDN0pe6cYORjDxmBW/NvOib8vtQz4M/0G93mDVMG8gj/18CgluqZidEknj/d3nwQE1V
         swVg==
X-Forwarded-Encrypted: i=1; AJvYcCUNHA7QAhFtz5zh/z1UNSI9nxoECxqVwXykjSUYddl5cJusD+W/OA2DqfoKqT9qnpPBHUKNiIklrprkEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb6eKIgYLJ7FYi461JUGl/evRzFHlu4VGj0bURAqyvj3CYBjb
	1rtDE28MCDWLSiN7PUdciRTVl8qnSW2UHux29UkEuBfHY8vLhYx5CDjujwOyygpod3c=
X-Gm-Gg: ASbGncsL/MPOSbaShI2mEQRizHRI2OlhWWbbxZmdNBzQ5OdaebYBGvNSXLWEOetUiLk
	2DqZFDu4McslraxSY3HMYCVOR6tLAgfC2zkS4qYn17UDiVHCz1U48DGfcTa3lKrp5+KV6k3UKyb
	jIRGS+Yk8qpJDnLi6Wlx11wIX5l1xV6fH/1A56QFXumQicRyH5qhltmSEpAU5AN0CFyrdcnSPhh
	gxRgypFV9sy9N0qet1n6NLsy5rh6sP4f4iMxASItCk9BJ0656N+8UVTwjMF4+fcyvLDHajrygiF
	w3TMi0za5BCfPU/FwpDnuJ8ai4Ho1BrK6dSp1NQ7UtsewX113Q/LIwvjA5eC0GWsXxrgRkO86y+
	Pcr4Rnhe+SXH3ZX/qWl8f/yj0rxcmlys7BKEy2i3P4rsQOLV6id6liYuAwrk=
X-Google-Smtp-Source: AGHT+IFHk4Xwk9RArCCX+gxR924eyLozP8mlXDS8m3rsfRvOu87qimTOaq2cLVy5Bc0FK8NNNeMH3g==
X-Received: by 2002:a05:6e02:17c7:b0:425:73c6:9041 with SMTP id e9e14a558f8ab-42d81617930mr55114785ab.17.1759334759664;
        Wed, 01 Oct 2025 09:05:59 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-575e72881b9sm2514685173.47.2025.10.01.09.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:05:59 -0700 (PDT)
Message-ID: <9c617b3a-7978-4906-a749-98d6ea1a944d@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:05:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.50-rc1.gz
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

