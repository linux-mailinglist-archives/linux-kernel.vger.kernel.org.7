Return-Path: <linux-kernel+bounces-742538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99626B0F353
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23112960E90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AF2E764A;
	Wed, 23 Jul 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iW7dzB9e"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360292E7189
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276041; cv=none; b=HfFmdh/s3jNbLlYcrGGqVLeDDjzlIk2TweqxDNaHTwyex/vg4WkxMXSh9qy0H+pwpeyEhADbgmsGytKbYYTcVRthSQtdgagvoRKF1JBAjn2Xs3bt/Hx/w68AhXFek0Yu6v3dRUiRqjpwCcc/OtUVel5C4SY+yp8dosR5ZcfEccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276041; c=relaxed/simple;
	bh=K5g5ghBqJeQ8gfTrmh/oFkJT1Bbutgsqi9q9KbN3jrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCa6aX3lX296y7pQ50JJkl2oU2ZGznp3naf0b+2QralfAEQhO+7wdRPwSZ4kkfJfsRXEoBlnzORowKtMdOoaq3wlTlIlQ8j8EpqoIFUkruKol/Motj+mvlnc7Gj/CRL+mlhd9jByNLZshgPIFgSur5w5vAZ6SJhFvdOePDQwZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iW7dzB9e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31e3d29b0ffso2157386a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753276037; x=1753880837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILj9WSAGRmrcwz1/CE7SMUUUscFZ+MMHiLlins5DWvU=;
        b=iW7dzB9eZwvSxABapQJMhQEjvqHM8W2sL1A6g/GxONea3sBy9XHlv1gdrZS5Jj3mJs
         9RhXDALq0Egu6gnUTXh1SiaTSLd+3LiS2BUOtoUwn7RwkVtG2mCdlVGfV8YSVJJsZhbo
         lJmylEZBxmzXoGWXg5J8naETV4p1QCcSl8ugGd075Gi6BBnJH212r7vVHUqiNkmvjMZf
         jYoqC633xZBTAxHdRYS39tR3blN68kIHkYejdOxXks2Cs5RXdME28kP18uhaFTKPQOcR
         ChUWml5fb1x7BcNL4Huy/hKVDmmf00DRRbn2CaT7jHC10Qi2Bpy6uTh2EvbKsru/RUGe
         MRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276037; x=1753880837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILj9WSAGRmrcwz1/CE7SMUUUscFZ+MMHiLlins5DWvU=;
        b=Le0H115wAZSMVc5RZt38USlJ2kch9LkH9DBmWZm51GU8LVrdZvKsThYfOaA7LaJnT6
         JyNGH7r/zGW5vfUoPlqA3bHAjKLSnaIYdetTeaVtyPdjfiziewAF7yhooS17z8wPQa+G
         yd4X4TWVg0OPWE3Qn3Kbz1Wn7oHy4Wui3EVpFszxbgBkmf38CVPHofwkyh/pBYLTKDL9
         /LW1IxD65wQbZWwEfHW4pWvBf64MzUyPoogxa5+I3EQSA92rKJb5cG/84C+eDDH1tM7M
         VTPRHTfn3dbJVNcBZ6DLeK1BjskiD3m8AG51v3aYmOSHdAA2PM/NCJTKXK4qkPyVXVOy
         F3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWRX/zk2JfxUpzMs6wCqrCiipmVIJTapmEsPFgcispWyL1Qu1y/MYdXUyReqNtPHHb/2PEyv9UTBbzHmIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsYLjR6bIAfXV0tOUmTCJmvXa/dsRwSV979/OYAwbdkl2xX1h
	GTlDBjs5GnHwDtfEjzpQP1GluP9+vHQ2nyiy8pBQD2ld5Kv7aVH4+SQi4xeAillCm8cxVhFjcSp
	O4viMBlu60zrAZltkicnAOOiT68CiVtAMEUqF2grI/Q==
X-Gm-Gg: ASbGncufX9TofNEA6ZxeqkfCVLyelORNXr89niBRWr6fpS7Wx2ZTE8rOu5XmrqmxN8v
	GKi+0ze7o2myEj7qhq2Zkg+ByTD5lXDjZdbHQt/nKMwDn2qGAh59yck45RMyRneSsX1rWBpRoDA
	IO29adIXlfYFpmFivW0nfhVfpz65GJ7DjRSaSRUzKrm2zoF9tCpkf66wtBClCdTtqlzHA79X4yU
	gtOmVIPV7Qu+y8txRX+PZzTgebEXp5TPzxWIY0v
X-Google-Smtp-Source: AGHT+IFFU4rGd/eAENVQgxvllM7kgatqYKSu45A5IXoyTjOesjXiiHd/HlBjUVHHJk/SHkBrHRo8js/6zPqOdNttFNA=
X-Received: by 2002:a17:90b:57c8:b0:31c:260e:55e9 with SMTP id
 98e67ed59e1d1-31e507dacffmr5191069a91.24.1753276037411; Wed, 23 Jul 2025
 06:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134328.384139905@linuxfoundation.org>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Jul 2025 18:37:05 +0530
X-Gm-Features: Ac12FXy2f0C4oio3mLtIgEQuU1pBJlEEwNWkdnl-ndkktKLp4yIP8BKyubkNb5E
Message-ID: <CA+G9fYsXUvYV3+JQf4St-NjvmMoOOpPCZZ2HqDxcVAoZ5kCd=w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 at 19:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.147-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.147-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3a0519451f2bb2cdc91626b4ae69a622467bc60e
* git describe: v6.1.146-80-g3a0519451f2b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
46-80-g3a0519451f2b

## Test Regressions (compared to v6.1.144-92-g33f8361400e7)

## Metric Regressions (compared to v6.1.144-92-g33f8361400e7)

## Test Fixes (compared to v6.1.144-92-g33f8361400e7)

## Metric Fixes (compared to v6.1.144-92-g33f8361400e7)

## Test result summary
total: 223705, pass: 203512, fail: 4887, skip: 15084, xfail: 222

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
* kselftest-livepatch
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
* kvm-unit-tests
* lava
* libgpiod
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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

