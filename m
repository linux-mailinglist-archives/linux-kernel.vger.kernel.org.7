Return-Path: <linux-kernel+bounces-896300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8971C500DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C287B4E5194
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2C2F3C32;
	Tue, 11 Nov 2025 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrCLwLiX"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23D2F39BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903709; cv=none; b=BiUGXsZtB/DnPhjJATVk14OsKZaSC7R93wPbrd224pkJP8MjkS6AyV8ySH67xp5qJcRqQmYyaKoYcS82oGpAT3yXjESC8eICsQOT+NTaUV8rXAsfFY8OJERydfguOOdTLwW5kGEatPAw4rj8IYVWGjIblb+340qpIpDT9xef48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903709; c=relaxed/simple;
	bh=SBZkH1SK4zEtlic0reoqSi8cs9YBp2mCAARzFUtLSMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcwyznbyNBSFZpuLtUecVCqMVCb+j/YIkOl2OU7gvXGYiFLg+7DPFokuryKVkdDuWT5SikKMd0mcq+D038QBH7ufWnkUh0IJ7D1ducKirQfvgLJWa/iaPUC/vaHigRy7aUIDQ9Z7+ver7+TPdwhiNOoWP9M3XOwcCpHJNZx68qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrCLwLiX; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6da42fbd4so114511a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762903707; x=1763508507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdmJPBDhXZMh/Cf/AbsXERBVSsuyRqEl9m3+Psa35qo=;
        b=BrCLwLiXyoV6npX0HPODujsDWJ5ctVXL3DcCVWnvULU2JzEQfAjEIzufB6ToAZDaNr
         G2MEP1bAlYNUSFitgAhr/Dp4AkimXu68RuPQPxzpX3YVgYgK9QyPilY9SeNA3UyrN/d+
         F6vBN6jVW4Ae5OIIumz8wMwZMsY7/EcM9Wuug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903707; x=1763508507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdmJPBDhXZMh/Cf/AbsXERBVSsuyRqEl9m3+Psa35qo=;
        b=h5AjfCru57ytkzp+1kXvKaYVigtx2uWOGGdRxmUiYYw/C/o7OZSGhVIUqXEf39SI+c
         dOLS8qqEo4VV98lX2ztvFzFDpTNSSGLPzJqIkNOMgkK5HKTLSSMXi2ScLY0e2K75YW/P
         6v1otNYXkofEyi37ViD9IGx1pzcPIyjKzveGalWtXmKq2cxGsiysbmLyiRcIrV0bG0MY
         SL6weET9A6cN6KkLAD20a7WTowWZyKMn2B9oM5JyQ2L5jXQ8Ra46HNKk+YeD+DK7hhxP
         XOCtHeBm44Uihyct2ffH7HZRUCP6SMQNl9bqBNwDJCUuO9sazyZ4yDLUH1Tf42OLLECU
         h81w==
X-Forwarded-Encrypted: i=1; AJvYcCVvNjlP6gs59+iCs6OBzGc8xbzRN7rA472BuEmGeMRFlkK1EYGQ9Sql2fKYc6aFtpXPWwmDoLSyE5GqIOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPBFm6YFSemSY3PBIEoY5HrjNmDDVZqhAziMs41ZHFa6lMdGP
	ZO8M0Qn+BwlxIRPRUtwpZB6Mwn/vxMGUee0YZt84s2vcdBBIKqSB4I8ibbT/QSPpbtY=
X-Gm-Gg: ASbGncv7t5Vf7qQnHDsJayxj0rm3fKtcA2s/5bPiEPaVI2fpPoBMcN3/7d4qwWa4wJm
	5cZ0HWQ6r1444O3ZizwOHKy8QQ1B9AHB+bDY994uYqFRXcIgY/CnjKxiyW+StL1uCCMkkLYwQsC
	ZIwkRBU9ArH0NVl6+d+56EBHaX42Kxh1VW2Z/5esK6z27J9K4KsDww9PZtfzHQ2PgpvtTSDlT4P
	RYF+hGtd+gz4ng8tglFN92Zvta6desLVOMcC0mLzR4iwKnHc33ye8bvOrAJPGtTyfD4ab2fXJo4
	F1GIy4xQsIgobnlEr2tPGKu66d606aX/ig3t6pv/oF1hnNchLmIguwMXROgaVpYvdgwaKQgq0SH
	RAv2ms8OWdr2AFwY43bAl0Xo/Z87ADb9V77aljdPhBHAzZmqEhdAKl6kj2Q0apfJipa1kDpGeCc
	mOoxNmFaNTUd/R
X-Google-Smtp-Source: AGHT+IG8L5zMLS2ATSKI/dMgNAQn9ETt4P219H5Z9iYMUxj68WRlOpHr2wSz4E3cI0EJtHnsOTWVvg==
X-Received: by 2002:a05:6830:6e98:b0:7c7:1e8a:c9e0 with SMTP id 46e09a7af769-7c72e3ce55fmr509116a34.23.1762903707177;
        Tue, 11 Nov 2025 15:28:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0fb491asm7617540a34.15.2025.11.11.15.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 15:28:26 -0800 (PST)
Message-ID: <81f3e0d7-2625-4183-8d42-46fc4deb70c8@linuxfoundation.org>
Date: Tue, 11 Nov 2025 16:28:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 18:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
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

