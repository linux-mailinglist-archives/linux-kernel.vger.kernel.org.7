Return-Path: <linux-kernel+bounces-873888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B59C1502C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30031624DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41620258EFC;
	Tue, 28 Oct 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtCqiNfl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE05221F24
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659653; cv=none; b=IzUVSQYx9nGguknD2pyIy1EHct2wBnBS72NYpe3iE2PWgJr/MduAPQ9p/dP6URxNwI/YWmY/WV/2VhzTnGWdPg3Np/q1eeYqTt+GLbD3PyDKmtCl0fEpNvgxRv8pHShNgd2KhAgsgjodVESbfuwUVSx5k/okJuCSc93OlVwk0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659653; c=relaxed/simple;
	bh=wwK0weIbn/RJkabxgJwj6k1KFxg35yr2QUV0Eztl+2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5g9CnKPAE8F0EjobvLc0AM9URUQ8EVZ78T42AVqoQ5T615B4I0tPn0823tDrqXhpvZKf4+qFm8pNVfrDlSSEQLwOcWvgSVOFL3wpHjRajCfuiZYi3msZshxPrheabX0dhP/jr+iPhh8MizLNI6nW9rJxG2cz7WalLhxQwJWH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtCqiNfl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so88911355ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761659651; x=1762264451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QykRljktm0mc3MCvnNCRxcTfgz7VgLQw/V4DiDkpL8Y=;
        b=AtCqiNfl4HT5M92VqpSrHUe6iroaGm3vULJS0pvAwN95phgot3m3umJBllmQDhPG5h
         VF5j1dZ7aOehhQc3dykufWAlybpaEb4CzZCzRxRBhNgbw8LA7r868EBOyYmOrH9AdEIX
         hw2rXtfFwSyLM7A0lTbQ/AJruT2f5/bPIUONv2WM7cA4ADEI+5LP0WXYu1B7DQHPqdyI
         9IA4NO9MLUPESNVsMbCt9pxi9YPo5Vyqc5lfkWLjGl+wAfU2niBBr5dWPMBCml5Sn2Yf
         PhbniCR/1LqdCVu0oXMmoheSqlvWlanjXgqlZAox6+88xBFPpXTKC+o10IBJp1rmD7uQ
         RnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659651; x=1762264451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QykRljktm0mc3MCvnNCRxcTfgz7VgLQw/V4DiDkpL8Y=;
        b=CN6m3S7ZxWs0VzoH0iU+qLpk1n2J33rQiLlFsZOjipW6pMsaO6qJMJJkuXBgYP8Bol
         0hze6fzbUFiQtngYWsUPNCq7bxEi5h4I5rCueycUb27Y3T55Mq4Sv15TdCmjzcuxnglQ
         vbzckJh9CXUUEcXfDqG82akCZXFdk0mPM7LaoLMZvZmmBZxvnQ7JTL1UkWyIq03Q7JU1
         34mvwlmQ04B67fEFpJyBYLUIOh3Z/3ZWbxDMnyLuRFV+Rbr7LxEpHDLFDiidQroZzlR7
         CiH0XG9RS1KDuqWbX2Q3UcLuQa8XVKlUo6n5ECptYG7HkNH8UNDpM/Ap7IIzVH79HpUl
         /eGA==
X-Forwarded-Encrypted: i=1; AJvYcCWSbwel+pZshdOJaRU2TueyuFBm5jp/whTFXnZGEecvPcLIBWdLqJucvXXsCfEAegiO0S38YjEmHnnl7do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEvW5+DzNnxwOeW4Dx/JzZA5Qc7KsaN63hAdkzAym0OaHutNQ
	4aj1VVDR74rp1WA7EKVEB9UfrQxQM5nX+EWcyZqLxP2+OXhQM06Y8hx8+qlsAsF7X+CFJT0rKjz
	7umbXchLHEiXo3SIfiFKsIZFk+AOHDUZ+a64SqxCqUQ==
X-Gm-Gg: ASbGncsPjwIpLl32F+s6/4WH6qaPedxfjubbh17uOYej9S4QroC9sG7t4XTem3kpWeN
	wVW8ZZXKmfGV0QMwVQZ1Tt3IUax8AiZS/mW0g/u/SXWBDaYoqc6FBVlJb5wEJQg5CEZy+eCnuw2
	bfDQCxI6nU9aIprTi/2EWCP+Mm+bSoDPCpDO8qxnZI4JuYDB5DS2AzHyNuRFAFgXxp3SjkKy5vI
	gP8f10Lkj8g9PZzT/volnkJLMdJ5NKKm8TgoI6m2ni4cnlPLj8HqJ1rrLiCuzlHpIufMtBWQCxF
	BGgqsHm2ZBdABAYihADzyqQdr/Az4ME+fZbQhACmYwpa6r7R0A==
X-Google-Smtp-Source: AGHT+IGUT0qkV3Bdj2hJRPpHT/PCadIoTCU4Ou75DCNinRSDeuk4gg21sOh4WYOhP7ha7zpx4+qR6h80MoL4LWyV2Pg=
X-Received: by 2002:a17:902:fc47:b0:294:db65:4de7 with SMTP id
 d9443c01a7336-294db6559c3mr4322955ad.27.1761659651151; Tue, 28 Oct 2025
 06:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183453.919157109@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 19:23:59 +0530
X-Gm-Features: AWmQ_bkje0OMMwzc6vZt00O0sguix3wBBNGcE3kvzFhV4YtpJR5AvdRehnqWb9A
Message-ID: <CA+G9fYtXU8UjgypJo7oXEXNysMQjohpy5pam3b7gHUYDhyQ9Tw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
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

On Tue, 28 Oct 2025 at 00:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.56-rc1.gz
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
* kernel: 6.12.56-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 426f7f601ca06d40c899834021f62b7cf90894ca
* git describe: v6.12.54-253-g426f7f601ca0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.54-253-g426f7f601ca0

## Test Regressions (compared to v6.12.54-136-gbd9af5ba3026)

## Metric Regressions (compared to v6.12.54-136-gbd9af5ba3026)

## Test Fixes (compared to v6.12.54-136-gbd9af5ba3026)

## Metric Fixes (compared to v6.12.54-136-gbd9af5ba3026)

## Test result summary
total: 122101, pass: 103425, fail: 3993, skip: 14304, xfail: 379

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
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

