Return-Path: <linux-kernel+bounces-864886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7BBFBC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775B73B920E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A2340295;
	Wed, 22 Oct 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2L9lDhs"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7027465C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134748; cv=none; b=fZ54zif/3DN8eu+IdDigYRDYtcvtxPdJOK/pRbIwo0EPO5H1evz6H4PHn6eSnLzhalzyIWhvfWa3H9kwHuHQ3OAR2m8L5LurBD4FucVhH2WTGAYHTpXUeHa+6nTXRLBHoswwtAJUrMcZha8l+9GPy10mZ1kiNzhGSA/892psEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134748; c=relaxed/simple;
	bh=RNj2koT6/Jg9iN8a8+Er+ObY3cVJy0QTKD4UCscfYnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmKwS8A+jVjbp5NxhmR4vhJOh7pEsmQ8L+JTj0wgmpsMzn2CUZ6YIeA9d39tfG8Mhp9VoX8Y6X3EVdHHu9TB7a75NdTiD8HlBJ0x6E+ClMrp8lgoeev43i9bnKAFY3SkSM3XnLdxpQ1MTRsXQveDDLGAwhIE7dlqSQYRtvmHmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2L9lDhs; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e255e9a20so5113436d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134745; x=1761739545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsbxYdewfvfh2UHA2Tl3D1IaYpjBuKyP2US1/dOI7NQ=;
        b=k2L9lDhsuqurx2oe6laCCQ52NVmuPs34Vebxm5CHGUq538C7HOlEGI5D2SOjZxVQ/M
         iIwwNp4hLUqAj9ltmL0dpF831HPlKB9dfvuRrPbrsPz8eeXln6zijz6oK9EV35bF5qYI
         4J+bR58p4gV4Vnd+2SgE2DYtJ9ljg2Uzsf9thg65B3caKhODp3JUq6q1w1/I8eIse3Z8
         M7iqPSTqGrv3sXik3NqrKztGAOd/jDeuxZ8y8Ua1tXwap4eZ0LnFdlW3ONwBrxvOIDZL
         o0ArdENseE33AdNsPOPfJzg7seulpFI3w7m8JDjTZJ6tnA2TbZ6Vpto/7q0XWH5ijYEq
         NZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134745; x=1761739545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsbxYdewfvfh2UHA2Tl3D1IaYpjBuKyP2US1/dOI7NQ=;
        b=snQGgK9fRqA/JifWiwiER7fUAm9Gl1zU8QOTVN9TdYt2y+LYh/YL0u1ohyf9KwZZ3B
         kgEkcympaErXQgiuJSyuiTmVjxq9YY80gQDRxoOsx+tAO3dUMIwdUJ51WHNbePxubLQy
         sUNiAXQyCws2hoqH7t7irxZ9ReTroTh6d8/Eh5qwjnZtFvh6fr83VV2xOiT4Pm3taLXJ
         tHtyADu/7Br/UE9cRPuo/ht04cQ5fgDHR2R5zTxj8VJnkmoK4akG+DiVQCp47oEdRczc
         IYovElE0+IzNf2o4yC1u8BGfMk3akQT7ZlrYk32rXpI9LTGkn3I/v0MH8RJnDrpU10ne
         7Jog==
X-Forwarded-Encrypted: i=1; AJvYcCWqLOEpwN+tyM/IIyxIMg1uOkxdJcqAr72KJQwxJ/a5ORYCothjIy2UWG9ASIC60VeMuf36zLOyQ2UvqHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMvXmS79gF+O/YdpatP+rRWpmMevv0fVGbobYDgufgyuT44o7
	QhCjl0X6mq4lVcBV3zrfN8rii15v3zvpWDmc9k+vZWQZ+s5tFnn8M92Vbig5xI3Bcvg4G1Mvnkd
	QAHqVFdDpEGDtS49zecB+wG3prbQ1GU3W8D4fFJo5pw==
X-Gm-Gg: ASbGncsOyJKwFlVMTM+cGY32eynRI9wUXAQdVemmXDKvgyqnUZJ+07C1oglUGuE/L7W
	1+JFXEBNGbccij1UpYKiCeHD04C+BP6tiCUcXNXVhyZ/qATvfVRZJaZVMuCN7HC6BiiDS7/leZ9
	JhrndQ3F05g9L470H9cPMMqDhr9cwwHl52vPcAraLzTy5CxQxeZ+gE4xSMpjoWOrnDbIr8RSn5R
	9SFrU5Ln8v712WHygVDf/Vf2bpgLYmGshMqJT2x8Bvco4We0duy2Os1RaDx+X+JhqJFPJP0sDrL
	U9W4vxvXupvTR1xojvVFHmvIlz+GkhjXQMyqBJ5Cfl3BIsE=
X-Google-Smtp-Source: AGHT+IEVIK7tQKmoArMHFnvXs66lZp2ZJesGI2vCEWC8RihiAm1lX4iHvyouvLFSKyiioGMo2OeoztXCogIKnK/gcyI=
X-Received: by 2002:a05:690e:d59:b0:63f:2b0c:2d6e with SMTP id
 956f58d0204a3-63f2b0c2e74mr1569504d50.3.1761134745547; Wed, 22 Oct 2025
 05:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021195021.492915002@linuxfoundation.org>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 Oct 2025 17:35:32 +0530
X-Gm-Features: AS18NWBSyT6dQcKb1MqntEcC897UCpgSrWukoniGLQKQve0iUkiFAwPQt8eraPU
Message-ID: <CA+G9fYvfjjqBqxEoWudw6PUCz07_r=OxiA26e=cJ7bWBGNGCTQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
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

On Wed, 22 Oct 2025 at 01:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.114-rc1.gz
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
* kernel: 6.6.114-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8ed83e981d68359d06ea8e83da61f55c4a5fc71c
* git describe: v6.6.113-106-g8ed83e981d68
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
13-106-g8ed83e981d68

## Test Regressions (compared to v6.6.112-202-gef9fd03595ef)

## Metric Regressions (compared to v6.6.112-202-gef9fd03595ef)

## Test Fixes (compared to v6.6.112-202-gef9fd03595ef)

## Metric Fixes (compared to v6.6.112-202-gef9fd03595ef)

## Test result summary
total: 91363, pass: 76815, fail: 2923, skip: 11410, xfail: 215

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 127 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 31 total, 30 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 9 total, 9 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 3 failed, 1 skipped

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

