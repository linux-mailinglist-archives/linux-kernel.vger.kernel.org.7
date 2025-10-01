Return-Path: <linux-kernel+bounces-839264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB6BB133B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CAC1946F40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81A28467C;
	Wed,  1 Oct 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0R/kTgH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95B28003A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334581; cv=none; b=BLNIiQwz0ocSbOPzTbw3I178JKTwcKSvAPPKkM78/uuCS3sA8o9NCrfHLyWYLUePnjwwBzhyVSMV427c5XUGXZE0W1VJpKyPVNRaLXjrsFrYY44Ohs6qxTk0ujsPS7UKGLVzhkApKfM+Sbbe/j5f2PA4BD3peyi3EMS9GDN1CRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334581; c=relaxed/simple;
	bh=TN08qxdXNdkLvHt7/wPIeKRCTg39xHBh9iRLNP8f/0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsJpiXnJTU5akZYVlAyALdmLDyu/ZnlUuQFjYpWQu35FfJScwe2PICOTBDBeZuJbNwEU5XBPArzN2VWMV/bgsn06lR42bu9eidUFvjvPSsNpy00ZoZNIBfAikRYM7Dwq0mKDBIJPVTFpwfl+JpPbKC0rDT8dTpi1slC+VR8lMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0R/kTgH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-938bf212b72so32172839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334578; x=1759939378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mR7FRFOp6wmlPMEQNaFmkailzNE5Cfn80QOSCcb0KCo=;
        b=E0R/kTgHxpLkyrt4yUSiAeFWWyXWZtmj9ZIf+HZj3yDe1ajLIEe5K2SxWAMrYqALzW
         1QaHyQhhIINflIce957p9hW76GhH1IfkWZ2f/D/VXTRvUMgRGvEXzhGp+Cy5yATVhgTz
         6HVqCynY1ug9VEBnixyo891fhHyLGU2JXo9j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334578; x=1759939378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR7FRFOp6wmlPMEQNaFmkailzNE5Cfn80QOSCcb0KCo=;
        b=hfcBU4Lr3PTIEPFR7bFF5UgB+NR50TaoygjQ98KXN2wsW1xL+a6UdhcstTNR+z9uGp
         8ptfP0BRfoC5cW42ex9Zut10qL35IQ/LGtZxLP7/o9d16RtKfgZFEXNSIxknPb/hdHxv
         ZejLPT0wgoejkHKkfsGlqdAVJRw1FhHop9bip16SxYZ33Td4mvsxcSA7FZbt238hu2lH
         Hn5oigyIBkCElmONUrBpO6+u9oii4je08hAcQFi9q5Hz+JDmilUimxuSEHhAibxBQ/BS
         pUOeCkEndtGJks44n1HoSOZcH8X2presJakR1sCxhP+dRV3fQpp94OUgLVJhPkwcBDJu
         jRXw==
X-Forwarded-Encrypted: i=1; AJvYcCU606dcxzobmXi0njGyobKMqBYsWASqrQURVn8EbCDgapKvUQnmfbx80DtJeynp5tlGXJctLqGHZXZOjzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuXqm1OS/V9xwKnR8yVc+ArIMS9AzoAk9chf23ILJDL+zvc9d
	cJ+Dj4E4x/CTacKT+lJYEbQN7UQP8ioH7CtbGepm7Z2uMkQQI3zSUUK+acvstJGII0U=
X-Gm-Gg: ASbGncsPHJa9bJqn9bHZQR0BqxW02PbrLUD29dEF0pudMmLo0IMtNgPrmecTlG2j17Q
	PNyfXW4zH3iHcTtQm6YO6dHRLslHZmuyxvsbfFMOQJCiV/w+SeBcOyV2HQSDTWL3RoYXpk9wxnN
	oMSkayzsBm5mPq6TvLkiw4Q9iI1ba8TDjXndz8KZVulfgOp32DCBT6vGmSB+bL8FUfTZ0dB/bqF
	qZ4tED334Z+q48DBprkMyUlfRr/voiDz6+o+B+L+z9dcPr2FxITBjLlhjdXMScBS8QEXnC5+sWx
	nz7n79pU9h4HZsgNl8bRYhFeGql1Drkxv8ZuriB/V4jIzIGj9UDq0eeb5jnFfly1IwPxd2ron6+
	JSzN4w/+HVvc6dPHpsgisldLjLidCn5kls/dUgoSO5Gknrvcw0gCy7yn8FvQ=
X-Google-Smtp-Source: AGHT+IHgdySDqIv8Jt6z7mJDygOJ39o7HwA2I1QtCXMXZ8x1/OJj6ga6XsCXSQpUzQE8TPPwtX9h9A==
X-Received: by 2002:a05:6602:26c7:b0:92a:4e19:197d with SMTP id ca18e2360f4ac-937a70f0ef2mr638019939f.4.1759334575525;
        Wed, 01 Oct 2025 09:02:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5764f341b2esm2373807173.0.2025.10.01.09.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:02:54 -0700 (PDT)
Message-ID: <111e47e1-b03f-4d24-a234-0d64c2792447@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:02:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.10-rc1.gz
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

