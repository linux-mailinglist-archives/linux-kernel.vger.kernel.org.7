Return-Path: <linux-kernel+bounces-806886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF4B49D22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B24D1B24AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB52EE616;
	Mon,  8 Sep 2025 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfDkEkF7"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADA224247
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371981; cv=none; b=eW41645yeACnMZRP9nVIGq+lqJtBAeN2yHPvVWqZEOtsNg528lFbsBATWLLX6T0HjgwPJF0kItbnqwwJdiZQzxOeU7QHjCltUNLwGfr1jFrS7hJ7syJ0hAD/2SU4gzqBpQ4205AZKoEXQzOXa/0JddRqiPHa/8/9g7fC1wBJxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371981; c=relaxed/simple;
	bh=pP64zdSLYuawWGL6M9+/rStQBf+nMDaUB0PCbB3UWLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OniQqnpVp+3utxGS+mlK4gMQ0JSJi5892LhDwlzjTLmqJFWv4/a+7hL2Gxjc1sXOymZwA1do71pA1p/xZbSuss+ATTeVprIfapKSV0uswZdTEB7OLQ0HIfKQZ9rgkNpNgIHYl42CusExvyizZ6yYEGhLVLb11KKn1mpF6lmoW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfDkEkF7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-40b035b23c6so5689655ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371979; x=1757976779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6g2ytjEOuNxZukcRm0gYsVtC6FSF5PRujJ//3LZSz4=;
        b=IfDkEkF7OEll3uY2fGp4T5b6rIe8skiIt3GTTcSV1zdxek/+Gbld8yballygVi+SWV
         LTQ46ZR9pvxhM044uoEvSSfDJ0Dp5NTGzNk2c1Ik5K+8iFCr3Bhzu7ILSJNDE2urTCp+
         YvYgdOWNf5qwbsGIRMHaUgrJANyIT0qvbnvX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371979; x=1757976779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6g2ytjEOuNxZukcRm0gYsVtC6FSF5PRujJ//3LZSz4=;
        b=m0o1ZQltwJQBkHhG5OADoNetsz1+np7AgyV/C9UYdyIDeprOvGprOdxPyqCUbQFBDa
         44fn5V1lmZaATGvMTM683lNeS3NA5T9T8sRhQFxS5EEv6+oTojEArUtAS8oJ7oXBNmFS
         bF7P5m+ck+I5glZaEtShutf0m0xxPDyPMc1K0q3J0zd/0Gwp56UZARKHaGWuhKZk6/Nf
         n/BcD40RYn6+nX3eEbvVUkCLvOQws9nm7iUWL8xVZJl4f/ktXcoSkmlb5k/R/b6mMHjq
         Ge5V1snQjIdOZnJTFa/WJ6j1SbrAjCEM6/heqK9piyQ11xyruufDPtGYKHVv6yCqwY3+
         bALg==
X-Forwarded-Encrypted: i=1; AJvYcCX4AlizYwFUK+h0wjua5a+ILlTjcoIq7xC2TDwB1kQDEGboQwg3Ha4tRSHhD7WQhDqBOnwK40BBzLqzya0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuV1G+BCnPsmD3oB7Ob+ncowIf9+3+FXRONYkv09rhwywOShm
	kqPQE9ZtBcbsSJNBJ1A7Op7NKDR5FRXVDQBaUlP/089j4WiDLTtCiLsbFpkwjrerOZ8=
X-Gm-Gg: ASbGnctuDKnOqdJ0VF0Q/eX/PyBnhb6gwyqapA6+FpEtVyn98CRU0dfM2khW3ahgrb2
	DFfxFDoM5Zs7KDywhrKBFN7S1g+IQZgW5AgHCW+bAi80e/Xp5xSsi9bs47QFRQzY/v7HiWQYyWv
	dqKFqJVKR/iTktXA5SA0UgQb5ZebcK2guFfKHAvqTSc/kwhZKeiueYUjQ1z1c2+PzUyzYjJudSm
	PsvwnqJKe857rT7YjlUh96gyrLp6ijVPFnx3DNP88JDfQxDqWld7tvTSnWdJAtGRIns3OM21TPn
	OJD4twMhwA4Dzf/AE836dQ4CJs8AMEZ5LGdOi75+LqeyEk1lFAKHafEhPwetXRTmRW7byhNQW9t
	xfcXho8SoNMuU/OQbydj4impM8uuYK0T4d5gDDXEfsx3OMA==
X-Google-Smtp-Source: AGHT+IGHlfDmvkZr5EsWyqNrB2Jpq9AoMeyzzheU0TqJZfe/YG8cZIrPRn1JB8n7L66+uFRG4iz1qw==
X-Received: by 2002:a05:6e02:f90:b0:3fe:fa06:bfd6 with SMTP id e9e14a558f8ab-3fefa06bfffmr93467105ab.18.1757371978863;
        Mon, 08 Sep 2025 15:52:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d594fsm9224126173.23.2025.09.08.15.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:52:58 -0700 (PDT)
Message-ID: <e413e58b-f09d-415e-891e-832b58be1533@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:52:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.192 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.192-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

