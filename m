Return-Path: <linux-kernel+bounces-873861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B1C14F57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4437426A13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0C13D51E;
	Tue, 28 Oct 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qk4cmGF4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3F334C3A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658982; cv=none; b=swtjGcJvMnzUzGukDB7JJh8sftlnHv+0Nipm6O84VSxGtQtwmI3+hSRkVYnRQg9QIZ5rvApWKsiGbJ7GDQPHk87juWwK2cJb/NsRkhKttaRJ7qjRNdRadgoBgfmJosXITagTsZEhmWcmxo/sRL3ZME/N2WqLuL/sFPnTmP3v5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658982; c=relaxed/simple;
	bh=NkTLesmb1wL3baUpMFlHe2G3W0/q/YxF/pJo68s6F7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQMJWRsSDH7eAKHvzEPiuQRVaUQBQiiWPYtGtvWs+reXevN6uklfVus0uKSVqds7HOM81E5M3VLCeCBKzlzpR9n4lZzIqdmi/0+abnQlmBNCkSrrudQC5oJAgu3cZYhlJhcm+nTsB51c7Cpekz+cfuugvveSL5z27p6PQWxqqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qk4cmGF4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso4298354b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761658978; x=1762263778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6IwLo36G1uBhKQ2BuhOcUno2dP4iNx04KNZvVlCM3I=;
        b=Qk4cmGF4VH0Vm6vWMPQEgWfgoM4tTpVrVy1t43Ddr7MmXrawxUtgvfeEeh01Ew+SyZ
         ce/z+UlZX5puViGXFJFCzx3vxFC0Qr0cqzvao6E0viw3eF+GiYYl3mTuDZNjfTf4PqKL
         IqByUoLSTQ8cCTQYVLiheY8zSUH3PzFOklHAxLOVcCBso2IZAEmtegIRd0ltAb1aczrh
         JbSZgoQPT4rgrUQScfBeOJnLvueuoE/mdAij2KVaAEH566075Rl6Cs2W11+V+NQNBNea
         bdicdTCYHLSItlGpo2nLL288XJDVWnwol2JhIMj2kdm2nXhp+YvxMpRjuzUcli6DD4/g
         FoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658978; x=1762263778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6IwLo36G1uBhKQ2BuhOcUno2dP4iNx04KNZvVlCM3I=;
        b=p0xiPRvGqRLvW/LLOoPx259N56YYxQlEhpZn8QwJyFddjVqXhhdtvYFi4D5tnoeUDf
         gYpD8kY0tLlcJSHQyJIsLFBhzJKAtDvIrk9fz1lfW/b8dHtPmrQxmlbvkHQnq1zAd+vD
         ICZn4SagwBek6fdMjmmiZ6L79f3fxFLmIOXK0PhnZtcn/Wadn6FUVPgQKBacjDTrc5Qd
         aWA0xVvXEakzRs2CMdm85Hl76zZN2bL8GoAiRPZfKJCI9gbHQoFML3xuKXT93lSH+UdB
         3e8hcZ2iIqRxqUU7fcGPsqEGkRQNhspKjF7YRDn5/n6rJVrfktdJ6lU/5I8TlBVVjlMQ
         kPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZk1EVdzrmq8dAXJ2WsNc227YNJiIDdoTkMZOnr49shs7m4yuYntB/gOtIjcBxCm8ks48zyA5dNsqvYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAW7e81QlUidRUzUvQOcwAF5xaejuMtcjK2qvdm7CB+JYNw0Bt
	zpF+n4xKyUdvx4Uq2JIpZg4p3I2rAj4Bm4icyT9DAnMzeAmge5LP5FqsbmKkOExyoJK5N444P0D
	zPOMUzhvYI1vEUiObRLuNNnOg+fGGZlhOPjeWDvY2jA==
X-Gm-Gg: ASbGncsOEugEefdGR3RtjbwJ33+98KyAJZozSDX47weqL06L1ur1JWEqV7y4j17T/Ek
	IoX5SNiOxEAbPQeUxKPKRaWnUhfMDDAyeBFHDVMHZsNKUemHMXgcldXjfl2150mI+c4e3XOEHVL
	PAoj5LSDmHKJtv3zQbWJeaQ/aBkruAjjWSjxbv6/tNmiru3YKxzl9tJeK8h0VSXIgpU9EybzFPF
	3c/rTgHuRw6EhoYzHHpQ1e/sSnVll2C/Z1ml9kmxf4sI50rgW0Zfeg+KVXKLZ6wRSpRb1WpC4co
	X4DFozDGZ0GfKC0umYLT7FNPz9kdiOXJU4NonWDCp3Hq5Z1QAA==
X-Google-Smtp-Source: AGHT+IFOKqumylDC3091DymmwWVMempBrV41yNWr40LgMIQoxbB3YsiPNdrsfBOuzkn9llz2IOW5cx2sNZcESM4Ln90=
X-Received: by 2002:a17:903:2446:b0:28e:681c:a7ed with SMTP id
 d9443c01a7336-294cb5231edmr48006645ad.36.1761658978283; Tue, 28 Oct 2025
 06:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183438.817309828@linuxfoundation.org>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 19:12:44 +0530
X-Gm-Features: AWmQ_bn_DPdFHC2JndhMvloWcakN9sV88rkaOQG3xnnYurPT_LYolUnNKN-lF8Q
Message-ID: <CA+G9fYsQ_riqA+C74mpf6-_zoqyh66kozjFrQmAFBfxqvzoqpQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 at 00:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.115-rc1.gz
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
* kernel: 6.6.115-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6de03dd48e80ed63781bdc986cd9895c1172a6b1
* git describe: v6.6.113-190-g6de03dd48e80
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
13-190-g6de03dd48e80

## Test Regressions (compared to v6.6.113-106-g8ed83e981d68)

## Metric Regressions (compared to v6.6.113-106-g8ed83e981d68)

## Test Fixes (compared to v6.6.113-106-g8ed83e981d68)

## Metric Fixes (compared to v6.6.113-106-g8ed83e981d68)

## Test result summary
total: 105308, pass: 89135, fail: 2925, skip: 13018, xfail: 230

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 44 total, 40 passed, 4 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 14 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 34 passed, 3 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

