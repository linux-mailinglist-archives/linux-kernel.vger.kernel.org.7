Return-Path: <linux-kernel+bounces-751943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1202B16FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C658D3B311A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F512248AC;
	Thu, 31 Jul 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcfXcxII"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4D20AF9C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958338; cv=none; b=pVgFcWBqJ6or68l2aer5dE7ba1DoJfesIkl9VOQIB3pJTnFdJQIC6UN4wF2SFr0JDeezXD+gJxAhlpgC2l0TQnNe4MopM979jekZj+vGG/zrgqz8vrHt6GXrJOUOSwDsI3dBPVm/ZPwz6Fm8KJj2axul3t3Yox8dKiiHhO8TlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958338; c=relaxed/simple;
	bh=DKmgLs+7rBMzNOL+M6hkKTnZ6DyFBymJ0tEIRgBIGRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWPuof2JqcrM250XE5YU9CnCLch8j7cZy3QsKPGnbG5cVyLYJCa+trRgcBNxGRZtdAzQ/0mUJzoSPEer6WcoT9rGv22LrUszJoDDvoOQATIqBkC8RT/lXqWP1P9UgdRbCJtHHggzvLk2fByB+z+fR9fQG44r37DGbZQpqxBw+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcfXcxII; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31e41cfa631so743058a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753958336; x=1754563136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkDvSnoU7TGvsvWlCPvSXBARcwQMXUgFkZZD6Fvwrvk=;
        b=RcfXcxIIhC9gUKB+KFe5UBMpM0GwuUtXocXeWz3y0veU8Nn86dluxRaU127p6iXvv8
         cBpveWo4JRRAAnhVf2KADUkb4HOx3NQLYNeRL3tVISAT0CsxZO+5KNK91ax8kDqMlruW
         SPATU1zI2JLYnLFQsNM2bTFizT5AvxmPu/f5TAmolB+clBH8yruSD7Q35lmPencZQ6Wx
         7SNGnzshp0+svV+w0fpsUE0R8Z657NjMKLn4yXLX/GUYFeeC/Y8ewuv1NzyD9QaXhkBy
         rKEODHXZHsUSGuszqlUEHzFouCyozvCMOtvmDIy2BdWxCJU+TzVp9SINsgYLClfYWSXc
         U6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753958336; x=1754563136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkDvSnoU7TGvsvWlCPvSXBARcwQMXUgFkZZD6Fvwrvk=;
        b=jaCqZXbQ3H3Geqlcl+RPSXbHskxPKbd03mMXGJVIOGUlwiCEQ+hIFxaf4PuqjrvABX
         kMlb5sxcpaFgnbgY1m7S32P15Vn/RPOYIK+txy57P913kozJmYN6shgX/S6VB0sbhUvM
         +yd2mpxDrBDvRN96IwuJtJWE2SiPQhPwaQmH8L1XKRyYvETOuqHAo7KsIVUUZtzfnNlV
         OvV4y2Y8XrvBsgsbQ/bD8oAMvAAWe4elQ7muK0maVkH+b/vle7aKqoPY1corea5quUl1
         3+ftXY7ylQjv85jw8tI8Sv4mwwTgZ1TRMLLkeGGtuiKHVY6/6dutxz5hPEGhyhv1nSfo
         2AxA==
X-Forwarded-Encrypted: i=1; AJvYcCVWA5bVyafDgBGbBYYKabEqXG3HF0Nkq2lBz63I4MxX7bKbyXFhNw3PBbvKqPyxpo0FuVG201YwKnPlQ4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3xS4WtMV1OxwQLQD7qsXZ1ni3n5S8HjG84Kfr+geSmd9s6bN
	ebkfhARs7UtxLjBxK+4+mZnHtxHON0xbPfVVszNXAiX067mJpCFmS5O11RPuukf9XNpfJloh8fH
	EbYhzP+AWtQxk7eGp5drdFnMJm1NRA42AShsnH0hsebTWkiST2i7+/Uc=
X-Gm-Gg: ASbGnctPGkseTVm+yB/Lz5xY2CDy7CX/8g8x1ab6uvxJCf+UGrv1Va8CIb69e7EQG12
	EPOA9/VJIp669sivlocinzwvnomlL6VzoqtxXEw39LkycsqcxTK+/DgwunFa4tVNQ1WZSmqMveV
	icfLubmMs3egUAVvJy+rTY0erCZ0ypLxK8kFnzpBmW6rf7ykm/KNrDD/7dQlhG62dOM0sQgo17w
	LSWXbSo0zgxv//9HSXRTQCLjgjSDNizhIpEvhesfbWwEXttoA==
X-Google-Smtp-Source: AGHT+IH/Y0utzzgvreW0dJK6xOnQ+BoUywaZ0Mpb8ym8+E/0auciSYgHSSPN0uqHK97ffk4lEtYzEcPfcnLh3wWwwuU=
X-Received: by 2002:a17:90b:4cc1:b0:31e:d929:5ca5 with SMTP id
 98e67ed59e1d1-31f5dd8ca97mr7850100a91.1.1753958335561; Thu, 31 Jul 2025
 03:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093226.854413920@linuxfoundation.org>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 16:08:43 +0530
X-Gm-Features: Ac12FXxAjjqKYT2-ponmIrQtaahksxYUlIaazzjNQgBtICQCKclPBbgg48ZtZqw
Message-ID: <CA+G9fYuGLcr1Le+ARav_KsAvRqc86zJfPfEc2Xatkvq1NnWBdA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
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

On Wed, 30 Jul 2025 at 15:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.101-rc1.gz
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
* kernel: 6.6.101-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1a25720a319a8ec7842cb8ec20f6614f8eed10ce
* git describe: v6.6.100-77-g1a25720a319a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
00-77-g1a25720a319a

## Test Regressions (compared to v6.6.99-112-gb00c1c600f8c)

## Metric Regressions (compared to v6.6.99-112-gb00c1c600f8c)

## Test Fixes (compared to v6.6.99-112-gb00c1c600f8c)

## Metric Fixes (compared to v6.6.99-112-gb00c1c600f8c)

## Test result summary
total: 295209, pass: 276307, fail: 5627, skip: 12819, xfail: 456

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 43 passed, 1 failed
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

