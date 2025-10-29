Return-Path: <linux-kernel+bounces-875308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66664C18A81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA04E8049
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935030F929;
	Wed, 29 Oct 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvhtFQ4g"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B730F937
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722273; cv=none; b=Q74ZG9uiDMQpiL6/u1fjupuL32F2YPxCM+4QuFI0QzV7Mkce74slc8+4pkBm7LNstOAsmCEF3MixWBLE/WTRz/ruBhuCqsky62rt+DY4jOTAOgdlH80oh9QHYYt+h44NbUu7axcMZ9YMnA1L4BejJveh2Lr3X24J5mESGIcaCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722273; c=relaxed/simple;
	bh=ykaaT6YbiADc9d9+kOXprtiOstIf3n6+rKFwjMr8+qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brxk/SO14J+Q5Tq7uADZvdCIQgpx5eEsB01n5nz/xwvtw6Og4KQIGKq/ST5VCIVexlScl3sDNQP7xJrWBLJ5jdo7nC1554VnGcFtVmYJAYQToSF3keqtRI5crDLfpAGyRv+YcPFqiODg2G2vy8rDgB405MVsl6X9ma5B0ABovZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvhtFQ4g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so103507395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761722271; x=1762327071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuUZCRhhNRXWt6XeO4ZvYFEtD1drRmJ0SlQlWn1fteY=;
        b=lvhtFQ4g7ZMWarCf6bjSLKN4afTlOomZGbOSgsOAoithWqH9N2S/a6Ri+MrNJyBj87
         1oZU8J/1rA6NBwNHYOXcl7gMe5srUGJRrzYCybQ9hsaBqZGb+2BqYmko6UmhKDiV55md
         6QQon3ZB8Kx52kUyXz8CdCfW+QTbXv6W9F1JaJZ6eMYlkL5xxnPjj/puQKTE1ctp6cdo
         9iNm5NTQADu4Hj7owcV5TVa/MiXvBjmeXLCXQXeK8WoZ/eMBs/QfzY26w6WyJNRwYfrI
         jILMigW7+hRSYDWGXH8QxOAF8YsCBPWjYdhbWp3srfYJRg+iFsV587AGlhYq0a9GgU5S
         mRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722271; x=1762327071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuUZCRhhNRXWt6XeO4ZvYFEtD1drRmJ0SlQlWn1fteY=;
        b=kY2IE1a1aAPlxt/AWss7giAfwAlU/NJ8JZqtO2jBs4bVs3qnqLo8k4xgmVUhJY3PxG
         cZNibntPuRIfW+DAMHL+yb/UvG+R6J0DvzK5WgqYcfN5gy6waKa8ODle8hrsyDes49rU
         kzsHHeo4hWNuHRRzeJR57OYl+idFs0z3+15Q3rM0rdYPDoE79vsbu3hxRiETrli4vLDn
         wdTCK+fLFovfIcVdVLltF6ENz6jX5/sfMZbIWLup+sMtYaHE0UPtd/BgciwO8a80yE9s
         ujTb3keelYREBKdAYOvZlYRYdDIJ0Z8FsNrcUs65PIBSuNHisuABBluHNz1XYUGg2VT6
         zoOg==
X-Forwarded-Encrypted: i=1; AJvYcCVgWgn1UGCF7VXwV+PeytZ0h56RmLnrG2wAgCktnNaOS+ZH08Z6kMxxFhmh/yCbth7HRF8dMzoeWEpvx0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFr3JLqSxo5ErXZn0RuiM2dUA1+2YuWZJds4Lsln3/zn+WyELw
	eIDc/b4C4PX5JZY9eEUkR2uuNpbuuWU5+IcAvIbgDDO+xyr+vZU9KMiiYi054hl85Vf5EBpnlRC
	N5Vhbcj/BKPNNGWMum2i5Lya5XTE5aE6aXmfqxbJT+Q==
X-Gm-Gg: ASbGncu0YsYEVvhwt22cFINhgRQDKNQBtAiq4SsU/4N+5xr2ucSIhYkK8fcFSzCRUmj
	tgYg7GmU5S+P2xQs45xyjMgsYiHTCQimPhYAmntYssDXnOneyBBJv8KmKoF6mTS2wMaBQrlOe0z
	XJAN/DcbAVHkLeF5vvz0s++6UUssg4P9Fn27ktZkddBv/Smvn+5fVkFuqfvao8mFvckQYcAL9TG
	R6QXBBRbA+M6BWo+MdSNvlNgUmFs7l1KRJO2Gc67f1/Nue2+LjHXh2KAus/E0L1rT8R47EUdAXs
	0ENMs0QGHA8CNULLa/m2Vz7MdyQRGLYJJRCQa2UKQXkQGJW35w==
X-Google-Smtp-Source: AGHT+IEvVzT4l6WFVgzJ3FSYoGb6uLgtVt2W5+fZOIl+K9OXMvI8F6nvkIt0kMi83P4QMS0RYXvro6p5vHwDzAUVI2I=
X-Received: by 2002:a17:903:18d:b0:293:623:3262 with SMTP id
 d9443c01a7336-294deec517fmr29410295ad.36.1761722271261; Wed, 29 Oct 2025
 00:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028092823.507383588@linuxfoundation.org>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 Oct 2025 12:47:38 +0530
X-Gm-Features: AWmQ_bkhsv_CfXE6-NmxcSUE1G28maRQK_zSuM7gYEAFQhEmOG1vtJliOgdNvmk
Message-ID: <CA+G9fYvNF1b+5u_ppt+9K4wDD_hNLNfDn9x5V+KnuR1BXDzG_A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
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

On Tue, 28 Oct 2025 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.196-rc2.gz
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
* kernel: 5.15.196-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 59a59821e6b5c0c51b329271616457c39cccc07e
* git describe: v5.15.195-118-g59a59821e6b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.195-118-g59a59821e6b5

## Test Regressions (compared to v5.15.194-277-g06cf22cc87e0)

## Metric Regressions (compared to v5.15.194-277-g06cf22cc87e0)

## Test Fixes (compared to v5.15.194-277-g06cf22cc87e0)

## Metric Fixes (compared to v5.15.194-277-g06cf22cc87e0)

## Test result summary
total: 62494, pass: 51282, fail: 2472, skip: 8394, xfail: 346

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 27 passed, 1 failed
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

