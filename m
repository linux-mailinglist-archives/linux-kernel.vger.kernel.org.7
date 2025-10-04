Return-Path: <linux-kernel+bounces-842034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1653BB8D12
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 14:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CF3C0D78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF82727E0;
	Sat,  4 Oct 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiQdmp7I"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD6175BF
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759579557; cv=none; b=mfjTJx6gPzq58m9ye7ejklQqtvTKuBJ+DjaURcuce4HvfREtI6m1xdVZUG2N/XgJZ2xPF9d9/3Um95+FMOu7JZRVsmMOkLGZ3wCJT6+AeTLNBwyAhLriPRqTG+UUJp6fdwAGuO71ulq0pKyJG7iBocq7ZBFFXgznwgZaO5ZQ69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759579557; c=relaxed/simple;
	bh=R1q7kEUIMV+6cN8A+xsA3CeTFAvUlbpVDYZvc0xGTlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye/nhiqs8hlyN6KxoIUZYqP8MeAEZjZ4tdUMObhWDk379DKxqOGMxGsykVm69cXMNq5El7mFsMnjZJfgFuX/Xm8g+wRZvG4ix0qnnqd19j2BB1r8qpz/y+abYSatN1pOZ0FmoZ7YrDeBYeeVTacB/ehkfp4m9jt+7GEZYMfAd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CiQdmp7I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so2787644a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759579555; x=1760184355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvMiexLJvP6E79APrj0rLj11cSNtbanirw2a0dqWnQY=;
        b=CiQdmp7ITcH2ZhZvI3wa/Pi8JGKMQoSxglmRg5zbwBWYtLKbgwAeRLCVvKRMQ4miAG
         ++ul+1tJyv/HnRBL49CaAPW8/xSRR5UjR2ni+T4keZb0NtwSM8po3VUTh275bKh7E6Ia
         RwwroV5bGXp4bwqWe0FmuMk60wIP0KxfK2WzBF2mTA5cKNhXhTJLGwR1fv6pD4+FtbCC
         bxEQpSZEu16h85YKAE5853BeAhTdg6tccYK34V9V3WtL6TjmmSchqUls87xRHzbJOeln
         4DHXS6FRbl0PRoBUzg2e+zcrvjqcNCvXT8PfHBFHgbe/YA0CR5mnQq4WXulG34jf05lX
         lp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759579555; x=1760184355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvMiexLJvP6E79APrj0rLj11cSNtbanirw2a0dqWnQY=;
        b=PCziFtZXv2a2oNz5JebVIZ77ql+AdFlkoqO8J9WQafPhcpDIb5V3+uSzolSgbkDO+9
         /QAeLomLzlv5CQAlu4y7uCVM/G0rJI1Aa8NdhRZfsyI8Hql5uly/OQMyPDWb4p6Z8edw
         45El7tVvirsuzdy1Mu5cmidPQLtOo1wVxPhLECEFBVz13EWFWv24jwVXsgY4KZg1QfW/
         VDXl66oazHrbZNXYTgn4eEdJlxXyhXiZh8xnwRUaZivurSIw2bkOxLmvERZWHqQkEVBb
         3W7Z6t8UHdHxbdCXRqv4EDGJ6MtsB/iko/6GV4miQ3TgBHtNfI0r7JrER9vithfPtsZi
         FRUw==
X-Forwarded-Encrypted: i=1; AJvYcCUjwYAl97+9sSRk8PIUgpR/hFbjj7FDoiODA1XG7IYKgH9/6jaGs5iF9RmX8Hz4RBzqkCTB53x9eUFRbaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qklkPFt8FSfLnqZdy/5KWwBztfAF3BxsWUa9xOQ6BRbrHsry
	E2ZtQc7cUIaugxxqk6Ou02m4irDKhzJaoyNvpv11La6KKCnJiiPobShLwkbaLS7Cl5SZ4g/q6iV
	RXDludPLwNgDxWgQfyn6tQm1U+2TWO4lfZwSFW3IvHA==
X-Gm-Gg: ASbGncurlpugroXd+c9l3y6C0hx4lYcFC6RDuogLfPoXzFAmwpVjyptMIOz8YNISidu
	4mRbpYWiIWLUVvEzdnSP3I3iut0svUZZk6Zyic7IDvfhgyoXXZ+1Emz1SvpxEngksFM0dmkZ7H6
	XZ4GKPWKteCN9fPDQwfVHCVBrvVBWsDDnWqSNrsz/5BD/enUaSF/M6hUMdorUC9u3Y3nWquXEa/
	st/EGZNqvJuVVgmUK+1r87WarPPDzGswO8Os+Tr/ZFtuwc7QZHvwRPtwSzec3mTxEtoblqZICXI
	5qDxcwCXNmm/oLiSMAGTY7/D
X-Google-Smtp-Source: AGHT+IHUcUiJvywAA3BHIQxICROug7QzGkP3JuEDSXUGBs+FalO/ecqWea7HGT/2uJb78TWgsqTWeIQtZungiwh66Xk=
X-Received: by 2002:a17:902:e78b:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-28e9a567016mr83165785ad.21.1759579555517; Sat, 04 Oct 2025
 05:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160359.831046052@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:35:44 +0530
X-Gm-Features: AS18NWAObnZ1L7fWSoS2-NJL7inBt0GzGopLp_3E_Hq02ONyESgBFKR13d7cVUw
Message-ID: <CA+G9fYuW6+KiuVd+ONpyo-vWCvF=dSNJzc0cdarBXjNY_XGaAg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Kalesh Singh <kaleshsingh@google.com>, 
	Juan Yescas <jyescas@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 21:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


LTP syscalls swapon01, swapon02, swapon03, swapoff01 and swapoff02 test failing
on 16K and 64K page arm64 devices and passed with default 4K page size.

These failures are noticed on Linux next and mainline master (v6.17).

This test failed on 16K page size builds and 64K page size builds.
 * CONFIG_ARM64_64K_PAGES=y
 * CONFIG_ARM64_16K_PAGES=y

Test regression: LTP swapon/off 16K and 64K page size LTP
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders, bisected this on the Linux next and found the,
# first bad commit:
  [bd24d2108e9c8459d2c9f3d6d910b0053887df57]
  fuse: fix fuseblk i_blkbits for iomap partial writes

## Test logs
### swapon01

libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapon01.c:39: TINFO: create a swapfile size of 128 megabytes (MB)
swapon01.c:25: TFAIL: tst_syscall(__NR_swapon, SWAP_FILE, 0) failed: EINVAL (22)

Lore link,
- https://lore.kernel.org/all/CA+G9fYtnXeG6oVrq+5v70sE2W7Wws_zcc63VaXZjy1b1O1S-FQ@mail.gmail.com/

## Build
* kernel: 6.17.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e7da5b86b53db5f0fb8e2a4e0936eab2e6491ec7
* git describe: v6.17-16-ge7da5b86b53d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17-16-ge7da5b86b53d

## Test Regressions (compared to v6.17-16-ge7da5b86b53d)
* qemu-arm64, ltp-syscalls
  - swapoff01
  - swapoff02
  - swapon01
  - swapon02
  - swapon03

## Metric Regressions (compared to v6.17-16-ge7da5b86b53d)

## Test Fixes (compared to v6.17-16-ge7da5b86b53d)

## Metric Fixes (compared to v6.17-16-ge7da5b86b53d)

## Test result summary
total: 162823, pass: 136895, fail: 4815, skip: 21113, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

