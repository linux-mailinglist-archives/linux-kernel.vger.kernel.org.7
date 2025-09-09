Return-Path: <linux-kernel+bounces-808019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCFB4AC34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7216B3B117A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8789322A16;
	Tue,  9 Sep 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVbAMD9g"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBF322A15
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417623; cv=none; b=Y1+W6auAtDRBv7N3zUf2HJQGgJcjzQ8EPx9IK4JVcys8Xqq42ASpKH2WaqYwFXFqffXYZrRS2EF+8wl4ucFKXhiW8csgonWMnqGCoznqhsC3ZS2pbf3d2owMW0sNJJ8jyngrS0h1n834058cPtquzqvnN/um9piDrTKRR8bhwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417623; c=relaxed/simple;
	bh=9ZJyGW+bKC49GMc9FTX6kKd4h6DpRua6megBj5FtP04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYOAxqr9KrBGCNlP+bvYyt2vWJJJ1mAEyHXS+84m0S72OgskDde0PJbJqoqGzmPzaSnCh2FkJjGbMCeB2WpQRiROkJbejChASfNu6eVY3GZZnC8PgsTMky27KewcK0ZNRD91wJdU6Zf/lj9YWl1pG24yNeY1KjWoT2BTv0VDbGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CVbAMD9g; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b522fd4d855so1795386a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757417619; x=1758022419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSFBZiOEQknXVMGBu4TMhR48FYYjHkmMkzk1O8AklF0=;
        b=CVbAMD9gBTly4MxbqRCH1UDM98shSRU9aCh0bMD5wQ1i3zugDSvB1+aceDDSn9dexY
         khbVLMCltRI31aXyvg9ZOPP7p682qJ2O8FP4pTBmMaWJHneOncCmvYfhjdmE6K/1whKa
         O3FvJWDTt+h0mBAQW7jocTLIzwD6r2uN3FL9PkynAo5us64OZtZ5XqAFZnHeroAj2x+W
         CEnV0djgKElyWAz2v6P7PcBvsm5D4jwQPL9toMZVSq0Ab4iqRCFbpXVI6lkJBzUWrbXp
         QOQzcnCl7CPHgm+iXu08KLQ+HOfQL3I4xKYox27Wo51UyV8SfE9vORAQ8RombZDkPMsP
         WHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417619; x=1758022419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSFBZiOEQknXVMGBu4TMhR48FYYjHkmMkzk1O8AklF0=;
        b=JFBdS2zORV26P32EYmisWjinuwHkksmLdxVmTZQ+7yCmxFFmmHRdJITo32iX7lVYTs
         Av7/spLd6qI9LeJLw9rTOO96EFn5HUe+LECHF+as6exYSwnSd545/L5urqWJEAjyYdH9
         HuO7uYDErSeoJfUZG9iPqKMbjtABP2fdCUes1SNROvpnVPII9dkBfbTWYABEHozh/9pV
         kNSG2IlJx6+CX1IaG8KPyTp3+HLPFUGVjlKe43rltEwPWGWf9Url0rTSVuTfUi0Smnlu
         8wAek3G7kH9bnBXU3TNv2MfJNrz3lm6UnROQXOID9x1vB1XyooQLOAnVA+TCRem2+kBH
         2LFw==
X-Forwarded-Encrypted: i=1; AJvYcCX2n0WJmWUK/22sOlAnWO7h1JWoYMREz7YibK5NjWtZYKTx8uYRx8wUIiQAkwCnlaODaDqIq04W4crLpuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUg3sUblsWLcWCGxm3NAlnOkfGnNZW0Tn2oLLZNGZk2atiA3fz
	ima1HBmqdw6QqIIGDcSa3KoX1D9Z7S9KFZrjP8lBs9zVrojiodaBxi8Zbwgw9ijFIcrGuRofFPM
	QF5JnE0kS2TeSFCz6H4qvodX4EjuTP6wujnOvU4QUiQ==
X-Gm-Gg: ASbGncsovw+kh4Wq9xoaavgG+1uP9ibIfvc2/KRcTPtlLJBxN/xVw6lbEz3885CIk/3
	Cx6XIrsJKOp/H+5JZL1sare2XhnvBQkUpKZfAKYpIjqC8mZK7e7n3qrnaQTojUyBiZnbTcCxfzI
	KxuiWr5X/mmOikbbpSXvIjJvSbnoFvI7M3HVl5QdGiYu9gWurOvrVTXnQHsharWGJsl5u2bfgCq
	jBlwBacX5uu9UlXzJJd0Y3oKrBhHwbz+CWxakk+C3MY+CQFWN1gTCvbVJkmktCuNO1/7EHFeD+W
	659P5wQ=
X-Google-Smtp-Source: AGHT+IGGzAvVlQufG8KDouT3ADlykkEvkBvNGNZ0I5t8cAtFbJmawZEfYX0IP2i5/0oE+b08v9jB58colTYmLhLGcjU=
X-Received: by 2002:a17:90b:1fc4:b0:32b:ca6f:122d with SMTP id
 98e67ed59e1d1-32d43f825camr13296443a91.25.1757417619366; Tue, 09 Sep 2025
 04:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195614.892725141@linuxfoundation.org>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 17:03:27 +0530
X-Gm-Features: AS18NWA8U4mOQRqghtsMgzHRkSzb0GhoojrF8eMm9b0-1tUEHAsdjmOFmCsN3XM
Message-ID: <CA+G9fYtDP_haVwEOz56WHLZm2svRXA9cs7DPHsZ9SQF-sViYow@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
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

On Mon, 8 Sept 2025 at 01:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.46-rc1.gz
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
* kernel: 6.12.46-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c208f589048822e3898fbeda8f5d25df2d3aa413
* git describe: v6.12.44-272-gc208f5890488
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.44-272-gc208f5890488

## Test Regressions (compared to v6.12.44-96-g4459b7afd68d)

## Metric Regressions (compared to v6.12.44-96-g4459b7afd68d)

## Test Fixes (compared to v6.12.44-96-g4459b7afd68d)

## Metric Fixes (compared to v6.12.44-96-g4459b7afd68d)

## Test result summary
total: 332773, pass: 307187, fail: 6893, skip: 18162, xfail: 531

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

