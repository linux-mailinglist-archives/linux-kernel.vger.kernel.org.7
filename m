Return-Path: <linux-kernel+bounces-768240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCBB25EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBB57A697E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79E2E92D2;
	Thu, 14 Aug 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0gBMjrG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFC2E763F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159885; cv=none; b=TMkuhsow4bU/7l5vF7ZZtqRRjskozX00agTmqUv0/i9c9YRLAoV9Dyk5nlqEis5SwJirlOPRtExua+O+ksjYuYwD4ykyw6zDriJXhcKr5JvvRsX/fGDbGbYvg7sIL9tPOfxtG62iMZYS0yzT8vypTbYox1H6SqdS5l1IjU55x38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159885; c=relaxed/simple;
	bh=QRuY0xcssAqNzsjoe0+GUA8Ky7ufdADxvjC0vu3O1m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQuZadF2I2iqJOJSg/2DKbYtU9cKqhGogBiOchpCq7dlg87SmfGlVVumMYJ6l9qqXSWMXnOcl/mb/3AOGBO7IkiGm+e7hA1Y/iTO+Lk89P0qtOndY3+gpiFs7yRU6nW4rXYJXuRlT6+qYi5RXUtJF0zQQHaL5qEE28ibZUpPU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0gBMjrG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581caca6so4743205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755159882; x=1755764682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN4ndrkgVneBhF71YXNayTVC1k6fq5rxQE8AAOWHWiE=;
        b=C0gBMjrGoGoEWwSDu9dlfODOYAQEXw6ta3mYFDeqUZenJBwikZtfeDUXTM4CkwM9sE
         VyNXWNlG+8Hpz6yS9+5uQkU1Cn5hxST1QflmH23bNR0BizP9dcji0dKdDucIbaZarXkU
         5So270KWNsJcSF/8hNGSHBRbK4XOCHTDf8lIsAgBz1awuAM3LhrFyqJvaxt8eJc8ZOUF
         Nm57lLEdCdmRHMSdkOlOUbOaCY13V2ia44Ua12HHCiqUJ+5SWiTiotJ34wxYjOUUESbC
         iabESHXFvmMiYmeYlhOmABe2H0dk4HL56Chz0s3aRMjDuNwACxritEreeMvTdeluoXQV
         /3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159882; x=1755764682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN4ndrkgVneBhF71YXNayTVC1k6fq5rxQE8AAOWHWiE=;
        b=Ga67zR985vNMAZ4eSAxLrp3oX3DGr379rhXD8PGBlKyrLElxz2UTnRFKe4FwM7XJpP
         xZOCIZWE6ITKkbnUjYdEH/nBWAneDOvRuDpgpIODRaRjQpU8aGYONy+jVThl4YnplR2V
         JH8J1xayTkQsHXbo9s3KfXn0FKOECr8Oklpc5G0oupiXDuCoEI4HCe6aFN0u/szNII8H
         5h+ovmrF8mAgT2GC8FGzRDG72RRe/ElJ10wHLCPvbPcrmljF8el+DbeteZZtrRa97PJe
         a7mP1JCL/FzErAmo4mArrhHuke8c+bBBgSvC9SbbAckqqGvBF8ALAcyg0G3O0waYlfwK
         Ma4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS9mh9phXspsffNfE3JhwdbAi1vBMo+up1Yj1Yc90F93OkJOB4waT0BE25p36FkzL0LFXjbP6jUDE5LiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pxXMYnnqO4FTQowuDPXgacQ0P7H+AB5ZNpdxVL5x8bYBqmX2
	UmstfwIDOLKkjy1ihFwcZMySxJT0MXF/bo7nVR2EZBC0TzHKG1Ph80iD+7TB2WXaYQergq+9MVc
	Ca4zRMjguMleXEumNa3rxEwq2hJ9qCWYI37L3J7ReZw==
X-Gm-Gg: ASbGncsrlCk1JAwLCP4j1BZelQwHJbsWlAlyn05c5bc9amM066rqAnfTMpBGPvlavBe
	w0xG1nUS87JMaalBNfV2zkLF6r765rEfD4X2TfGN94nolnn+rDtjsYnsh5vr+epHgdtP2uHz2Ip
	WSy4WNdiYJjWiR2VWAZckLFQGiOxBnlJm0iEMnHL3UzlPj5OFiA4qg3S387kwra9/qyAtSMTeRB
	7VoH67Au0/kh0t0GfcvWDAEOh0ImQtURbg+6uyChVrV1qYC37lF
X-Google-Smtp-Source: AGHT+IEQ6olLFhlnuBt+suQ/HYvysyluDH8m5MsRBc9LHDFH2apZD3pSIajpR/6y6fisab/HUr4DU1uJ9Fx/39JH2o0=
X-Received: by 2002:a17:902:da92:b0:243:17a:cd48 with SMTP id
 d9443c01a7336-2445851f038mr40305795ad.17.1755159882053; Thu, 14 Aug 2025
 01:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173014.736537091@linuxfoundation.org>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Aug 2025 13:54:29 +0530
X-Gm-Features: Ac12FXyyGXeSA7vfnwGf0EzVOprDr4qz86gCpoS_15nupDMTeTdNSdzNao3uL0M
Message-ID: <CA+G9fYvMdJpO=qWHh0o0u7qeaTS3-=AF2FgtLgMbRuKQ_5vccw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
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

On Tue, 12 Aug 2025 at 23:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.42-rc1.gz
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
* kernel: 6.12.42-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3566c7a6291d9602f9f443a3e97340103197f811
* git describe: v6.12.41-370-g3566c7a6291d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.41-370-g3566c7a6291d

## Test Regressions (compared to v6.12.40-118-g487cdbecb4dc)

## Metric Regressions (compared to v6.12.40-118-g487cdbecb4dc)

## Test Fixes (compared to v6.12.40-118-g487cdbecb4dc)

## Metric Fixes (compared to v6.12.40-118-g487cdbecb4dc)

## Test result summary
total: 308371, pass: 287741, fail: 6222, skip: 13991, xfail: 417

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
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

