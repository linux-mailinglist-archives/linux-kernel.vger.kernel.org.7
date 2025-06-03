Return-Path: <linux-kernel+bounces-671502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148DACC263
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91BB1891B02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E151E4A4;
	Tue,  3 Jun 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6TA3LZR"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3A4F5E0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940506; cv=none; b=bPmDlUvdowUm4z65zMgkkb8JTUpE6A+5lyx9YOiZ5GJ1Kh9Lz2DZ0eK2LcQFuSStRU3P4SyYNK3sB3rV9kGQ/7TBemeGZvvy0aWCxuUYIPa6P3XRTdjOxU11gLAQhvaHlqj+5a2mXaZf4v6XWv52clnZL9MveACfwnzGBqYfQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940506; c=relaxed/simple;
	bh=C/YOcTQcT8iXErasgO8aAKWARSmqEdWBUL2o5+47OUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra6u2rkIm81XLkVzIxLZ1OqIhXK5KbAww8MF7NGk264nVuzOmgQoCrgy4LNDP/QBNCq7FGFQGiCknL1Ag3N0ayocZkuKNPoiU5/TQrCMJMd46fEa0DEatEB3ngdP8CjgYHqt7h2CBglpOPkrdDeyF5qkOkgd9mEwpJTAg1EsCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6TA3LZR; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52f22008b6aso1810322e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748940503; x=1749545303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgcPt9DDVJDqrpwLwisgOuspBXKCsmeDakBhXGkOjfk=;
        b=q6TA3LZRR+YwLvRHBjJFuG5S52pe7xmk+RLZ8yooLVyRZPSBckHzqIK1M2BLZWcTcP
         LOcaDmmnLVVOLVNnwHlyThsFx+1pCR5fQVG98Xjxrh4ZoxDVcRpv1aZXHdqAROn5iy/I
         ghGGVb71s3BtO5SRbHoGXrGiZZ1ChmLeKeBIKVRTLM1vuYTRc5HWM8jbhz3Gig4yWHaV
         nCa4lHyPw4Ppf+fvp5FAG8GrJxI8slj/CXcnVANUQgtMaWLVd8lyVE2K8W1iUACXDK/m
         jk06I5v4Mb4dPT8jl0qDAxXnmZbX5VeysNqB1ScukJgaalhQWdqiFr01V3zbjEtiDhSf
         +T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940503; x=1749545303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgcPt9DDVJDqrpwLwisgOuspBXKCsmeDakBhXGkOjfk=;
        b=fQVnwYyGe2zWFBoNfh6TRI9RPdoS09HeFEJKKb+SYRlylrhSChYIm40a2X2ufU+SWq
         V7m05M1mMRqwbUf5jwJh33BrL64meafmRzvUKZ1sb7/w920KiYtzMeOVJwhVkGiqjhCC
         5+LYDJS5goG0mUtrHJYSNY3wROuOK2BhP7adQ89XRZ6gEQK2WK9pGY+6Iu4oPoBinC/S
         fttASEPtrt9VZrUqFD3SQ6cp3rPez1M2GCkcdST2vKVYPvGuAQG8J+04bRBujUmoQ3mH
         K5cJ38IsH7e2iKvFgtcigue1rp4jUW6TAKSQbi7KSXT7LjGaCa8riPaMMGKbIMmc20iu
         yEew==
X-Forwarded-Encrypted: i=1; AJvYcCUBqZ8N9BNn6o0cw4bn+baTwYzJwGO3PMxfpoBMZhTzwoVg2YTd/mUDasRDa+suSl9r9Qu9yYtNzTIA6Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRf3UWhJL8g46p1GOrBzcw0UZ3GIkU3pNnHfNTCelsSNEJMWnp
	EpBzUAPuhHpsiBIUhc5qRTcKFXGCNI4E8levAwvwXhzEpSR+OrLrThDjXnlr0dByQxP4ONQ5B0B
	GIHeYuMft4fv5NcqOwFA6C0ltSKHsah53ttjdCBMTvw==
X-Gm-Gg: ASbGnct6WWhj/Lhu7A/QeHRk6SYWv1gLw5K6SOG55HrWvYa7C+5QSVOz0QudHj+DNMY
	rBoPLgkcRfNpU0Bb0QwAEgkTQlTjf9H6PHRsQse3tbfGSzfPKmQiicuWKQ7qA6qAtGIkBnWK/OO
	jPLOYZKEmgTMzTndk/+TWgsQBcE+tcW2d9XK3eT87QjVBh4DRNWdrE
X-Google-Smtp-Source: AGHT+IGcy7MiKCdJJEgjaUOaa2YDu3Rl+RXlV7VuqflL5eYw/3JIpEJZGL716aoEloMStawtjl2SarEYf42jKrj/eWs=
X-Received: by 2002:a05:6122:2a0a:b0:530:727f:a7b7 with SMTP id
 71dfb90a1353d-530937f61abmr8407156e0c.11.1748940503136; Tue, 03 Jun 2025
 01:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134340.906731340@linuxfoundation.org>
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 14:18:10 +0530
X-Gm-Features: AX0GCFsvZJC8sit5FzkiBjOLsSukE5Gtx-9vtfsjTxtgIW4I3KYO2mKGPNJcyxQ
Message-ID: <CA+G9fYs+4VsFrE+t04gqujBt75vOUQz8HwGPcKh-xKHqQ2zu-A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
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

On Mon, 2 Jun 2025 at 19:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.93 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.93-rc1.gz
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
* kernel: 6.6.93-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 58cbe685685b1c9c144356315c7c08561e004d4e
* git describe: v6.6.92-445-g58cbe685685b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
2-445-g58cbe685685b

## Test Regressions (compared to v6.6.91-118-g18952a1fc4ac)

## Metric Regressions (compared to v6.6.91-118-g18952a1fc4ac)

## Test Fixes (compared to v6.6.91-118-g18952a1fc4ac)

## Metric Fixes (compared to v6.6.91-118-g18952a1fc4ac)

## Test result summary
total: 281357, pass: 258682, fail: 5380, skip: 16800, xfail: 495

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 20 passed, 3 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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
* ltp-ipc
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

