Return-Path: <linux-kernel+bounces-848846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EBBCEAFC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E07545686
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5C2749EA;
	Fri, 10 Oct 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmxlZ9ft"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A562737FB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134816; cv=none; b=cDBIZ+Q7boZtpYFfRss9OyoFNB8mf4psZM5rBxMvScbLdSp3HXJWPm/+Fg8SgW6qQv6gwx2JkjCcYKjAeWEts8vXL4MifXp4AjP3uJJfbTJ3JwzigOesD5qr76GbTGzYgQfsT+68fkqrH3FogXtXFkgjJF8QpbTZRkQq9b+enmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134816; c=relaxed/simple;
	bh=HX9kUSbVvZEhkBm389aXiAE3qoNIBIrdZd/4VNb04nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWobY7/qBUencWvFzBIo722uwtN+SZtmXipAnzAHoHQCzVrstVie7BRSRzqnvna7Qmk/Wgh6Otu2hCHZCk6bkGLyZiQZX6NKn71a5KTYPgCEuIDYriw5Om7rVbyzrOJyzHCJsHZHn/GUWDyWby+tdOSza8NBahwpA6mOArUu1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmxlZ9ft; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so26168695ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134814; x=1760739614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FATvYxMqMxqS2ormXMSWnTcKBdYsfsjX3qE9wWsDV+4=;
        b=XmxlZ9ftzkmg5EcosOUfAUJS0c1vIkDCS8eJ21IAtEzzy2CrxLtng3Jr9vgjxjbjvM
         t2WhZkTTbtM0iViW1bU/ps4dDncrySwf8q/YFvifx1ERS99VwXSTJlhZAFFqRP0tRkfd
         hdtpSYmpapF9c/tgfZXIQWYKYa1bRnBHmgpC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134814; x=1760739614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FATvYxMqMxqS2ormXMSWnTcKBdYsfsjX3qE9wWsDV+4=;
        b=rx2/KmTOaSzdosX2tTBaIOmOFzhbTO1QiwUVJvechpI/GKU/ejhzU79iZjmAigo6Wq
         XmoWJ5gP2Y4m4xENEh3iJnk6eSjafcTTTj3OpxPlzf7/vI8INfo8LWEr4IlfMZfIjqHJ
         QCPB6IJH+SxfbDF6WMn0A315Jstd7Q2ccrs50BmTrcusDxoaiiyW28Ol6JCRBjTNDS5K
         LfGK0ElbaVoBLvwd/Qk+oWfwlsBZKp6oZxRKtvZ7sdZyGz7I8c31QaHS5I50zuPDoIPt
         m5SrnDSoFSemdFf+UR9bFFDEceIK1ROJek1X236B3d8YG0HDowif9tvcdEeO8uFvJuQk
         VdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX83/uyg8c5jKuxNDs23T9DkpKwLA9zr775cUmUyVmQOlLdPZntx2i8gBRrfQZ5d6Za4vaTQV0g89s9Uag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNpMpT0qEyv+70bayo2I1tICXAopVoX8cS437nJi8yyJD75pS
	nNlmKKslhW5B+7zuC7wM2gPmGpND5YGuR/7q34QdEG3oKt3PYx4j/NNNme62fUMc1ug=
X-Gm-Gg: ASbGncvHgInQGSMxabR616RJXSxW4RjGTf5d6dYdtUCjEFT616MU2yQuyDBn1qU8lKO
	V+jnXjysTR0lHIo0l+ZMWNKjEBVc1ut7LW3SC9PcHo2gjdHOeeP+vYVI3w/NaON0+ZxOoU5QWpx
	IQeRNOb/uHsRDKrdvHetI6N5RrM/YpG46v5qUPluX+jXrRqZqweCmhPqRclE6dHlRRvAflj/ndM
	/wjsDCdbqXJ5+DOwqvb9KF3PLC6z5NPLNyRIJ6O4s0c/yrUBLVAYsdT9lslOWpq8eXD+vWcrzOD
	vz9zKX9vE6OHNl/ZwKJpPetlo58kuLSXRxuosXJAWGr0zKUjQwQW2QqsKdqb66cT1UazRkeWaNl
	Lp9M1xXBnwa2Gi80QDUCR5i5PR7LxHR8tBiHShyb/Mf3DkS3v5ydf8FGJk6rhf9Fy
X-Google-Smtp-Source: AGHT+IFjVlOVlp/S67zJcwokGu7xNEaPgsH+NZPyas7fNGWZBTxl9oVKAsc7jb/qBFuc1FpBfQ7TOA==
X-Received: by 2002:a05:6e02:378c:b0:42e:2c30:285d with SMTP id e9e14a558f8ab-42f8735201emr153202805ab.6.1760134813952;
        Fri, 10 Oct 2025 15:20:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90278522sm25119905ab.13.2025.10.10.15.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:20:13 -0700 (PDT)
Message-ID: <4bf09441-6431-4770-bfd9-a1890c0db4e3@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:20:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131331.204964167@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

