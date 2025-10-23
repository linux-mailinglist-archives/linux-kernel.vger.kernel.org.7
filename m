Return-Path: <linux-kernel+bounces-866319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C01BFF74E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A88264F29A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB52BE03C;
	Thu, 23 Oct 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZ8B1DBO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485D292918
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203262; cv=none; b=LOrSmrMTYfzUvEH5bS681884O7DsP2F6i3Ix7AbaY75Pql/xyrY9dY5OullOMzjqZ3pu0eeWpvwcnMcYOn4xjJDlxYgH9qcWE1jYID3PaHYfTP78tMd6XVJxbqtQmCLy1JxtbyUeFEBKd+/jaFXCvQjFSzFVel/5azEjUd7eM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203262; c=relaxed/simple;
	bh=/mxlwluWA5Lr00R11HzdOU6uUoGVTmh9rsH/zgvcFLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLSYBoxEL/J7Q26ScThvWg+6c/Rsr4Z5zlzGFV4EaKG0jRqLt5A3BSRWkqnlK5q894GkLG8aX1oE7zwDNgLjyY+GlIJuEtGGe7TyhceifZh8JFlfrS1Oy9RXtNHourhKLp48ZLHVArnoCgqEqpLVyAOp0ULUIQIWcdq9TYywvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZ8B1DBO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-292322d10feso4117615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761203260; x=1761808060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DujqLCJmQFaZ3EINhri++XH5jZbl7g7hKcnWNYi4ETw=;
        b=aZ8B1DBOAlHSyfrKdKe+uoJzh1mPNWeTeBEORh6WOoYby4PYCDzC5K8jKypIxGdtBJ
         iRbaKchAgp76bNZbc2l/gZ1xaJwC55+Ie2FyfwoN7DT58hpPN56Kibp7Mi1RMtsMiBjg
         RozzfVpiZ/2MvO4TCUqzbzYTPhVpYJvdZzRc+ECGaNJLhGXgRiiqQzPk4F/W7vmFPjdS
         /SHJAg+UO8S58JQpPJIUI4wEyPDzFphEDFGlsMiMV2e/iP6iKPRDoWiTv+oy8UUpd98M
         dS35YYWsrNvtbOP+UMiURffB5PtHcJpi35xYfQtnxb74dcfn/1N/uMtJLNJCYE8Bk3Dy
         C6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203260; x=1761808060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DujqLCJmQFaZ3EINhri++XH5jZbl7g7hKcnWNYi4ETw=;
        b=lk9Wxu1xl0r/aOytRuoZTp0j01NX8dJmTWbtRSEfV3WYSGCWGZZr6uIUsxbo7/SMXE
         noiNvcyfhmZmAmcURgVI1Si7AsWMoPAO1FBnPrnpNhVVXJmypG9RIynESNRevDPgnxbv
         FUa1B2XUG1D/EQuQm8wK+VRAu0LlOh+B02sUtHhTsZnt7ih62rM3WphgwawEs72OVdNL
         pbU1sK9VIHo+97Q6lne9TE3xmVzc5YyBrwTFysKx4J6kCCBMfjGOzxpKyqN4APIeK2JT
         jaWc/zGWgTqR3dbOjoWPeVG9kX07Wye6nTwjDRjzB4I/nZHcAdIX4XBhtbhr8lRtXOv0
         6AUg==
X-Forwarded-Encrypted: i=1; AJvYcCVKxVblq20XM7wqMtBbeMOm9M2idxT9BXpwbB1Znc5n829L3YnUYhLjrbuDweboon413HfAvvl0q67u/T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFF+DEAankHxIDht1X8uY9NkXwRGgQb4zhVoVRJQ7nLy3yhk+
	JbgSgvZpFIAG7w1sKLu9x6XoNcrRYrLSZWKeQGt1K4gARjW9B4ksQ2hQsdNqIaRrT26gzoureIQ
	ANQu9YG8650X+0TUYjqn7FA++1qJqjlpjny5hxaOhWg==
X-Gm-Gg: ASbGncvTkJAAESoxLyw6DeLraSQuxAczocxuJ72VBZ08tLnvUiYqIPMeE+MakjdFu8j
	Qj0lrXfyoJZ2UFyd1pKf2kU7G1xufNoYu/uKdUuSn2y5vkZwdYlIWS/MaWaT504fbOqVJz/KO+N
	BFJ3Uhyc/HY+VmR9lmMOfQhZ2RM6oap5iuYhgyWzRlO7Zjz50NVn+0nr4K1KypBsDwqQM1kkkeh
	W9iw9hlYNNm9oz6/Mnwecq+ilpgUGPVbrcgibxac0C0G/DWJfEcvYJM21kSxzb+B0qg1jQbs8nj
	uqp4XCwRuawN3ehkw1tJq0LDGxyAh4anD2yV5wnYUV0Pe9JX578El1Qfosc9
X-Google-Smtp-Source: AGHT+IEVKClhgjdibSHjHuDv8+MSTBfokXQUNOCuEMxiQ2XQOZxNtM5tq3eXuW0OJmRpgx0Z9SIU6xRbql+rNC5mX4A=
X-Received: by 2002:a17:902:dad2:b0:273:ef4c:60f3 with SMTP id
 d9443c01a7336-2935dff6634mr53232415ad.4.1761203260042; Thu, 23 Oct 2025
 00:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022053328.623411246@linuxfoundation.org>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 23 Oct 2025 12:37:26 +0530
X-Gm-Features: AWmQ_bnQgdRMRzTsDLfS-gzQlMvKL6tN130z4WBOHnPtYJNjnFWNDOL8porM-KQ
Message-ID: <CA+G9fYtMUKg8uW6zefPNCU8VnHFMEy8G7Tb_WxTp2Da7uuJtDg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
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

On Wed, 22 Oct 2025 at 11:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.5-rc2.gz
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
* kernel: 6.17.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3cc198d00990d2fccf1413a30fa9ecfa9a02d35d
* git describe: v6.17.4-161-g3cc198d00990
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.4-161-g3cc198d00990

## Test Regressions (compared to v6.17.3-372-g396c6daa5f57)

## Metric Regressions (compared to v6.17.3-372-g396c6daa5f57)

## Test Fixes (compared to v6.17.3-372-g396c6daa5f57)

## Metric Fixes (compared to v6.17.3-372-g396c6daa5f57)

## Test result summary
total: 129304, pass: 109260, fail: 4449, skip: 15595, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
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

