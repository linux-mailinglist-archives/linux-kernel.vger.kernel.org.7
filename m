Return-Path: <linux-kernel+bounces-766951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7334B24CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB877B0215
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CEE2F5335;
	Wed, 13 Aug 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFofw7na"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253780B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097965; cv=none; b=pT/nD+7qPWVq6rYJ/P5h4AdEwLDblFx98RRbHbDfr/XpoH3HG3QyALzq6Gytn3D0tsdvrg6hE/+3YGq+coyt36obgHAisGGIGuaeaFk5aUvx6gBNqKC/MFN9+yY0390ta6DxbI4eVGN0mVUfN+OAU/+569lsWGy3wptgK3ln0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097965; c=relaxed/simple;
	bh=zVsSFbrvhm9BJ3DbBCbm+xy2MVqqV7KykKxHCqqt4KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmabZlPQJ6WIzBzKlCRLFET7dvhUX0KmcowgXdARTd1Z0WgVIch91p4BFiZxJe5GJtfjrxMQhOyIrk479kU/zTea2VYsJB0Y8MauTzIvjkpHlX+pz34HstfXbUam2NyiIn/w7qMy/8ss3M3y5EJeIxCy9Fjwyx/f0rhNwqDtaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFofw7na; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88428cb5dfdso15256039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097962; x=1755702762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n42jFcBE2gpeQ/vI096ladjtP3+BqKDXgfUhoLDuD1Q=;
        b=IFofw7naSaDt7ClkuDxCq5Dg9crClItBMVTyW75rPVSYP295pK3/QTe+osvspfsuPv
         xEHCCag2PQ4NriDQSVwFhcAXQUN7hLVyTQTGgUZBNAzjJzSiyf2KccSfD1rLprrLo3yS
         XjJJotuK6cUDvtUKoZf0wcfaweMPnm3F7A+WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097962; x=1755702762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n42jFcBE2gpeQ/vI096ladjtP3+BqKDXgfUhoLDuD1Q=;
        b=RDoj4oLBDKQmdd+6aQ1WcTjm1R/VKoqMEJBLbLdElCTgr9PxgdBOVq4GyKMJ0HQPHq
         qbH06ptlu8ctUKc9aRB986al++u7CXAoTlFzixrQPV+iQmecQuZBcW5m1czbtRmBJAhF
         /yM2Mowb8KDl4xni/jg87YsWtlZPzSbC7EHQK0s26E5TYb14qE5pJ3FaCLApNqaw3AiI
         fn70O2QGGkaq6EF5QgkWIOLDRAv1XiPAACK0IbUw80oPpDM3urwMLUSrWGCoHMl5eoAp
         H071o8wIKWQmDaYnoUkcs1GcTyS9bNRz3vsKrN0GfMqV5VdZxID5DxcApGRdUHceip2P
         9nNA==
X-Forwarded-Encrypted: i=1; AJvYcCWNJyh7NITrtJnvtLbT+dCKFWMic6IAloM6yUUDNAb1JrQpQWsR453MYgD/9Kpgb0RTWPyh1H3y1r7CiY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWbVzVTG0qmKGKct7DfVhW5P8ZMuV2xq2fTc7smXg4H+owc/i
	CjcIzhShCL4x8FX6HtHl3yY+/xf0HIm3AZImqIp9p5vuzhZoLWqlqbjmiMPhB8Roaj8=
X-Gm-Gg: ASbGncul+8I/n8Z+LkBDeJos/0RocyRN60YSWrU6tcqkG5tM7toeqyJN9MjSp1qurVJ
	7u+Hm89SW/yfHufMCTpDmjXYXfv7HlJy9K9fzZSn8PDrKjgMFGbR72hIBjDAiJpIHLYwKFgs9Qk
	mwCDnY6hTzjXwPM/hDVvAdZz+PgU/OPleIV3mTaZ0Aixrz2qn7c0WGm6zPc0wqOEFw7naYsUOJ8
	p9XfNMIyn+4baAX9nuxrja2s36SD7LUJw6sEV4HaiPARxYtzQHjWKp2AHYuBY/5POytRt5CPjJW
	jrCMftW/8eRMEJBC6Wq7TEU6h99nIcCRVhKSzQ4nQBoV69ifvp/mZJNdnOJLrJ3Z+L6veZ3dTqs
	1L0i6QHSIL/4cFxQG9rTTjHY6oq74PCdqHg==
X-Google-Smtp-Source: AGHT+IG7OVrd+2DrUYOqB1Ip+rADtsN4EW9RyHicJM+g0CKieqgcluHwZyyU3hrd1BkUduuItJ8C3A==
X-Received: by 2002:a05:6e02:19cd:b0:3e3:b3d0:26cf with SMTP id e9e14a558f8ab-3e5685aa5bcmr45056125ab.10.1755097962142;
        Wed, 13 Aug 2025 08:12:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cfb72sm3840508173.33.2025.08.13.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:12:41 -0700 (PDT)
Message-ID: <9a55a42d-353b-47c5-bf9c-1b55bf67ec04@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:12:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.102-rc1.gz
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

