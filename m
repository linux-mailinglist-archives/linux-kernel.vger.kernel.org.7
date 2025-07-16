Return-Path: <linux-kernel+bounces-733816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCE5B07950
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793404E6E03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97912F2C5A;
	Wed, 16 Jul 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQMl/E2k"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13C26981E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678894; cv=none; b=ejukxdJOs/U0xkc+mGTn7Egt147Gy3Wm3bknTS3FLqBThs5WxgcIB1udWbyl7RzpduejnmgJ4OXbPMM4UpM2aKzSROwPq8nwC9pQToHozGFhFuDrkVNjmHsJO9+dnGIWkXmStxzh4sqhuvpZKJv5Zh7sfh19gxBMAHV9w6Bu+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678894; c=relaxed/simple;
	bh=sJ9F1d7Hm77TJIAltAZf3WHYV/zaIkRNhhbrXivEKVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyrX5cJs5zKTESfGUn/ZLP0kBJPqSTxT7cnYQZTym8VGdh4SoTKohzlaj/LOSC12n8JdbWQPR492iSuWY5tcf8VZKM+GERrLRgNAVOnAEBnELRFHGXF1eg5qAE1huFjdfhy8FlRWJNQVqDw4cpuvz1ICXMXdeet3zjuwNFc35oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQMl/E2k; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c8a5053c2so65054045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752678892; x=1753283692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG1bKPX3a9pOYPMo36U/kpFDDPKBd3jz+ZJQT3BD91k=;
        b=cQMl/E2kfJMRV+KndxYNr3Jh98X/r8OZrhVfoKGSJGtnqa28LJxvq/z4qGRY5LxAgo
         nS2183C7+x/3yqf2mXT/ZXzjuQ4UX3PYlDLFHmmcLx50xUKKLOAA6EEir4fD3waEpSDp
         ZsVEozGBvd6kWDGPsxNpFBztzaZWqoHfBglHOfWYgETYU+d+l6VkYjSzXu1H21SmHkm5
         sSkal/dtFWlizwjGotbCu4OinQFxAqDy66NLLqPGYLE512lCeML0OIBhfHMKFh2cHJRf
         Zi/D4zdAIqu64URrYyinv8p8d80H/JfcE3g3gon59cIRLHUPqKASAa2cveOv2a9krNWY
         VGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678892; x=1753283692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1bKPX3a9pOYPMo36U/kpFDDPKBd3jz+ZJQT3BD91k=;
        b=Ltz4Lj23gAckxYWW46NE/LW1yQyGpfHhOB6VP5jNvFgLFngcBFFTrU8m0INaX+cjZ6
         ziX/0cBQE5KE/bbfFaM4+Ux+wYleS70AD80H16953+m7DhquGSDMqYr3ySn/ADonnKjN
         Wz8lVC8Q+05tH2q1RzcoV/7Z2gbe1qGuQHjYJ0a5lqtfDreVS4bn8pMh4OtP4HSPVHoT
         /5sJxAbMX9LCjgEaCw79tlShtP8blkQMH5QnZ7dBn1qv1HzRPe3LWuiLHFF1hUnMhlsN
         NNp8HJR4Dns/Vr7kjui8zXpRShudl7c0MdSWYVHn6KdGT8r+KqzYBIDX87ZdUTPYH0Zy
         v9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkPJ695SXgPTetiiap8RzpuVqAqHmksAEJyYzT6Sox/NoGGJcQrg6un+G90yvAhukiMuKhpugeRq4h2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5EZwzYiUNDY4cj5+kg9N9YP60eGSyH4lqB0iU+kWv2oOakFz
	ygUuSVgkZfryk/FehaeE2ygT/MLPAj8PDU/i0B3CGTPDHCos7gf5kYgNIE4pcuNE9dCtetJWLlM
	yRQGdRwkIEbOzuhyHHPAXfvICGRZN9hk1FT+ONsRDJA==
X-Gm-Gg: ASbGncsZtZOXj4QGzprvduaWXagyIlzBu/n3ytzrUGTXc3CO1OR33VLKVaTKNqZd98D
	Ys7qCXvGAPDXNkWsiWlRmyEYprkIMZOeQiY5u9jr776HSwoEJEbviW0EnGMOkc3qL5QJ6rStdxi
	eAqHpyo5dZC2AYf07LFRKdEZwiNZjhWWF3ie7l0OtxvFRy5jqMwbESc6MGluAG/DwSEm7rh4gD/
	lcMMC3/yfiUe0gYvcmqE2EljMUvV0MtL+GZGFK2
X-Google-Smtp-Source: AGHT+IFN4fuIIiulZ3MRb1paSNqs6Z2BJ/Xj7EPl0koyk36NfWEbtV/zpTDUJl+uQQQOsVLtU/8WYBy+WKPOX8mi3zA=
X-Received: by 2002:a17:902:f686:b0:235:ea0d:ae23 with SMTP id
 d9443c01a7336-23e24f366a9mr41690455ad.6.1752678891055; Wed, 16 Jul 2025
 08:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163541.635746149@linuxfoundation.org>
In-Reply-To: <20250715163541.635746149@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Jul 2025 20:44:38 +0530
X-Gm-Features: Ac12FXxuAFuQkORwiuMY8JC4Ac2ZwV2xrsQKTzOurlwV1lEs9CHp9_WNBFMoscs
Message-ID: <CA+G9fYutkaN005d8hw17+i-F+TR7M0FOMNDhjMYEvkpsrp0+Xw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/89] 6.1.146-rc2 review
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

On Tue, 15 Jul 2025 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.146-rc2.gz
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
* kernel: 6.1.146-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 33f8361400e7e0f415ad8f93fabab430397bc2ba
* git describe: v6.1.144-92-g33f8361400e7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
44-92-g33f8361400e7

## Test Regressions (compared to v6.1.143-82-g10392f5749b3)

## Metric Regressions (compared to v6.1.143-82-g10392f5749b3)

## Test Fixes (compared to v6.1.143-82-g10392f5749b3)

## Metric Fixes (compared to v6.1.143-82-g10392f5749b3)

## Test result summary
total: 222917, pass: 202922, fail: 4848, skip: 14938, xfail: 209

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 0 failed, 1 skipped
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

