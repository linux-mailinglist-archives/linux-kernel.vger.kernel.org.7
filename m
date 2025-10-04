Return-Path: <linux-kernel+bounces-842032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C4BB8D01
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD304E4C60
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912DC257836;
	Sat,  4 Oct 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhQde7qv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2C1E51E1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578806; cv=none; b=j1RwFrIKzb0bhCBBMj9R89H6EPrdPvtwPIFBowXj4ylR9jIwtYmsF0uUtlA0/4aLqU63QgdVnIilx9FwcOYhONyC2Wfi8MF3d7wYfMM0dN+ddmK5RHzvjd3qlDKUTCowUVLU2PhAFFkOE4HQjFNHXCbiJqjnAGz5ugcROhgStrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578806; c=relaxed/simple;
	bh=B9tTfk1UJrqtbI8dqi8zA4lNiTZ56E1jxWKUD90jNiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffCTaG2RKmLde4wOotBXfbHjoM3ayaa+VWbompVMxp00kjOeLm9HApy+PUXoYb3IZ282kd8LHLOL32Cxpd2apwch+EmQBdUwAupan6UkeWfjozu2fxHp/yZC7io5Fc06khxx0M8z39gvJ6O62/wf8w2jH4k3w9Vt67BrFrcJblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhQde7qv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso34699615ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759578804; x=1760183604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7RU5qyXjwxmGdqEjwRKr3R2CKcBmBG4HiILh8Lpt7c=;
        b=XhQde7qvbQ7wt+NmscWLt7qmM+GuJq4aCEOx/f363KlWY5UZpCamyVK4ZRRV5un8vm
         PYt5OtC8FprGWRg9qmi+cL5StXGlYa5n8pCSUvdvWP7SrP13NmNePpJa+o0IW99sxNRx
         ZJAOpyRd0/0vRqaL0HRR1RMR5Z3gq+XZs+a9FdYTu3xNE/xSL6BGCm+sCdDl604a5ZhW
         q8wfp3oO/c8DNTi0Z8AaiQ2c1Tge23hZHSW4SpMwrh83jN8G5AyQz++Qe164PWMd+9CV
         e+4q+BR66GmcO4RBE3Uw1NyhF9b9q9l9qzvhseEtyAkU4MKGxVCy0w0rXqs8Hj0gnYyF
         b97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578804; x=1760183604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7RU5qyXjwxmGdqEjwRKr3R2CKcBmBG4HiILh8Lpt7c=;
        b=Sh4PRHsd6MzWR7vXY8Yaag2TgmOu7vCQhzcm9sCwRhcZIGYfy1zLr/qgOMp/l8f/3y
         BBfaocunjRCmPw3FY4S75ys8D0yuuVErZZS8zBzespsUPaC3tD9RsEl33y3layZeSQX7
         psfJAfbWdUJvYIO2yewqAwiC5e/kIDuoUOZueIa8Fo0xc8CFV72UdhHMqPUmGHY3jA1Q
         GkDtg+dWk0qILhzLaEk8n31otLDWI5NphlIRFXv3xWusFssQkcpX2NNk6MeReKR9zmDF
         zLDCG23ghpy7CtKauUcYeAMiMHL+fdyTeKo5+r78WpYpx9EgFLRAOIAo+k5/tvisH9gK
         AGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4eHbTg9eqTJM/RB8iuXy9zaa1AcvLumnHsD71dlvv1Gxr2P5AUHSRPdtV9E4Xg2GP07+KmLp2rCIz/u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDODd5OFiXhkqteQSLdsF2gPjRezJhSX5wdPl7dkVROQRk5nwj
	+M+R0qIes/eB3at2q1JhDJawhHRve5g1BxF1+luoDXCgr3PLGN6eHn+JJpUzGWZm5SegeRnOgRo
	nLhNypwOA+K7jAcMXuvTOZ6mor5O0sucRUO41fGX5ow==
X-Gm-Gg: ASbGncs9J7uQYwlXjzqhRcyZLW1bxE5YWPKHj6z/rbxdkE3aN6f8h8Qf+PS4WZI2RIc
	5RBj8Efk2Gh4o6YB7wFJ+I7UvFrZqDSZSY5JvtYfhIg/WDFvSehug6crzIMnvt1AAjImCNuLPLH
	dEWux+pA4RO67xtm0hzLe/LrfsNwCwzqHwmWiIxPHxQ3mwg1Fjibc2nzFgGuNkikawatByflwhJ
	265SFf5zko29/cQxTlKApEm85XbHpw2IUCefWcL1utf+yMFKKnWPyFAqXQhFDrbbcjMzzscHdFE
	T/TStKs948/Vs1fa81NsroXm
X-Google-Smtp-Source: AGHT+IFZuYOS8pBjW/z3NN/ZGg/Iib6xrjJwYtDd9JtCupYMpqrEGIPYbDOeRWKCmqJAPlb0kBXf3I+C7fQhjl9tF5M=
X-Received: by 2002:a17:902:e549:b0:269:8d16:42d1 with SMTP id
 d9443c01a7336-28e9a65c0demr75903205ad.50.1759578804572; Sat, 04 Oct 2025
 04:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160331.487313415@linuxfoundation.org>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:23:12 +0530
X-Gm-Features: AS18NWCKTF8Nqz9apGR7FQ34u8mKsa5_l7wIj6tAIQFmJTUC-xrCwAENy2HEogU
Message-ID: <CA+G9fYvvXA5mkkZp5T1UNU49VovA0LJa0hdGgt3sKL3hwMfNqg@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Oct 2025 at 21:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.110-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c901132c8088afd41cf7eaa3298b62c8cc5874b6
* git describe: v6.6.109-8-gc901132c8088
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
09-8-gc901132c8088

## Test Regressions (compared to v6.6.108-92-g583cf4b0ea80)

## Metric Regressions (compared to v6.6.108-92-g583cf4b0ea80)

## Test Fixes (compared to v6.6.108-92-g583cf4b0ea80)

## Metric Fixes (compared to v6.6.108-92-g583cf4b0ea80)

## Test result summary
total: 121371, pass: 103471, fail: 4150, skip: 13306, xfail: 444

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
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

