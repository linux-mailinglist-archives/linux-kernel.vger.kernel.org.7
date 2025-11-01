Return-Path: <linux-kernel+bounces-881203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF75C27B60
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE12188FAE5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AD284883;
	Sat,  1 Nov 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AspKEKV3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C6DDAB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990808; cv=none; b=UTuiAikCd3rvrmOen4IvL86RBtIb89IfeHQF9sy86wnVHJpG9Hwmi1WHvAFR+2aqiZfuf66dMvYQY4JHy3/vVmoZHK+RJ8SX75Oq//wNXdHkA1ntdPISinp6YzC7Ln8QgRxzKtPODcJXB1yMThBLi6dWiCGQKoXH8zn/FshNROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990808; c=relaxed/simple;
	bh=4NnyNfGAC6ZsIDcYxmD2cQdCUcSzIsBYlbDPrmER68c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scCbOtKy3lk8oL6g3bDc5ckqyPbl58T9NR2JEzohzLBRgR/JjPxqxzxHQrya06ckv/bY0t3gV1GLSYeEmNONLI6UnNob8tKlb/G7DALp0sDNMjgSqlGud/x3XIbXGSvQcOBrizr4tJDbznk3ewYXJJpq1ohIGS6kJ629PnKmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AspKEKV3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29516a36affso18485935ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761990807; x=1762595607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiQP2oPvOGmDsDaKXplb5p4mdzdNo2KLeVLNAbQUAh0=;
        b=AspKEKV3k0QBLqf7zHcyRVwmkMIWDyJM8pzR4JAWvYk2/onNvNeupeDdaR1NYn4zks
         r4Zji3voB3lBHGNyUvJPFtOr38L2tQiopclRjqMpt9amrXBvOdS5Nm6BevlPzCY9iX7X
         rS7oEfx0IgQ4rrcgiN0QZ+4oXx88PnjanS8haCxSaqxbu9NbbgGzuqb1Ta9MJ1yTW3aA
         5w0q/Lc5fiT2vT16syoBMuB19Mb9+1w3I9/PlhlEo+G77HyGcagiC0EMUEoT3QgXG6aE
         5Wd4F8gkXq2UZFhe4YLF0Kl33mugkkBaZRixg0zX1Ff1PZiPo0i45KVL6ejtIp3qIKA2
         KvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990807; x=1762595607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiQP2oPvOGmDsDaKXplb5p4mdzdNo2KLeVLNAbQUAh0=;
        b=Yy7MpCB3lG1VGOEuO9U+s3RqXx77cFfyc/2CZeivLmpsNRjygPKWZAjRtVtc5jd86B
         bPwjTjGbVutojFU1HR4h7BnVnv278MKlXPU/qL4i8IeBKn2octJiGpy+io89Gq+/DKsg
         6rg3sbq0Nhn1T6eOrEe/iA8dYInAdVPO70ei3qsnNU+CJnKdjcdeCiN5RkDuF2izspep
         eiekRFSeiizkJEXTHHmmzLuAZL/M1Z76fGwxJV8Yojzl6iXktz1PE1fxjL+mf6YgwWOE
         zd2vzho6GTtSmoVDmwL+uY8cVqt2ev7jP07j+isC554UqLhYMwLy6rkFxAPqs2y813lz
         Pm/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbv9Z+gGHpOu4Lcv5jR0IVBzwjsuu9sSxSsAh5DQqxYRXqHz+p5Wgb3Ots8vdfqaWf8CTbgmvvQdgUCUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kGIWvrGpxnmwJqAHr40LK6DOPrNgseANqv2+BHEj8S+5UXdI
	L3m0AJcDAH32nwCBSeubxmqK16sHhK0fYVnGahU4NxJhJ9QkLCLExlkaI7YMz4qsL9pgSjOLf3R
	q5tn2Fdfen4YWNvqyo1yjBASbekbOUNoMR1a+2IrjUA==
X-Gm-Gg: ASbGnctpnxulroo57z6WOUgp3KdHQqKn7rEVYtWpv1/OxKtEvi7nKdI0ZheE87uLD6N
	HCOfNnUeZ0OZwg3RbCZary8xN3TLo2clLxp4zVSn29uwVVMj60BfOH3XswYFRiAOXysu4/Vi/LU
	LeX9bZDxBn3FH7FaokqYCuAAaAN3f2QpZt/XUvBNm7rtOKBXE4hkGzNKSRlH4Lso1qqDL0Bh/iL
	a/j0n4CrGcKD0SGWU2YzuB74WyXr231oRxqN9dL9ms5iSpBLHBNxCchq0W/mSp8cpDfr3QORWB9
	D6neqYHOs1PemT5iCVPMr3wYspXVDGOUgLTHY3QReN5hjMMKiB5KNyc7BAJ3
X-Google-Smtp-Source: AGHT+IHVrBk8ya7HzDcwr++ObnOTVtnq1sbGBgvTci+3t9R5SZASv4ftQASWh0z/vQJbU2KCgwT2mFvEfsDiwiZ3kv0=
X-Received: by 2002:a17:903:2c10:b0:294:ccc6:ccfd with SMTP id
 d9443c01a7336-2951a3a2fcbmr81603865ad.24.1761990806719; Sat, 01 Nov 2025
 02:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140042.387255981@linuxfoundation.org>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 1 Nov 2025 15:23:15 +0530
X-Gm-Features: AWmQ_bn5F8EySgrsxxev7HP3CeF23tQ9Lh_tPAR7Mkem-yjGp1bdI06dDmwKJF4
Message-ID: <CA+G9fYuqGSNJadcBFCS6VuBrWN49BL+R+8x-kFkmgKfBGzxfNQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
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

On Fri, 31 Oct 2025 at 19:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.116-rc1.gz
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
* kernel: 6.6.116-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2c2875b5e101bfe6ef42655c890d804b3c04abca
* git describe: v6.6.115-33-g2c2875b5e101
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
15-33-g2c2875b5e101

## Test Regressions (compared to v6.6.113-190-g6de03dd48e80)

## Metric Regressions (compared to v6.6.113-190-g6de03dd48e80)

## Test Fixes (compared to v6.6.113-190-g6de03dd48e80)

## Metric Fixes (compared to v6.6.113-190-g6de03dd48e80)

## Test result summary
total: 116160, pass: 98408, fail: 3409, skip: 14040, xfail: 303

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

