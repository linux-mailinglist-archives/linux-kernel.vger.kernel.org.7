Return-Path: <linux-kernel+bounces-883384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E85C2D4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8B74646AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713B2DCF44;
	Mon,  3 Nov 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXA+7JwA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005326ED48
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188646; cv=none; b=bb10/lXr7vliJwN7oOZcwf0+bJwxhPXw+sb4I48x28NBp9sfeGuYzTz1YTh/g1F0+ZP5P3KX0JH/wK7f72C5VFvtJ/rvuf+zVubuwO+3rui7w2pIlFk4mBKUFfREuGXINNW8LnWhx24rPbZIibZWp7+xiATKvxTP5lX6tqvxLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188646; c=relaxed/simple;
	bh=+csLiPvaXB7cw5DKMQWtltLuwsR3d4lws5+o61L603w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vy7IjjRYCevV5RztQ5osGgKnaMzqlbcwY9BOi5Wzk/863sBdPoDJxfFkFESRZo8NqZJqhlMppm3qKROyDvgTdKJW0w8Y+kPvQ/QjrzoYzts4rU9KX3HDRc0dHzPYNLx/PaTcC8pbRPxPASkYt7nke4uiX3DK40dlV7iHnJewjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXA+7JwA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed101e8486so63111611cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188643; x=1762793443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5Im3Pln0a9an+fAWtgyl0jY5GCpUicHm8/nn+JeBo8=;
        b=OXA+7JwAhARt0py13xRki8ezHOuagy/kjFbmYEHFfcbKEboQhWLUA0oPrSFvsoR6d6
         Q6sw5gUCiCxJnACtCC6wkYw4ZniJfCdx26BpwezTxDjmvitBuzJhCIl/1DPP+e/viZ13
         ckiIWhdtndJ1EaMbZtITCRVuAuCEyAAvCQTQ4vloB0EhznSqhqw4AWFsTwiSQoOPF8cm
         56aeyu36CMjkaVI1z9w2n6puSPst6nOCRIceyuUaLUJZ9aMkVNpXV3FN/8CI6T+4v83E
         wkhN9fSJpEyUOPjpRSOqifBzVZ1Cdo1wiFXjDMbw7sj4Dzl2S480qvjVvBPMAfEwgRUG
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188643; x=1762793443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Im3Pln0a9an+fAWtgyl0jY5GCpUicHm8/nn+JeBo8=;
        b=rw2PPqm6tQCDTUbQXXwLtj4atI/lfsPuWBIGpAmlFstbuqFzL0gV8W/HwDIlSNud07
         tSHQclbvlcTN8Wp/5F0ay8Up+rYXtNmwYGJsFL/8Z08RxK1NTeqfGaU1YxXv/8Q0X3UE
         CAKM4Y7Pc+/+wKzfURCoy2gVbIgqpM7WvCJ8/dp9xJo9UeUXer+r6h9lBQIeoN9jrGzi
         PLLg3UHSp89i5L+YCZ4pa47pvNliVx6VIaWupoWzg40iPr+hdA8eGxMwic4elKPgyhJZ
         5B1FNQ4/XPKWb2amZZIgOyeKxK80FXOkjjtFNNAJ70SCBpz0GVJmMeP0XLQQNXI/7ApU
         8Vvw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBPrueBIAtKljNzfvRPBGuQ/cP0dUd/iyqDpDY+62sUMVJyDS0Jx+PkosItGzDAd/BSYwIzYI3lXNko8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCtcoiI6l6SMgjUXCfsoYL9SqU4oT2W3DgMDPYbgtA+AmuUSZ
	b1kgK+8GAGlhi2/hReJX8PBPeL7Tehen2/0Uz00q+Sv4GBr7ipTJ0isV
X-Gm-Gg: ASbGncvqrc2gPM3jX+ON7SYL369JTkyGOsENykcLFWwU1cTL5v8hua7xmfHY+l/FZiu
	phsSC6jAXHOaWideEo23km7hKZHaS8G+jUCgGaVe0dTW13HidVXZJ+zbZyxnHTCS9gdtrb9XMB5
	Zfi9cANyvCC81n198M2SdtHOH32ETgYx1KqX5i8NhXlyKj7U2yZMI4rld/UQk1Zh/d0PfhliATh
	DP6vw6l789RHpLLRACDGbOspf5gjdZGSZoLHoEOTLm3O+hEQ9oH7QNUSFhNXLqQRCqTbWEfn7Nu
	6whMSfaC2tEvqyym2K6fqHoLhjvwGkpU6/bCHHQYeXgtn/M5F+Lb4U+Y+wqK9JbMcZNRbg1pjII
	Rq+3ekAvxNLdNYT6osltqHusamd04udO74DktaKiQZJqybrFabGxWR6BFjHO01o9TkUV7wQ2sNY
	PMfhNr79jziJf5LLabh3spOHpf0S2fqLiyXyr/7g==
X-Google-Smtp-Source: AGHT+IEUK+QhETnkizEVhsn4OSDbW8TLlREputnus2DePYq7zcOHls1TEMf1YxRKvCho95j2x2XPsw==
X-Received: by 2002:a05:622a:4890:b0:4ec:eec7:483e with SMTP id d75a77b69052e-4ed31055828mr154509391cf.68.1762188643647;
        Mon, 03 Nov 2025 08:50:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbdf2b1sm1644631cf.17.2025.11.03.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:50:40 -0800 (PST)
Message-ID: <36d2ebd6-118c-4847-9233-ff848f6425c4@gmail.com>
Date: Mon, 3 Nov 2025 08:50:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

