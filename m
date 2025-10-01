Return-Path: <linux-kernel+bounces-838853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58174BB046F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BA24C103A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8372E92AB;
	Wed,  1 Oct 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWh0XbZN"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989E2BE036
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320458; cv=none; b=NZOn6ET8MZKMAeBfPzseHcIWzmYpi/YfX/SheDyjmGHSworN0yRNinm0pIaQ7nrn7nlSrG9qazSCDD+PiN1OtwScbr25eeqwOEB5YBQpJN71JYgNZ0nEMR9eIiK/8b1U0D4ArLH6eNdM06PyMr9yaZV+0fhwE8oBL+XhK5r+N9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320458; c=relaxed/simple;
	bh=KLwS60J/8+RWtqASMttEKYh5KohtFJsU2BRcSHzWDes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9LqP4stCvBMV1LBHUrCyH0wXzbYZvUOJU8BLlLYawjYJnM8tAnyZpoh6a9wokixsPHpzbbi0AJTTnFO5NVOwBGSqnBH9Y4yxNyYugeifEuyNN2pfjqtDJ6YQxLQDDbEbY+74Jfrqabk0kw2ydFeb8uB6ED8t1soZeyz53n4yLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWh0XbZN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso5116606a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759320456; x=1759925256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxgZeKOlcJQk5z15C3qUg5xdCnQ+kVOlBtf4/nD8Hro=;
        b=fWh0XbZNUK+bi6Y993UtqqNRuyFCpDIm3eo7vFg7DPXRfsq7UeU+sp5r6XiOkbJbkV
         ahtCLos3Js3uvnfAWhI5egmSVK1h032M74bC265+Q/WkP8Nxi3P4tKXI8SeY6EMXcJOr
         WL1DGhMg4D/2qIz8UsZj2r9qf99NSFdp6U/EH3iYliZ4NzXp+4ZDb39c6UAWEQLORyAx
         0uFLmpzFyneWT4dif9CFQouhlTkHmZyL5IYoQHyyyfftaYZzqkO0IjuJxsWa59uWKdzR
         eLxpSLYHJC826/vITiQ2jA9t6eh8j+w0wPtMSqYyW3p1knueeZXeTSMDHuPaY3VNi9Bn
         hTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320456; x=1759925256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxgZeKOlcJQk5z15C3qUg5xdCnQ+kVOlBtf4/nD8Hro=;
        b=FN4kMp9G7IhvpghUfqs7/44ItLW3ZWaKaVaVGikIqZDDngAxFCWH71GpIQRCQYoxoD
         ZKUZzMh6N1bntkmC5T0+t69BevuErUcnFPsdemwkogHPFUEA+hdWmtYYrh5NcklQIXS4
         BY4/S2CbnNCBAS+8RqZt1A/6enHbJvjR44c6Dre9FyI6JswHCEYteJ7B2fkjZfbubBSy
         ezkQc5R9ZkmyjbQDSZ11H4M5OO+IQHZdQ2bmUxIl9qg4D+ZPQeojIECAss/Cb1FWWzWd
         ZVju4Tljh0zA61ZCNzKuljPWUYQpxG9p0GaykITCMZPWkRtjlJHsZ01JX9wpFxZFhIJO
         QMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqaCyB3MggcC2XugY++7X78STWoIo5Plb0gTak0jMyfOzZuma9pfO2+MaXvV8vfAhxtE7tRdlJWDkOobI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCP14uoDn7Gr2URRZy3PnNeXBbQlLKhuCxku2qvAKQQbtjYVh
	vIAI/rmyW16SBZTSz/IP6xW66NcG5vHTWzat8EY/8YTH2L+U1lvwuc7gZ6eoQTjCWz+8BlaGSSj
	CW/TAadzPvf6HwJnpPaullZjR8XHSHwGnG63jIYLoTg==
X-Gm-Gg: ASbGnctAk6aoPCsVyjtkBx97qM2A4+wVT9q95pdM0bxuNFq9KDHl+qrv6DtNS7e6pUO
	DWmEEnGKEGaHT2Kyg2x/jBkZ3sX/4K2EoTBPY7uJfG93R+iJIAgxmke7BaXDcwUeIQcrNHb9nsI
	MB94pX1UeyrqiN+kTwLSSx1qdhTUF298mIIZHzp6wcUl6JFeCUUMy5lIicFdYPe+oCrKiAJqy+f
	4x6vRub48EcxpK1l+B/Uu7nag9pgYPFQE5y0a/sMjz0DuRNH9id4Bjgsrxmjf+/g82cswawVSsr
	0WriS4IJcUY0MHyKk9W4
X-Google-Smtp-Source: AGHT+IHL5VH/dDJwfKusXYhYW9QvidSoHEl+++jEYo5wsQBw18GkBcB19ZLrvyu+Gi6i2SHaHAm+a1Ojo4jVT0crWYo=
X-Received: by 2002:a17:902:c406:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-28e7f2a10demr45520025ad.6.1759320456078; Wed, 01 Oct 2025
 05:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143819.654157320@linuxfoundation.org>
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:37:23 +0530
X-Gm-Features: AS18NWDTltx4j1hbJ4bSb_7pYAsXuGTenb6lzOZx6k94vBvLvRE0x2stPvloBUo
Message-ID: <CA+G9fYsdOigqpVZXXf9SUJPdkJw1i6QyMGCzgZv0=4dqBdFjvw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/81] 5.4.300-rc1 review
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

On Tue, 30 Sept 2025 at 20:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.300 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.300-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.300-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e1a2ff52265e4d85abb275e2930b92c821a3dd19
* git describe: v5.4.299-82-ge1a2ff52265e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
99-82-ge1a2ff52265e

## Test Regressions (compared to v5.4.297-70-gf858bf548429)

## Metric Regressions (compared to v5.4.297-70-gf858bf548429)

## Test Fixes (compared to v5.4.297-70-gf858bf548429)

## Metric Fixes (compared to v5.4.297-70-gf858bf548429)

## Test result summary
total: 39813, pass: 29726, fail: 2683, skip: 7251, xfail: 153

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

