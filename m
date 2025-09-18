Return-Path: <linux-kernel+bounces-823363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22305B86346
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C51785AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAE3164D4;
	Thu, 18 Sep 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGiOso8b"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA3314D32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216413; cv=none; b=UyaIZfZMWGRUeBI+zVvGjE9wzI9y6H6tVlHMwQ40rWlxfnwHhWQBm9YDCv2ppbUXgz7LjV/xpHjxrmAoUKKOeCSjJEK+3SMZ+BI9VG9rvauBHaYbyW86dh4Gzc4gMbWg7GyxR+OROTPR+VeYLdq7io7BvLL1i1PlZPyBLDhh1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216413; c=relaxed/simple;
	bh=rB8tPEOPRzhba5eLwtxrWUp/9qJMpIYZ22j7kwy6N+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1+xsANe4v7bFvckB5QG6Y3M1YwdudGM6NcJzDielKnKjneohgcPUpxZn5eAyzQF3YPHXCFnsEsxG6iZ6OwynAzyXdyp2OjGkP0LMiANyRIUiOkco5AWz0rbOvreazAmNXHFvHQnNjAqE0hbHH3mJj0vvHrH0ub3Il5+uhrW7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGiOso8b; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77d94c6562fso907933b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758216411; x=1758821211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSL7OFemqt/NSr5lMBXtrsDUmlnbLhLq1OBPdZomIMA=;
        b=XGiOso8bZ+KYFaOWiVN/t6E52Y2ZhHWNbeSX3U/EDo6YJYbv8iQYnxwLRwIwNOK5P4
         9G+BAr7BLB7Btetd/r0mgmgX9gfbwkRtpzn1hJC4hkQ7Mt3qc3R3ws5UvyG+WYe85qmy
         lHY/5AazUgr+7/zvxYM6G5xOMgibB9GmMD1Uho60fjbrmQgE+KmYlwjCjrUnTJ5ym5e8
         HFxqEChvkCwboDXN8mxXPWwcmDjJYZ5he7gVaSP9B9EiqBryCJykT6/VhnHGWn/aP4K1
         VER82ek5mR81RJp8dMDtqGkYCa8XqkZ4NM0RbFF1PfBY3OMK03UkEuyVlDG6o+EBRMHP
         ACpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216411; x=1758821211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSL7OFemqt/NSr5lMBXtrsDUmlnbLhLq1OBPdZomIMA=;
        b=kZShp38bm6qrc0XXAyHuFPy7IAINieEih7uXEdVfc3vrOzIrv3EpOJZ5k0srfgP8IZ
         bEbr4ubkKXDDVlIi4sBLDbALqltB+TbEhe/Tm2JqMqMzU/uaxcPq9MuYxtqMort+z3Tn
         lggRDL4xNsDLHUjdmsm3G+x1u6d+jXwAAUkhwun9f8KxT4AH/INi8eZs4q4LK14cMydU
         aAbKTP/SpmJkGVREl2E8gVspvXDutKrfARmmfdUg8KelpmLp11HBfuuJsFqPR8Ocvi/M
         0Sdh6HLt3z1yXCLzZtpuV/Ew6aEJqn5SbqUleqyJojI2je6gtMI3mM7ABxIMHkuFE71z
         MwKg==
X-Forwarded-Encrypted: i=1; AJvYcCXsyLtpxJsY+4bA9fSYYVVNkhIvxvcwJH7o41ucdtPZu88RMt834a8gMzVdh4ksRCmEaIVVrBXS3SZywiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oaN+rpdo7BlDQxB1ScpTqRO3fnnkB60WcX+86kqC00l7kVql
	AcnS1vYg7dZ7ZNazB2cOyL2GOs7YcR7cqwu8ozXACj2mHBrN63EylxMaMTvkEg==
X-Gm-Gg: ASbGncumD7h6j3QP8QN31KjpycWwdWGQxDcHU5hHzp5zOPWIg/dM4is0iHgmZVnxEkQ
	t8FUzVuS1yWEL4gamO1UaSBgmWvIzy4AA8qjyIh82glV8CHtcY/G3UOFHdEqo+2Ms2Yjrm+ozNB
	e49x1btUTuX68phw46LYrWtHHq5+Qo2L334VsSajfv4m4Cre3zIcEjnG5hB9ASvZhj6AQaHASBm
	ggdqSYWp5yo8NK0nIBwoI5o4rYjyOfovL0DrRtWGxuUwAQ7XAjC7f2Aoxr0OpmgVx8jG4OS6dE8
	X3m1MGM1n4yLlSMYnG2QH8X8nTI+wvjVFHW/uTiJDyqjWSgpgfmB7lvYc59GlgCFOjVnPE2tHFK
	0yfg0VSutILWDTQdAwQqTSEIOyX4WlOjmE15UnlXnPCVCxHXktTzghB6nlV4aekLytrEgWUV3mC
	Vm/ari06s=
X-Google-Smtp-Source: AGHT+IF3/L7P0F5rFfW+9cQVyy8quCWoy76tgJTxC2HHDreQRLnIJl3IZDhU8wQipfAMzXT01RaFYA==
X-Received: by 2002:a05:6a20:e291:b0:240:328c:1225 with SMTP id adf61e73a8af0-29257ff98camr555934637.12.1758216411343;
        Thu, 18 Sep 2025 10:26:51 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d6d1883fesm2267894b3a.59.2025.09.18.10.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:26:50 -0700 (PDT)
Message-ID: <2270a44c-0480-4261-ace0-c2d6845d6556@gmail.com>
Date: Thu, 18 Sep 2025 10:26:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123329.576087662@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.153-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


