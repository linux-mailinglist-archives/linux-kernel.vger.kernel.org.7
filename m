Return-Path: <linux-kernel+bounces-849085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B8BCF2C0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CB7189FAA0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B8221FAC;
	Sat, 11 Oct 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5kMi6s9"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B13221D92
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173440; cv=none; b=tP2gqeQuzVS5+Woaej23NjZvgDgjfoHLBri10OX1tYkURY388x3AJdOMaW9dbtV3vratLKmM3RjykBNUxb6CoNwuX6UqVvY6dkA5/dVOJvO+XIpX1uLibuyiGraDdPZ5EPx5kXtFiE4aVVzjBjD8YYhUVQuHhhvU1y2N1hz9sgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173440; c=relaxed/simple;
	bh=p4o0vlMg3rayPmvEZ+r6StpN2AzXfZ4MZ7VvyG5in28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Od6Ty9QNGZdOdoaJ5snFTeIY1+DHQB7eQA2dhlbr1MTv+JhwiOfpuoe45SQ+rlENGK9qWNHgn+QVJwdPn987qaWIvJGCnsUEWeQL6e/km+lgrmW+R9FEQnUoMhTI2ncgavrPnJ+AufO+kq+n5RgpHPuYWgOlxVM9xUc3gp+FjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5kMi6s9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5515eaefceso2413546a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760173434; x=1760778234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yri33TAsrDTYHqwIA4g0BnNHEsdzEHDprcYUwbRN96A=;
        b=W5kMi6s9DBxKii/8Dnkv1WsTRiEPRFKcZH4yryt+BWOiel/U4ZjvUv7ui7VGGTRyvD
         SPzDbgXxtw3ZEp5KsnmHTnfxNqbE3OKqFLcalTRBpHu0QereKtJ50ACgC1/2bU7giXFf
         3K4GebdhJ57zowxLYOzYYq2AnxctLKg3lE1HYbWw1AanVlCTDOO760DK6dRVir0S3pxO
         1ndHFozBnk3Qnxs+tS/VSVdbxla/YVAN3Hp8LDZV+CalG59QmztG7y96al4D4iqNzipk
         iAMQSWEby8XHGFXAZ3LNKmgTIVdJm9stlZLC8LHBcSXnl7kEsTOqIZGLHJtJmr5/Rp21
         fvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760173434; x=1760778234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yri33TAsrDTYHqwIA4g0BnNHEsdzEHDprcYUwbRN96A=;
        b=CtCZ64ba5y1MNmno1KnDRz0hTaL2zTJiJ/o8IB99RgGkVwVI0oKs5+C25VYchvbU0B
         dkSLJA0H0KhKZXR6FyCCgXJ9DtlRzSvEF5uw6nkOugT/76S+rNWwAt8V5Ab+GhZGWgRu
         OoEHnm2zqw1IVEPJ2rDvTxAUZ+T3oyVs3S7cH6ua1wZO6Ss1ynXbEXLvAb+QE8GP+Paw
         Yv9ry1e5YgE8hxto21auLbvFftxfrCfYuq6eKvtIE3qXjTD80G3z6w6zTNNVwI3Ndy2V
         OQ8BW8sRYcfsoU0AXvaiuxyr4LKYNywHqqNf6sLvcsNzhL77AnfoTSpvFPFWa6W7pI5Q
         dl+A==
X-Forwarded-Encrypted: i=1; AJvYcCXdmElf6d+U86LD9Pu1vZ+l12yjAMWlrT9G79SozU50L+eyuFsnNcBMrtkH0/yI5UcIwiA6dEWTwWDZ28M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCflA4Q7ik2I/6grat8ymMF4XsEJMV+lFoM6P4YtEWYSk9Grtm
	wAgWSLKotqvEib+hCfWVSbRIPW1TuCwqjleu7KaRiPEUp7MhM85k/cir8NZMwvT0Ae0mhb6p/oH
	JWOPvhsMGcMwncHvNBjsyEUPVPPcxRQVsKOcKZJVL5w==
X-Gm-Gg: ASbGncsBMzHKqAXmrL/hotoAW6452KE72pF5ZKCwhiyUVwjorNXv2BQrHy5VxugGWL0
	sx2Z8qqHrJ6YPzQRI/BsdgNDK6/W9OUho/glp1IOn6KMoQOwYRsb7XqNbHU0ye0ss7gjDpHutbK
	A1bWOGV3aXS5s1FoUZyJ0yF2+SvMYIKQxx2YBZgbeBW9BKx1ALBYpeMateiH6oeXa0ElB8I12ri
	pneoSECpmQ+uNTDukHZ+4Mz62RRbmp2AYgZTT7FMLQi2n2yl3MrmOO88BAhoCQyxQEndOg2lX1l
	JRt2piGEpif+1fDTxZGOGRlrT3HE
X-Google-Smtp-Source: AGHT+IEo5Uyde0HdTIg46Mgc3EqcXiuM1A8u34PuNf1I6GxmDtVoPKQmvw+unuf5pGI573VZJcnBBhHNPh3KrFJA1Qc=
X-Received: by 2002:a17:903:2d0:b0:271:45c0:9ec8 with SMTP id
 d9443c01a7336-290273ecac2mr179583115ad.37.1760173434235; Sat, 11 Oct 2025
 02:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131333.420766773@linuxfoundation.org>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 11 Oct 2025 14:33:42 +0530
X-Gm-Features: AS18NWDBQvhzum4m4HTsjHhNVPJw2a1osUi_zNgxe-rnq14n1mvchBBU1cUGBj8
Message-ID: <CA+G9fYuSvzpfBzJJp_Y0wQL6J7qTK=0mDPpBZu1rMM5s_UhrOg@mail.gmail.com>
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
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

On Fri, 10 Oct 2025 at 18:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.12-rc1.gz
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
* kernel: 6.16.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e006d63d59f243154aba844a31f8ac8afd93484a
* git describe: v6.16.10-57-ge006d63d59f2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.10-57-ge006d63d59f2

## Test Regressions (compared to v6.16.10-15-g13cc90c947b1)

## Metric Regressions (compared to v6.16.10-15-g13cc90c947b1)

## Test Fixes (compared to v6.16.10-15-g13cc90c947b1)

## Metric Fixes (compared to v6.16.10-15-g13cc90c947b1)

## Test result summary
total: 166603, pass: 141637, fail: 5024, skip: 19942, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 50 passed, 7 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 23 passed, 2 failed
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

