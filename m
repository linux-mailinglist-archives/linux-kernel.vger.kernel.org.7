Return-Path: <linux-kernel+bounces-798673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E8B42133
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B3A7C025C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28743043D6;
	Wed,  3 Sep 2025 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3Wd+go7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69090302CB6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905605; cv=none; b=Fuaxfc1DJuxizzWa9HNM9hjFbCzzmAgm2CXRgnY5gYu6voDBxDjOK39ztnN/x+4fz8wvqS93cL5fbgXsR7U8FZTXAFVG7gYAySq21aZku81VWOoXwitQ2UmXlFbtI/ewa2xHChD4eruIm+VrameqfNGwv7DMWz+MniE9AJ0GRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905605; c=relaxed/simple;
	bh=MBf+FNCGKxwXMZFLdgqxv1wJ2tqUK75/ygRKEJaaXYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj73V9kt4qEnm1abqL5N0VXRgZCZAPWEgkthLU9Q1t6/wxq9hqpBkrrih21Fs26JwgNV7z1DuH1QJ8ikl+mT8QmlsVuA3WffBcvh5Yu+TXhiYIJUEG6ZY1maNhBg2jNDlwwSyFA5Glu73gaigUDocU1nEI2dF2JCB2OHHFuV+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3Wd+go7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244582738b5so56647955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756905603; x=1757510403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNv0gNy0s2fPL97dDkfmI69n6Su4g4QO35nVtCIF/5c=;
        b=g3Wd+go7IOsGUhTJadcrXlgtX0u49ayGemg7ITi22IzLb9C7wpiqKhWoxss+RyYAb2
         M+bAkGb5yn+QEW0F1959n6Nom8tJmkzYTsqF7SbAZq8qSWaVyR+ZABrF97In9tHn9haC
         8ta/6TbJP1iLW0BjN/QhKD0rHVELUZACV2vVhtirRMbL0aazB0f05HyZRDNH0Biqk/eZ
         9nOO83zkPaWXXh/RiNkW86zV6uH0hQi/e6INzajKDKmgKmONngxerbW0H2NquiIbjk4o
         soKRMyKLRfCYM7DU3b4ZrxmGu5SimILhxz+ZL4ha64L3CJROAoKyjK5vaHVHech7hKYO
         2bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905603; x=1757510403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNv0gNy0s2fPL97dDkfmI69n6Su4g4QO35nVtCIF/5c=;
        b=pDq0zm4o/HEfJVfOY4vRR9GJrcVQNIx2YYuwTus59xDLvXwqTTZZoJiCR+z+dMP2QI
         cf7ojGwzUOeYSVLVKJ7FAFyQsie98j0qxsxNr3YVB4Jpx69HKttc799UgtzpPGg4jSAb
         cDpeAtFEvoUuRiPaFJpasbihYXd3EpStswADzVeg398LOfKCNqVyS3wAJCKwuY4o1s17
         wnTBOKxdoK1cXjRqFunlzZ6+tTwZQ8p0SipNxxozrEXmyPN+SGnJY9uMvsLRarI0KHxL
         eXW2QJRhhsjYib/LwNAUOGL038AM0n0AvxB0pnd3xN54+A37bEuxZaS6eRKp3hLHIs0I
         vCjg==
X-Forwarded-Encrypted: i=1; AJvYcCUewylOm3fllt9gPx6vXGX3xViEjECIU1M41qESSlCskPMtsq19LIvoH8ebxRtejK6htbey+0C7qfQwfvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfhnnLEZ2NyZliW14nuh3+6BWsz79NnuTqSLLEXFD00zqPVvo
	jtsplC4WDSXw/CAle3O/hIOlkvEg7Njr824P5eLvmBPqo7HXAPe0cIq5XKv5enXeH5E31OzoAmn
	oSW1UqJTYyREJ1SDxx1t8Ds3S2L8PfHavnOOZy3Ow7w==
X-Gm-Gg: ASbGncubp96JDgp8Gr6XrcBCql9B4uEl1C1EHR84HxdGgu4BvBKhekyIJJneg8FJjfG
	6IO2VXrmcLInfWcI5njJGgLhKxpLDglN6oCz9n4GmEd2qcRDd7QTgM2FT/07SYIQ4SFKTiojiKR
	mtP0VO+lJwpHDW1bLxESOHd1pCoaxalxE106xmQtqORCcMzPdPkAw1qp8smD0aTIN4qVWc6y/Ah
	kRKoC6A/R6/PyFhTFsn1bLn1kL1aBcff92D52ioLl3q9C6GnZs=
X-Google-Smtp-Source: AGHT+IHdTXE73KoeeFD67NGkxzug3Oe1MMbVqH+Kjq3Jcv+JioF9+0keLKnL4nXRSH3NfQ3WSa62apQ+FE2SJGMwrTg=
X-Received: by 2002:a17:903:1acd:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-24944af0f6bmr215296135ad.46.1756905602528; Wed, 03 Sep 2025
 06:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131930.509077918@linuxfoundation.org>
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 18:49:50 +0530
X-Gm-Features: Ac12FXyFlwPtRrrFcPyzEecmFta83FVyMG0IZbGUnmR2iHwzBgijBa_82EhQWLQ
Message-ID: <CA+G9fYshM788qKDL0cjYOxLJJy-1wd8RRB7Ky8weKA1QWWKvzQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/50] 6.1.150-rc1 review
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

On Tue, 2 Sept 2025 at 19:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.150 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.150-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.150-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cdcdd968ff27439390868ee985f1a70f6d6081a8
* git describe: v6.1.149-51-gcdcdd968ff27
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
49-51-gcdcdd968ff27

## Test Regressions (compared to v6.1.148-483-g3c70876950c1)

## Metric Regressions (compared to v6.1.148-483-g3c70876950c1)

## Test Fixes (compared to v6.1.148-483-g3c70876950c1)

## Metric Fixes (compared to v6.1.148-483-g3c70876950c1)

## Test result summary
total: 226941, pass: 211392, fail: 4456, skip: 10839, xfail: 254

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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

