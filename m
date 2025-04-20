Return-Path: <linux-kernel+bounces-611871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF5A9474E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF517229D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2EC1E2602;
	Sun, 20 Apr 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHXQPKUU"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52762AD14
	for <linux-kernel@vger.kernel.org>; Sun, 20 Apr 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139744; cv=none; b=dmkaALvxIfbXw0obKvs/3jOHGhiIP7M0QemZbIrgQM+k/eezAdpQvgandaAvSjJ3iiSqV7FgfIBTgDXEfErXcGtxUTHbptbHPoD0zqusgsPYcSMLN5MtSZpOOBmFStkqZ2iNNY9l3fXik5ul6nJpy88bvQVh4Al5CEJ44gCmrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139744; c=relaxed/simple;
	bh=Vm1SneeIv1DShncqWrSbn2uhWCgJ8xrqSoeq/3C8wiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBoG+8gOc949onCuc+panuZyTCQ2KaC23xnZMM4FTKoSMwoSlRf9MOvl6zm9o+7ToG3rkgEW3smR5M7MGk+UKC/hhw2ZxM5sRDuSmR4tMjzkxpIZxf3BmZ0TZgqJTf5lFasjSJP8T91lmp2qgkTVOjvRllIIuIo1AEUZ2D9XAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZHXQPKUU; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523dc190f95so1255063e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Apr 2025 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745139742; x=1745744542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQC5AcabxKeiEVKbwfnNZC064is3VX268OdmNT2hLSs=;
        b=ZHXQPKUU+iZYXsgduGBZBf7gB6pqE2SM/piYtVg3aLhoxSULSS8Uo+IQtS6ivhjfRA
         pZmIwiDgfSYKNp41/UIszbQv2yCsq4gZypgxmvoxYzY5R8GBE3RApx/8Lo9ZbXgqB6mI
         iPuglqKMS3uJvKx4Rz73zK0EZOlzeWqIirHul6MabnkXtNZFnnywqEx9UOZ7/NoL93B0
         a8bAXy1HvdCBBxsuchsoje5rs6UtOrpLqBXqql0CEpBhv/3uTxSRn7r0XtMO0pi5dazp
         ecD/8Jzh5G09p5OTEczMPaU5Uulo5O/VoP53rt7NFQYrbFaSF8Fb0qr9+BWD66MalJ8Z
         Y3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745139742; x=1745744542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQC5AcabxKeiEVKbwfnNZC064is3VX268OdmNT2hLSs=;
        b=ljg4jxy9sd0beudPKDpmBGJkpFd5PhWSH+NdBTnvgGPvZymAKmUCbwzsGHi4hVPCKU
         MS/rX/GZjoLbYAtcCUckzNBERtwo9dWHtCSNEuCOenyccof0uUjYNB4zZl+WIMSH4EGz
         z00ggD5+v60y+oY8wY03ztkYueINp2wID64ToYCoIq+RQBIY79+30Ub6N1xPaf6IZNGL
         nIj8TEJKrkSbYOJpDH0k0pN331bLIaiTcdiOKifgaCo2XWrSb8/5H8t76XNhYiyBhBuC
         bhvFYn7NGve+9aERIp1VcmfXjujZYmZl5rb8sjo/9iUJA5X82nDwkjXEB1089Xpchwep
         nIAw==
X-Forwarded-Encrypted: i=1; AJvYcCXEPEy0Bfshj3sveddL7dr/7Oi4aZDPvKKOD2V4QdZ+8DaJxASKp+ReBxEJvq8sxOR55JIoRxA1TrFTuHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZTm1bEGOReEt32MRiGL6YLmKBiU6bSi2Cq25hpK8mXhK8hNI
	Sp6iZdoc46BY0itWienQLwzWaUFAdjEhHmNmet7cfF1pweAxD3h2f2A+I/I6szMR97/vQT0TYDp
	CRglroH158hLB+jsHhToEPmPO66F9HXgIdUj+jA==
X-Gm-Gg: ASbGncsoFgCm9ANcSHPAtSHLPDsSaBIGz7xT8ziYr2X/zj4+48Tw+de5Zd5MMOjqMBp
	nujxmU7SVTbJ99rjUEt1EzIokCokkgvmhZ0oAXguVeJ0iLi4Q2c6YFxu1Xj55uQz34UKXAJxodA
	xbL+JnVDyQ/8Z1UE7UJXXE5XF9LLmTQEjWQwBgJri+c5BASOGkhLocD1E=
X-Google-Smtp-Source: AGHT+IHntgRziFxoHZPrkez9WKkiU2A6UmellXKi/BMY23c6kkHgThZDWZ17Fbw56FQH+1A82QuWxaV+i3kn3UGw9A0=
X-Received: by 2002:a05:6122:1ace:b0:528:4f4b:f0c0 with SMTP id
 71dfb90a1353d-5292540fdabmr5837027e0c.5.1745139741697; Sun, 20 Apr 2025
 02:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110423.925580973@linuxfoundation.org>
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Apr 2025 14:32:10 +0530
X-Gm-Features: ATxdqUHH6FtR7IqNk-DfKZGccRuiyir-02-_NXyIQhhu3k0XqwhRZWMjkZaV1eE
Message-ID: <CA+G9fYtOeB3A_Ebz9rSZ_Z=DaoJG6DAUa6XK9v_k7vqvRqEzMA@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 16:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 dragonboard 410c boot failed with lkftconfig
on the stable rc 6.14.3-rc1 and  6.14.3-rc2.

The bisection is in progress and keep you posted.

Boot regression: arm64 dragonboard 410c WARNING regulator core.c regulator_put

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Lore link:
 - https://lore.kernel.org/stable/CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com/

## Build
* kernel: 6.14.3-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: fc253f3d7070db50a3eaa92f79aacf194f82a6fe
* git describe: v6.14.2-448-gfc253f3d7070
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-448-gfc253f3d7070

## Test Regressions (compared to v6.14.1-727-g2cc38486a844)
* dragonboard-410c, boot
  - clang-20-lkftconfig

## Metric Regressions (compared to v6.14.1-727-g2cc38486a844)

## Test Fixes (compared to v6.14.1-727-g2cc38486a844)

## Metric Fixes (compared to v6.14.1-727-g2cc38486a844)

## Test result summary
total: 131061, pass: 109303, fail: 3209, skip: 18120, xfail: 429

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
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
* ltp-ipc
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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

