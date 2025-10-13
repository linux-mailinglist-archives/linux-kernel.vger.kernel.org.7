Return-Path: <linux-kernel+bounces-851039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA2BD52F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7EB18A5889
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E02279DC2;
	Mon, 13 Oct 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOvdfm91"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAE2737E6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374033; cv=none; b=Z6pg5H0SQrcDbX61AfPE0Syw1EJ4K0Kzh7QGbuGF+6Sptl49NzGAmOsaJ5M3ooOYKsEHgfpPNbpMff75oodKK36QNHjs+KjRi6eXAgUZOE2SePHDO1zt2jegko9jLw6M3+7uS/UvCS/WxZR4a/Z5VLzcbpinO6Q+P9XT///LjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374033; c=relaxed/simple;
	bh=nysorLopTDqkbUL0tqqaEE1x9Ol5vXn2RSHBgnImewg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NblTOjXjTS7G6gjRSxPLaiaAhbYilOIDMUgjLmnPZwd/68GdBjBOrAxxIx3isNHRNMy/pA7BZw5QXbs1rCEku1LiQVzlvMjbijXbutostxKGZmICSTd20xFlO7UwqX5YgrhrsldFIARRn9ht3XongblvKjBVnT5jPq6TNazZO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOvdfm91; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3306d93e562so4485237a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374031; x=1760978831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voyfMb5RRcwzl6imzXpESkU1fXWIq4jQYbcfjDP3qrI=;
        b=ZOvdfm91ZmAAbeVTYPxQ9XA3eaqUY3LYoqdydv5yaBMhHGFbaIYR3WnKsQG9tZKMeY
         1svukWkhnamC8tQENgkjhn9OxCw6A1vS8/POLockeWdGEJ0SWHQkce4vOliM0uwOkRxM
         VNdt25GwCgEojXNGJgr9c28Iba/KKrK8uXR3AFI9QacAGMvkj++iSzFt9BsldLQhuBfb
         +zyRYpaCxVFiANj0JcPCzkapbbke2PvQwsokMkXCTFsurgGLgAfcabY1au/69o6DPF4V
         X6ao1D9tqmmE0caKXYvRBGgLZ2tPWkBZK/s/CYShX2+wYK5oXYxgMgqCjgI7kWgi9GlR
         5siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374031; x=1760978831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voyfMb5RRcwzl6imzXpESkU1fXWIq4jQYbcfjDP3qrI=;
        b=kI2SYWN28W5ms85p36EUXbG5WXhqvzujzM2v1lRuNAyPc1XuLqQ28iMzyAlXJgKGf9
         S7svUHTeajQyrtpJUJOaYVqXepfHeTPuo8zUWbYZBJDX8zSfGlocyOxNDavgHBLCKVTg
         CuEcpHhO1jazs2cANSkEpWn6b8B6PvH+c8GRrGhVy03gUbLUh2m9TVKCvDUbZPb1RtdR
         0HVV86GfKZoyGl8O228YdJ2aCitfmInMqNP+wKeMFQJWx+k0p1nN53xnHlrvRKgT8Fhl
         5wshtvvwcmLP5yjZkB+8KTwatQPgUmtMQz8Y/xrZjzaQr804egrWKk/fKZJa72450Wtr
         vM+A==
X-Forwarded-Encrypted: i=1; AJvYcCV6dh76YtRVqZBTQbeOPAnOfEu0PKaStv0/ygWOhgUZrmBdpJr3TSIzt7FiWvmvxSWPdzxE5BJ9M+w7D0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55T2vhs/dEK7D1VVGk07oMNKQl3GcQLWHOZfsdP/KrNIYALC0
	Uvtd0aTKUs0Lq83MfjA9/qYtGvYTffTaEjyFpop5qQQF/76EmMnr2yDt
X-Gm-Gg: ASbGncsrO1Zif568H1+wl7lw+JmV+1Nc79KJs5lTYMRn/ngMVXDBmNN6a7HxAhsueJQ
	54ex2dboOJMmvlYyDILBupBOpJl/cfWo+3THMYmkfQ2nu6+lW6i3J9u67IFJsmE2T6+ugfW31dE
	AC0aP75d5AyJcn/0HrcmYAHT48+Iat7JwcatB44whZlbuK6elsmBkmjVm6WtpIBp7gfYXhF7N49
	IGHd3T78iNGRjGsiNe739lY6C8Hg6tyxNxNwdSvfHDBEOxnlvVNiOzPrcfbPFnhUtonKY7y5nFG
	TIlZt2qk9diRVo3c0Jc6bJ38U/wOvOYrbwATJij5q8dFvpts5kzrGeSzhs3uz8NU9nf1VacDaXc
	hryTPFegCaBwoGcrCb7ebOt79hgSaOewh2nOE/F2gv/0haOofXoKlMeq6RNQeFsE8zPVvRdNWL0
	qRkcE=
X-Google-Smtp-Source: AGHT+IG1Ysy5KBOTuH75LYJyCJhrc7Jg42bTix5dwVq4VuJYEECGxkpdofnArrrEtSYwS+l9+qhUwg==
X-Received: by 2002:a17:90b:1b41:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-33b513d08e3mr27148095a91.28.1760374031086;
        Mon, 13 Oct 2025 09:47:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3dbsm13073884a91.4.2025.10.13.09.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:47:10 -0700 (PDT)
Message-ID: <5f1ac6fe-5b28-43f5-b143-dbece62505d2@gmail.com>
Date: Mon, 13 Oct 2025 09:47:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144315.184275491@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.112 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

