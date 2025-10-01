Return-Path: <linux-kernel+bounces-838824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78573BB0393
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DA43B1678
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F762DECB1;
	Wed,  1 Oct 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFpon0hI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC62D9EF9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318988; cv=none; b=ZZkFFzEZAD3htw+Vhims2f5XRB8DA8TxXPGAW76zd42A6QJih370UuJEWMR+popoimUfxRUuZOhb08rm/1oRf0zGsmo3NxDVZI8ga0ROi62nyh8iD9oWWt9VSAbdEN9DVwdDjDD0sKf5brVcBe+hGfGUepVdqIodHfLmShelCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318988; c=relaxed/simple;
	bh=ICC1mpjBaX1fMrY45swyhJyHRGjc72JKuZEGUjPTJjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RscbzS4buHSIB8Gmi5ZZeDC/nrLCKhvuoTP9buvKzbnkLINpwKQbpdF23kMu5XJfrp3rdHWTXWlwjR/MD3du+RIT8RxVl3cRelQ4XlT+NvBHPjZAAghBB4CMPZoVWQMRxWYhb2teTp4wVRj36eYsHmbMb2tNWw8kMQ2dfToMme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFpon0hI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28832ad6f64so42687285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759318984; x=1759923784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M4p9D7lI+yLv3i3nD5AKMya0gsPB40iM48gCdLXN88=;
        b=WFpon0hIl3Vr1CpeTRHW2lBC6hNRI2KI0SuzuW71IHswRi/yJVvnA/6DaqyJWJRiAM
         ulGpbkkk+pt0Bg8JkZo/F/vNOcH76SY2RKJwqYGsft39JyB/taFWigcMon+mjz4EV/iQ
         e4eHfveA32ymH5FDa3nIoTua2f659/a+zxjpvgz4GC6mBH5enggv8UVVcFQ/W4fMYis/
         GUH+QHBTebcnyy5492EJ3YCJO4g060Rspfpw3431MB1ZWHqY/KQE5/geAsiDOOO5vD37
         EDEi9cEoQh0h11yHd4KE08rBek6Vmu9Jt+hQ9jxs1Skie4C3fnLVlQN66vhXfV8Cmj/y
         yI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318984; x=1759923784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M4p9D7lI+yLv3i3nD5AKMya0gsPB40iM48gCdLXN88=;
        b=k5ZoRQc3QlH1U7I/47hDqRY6mT4f5TQxol8Jkg2IBBC8YrWiO1iYLqfJFUEZDzt6JP
         uSpcOKA5XFcVg+w/kq8cTAJyRVlmnh+UNKwHZfEG6M9Ns6fStZazvlMOvUcgN7i5fsia
         nPCQpCtKXdlFh/8Ge+veNuEHBYUzNbBkwM/SME5s7wZvVf2o4qNhwyRGb5zpczdXyHFi
         0ZPrH1sX5dyx7zXvJRi1cMgOEumVAf/lyCJ0r7/oEUUR3dYeJDTvWpgolBNrdlwG5Btg
         k8UYUSKRV1EaDmRmb5sfFIaKDGgxyB87EXL1fFTCLFTBJ4QV5rKpgZ1tmXf5gjJYQM09
         2KRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wuwNl3npFYm5n2rQpIR/LmT14iW+/UogX5uqzQ3W7zBxBMzGob+QF7IieGBusUHqI0+ZJuagEz7ZJwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweq34t6ZQMzmAV2Ev5P7AdiKJx6OQXp7JcGg5n96Bkmi/uPeQC
	p+XOeKh/hcXC/5sBu7FAbWwiaCPlFXq13uTSDW+8aSAI2VPb3TXytuMUURzWy9M9ijQOdsXYNmY
	33y2Esu08QxY0ynI6Z8fMgKt76m5SRMDxc6BJ4w+QgA==
X-Gm-Gg: ASbGncvOA8JeZqpmxjSCfUGjpOoDKdzlxVOAz1b3KfbLmW9bOmSLk/7g0eoISVRAhGd
	3/uaWy5v9dlRVpgL0auEtqjSUYhgCnSVpuyDxND0Yf/XfOIJGqd4NUNucAdTAk2HzX2zeNtwkZL
	4+9+j4L94hBd2KsDiyRSSCULGyVaTCmE4ZjdjfHEz1Oi4HyvBoJCWBhm8y/qTXs/REQ6Po26o7w
	QWA6lrpxAIYWmecTA2lZSSVIbPfUhsCGQIPTRvxjitOZQvHaHtj7m0uTvhb2vLPHzAub2mI6Q8n
	Lo28L60TdTI4cOsyYhzg
X-Google-Smtp-Source: AGHT+IEMbx0M87eZESs9jldV4MdFM4iSP810cku0WLVGzXf8k/U5UFP/ypYIgF2u0SiTMZolotTj1uDJoJPKSAwtYQ4=
X-Received: by 2002:a17:902:f68c:b0:275:b1cf:6dd7 with SMTP id
 d9443c01a7336-28e7f32fe82mr42585035ad.34.1759318984443; Wed, 01 Oct 2025
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143820.537407601@linuxfoundation.org>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:12:52 +0530
X-Gm-Features: AS18NWDxtP73CATq2NXcRu79wLgRRf1DYlwdDx4ErrAk_jQ77dIgp1kcYcZyKK8
Message-ID: <CA+G9fYvrpdXhrUWK_FGbxXcTn3pN1-Hw=qJUjyD1k93C=g6ewA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
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

On Tue, 30 Sept 2025 at 20:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.155-rc1.gz
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
* kernel: 6.1.155-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8a8cf3637b176b7508c3f109c6234a1a6e86d9d2
* git describe: v6.1.154-74-g8a8cf3637b17
a* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
54-74-g8a8cf3637b17

## Test Regressions (compared to v6.1.153-62-gbd7dff6dbcf5)

## Metric Regressions (compared to v6.1.153-62-gbd7dff6dbcf5)

## Test Fixes (compared to v6.1.153-62-gbd7dff6dbcf5)

## Metric Fixes (compared to v6.1.153-62-gbd7dff6dbcf5)

## Test result summary
total: 225710, pass: 209239, fail: 4868, skip: 11344, xfail: 259

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

