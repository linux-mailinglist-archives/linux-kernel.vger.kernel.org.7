Return-Path: <linux-kernel+bounces-880986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8BC27214
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9341118857BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188F2E62C8;
	Fri, 31 Oct 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZslB/+/"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA12D7DC0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950132; cv=none; b=mG6T0x9pRKD/b9/OlVhJuDB0LVCjcgdppqlcItfZCrMBK84kq/rmS1LaZR4z8SC868XmrQub6bOsBC+g12iMnisj4gsy2uk3dNgWj0jImkAvWc4i5+NEdeNatCd59jz7DXSSRIg4NeMi4tyImHTvHN1PqBxwyfMna68SuoBuVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950132; c=relaxed/simple;
	bh=iYck55bahX1dqxP2BL3n7cuT8Xbz8u0rKuNJzAfwsLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlhLpnhlbPBOXGpz0E41P6YLRTIQIwgIcOX8RCLMlPb5v2XO5qYYKduTZM+Jou3cNg1UsVC+QMk5386kKpQqDpYJanyo6denpCnwJj3tsKSA6GfostpugJ5UlhAn11+/cI5OPumiIgKx/75JvML0rubpJ7hFtvNDkMxWoBFKIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZslB/+/; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-943b8b69734so255164739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950129; x=1762554929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnbrNksRBh1bg9JZSC/QDuCw6CE4G/JQOW3nf+SPy4I=;
        b=MZslB/+/w0nMXv/n4YHPUFxz+TEKq8ZHzFtX74JfuBwU6ywI9xrQjcw1m3QrIthrRz
         9x2fnSz4PSZ7LijfJFkGWfZKDQC19gwYkZDOlQpifXvrOLfoKSrVCwZVWVhuQo8WXL2i
         rjT65/524aZ62hPRx/u5uykndK6EDjwn9PZ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950129; x=1762554929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnbrNksRBh1bg9JZSC/QDuCw6CE4G/JQOW3nf+SPy4I=;
        b=LhqkiIUlTwRHsyKnsw2hUQrNNBJhzcXgibi9HGeWMVHLy5+kpEyFFw+qkZgh8T5HOM
         +Zs1vAOSxP3akWrHfp7WFtOq3NV8vNd6Fi8YMov2+g+t8OTVO5BOsLLZGMsHzlp3fYec
         s9/ej5DlPwFGiZfBx1KpRVU8fzuyzhH/1wy3YRz9bswZgfrI6fASDUZJTN7+MwB2lJ3i
         O94DOLovU8l+4Nw9fO/7pBFpN07xydeYtTq0gTNM4Ek3e7SEQRWWv9OxuALUCFiYlEbj
         +1JvyFpQACwbR6vD9dcyAsItDNB19BmabgCg0n1Mizxsd+TTOb6aZI/84g3rZbIeh0cY
         GnXA==
X-Forwarded-Encrypted: i=1; AJvYcCWFks79AkNRJHIlOYTCS0Mu/4qYoYWhIHlWMQoyJ3k2WIE0C4fWzExDD+QGP/QsyXyZn89XRJV83h7IlEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJqT/G73a3rdIq0nejDi4H7ntb3WkjwSrfojff5egd28xIqgC
	9tuxME4+oiMupm+q0ZPaTtnWwU54m37Qc0dIUQ8D5EMrGl50d6+KqllAkjtuLgpyguI=
X-Gm-Gg: ASbGnctcYdaikzNOGcShvayvFo4W6anaa5g12NTG3GomPbNb1v765PthbOrtuvPcnr1
	XGJPMWccH0kXk3jkYi9qf/ffhkc/WJiAXCdFK9kT3R0g/kDtvwu998ECd6v3CUdDrJaU3aZVFb5
	+h3HsVTKLn4WFiV62i+LxLBH7zg5KyCpmPRLxA4fYai4/03GeU3JS0NuS2+Vj7p1W/QO3hmOsmP
	F0CcnswNL+BD7ImrT4VCkbrD9UBKPkrfpDKiKWWk5uAb641xOyVI1fbsI+I4VdeVIzFzbBpN3/X
	K0rdtUTszjHbfzvAVCtiy/0HVefel35wQSi+kS62J5b2ENRtPZ2ongTf+u03JmKI3hyMpnShOyA
	AQAG//H6YscEnRMvPbCBR5ZIyTtQiIGD6J12mz8AkCvsqvovbyBm7cz32T4xvApAyCBB2kchER6
	MgdXjLHiioCcQpVFJ1ruMcWu2i/qTvVnTi/g==
X-Google-Smtp-Source: AGHT+IGjVrSQAMNqNAnv/gM9bi4zfu2mobXw57w95CoY0VCC2MJGIb3snv4VN/yENZWB73vMHzXC2Q==
X-Received: by 2002:a05:6e02:741:b0:430:9f96:23bb with SMTP id e9e14a558f8ab-4330d1315a8mr76043315ab.8.1761950129290;
        Fri, 31 Oct 2025 15:35:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a55b1b27sm1151546173.41.2025.10.31.15.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:35:28 -0700 (PDT)
Message-ID: <23807f00-6b2a-42a6-9ab6-620ae5dcc661@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:35:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140043.564670400@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
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

