Return-Path: <linux-kernel+bounces-751933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B4B16F96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743B584B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB42264AC;
	Thu, 31 Jul 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5a+lBw+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE921F874F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957825; cv=none; b=mraGK7VY5COsVcJNTqGBMJuViBvm5kmrqhZSYm1eTmD19THzF3OyvKG2q2/8WuNJ6exwwKkbcPt6EtMvhOQDGt9ule/Omtqgu2/RgZZD/dSy2trW0HjS85/H0aKUedmlZ0tKDBgPFC6hS0wmtWOq2xINmQMqDp2HU3dMRtg8URI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957825; c=relaxed/simple;
	bh=cKgxv8GKYiGoJyvHvFtNmsnGCey+KIp1OZrYAvCNNWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJUajIFXkm/9dd+QVVT1cc22PfVdz5e+D9D9B7xRPRalSrE3jmte6HMkWAZJMeR+jNsjmdHLjHoU+/OXw1M3d1kB6UA6YieXz9iVBek//RaEbVD/QiPDXjILjaQedIMwu6l0YO3/JJRfdlZvHRTCd3AuVEn2KxTXwGwCnL3LFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5a+lBw+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so632250a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753957823; x=1754562623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Oi2qTuWyaRtBb7dTg+6FPQ+pI3wu1nBaCzxMIA45Do=;
        b=c5a+lBw+HZyCmpL9W/vBhuicESMnVChARIriMXeA0dnEl0J0r+BEWU1z5zscoOcpLR
         oT0MfjLvhjfUmITmFMYnSDGVWUiWxnyyQCFSBt724iDx+F4LSFhuKis98AvyFvZ6Y036
         RdwdaP62NrKtmMEiUFEYX2hWkYdsOo7qjPwghJx60rgoWqzG0H3sarTc8h0n1j2AchMl
         AxO9AeumwnYvNg4IFF6CB5lHqzLso1Ys5ivP5kAZdns1EwabV8Xzoi6AhsVrJE+JR/dX
         flWoCHEB9vGtjjEl2ap1B+gfFBVe48KQ2KtJpPbPntv3gX1HVZJ0h55hlK/wwypSSbaX
         1vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957823; x=1754562623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Oi2qTuWyaRtBb7dTg+6FPQ+pI3wu1nBaCzxMIA45Do=;
        b=I/ICoN2MxuUVgB7p9/8KPcelg7sHiYO3EiG+Rf+Ysq9NNboVv7RDFhW6/pNoKOHESg
         UpB8CyqE1UySzifq7/ABh30UVPYIAC6qfQuG/mvH39YIlxDVeTTjv6CqgRS8hPZuRWxh
         Gwwbg8Fl6+4oeG7WGZ68UbZrOulWIccjOkHMppKstXMCtfoohSxZM5k41TBB33U9klX5
         ZgKUtOJeZIXyemwEHvgJbw5p2Guu9KuJODqdfwbdk2su2iYrf6ld9ipsYs/gIrxebgpx
         5WDi9qwWQ9z6HfVp4PQPutOSAZNtJ/u4tlJ8DQVLx/vt0s5XAJjMuzyIXcLdSn6uiWHt
         mHJg==
X-Forwarded-Encrypted: i=1; AJvYcCXIOaSfRZBAbQUnSrBd2nempI0kLnlwzQj/Qa1+CS7tEmvqqhiv0YEAyh4NF8KQN+x+BZJ/rQZztrs2HiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweclXD/qWshK/tRkkkfvV8xOrbYLYB2fzEnoaqLF+QyD7YILV3
	+CTTm4xWfLNDfAHPed+NwlRxCoA4DcWXTufqRjmfHW9IC2xUiCtErrG8+j+MkpK/bTPVbfVKoVI
	i/wjwxED5mV2VDwSRZwoKbtk1vQpHfb2xf7UpHBh7Zg==
X-Gm-Gg: ASbGncuGl4Cz9t8DlODPWgtk61TkakJYhMP87yq8hAaVutTnb5itW1yP1AqflsALeO3
	5dmOLb5I2sw2HBwzWz9WXHm3ExnuQB5SZo7DturbVPihvwH5E4rfv7W7iclOtVP58Pw8CLH6Cjd
	i4qhPMM84h/XQVpGXpc4h7XB6GS454nGK5LDc8bsT9RWuepk4ATRzH+1B4iutQ5l6JwPztZXIzL
	MApLpdkpMD/rnM4051IFSlsM6EikJJODqEPpMQ=
X-Google-Smtp-Source: AGHT+IFMo8eS9540Ycpyz6BLwie54ysqPXYxyB99tqOVm2Ha7a5bBRqVrHC8MFt21s2epCH8JoGbsK1iTUkRJU1SI1I=
X-Received: by 2002:a17:90b:388d:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31f5ddb5096mr9836519a91.13.1753957822885; Thu, 31 Jul 2025
 03:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093233.592541778@linuxfoundation.org>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 16:00:11 +0530
X-Gm-Features: Ac12FXwer49nduMpxwQFJNtfBz9Kcza_Gc1ctDiNbFgtwe0wrfzSSf3cJpFYum0
Message-ID: <CA+G9fYsFR+u0BLAtwvj0kyA6MRKEpihf_SpDMYy=JkpCLexhng@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
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

On Wed, 30 Jul 2025 at 15:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.41-rc1.gz
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
* kernel: 6.12.41-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 487cdbecb4dc1c90451661e3de44c8283c2743c2
* git describe: v6.12.40-118-g487cdbecb4dc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.40-118-g487cdbecb4dc

## Test Regressions (compared to v6.12.39-159-g596aae841edf)

## Metric Regressions (compared to v6.12.39-159-g596aae841edf)

## Test Fixes (compared to v6.12.39-159-g596aae841edf)

## Metric Fixes (compared to v6.12.39-159-g596aae841edf)

## Test result summary
total: 326156, pass: 304428, fail: 6239, skip: 14887, xfail: 602

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
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

