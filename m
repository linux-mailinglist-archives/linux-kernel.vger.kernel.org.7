Return-Path: <linux-kernel+bounces-725453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B846CAFFF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDA36426D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187632D9480;
	Thu, 10 Jul 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4l+f0uV"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0942D8778
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143386; cv=none; b=tAm6hoaTjD5kmzJnWz339WTQ1xzj6if1up6YTAz5OFh6MGbR7m1Y6QCJCd1XkyCV3zFVU+e+QVGaH4iw+qggREgs2LU4ChxF1qK5QG8ItupQ6k00XFVKqGqrZWvDjsLjZmgWQbIAEsou56o8n6GwQbnhzjLg6XO/VKW5CShzswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143386; c=relaxed/simple;
	bh=X4dWfCuAvC2u2fIEaHCnRGK8nxZGyEJAfZE0s2Z8LYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcEOwje3ojnmlFRHO+HatHirsO7UnobQWuqFDPTuvUK2gkMcXQDHkPPOBeFKw70RUIO9l7aHXgrNrxwj9ppZA24JOmEPK7VkvOAolVDu2Bh3IrZ8Oz3IEprf2Z53aa/qYjz2rpJa8qR9a1pZoFottxAw+yG0AjXSbCpgefHAs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4l+f0uV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3220c39cffso896369a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752143383; x=1752748183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H5h9tlKdQd4trkg6e5cY1N3SXg7n3+0oZV2U7x4PRc=;
        b=F4l+f0uVNFqvSxhdvjHzPmBjaIMO1mQKAi7sg6HqjnJLMkWQm2I+7UvlE5luTHrpKj
         uh3t9WvkejVhqEmfMjCc/I78fMR/WoZSoeebCvQYaEUB1EOrglrKqDnBh91hDY9IDcEj
         crzNgwDsZ6K2deweKvZsX295LCeMfuSvvq2yJVO1xU8Ok2ZBEea/ijt4f2JHEpOBEChl
         VmX99ZBmOsmmYg+Mvnrqpzz7MJBNPGIFRhOROf5LE6mKaNufT9LRVt7gCSZWhHDacxa5
         zY7FpiI/q36fAuy9I9R9IIsImZXEKGiLLHGe0VFYVjemMbokPB+JfSVVxULDLCZSoEkn
         ZkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143383; x=1752748183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H5h9tlKdQd4trkg6e5cY1N3SXg7n3+0oZV2U7x4PRc=;
        b=RznQViBiUlAjLdNd+jFIX8cdMK2NGmFgYLNmcjG1YRgLRwxnbeEKmWXT7G6mQr6gfH
         aBiHbHRhdV74c67RUuCZeaCQHy3Y50VpBle+G2JU1HntDqSRoyqhXcoqh0o3Bg8Pd1HQ
         6frM2JEMNGL+Rprxn1HQUxzELC0xkf4rPBqk2cclx8BxI4g4T5pilPrUGfZSsz5zo9AR
         /2ojGKIruT3j2x8uv0qwt+F6ejxbQoARLrk2WYL/VLhB/ckvaBNRCyK9emc684U2gL7Y
         sLYCg9C/10xUrYdtyc7FBrLGgRRaK3dedDJwkUBQhDgbyguylxNE8W2ea/Mw01dxMhEJ
         64bw==
X-Forwarded-Encrypted: i=1; AJvYcCU0hq6voDf+TpobX52pvsWTTXhygYAsI7MqyjXdu84W6/ApczndAcNla9Pjy/UuMNdbzd6smVlENP2s5AE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh9IJCjFUBTTKfmhJaW35BywteV6mlcaBH/WadOs5LHfZqJTK
	cnW+VVIXKSpt1e58ywu63A5lDueokr3nl9hYa6MSnQKAjHy7kvrjc8ubhp+kO8wM/8iGg5/0B1o
	YvGlpgZvQefHMgM5imKGtp4aqKMgn6AgtDEVjn//MOg==
X-Gm-Gg: ASbGncsMQoR6FhrkiPGFxYh7WMliyJ1yANspR4PoBoZsTroZJg/lTqcHDiqUsowqTn/
	Ys+ePjpOiwqkGOZJawvQ+rLp1KyBX2xFin2q8N5E6LX715xPYleYp1+2ASVjxwVOByKMJsmyyXS
	VmJS8tuIRVPg9DtxVAbZor4iww6z9N+snVN8d9p9nMLjgZo/AP2UqsHQvZBn/ZQEm0UrXAoDuxH
	brW
X-Google-Smtp-Source: AGHT+IGTPRflc71ehM/erqtBSBvrbFlDX7EuK4Oc4DS8WHD5He8D/ywhaBNzOZQtlE1/7Ffka7swie+za5d+pVFLbPg=
X-Received: by 2002:a17:90b:5344:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31c3ef2308emr3235696a91.13.1752143383085; Thu, 10 Jul 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708183250.808640526@linuxfoundation.org>
In-Reply-To: <20250708183250.808640526@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 15:59:31 +0530
X-Gm-Features: Ac12FXzL-Kg4EgSJdYxYdn7rWZRJkNLFNrf7e6muOpwhA3-sOwMlQSSbxtPvCY8
Message-ID: <CA+G9fYv0z4NJxEyyB2mtv5f8GThcvgE1bbcvhQxGCkGAVDmt-A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/149] 5.15.187-rc3 review
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

On Wed, 9 Jul 2025 at 00:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.187-rc3.gz
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
* kernel: 5.15.187-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 09eb951d49e58b88552e5054a2c1dc20ea1f1504
* git describe: v5.15.186-150-g09eb951d49e5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.186-150-g09eb951d49e5

## Test Regressions (compared to v5.15.185-412-gcab978569923)

## Metric Regressions (compared to v5.15.185-412-gcab978569923)

## Test Fixes (compared to v5.15.185-412-gcab978569923)

## Metric Fixes (compared to v5.15.185-412-gcab978569923)

## Test result summary
total: 54782, pass: 41945, fail: 1996, skip: 10559, xfail: 282

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

