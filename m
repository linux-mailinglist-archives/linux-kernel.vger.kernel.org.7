Return-Path: <linux-kernel+bounces-788021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9798B37EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7571D1BA2F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCFC2E9EDF;
	Wed, 27 Aug 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNc8qgNh"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736B2F532C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287041; cv=none; b=Q91OunaT3pq9YBAM2n/SSVXDZd3zKdg82fW18uHp7MeY5UKcsDzwP49eJfnnSrJU4wo0AtXYd668BeB6moyy2O7ecmlOnYjHF4HlPKHFZsU2b+ZT4AgrHLLrcH21ae1sn1LyYmYVBmBqcPOVktpJiPS8etR1rfZKO+nFWWbtN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287041; c=relaxed/simple;
	bh=tdG6lwDqbuZN/AVud6hb++JrEIXzuwXpSeTEcSPRwQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0Xv8FEtp2muOjAY8SqoQkLzoauOQLTB9/SwkyeZ8TROVA0ed95rIibP0GRGeGAgFjkmovLIDFHdoAS3GIeuBhHqXNwV4q12Z2G5nA2ZUIfEmD444jscGq1m4p4xBxGJtKY9YiR5wIxXTo90ZThmyxzLlghPXRm2JUkWist8JPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNc8qgNh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70d9b07e163so13160816d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756287038; x=1756891838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p00Dt79OtqQoegFZ5bdUUNG94Edo0Rx/ZyhTvrQlI1M=;
        b=vNc8qgNhD3G17SWb6ppCo40LvpvIPgsxBKCpGERI9U/aee3dLvn6v7YxQqYj7VKNHg
         Rf0UX9/8KreWrRm6CmHaoAdTMKuuyx2eT54ZUcRakjgeEP/pYIFtQiZOZGNEOo/IrjLP
         kHvdnImhT1lOoPfhY0UBcXXGcF9R9Mf0dLcCaDHkmSpp2m4LeRUjnvKLs8jDG2XpQ4em
         XyNaSmSHOnaT+H8CXL2jxp8VLIOlHt1ycRkz5gPA9WLNX3SxZ7MhvYfGfIvWUl5fVpyR
         afDG7jlh/NSSwDupy+IF6HtslR+TBsIIUcCgszt7QckXR/AvAbcKUC9bBFWMB91+kE/g
         K4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287038; x=1756891838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p00Dt79OtqQoegFZ5bdUUNG94Edo0Rx/ZyhTvrQlI1M=;
        b=TYe87PddpVt79Ju7W5ZeA7P6zZUqc0qIzO2aEdPjkBMNkwsqZxpWWDKJHAlSyX+2NF
         gEKd6eIc22V/eEcIwRa9cnMVkGFADa03SAcGhpdXw4diu9cLJ4Rir/YjjZs0dTrM63BZ
         +sAE3+jgPKgCXQOYf3csbBXRvVOMKKA7OTEbxl4KEoefAO3pNKtwhCCwwJGeiBsgd9Fb
         czdrJS70LzVKsfCjCP/iLuR+uSBowEZP9QFMAEK+AZXgz0EMPOOb1aVI8UsIPT8X0PA8
         RUpFX1j2o5WrFMANjefsEZASbNPxaEO21l9pVHxmag9cdetn3kNVDHBttWdLTe+h4rEV
         CGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUXr7jUru3Sx3kcMr3c+FCkEacbQfesofD1rpBKu2CjuN0FzySeD28UFElMpc399pfKJHBMEAndr21C3K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2ro9BuwmdPqgekG7ANOx2SFGhX6M0/MdjMaBRja6QF/REG+a
	4he+UCE+7xJ9ImcHWgf5TPoq6VOTtO39o96s1xEyhzWoyjkxfO0UIY1yxs3L2sAOc2i7yzqFDMd
	2bVVcEum3qyuH/UXJAYXC0h+wDgRpvyEpECLQM9urZg==
X-Gm-Gg: ASbGnctKkXOmxQ+DlRIlFJaK8Lmg0bpsHM/VTtYV5JQHCLGjhuaSOc32L/kjR2riIbj
	Bx5mArjrTzDHNRO22MBZknJWDvmHoAF8SR2X+5AYqQPNGX0znQxu4QiynoxccJxkjDUrdtiKsxw
	ZmSVhg4ISDmXAzII6/Kw4/Tg+qNQjMeetr5/0pevUdhXKILGefGCrF6D5k9kBaSAlxVacJAt6bm
	oLD34SJ6JNenAy4
X-Google-Smtp-Source: AGHT+IEwdIexP0HA2vYtTuFG+cmWr0/asWhdvS54qUEB5cX1KpPDhRdmpS66B3nEu6uVhib5L2CvrhCMss7o7yDziw4=
X-Received: by 2002:a05:6214:3003:b0:70d:c054:9320 with SMTP id
 6a1803df08f44-70dc054964bmr76720416d6.3.1756287038013; Wed, 27 Aug 2025
 02:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110915.169062587@linuxfoundation.org>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:30:26 +0200
X-Gm-Features: Ac12FXxJh0tPtMslPn4Ikgd1vLpYMc-s1M_Anx8mniQakPdgUznCnVh2ZgFl6zs
Message-ID: <CADYN=9JmvSQOxp7TtLj1UgrYQzb2k8tLz_V2sN7OS4wNLVG_Qg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 6.12.44-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: c7e1bbb3520545aac86b8bcdb924cd3a7d200bc8
* git describe: v6.12.43-323-gc7e1bbb35205
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.43-323-gc7e1bbb35205

## Test Regressions (compared to v6.12.41-808-ge80021fb2304)

## Metric Regressions (compared to v6.12.41-808-ge80021fb2304)

## Test Fixes (compared to v6.12.41-808-ge80021fb2304)

## Metric Fixes (compared to v6.12.41-808-ge80021fb2304)

## Test result summary
total: 333492, pass: 308486, fail: 6580, skip: 17877, xfail: 549

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* modules
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

