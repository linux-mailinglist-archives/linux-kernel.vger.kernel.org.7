Return-Path: <linux-kernel+bounces-838714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3ABAFFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3448D3BC8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFDC299A81;
	Wed,  1 Oct 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKmb4fO6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEF23507C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314136; cv=none; b=jtIkkXxAW/5ikcxGeoMyxhd8ny/VoGj7P3Jyf018cX53MdHFSS7c9vkjP3lYoTXIZZVTT443ooSUnJki+y2cYG8t4OWTyjqr7bZr2cZxTnn94MjHeY3FCTQ4Q+TJguoQX6UL1JxHwa4DZ0ty8N2vJn2Ip7pOhegW8rZoUkNNu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314136; c=relaxed/simple;
	bh=OTliHX4DjBx+mupF/CV++tI7w3tjBGKObI0txuXqMIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgHtuVOKWRV6cfUoeYbpUB5k+t2XVZFRnoZCjF4E7hi2otBbLXYJPS7Qvbws6ZVI0yBoXgmobPAqciIdu1Klh2JMF2KZHZfWjsz9reV/U5zdnu9z51SFmpfqeIEKnzyAQy+M+iQ3zH1cllM/+BJWX0WPDJ4kABddQVrs5uo8Kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKmb4fO6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso5574351a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759314132; x=1759918932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyEVhMKoRQmspXzhQGLidUHqVI4iIdBM6eUSr/v/1i0=;
        b=xKmb4fO6uA5a+JbzC/SNSRHJsjeBalhSdt92neeRgtaC5UJgH+cijxVfoUOnSjCXkD
         kA1GDWzPUJhKKWaHoelhEIPy0cClhhT0ePYVztdD41n06qVs1FDZa1tLZRxEVYa3BzAc
         73viuqiwtoExMpxwjLoTjyazLtuhwI6BNRwO47aDpGbvddFh5VfLvgKCYbUf83Qz9bvZ
         fRJCtFYEedLhitVC4xB11qBsv9qh/nFMtjaHu3Fk+pQSEpgC5C+nUzv1VuPUnJZ962eK
         PyWylwzVHf3ObR2VD7O/GEYWSn9K0hx+l64PKpWnDaeyhiZ7Jr+t87Qksl/7yoZzVA3x
         RyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314132; x=1759918932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyEVhMKoRQmspXzhQGLidUHqVI4iIdBM6eUSr/v/1i0=;
        b=evNXnV1eb+IrR9XAe4ITY/ubpG4MQK8qNsbiSfDOCbucJ8kwDkZC7XY+mCC/PfO48D
         7H4OJ3tr2aUG0oJ6t1azcUC4lntvtOvWvcFKx9OVJjyiKHmu5sgnPnXgtOkZYxaIXgmr
         p6ueE5IrdeGmInx9NSNnAePXTvuV/VyQ7pGEvLFnh9z0mnlPA01nROVr5LUPdfWEjVNW
         U3Vk27AgrNd2I/yEaok3ihvatLlr1WmZgYWSQ2vFvenUEDn18hyGmrqhGxgxzjNppIxC
         7fg/id9Ysk4PlcglW1o2X8CZ6Fg2N3AYzdtyKms/aWQyqqlSR9oM5QeqRwfqsP6oBqau
         TY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhyjmRSzCw9wUg1ZPYrZ9KVs+Yigyb23mWUY8EOrqxzjwMqlRTqmMAb4CrPzdFsBZZCndJ/Bpt+zcrFNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnam1YziBZtoORq5k4O9UYIB7eqAXqfbT2dongL7Z/MGqH1pN
	ayL6wExsjXnxPQ8+rGBkMtYQPgdPKLPcty2yszFQDjImAA0F5YhcSTGuEcZubrxd7zT5DaywdSe
	nhiUDpziof9oWdXwus0qjqOx+NhycM6xANwVD+W5cag==
X-Gm-Gg: ASbGncsYv/FqWN7+G4nPHmak2hornfsnJb5VeSEP0wKTW+cdQ931N9KAXReTgckXBgS
	MSkkwKRZD8+HFsCapLNU7CGt2tkXO7oZdKf3eSue6HeLiPIENA89kj7oTkA3zqNIWpWa+gAtZG2
	VeXC2w+ejHM4rygV62PfaS/mM/dVmUuVjrhlPrjhgwZfci4U2WSkMcXC06EjbmJVC5QflrqkzKu
	vgVqKsSJP/jrXOzw1pkO6MMvDqyKG7zccVks+vNtU/q5qmsrPoTaE2OiXr4rEOyAm53eKbCmYm5
	UdO4ZrxOK+IR7v/GEpBh
X-Google-Smtp-Source: AGHT+IGo9YrBv9rBn/WWKf2pOXy6IvJ0AZVZCB3CCSonzjEZG/QZC9w1FlI364hn+cBu+gdtSNuOo4dxGMfNqACEMPw=
X-Received: by 2002:a17:903:2f08:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-28e7f2a3ba2mr34511945ad.24.1759314131937; Wed, 01 Oct 2025
 03:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143821.118938523@linuxfoundation.org>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 15:52:00 +0530
X-Gm-Features: AS18NWDFm3YBIpvyX9ximxJERerne8N0kR9urFmXd3w78LNh6kYHsL6Fv75FDXU
Message-ID: <CA+G9fYvsvta0E7hQ84mY9=1aY0z3kypxd2CR-RAtqtkwM9fZwQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
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

On Tue, 30 Sept 2025 at 20:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.109-rc1.gz
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
* kernel: 6.6.109-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 583cf4b0ea80d8f32feb8655c39067ba1da1ffd7
* git describe: v6.6.108-92-g583cf4b0ea80
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
08-92-g583cf4b0ea80

## Test Regressions (compared to v6.6.107-71-g6bd7f2a12b28)

## Metric Regressions (compared to v6.6.107-71-g6bd7f2a12b28)

## Test Fixes (compared to v6.6.107-71-g6bd7f2a12b28)

## Metric Fixes (compared to v6.6.107-71-g6bd7f2a12b28)

## Test result summary
total: 291438, pass: 270254, fail: 6807, skip: 13926, xfail: 451

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 26 total, 26 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 40 total, 39 passed, 1 failed

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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

