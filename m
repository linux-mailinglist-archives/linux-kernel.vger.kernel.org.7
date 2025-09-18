Return-Path: <linux-kernel+bounces-822590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA6B8435B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A13174C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B522FB603;
	Thu, 18 Sep 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZFqJHXP"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C92F546C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192399; cv=none; b=UxdN0D8WG2A8eJW9bFwP+h8xw4lM/sfR4g/oMSAv/XmFr55+Nuya5+lHUpAhlLSBzp6/9pfkytgy7jtkJXCGFPidzzB5WZBugvnANDuE1xd3NbrKKtOrEkJC4acXSfM3hAXjgeDT9Rjruw/vZpqcqTBBAuHtCIW/6cr6I+gVT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192399; c=relaxed/simple;
	bh=L4JbDnhDjtwgqU7oGyI8Wp0tQ9+SidMIXyVmgoqUs14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2JlNRSyek3wYecde0cld5D6D0KTg9CShcG+0y8PeNvxw3YH+eXFyBmt8yiTN/5g/g0sIVLR3GusmGUYI0SZdj05tI6xsaZoIKUTZ8rf6Kb3M37X1JaZj3NPp1n5Tf0/xGh26YCPffUWBhem3PfbUt/IA9NoxU/yYGN46s+X9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZFqJHXP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79523f3f925so464266d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758192396; x=1758797196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQuP8tyW/V8wc2esEMvJ9lfWJI91lQs/EPBLuMDMLvY=;
        b=sZFqJHXPMX/5s8My7CY6JGtb2aL5AT2FCitvLjo0oaIa92CsW3LHtpAGlsSpf1NbwC
         xC3fVQpF0zadcq/GutLd+bD7V8d8dL3s9STu41KiTvNN4CsEzHdZQnvafbtqr8udzaFN
         Ompt4hm5Liz/CBinXNgXEJ7yYKZWfB+uNn9K/Hrb+A/3pSIPcIEIjsitBskC5Md/nq8w
         Hy56yfk3z0mQFdr3Ou6ih6Jxpk9gL5hTIFvj67WMfXmykLtK30mRspzHGsj2PSsMEx98
         URVpyuMellOj/qpdP5heoTTmX47lxdVnFfWzfs8PZTEm10lZiJzXwEwsFpfMiONximhs
         qQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192396; x=1758797196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQuP8tyW/V8wc2esEMvJ9lfWJI91lQs/EPBLuMDMLvY=;
        b=eZKkTgtdXsRPYPDMDGzOKN+EA521/4C/+OjSZ/GYcbgI2HsVrrpnUyBQA24nQXMZKu
         PtUsJtFzMrAyNMHccGUfXW3xXGB+hlYsAQfuBtt3JEPeF9xIhwQyzSJ0qQTghq5QxT+Z
         uxhe7vhRg/Yt3IgGkGGqbkdA72uHMmUwCritR3bsu6W63+0uC1qUz+lcgne9FowkbM2b
         ioSLFM5PBSocN2IPP11UTpP/huiLvIsBT6fwmkEvgPKcjXbJJd+w1MH/VRHAG2h9tm3q
         CBtAyQudVhkK2RW7sNXWVmO/Kld9Ycsrd1YnLNKSFn3VH7BiXp2FfQLFX7etYN4Trg+f
         WzOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1hA06rHqHbEBEGgzjoozCvtOPxFdgkaEV48Ci/TXgA0C2zleABNCV+PAkP5XQWHHEtys6PMWi30Jl7TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PWnyuPZdo3D8ejBczYFfKGhtHjkE8x9U/VrBHgfzclfw+XTx
	8sW6u4fBOVzI6VpO1Yv4lG6f2JotbNu05yQpkji04Ve55E48S8gUtBAHwA5B0dzyLtPhSWdrvRN
	3KBkI3zDFIwGGtAd6Cl0p6D7u+jMUp941D4Px5G+O4g==
X-Gm-Gg: ASbGncubucQEkNyltxCw8yFwwvEod/QNmt8PFF7f4yL6cSn/g/xflmWg8yFquzv4lKy
	eHjWz9kmPQHdK8iIbYO645yvZK6JOsvhvp4IZkXaDhqPgC57FvSmGQxwaPxOwdst0V0BRUR5aYt
	ypOC77gWzbcAN6JSkNkwQ0bZHmnt+2g90SC4JXVWpTiArj12SCsej9C9QKdDHIC/2OlBGKXF8L5
	ixvO+EjpEJAfO3WvKFTNocD
X-Google-Smtp-Source: AGHT+IHPgE3u4545a3P/yhwjQ/Vlqj4pnjM42gRlznDPvEESbsi6cGfeN7rgabSEQ31Tsd+dW++S/rq0Oaoe1iRa9mw=
X-Received: by 2002:a05:620a:a816:b0:834:bb79:1d71 with SMTP id
 af79cd13be357-834bb791f84mr259400985a.2.1758192395827; Thu, 18 Sep 2025
 03:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123351.839989757@linuxfoundation.org>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 18 Sep 2025 12:46:24 +0200
X-Gm-Features: AS18NWCIihz5Gwu2V23qfUJ3gMn4FzMR0BFfKPMceEfbgqFXePD1in6vpt_Zcjo
Message-ID: <CADYN=9KjeiPF6+TUYt84ctX4zhaQBp8C=Ygq6wKMR3Vek1WOJA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 14:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: fb25a6be32b38a3267e8037fc4bf1a559316360a
* git describe: v6.16.6-198-gfb25a6be32b3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16.6-198-gfb25a6be32b3

## Test Regressions (compared to v6.16.4-327-g665877a17a1b)

## Metric Regressions (compared to v6.16.4-327-g665877a17a1b)

## Test Fixes (compared to v6.16.4-327-g665877a17a1b)

## Metric Fixes (compared to v6.16.4-327-g665877a17a1b)

## Test result summary
total: 338478, pass: 312378, fail: 6637, skip: 19463, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 38 passed, 2 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 47 passed, 2 failed

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

