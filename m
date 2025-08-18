Return-Path: <linux-kernel+bounces-774430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61773B2B21F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A977C19645E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F5272E71;
	Mon, 18 Aug 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgQ0HwdY"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A253B56
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547928; cv=none; b=oHU23mXB+XJsMBlN3d7fiOX2fVOnEZAksSeQLC8ovI8+50AKrkZopSmYqaS15+IQZ4761Jn2Cnhh7KQvjnsdC/JAQ515Od7RKDPC+ukC3X9BxdDWRdkLAHYa3NRxPvPwejjsQKpoxeOBTUjywSW+Swhmbenfxud3mXmFZ5yjwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547928; c=relaxed/simple;
	bh=ZTEw3v59byAbxSZgmjys08ROhmY00iv+6lSpKMPh+2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6wnETThCfz2ZVMyXUwT7OuEa1DXV9Sw0ikqCG8yv4gp4sQQRfnfrmmhPY1W+XDN1RenJgKqCDwCyG2HgFjzlAJeHvyyBp9eosv3K1PWvUUj5b2H/csQmZJB9L9OSVQhC8cy1SujYlfiNj4H50YsfCLXHip18c19FOaZMCo5cMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgQ0HwdY; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e66b5492c9so8010015ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755547926; x=1756152726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfUMdozgYccOdsGAt0DPTeKUGhDvpTTBYKEk2M/luYc=;
        b=IgQ0HwdYzu2I2C7Gr77HnXW8n8lpSwCu3WDkt/3qzBJ0l6WapWvNYbcDEoA63vKEPM
         SxcIBIubZthEViBpTG2Z3R59mlKMjKKez52zMDm5QHDuzSQZei/3nfYI7bO/71VD7z35
         gAyJYEdPc3A1jC4ClyLiswKRU0Fgy+EM16u9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547926; x=1756152726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfUMdozgYccOdsGAt0DPTeKUGhDvpTTBYKEk2M/luYc=;
        b=m/ZLJ38gkYTr3T2dZ9/jILaRZMj8EH5xIR2WtscqY7HjA68AeQ6rjnlRmRLn6wPX6J
         vBLvpj3ZcoW10Nkwet3ZMEyy9IJ3R8/RVsfURvXrtDoAc4U7E58ZojtKbo4HKfuSeqJ0
         ayBki1Px9qaYGhD1fBupK4sVKBjpwfC/VbtJmIydnylB96F1Gqofq0HstBKR0gkeegma
         zpaVqe+ivPrlO0Q9XpkKGdSN+EnFV8qr6hzVEwBeAKOBD9V+h7cfHERcCo8pxmEHgGMq
         HJltMOSbZlNGGwVp9vvgw0eM0hEcLHV5+T1i5pe8FZITS4QLifHeThXzZbNfBd4BsLeZ
         bGPA==
X-Forwarded-Encrypted: i=1; AJvYcCUfaUoh9DQ2CiZKMnRzfbyJgECzxw5rAdm1wA3eYUpEqvSh2bbPHEbt+cVGnzu2JxlRkdHeeyRDKWGrSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXzYA6Ko7VNfYrjBzD9oFidfGIXLHvkTGYXzCgzFYeAvObmz3
	Njss7K5j5UmDHlxEbNkxUVC6gDyEmW5n3QZxBXzVbzedDirUGxUI1519sDMlgFnqyqM=
X-Gm-Gg: ASbGncu4p6bbhpZ2WePbhTai7no2rajqqV0mTkUNQg0CL/KLBSVluYfk6tcEypYoK+G
	tVr+yXSz6Kv1lhlcnZM9RdOOCSF7+muBbqse4+/Kcdc2OFkIxjaFwcSB8tFWFF0/XNzQS61WspA
	U4fJRBCoNvgF0XClnyxYmXPVcLiXGXJxSgyEGuTBFmBiLVUae12vy5FuwQR9wr/RIWbUKIfLTdi
	gSvZlXkH5fkmHOK6K5TlFB0aPW1pMAfpzGeMTOGyL+VTjnP4cvkCnqxzvecdXqMXD9vlHMTspFl
	+7vnEQj6fMXR4YvxqeyWL504yiwROgJY6SdfJEeW9ZwvxL+0uB/SiQ+1seT87gRhtBdYiRXfCvW
	lZYDvCSNfjsGQlSNhzKbs6gqa0/Gb0rCm5VYvkVnBgbp84A==
X-Google-Smtp-Source: AGHT+IFcGP4eRLk9XuN/IRxuYbZSmR1FokdhKrwhASissjzBWd2Po9X+zsiqxt4bWrarLNWlvZDNHQ==
X-Received: by 2002:a05:6e02:3e93:b0:3e6:72e4:c5c with SMTP id e9e14a558f8ab-3e6766555d2mr930395ab.19.1755547921189;
        Mon, 18 Aug 2025 13:12:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef61sm2927751173.8.2025.08.18.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:12:00 -0700 (PDT)
Message-ID: <bb7f37d2-dba8-4d9a-81f3-e1125a620bc8@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:11:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

