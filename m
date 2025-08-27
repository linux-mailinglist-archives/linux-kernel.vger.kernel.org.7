Return-Path: <linux-kernel+bounces-787886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9BB37D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1A1BA0F68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFB432A3C9;
	Wed, 27 Aug 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZNJoQPK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B3322768
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282318; cv=none; b=V9BKBJ0ATS3mLQjhuWTHa9IQ8oplJ6t0Wm3LOJf9zjG5wr/bRHKKBLmbpSaEf9OeGYWHPjsDmquPf669Qj7vRyc3apoJ+iN04Z89kStvVszVpsdMH48nttJEAIdXPrpQEcUUA48N9woZPJAK4l0mZOiITf6NVQNOULbLOY7vRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282318; c=relaxed/simple;
	bh=jOoLC5GpPdKtCOkN4m/zgPw33LJxJ5I73DN/I9tbbWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1rYPT/dmteI9Gmy6ZJxpaKzeaB6o2/v7z1WLO5VTb7wohR10EZfVnemJyvGDpYTEQECX5iHy+PkwtafbgvOxiF3YGPNscVuP8Aw2ctLSdw7IArGukkozj//s2BIpAZGSylcYohyrMbJJfjewObUQrLlGQuh3Lg2yu+LlbXZbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZNJoQPK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244580523a0so64420195ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756282314; x=1756887114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B83u6UCsQHtIoE+ppMxK8f8WCkMt55tIYpEVdEAzh70=;
        b=RZNJoQPKBSBeaxi083h+oBSoP4TGkdPFR9NVbPAfDKxbZxNTYtwPn+Ua5RdezxyUVP
         UqtmmLHHvTiB0eoeF0HaRMjcKSKvo6oG2ZLYM8UA6moB3L6JcmQQ3zQmzD426IbJ8oDx
         hYIGfCeREly8NMODNV5nq+ggQO31cd5gWlPGq9cDyEI6S/rr/aq0h/yCoitSSwUET/xx
         a9Xtn4jRSqd4/MJfIdtqm9ajDv7v8uq+vC/inWcZgPN6931JFDWKM8bgB+lHKx8RldXa
         O/wvjCI3s+Ns8/w1wYt+w7e/E4DxSWBMlX0ijda9NURwpXpR23VCMqox4h29e1hzvGdB
         kxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282314; x=1756887114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B83u6UCsQHtIoE+ppMxK8f8WCkMt55tIYpEVdEAzh70=;
        b=Kr49ohNLVnlms0eJx9Af0MJEPBnuK+yGQC3nRrd77oVgp1CTficrm7idRg+mBE5YK8
         Pdnp5tlUv4PrBv3wydN0BoLjxym9501EvdMx4Qm30kTh5M+H2f5PW7qmqF4HeEIUeen6
         dccjc8N3LiMjiV8KYgkHcsE0KbaxEEZnGz3hr/uyyhipJJrUEfemCBX5WHzXsjUq6J2W
         Mm5z+ymwwCaBTjuI5Q6rHyZ1ohlgsatBBSzCPSmsEc2Cor36oZNXVQFhVjkuuMNKbnAO
         pois4rOYj6R4K68VenBv3PW4qS/Ua0U5md2HaJPocslvOvnZ46HjTg+h+bgOzaDOL7yU
         D8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ7gdPqK5mZ3mj9OeySpZ9MfDUtXs3QvOgGMXBvWh/Nkji5PSdcrK0rTb/8HLwFwCOE3Ho7Y0e1Ju1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFj6Tho5eJEXmBYEZ2Y69Q4DOvKg8GRGrXTdXlkA70MC1sxOXN
	KP5HiHjx5ePNoIcFhQaVM4ZZNXw/kQ2ZG7wgY1SZAIMt/zpeqVOnZ2sh0JgzkCIUsnzt4gruhuS
	F9jjXTFJfCqJ5aCkThal3l87j279NEIcQuJEhsrHhcA==
X-Gm-Gg: ASbGncuXf0+hd6cwLHX1X8NX4FG7Z+TBDct++vMyjT8dcOknBrmKAM1SkEPv6ar5its
	cU7c3dKLwx+EmvDQdSVAQOmkBQmgao8We2pn5FUU1GzfuI8kd8Fd9zuPhw4sX8477LMAtV38vKW
	7QqSbx+UZBLQpnXnRNXE3Tm84fA4+67WhU5ffy2bM9ScYKv5LHzdvcP2AZfVhzPR5+pFKAYlOzx
	dmP4UfudDdLev9/+V+H0NC890cy7sGY1EzUa9VW
X-Google-Smtp-Source: AGHT+IHDCckS2GvgDg3rDQSosFDUnr9S/UaRCXlraeNDTOGtJ1FdHBVbfzE1VsmrTB2K196QXG+a/QAuc80Hecze1BQ=
X-Received: by 2002:a17:902:db0c:b0:246:2703:87ae with SMTP id
 d9443c01a7336-2462ef08e1dmr213164435ad.30.1756282314497; Wed, 27 Aug 2025
 01:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 27 Aug 2025 13:41:42 +0530
X-Gm-Features: Ac12FXzNZVkmP27De3ESl3_w9jJo97pXSGB9GkNlHU7vxAIViOCe9v8deHERbMM
Message-ID: <CA+G9fYtjpQDKwsBPM50kZ22h-dcgy1oZiywEvDanHJd=04ks2w@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
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

On Tue, 26 Aug 2025 at 16:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.4-rc1.gz
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
* kernel: 6.16.4-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2894c4c9dabd275ab1a7338d9631bc10e5649c91
* git describe: v6.16.3-458-g2894c4c9dabd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.3-458-g2894c4c9dabd

## Test Regressions (compared to v6.16.2-10-g3fb8628191b4)

## Metric Regressions (compared to v6.16.2-10-g3fb8628191b4)

## Test Fixes (compared to v6.16.2-10-g3fb8628191b4)

## Metric Fixes (compared to v6.16.2-10-g3fb8628191b4)

## Test result summary
total: 344576, pass: 317202, fail: 7069, skip: 20305, xfail: 0

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

