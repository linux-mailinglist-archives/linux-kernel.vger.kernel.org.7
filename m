Return-Path: <linux-kernel+bounces-874828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2BC172BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71901C28124
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856ED2DFF04;
	Tue, 28 Oct 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="dpPJPkrN"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CE1B6CE9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689956; cv=none; b=BKuxKGtFzrD7b6XCvbQXDYWchlP+6WOKIuJCb46BRcfdeS1NhkC+fq/wXzqgHE3pcQNfx3fTUZFyUMEXyo0UdeETbrhVKd8ssp9nOrUykYPTE/42QuNChwTYBcjhG4lydMEWfOaxpMi6blKCYHUYvMZB4imo3O+E1QCw+JE7ttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689956; c=relaxed/simple;
	bh=mevXSP3pEnwviu7Dtj0yYMRGZGl7rzL2dcYI/FArHso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5xINcRASzn3gBKerYCHjcI5ebEGxf4s+oqt19ey5RQLqRePMrgtTKUrVJWeqzQy1XrWqHNLtd1IRnZM0/DrDce+/7INNSvE0fJlkWq17CbbGQoLDTymj4Q54x+iK8CMDusns/hj6cg5w2EoygixsX3LRbpJc73/m1OKCX+qa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=dpPJPkrN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f2b29b651so662556085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689954; x=1762294754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56ATqaJhxY4mgO71KSReEDqtQk4ZYFmHYwLd5aGRlu0=;
        b=dpPJPkrN+UfeeVZ09Dp7awi3OINHjrL/Vwt8g+FGDqPGDXJJdn4WOJsImyIYhXm1KA
         ENt25tGaW6ecrnIz7JkYKPErRo6yGtGIRvh1C21vI59Hjvft3fonFGulvDNZNRqU3s90
         j+N+Ayw2MnHDmUZCL+hztl1milsyDzCUGTOKp+38pKkU5J9LryQHd2qxhIcXClegt2w8
         QMylaZKe+1emIncnacjCnpVEfEXKH8I3boyut1RWVlLktzqII7pQeDRoaNLd1ql79g7S
         5eosyKrmuIC5vnQVsGLlI6ZnEyiPnkdQWNbGMSYJnnzSk9sy0DAK+MvtlEMs5SokrzZ3
         6ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689954; x=1762294754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56ATqaJhxY4mgO71KSReEDqtQk4ZYFmHYwLd5aGRlu0=;
        b=PrvFcSNC2IjenNkkOkYaeN55To+2k6weAOCA15SwgroEVfAbJGoyHMga9EMYn9E0BL
         OvNDPYV4O8zHZsPLOBMi1ZihjHGEJ8uq01pjAwggkRg4v4sDYqFpDZHoCbqHeYaZa25J
         s5Ili6rSGoEi162elG4lAaijTg8bWSR9gLwxRWYLt1vaBsniEWqQTsDgzLkvi+nEAQdi
         TjHhmJaov+SyMrSL8LRCLqgf4YnVXiFb1uqGGZ/iODlwuxZtRT35+r6c/xXRxCSr49Do
         fuL9ILG03tzTJXP23KcB9iNAto6zdQayCOU8CDB0JcQw+jDUDvb2R7AnlQxxiZz56Wnm
         GXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWUC7pkObxR9vppHsPoW9AwE12yj6lDYUcMROsNK4b6gtMVhA6s34w1gcUfkD3iDA1rd/z8FZwFy2fxnAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvXxHoyRVQhsCl2IFd+frJupB1WCMPHIQM9UTAUBR6T9qxulj
	DTnCEbEyOCCGnHeyNASjRYz+1naqA03PYavTSnHOSmuhbWSngatrWx1CWyGajnD3YJI=
X-Gm-Gg: ASbGncssbguPTrb1/zLMPYWrgnrQlLUjnoGTWcjPisQ+vBaTUQVQ3TmUa7EaX38bi71
	/ccMWM3dKVHxD8U+S+LzHShtcQzhZPTbFSS+BFJSs/73HVsLUerZQNWbwEnGd4GCIoKndmxyaAV
	JlBMPJSOLcFlWUGqjuRjXusW/5dDRuSn9JrQJjQRNHb7oDC5aORkMi/gXD3kEF3e2m6XUxeBLtg
	y12fgOgqx9p0SS/uJBDby9sh49FIrxX7KdkhM41tj6ClAIvgvecKJ+tadff46cmzab3jyRaJew2
	XRxwcv/ZVjmeMGMeJ6IhJ6QdpSSv/iYD21SOzwn3aXiVT+C65MEr/dPAwWQjmf1/K6UrbZ/nOzl
	dELb9qGZEh7tKj9orECpYkeaL5qZ/6auVwFqWYk1Pzt7ZRxHmKmvWP28LwF49h0WxwkO/OcljOc
	9uHsi+PM9VN4NCAA==
X-Google-Smtp-Source: AGHT+IF8GRGi5y+TVmHqaFaB9DksAsq59HHx98BAT9jVFEgFA7NH9GIYqf3/VizIifdNtLOSDGMHdA==
X-Received: by 2002:a05:620a:1a18:b0:8a5:331:b22c with SMTP id af79cd13be357-8a8e53d8000mr152397385a.43.1761689954189;
        Tue, 28 Oct 2025 15:19:14 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3830f16sm80099491cf.22.2025.10.28.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:19:13 -0700 (PDT)
Message-ID: <b6e926dd-810c-4123-bda4-5ccded5f8b6b@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:19:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251028092823.507383588@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 5:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.

Built the new rc today and have nothing new to report. Stable on -rc2 
and my x86_64 (AMD) test system with no errors or regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

