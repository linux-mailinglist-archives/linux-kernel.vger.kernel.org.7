Return-Path: <linux-kernel+bounces-828326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49303B9465A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EFA17555D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CB23815D;
	Tue, 23 Sep 2025 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRqcn3ji"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5713D2B2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605102; cv=none; b=nhQ4GV7ys61RgBts+f3/LTRpeGIayOnAVZW9qgMIG1ZbMh0GPHfjq8UsBC9den7x/5NuXBlHfFjz4MjY6fEbncAC83wlOfHhggO2TiCnwQqYs0ZePBWUbN8lpZhLz8UhO+RbkBlxPpRMk9yq6FlqU1Qv0bjEqsS9iVkQ0io8ppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605102; c=relaxed/simple;
	bh=cm9sB6g65hW6yY/FNW4iDQ2FJw7IZcdkRm8PWxCVewI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+6ouBqaG1zGLi6GW65pFknBl5V/pApR9hy4L6V02LhLm0LR2lsOkUKBDtMT2PIEX6C6nhfsUwmQFsdzmi1eBw/AWFf8LZy8ocRYoyA3DxQGzOrZ2TOUHyF4QNNoLG/HjXUUPDfcb3Bdj4ylCV5NB2bGT24mVP8Rla8WivA4a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRqcn3ji; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b550a522a49so4452516a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758605100; x=1759209900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2l2GxVZ4BdK5rUKJmWFIDJCnFKVfvbZhz3z/nqrDFo=;
        b=CRqcn3jiUgxAmqqSaWTbEIpmHuvGQsq26kRj0mSt6uHlUFC0tUrb/17lcMmGahxRnP
         HsFqY+T/3DL/HWBrzdwUqB2BV3GvtJ5Mb+pOsBeqbMrh9rB1pI4DSUbBZDwKlX0sMoED
         OhLgsDdDTmm2LtHmeGMoKTx5sNdYPbPPsfA2h0lNgU6eL6C0ig1diHmWNwvq92hJKA9j
         h9VhtuEjjaLcVgTUGWH9M1eDlaE2+fyoPFdWNFtfpOnaMd68qdd6k03VgFjV340uRY9s
         WcyRRr2Tic73gkHVyZyNp2Quh6S0WyLrydyHVTyUHikMj21TN+jlFn+4d+LzFS58IDB9
         v17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758605100; x=1759209900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2l2GxVZ4BdK5rUKJmWFIDJCnFKVfvbZhz3z/nqrDFo=;
        b=O85VZx6Q04hjwRVJ9hmaOAhbgVYZgvcGob3bRKXn8FZJC525gbkQfYJRssN9xrCUsV
         dePuLz89TLy+0gEWyjiyLlc7Sr8GLAOdhxqfFgqte4rOyDNElcBFw+4GbOBu6oLOedZ1
         hCd7Kre5k/WVmV8psXQtUiUGdXo8X7Li3ttTCkoAKhnZqCTM45BsqebXlg8yI6aP1J5z
         3bpHhtmvbcW/X6l/YuVqIIZiNW16Kvs/1HnUlEnaCBw6rH+gAwPQXNEfo2VoSOBkjd7b
         zrdwhSfOS+pMMQVZXbxEXa8mSwYpOLuytSEArunV6JQTmd6RoEWa9EKCteqf4/5B4BJ/
         a4rw==
X-Forwarded-Encrypted: i=1; AJvYcCUCzuM+cg8wnGGVyRVF2ePaSXL/db1iF4+sfusasdOiz9kIb+iucF2rnIDx13a3m9eZ7yl2KZqipKNNKjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8ygCtEV0wsK9/pTdOmOgU0mQ6cxKX5X+QAImGPsOxbZ5ckLf
	6paNdMSczYyRw+pMLUpM3cWmse66Cv0VWXqca6/wk4R4YJ6H/2ABUJ+vH9+wRZ2g2m/vXKb3ezY
	RoUKpMAHVhbNJxprixLB2HfmgFuUsq8RbPvovJPbDfQ==
X-Gm-Gg: ASbGnctsejkzOt1atR5Rp5fZ+BfP3cKlniH0vIkEXCt/nTl8SZqmU90rdE9LS4cwp+q
	9MZZcgbAmglI/X+U2i1DPZtg7O2Bu4hGls/a/aFQqeT/mX96VfNMLNO0h4mdp9SD8QlIFgqmN7r
	EmmwaEMIdZpPM/NMtb2ZYr0q9tZqTuwniVIXGaGdZT828NalMgMAa8p9V8dR+Jcw7QvPhsmNa7W
	rzeTRx7W9RZZajrkisaM6lyr9i3lVkM16iA4SzE
X-Google-Smtp-Source: AGHT+IEaV7F+9T9RJ1B/iJxOIKWpi/n4+mjOfllQ91nyRkEoBIVGF5eOLfay0jwvAkJUj9Nn3Lo0U/QdY20V8G9vhd0=
X-Received: by 2002:a17:903:110e:b0:267:a55a:8684 with SMTP id
 d9443c01a7336-27cc1572869mr19903375ad.2.1758605100214; Mon, 22 Sep 2025
 22:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192408.913556629@linuxfoundation.org>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 10:54:48 +0530
X-Gm-Features: AS18NWD5DBQhbha1W-yJyIO5a2wFOXqU2hCi554qEwVFhyfdz5r4gIwW28W7lfQ
Message-ID: <CA+G9fYswyv3G0ZvR3C3dM6UuzQyuHVPcjiAwPRHxpmbwuKovsw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
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

On Tue, 23 Sept 2025 at 01:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.49-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1fcc11b6cbfd87e64e99c97c45c4f8fda2192ca5
* git describe: v6.12.48-106-g1fcc11b6cbfd
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.48-106-g1fcc11b6cbfd

## Test Regressions (compared to v6.12.46-149-g6281f90c1450)

## Metric Regressions (compared to v6.12.46-149-g6281f90c1450)

## Test Fixes (compared to v6.12.46-149-g6281f90c1450)

## Metric Fixes (compared to v6.12.46-149-g6281f90c1450)

## Test result summary
total: 319891, pass: 296933, fail: 6279, skip: 16277, xfail: 402

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 20 passed, 2 failed
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

