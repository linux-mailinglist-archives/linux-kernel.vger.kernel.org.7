Return-Path: <linux-kernel+bounces-671738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E1CACC583
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA255168433
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D622A804;
	Tue,  3 Jun 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnia4+Rw"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35691AD5E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950340; cv=none; b=rooob1o4XBdVNa08j4hfiQHGX7pJZpFs+A69yivgtBMREFYyhxAXXsuh5bhF0YP8Ec6SCM7O9LJyN/CRh5PAptPohgXTXq2rGrb3w35W+R0wXaFIzHg+uqECZB4o482jEN6Q6l2vRh7r1Fqw2eV0D3aNbW7/PG2RKTtoNVwrtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950340; c=relaxed/simple;
	bh=C9gRWlLfBi0YKgBn0SoTcZxQPj4DkPXCPkpzlSXSJqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3SPLBtthf15vy/u2FnLpYdghucqSyehsnqFLT8mowCVHS4ObjG5s8FVa4bjmVh0pQhVwh5+n4phhgHHQ8Gtw96K8fqfcZn8HSXTQtymsrQSSMGpoDiGBvHSpJLh/rN53YTqt/VYgqI/dZLdbgwCw0fTEs26CvcxatScrzjbAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnia4+Rw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5a88b34a6so491816285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748950338; x=1749555138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Atrc7hSG4Wq+YEOtslDiDaD9TR06OeEIkbilhWvmPY=;
        b=rnia4+RwMIZNqLgs2DfZpr5Q6LuUBdGLWAE+f/viVpLHq8q0uvzU7veadLc+SUkI50
         NhjnmtIacvFVbEj4qT8AUxb6bWF/NckNDWkuqQcYRkKaS3hrLv4q3mbdy0kBwIZNqm8p
         lx5RqnkB8/2VMdO6OeU+zoSzM2EdYosyMwLbqLJ/SelBmkbeVUoiLl9NT4cIEx5aRulV
         XqhAtaBli2e4/0nsq6qNULXDkXKSZBIhn8DdXE444i5YSDeFVmaijbMVjwoVxo9qK+p8
         hZLNK0bOk6gsub4vkxT2vWzFtc2Nc2+QRdy8aHI0pnIqrB3Md/+GVRjdrLCUfTag9wax
         ntIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748950338; x=1749555138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Atrc7hSG4Wq+YEOtslDiDaD9TR06OeEIkbilhWvmPY=;
        b=FumbtEZpvwt91I3kNDulNJEWTy2dVsbWH3GrMPPz0ld8r1c9KHVU37NNyHaKDow7Wm
         rtgWpaspl3TQm0X0ODFSNK4Q9KDfLCDzV2M+5isaPCy7QbbbH1byBnJl6Dk1aje3HwwK
         Ag2WRdoqDUm9GJiiDDqkxlh+W1aCjlTW/kLslihlZb3F9o/JNuVxIHqvpHCAsQYaXEuN
         gfkwfPh3JpDOhlRSGCaE/RCEy5OQToAr6f6rbA4QZb/aW6K17nnpbmtf/8wKR/Y5Iftt
         TetM0yxGDl/GZoWnXsqva7EbgUx0Ue7fbS5/6uzzFIUqLOaYXWcObXaFMIjzE6W31dEr
         XoHA==
X-Forwarded-Encrypted: i=1; AJvYcCUmDk6yS3Po7dndUScrbSDLcmBbmaw8F/ITQEzGG3KhGkB5+TYXua4MZ4ek2DMsOQHs7TK7HwR0heUODts=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFVJWxmhFxQ279fm6q3Rg7ZRICt2Q3gMRq0VYCtK9Zsvt7HK0
	cvM8lzPfRW4jgYVVbCO8GYOA0cI+7mdvBvgMCJZm09WMKJ6ZOm19i54nmp+9O6J1oTEuyTWaTFM
	o2BaVn2ofWKQcOR1MJ1mbGQ7jCzjd6otaC2s+JeCAIo3Dh35nDQgWjQI=
X-Gm-Gg: ASbGncuv0RWDmeog8iSqO0YNRlqsZtDrE+ngZFtNihw8B/WaUWsKK2l7Ly0QFtXYJqg
	AEelOUpHcfFKBdORXaJ4dTTpYunX3NYrM/tTXJO1Q9NLDIk6ClV0qc+nCpElWQ1wSP+ngw6cZFY
	tcb1LAHW6pJGylYGzyaPD7vrC0PLs6e9Q=
X-Google-Smtp-Source: AGHT+IH6CJu60GvORvqxJTYPklRaw8iQFScWg5PgSdR9bv70h3hv92ChYzgfJyf3St4K9Fc9ny/UTGzMOdn4NZ36zbM=
X-Received: by 2002:a05:620a:4406:b0:7c5:4adb:7819 with SMTP id
 af79cd13be357-7d0a4af0149mr2061854185a.16.1748950337974; Tue, 03 Jun 2025
 04:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134238.271281478@linuxfoundation.org>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 17:02:05 +0530
X-Gm-Features: AX0GCFt8z_HGqiWFmGilVaVi001nq_yq_XNavx9fqIS6CTpy8M6ngbWXGV8DcCY
Message-ID: <CA+G9fYufqNSo+bhq_JQgEPNo0pKFPhuWQQbmGd8_HOE9LX1-7Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
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

On Mon, 2 Jun 2025 at 19:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.32-rc1.gz
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
* kernel: 6.12.32-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce2ebbe0294cb1fbd36bf75316d94f81f26e582b
* git describe: v6.12.31-56-gce2ebbe0294c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.31-56-gce2ebbe0294c

## Test Regressions (compared to v6.12.30-627-g3fc6e1848884)

## Metric Regressions (compared to v6.12.30-627-g3fc6e1848884)

## Test Fixes (compared to v6.12.30-627-g3fc6e1848884)

## Metric Fixes (compared to v6.12.30-627-g3fc6e1848884)

## Test result summary
total: 309879, pass: 285936, fail: 4866, skip: 18494, xfail: 583

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
* ltp-ipc
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

