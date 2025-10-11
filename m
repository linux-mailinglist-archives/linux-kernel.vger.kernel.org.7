Return-Path: <linux-kernel+bounces-849081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0BBCF2A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18A5189E417
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D1233D88;
	Sat, 11 Oct 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quE98vCn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D7221FAC
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173013; cv=none; b=Y59cG9kY/xsPuDjDuQr0HaBy/QFpFe4QF22SUN2lLxlVghweLM+BMEXci0cQBdUbstCVdsEv/Do7yB3w/+DgRC72qhtXf10157MS5bErQgGQSuSV0t+RLR6jHcjI2ermQ3OBTMxZpxd+KSbdgPh5DwpFzUsj3NOV6We/SQdwSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173013; c=relaxed/simple;
	bh=Q84Y22WpyJXzt9iWS/zC133vZ5OYVYmhlkD71g/ws3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWHoNHzo+OfCT9fSy5DdMVqhZcdmBC12RwUG5CQ3uN6jHFO9ebLl+vz5kULyyhq7FE77ccqrCISITStGbb7qVDSm+b1ldfMT6dzOnu0vDyyEnYnuop8QHmLMqlR38Owy4ZW7g4L1AR6aotxY+YRce6HpXw3ZwDMjYqy1GugLz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quE98vCn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e0798so45119655ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760173007; x=1760777807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZkqoAYenMOoLgUnvzMFIL5K5C3oJ0apuih+rVEe5zM=;
        b=quE98vCnVUHcNjcDgnOPPCXSzB8Bu3S6OROMydX5nHpFC8omIZzuF1xPzgSP78kXbS
         raxyPajS5NQtVy4D+Xu9YXHdlCufaKUrtPvul+Rcuep6kMt4WiSo0n6kBivc78NgaCmH
         5k2AuDGg7zO+n15r2jior0KyY8rDNtKRHxC+0s9buYswdWRA1qoFY7kAOEBaB5hNOCxJ
         xwer25JsWRp/jE2ETJKJ+uMfZIVN3inGBnFQsp2PmpcVteEshukaZ3uXbYrvoq2GSibC
         I82Hf0r4qgHKXlXzf02nWiQsKw0FZ2A53DQR+tuZCQEJNgBbCUL4hxju8rKZMXFpSKuQ
         dGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760173007; x=1760777807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZkqoAYenMOoLgUnvzMFIL5K5C3oJ0apuih+rVEe5zM=;
        b=m7dYoJ+Wn8oo2ffqe/ZtlYDVOvP4rEQ7iorS06p3Qkpl0pKF0s+MPR9NQeDWAz5AZN
         hgEA0OUmtDW0sgQVWuC1hCZInnm22jXiD266U+qDptGJtuB+OCr3FN8s+Yxz0An/2vMc
         aPhonBGn+wI9wiyY+b9x/PsvQ0c+Nm7h5LeSfeh+HJh3LjutnctMLj/HRDwzQ/IKTsKo
         hEbFqtB4W1GeE0ffgXf1IwAQd+1Iwy4oZPN+4pdq4euCaQAF59t4qZ6uJZnDBWsP52ko
         s5Nm2smMhkgvTlOf2w6dRaQ2TTYW8l7CMWPd+GQ8jgYs3IhS0ijZM8JR7X5D2xu9mgDb
         fQXg==
X-Forwarded-Encrypted: i=1; AJvYcCVuQwP6lWLY2ouTlrode2/JWavQJBYxJ/6Hc3xXeA7wTliOfGkPtiMFa9uLYmvKPLHL20YEA04aWOtLciY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYQPbVjcFgDAgtcIMbMhOA8Uoi873YMVSeSdBzwrnwUENGCw7
	h7z2fPWj9kUJHFr03oqS7BqBMuck4aCIkS2L+AZDBfqsaHkN7NhdLB+x5zHJ9qE44nzRIvQn5bF
	by7n5bB8muNz/wZJeZAeEFKAuemdVLnGyDJxs/BPevw==
X-Gm-Gg: ASbGncsIfhMgTRiJuhVic6LJvWt+E0yV7bJUjOwVKTWqRBIlUSUCjXgQ9QXZIWa6+jG
	991hOD/ge7Bgc1kLCigpOD8oqiurgr3QZsAHcHeg6gN22ik0Fq/O+qTJDDgNK1V+mK94429CgUv
	xpzNj2L8VRREuro8flIM+hOcW9r5xwvErfYKT+6v10xUhV1TPg2CuIORScCenQ03a6w+Y4Bqlxb
	nUde4KDv4wrNUyRk6wD6VODOpxS7HDrtuwSaU3R8TIo3gMcRJ5DyXMODgHr1MYNnCbyMasSRfJv
	43woB+BUkhud7qseF+7Rz9XEnC0m
X-Google-Smtp-Source: AGHT+IH4aGvIBP2bJ9+QW0JQJLsjmcgQxlEsHkanAzq5vTqx6NRHHgIQno4wEWY+WHR6+SBn1LZANqc4KSd/RDe0qdo=
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id
 d9443c01a7336-29027418ecdmr195663335ad.52.1760173007557; Sat, 11 Oct 2025
 01:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131330.355311487@linuxfoundation.org>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 11 Oct 2025 14:26:36 +0530
X-Gm-Features: AS18NWDVp8xoME8Wr3vMHaskDzUO7wibXF6YelZ4zKm_xPeASpMUVNthsWfcn5k
Message-ID: <CA+G9fYvFgAOu=8M5LH5yBca6FyZCtrFEuTiEw7RzPoGp7Va1sQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
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

On Fri, 10 Oct 2025 at 18:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.111-rc1.gz
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
* kernel: 6.6.111-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 65af00078567f7e13108e6036a6bcba7f2c26892
* git describe: v6.6.109-37-g65af00078567
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
09-37-g65af00078567

## Test Regressions (compared to v6.6.109-8-gc901132c8088)

## Metric Regressions (compared to v6.6.109-8-gc901132c8088)

## Test Fixes (compared to v6.6.109-8-gc901132c8088)

## Metric Fixes (compared to v6.6.109-8-gc901132c8088)

## Test result summary
total: 133027, pass: 113628, fail: 4440, skip: 14481, xfail: 478

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

