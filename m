Return-Path: <linux-kernel+bounces-741529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847FB0E555
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB58547B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96A2857FA;
	Tue, 22 Jul 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INyaU5U/"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFD6F06B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219176; cv=none; b=uFutm2R7onHdGQ6YWiHGEG8dKip/vOPczAjtz6KU1mGZQ0vbWK6sHEu6yGd2ISA2wtYAvr6P3oh4oqBFCdfV68e4JfgS4oEaR/cXL7wLRmzUuBAj2ualD1JkVJLJwOHZ4TXs/2nwOx99IUqUhjepSwI08Hr3B5bxbwDlkX7ut2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219176; c=relaxed/simple;
	bh=U5/9PrXzn3TSV36bHyqWBQ2lvhT22VgIYiPjEDLqPoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inLd9ftbQD5SVmBHqPI8cSrYw3EdrL7z6NOhvXSfVAH0pHXeLNEccanphw+x+xXmwII+GoXXKyVJBsvF31VvaBCeGGBQ+pNqGYt91PUYIr9HZbxtm1UwWcK4PL4YnV1KxLclN3PNnTOM0H83Xww2ce2Ck9EI1UHy2x5tT1HJzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INyaU5U/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2f20f4bbso21721535ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219173; x=1753823973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vopwzi+8eYb89OM5G9WI2DnldDqvb+R9BJJKxBuhxuo=;
        b=INyaU5U/LzculQm/MyVyYUQoBjg32wX1/e3xAPdK05HbHuW2HnFeONgPH7ex6k93Xf
         9rT7ZjF0XhDktsE/OXbKle8DqiRdQ9Mb0BDm3KVITtmt1OTmI6OMJNhY4WoYgzOdhDSX
         VPZyIqju2uHwgnFf5H9XEniVOIQk13mTob94A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219173; x=1753823973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vopwzi+8eYb89OM5G9WI2DnldDqvb+R9BJJKxBuhxuo=;
        b=ABiWPwc1U5KpKuvfrIi6kx+xZjyLB8Gc8s0BVMSY5ue4wcBs0mYbCH/cuY3V5E+AcI
         mJAhXWUEgEIxDYWYkFHQw0wUrUQ2DqqSMdPcZAG9joMk8rkYxqmPSC8rlJzry60+2Rzn
         KfqspuQT4EKMTUNp6Slxv5vyz5rT/mxyIEYUcOGWWEhQ6Mek1+Qq7u4FhLF8Ma0jauEh
         NaEDX067vuHpnHRVV/0t8yI18M8+oHchYE7gfC0F/3kp604VrYPSWywe+hQ5ng3DgcXk
         VygfUIhin6zpnxcYiEahzvMrdtalXdOyzVeo/j06RIbB1MxMHMDHDiW5FGVUFNz+qCzG
         6xDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7h6i9/cUMBGKA7VS+KPHHPcdGlSIDadSIZl6QxYm/2VEynp5wrHKOz8suno1eXnastGEaAcnEg11LsPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1k34qFyGwVeDpCL2aSwQASCACntgDWQZ1/j1Z8jb135mybcP
	LsRzDaajGQZF62drkruS+U541DF77Inda4zsnUgyET6vL4pC48TcssWGAScUGE3d1dM=
X-Gm-Gg: ASbGnctMvj0qX/gJPoHGYEg99RnVTr+vA5j/dLpp7tDe35Os+BE6C9CP0cx27JrCWMo
	0VRjsaSIcLFNUamVjkP+crJi328SjQpLQyKLrqJlOBfgrKerKJPiPLkEl+mC2JaZ6bAqaxFphT3
	KidphoiNEl4A377G/ad3LwZ5GAKGvDmHhSh71udf7Z0DOiwS6vDtx4auNU6RdNucghyQTggTGM7
	yCDsvFBSL14hPbh0FwFjlVkWfcJ0y5bYmfXHlAVAzTNLsHiH1zVtQmkY1VdD0rmtf0AK0s8fJ8P
	jIkbAE1vbB+yKeolNb/qKdHI9DJt6DtBtA3z3+AkTGwizNO7VWBjifeeUiPAIY6aQCah/NEy/0I
	BnKHS6VW/TCGBfHLVkj+xsEl0Rclr0VvEJA==
X-Google-Smtp-Source: AGHT+IHB2kj7wAlirQpyMhdwef+1nzMVJzg7XJvQ92glYHifVsRf8s//4dpWUNN9PM2HfQM5LeL2FQ==
X-Received: by 2002:a05:6e02:4701:b0:3e2:9eac:dc01 with SMTP id e9e14a558f8ab-3e3354a23edmr11949525ab.18.1753219173467;
        Tue, 22 Jul 2025 14:19:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c804addsm2750342173.58.2025.07.22.14.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:19:33 -0700 (PDT)
Message-ID: <b0d63011-fa27-4c21-a5a8-a2725ae935aa@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:19:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

