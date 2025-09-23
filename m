Return-Path: <linux-kernel+bounces-828298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F50EB94585
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888D87B414E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126530E851;
	Tue, 23 Sep 2025 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoYon4M3"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962830DD15
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604512; cv=none; b=YBofxBEajldNkGgFIZ79pGhGdmw64TpdUZJRBaT+qSlFa0FpIAtuDMjkw3kDKpAVejDe+n4TUneOZ2nsh9vBCCGZR0jzpRkPYC8DT0s8y2r1zuDhUzJcH7vKbb5GNYB44cclbvDots5eiQf+n/qXd0ub4/Fs6xs/TU0t6vAUEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604512; c=relaxed/simple;
	bh=7xO/w8Ux8Q94lDae1VbNusDmpntZTLs83b9gcG70/VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdNJZMIFKvlwquoqte9TIlvm1AjvZQevOyQpup0M/f5f5RkFRURTfasOiveiIaQRAAEMiGTvP2ojeIlEZiG+b1e45mLstff/Y3WVnDzuezeejR+3Hq/Q1GzjNCS+BRrxdNYH8rbqZSi3vC2fpA/1Nr8l+RKgLb6V7vwrKs0wkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VoYon4M3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1996007a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758604510; x=1759209310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7i9pmTrdIrbqnHasCnEr2Ik3GCVKcKjWftLq0bTHq4=;
        b=VoYon4M3t2GBg4NqusO1L9EIRpWYjrQ5eUCCnxZZooq+qRNc+t+JOYeYxO+EbFHuaz
         v2ocm5+8jrNSeDVo+scdN9/H7xcbcP2aepumnH66QRLT65SSP/qnWjZrrHTqw3qnJ8J2
         GJXKZQWR1+ywzskYPf6AmhgP0GTz5ZZIM1n22gV2qAl3hVTG+/tDsyljJVqHBQJOd0Fz
         BqgAIbAWEpNP1MXiT4WZiVfFs2BJ7CUqc9EIa5pK5wiFf49+LHJVNTuBa3h5p1CTQkRl
         PfN3c+1QP+8hTQ5aQdviRLF4s5lBpA1ydGe3il1MTKUI0VQ6qNME6PkAJUveQ7YA/LP1
         8UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758604510; x=1759209310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7i9pmTrdIrbqnHasCnEr2Ik3GCVKcKjWftLq0bTHq4=;
        b=b08djyk0pQ8RRI1/wJnuK/NGJ8n3tsVbzuf15+rRkvyqMLfoLxIxyWrhr/MFZvB9Z8
         1HwO10MZiJv+K7nFqvMKO7lcfD0An5MsdvX6oYTQ3lqEcFKC9J9a40ujIqK5j+4DUwmC
         7nK2ltJWMwl2Tb+DbWMy62DhUsYk+wOjPdnyZ3dmQd3sNJlGSckiI1IKsTIy9vkRhMrS
         /3TfT1pZJ/eph2LqAxgDygfUVtEpNnUoX0xonOa2pNhN4uA7nKGGuvgUPKsreAoNkWz+
         EfdHR28bqK4qnBYLUmVuL5rNR8BJRVSjTHKwgg1C9cV5MRSeg4LJWoHNDTb/meS70hwG
         kndw==
X-Forwarded-Encrypted: i=1; AJvYcCVOzL0jGQWDCHgO8um0X0tofbNf43H2X//ZaPAs6ittwGbgzRSgfI7T46GDN9N7bdVrRnS8HjOqm27MD5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYj5gRj1ECxNqqXkOO+BHwDIdoOe/4frDUsOZmpLSTV24r+oLG
	idXHx/Qr67o2v6nmgoWDTQWQfN6FHzotVEthJ8u/oEta7s2DGPefhtzWMspcxdAbnEduF0eLHuH
	YSXkScDW5dpA0RJx7cBDKrzHBpwAWvafdZfthQmVrxw==
X-Gm-Gg: ASbGncuGO7EDrzalq+xGDpNoVqLNNsIgKyD4IqlylqhSrh8rgtu+iy1aSJBFLFO9A19
	zVtWFcv3xpFXoUH/cgCfZl5fZh3kVuNfIbVX0xaP44SfPrNltQ0NkSlYGCkmV4qT7dFkT2NJYSA
	P/eGT4sBwC6j3LGtw2so5DkPjhpwZ10ZARXPuALurVdwWVGy46wtlZh752NI72r4ASUHReJH9Sc
	SCGmGJofoRwXTevBivR7EqNWXS6poAjUU9VN79U
X-Google-Smtp-Source: AGHT+IHkyyCZ4aLQZ1Y0xjlVL+qqA0NCcCbmE4WuYZchPsfa/VVDefDXqBjV83WLM8h+6HezJQO1BpZc/a10Bjf4AW0=
X-Received: by 2002:a17:90b:4cc5:b0:32b:6820:6509 with SMTP id
 98e67ed59e1d1-332a92da3bamr1474811a91.9.1758604509894; Mon, 22 Sep 2025
 22:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192412.885919229@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 10:44:58 +0530
X-Gm-Features: AS18NWB826YLcDy8jjmwFSMKmbn-OofuLGovoRwJaNxOpvEac_vZ-fqEi4wyT2Y
Message-ID: <CA+G9fYtNrr62bYOxqG8cXkE1Qv6neuq3CoB6v61SWxzUm6MxLA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
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

On Tue, 23 Sept 2025 at 01:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.9-rc1.gz
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
* kernel: 6.16.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fef8d1e3eca6557cae4f0149eb2071123c473c26
* git describe: v6.16.8-150-gfef8d1e3eca6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.8-150-gfef8d1e3eca6

## Test Regressions (compared to v6.16.6-198-gfb25a6be32b3)

## Metric Regressions (compared to v6.16.6-198-gfb25a6be32b3)

## Test Fixes (compared to v6.16.6-198-gfb25a6be32b3)

## Metric Fixes (compared to v6.16.6-198-gfb25a6be32b3)

## Test result summary
total: 349618, pass: 322571, fail: 6726, skip: 20321, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
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

