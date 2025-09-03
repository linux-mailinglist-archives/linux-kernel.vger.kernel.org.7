Return-Path: <linux-kernel+bounces-798174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC65B41A52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A4E562A28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C82F0C46;
	Wed,  3 Sep 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgHqXa1j"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058ED26AF3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892656; cv=none; b=pkX3IoVv8vtHJjyuffutTcZPAtKM9e4U7sONdQJTdfcnwW1BmijhWUxwqSTddrWroT+wKyIXcJXaX/vEkaIfSZPe5vYEts4wj0aCQEqWwNSyXp+ZD0beF0K+oCu7NQkZRtF/hzXynQrtQquom9VmMVpXTBEUmYn3Bo69dKNAs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892656; c=relaxed/simple;
	bh=4DO31URqLOlIMCZRzxmllm/LEhaNDOtfIDJngVNU0gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mob3PL6M67zMvSoEOuSaeXNnvd+eu6eEm/5x/N5rvRtMtb67a07bjyXz9KCcPzkX7WE4QYReD63jcb+h8UGJ46LoID3Y+t9+4YrD/7PxMB93IHihV38LrexwPbS5a3v2MixxJypne5usZDlV+bt8KW4t9hfayK4sfmmYmF5sqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgHqXa1j; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174beb13so4246324a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756892654; x=1757497454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtzzda4QBQAaKKzF6sjShO0A4Pr/KXZhT9QV7iIvqZg=;
        b=lgHqXa1jx51lEQToyotxVi67zJk+zp45ZHXkDshRl2jLzdyZzNSR442oBCM2DBwoMX
         2S0L4msGoitbGsJe6CdSmbwJkByRo78NDT9jWaf2r/VJIHz92j4qN8j6dbZJGG5yZEd7
         haDRHdNPnpKME4i+/t7VPb0LO6e9Z1NK38ux+qe14Ey5sTpOrd7IS+7b8ZBplayPdyeU
         nNIKzpXk3BUQvvAASUajCVW7GOoRHDm+HmcKWyy5q9UBA9cpuvBKtiq+4nPBqsNsD8ou
         AMtZJtfscrkCwJTWFZs6EX11m8wL+Vp8me7Gou2f0rveMf3ho4ItbcyaU9wmpzxwmBEa
         OLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892654; x=1757497454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtzzda4QBQAaKKzF6sjShO0A4Pr/KXZhT9QV7iIvqZg=;
        b=dzFP9pIE2Y8KLoY4rcNRc+pjL3GrjclLDjttx8gzN7BnDACDQahJH0YGsGZbqSmvPm
         J85QeNe+C/9jeJcCmLFRvM6sK6xn9eo+cGYtqSstgIdM8U0+w514E+/Xl9sWIgSGdy9B
         nYDiewxAROx4V+ArEkl4PtThJk+jyJtD/vZNvS06pWsiVMD9yVMcHACWsoppYUjlRZbQ
         5RcPd//1BpliVadrPaRovFteXKqqkU+UWKW3TWbL20HqrD3wszG00b6PVt6G4lNnd/9O
         NgRhhyF2tVxv5cMSKqF0dzB2dhegCryJb2PLpVdcOphPnrl/Q+8lMLGb2tu4rykNea25
         gOMw==
X-Forwarded-Encrypted: i=1; AJvYcCXOMVAJ2gCfZL137wo8tQZMLz49w9DmswYWoKTl/cjKFupZVYpHsKNgdoP+4IKIXnnUUgcJ+Az08rhoMm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jpYVg5AemA9McLfuDavYj8hmkwN3O3FD1RZgpNqHiVl1yJ69
	IFMva3g6ycZGgOcGiTQJPFvygIT3E6Pgx8c1t1mHPt2CCuUfEPXPP5gDqZjzxpjyC/DBvKrPZph
	0VHB9gREWbKqSa2wrBvYa+yx1EL5XEM065qFSoMU0Fw==
X-Gm-Gg: ASbGnctTGmgVGlwzVU21JA99qfgek3NEdUTL+qou6OlSVE9uKHZQwW4DHsAP3+CHOJg
	IryxRLRvESLZRGlK+J0nIWl/70RBvSzQM+k3jWuzVcqM8bjOuq+0CF0+oSjnThr1Jg5wkb22I11
	3/m4oZ+Q7rtuY1bRvUsTrhXUcngVIG0JAAgS7QeJQMBsG3xJKQ25icATiCaiOEVgJkFeVVvY1On
	jZWlRFC1h3nseibFdo8dGRiFJzmna1gS60JAyt9zF6EqkbkUKyT/LvMXUkIXQ==
X-Google-Smtp-Source: AGHT+IHi/AIip1Etp8O6tE2+9Jrulbj7mZegJyFHVes3qPLwUuW5JJbcwOl3A+MkyPFMk+GbxU0Nie6sEeU80s96Wm8=
X-Received: by 2002:a17:902:e88f:b0:248:e259:16ba with SMTP id
 d9443c01a7336-249448f9912mr160615025ad.4.1756892654045; Wed, 03 Sep 2025
 02:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131926.607219059@linuxfoundation.org>
In-Reply-To: <20250902131926.607219059@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 15:14:01 +0530
X-Gm-Features: Ac12FXxnehF-f0uX9uf1w98xh_zbbMgvqVVos902X4S572K02cR0LhUNbnaqGvg
Message-ID: <CA+G9fYvSa6TioRgDLT_KtYdWYLz4hUbNroVjg9KiBEe6niDr1g@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/34] 5.10.242-rc1 review
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

On Tue, 2 Sept 2025 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.242 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.242-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.242-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4576ee67df7a1a73a4ec410a6c8fba6afd0238a3
* git describe: v5.10.241-35-g4576ee67df7a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.241-35-g4576ee67df7a

## Test Regressions (compared to v5.10.240-524-gd8db2c8f2fff)

## Metric Regressions (compared to v5.10.240-524-gd8db2c8f2fff)

## Test Fixes (compared to v5.10.240-524-gd8db2c8f2fff)

## Metric Fixes (compared to v5.10.240-524-gd8db2c8f2fff)

## Test result summary
total: 38282, pass: 31263, fail: 1860, skip: 4969, xfail: 190

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 100 total, 100 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 20 total, 20 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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

