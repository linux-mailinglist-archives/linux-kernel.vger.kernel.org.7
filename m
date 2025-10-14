Return-Path: <linux-kernel+bounces-853187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADBBDAE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B309E3AFE00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB5A2877DE;
	Tue, 14 Oct 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oz2Mo6R3"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21B275AE4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464806; cv=none; b=Gcm++NVcY3k6QBba0c8O1QyFJFAeDYXv9ai4gwW5KGOCTO5DExhvGEeXNfsWhZaTmX5jhSF7P4EWufGYoouPwFieovuSsrVJTuV7O4Ru2r+GnuPX0nuAmyBjPeKWijCdUiThWbSXeYRE9X2/8lMOyjrBSgVIoGBX+Z6WAlakbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464806; c=relaxed/simple;
	bh=21ukBTCCWgadknZW2SMkQg2BIIiZPeGfnkE/wF+Fy9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baUg587nUpJCwg+UAITRcyzxn+VSbe3eAD00xoE+iYvXxz/3hiwgc8VqE33ZOnZeUzksO799+qTzkVs4dz8ZR0y0tDSSC6NjKE38YZUiK5zl26I7MrgvqhPSSXCl2n+a7+L6aaAaJa1jYyZewN0xJ27v7yQTdm0pgRFmHOYqerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oz2Mo6R3; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430abca3354so425715ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464803; x=1761069603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoAS4TyvZHgjNFjXDlSUMotpNCainLerBGX8bzDNj1k=;
        b=Oz2Mo6R3hoIpdbJpBi/6B0wo3OIU5/djPpobSyGGKIEHQ4XVcftOYFADm192yejjOO
         bwxlQLcymw1tnJFS8+iWkoisDy3yWral8fLhjDsW/mkQ+YJ9fPqYRlXTEclUBs/i05Fe
         2NjWx0+JZ7e83cuGfrolAINeEm+4an6w2TnpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464803; x=1761069603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoAS4TyvZHgjNFjXDlSUMotpNCainLerBGX8bzDNj1k=;
        b=mOrF+2kDKGQB7WlMJ4jnc3tvX7bgK7AZkW7w9Ra+4fQ0z+lJQHCqPCZb/+ZiFBHF9H
         LIaQQTWHfV6ZVlA2Yfa/NkS7wQ0XKGRLymG2c8qKjlMy/enf/pBE1/CQ+dLGwxzOGf6t
         v73RmSxxQCne4xyIJYzZ7phnW2/0VrgJZH6CskoOR0QyIY5dnMzMpa6lwKZTDra4q5b0
         AqMQpr+x0GK+gJWg5PKDG2QiLQRhifTVb+/m0AXdtPDeKJDZaS034ciJ1ZNEf0xo+glH
         yd2OcLNZfnsNkfZ/xSWXFiUnGZNdaGO0VZqkGtOIEhw8mqIv/w0ep7PGLEHOcYldoeqK
         Z2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX58qCCOON8lb9hunnCPmZP7RD2jj64QZDjdMkeYsd8F75rx2+eBvHO/Y+1hX7jYZmZiC6YSmR7UP65LoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyubGPwHEbvHiOXd21zHeT52AltTCREvNWdDyZOrZcMwcA16Vqn
	b4pP+jvTTBXRyev3gCNBR2+jq8btt3XpoGvDl9d51ByFpnPlfNRCqJXxoTSHmEyfJsM=
X-Gm-Gg: ASbGncvKF212CdUZzs3qs+GVkMXoM9h3Li+er9+T6t/GLR3AGyOizQb96NwqaYvI7y4
	CsYObVblQquImcBkJeMhziuaEsO13EmTZZcqTsYAbCOrT7+qkidnqvwlbCpBZgeCehnuOaND/nq
	brPc49hI586ikQnitndS9h6pjK5arREky0phVGdxX8Wdle0QFPs67GwkEXFUydtBd+v6ZTGbiLz
	lqhw4BtP9Cgd6UG9ZLksNj/lVSWj7L3P4v5CptTIdmf/r3ambAlrvYKjJ6pnNs1ye/BUGtJaOkt
	WrdKcj61ykIL92Sj3jDQ8gBq5pbYQQfOoVX508FCQXebsa09LbSn/IWU6EB6vVdnRjZhmSeWNDe
	MEb2Ldrs/JuqcAcp4cjVNvaVtGTqJ1xIHy7LXfYJ6LykwErMWqt41k3msYs+UcTdW
X-Google-Smtp-Source: AGHT+IGs+0qZ3roynS5JzK/onWLpnh+nlFehYpcK9FuZyG1lduY4TIIg1ukL/IPrYrEz/ELyjmlwjw==
X-Received: by 2002:a05:6e02:2501:b0:42d:8598:410c with SMTP id e9e14a558f8ab-42f8736931bmr330675805ab.10.1760464802510;
        Tue, 14 Oct 2025 11:00:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a3869174sm8014535ab.15.2025.10.14.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 11:00:02 -0700 (PDT)
Message-ID: <24b09edf-7f27-4f01-b745-8918da8b3c37@linuxfoundation.org>
Date: Tue, 14 Oct 2025 12:00:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

