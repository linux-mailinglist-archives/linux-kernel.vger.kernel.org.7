Return-Path: <linux-kernel+bounces-797844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC2DB41616
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660CB1BA077C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC412DA757;
	Wed,  3 Sep 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+b2V58e"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D222D97B8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883874; cv=none; b=oEIkPI1JPaRKYYVp969ebHlM7YP+DZCTdeFWrInccm1UwZnu8dYNNKjoyvOPDAxymgsziGuABxAbGb5kARdFXJwzcz5/Kjxd0736aW/Yr70bNwkxiiPWhmnbHT5bxXwhpH0/GDwCSpcEiFYTnmzbKpHusuvcG118AJdsQkupX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883874; c=relaxed/simple;
	bh=UmRwMk4UyU9iF1L52qhq9eclMpOmDUwbEL6NkhJwQSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku6BWKOeCVq7d5w14xXNwggUubaGbn964Hq2lpXNX4Fd1sO3LSecTd4ispx1G4XayziP5UQ6j0OR7vku0qPgnEq60wne4txL/8F4+9CGZnBAXvrkxQz449TYqT/Lh7V8sMSgLl9yw5912PdbUUKarwgZCwQMvBtLSW+b52OYSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+b2V58e; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso198428a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756883871; x=1757488671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtZQk3qEYaGrYFmRuGVls3E+sSCgFoBR1bXzERkWFbI=;
        b=J+b2V58ej1WYdDXwGSFuAbVTbJXn2qLvSi8EVgcuDSVA6PYoGy+hSsHZ4crP0eNg14
         nlDzwjgUTV8AXbBHwRbDx5X5vhYnV2kNroRytXY3tK37Z0hppbx5fDXpO+WFfcpsyxCJ
         N21VMRblw7iSN+FmdunCIvDZ54QGQKtjzOPyZFcnYza606Ch5npoMKT2wMVyAf0/rmYj
         iy4wLHtNNCtd8JoAcpAOz0uB4zoPeiKTVE+T5pd2vxe7CSpZd5Q8Y7NRYZYdbWrh8u/g
         Vj6qJHOJEm/b72GO824Fn96/XrzpBtAWYb/zE0DmWspC4LD7jDPHPn7BouP3igKXe4yu
         uURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883871; x=1757488671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtZQk3qEYaGrYFmRuGVls3E+sSCgFoBR1bXzERkWFbI=;
        b=VjblY/Pn/28l1PeHMa0IzI6qteGTM1jpUje4JeguY9xt2J+KqqOcneaAg8q4DL5ALB
         4NYQXjuPR3ZGt4eDrAppiHfdaW/2sgXP/CgOf4/UvTLCKr0lER3IJm4rPI4hWbDfmUD4
         kPKV7LN+8ZbVWlTknp0xh+acUEaJ8tvgwWdhUaMEeljWSfnYGXZ8jgB2FOJIzUqexl03
         agq9JHPE99gaFbjQW/ufi7a2AhmmzIOwRAbGGBjT2yAX3nYH43G3H5TwkzXMZtJHrx5m
         L5P8IQXkJqb5N0f7i5BUhUhdt23dzUbqBuPA1+dzsXlup+CUvjBJywcEbsUE+DzM4RZv
         Z3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzQ8mUl8Ltguvy607Sk5aINEy4YI/z5pCb/f6IvrtAXZCDNQicJ4fkhCfrMUbDoUmqIFt/m9m1KV90oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcPRPRgK5AMAGzMAO0f7MPRhWqNox9tIdbPfw33EiWVjfBoNw
	6mZUVP7b7sjYNXheHXaCUMeKG+/x86XfDzEM4/M+Ito5/elW26yrayvgpYlYEErNr+IfXrpB3M/
	rBofEQ7eneR6DRYVNiY5B9QMZW5V5fpNucvCt9SWlOQ==
X-Gm-Gg: ASbGnctx4mdUSTS/GcR3iRZj3jKhmPgRF2NeogGWuVs5WsYqyFigQd6pUxHNtU2+49h
	KENvFlcCsc5WQJS+Fd1fNM3tsbmmNWCHe28pH/ZT98k+Ju+fFv8BoPWKax3IC1yO4QqNGlNeg7t
	T4IbU4NJqGZyIDFYmjHoXqQqdFbtjl13ABOY5/2Cu69FLQv6taeCdJuPzdJ3q38av6yJHEM/Rmo
	1kEvd+iwd3OPTBmjVhnYWeCrvBD1PW4wUdaNAJpAUO9aTk45vk=
X-Google-Smtp-Source: AGHT+IHbC2eWGnJAQSmz8QCetFm2ywFgVLZ0FazDkS4bKQYQIfI4IWjdRDCFy0BXSLm08wp/pFcKC9G3amxy2x1vLgM=
X-Received: by 2002:a17:90b:4b8d:b0:327:c9d5:257e with SMTP id
 98e67ed59e1d1-3281543c7a0mr20454710a91.16.1756883870836; Wed, 03 Sep 2025
 00:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131948.154194162@linuxfoundation.org>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 12:47:39 +0530
X-Gm-Features: Ac12FXx2JI1QpukV4Lu7p9dVUayZlLzc7S3-kKnWthy6XbZR_LyCoaVFceYkR08
Message-ID: <CA+G9fYsc5L2CHwD26-+ZqcCyDPzxi3f9Mc=s11QEtcguBRMfJw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sept 2025 at 18:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.5-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6a02da415966f62533bff14bd579f6866076597d
* git describe: v6.16.4-143-g6a02da415966
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.4-143-g6a02da415966

## Test Regressions (compared to v6.16.3-458-g2894c4c9dabd)

## Metric Regressions (compared to v6.16.3-458-g2894c4c9dabd)

## Test Fixes (compared to v6.16.3-458-g2894c4c9dabd)

## Metric Fixes (compared to v6.16.3-458-g2894c4c9dabd)

## Test result summary
total: 350240, pass: 322942, fail: 6798, skip: 20500, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
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

