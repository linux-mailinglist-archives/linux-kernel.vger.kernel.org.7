Return-Path: <linux-kernel+bounces-881202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEEC27B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B323B1F08
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0692C2343;
	Sat,  1 Nov 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZctigsb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C32BE7C2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990691; cv=none; b=IndnuKLHR0fHh1r2v+TbIjwlCfdbFw/BMJMnnANvzKb6GXjfX/T7ZbTxqsDzChrggCGgqJXkEBUKBnt47BRjod5GJP4WPEM5nhTOrn6FyDTnY/rF4IJdOO/OUN47ilQ7LMOEcCMg3h0E7/ZWweRM/TjM3Q7dqtdy2qDB5nYAKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990691; c=relaxed/simple;
	bh=cxeXmaUC1r1AN1Q6zrajn/g4+cjvWr93NIeJ5ON+F9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g89K6u5qlErEHn1p8izM5MiOVu95apKtPjnyNc2omO+5hm/qZ+QWaq6K6LwXsuvC7yMoRt+gvWtSGFjfUa4WEJEHuv2s5/i7sVw7HUifUj24SqKhQMOroICr/IaKirRePlk9S85dK0+gX1QoqPR/CMspC+mtDrAf2/V6owW6dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZctigsb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2955805b7acso1962855ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761990689; x=1762595489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McFbXhtz4jmo+KDwiA86yApiev0qIgfE4gvcEtLCFoU=;
        b=iZctigsbQgC+XyAuMXqRqi+sIzMy+Rha6Y/6cRWSqu/GVrNr62iAbQ9+g9HAPHb0/T
         +4EfZ7Cugqo06QrnTKcFdPFPiy2TRwdbmWmBCvy4YZEf81xwNLtcQcMR6jIHgrOTAdrN
         2azAZHHjT4e8DHZzRNaZsThSiRiF0aRzRfGlUTk/fsWac2cVvB5fq1C2XPM3Yhyzjamp
         iJmV1jQzbr5VEPwKVUUbg/yo1qUlpOOIMEaPeZqD71GA+aegwkhnrtpX5LdatSatYqS+
         MUYYIcQKKVx1bM6w+v2H8Lyr1ybqFulUHGA36x9ISZBxGTsb+8e+rK7wzbSpFm+YwJ3f
         Lk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990689; x=1762595489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McFbXhtz4jmo+KDwiA86yApiev0qIgfE4gvcEtLCFoU=;
        b=Ny8LFdTKKA89tmT21/sm59EuoSpMVoRlTi/xMO0lDU6LwUmggM/C9z2mvWKmcASNNk
         U+YOpfnKA8bC57a8hsXL1LebmBLNoWwbIsrpWMP+x/LIUzgxLeStgXcAs75jwu05KrAB
         02a4b0JI8w+Qi5IiahzBrfRL946XT/m89TPtgNZjLxuWv5WTJ12KyJOBkghEaTkp9gy6
         c5lB9drKu4spTkckA6JwNzylRNJbI8oxEQrIeMb7JAar/QYQQDOP8H0lw8aSE9sRPCB4
         ifh2v7mreh5qzkJfgaXowLLOXA7e1DHl+upxr72UcyWzLQETE0/vawJZwmO/heHs8XO9
         /J4w==
X-Forwarded-Encrypted: i=1; AJvYcCWet8zsUMMLQFzXbVbA7b+ZPZO/O4oZKWngMctWXVX2D25tQ1qQN7liSNCaCznAYU7HfSXNE3ON8Lw9+pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdFFj2dW2fjiL3TQBfTiVGqzYG//Sp07U6TdwA8yOMSsLpVvL
	sQBs+ZyXGXZqmIOJYot0i17tmQ1YDudR9xVwhmQq5HY8QN+4cX9Z4YdeHWfItP7ddmL2ky0UMb0
	PaHCRVyEYy7G0PdX4CU0+IxSPpwjErnprQ2WiYaDvgA==
X-Gm-Gg: ASbGnctWzNHm8LU7kWk60EHBOZqep1JjuwS2ji8SZ4ayHkD6YQuMLmtr3XZpWhMYdWu
	jzCKBh3mrYZH9F52sw0JDudahJBnB40oBtlPj/33z5bpBXT2ScCy1R6mBN5fMdkZefEAcof+OIA
	OshhRaHDcl9Cp7mdUzQlUeBsbWXKcHKCzWjS8czIpGDzx3/r8b4eqnDS+8KUcK+JphifQsfAe84
	OLWhwjxECjMEjdoCJsIdjeIZ9KF7Kr3fmLFbhISLTAwFbBRf6oVhsIi6hMSZEYOgB9T7lnRa54Q
	cIdZN/3fxJFZnwq/Ne4u8Mh+RyyULXG2ilaIx8lwyD5mH3mjrPmeOg2NnVyL
X-Google-Smtp-Source: AGHT+IGjYyolfM2D7YgXpZlbGWuWUC3W0ulman5tmkNHFmjO9HnM8yHjQLUSBB/g4yztWRApbBpqGdRKZgmWJqT/mkM=
X-Received: by 2002:a17:903:181:b0:294:fc77:f041 with SMTP id
 d9443c01a7336-29519caf36amr69394125ad.25.1761990688633; Sat, 01 Nov 2025
 02:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.939381518@linuxfoundation.org>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 1 Nov 2025 15:21:16 +0530
X-Gm-Features: AWmQ_bnunGoYmUcG3s90RqJmKPKBCgjWARvcMTto1Ni-6YWyDC_-29m29naBKgw
Message-ID: <CA+G9fYu7_BMtrAC9fHOeHpJwgu1FOQTersRZTL_MnR3bPC4+vA@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 at 19:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.57-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c3010c2f692bb27dc44fd2318888446944f5846e
* git describe: v6.12.56-41-gc3010c2f692b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.56-41-gc3010c2f692b

## Test Regressions (compared to v6.12.54-253-g426f7f601ca0)

## Metric Regressions (compared to v6.12.54-253-g426f7f601ca0)

## Test Fixes (compared to v6.12.54-253-g426f7f601ca0)

## Metric Fixes (compared to v6.12.54-253-g426f7f601ca0)

## Test result summary
total: 115140, pass: 97104, fail: 3754, skip: 13950, xfail: 332

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 50 passed, 6 failed, 1 skipped
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

