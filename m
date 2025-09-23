Return-Path: <linux-kernel+bounces-828444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572AB94A04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B161900006
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B326CE2D;
	Tue, 23 Sep 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AThyBQ/b"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EE23D7D9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610446; cv=none; b=t+P5q0ttx00IQlrYO02ucf9+ioX8u9jRgkikm/N8uWc190wZKB1DLPP0MzEi3xlxKKnK/GfiQqmsFVgm56muJePrRaHyti6/RXYPVRK7O81xcHZ6gt8KsbRD8KpXjtkm9uoDySdLsv4q+wrNy4O/JTDKesFuuA5cpj1foOj3t9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610446; c=relaxed/simple;
	bh=PecQcC4+BQ71O05AhvWFsvUVyIVtp/6jKO4vNBvVtow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoaD36wsyXOmBLFOvdV+HU2lj5eoW3qxbw9Pf/LfPbncj231TZh3n8dyNxeY7SQUZDAABy0hMBtSL7A1BF9B5OZm2tWplxxy3pDaaFIeyO0RtvJe5lyYtw2zaOEoEv1BsOFEfs3k26GrZf7WpwcN3gbWlEPiSBCF6hoHXnYvzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AThyBQ/b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267fac63459so49759465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758610444; x=1759215244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quv8k6pC8nE0ORHmfxh5FwNCkCgEWH1STYAQdnqAQ6g=;
        b=AThyBQ/bW46B38UcyUmYB7fkCSYJ8uT8DMX61cb1Vm0ddVAYMOCP7BayIbFoboSFls
         I7EbNV6QWK03/mX3xLgUhk/EnqQKo1MSIHD3k3mShp7QaTO1lRuUR4zMxDyf/S+gBdZW
         hUs8gyyERlPiA3fI6nS3KxAVycbf9ORDxdbIbqzI09oETSNtOnGO5dX+bWQVM8fHJ+zK
         Yrtc2ebqSBeY2tyFRRlw6BdhQ6WiqekpdIpC92cR85d7EIpBGqQ+3PQVGuGoO/5CxUI2
         r1KM0bKOfNk4RjMYDAp6WDqFMrKpgCprKCMYRhYZ9GCYMmjO7nENam/9MNehFFyGHy5G
         NRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758610444; x=1759215244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quv8k6pC8nE0ORHmfxh5FwNCkCgEWH1STYAQdnqAQ6g=;
        b=lF2j47xmqgJn6+PB+KC7g0d6hpAXZPtJCaZawvvquojYYAxc30+iBIUIqBDWXwCP27
         8oRSbWH6jwKvT24lcLG0SCDwuff3JXQlE/5HyqMDPen9AgggBEypHNCiTRMg01xGLQ7M
         MdasBW82KN7L7mh9IvwSXyre1G2mDP6/1QMcYtPMh86i/goB4wHQ7+Hl7jTjJUMIq5a1
         zuRbbKkJH9wUr647j5zZ8zdnyMcVN7XZyE0CzkNN22FgkRZLqzKSKHjzzKeKgYKTQ2Wb
         Nno7oI6Q4Iw3wLrD1MmIAMZpsK/rruqTwtyWIwsqnBTTbi5/M+GCFLm/H4J8VyDXeseW
         aLTg==
X-Forwarded-Encrypted: i=1; AJvYcCV22XJPa+OOgBflAEYMKPcA9xmcP+o0GU+lptH6KjBEewJ3SBGCPbyFTxGWV2NvAzooqAo2wenFcMk6SRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVBGVGyGe5zAqLCJzKSq+xn/8UvQiskUcBSSIsFEi3Hf0w3A5
	bWOjltLcydp8DgRTLE0YX6EaWPHT7tJ8nQoQVqB2pNtbuPHgdt0cL1OMT1XwmLPTkYTK/A3HKih
	pYNRrtvAE4Ijgz8K3ekoUUKyDIO2PacfX/N5FA2D+kA==
X-Gm-Gg: ASbGncsbG5p0Hq2CIzfVN4gmW/7N68XDsuIQJIwMowEj/nARXlD4xiatnjN0lOatXBw
	bvUojcXeUqrfKbgeftgh3Or6rQSXQ21lknBQ2fOtLIAmX+MX4YLA7W+JI1J1elsLkScQv2Pdsf/
	o0f3wvg280uxZt0qS9qiK1y6LXUyTDCmPwWddbqaDfdkAyXRUkymjtbS0B96LeOh4DiR6QXtmqT
	3ifkJ85MC9irhFsrTWI5LsxGZbLbGaeJ/RZDqiV
X-Google-Smtp-Source: AGHT+IFZS84i47apfj07NDSNB5OlTx6jsX675G3VHWBcxqxxMy1Hh3VbasuQ4IRSHg/XZUTRQHb9JUEfx8v0gq96qyA=
X-Received: by 2002:a17:903:46cd:b0:24d:f9f:de8f with SMTP id
 d9443c01a7336-27cc21f8272mr23361255ad.17.1758610443986; Mon, 22 Sep 2025
 23:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192404.455120315@linuxfoundation.org>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 12:23:52 +0530
X-Gm-Features: AS18NWA_NdAUcwHvfO7RUgz8JOg6_pm8wUdc7xt68AD3PFrIDqYjdPrecl-sjG0
Message-ID: <CA+G9fYuAtATgt4RLzPnVUeyK+4Xdu3u0GPUYqAQSH-904eFwSw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
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

On Tue, 23 Sept 2025 at 01:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.108-rc1.gz
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
* kernel: 6.6.108-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6bd7f2a12b28f0583cde5d70941e17ef05e62d17
* git describe: v6.6.107-71-g6bd7f2a12b28
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
07-71-g6bd7f2a12b28

## Test Regressions (compared to v6.6.105-110-g08094cf55442)

## Metric Regressions (compared to v6.6.105-110-g08094cf55442)

## Test Fixes (compared to v6.6.105-110-g08094cf55442)

## Metric Fixes (compared to v6.6.105-110-g08094cf55442)

## Test result summary
total: 279461, pass: 260568, fail: 5659, skip: 12881, xfail: 353

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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

--
Linaro LKFT
https://lkft.linaro.org

