Return-Path: <linux-kernel+bounces-872441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126EC11303
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E573F506DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02E313E17;
	Mon, 27 Oct 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAjQmF8Q"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78E23EA92
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593510; cv=none; b=oC80pOkyaDsmmbOkvt8MONeo6jYwIH9hyQplUOcUSKDPw4LHQKME5UMFKdlfUrBv9FkVsnDeCdN4c5KGGBRnmn3USR5q+pTkFZH0AGKDWMYgKBjYS74D8u5w0G1j1g//wJi6M47+D9mRV2ugYS1PcooaSUos7+JEKwsxlEZruv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593510; c=relaxed/simple;
	bh=Wfw586FZsQVYuyKx2zTL0/KlV8MshdPbK8gyqOvNcfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlutPiXYHHxiO/4lH29w5h+0jCNRc04e/jkMcsAMYNUIZJjYKFIxL3x91v5G5OXxpkQjL2lz4yMR+ylsHMcaULzLRQOL4ePBpUv1/YyvDIRs6WwFvNcP87GCJiekUeJjMkSwhe+KxCeDwZkT1Q/8VWyCOXblSWThRipTdJjj7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAjQmF8Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27053843bso7022779b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593508; x=1762198308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQIEre2ri1pN3eJbczeUY9nkqkn0UVxrRDPMJROpfpI=;
        b=FAjQmF8QEaMq/4sEvxiPtMVlGIDHw71iK1Z/aBQchBBLxUv9aIzjJzAN8+P0cYwOe/
         5KmSx/F8uIgpx70W5l4Z9B5tZqGkCBkP4R0Ih/PjEJbSFp4cRK/NPkHagw50ZgQJbGom
         AfsBJRR7mKuWf266I+sJsaY1W8s4Ox18oZft5tMW5rZy+A9DeheLyykIq+yMJN3VBD4a
         zKKsH6SOWAvBhWqqs7SLViQJWnUipLnKWxFlU/lbgu8ElgHmAgDcUK9TrdS6BFlqJ+Wm
         D5V1MBeBJpJAHaCKnkeGTC9wnVia6ZP+2eded35AMd0ZU2on90RmIHyCuvIHzyNRofoq
         fDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593508; x=1762198308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQIEre2ri1pN3eJbczeUY9nkqkn0UVxrRDPMJROpfpI=;
        b=BYORdHgT3r3lWyP/SLj7aRkbZJaHGtKW5ifcnBpt1PfJ5ztLeeZEAfPbfuK2rzewC8
         30/ZNCJszRvAsVgZjX1ol+dFi+Um8auO6RMTr1JzrEvBN2s7+aetWPi24ZcEKm5tF/6n
         oIfaM+xSGXtpxrHeiFl6ETwr27OS4dL29ZsnGsDg8l5IYtwAEL3g3qXzTyy32yyW7oZA
         m4YqXRtMUtsJYkgB3Y/on+qdiYYbjbsdmwjtHVP+5KQrlSsSbo0RASKa6uq4vNKN6j+p
         graBCILu1DT8q1jkSlqj8OeILniXg3/579dpVdZ79+p8Owx8vqrKlwD9UpZ8g6K2+/qP
         1l6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW3T79D98p8xww+lj3/5O1us0wXAdhbneq4iQIb4v7xH9g7+TgU0c9tJyMiNOPsi31zsZDr6wK+j3+Rc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGZHlSrx3bRhi/Rg6BpMtaXIAoVmEWfrZA6v/Rs9tCwxDWN8D
	vGs8sk/Gfi/f+h7aIkbyBS1JhM2ovpG/g8QSctQ+V63wyXXsEa9JL+iZ
X-Gm-Gg: ASbGnct2/ob/ziHZRqeBVECzqSY4gILmUZlY5MYU0zEEiMjzyO79mECN9wBrc/PVs2T
	znqd4+jHUEBUbSvhsjdg1D3UDykgU2utKoaUgkbQsBAnjSPu6HHWP/c6GmYF7bx/kMxxsG7W3mb
	12HaOdHc5MYg238MUf2NrKvnnlQFRM6UWmVVmL6WYCLaCZ50hH0Dvt4GRlwrQr4Ett7e4eFrQDr
	kNHSUmHYmG/1f2fAzsMyXQFvgylMB3CwUZBDUeHJQxSanSjk1OJ3a+W8j32xu7Ye3Q+AZYMrClP
	id+ilFVqTeueDbE0DbckdqQxWg+ZJHVtraI7BmsGiwTYBihWKDKSlj59GnuxGpX3AUzF9BfIZil
	RVW+6mlarCNQgGhDTgbmt+rFW5TBDFwar0FKYQSg7S4ENVvarQj2OAV6xvFThFm3pgSQ7yCE8jl
	qcWxdlEVHi7j6aTs8gyMLj/th9a9FiW0gNsKtG9A==
X-Google-Smtp-Source: AGHT+IEkosWML/wG8WDCCZZJB7OEe7Pbs33Ch34uBEMhw66C9EPkEPTbWzwlAuneyQFI3gppfP9HKQ==
X-Received: by 2002:a05:6a20:914f:b0:334:a72c:806e with SMTP id adf61e73a8af0-344d441f72fmr848282637.43.1761593507941;
        Mon, 27 Oct 2025 12:31:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f0c0b1asm8203659a12.32.2025.10.27.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:31:47 -0700 (PDT)
Message-ID: <eb241eee-2b51-410a-b13b-9511202a68f7@gmail.com>
Date: Mon, 27 Oct 2025 12:31:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/224] 5.4.301-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183508.963233542@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.301 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.301-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

There is a new warning showing up with 
b27e16c9e625465fe9ea9955bd8ab095498de9e3 ("tcp: fix 
tcp_tso_should_defer() vs large RTT") , but since 5.4 does not have the 
full minmax backports this is expected:

In file included from ./include/linux/list.h:9,
                  from ./include/net/tcp.h:19,
                  from net/ipv4/tcp_output.c:40:
net/ipv4/tcp_output.c: In function 'tcp_tso_should_defer':
./include/linux/kernel.h:843:43: warning: comparison of distinct pointer 
types lacks a cast
   843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                           ^~
./include/linux/kernel.h:857:18: note: in expansion of macro '__typecheck'
   857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cmp'
   867 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
./include/linux/kernel.h:876:25: note: in expansion of macro '__careful_cmp'
   876 | #define min(x, y)       __careful_cmp(x, y, <)
       |                         ^~~~~~~~~~~~~
net/ipv4/tcp_output.c:2028:21: note: in expansion of macro 'min'
  2028 |         threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
       |                     ^~~

I don't think this should hold off the release though.
-- 
Florian

