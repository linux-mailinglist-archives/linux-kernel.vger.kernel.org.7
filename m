Return-Path: <linux-kernel+bounces-865400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD1BFCFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9D4635513F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DBC25A334;
	Wed, 22 Oct 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IEShXZIn"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C4257AC2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148605; cv=none; b=X1d7+GciBQlYzwB+jxtH4czpoEjo8f6oF1VgLBVg+rLLQNI7y3zxpN9Ia9+0F7RCJz4iOh+okQDqe3jbxKpkmkKzZfdOFcX3mcp9z3vZHZF+SZe/R4d38r1h9Yn33k7o5HzDgN0TI6NBj3RUcNsdHIdtLdys5zfxzwfIJCPE0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148605; c=relaxed/simple;
	bh=yZxdIcNjsvsepd/jR431aaY3GWoUemNnmmdOtuw8xT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY73T0/NJ8oamuT33SFh1hegs5nXQzNv61ygfatPEkykygpti7ZvW7Vm8PiRZPV1QXGX4m3UH+3KzcwjIRFZPtg27NjXduv4r2+DYR3hIrd9Pg2U/gUEloaczNewfAegUD3+P6YBJxYUpJykWJenqt0y3blUuyRk4e1DEP3LgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IEShXZIn; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430d0cad0deso20937385ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148602; x=1761753402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpVnSWJTgD2kkjsIK6B5EZxkI+BQNyamIAMlFJBOIaA=;
        b=IEShXZInlVIhkEXILYVYrV3fXf3MRQaAeeTP9eS+gNcL3u5miBtdj+nN5fmvGYOlFb
         b0FOfPq5mhUvXAD195DJE6tw728iO8MKd1I8Vmfdoe1fBBc64CAzwfM3XC6pUI1aovrQ
         sVPIwZBOK3QHFG8Qv8Kj2WE6XevHBF7eqRw/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148602; x=1761753402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVnSWJTgD2kkjsIK6B5EZxkI+BQNyamIAMlFJBOIaA=;
        b=Ky1+NDM0bxcX+ky1UQBu9nXBHJ9kpoU/bDxIBBLSHWp/RHvuUaqVsXkTbBTd7aln6F
         UCT8IHHA4jZtOKHxe+S3upWtNNlVbr1FJg2e0Ld+3Ea+0EMRbni8YYGE3ERy5GFKYv3P
         RJBU8msheN4LuNej/+HHw/nqYH0GqJfW4Qf5yzBmdhR+JFFA6erO0f9iKJyinLgJ0j1f
         Vp0JJDX/oOQ1kHrTJDSXIKfdYw5m9sBR5OrAV1ldou61j0catRQTc28nz8Mzt49I5NqX
         bIeOwcyTsN4s6k2/wbUALeftWsOmTSCP1tZNofHbuCxBN7iQtEoeVtx3188dFvE1/N9P
         jvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvD4f03XBazNJi5kSV6RURTiTfFY66xNMM/CUl4s7qN2dM6W3XFDIJIe7+Qln55/uQK5zFtRToiMkIm88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9z3XUW5vnajyvKjSh30XwsS6nPyfz+OX6pT7+H/hy/TPUdCd
	nWCjPqBjFGl16XxSZS8jGCZr3XTQaOob9VAuJsYFUQPDPb5nf144sqqjPA9giW+sXC4=
X-Gm-Gg: ASbGncvLFWYA0KziAgnhZhRfCT8jE+l3Z9v2ZjQMex+2tnKP8B2/dr+sU8Wz8mOeZW7
	AkUk5VI5m9J/pOO1P8JhgYvigdj1GdZksJIhChvu50d2rmVVFhv+rUFtVixuM448tjmiG7zxmp9
	1n3S0ZvJGAdRntjK7dDd66WOebCKTlaikiGR5hfM5UqYDtEyzOXu/ixYEt0vd1VKNNXnm/TG0UL
	5PYTv4NpFiltSxMI+ebsVbOq2+kqgqoTykxAZ8f0zBtRLu372c4zp+fECBW3OwsIswWK/YlXE6v
	U3TDWZq8S+a+AuGVAppQrs8dypHuV69DDYHlj0SNJSD3hEu+lC8+TbZXnKrmxs84xAM+ZiVapKD
	L+qXyEBJE3Z6At/k/35EaHCJnnYL53vGdgugqaenXwjQypG5qLcCrsSAcIKUqEwV/I+E1qhsqRT
	yUWv8W4z1QDKZN
X-Google-Smtp-Source: AGHT+IH+q0EsPvLLPOT6AkCFc3G/awB3o5SJxRzTQyoyquh1E8IUgNyuxjCWbZDUGJ1+3fGtEEZu6Q==
X-Received: by 2002:a05:6e02:4711:b0:431:d63a:9203 with SMTP id e9e14a558f8ab-431d63a93fbmr23185375ab.19.1761148601709;
        Wed, 22 Oct 2025 08:56:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9451918sm5225944173.0.2025.10.22.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:56:41 -0700 (PDT)
Message-ID: <ef7fd14c-fdcf-482f-8af4-115f090caab8@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:56:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.4 000/797] 6.4.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20230717185649.282143678@linuxfoundation.org>
 <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/25 09:54, Shuah Khan wrote:
> On 7/17/23 12:58, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.4.4 release.
>> There are 797 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 19 Jul 2023 18:55:19 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc2.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
>> Mario Limonciello <mario.limonciello@amd.com>
>>     drm/amd: Don't try to enable secure display TA multiple times
> 
> Verified that the error messages are now gone with this patch.
> 
> Compiled and booted on my test system. No dmesg regressions.
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah

Please ignore - wrong release

thanks,
-- Shuah


