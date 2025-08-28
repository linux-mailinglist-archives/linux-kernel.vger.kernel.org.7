Return-Path: <linux-kernel+bounces-789413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62ECB3951D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC941892CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCD29CB32;
	Thu, 28 Aug 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMMhTHSu"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CB1FC0F0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366006; cv=none; b=bckd/ylihhWV8ZxD9qYACEPp6vdBXKwSnCl8mONEk1xS+bWeR9xbU3XXREPs07d1QpQySsMBKe8Ktfgocn2q3l3vGtk/rJ8U4H5fPkLMRU1flJQo6t/lvMTFI7uxKAKSqbaLqizfA5INmC+V1CiIV82Zog3dMuovmqSXkiLTz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366006; c=relaxed/simple;
	bh=FWeqn5vRZAH6k0pKhP35N/soh/ogrNerUNcbSo/TcDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewNM9JY3ZSd/QpkgrUl4zonI2jzeuEYCFkkOM0RKXkuEbXKuImq5mE1USWHDjgKJsjrWPlTowEvMPkqLeE/5GRhLgjZDo0FewAuIzC3ktqXYgBprWFEdp6tnHshraj0mmO6MeUstxBLeaYBmzaDeFP9mnTueRHS7sLwn5LPjTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMMhTHSu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b2a09bfa2aso593471cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756366003; x=1756970803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7deqPVGcNTC25viCblNvhMMKUTMA22h7onsyE6m/3YQ=;
        b=qMMhTHSubkfeBVCiHEsPH8rqv51/6Isto6DRac3BYo6yoJyjB3R5cIUQXgwATWnxF9
         F9fw0i5eAvt9xRjcAmwTUMA71ZxgTBGsaPPF/D+Bwv7bBuKD7P+/q51EoL/4Ie2AVhUg
         HzMoE4Ec50FvUC4dHnbv1J3bG0oV4TXBqddHzHeawPZ5zUddX7gSyuJIL2kSfsbibG1o
         BdEGqeb4dd1yScngzYsCnZTZ5We7wBivNn7vLxzQal/Fu9Bvl0JiVZ+dHVE9OKpGWjnP
         mef8bixg41e0lPbdmGgK5NoILU5wSEeqqypjkrYdKyqLEwXPMbG9p+8/9IX7NeHGew/V
         KbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366003; x=1756970803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7deqPVGcNTC25viCblNvhMMKUTMA22h7onsyE6m/3YQ=;
        b=USEUxxCo0N8NNnEBsGs2rtTYBpiqnEQf4wD1MMQkFi+ORz9LXhkOnMr3G52k+S/3IL
         6lrENX3JkPYdVzOFqhAkQ2KpUnGtguFEPnuxdymUgr9OHbhRr724sB4NKtxmbVcIguLL
         MgM5cBQ/wm/mJ0o5QCt46+5SvyJN+Z3hJfiANx7GnDcVMr2DsDNDBV09c11Qbm3xVNNH
         o2rZzjJvzFP4kwoPX4GuBT/VmcFvcudu7qTA5SPHuKeNwDOC4HZmjXL67Zp+xuy3aNP3
         dIDu3Epyx8ChbSVyyV9kymBmYmo35ZGc6tFJVq0csvvB0sg/ThpC4/m/RY+j10XwEaNM
         02IA==
X-Forwarded-Encrypted: i=1; AJvYcCV+eMu7emkmznZZRqzPw8oN1Db7PWOapyGThzLAxV6b30noBZz+6pQHfKuVymjoTyyGNwPx/ETvqZxjORk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkn5ub6AfU/cfuEzrB26uWfYnhS3F4n5lykgCQoX4gi03hAPa5
	fc+WN0qXIEyXSvzcdf6x6Le3EFzTxd96P4EdQekXHuFeNBsX/cAItbXG0OiiSLxRCuwFnPvBKTv
	1l+wJKU/GoMxeroyLTD15Juqh0PDdJ/uvbmmwRrSB3w==
X-Gm-Gg: ASbGncsuxJWdc3h8wTriYw7xht1wYhp+p4XJaI8eWpsfgSTLagQ2q0ZTgG7FBilRDv+
	nTGTmkekeEUYQjLyg+P18TjoTYPbrqNPiXq61ni5yD4PDNWFCXyZrfSDNkUM2H+Fz5UXyplBLgv
	cBtSU6V5nPwssqlVw5pJ53beBjwVY67vzUex0F3p5WWPKhg+0k+tbNkVo3TAMej+EI3P4disdjC
	Stj24P6V4fZB/Cj
X-Google-Smtp-Source: AGHT+IErKUhUmI37jeBXoTvy7qMI9WCIiqOnvQ/h3DmG9UhJAH1k1Z+eP17jDLSBcN8nrX9bC4v/R4LnJVxfLQLcGYg=
X-Received: by 2002:a05:6214:1d25:b0:70d:96d0:83c9 with SMTP id
 6a1803df08f44-70d970c54a1mr165565056d6.2.1756366003397; Thu, 28 Aug 2025
 00:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827073826.377382421@linuxfoundation.org>
In-Reply-To: <20250827073826.377382421@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 28 Aug 2025 09:26:32 +0200
X-Gm-Features: Ac12FXziFZRFGNoRBwgurFlgUSBKRKa9JvBPPmeOBJJCRxUePGr8466KojIL_b0
Message-ID: <CADYN=9LV1rjG1dv-Ctbk24nwhRuu+a_mzBagaFEMZkQ7qG65WA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/403] 5.4.297-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 09:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.297 release.
> There are 403 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 29 Aug 2025 07:37:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.297-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE: the previous reported arm64 build regressions have been fixed in RC2.


## Build
* kernel: 5.4.297-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a860ce417cb1ff7332caa94fd6014183f8639a17
* git describe: v5.4.296-404-ga860ce417cb1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.296-404-ga860ce417cb1

## Test Regressions (compared to v5.4.295-145-g6d1abaaa322e)

## Metric Regressions (compared to v5.4.295-145-g6d1abaaa322e)

## Test Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Metric Fixes (compared to v5.4.295-145-g6d1abaaa322e)

## Test result summary
total: 43352, pass: 33098, fail: 2462, skip: 7622, xfail: 170

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* lava
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

