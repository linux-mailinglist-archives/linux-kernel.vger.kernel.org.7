Return-Path: <linux-kernel+bounces-852051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B9BD80B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC424F0CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5530EF7F;
	Tue, 14 Oct 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeMtAs1i"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB072BD597
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428730; cv=none; b=nXNdCrfh1xLbBLuPCyUxBcj72krYTfaESJTOxwSLXUoQyqOh19nvsRYTveFMQGgc13d9Z1QLnHc84mSpy9mQ6XEVb7m9DVH2aH6s3dO2CsdSpmSM/Jt32twGvRoIab0fch5wbx25DMIZgwr61PAiSgr7QeQHA8PUG8prtt91mRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428730; c=relaxed/simple;
	bh=G2VtRn5hudNwHDgDn/7W78by4qirc2MsuWrSActYjD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5e38P1QnRtF3iI0yuDVaUk9kcBtrbUPebSa3reAKOP3zeq5lEJhlPjHx/zQcPeHeykfAle+ofTzR6U+RbFsx7wAcdVqGmXsoPHk3tUcMs2Jp2Pop2yLZREWyijvqJLCJfFADN0vcOIlEU2KgY5Ad/aTngiFWBOFUviZLS29CWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xeMtAs1i; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2494218a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760428728; x=1761033528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gCfEtBQohhUWgvY+Jg30trTCgcmv7nRwq3VJ9R+wHY=;
        b=xeMtAs1ietPAmKIZALBoEnyeG2yp8CH77vwb2kyCIr2GroWIQBpFjQX7Amwo0UK6ko
         lIR6v1YNloETensMb/Q99LlDqRTz/WXNBBSGzHt3dypJ6BIeitX2Wjj8CpUbjBqe1B5l
         vt60r+uhUPOKtKQDKFGt9e5Edw3PeKqpNT7U3sdv8Hb1CYCsCjEJr85sYiKnHaJte3tz
         HQZpuw+qeSOEfRGyeWFUmlxUCbVbjSI1SR4LqZxb6d/dSsTsFQKpYKol/Jfnfv+vQAt9
         VPJmR/33lutDnWp7ZFpt2trRhxDVvhoFaWxY9I2SQJ5FScWu8cUsSratU1FREyOYlIU4
         QUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428728; x=1761033528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gCfEtBQohhUWgvY+Jg30trTCgcmv7nRwq3VJ9R+wHY=;
        b=LqBFZkvAgmIjuEYjM5BSEA1Sqq/nh9PAmGoGS/Ve/E+ZB0UbA7b049viTq31Zztl3/
         KOy+yLzTtdqc34fJSoO/f2u1hD+VH+HR+nb5Ro9e4pgsCfPCEsOt+C816QoluXVZmbm8
         n+WpLz+ETJoGy4ielk48jU8I7yxWrzYsjPWrkf6Ad1TKzFDo83cwoQgaWqvgUEBnTGk5
         1IIIkFIH8XQBFOjAk5yUAYRv8cUHy9SnU6NDsuZ5xS077LrVQkAeFoa9v5bZkY99DslK
         k5Sxz8Faata89QzqFcF3jJfun+1NYCdPpMOxcXU6ObckyLTH4/esqdMrsS0ABcmzM2Fl
         2H7A==
X-Forwarded-Encrypted: i=1; AJvYcCVkDedbfn4ud9/xehTVKOZXT00rSPH4/ZvMxvuiLBpah6eaqFNStekWqUJYtPEEdidNSM4UUKF4rvAbDpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1zzgkEaNDZc1XoCktajPupYp6z0x8IBkn/dptfSbGEGYtb5u
	PBNkZdqB1ET7V0OZtzsLeXMwPbjHR2p6qrcmkAoeA7STl4udz3FrOby3HkOetikcGFF1UF+/cOo
	Wl2biwiDdtYWEO9m7AgNrLPsccs9wpp0YZVSoJNe0iQ==
X-Gm-Gg: ASbGnctskm1W+LFeVICJKCWMfoPCyEq+oQUAjCsDtNeuH6shAa7OFs7uK8TyN92Ansb
	2h9lg/lWE3ysDjFRj5Ey+rLEgKoWbn9bBRCzzMn9odsmtX/fcAv3NK4LBshq0KBuIn8x5DW4//e
	Hw7KtP85XEgNglSOVGeDAL8cBdz7rm7rrZkA+qHyrAQV0L2Qe/CC5VzYO4eMOCiEaQN0i5ZZzYA
	7jG0/gMm68BVc87a2BaiIv4+iKG2v7Pvm00IVrLcpjtB/6D42qKZSYXPMUzOfrIJ5VXDgjsD1SQ
	e6B5OL/D6jP23emj3vhWvMkO2K9aUw==
X-Google-Smtp-Source: AGHT+IGyLtRwKF59vA/XgA89QVVWWrZXaLpJuoILoiZ0IPjJIP505nZ21laMBq6+MEb4Y6JHPF+ffXMGtMTqV8CQDmc=
X-Received: by 2002:a17:903:f8e:b0:27e:f16f:61a3 with SMTP id
 d9443c01a7336-29027238f07mr282622365ad.23.1760428727710; Tue, 14 Oct 2025
 00:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144411.274874080@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Oct 2025 13:28:34 +0530
X-Gm-Features: AS18NWBVmjY_ZUNYY0Fb-geHzDHpJmdEB3VK9gcbwGTLTufE_jsfJXboVi5C0ZI
Message-ID: <CA+G9fYv4wpxs1zOrnNBCK+oYL7-fsTy2Lxgd9NGMY7PcwPOTMQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
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

On Mon, 13 Oct 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 99cf54e7bd2fde42d75c71b54fb3652adea2e7a4
* git describe: v6.17.2-564-g99cf54e7bd2f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.2-564-g99cf54e7bd2f

## Test Regressions (compared to v6.17-43-g8902adbbfd36)

## Metric Regressions (compared to v6.17-43-g8902adbbfd36)

## Test Fixes (compared to v6.17-43-g8902adbbfd36)

## Metric Fixes (compared to v6.17-43-g8902adbbfd36)

## Test result summary
total: 150604, pass: 129081, fail: 4610, skip: 16913, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 51 passed, 6 failed
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

