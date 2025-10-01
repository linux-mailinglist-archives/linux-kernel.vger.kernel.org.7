Return-Path: <linux-kernel+bounces-838850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA4BB0457
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5843A3ACC82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB292E8E0D;
	Wed,  1 Oct 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbsonAAm"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D02C1589
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320343; cv=none; b=ZJCIJCfWTUsvDpuEVI2BxQRstspWyswWK2ZYi0Ke+VF8rQ4jeRfZQIoPA874tColkecQZtSCkVSYKwb2/zYsEpgNNlTPIWaZiWSEUW83YGRX1kLOxsuA9Suyuc+p29h0YaGJjpmoZXUJA2J+vP9gIzQVQEaSfZEPrg/+pfaNEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320343; c=relaxed/simple;
	bh=O6vKQTz1eSAv1FTPz9NfRzTKW63iKa3lMOgQwx7nkZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS1D62eou6ZuwFgcMkehvU3wVoQs4xUhOnGqZYNA5PsQZhBMjtXi4m7OSOe2l8uyqz1j+USM+Mp5hk3GAt2dsE5RuGEwr0Lp2rH9GCCDMlkPSh7Hp5XPyOo/BGcZFv0JPk2DCXj3FBDh1SMlATNppPZv+IvU8epNgjnJtQK8UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbsonAAm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550a522a49so6329500a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759320341; x=1759925141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg1GfvybsU3QtTfMcHFEjVchBGwucMjxi7dlwU4m9P0=;
        b=GbsonAAm4IlBqzKMZAMp8NDVc7M2QwYAyLBwQmRGkfyW+1b7KB9ZErGiXAFncxWFY3
         2KxesV0pn9qjtJO75gKC+VZwjvsoMTE+s4Dz1dmQbt9pPw9HvgOpGBIn9Ckrsxi14hpd
         QM7B1UGYr6MnW0lvXPo6HE4+ZaOn7mbJDNfzMl0FFScM/6b+2bhmmtwG9NxbNQEMf4a+
         bpOLUnq27obTfokj8gF39dLcqp8aL4gf2hBK4cY0Aj0AxxRe7TwIzgGDDHWsPfcrFsuB
         qBKpluvlT/jljTSyZLLdiuffHCgWQRBt8diMgRB8ZHnyLIBm6BuNMfaF9Nyd2bmLNi77
         OgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320341; x=1759925141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg1GfvybsU3QtTfMcHFEjVchBGwucMjxi7dlwU4m9P0=;
        b=ULkxnWr2PtouM39FqSUz7clmnDIlJH9pTlM0Zt1EtUJ+6CCgqzUGwhbzBL2MIrCxWA
         cD9VZDyuSxcIsbjwWG1oS0zsjGORtYJQBuM6upxI80YRiK0fGANdz+gEky1t6Ho6rVMJ
         TPKX3c+SuQj/G942Dkriaqrrx8cVCMQ0mf4Rw6YvJYrhQe1+EphpsDLv3yrbUB6rfD+g
         xiBDzFybCzUP10hRlsc9dx3eYsMQWbY9ruch4tw9L2RpdE4sjz4V35858yhE6gQzb4sl
         ee2HOKrNWLns/FBdFG1/uMriARYbpzBdnJSOyWdQgI1tegu3PEMxIX6CP2A1CXZJWUZm
         J9dw==
X-Forwarded-Encrypted: i=1; AJvYcCUEP5mWZQsaJer/4xa8ZEJk/iRgEkDPGejC06JJJYELN36blzeAbcNtpU54sGE1yTHUzn4gKjOetiN8/dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3OLMc20Z9oT1TDmImSAq6UBVubduupsUMDVvSgfWfwFwk9XF
	wM2f5IvH2FnQ/bJYGMqtKi1ycww/n1tmBXhZo6W8xcnY6DWFr/fpd7I6FIdPgUklBk4wsiVGHzT
	CD59MPZ0Qf6loiyhRM3u+ZJvh95uq9GtqekaT18amgg==
X-Gm-Gg: ASbGncsdWauGcexw88VPSU0ma+y13GedTscaO8txqlMM3k3y/1RrMT7AYNLKvd6XNdK
	Ygja79XhDzj/ieVy3silMoLQqwxPv223psowq9wxil0Mu2hBItgyPQAk7iK0qkAzzc+QYfyrxPr
	mD+RtOyy1golhwlrHC4NdbwlP2+1u4C5K8HdpPcoo+pw9mahbMAQ9fOGHk/3xqIBfLRRDYD3dhF
	HSQoebkmnwxQJu4u1pSLRkrjpdpj70UpFYvOIudIIeSp6ySasI+f/QWpCK0g4dAvE5lhaC5Af53
	+Pfm2Qg+77B2bkssIQRWPCR8ggQSByY=
X-Google-Smtp-Source: AGHT+IE+69MJlAegp6HNoWgT69FNLBCWEbG8GGLCgCE5L5FpcTX3fcSAL52w5RW24lGOU0JtgGcawYpVHiKGuzYHrGo=
X-Received: by 2002:a17:902:e78e:b0:267:6754:8fd9 with SMTP id
 d9443c01a7336-28e7f3284dcmr41559095ad.39.1759320340797; Wed, 01 Oct 2025
 05:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143827.587035735@linuxfoundation.org>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:35:29 +0530
X-Gm-Features: AS18NWA9XV18Pou9nUNt_ZdVA85rILDAsVyiyN_bBk1qQqHPGQaNRQnhWQ2ceJc
Message-ID: <CA+G9fYstR1tuG3bQ1MhE8nvqzRmg3bvd9k9xnLXtPJQOcqwUgw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
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

On Tue, 30 Sept 2025 at 20:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.194-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.194-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2e59a3f5f54406d7cb71d75a55df3c9ab93cab18
* git describe: v5.15.193-152-g2e59a3f5f544
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.193-152-g2e59a3f5f544

## Test Regressions (compared to v5.15.190-99-gccdfe77d4229)

## Metric Regressions (compared to v5.15.190-99-gccdfe77d4229)

## Test Fixes (compared to v5.15.190-99-gccdfe77d4229)

## Metric Fixes (compared to v5.15.190-99-gccdfe77d4229)

## Test result summary
total: 55742, pass: 45195, fail: 2492, skip: 7695, xfail: 360

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 30 total, 29 passed, 1 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

