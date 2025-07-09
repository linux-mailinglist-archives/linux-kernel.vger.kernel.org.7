Return-Path: <linux-kernel+bounces-724282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD236AFF0C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EA37A2BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD673238C2D;
	Wed,  9 Jul 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpjOe0sU"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197F23644F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085262; cv=none; b=Ni7yEMR7MKSkU8e4arLAUbm8L3S9jULhXQDncRhDBXmkTI2l5QBQq5flHp00zSoIp+vkZqL7nOGhz4R86OEQG8IW3FFP/MFfrzCFXk2enuGwIBu/jjaamRwQASyQplfPAwv2r+RgI8pQQ5KpjzNWGXgY9PScAK/9lEww79L2xcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085262; c=relaxed/simple;
	bh=p/dryZ6QebmaRczj3TL88LA+dB1lAU1RoZmnGtOYz/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSUI20CKO+r4cyHVurac+lELaTFdh4L7XgNIeRW1VkELSQTbyP055eTGzAgQOlqvT9whHn6X/a7tKKvhUYinpJES7NMECbqbboVTAQ3beTlj1Rxwt1+9IeVTp90O3+c3tvSDctJ+TdFr30YRzAj3AxkFE8B7xgbMs3k+UxattrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpjOe0sU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so268244a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752085259; x=1752690059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfJ8WRoLWUtG9c45B73F5HHWKfasYMw8IzOoWgo2CnQ=;
        b=TpjOe0sUNLcmUBTjGfGEAy3AYNFVaWSWWD1C8OFdm4zGlq9U1RmBeZiuHaczc2RmOd
         eLOu4rJWxDSTi3smcy+NEZGnHBzntK1I6pV3iSJFyGFlkV99hMXr8ugJCpVnBOvm3s6v
         T0oFZqfMProGHa1FtNQrfz3cFTogbF7MZqG4BdJraYx9r2kxe/MUa0IzZ7/q3zE43U0I
         EOMy/EIDzDBFspS7BBFVcAS0155HzvtFECOpST2uxGbhN6ZwZF2/M/bW+NgEYlBVFIlg
         B1QNv68anCQH2nTtRlxamePEV9+3k4S96VSbhbxG2LWbAY724Wq6YPKmu6jVq5rkZzq6
         +Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085259; x=1752690059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfJ8WRoLWUtG9c45B73F5HHWKfasYMw8IzOoWgo2CnQ=;
        b=JVrRar2oh1LB5d7vdiNBwHEx2O2GzrEjrDd3Sayv+APzb1Gz3MbBUFGWtIeLl9JZsW
         5rIk5PziYw9TYDb3jDfh7pcV1lPIFeLjhjyeg9v0KJ3So06t7qepKnRQI8ez0FKsX5im
         v0xyQjqI/phsfqR3v8DtD5dxVMy5jTpOZj4PqhokEM5CJF8XbDxAHw3XJc241UI3p168
         +Xd5NFseQakZZHQrx35qdiJu7LJCdYz8QrA23ZhN/GN6a7NaJvVlmpT8K7dJK1HCSgt0
         ejJA9jxzHfo64znNJfc6mUvTlKvuzT67ZY3v7MG3PKS0sRAkdGdJgRX1Wat1g7SyLbuS
         SLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjVQWsU1/UnqR3lAPifHPkSUyt2mgN/hvNmJHIcYnQF5VcBoilYtVSA1toyV8gsXWDxrPot+O7WN8W+o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFtqlHDbPUjFyvCOb56PrlWrKFPMa3CNLRh2hJtQQujiEbC4E
	JLd3W43mnx5CueFp/Ux+j4eeX6z0JnarAyq1YAImpEOHQrjCLzrj4LF/Q06Ygh5CgD6hAxb/r0y
	aJQiFvkHidGWreBC2Bz9by63xmbfXPyj3Lc0yq/QUnA==
X-Gm-Gg: ASbGncsO5diwb94HC/Lsw2Z9BaztccL3CoiVgz9l928iSTlI3KjaT5F+/+VGESNqZlg
	72vgzHJqsHpW3cfmtFUh5sYe2k5e8y8e3w92vJIamcUEi3ZQsTsWkyK19c0opqksruv9ngbfPyj
	4hpiU8zPjV+rYqcEjlHEvEQ7urTIp/X3yY4S8iwnYvNBGkoHiAnsDdCr/LDNms+ykeLIvKBELyQ
	Pm0
X-Google-Smtp-Source: AGHT+IExtmaIL44BvbpJdzDSJVsuTq7I6JM0TtX20i4Aie0oZ22OIY5PQzXS82OR66MKRFgXdL2GskM0SUmBd4l2sOU=
X-Received: by 2002:a17:90b:55d0:b0:31c:3c45:87c with SMTP id
 98e67ed59e1d1-31c3c45088cmr1108278a91.13.1752085257282; Wed, 09 Jul 2025
 11:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 23:50:45 +0530
X-Gm-Features: Ac12FXxsOjG8FsT_QU-sc7atBK_FHtnYoeDJkzlyKoxOjVhpVN_VdRKDkXaICsc
Message-ID: <CA+G9fYsxQLykV7qgHoLRz2xnGrYzoFEbSKM1Nm4m9q5EVeSnig@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
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

On Tue, 8 Jul 2025 at 21:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b283c37b8f144465ae3c78397ae2e9414ca53288
* git describe: v6.15.5-179-gb283c37b8f14
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.5-179-gb283c37b8f14

## Test Regressions (compared to v6.15.4-264-gf6977c36decb)

## Metric Regressions (compared to v6.15.4-264-gf6977c36decb)

## Test Fixes (compared to v6.15.4-264-gf6977c36decb)

## Metric Fixes (compared to v6.15.4-264-gf6977c36decb)

## Test result summary
total: 339648, pass: 311820, fail: 7773, skip: 20055, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 54 passed, 0 failed, 3 skipped
* i386: 18 total, 17 passed, 0 failed, 1 skipped
* mips: 34 total, 26 passed, 7 failed, 1 skipped
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 0 failed, 1 skipped
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

