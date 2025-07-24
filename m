Return-Path: <linux-kernel+bounces-743904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A3B1052D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F94561552
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4542750EF;
	Thu, 24 Jul 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDQIX3Ag"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1672750E2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347842; cv=none; b=JZE/jjbs5GWm4qH5ZWHYuN+OcoeKfwGi7pnjWrmXtUCjcQasFIGCVBW05M7ITKbJ576dUBJkReuehiBpEQa2u+ZTUDnX7uQcBvWm47GHH9PvT96HPD1AvDH+8l96MdXFYAcpcWjYIb1y2FgWhnsC+c+slygKO4RDaJ3BUw5MzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347842; c=relaxed/simple;
	bh=kWJTwskOGOSmv/NQrgz31Leg1z4OQaq1fZa768ssmlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOF9tbd+25d5J7wkly/PE1MIVfICAP4JYGHbclsf+uiyvWlBMDT7aXykE27NkqCYIJCYmkHmso9YcF5vXxKaH4O0ZjSH8WBiibIENgy9ccMLFLNZdxbEj5LpoOhoyVyyZRI9l4foHPkCxCPckH290LISqLU7Z38b4Qac3Fv6SfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDQIX3Ag; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso638749a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753347839; x=1753952639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPWtuv4lJrSEvpGaLUbqBCZfWpn4k+RWv0aELj6So1Q=;
        b=DDQIX3AgcZdFt3UpS03ir2euDYoeHqLKM+cUiPCJNIzCDhmTiOw67BXcRzzAOPLRi5
         ZaJpOMbzD7Wr8hSxTm57Y5ptxA0j/ueZlSvpHdXNB7gy+eUMX4r9E2NfYx3s7aE4yv7p
         EotCPZjHWEV2vuNUjF+JxLmx4EziYQv+y0JTlT+uJa0OuOopSvq4kt7m0lT0UDwRHsK3
         8sqyicTHLERu3WkH67QGzXo6Oz5jMkeuW5GR+O4wMK8xv3gD56mS6X8haV4QYSDVrOGl
         3UV9vVM1hwKZfMSRlU0pkQ3gf88L0tO5uru7yUww7dOZFtSXeRrVnBHsTaHdP9lsclUB
         wQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347839; x=1753952639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPWtuv4lJrSEvpGaLUbqBCZfWpn4k+RWv0aELj6So1Q=;
        b=c5/ruFufVLy+IYmlsdLWwd2ngkiuvw/OgUORxn5yi9rJpR1NhSsBYTt+vCvgJE7uJ/
         dcAyUIubwW1lG0umylTVYp64XH4Izhc7jmBbGrcEkJ0bbf6Z6AUrXFQ0cPTkgPtfI+eu
         A/O5kqPZziXbe1wgiqXU5oRqVDpwR/hSCb72a1jmpchcdG+mJOA2aZz591ZODnytPqoA
         niEStT0ERSoYu2hxhRLUtL6wO72zzdRJcV0RKrixI7hjJvrUgjWK8FZLsYz9pKqMqaYX
         ztbla4zkcVMlbbAUiD8Hx8A91gz0BAJixtV/gHu0rSG4qgmNmQOgQhvg0eTLdJSqww4+
         U99A==
X-Forwarded-Encrypted: i=1; AJvYcCWtVW5B87gLVeOY4QhWdKeetsoM4rBwMONRdhde9I9b4H2mMIQB3EQAEj5p+WspdrrpOW8MOMyAlaigRcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0WB7ymTS0UsRTgvErpFswQb7dQcY0RG7st0RtuIcYfjRnzS9
	S0JK9aPwiLNVBeDkmgSMFif3N6EAmGRx8flT++ht193IfB3nFXRYDHSItrHoYQQp2Peg6a1xVAK
	EDxie3NbAivIPbKq1OJWj5RXyWskZ62ADXHkOgCJAdA==
X-Gm-Gg: ASbGnctDzV18B3ZPEGdz9Da6XKRvqHpXNX34jcSlpo3KISO42Q9K84P/o32Q7gTd8rb
	secxYEudbj0BoS8sduKnLY48GPqmgzJkC6Z81taiYlMtj+vSzEzcsltlUm45xb9LfxXP8+aLLoY
	5ZEu/UrWGQw7Rm9JOBFwRS6ZxJYCy2ICif/EV3UHOTVbq1VBL0GadtrVC6rA/BbxN2Fa4AjNXxx
	z/Wmk6CppXVB75kVAkcRjKoY2eR7obf8KTFXKHo
X-Google-Smtp-Source: AGHT+IFQuCZwC1KeXNgkUur9CNJFKiakMhZbBzuGLWlcXfAg67p+c2MHmy9HoJGZDp+ZIAF4SeIn13PYIWXKtaoTtKY=
X-Received: by 2002:a17:90b:3809:b0:311:a561:86f3 with SMTP id
 98e67ed59e1d1-31e5079f069mr9091570a91.6.1753347839489; Thu, 24 Jul 2025
 02:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134340.596340262@linuxfoundation.org>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Jul 2025 14:33:47 +0530
X-Gm-Features: Ac12FXwSfwTHUsil6PSiJplqyXKkYTYZxM7m8ENCaVQBaeqVIZ618kQJLz7zxTQ
Message-ID: <CA+G9fYsXDqfR6t8szOBXXd7G1zp6TJ3oU_rPFx0NbNq0SrUZbw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
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

On Tue, 22 Jul 2025 at 19:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.40-rc1.gz
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
* kernel: 6.12.40-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 596aae841edf981aab1df1845e6df012bed94594
* git describe: v6.12.39-159-g596aae841edf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.39-159-g596aae841edf

## Test Regressions (compared to v6.12.37-168-gd50d16f00292)

## Metric Regressions (compared to v6.12.37-168-gd50d16f00292)

## Test Fixes (compared to v6.12.37-168-gd50d16f00292)

## Metric Fixes (compared to v6.12.37-168-gd50d16f00292)

## Test result summary
total: 322673, pass: 295025, fail: 7381, skip: 19752, xfail: 515

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

