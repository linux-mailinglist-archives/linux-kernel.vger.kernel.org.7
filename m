Return-Path: <linux-kernel+bounces-859134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F04BECD99
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA0E234FD03
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD332F9DAD;
	Sat, 18 Oct 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeTFPecj"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203842F90D5
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784165; cv=none; b=FIVB/W6rFkSMf1LHTNI8pn0fgIaNLJPceDN8otZxZUTjIdmS0ufhXn6cXPuNdn3qSkYTUBJJKrIT4Q7FSh8QkLPo2ElSYIrfiPsAJgnpnJCwEUMjFy6fH1rBpHPiM97x5RXxgMxmadaMJ1oJhLNZ/TOS6HJXwBJ1S4MHIpE04Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784165; c=relaxed/simple;
	bh=eujZEm26QNomQ0uZsPlsJhjB6dXoxCoQV/63rJ+xGzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbMtI9C4i0bw8760CkfNXbe7lZ8Lr51/oRLlpsViDb9eDZvSpNzKnkqcd9x7IPAen3tP1GA0l76ne31F5tqv/dPyssIs6+PNFX+Dt00s4bFrSJXi3XTODUZk4gWykrW/f72oFDsj26JmTR59PGnJ90z4CQOwIutW4QKHCY/Vrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeTFPecj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so2530823a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760784163; x=1761388963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKtCJR7APuqaYl6bh3Ms7NkEOrtscFZrf4VBLleXnTg=;
        b=GeTFPecjlx/di6r08ytrMbzemmrjXaCZ03OFRAlWUTSPrS9foXp3N/iY70c7MZwg+v
         wSlPcnsQyUtlnjjDwKmupJpRmwZ8D0pIrV2/y/UWHYbnKum8YWo8/j4jPJVNhSQ9f4wE
         /5cywRxR7C4tmxfK6OrBtwR/XYg3XXjqzknUqCCc+03kDK8V933C0m6wvAmJwZGgDTa4
         P/knCM2WLsegD4uZvKuBpjNHIZYwkS7HKZtFadPPp5uSY5LG+nvGKDWLliDRm5yt6pT7
         /dBZT0tTEabP51SxntHGwIVZvdeuAqWvEDOFlleahgc9i/dyjeIVULEKhgdai8bfFFtf
         NLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760784163; x=1761388963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKtCJR7APuqaYl6bh3Ms7NkEOrtscFZrf4VBLleXnTg=;
        b=hsNsun0rGcNc89u5yBqEy3Wu6HUHe6UqhtscUU1wXb7FaAWa8LkxQMcFfz6wYUN+zF
         80RGLPw1Bhysjz722iPGM/KPj94bnY+SKpuvSUfgT8IhGov3b8JLIuu/yDcdu4JHWpTt
         0EdjaaCSrgcmwT49ii6o4SzV/VRITKK3SiahTdPwGGKqF+fgMIgtjwlZ7BxlruUYUQQi
         yT0r6EzjdII5gjlFSIevo0mpN8uOUyskN6h6Q76gdCFd7Bs4fHTNy6rYRPBiE9+MiZTo
         VvKl9RdDHuZyqinkeKYzCyL444nf7e0Nx2QsoPHDyf5xzQEYNhQ88mInidL8360u7jr4
         NWpw==
X-Forwarded-Encrypted: i=1; AJvYcCULEyoeXR5fqAoOL5/xihcbAogxzGk0WA/Uhj+69bFi9AxKo5lhDWEdNBuXwTwZI+vDRIFdvgLNN+i4DPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWT2jchYXLyym+zMcHTon2ZscGTICDG9hOGMFh0xHXgUu4f0cJ
	gwu9M9In9RZ3RDikfSXHNAbbA6Arx0TO8e0Oa9d2iMNRFcV0r3aknPBV3uMUJEqotzdBagYAF1w
	o8P9SmgyOpIK5ulE+lSp9rFKs3/eiOaPbEFG0ni6Phg==
X-Gm-Gg: ASbGncsDVnO1CAuFKtKw/MTQey778divPlDZMjqY5Rm1nVrsgeCRSUoPftTkrpnbhvb
	XgiTTuyCDyODLy64XvO/kJqdo0rz3DTfmfHK7RwyNDnXqDTdoeaob75X1NV6eAI1VayIkWTjZQq
	10lMQnfwNnzwmzq+OvUXm6lIqGG9tHgeCHmGM+g8aHtcH/asS4XauzJWWbySAVTfLvNddBaSdQQ
	UTwE9aJXTIBp2FLe5pRGKJYBMi8vx9ufkBpZlJex8em1HLQpfddIaQZc2wjo5aQ8fzOj0oso4fM
	75cadbrPSt77Z6MeIL47FH4gKoBDrL6FJc6F2jlBwK8aEIHrXvLQJHHGlkw=
X-Google-Smtp-Source: AGHT+IG4l8FY9Rly63iVwkF4ND9jy7VhkbE+KZiG23qYJct2RnQ0jxSB1oZo571w+5Hbj98wxOCUhpezndZy+8OOhOc=
X-Received: by 2002:a17:903:2309:b0:262:9c4:5470 with SMTP id
 d9443c01a7336-290caf85241mr87472235ad.28.1760784163263; Sat, 18 Oct 2025
 03:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145134.710337454@linuxfoundation.org>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 18 Oct 2025 16:12:31 +0530
X-Gm-Features: AS18NWC1tQ1llFX7LULrRrpUFjdOIk2jZcXVw-IyC4sFHqzmRTWSi7dadzfwsO0
Message-ID: <CA+G9fYvQMwxB2LHpZPkQ7nUDkVw6LbMnpRif=tq_A0K69aiGVA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, linux-s390@vger.kernel.org, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The S390 builds failed on stable-rc 6.6.113-rc1 with gcc-14, gcc-8
and clang-21 due to following build warnings / errors.

This reported regressions also found on
  - 5.15.195-rc1
  - 6.1.157-rc1

### Build error:
drivers/s390/cio/device.c: In function 'purge_fn':
drivers/s390/cio/device.c:1325:23: error: passing argument 1 of
'spin_lock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1325 |         spin_lock_irq(&sch->lock);
      |                       ^~~~~~~~~~
      |                       |
      |                       spinlock_t ** {aka struct spinlock **}
In file included from drivers/s390/cio/device.c:16:
include/linux/spinlock.h:374:55: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  374 | static __always_inline void spin_lock_irq(spinlock_t *lock)
      |                                           ~~~~~~~~~~~~^~~~
drivers/s390/cio/device.c:1348:25: error: passing argument 1 of
'spin_unlock_irq' from incompatible pointer type
[-Wincompatible-pointer-types]
 1348 |         spin_unlock_irq(&sch->lock);
      |                         ^~~~~~~~~~
      |                         |
      |                         spinlock_t ** {aka struct spinlock **}
include/linux/spinlock.h:399:57: note: expected 'spinlock_t *' {aka
'struct spinlock *'} but argument is of type 'spinlock_t **' {aka
'struct spinlock **'}
  399 | static __always_inline void spin_unlock_irq(spinlock_t *lock)
      |                                             ~~~~~~~~~~~~^~~~
make[6]: *** [scripts/Makefile.build:243: drivers/s390/cio/device.o] Error 1

### Suspecting patches
Suspecting commit,

  s390/cio: Update purge function to unregister the unused subchannels
  [ Upstream commit 9daa5a8795865f9a3c93d8d1066785b07ded6073 ]

Build regressions: 6.6.113-rc1: s390/cio/device.c:1325:23: error:
passing argument 1 of 'spin_lock_irq' from incompatible pointer type

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.6.y/v6.6.112-202-gef9fd03595ef/log-parser-build-kernel/gcc-compiler-_drivers_s_cio_device_c_error_passing_argument_of_spin_lock_irq_from_incompatible_pointer_type/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34COEeJlCgnu1mnSirBqlyQrqiL/config

### Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig


## Build
* kernel: 6.6.113-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ef9fd03595ef20d45159b484886170cccb77e879
* git describe: v6.6.112-202-gef9fd03595ef
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.112-202-gef9fd03595ef

## Test Regressions (compared to v6.6.111-197-g07c1c4215e92)
* s390, build
  - clang-21-allnoconfig
  - clang-21-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-tinyconfig
  - gcc-14-allnoconfig
  - gcc-14-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-tinyconfig

## Metric Regressions (compared to v6.6.111-197-g07c1c4215e92)

## Test Fixes (compared to v6.6.111-197-g07c1c4215e92)

## Metric Fixes (compared to v6.6.111-197-g07c1c4215e92)

## Test result summary
total: 120291, pass: 100081, fail: 4386, skip: 15390, xfail: 434

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 0 passed, 14 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
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

