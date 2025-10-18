Return-Path: <linux-kernel+bounces-858978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86BBEC65D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1F004EA6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F44280325;
	Sat, 18 Oct 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKSmcG0f"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD6277819
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757031; cv=none; b=QsL0QJ+kDYrTo7w43S8R3xERFmxCKDlGq5QJTrn8GqC3fH8iwS9e5z32kXbI71ywcXSOF7YTV2UFLL3HDwx6ALRijvB5lrZLs/yL0Nq8J512SmT+VkNQZjSbKj9TCkWnYhvNfsd+LdSQ/IpN9yQ6Cvp0Q1Wy0pEuhK3MT4BaEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757031; c=relaxed/simple;
	bh=CJQ76v/E/PHDdYgbR8fro6XXoFI3bbatRfKPbnF54mk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uKWtIAc3apPPx0YezoiR7TDlUMBJTGlbkCJk9K5Rh7mTXZqnSyMhmSWXGE5ANX4EWAHHTpjGfs9H1MU6ELi14LX8SE6sj3UtEzRn9rVjG85eSSul9Gf7V7EwAjnVKNHgoFSdpN8jMS4OI/WqYH5bHgB5S9Pqhiph92/3yjE7M1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKSmcG0f; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1535162a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760757028; x=1761361828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jf3FR3Gwahm6tMjH47zEEF5nx3T+VLl5Q8klA7mB664=;
        b=NKSmcG0fKsXM1aZj1emCJEwyQVrNtKpTfRZuIbjgXWefdOCQPh5ajic1TAkl3JuW1e
         Hf2dpEKkz/PPV0aA69MYyJp7cVaIZ9slgVXDpJ4qYBM1sarKygzNRXAJ+brY8POOYbz3
         ism5rzEJypVbSGmI6AN11aXimcvlmWmGktLjcN4MV6JK4tFRrPw0HXi6kUZ/qi8RbY+J
         +u0oJ5tKHsVyEOi3rVME1ncLPz9QOwc7BR1c5chGBD54uqqupeJu768W3QCB6t29iCXm
         3SgJnRiU9gWwXGtRYbXi0KMiJtiuiJWQXhFCS98C2S7w5ihT2gXTCNAIYf2hadzetgH3
         I+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760757028; x=1761361828;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf3FR3Gwahm6tMjH47zEEF5nx3T+VLl5Q8klA7mB664=;
        b=s6V2CXqZW1pENHCh8lHrxz/wLWOVk3I49A1FaAv9ANxSaeHPij7Zf9CXGm00U+8lAG
         FaZgLBof6x3z2LOodufpUiv01+brgNL3UZh3apl1mA2AuM9R92kqQd+q4FInRmSZ7KCP
         /iUI/HYrw5gpdGH8qb5Hc6Kxo3UtXYZHEcS3hL0I9Va2qA0qAKAN62ZABWyhXbwrZPY1
         72vwxxB8AWkHOpMl6jYFvfWWHD204gTKzCXdwOYE32kmy3F/aCiO8xG8oB83we4I14re
         fPP4mBJ/bXJx4ZlCwCJuJwb2Bcg2ZixNIQ3XgtegjtR7gM/YlCK8QZ0tsE64xAbvfCi1
         +6rg==
X-Forwarded-Encrypted: i=1; AJvYcCUWB9puc5EMX5BBUK1+avj12qo0TO+jkp09bOPQRJ8+4batHlPaKPxvx/D0hvz8Y/9kS/A41rDXF3/9618=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+009AJt64FkTLAL+w621F4pMX1d3irgA6w9XJ6RSZekIDh2H
	Ksf1tDNTZkChKs3InoyvWUe7QIE9d1Ruek+BfLkRMqKmIRoTXaU0SdvY
X-Gm-Gg: ASbGncsnOPmtkmWlnlC5j5Fm+HX1/XiyKmYpjalbWBegw1q5o0TgduFu7SYgksDqIgj
	kgssXPSfcF/4Zg2XFibdTrwhrdUrjyTPn6mXfePZaeJaUJ+1lOxRnKejf75mNiIJ/PHRTfcvO+u
	f6dYYoVBKcKPi9Px7cN2v3Waw2wroek65SArKG40+EqZ2524/utzry1hGc/oz4z1wUkjI4TpBlr
	POGQvhfRRK+lS6B6toXqXVSVjJF8m6QSBOVASk4F8aW1OMwvg1mzFj+yzxOzhN8YYvofEhkom6E
	/qzckfBYgiXajk7oghBHZ4qBFPlo2RSGAVai7qBosVQWSZ7AwY9qM6US2VKwFfQ0cUsnSssAtcy
	KYzpMEnu1Z5tUIRDg2Pso2LHZKkfsR5Z80H3hTpmqzkW+KWlzsDJ9d+bWQ2F7oAWZjXS0ehY5LO
	JIPmbjTU87Zzrdgp/wjsicCZZzVjTngohYKkvCIcRfkKXLMcafsNyY
X-Google-Smtp-Source: AGHT+IEhbwIAKfabrUVIFmF5c3f4H0tzASZNULyMLnrkF3+58Kx389FBrjyRdsSR1s0BEE1Eo4vI4g==
X-Received: by 2002:a17:902:e549:b0:28e:756c:707e with SMTP id d9443c01a7336-290caf846e1mr76225645ad.33.1760757027966;
        Fri, 17 Oct 2025 20:10:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5868sm10321445ad.60.2025.10.17.20.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:10:27 -0700 (PDT)
Message-ID: <a7fa59d4-7c81-407b-bd1b-d6910f647443@gmail.com>
Date: Fri, 17 Oct 2025 20:10:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145129.000176255@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

