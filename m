Return-Path: <linux-kernel+bounces-798170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F9B41A43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817821BA43A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440E2ED17C;
	Wed,  3 Sep 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vY/41Ho+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56162EC54B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892501; cv=none; b=PUaoJDP3nakqq/6N6AAEKScCTdvLQ6vsiC+1nM0N3/1T5k+VBkF7obHtJmdPL2zPUCWZlpixAQSUWIrgu2vUphkBcap4Aq/3TFpO7SZbJkgmr2kmnMWBHl1AnNPyqHkwc56YF7/s4Uz4mNm3mgwRCXr5+MRaACUVGtjU/27NKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892501; c=relaxed/simple;
	bh=X5qyQf22DbH1IYod+3PsYB3pEsfk4pvQaKk6qYflNiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky6oTFuwt8VPI6w6vAbs2aTxkNm2AQ64Q54Dl28NpyJILDt+bmSfIv+TtgNmEnZRh8chW3iJ1UZorrckMf9Sbb1xbPQoOwhlHfy4PzAChAkuRtBWVcanRiUUIbh5158J4owWe5b0ZmKG1qUv3YNOmcUOeoSc3s8hijaWPefbebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vY/41Ho+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso4965725a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756892499; x=1757497299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UoMKbHlNGmTXnkCs4iUjjPCof1fgD5XFokjCFBKuEr4=;
        b=vY/41Ho+gENXx1BjAbirIQnkBcw3GWu+YMjrHR0RQyWkkInHqr9CqRxuXHBjnlhUxs
         VmDcG1xCvUFQpm3TqOOcmNLfu9bf+8cdYRcrdcEsroXaaWVFnKY5/5vMzOjGGEeTvATr
         7sbIW01Ujbxbr0dwbQ/XFrD3oPdHbdSfkAN5E0MqMogXC7TUg4usdJV8pgW2ItfbqVZZ
         rtAbJ7g3VhyJ+ekrmZyzWHdXOyu+j43vsRMKUUCBj4bJ+PF6S4s/f5pAwhJt3J1psZRU
         W+tRAIo1Hpq2hUhtKQLCljCSW0i7jyhJdiF3ypX5C/6cWnEKs0KQnYePTr88b58Yg9qT
         D3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892499; x=1757497299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoMKbHlNGmTXnkCs4iUjjPCof1fgD5XFokjCFBKuEr4=;
        b=ouQzNH89nXIzqeeAtO6oerAYFF76WyKegHS7Q/Qt/f2W4ByJb9Z6xZx8mdN7X33ogY
         oZGVAjdtz+kmWKo/nOZslSBZzVn95uLaPNym0mBAeQTlrzpqpeQuaPZSciY2Mfg+RPXF
         /5O1pfTrFERXBu2Ze7KsPgdPJXK+fP3nKgfM1ymDcrQhsA/cBJmNrSb+1MUyfgXLVoYz
         +QrS9GSCqEG7C7GrSiDWS5iwkeR6VZL6VjAOgOwumyjeFkrEJeLkelCvUu12Jtyaj8pt
         ZYN38Ojzo+3PE6soslQ66T0lvZors9YUuDoi6Tg18Em6Va0H0vsUZsq0VJzQbQR9+lmQ
         ur5g==
X-Forwarded-Encrypted: i=1; AJvYcCVx8AIJ4xZPLsO4rvqqIqhMkH6FopTUB2Ca8TrUBE27TpQII4UhuFeYLyZv6BrydG8qdDoEnxnPjjI6SVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0ZsT6TAwXbF7uciwb4tc0EhTM84XlNsCiIJAryto/R/w85od
	J/idFv3vd56u/NP2E0IGIzg+0faWAMl6HQqSE+j0Eu9M0fKjs+MaqoD2OAj9gUpWkAI+1rqTouy
	lIR9jFuMMAwuIiYfRLXNPSwraJR+tSOIgl9Ucx4D61A==
X-Gm-Gg: ASbGncsXl56cnMc23IpmO45Zft2vIaqjS3nO+XHzhv1tD18zT6VWYnNGe4xkrmM91AY
	Qox8gDmvJCFYSzlJcHLbkzcGQbZADN56IgEAr6KVElnX9ANTQBgegOhsHwYafsvwnP7EgJ1CJxZ
	5ZQwgK/1WMCArWQ6JwdrztkoCk6j83sgTNQzQr6yyabmEzcJZ6pHtj836wrf6IOzNJdiq/jhM3M
	rpKSQ0xETaGJFbsf+WhAcMUi3hnrmVgMzjhqX+jKIAKUpu1f+U=
X-Google-Smtp-Source: AGHT+IFNtimxcRyY/PfCxn/AsH/+0KLjvu7CF4KnB+v7iOQeJU0cUYnhzwPd/MarBMyTmB7aKOrGR3tKLghdyPhBNEw=
X-Received: by 2002:a17:902:dacc:b0:246:2e9:daa4 with SMTP id
 d9443c01a7336-2494486ec54mr168081805ad.6.1756892498999; Wed, 03 Sep 2025
 02:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131924.720400762@linuxfoundation.org>
In-Reply-To: <20250902131924.720400762@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 15:11:26 +0530
X-Gm-Features: Ac12FXzErOtFUn8jcmcJByfeaKsz65msV8WaepA4390E28mrBrhvxK7ANHNvAFA
Message-ID: <CA+G9fYtoKARW00i0ct=M+-1OAWoQhE_rvsS6RJPPQ7YEcZ4C1w@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/23] 5.4.298-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 19:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.298 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.298-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following build warnings / errors were noticed on powerpc cell_defconfig
and mpc83xx_defconfig with clang-20 toolchain on stable-rc 5.4.298-rc1.

But the gcc-12 build passed.

* powerpc, build
  - clang-20-cell_defconfig
  - clang-20-mpc83xx_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-mpc83xx_defconfig

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on 5.4.298-rc1
Bad: 5.4.298-rc1
Good: v5.4.297

Build regression: stable-rc 5.4.298-rc1 powerpc/boot/util.S:44: Error:
junk at end of line, first unrecognized character is `0'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build error:
--------
arch/powerpc/boot/main.c:107:18: warning: array comparison always
evaluates to a constant [-Wtautological-compare]
  107 |         if (_initrd_end > _initrd_start) {
      |                         ^
1 warning generated.
/arch/powerpc/boot/util.S: Assembler messages:
/arch/powerpc/boot/util.S:44: Error: junk at end of line, first
unrecognized character is `0'
/arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
/arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)

Links:
 - https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.4.y/v5.4.297-24-g79c1b3cebd7a/log-parser-build-clang/clang-compiler-single-line-clang-error-assembler-command-failed-with-exit-code-use-v-to-see-invocation/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/329ANlwlmsEF0DVWfAhYuSJx9Vp
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/329ANlwlmsEF0DVWfAhYuSJx9Vp/

## Build
* kernel: 5.4.298-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 79c1b3cebd7a938fa4288b4e4e63a4265bd570a4
* git describe: v5.4.297-24-g79c1b3cebd7a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.297-24-g79c1b3cebd7a

## Test Regressions (compared to v5.4.296-404-ga860ce417cb1)

* powerpc, build
  - clang-20-cell_defconfig
  - clang-20-mpc83xx_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-mpc83xx_defconfig

## Metric Regressions (compared to v5.4.296-404-ga860ce417cb1)

## Test Fixes (compared to v5.4.296-404-ga860ce417cb1)

## Metric Fixes (compared to v5.4.296-404-ga860ce417cb1)

## Test result summary
total: 39592, pass: 30278, fail: 2135, skip: 7024, xfail: 155

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 22 passed, 4 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* boot
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
* lava
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

