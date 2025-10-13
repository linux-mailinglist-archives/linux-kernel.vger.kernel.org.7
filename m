Return-Path: <linux-kernel+bounces-851056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF275BD54B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF951886A50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2529B8DC;
	Mon, 13 Oct 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxsY4ykY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCF29B8C7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374667; cv=none; b=DoTKMrsapr190b4uBlS/R3GI4y6M6sZgVWCF4c17G61KVzTL6+EB+ZE80V+GKfGAIsgcObLbVLq/2LJX7FEY5WZKUayPP5vDgCKSB/sgipIjhSqcHF7S8DwlYcBYf2OZ+COXeKh0pvpaFEBkKpvOFD8Y9gclXiVsYuzQD2I2pXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374667; c=relaxed/simple;
	bh=uIZm0faNhTPOO/c5jIlL+XBC6TybQp8kD6+Bxh0rKbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOPyJ5IpA5nkuDODSXoIs7xZrOBUvJ6IC1W8vU17jXttNiFSLvBoM1uDqzlm9/EOyyUUrTzJQQXaQy/9Ysx+ze321hkPS4glGzqG2dZrf0wjtiCqWJVXtB4fNOF3/p8CA3MvJ/OsvCaZt0O45UyHyVkup+e4fwiJQr+3sBa/tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxsY4ykY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f605f22easo3805126b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374665; x=1760979465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIBQ7DXPPtVFtqnlKJKBgEnwsBKQuDpfZoq02adf1b8=;
        b=hxsY4ykY8MBlaVfSkEmXZpmSXXCnPFOdZ/1WcsiRq0SX+mvHVCUd8xYaKMrziZEdXa
         S9viHCYrpEFDs+/U2zzQv8j/4YM5iw0NtcZMaFwhIoewcr5Jb4ahMpcw98nCECkxEN4d
         tgL+eafs4SEiQcvCpjNi6jwkwJ1mz88bvukoSb8lHtoRsOv5TJTcHXqNBvdURfhWo9G9
         DsFRX/Q5zzz/iTPo+nXDAMCASICNPCXIs9nIwJI2G1YWEJXDF3phfLZkqnLRTRimELGf
         32UYhp8gePcF34YJdCNYdYQ/Ws3lj7e3+YL4Ula4xDcPar40fv72mMAIydfzxckT16pd
         fUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374665; x=1760979465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIBQ7DXPPtVFtqnlKJKBgEnwsBKQuDpfZoq02adf1b8=;
        b=rNwyHOFCygZoZY0oeRNjQ41v460IkWPvMfJTuAD/SiQcHv7BcdGfj/z9eTmOceCLzD
         lWsloF9bFudXwAv6TQOLNwwciYqyXuqRj6aL30SVcwbnmEWIpelvi1t59FbTCGLSDquw
         InkK6snfMGPqu7M02ka51aHL9xeFBxNsW2+6ob18n3ovkGW1SL4U/MRwFDPmJA6Bo8FI
         w+FxWiUAEv7BUDs39a0QIReEbkPzSg7QJbh6ADyndYvNQxLN1PVQmcfhlU8dtyRdIiEg
         1RyIGvZf7hjcjRrfCzLUBsenY/IytKTllXhSWizEmRpoVQKZhGFz9eqWyot7Tmkd0Y0S
         EVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsTTUVzR+ReUH/YPYPgpsAyVUvW5lej1OP1rP725MDyVbG8qG5f8F4uLXQIaKbSE+QBjU+8GJq94u8y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8+jNe+oRnvDNAv7C2E0UI6zlqlCYx58GrRmwfXlcexHWoNJH
	64LPFdYwqEXnaL3M0Rx6guMj6dKQQHkGYEZIKH52xf4O3h6uFub6lQJ6
X-Gm-Gg: ASbGncu7b+av+yj1+YyNnHfwmrZza4+VgMOHw8zrRDtR4OkCycYZ4n1xQY6tXK3bRHF
	S2P9T4rqdzUiONQr5SM2Jh4kQleCq3kJKZ0GPA2Sv7QbMzPK9CkBSaZw6qjDpbbiyHMYh0nO+F2
	yMYDzKRNfayjbATPRn+mjhUDdsHbPhTpJN3ThY5Y7PcrUdFwEIih2vius+EYkBFG2SrMJHC4oDA
	1AYRSf+a+bjmxJfiaqoAxi6qDOrx6wDTBiyoOtPJifyn49SIhE3Uq6Um0PhP+p+ycpA+mWOHprj
	+5QRqYeD0bl/tN47WS2Lr0xOXAy6da5DtNGnNJvN//MKbFzfHhJfdu9UWpXjk3U1o/ibBPAa579
	vy/KQtam4pzihPRrlyhzNphTW/dPoXOqsteDS+xyS/Cq4vBHaUgfQce4o5vubLbShdoSZ+XZtGx
	oNVpvdxui4mYsWeg==
X-Google-Smtp-Source: AGHT+IF/F1baTGtfkyX/X4yywp8EinMnUc951in+FzSitmy5hmr0L9dH/16lif2v07+i6Ky7Ytd7RA==
X-Received: by 2002:a05:6a00:17a5:b0:781:1562:1f9e with SMTP id d2e1a72fcca58-793880f0678mr29157568b3a.32.1760374665325;
        Mon, 13 Oct 2025 09:57:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993340sm11936331b3a.72.2025.10.13.09.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:57:44 -0700 (PDT)
Message-ID: <cafe0391-a33f-4bcc-b2dc-b1ac524c31ac@gmail.com>
Date: Mon, 13 Oct 2025 09:57:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
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

