Return-Path: <linux-kernel+bounces-865465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75002BFD42B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EB73568332
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72A3596E7;
	Wed, 22 Oct 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en0+pvYN"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9838085E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149433; cv=none; b=PdUO7sPN2+XYuxIgDWRLxokc+yYc03t1UMMsZKsTc9muIpz3t5Aw/iURA+4UZciHls/fK+fUwa+hofyjvqHs2TybXGQzdMrwixFtMAKfDLo2PioaL4wTRcCG8xmHYGPm3J/LYZEIINro+MNmoS6V7Eb+fhzJ5Wet47SGvyb85IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149433; c=relaxed/simple;
	bh=KKrkK8RpkI2SMuDE/cHHahMB360eSTnAZDbrSoI4o58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y29f6es3d8PdwrbnAl9CuJlsbkUZAcBNMO00nYkw362/jmwneCWqHrN6M18RCoHlPIJQMp0MON9NItTLQuDnuKJvGev+ahMJ2X2K8kpbmUh9cZZFRf6PUK+TjtDxL+3bjmq+IlR2PVXvRlWHpPmFNh3UvbSv8/Db/FoGZ6dPxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en0+pvYN; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9379a062ca8so302645739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761149430; x=1761754230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fJk0vLG7thkf+LY+zE0uqEbWMzbuwo6FawmPYnjzlk=;
        b=en0+pvYNEUmF7YkAtcnmGw5nKtnIbmWpVRua3IVrSwE0/X0airnn6m3JujwyGAKowV
         UAXFZ1+EXhpA1eGzzDXEHruFNy5fM/U1wBxyJSWDbRgui9NdDDUfwR/6yM37n+WXDfGc
         WFocoUznjyaJ6e0hOeSUWkW7kwkVyOaToRonY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149430; x=1761754230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fJk0vLG7thkf+LY+zE0uqEbWMzbuwo6FawmPYnjzlk=;
        b=WISe88+697O45ZbCtC3mKnFjxY32kBCB/5HzLC3FlikBFlcc/0IPEPHzBXRw7/bvpb
         27+dikBk6lBA2U5z65ysT+6C4gQWL5ZCGEmXpYUxM1UC6QolqKuIFC3YtU4Cq4XJ+405
         dXmDcegAUthkpUnKSIO62b0INA/4z/MlhVNPVvXVX3E9TYYn49VmlV8c/5JZbd3TZqky
         SVrO4CqcuL7SuKD3wf7z+AqWL+BJTOtM0nNwX/LKLAk4OCFa1MZnXl398s7iodEiMhMM
         ADFTZG2Mq7Idao/O4YetUAuyyOiCOtKLipX60Un/5FRB4TpEw238QF3GstVD6Q1P7C7p
         BmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQCk/byd0npIvNpVXXOOywcQo/sm6LZC+ERQYxDn5fYFZBe3txGScx7T66fFWB6aijgsDw9nsxQYqAe8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvS3J6zF9Zy/gtUmy765zYPrlu1nqvDnj4zeayanUTJd2dqsK
	OkY2QchI60Okf8f1Uej7GgAevBJNw+ByydiFX7dmMeFvt3uw4je8cnmba2dCy3OprUI=
X-Gm-Gg: ASbGncucA/cyqXAEsK4Ui1fiXGtOAAlPiGfCTS9fdOisImyYOUo4Srl0SUc1MR38/+1
	3yA4pLsLc3rELxbu08V2uVEz3RsckRnieNpeGvAlsbw3wDQtJfbjQJuFlCnu0j01sROAqckbmJp
	/iFxTlyyxCyIV2P9ZkB+Lx6AGd2Tj/j5tkZ6ErvG0QyDz8k4OJW/JcX6zuZoXEM9zetE987jENu
	0RDSpGS1/lxHN6M7zgT5zO5vZgX46AENeRzHX8J/N/QDANwg/ykIvrlwcCpMjQ/X7EKw/4386tJ
	8+ffNSF8ZWSDmXXab5Pg+5HfJCkNzLN+dV14+EUZDevc4h4bsvF0YiJqvuZu52EkCieNWksh6jH
	CC6dYL/U2RhTtV4EirWGhM6fLHs3Zkx5WNgJhyi6pfLZZ2hIO+fTBTpY7o/goHuLg3CH790JJWe
	fSRpJ7334g++7CytT8pKiutIo=
X-Google-Smtp-Source: AGHT+IF7j9Lnn708nVHmf7dGCzAt+5tww1lpkvS1+R+l8hRA+Mp02MiCzDvJ4Kqgi3VuqK5H3C3cwg==
X-Received: by 2002:a05:6602:2dc6:b0:940:d157:afd5 with SMTP id ca18e2360f4ac-940d157b1fdmr2126994539f.17.1761149429575;
        Wed, 22 Oct 2025 09:10:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e86645264sm488502039f.10.2025.10.22.09.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:10:28 -0700 (PDT)
Message-ID: <79b7357c-332d-40a4-b8e8-c521b6873099@linuxfoundation.org>
Date: Wed, 22 Oct 2025 10:10:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/136] 6.12.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

