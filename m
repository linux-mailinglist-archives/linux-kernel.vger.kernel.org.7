Return-Path: <linux-kernel+bounces-743732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E5B1029C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9343A257D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75C1922FB;
	Thu, 24 Jul 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsbXuhID"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC391EDA09
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344094; cv=none; b=X4VoKJ6kIQ1QM/jlnbLhn1sZuU1aF93a3SBOje/RPC3pxaMdg6kVe0Tb3Lg8INm4nbF9HzAUYh6p3UFbLLzibAr26xNVDsZzhF7hfeOqw89hsD1BXHvZc9lA0+YVUvC1ucX5ZCtfpmiuJZyaZYg6Vg/NvxMi7cMP0IH7ZdeurBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344094; c=relaxed/simple;
	bh=5A3Z8slNVEBZE3CFg2MqlP9x7DnuosBp4IhM0ZpDKlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ths/ahovgdHPSzq/84bt1zmdaEdtBRIhHXmF1x9iAyUuvniW4xBEEnPQTk0vLxhM4qE4mQdL4cxmJ+6Idq3b/vuLev3qc/MdcIMpxfon455sx0rhWrXwZIjxXRSq0L9BthcPGQpbI0q9yftQYavyN1BOs6SuTP105+P+yfhwBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsbXuhID; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso644904a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753344092; x=1753948892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm9KNNBxAABgp5gOoV12tf0eMIaYYncc2PwDjjv+oEY=;
        b=wsbXuhIDsvtXDeb/9Q3ANSysW63VFoy2YMMCT/yYn/SAmg5YXIC6aLcgTdgsvG2fRH
         gZC4KVi95RU1EnXOY+Cq2nZUSbxZc5gL21bobOoLfK1I8RGYm+iMp1cwXEJfO8KSV7ML
         FzvlDSF9p6MNXODzqiqAU3i4IEEUnf870wrWz6fRGFChszsFxEaF7V3vGg5WO74zJYzU
         sMmbKXpvlHIVyMvgyhIldGARXgg1PdQ+Wrg48b0Dv+2nfNg6RdcicdwwhcgK3uR/5snx
         EaUfhSuJfdWEe9LOzSxW2qwuK1nlF/IzbB1+9ICNlDHiGBaCauujbaZ04H+ZZmvOMml5
         Z4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344092; x=1753948892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm9KNNBxAABgp5gOoV12tf0eMIaYYncc2PwDjjv+oEY=;
        b=lAkosx6ynciJaUmUcA91KlZyO4bSP2qw0MkKk2GMLQecUGq4xrKJOhZQVXGarDx8BT
         K/49x3yBo+rj3l89mrxcj/y4Km+6isEOMKcZGZUgXGlh3dxL+tGnOppdIxrvTbSBqwFL
         1XawtMI+K37Tlu0Z9lYngfIYVtsQB3VCZX33C0wZ6wI/eO9VUOFaY3pv6Nv3qt20DFL8
         2Gx00nGdQqitpz2pMxQtPRzMedxmFY4pDFQjoAe3YDLNt0TBLRqWxiz2LK6LODiIswwU
         uaA69q7oy+Hi9QzHf1G6JUIeEwF4GTXpNu/cHFy5IT/3dL+hoCELEBjomuaIrOszcrvH
         hpgA==
X-Forwarded-Encrypted: i=1; AJvYcCXvqip+k7re1ceKhO1mGVaSiBjOvxn4S1pth3wkQRvnO+IQ/1Xq9rRujysWV/6LVfaAcSt71IAfQL54I2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWt5q2d0HSHkhdm3oc5GoG/iM/pJxG1iwLiEoTcQ/yr2lgMtrv
	qphrzd0lnQCXV/PTT8TP59nF67AJJIQyK1wHr9r68OK3/QM6XW3FTMCJzHPtn/5HEJqTKVAxEJH
	a1IEql1AJfuB98O6p87SDDKNhYshugxy3WEfyXUJajNCzZrVtYlNHprk=
X-Gm-Gg: ASbGnctGLmwasF542088mOcTH9Iq2T72HR6YqfzeicUIBZEUMfCns52pCoQcXG/nXUI
	CN2/s78p5bXmSpMy0C3EQjor2xvtlLPXALAoTWlBHoZBR/pHt5htPu4f/E6lWmJYn+SnYTRAfrF
	NQGoc6RNR+XbSQUAxugx4j8iSGdp3gPruZoPbyApFRlScDayqWcxCuqagMohQ5tzIKlNi5HO/TG
	k+A6yvE/QdL6B4c+A23GNxGtfIKxMoi9WIMM1A5
X-Google-Smtp-Source: AGHT+IFXFMQVdedGPzwZ8qOT6jbiIBrxpwBPcrccxmouRbGeo3CqtPlJjH+Rc35UCS+AMgP/xcts90SLDCaiAhef8fE=
X-Received: by 2002:a17:90a:d60b:b0:311:c970:c9ce with SMTP id
 98e67ed59e1d1-31e5082bbbdmr9159726a91.28.1753344091532; Thu, 24 Jul 2025
 01:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134345.761035548@linuxfoundation.org>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Jul 2025 13:31:19 +0530
X-Gm-Features: Ac12FXxtcOgLqPqroSSzbVA9m-CKAZYmLOPXu521BJctLr01UlzJ4sQIX0UGpVk
Message-ID: <CA+G9fYsh9j5qBXLgcnJ-vJXSQojhUQU8CH=1oGGBbj3iXApZpw@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
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

On Tue, 22 Jul 2025 at 19:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 81bcc8b99854ba689a8c85fb1d39d5acdce0385a
* git describe: v6.15.7-188-g81bcc8b99854
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.7-188-g81bcc8b99854

## Test Regressions (compared to v6.15.6-193-ge6001d5f7944)

## Metric Regressions (compared to v6.15.6-193-ge6001d5f7944)

## Test Fixes (compared to v6.15.6-193-ge6001d5f7944)

## Metric Fixes (compared to v6.15.6-193-ge6001d5f7944)

## Test result summary
total: 329387, pass: 302234, fail: 7786, skip: 19367, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 47 passed, 2 failed

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
* kselftest-rust
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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

