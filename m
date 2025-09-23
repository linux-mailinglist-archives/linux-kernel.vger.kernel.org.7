Return-Path: <linux-kernel+bounces-828780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCAFB956FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E5F188F342
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB931D381;
	Tue, 23 Sep 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0VAFkZK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3627815B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623430; cv=none; b=FW7WUSv87sCEnkv1VVRtF35B1r/Qm6v3emxh/Kybj4h60XsTPOhJBL5y9FRiLm8F9UKR3QF83Ze3EoGRGXic2G+20mUJoPCSJ9JrUfI1JiC8aCqijNyd7AenSoWTffgt++0CWC+tJBOFsOahooi67Pvq11hwwX6EtARek7yvOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623430; c=relaxed/simple;
	bh=nQYDG7/ESRE6NVpQ8N3MVFRC1NTmVZPp0DyEPgDS3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr9aIAdYfgwV2Wmt367Jv3TyxHtJCBMiftU6Es1CXsO1pIFRZ6tXwOmZym65MQDr6s2QOM9vf7m3huFp3P6XMxcvFT3i6SBnjMF+SfjL4aMrzYIJekkh1eFjYQFKntv4W4rrZJNkqEIXad8DJCJFFLWGjBuT0T4yAMQAD12OjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L0VAFkZK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3790462a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758623428; x=1759228228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMRYr8OtOqO/HFrezWjaR8f9pLA6E/Ty5wzBOjw1mXE=;
        b=L0VAFkZKYADuCHGrwacw/T3ZPmd7NmGjvJpkskxYCaZaZSssvxrzk6HC0vikqq0Hhq
         Ulr+WKxfMGQCDM4I0FbbqPccU7gLjf0OWl7i4tY4VS80/o74HWhecFQOS1FJCAqRf3Li
         q4rxPNdt9AC9HIFCHh3OVVAs+akJDAHjr+fu+KHPYCKbMUkauZlQja1Jhlxfx9zkN4dp
         5CGzo6FgamGwyRcE2d5DU7d7KRVTndj9ZekbOpz+5Yl7mh80te3yY7H0rET4qLhgP38D
         opf2/1K81A4rQiLwVEvbagspfRJrIMARbMU1aCAEakwqACWOSeMG7OAuMOIBjtO5BUl0
         IiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623428; x=1759228228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMRYr8OtOqO/HFrezWjaR8f9pLA6E/Ty5wzBOjw1mXE=;
        b=TSQM4ZRWEaALy+qUY9afgR5k8uxZNXw50KYOXDz7fT+T9npVTx4uNu557e4WsXnxe8
         HBpH0jPyAlPYLFHNrxWlFrqu1HnU9spG4aeZU+X7vB55k27ZMH3aKLBdnCtGYisT/XND
         CrYowI6LNqG3jWwO2rGmAevh8qwQCBsQpTdTAqbAq8Le8WJTtM+pMnGPIBXBca3CTvl9
         H2KFLSDJE6opZXXNaEZ2hCO48fQoHX+cSEhGpMIOym4/LT6JdOBR5G/kAVkDpuVL9nZH
         uAndMdRvB71v0kP+uqxL1d96fiA7oqm149TgWHxAXGxDm3xCRX/urzLXeoQKD5z4xhPr
         HDVA==
X-Forwarded-Encrypted: i=1; AJvYcCUqdm2t7B8GffAhB4XSgGRlgijFAmBfY0TNqmbRijFlcKr969D63o5UgL48S1+gE1EaV9XkStRrZFklqYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIjY5Tl/9UGji7+fr2YVeiVDSV4UsMSKbFUpYt4sUyklIj8hE
	4QO9DCpDJgmTDyDXfxL5AWGXHZnxlI58kxtzcN/JLxobcFvscHS4YJr58blsUlXITZ1QfSmTnEA
	tfg4d+uysluep89x/vxjshBkt6TV1AdU8yNG0CQCDqQ==
X-Gm-Gg: ASbGncsozu9zHFOgifiPBHFw5BIvUxWN56c3rtPGVJJXp6Xzx/Jm0dv2cJ5b2qHb/pH
	iuFwtMEhuIFL7KTehLRs5+M9tXzPjZvNkxCr/wRJsDp7pmhBYou6x86Sap0NgS+n11Lq9P2zVXv
	yLk/mVa+1kBB/BGh8l06GDwL4rmTm2FsWF1qQvDZ9h//qvqw8sas6sxSSSFo2Se43iDa9DGrUU9
	CtrWARasYsiMTb5E7GbJRzpGXI35wbeTAHdMQdj
X-Google-Smtp-Source: AGHT+IGCbLaovnWzmpLxnAHxOBtwxFY93rFcE1czzzxjsg6cIsdwcN546zJG2Fui5rFNOkdh8TTlG2kvVI6evYMjiRY=
X-Received: by 2002:a17:903:11c3:b0:267:95ad:8cb8 with SMTP id
 d9443c01a7336-27cc874d3edmr25011055ad.44.1758623428016; Tue, 23 Sep 2025
 03:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192403.524848428@linuxfoundation.org>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 16:00:16 +0530
X-Gm-Features: AS18NWBtNIoXbscRPGhjJ8JgJD1DACVC-p7XxDGqa1-ukOiEjaqrJ9qSh5X3TZU
Message-ID: <CA+G9fYujv6g69Pmpr-yZ8fy-P1ywrnhwe7Tip3X1HPPjfP=L5w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
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

On Tue, 23 Sept 2025 at 01:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.154-rc1.gz
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
* kernel: 6.1.154-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bd7dff6dbcf5b16eefef05f2750607b70bfe727c
* git describe: v6.1.153-62-gbd7dff6dbcf5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
53-62-gbd7dff6dbcf5

## Test Regressions (compared to v6.1.151-87-gb31770c84f52)

## Metric Regressions (compared to v6.1.151-87-gb31770c84f52)

## Test Fixes (compared to v6.1.151-87-gb31770c84f52)

## Metric Fixes (compared to v6.1.151-87-gb31770c84f52)

## Test result summary
total: 227967, pass: 212169, fail: 4614, skip: 10926, xfail: 258

## Build Summary
* arc: 5 total, 4 passed, 0 failed, 1 skipped
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

