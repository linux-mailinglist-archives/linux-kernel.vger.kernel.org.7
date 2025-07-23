Return-Path: <linux-kernel+bounces-742568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4FB0F391
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40CD7B440F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF82E6D0A;
	Wed, 23 Jul 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfVTN3uK"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F07184524
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276572; cv=none; b=KjZVKUT6E/WAwixXYpZNHDoFYOUuRtEVbIh5XHNxngP+wK56smkcdh9RSW8ovsoAAkNvtku/xNZwKBMir1ycphxmAtT909WwybeOaOFN7dfp0sqSypGlB2TLgAkS3ABEpjWSuxJD0yNoaM6wNH0rGyLB9dbdQIDZqzu/+ZwfP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276572; c=relaxed/simple;
	bh=14HmSM8uHW2szgsBvMI7e8oh3tK9Ou/pDBEgGzIuw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c52gizMCDvcLvXmYp2vNi1uLqI/Xe2b+mqi9rbC6Mprrp+GOp8up+B1yCOWH66A7QyNFo17K2JZpMKMMlsmfJw+inOd85zUtBaU4QEJLOtK7sLX0+fFMQYNmTr0FE+zCIBGKn8AP09VOr/IwKFNSBNqkGrRRUYGhuro0uF7rJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfVTN3uK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso5577971a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753276569; x=1753881369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atef1i3VJcAXb2u6WsHsPrsedBDpU0QvJuuw/ePDzI4=;
        b=FfVTN3uK0fjiY9SyzteiPdXj/UfnUuhj0NfMQpovNJMUwGs/XWuoAPyplbHsH6eKyf
         dLgz23dXAwKpnlnqqv/5fM2spIcDdWvCzbsBcxdT9AiSD5+5bXyqcdY52q/JFtGS+quM
         kEWud6i91BJyrsTrHncS4MhTsgEr8Ngc/MNcIt2EwjpZwOEbdHVz9nCu3ltr9yzb30Le
         mZgQFu1vwhW61mDE940DULBk2P48WSlyz9OJiSmJpJNoAcdK755cVZsqK04hLDaPOdsv
         RGLE7tqy8sg/aUwOvrBXPfGrNgy6YRk31TIjrlpyf9gtyZjcfLwA6xoWl9gxN/I+B9az
         v4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276569; x=1753881369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atef1i3VJcAXb2u6WsHsPrsedBDpU0QvJuuw/ePDzI4=;
        b=YSBolF3Y3b4JCX3FUHL1Voc7lx73lSQtNNKRUec5XCbyOt/IU+/eFVmCNtOnASI9VW
         pkHEBWDp8HlTbq9ffltHLqYjMYkATWg0tFFYAT5d16FzS/YlA8VbMKeEt+9ndbDzXDq8
         0cne31wjbXcTbQjepkWdSNbDdn+WPI4qYVplBBMfGPML7NzDE4TZZ6cZLejgSgilGQLW
         vAJUiLG80P5yJO0R7LzFC//YZmAOcJfs8O8mgx3tGFSCDNVoqGxAWZUT0liwr/nJkRXr
         olXBMoG7KRoGY8Maucx37R19D2KHy68+kyS88cFqOCX5+VcLOZSSzU4sjD59A5TOJpSK
         eKMA==
X-Forwarded-Encrypted: i=1; AJvYcCW6MANySBeTUO4h23sQh+8Ah0J/hMFZfB8WGCoBGK+d7/HH5o0Gsohka1W12yOWK1lhFHsrb/bw//pi0/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJo8IvjJ6P9hXAharXu+iaPr7rW3idBQHYOsiUPSH/2ZnOg77
	MCw/yINdLvWhhLmVup1zu928yxgUjVn8yQmAC5zWw7cLnIqrkyszuJAyIGFiD1yA14nQbuWV/Bz
	lqYFMCqEmQYOBKtWo4qsaByyHWZpS6V4l70OKjqV7Gg==
X-Gm-Gg: ASbGncvxeOQ45Cudt0HvWmwFwR1sY394sEEwEVayLwg2vMP0akUBIse0498adudxCl2
	YLVwySo8wvJeq3gAz0udym6d4SKxYLQgKFpf+7gJ7Jp475Ztdo/ElIe/17y5rKw7fMB+V06AXTs
	Os6k9MDbyF1Cc0vqkhL1qz9CpLGUM9EgaHu8HPSa4VEEmTEA4XHy94/aeJ5fcE8JG06ipTOc3Wl
	c9xLw+JusKqBqKpAV55lvCAw5OiZ6s5d2u/lRaxRFJjHY7uIYU=
X-Google-Smtp-Source: AGHT+IEaLWB+Sw4Gbgk3BTkcEgfE8umVN+LG7rh9/lSijCb6BYcIs9Zx0jLribkrVxEXEDf3Irn/G13nDbWE53Wrcf4=
X-Received: by 2002:a17:90b:588b:b0:311:ba32:164f with SMTP id
 98e67ed59e1d1-31e507a987cmr5527471a91.8.1753276568302; Wed, 23 Jul 2025
 06:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134333.375479548@linuxfoundation.org>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Jul 2025 18:45:56 +0530
X-Gm-Features: Ac12FXxdT8wYY-fnDMpXng1kor0UBWkW0MwE1qEUQsgovX9oGjywVgaD-FaNXpw
Message-ID: <CA+G9fYv1FhGq7=dkKZFXnn-ienZ=EAq6miWxoNG1m2GfjFEy1g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
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

On Tue, 22 Jul 2025 at 19:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.100-rc1.gz
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
* kernel: 6.6.100-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b00c1c600f8c5bfccc64c71973fd991c0019b6fc
* git describe: v6.6.99-112-gb00c1c600f8c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
9-112-gb00c1c600f8c

## Test Regressions (compared to v6.6.97-114-g9e2d450b5706)

## Metric Regressions (compared to v6.6.97-114-g9e2d450b5706)

## Test Fixes (compared to v6.6.97-114-g9e2d450b5706)

## Metric Fixes (compared to v6.6.97-114-g9e2d450b5706)

## Test result summary
total: 300504, pass: 274252, fail: 6863, skip: 18905, xfail: 484

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

