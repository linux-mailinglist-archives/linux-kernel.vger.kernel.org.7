Return-Path: <linux-kernel+bounces-859137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BFBECDB7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE09C3B1BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DB212575;
	Sat, 18 Oct 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYE6BzLe"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F42EBB86
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784680; cv=none; b=IpICpZwUDG2h24SyuSuRE6PCcSFRHYpIasu4H8at75h+I4uVDJiF0efiH0JWKg3Ap80+3531H44Gc2TjuqZcAcgF45b3Kj6ThyH46ynVeRahjAkNbN/BbiEGdu2nKlVm2sdBbnAAcXvBh2hm45P78sB1vCZvjGVm1xzb1Q+zvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784680; c=relaxed/simple;
	bh=WC8GTwJNYnj3usj7cIM+YsEpKdRoUi/csrfUvlElHJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuK2eQD0mnng63cgSzS/tuk2jbk41c1PyOO7+RJbReO7Sqx0JMK77nQqdgd+vwZVgt2WdYhe3le5c6ulT9KJEkG91XuK1FiDDp5CXy/DMOjWZU1lMLm8lsSijyujJAQkf0rTP6tZPo+gIJXEJ9gBNrB3H1Pi6Lu0N+dSirAgGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MYE6BzLe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267facf9b58so19394955ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760784678; x=1761389478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UN99AxvttZDth2AwLZ86dPMNpsRX4UzdoMclz90QAQM=;
        b=MYE6BzLeo4KUdc8wP2gf1+Av/WqyrNRplkU4BAi2janyJ7f5Uo+llkVAV/Z4M5yHjS
         CsfJg96TI47qQc0I3WCpIkogDOdcvQkI78/BUzEgXlSnv1pEV0U3NygTtuTN1LAqT8YB
         GLGLhERCe48PhPYE5VpMKfd9/ikJt3wygGV5E66Imv2LGmzGf3md7RYW2JPLDaZkrw7g
         WEYDBhoLn+DhbvoolJV3g4knppUSWJS2LC3BWbm/RAm4wtYh28wWqhWVlafl0K4eJz6b
         1kegVywDcxJD0Az9dRsDMgVOMqxiR9htog2X9jsRdVPVMXAHBzQKGUJ0RKFtNSN8I2Tc
         RTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760784678; x=1761389478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN99AxvttZDth2AwLZ86dPMNpsRX4UzdoMclz90QAQM=;
        b=ffixZUaTitpfOC5Lg/kcFMaKYAjeNZLDpib645YKVM022mE23zmmKHWNsP1+A0BwMF
         C9PN1ZlPPZt+CjstjMMT1nlli1+pp01bpShaBZhcJZndVL3tHABM8McaIKWMDE/MDt+z
         LwawGa5s3oF3qxv/wu3QJxUr9VWq4cQHmFm3fjY+FMQ/QyoBH8CGvhDKPDraeioNMWH1
         iiQ6IzheTWVnn1Wd9XO34bvrnA0npLCBPpwea3mDOfhJ2/b/gmt11lk48sMcawHl7w9i
         PxxuYND9D2YqXCYUnP4Eo9IQ5xqeB8I/8hex2y7Mrmkmbq70nCHicQQCcP1I9lgDiehB
         k31Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtrD0NY4nhrQku+98B255llWe6qm4Nrh1lSrCLJHCqt/GFiGji1YhuygnE7N3m8yFVIOmyvRegreKNXgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaEeZEZXqoPBiy9k9pGqxKX7G+gZ9OpcfsZrAkysEWUEcuWkT
	7SJW+O4vn3Fmr12GI6t/B+Maq0yqqtAmSwYL446YjAUKZ9hZ+RUeQoR3q7iVa8L32PYZ9IsI0oA
	jXZRd0zDstqAISj1Ci44hIQqf+PDskaI3gQ/DHHlwaw==
X-Gm-Gg: ASbGncsZdsJy02pTxGCeAK8jcEcecsxez+r9t14wzAftgKjI71wxx0ctv2uB0O1J5MU
	rG7wrYv5ItIGU0C7gMy3Z9AjU2mP3YLCT1TWS7RjCzpZK3uUsvxnxLbGgDaTBCxbADZ7J0AaHEd
	bJyI0Jyj5SvN6vhWz2iaEdxvut2WhHueljTWXzZxbFWEfWTb1iN1+ZWAqoOG2u0mYUKVSPiSUzz
	sP0N0+W2qf3hHbzEHGPxBlZkcqdKuu33ENUjzR3N3ad1tkIcLmW4TXDU5d9lazBqKQx3x3M7mNw
	LNQe/v6OAz4fShpMZXAkcoWTgfXdpF39CWEWacvAJpNPPone
X-Google-Smtp-Source: AGHT+IFkT3kKTmUh/7GkVZYVCfgDYzDpIIGMg58YcOd/EEbkE748tHWMyqEw12UQqPbUB2qFf0oLHod08OnPQNgKv0s=
X-Received: by 2002:a17:902:f78f:b0:290:af0e:1183 with SMTP id
 d9443c01a7336-290cb65c5e7mr64027955ad.51.1760784678388; Sat, 18 Oct 2025
 03:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145129.000176255@linuxfoundation.org>
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 18 Oct 2025 16:21:06 +0530
X-Gm-Features: AS18NWC_DJVK9ZCYaqrdWG1cdi0bKv8YI7U-NQXI-lxxQ95eDn7YGRPBlXVGB0A
Message-ID: <CA+G9fYvaa6UHXqbCGTrn8ocJ842gH0VQyEKcJ-C8gXOPtm2NNA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, linux-s390@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 20:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 builds failed on stable-rc 6.1.157-rc1 with gcc-14, gcc-8
and clang-21 due to following build warnings / errors.

This reported regressions also found on
  - 5.15.195-rc1
  - 6.6.113-rc1

### Build error:
drivers/s390/cio/device.c: In function 'purge_fn':
drivers/s390/cio/device.c:1316:23: error: passing argument 1 of
'spin_lock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1316 |         spin_lock_irq(&sch->lock);
      |                       ^~~~~~~~~~
      |                       |
      |                       spinlock_t ** {aka struct spinlock **}
In file included from drivers/s390/cio/device.c:16:
include/linux/spinlock.h:374:55: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  374 | static __always_inline void spin_lock_irq(spinlock_t *lock)
      |                                           ~~~~~~~~~~~~^~~~
drivers/s390/cio/device.c:1339:25: error: passing argument 1 of
'spin_unlock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1339 |         spin_unlock_irq(&sch->lock);
      |                         ^~~~~~~~~~
      |                         |
      |                         spinlock_t ** {aka struct spinlock **}
include/linux/spinlock.h:399:57: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  399 | static __always_inline void spin_unlock_irq(spinlock_t *lock)
      |                                             ~~~~~~~~~~~~^~~~
make[4]: *** [scripts/Makefile.build:250: drivers/s390/cio/device.o] Error 1

### Suspecting patches
Suspecting commit,

  s390/cio: Update purge function to unregister the unused subchannels
  [ Upstream commit 9daa5a8795865f9a3c93d8d1066785b07ded6073 ]

Build regressions: 6.1.157-rc1: s390/cio/device.c:1316:23: error:
passing argument 1 of 'spin_lock_irq' from incompatible pointer type

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEro5epq7T4CfI69lXe4c1ZJ/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.1.y/v6.1.156-169-gec44a71e7948/log-parser-build-kernel/gcc-compiler-_drivers_s_cio_device_c_error_passing_argument_of_spin_lock_irq_from_incompatible_pointer_type/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34COEro5epq7T4CfI69lXe4c1ZJ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEro5epq7T4CfI69lXe4c1ZJ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEro5epq7T4CfI69lXe4c1ZJ/config

### Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig

## Build
* kernel: 6.1.157-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ec44a71e7948d92858fec8b3fbefb7638144f586
* git describe: v6.1.156-169-gec44a71e7948
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.156-169-gec44a71e7948

## Test Regressions (compared to v6.1.155-197-gb9f52894e35f)
* s390, build
  - clang-21-allnoconfig
  - clang-21-defconfig
  - clang-21-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-14-allmodconfig
  - gcc-14-allnoconfig
  - gcc-14-defconfig
  - gcc-14-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

## Metric Regressions (compared to v6.1.155-197-gb9f52894e35f)

## Test Fixes (compared to v6.1.155-197-gb9f52894e35f)

## Metric Fixes (compared to v6.1.155-197-gb9f52894e35f)

## Test result summary
total: 87986, pass: 72984, fail: 2700, skip: 12061, xfail: 241

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 1 failed
* arm64: 41 total, 38 passed, 3 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 14 total, 0 passed, 14 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 32 passed, 1 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

