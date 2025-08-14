Return-Path: <linux-kernel+bounces-767999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F22B25BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252595C47B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AB2417F2;
	Thu, 14 Aug 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL3/GMqR"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950823B611
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152334; cv=none; b=dshh0ZqBHWGyxyPezgCrt8HGur95ALqFMQIAm/dDOMSDZ529CD3uZBRpWwdY+EbKCQYC/DWK26qS1oW00PLqnTz4LfYZYr0PADEKcrhvscciStiu9nPVsWpsIr6RxgujEo7U/db+LBEIX49Q6y2QjEfHwAWzX61jqnVIo6liGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152334; c=relaxed/simple;
	bh=4ncyZacGunfO50btMmfn7MReSvDAIsMQ0V86SaO7m3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p89nZYlpv1n95z/zk7ShX2njlwzlvdGMKKLfMDQt/UJ9Kt4RzEJjoRg5f6rQxSDsqR+vTRWuo0mvT4+kXv9HOSrV7U3CCdRN7aSHNaxV/0GLKoRS5Y+XbRjg5OgVZrgJ5/6CSHOQ5RD6d708qcYtbGphjJDDU4ackyVBXE8/uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VL3/GMqR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47175d02dcso616878a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755152331; x=1755757131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVYoHiA4OWioHJGRjjS7sBw/dfBgPghCAuWYMygSBRo=;
        b=VL3/GMqRvPiOMFcQ5rUquJPC2EW1z2oDjaKQp/NnjNNB7bv5BnqFLj3sCAAbd8eThG
         c8DuPXflIqJozCCRXB7gvhIMbSsQlb6siMoA6HI/X2ExZvQDaGqrrgciJHFRU99lKzN+
         OMA+tBFmHpsC+1FgNemck6b6GODmIKaAgI3S/mfUuj7ahCSClQRFljYRezy6NkXiySiD
         htueZph1IG16O74pIb5xXYlzQEbSE84Xwjf3dMVdQul1LKqjduosCixh3q3KH1qwbWhs
         FPf4N41vzcJbth16MWOEqvgTn7HJUvYrAqZbUK9NwAd7G9LE/OqhAFz14TXF9DZ0PS34
         TwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152331; x=1755757131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVYoHiA4OWioHJGRjjS7sBw/dfBgPghCAuWYMygSBRo=;
        b=UD0EofhJmSNPueIy+H8xwXpUOeW7megQuOQ0pI1ggxseq8o44DLB/vJ62IbmglWzKW
         Sesr7sEG8igRgk+5obuqyO0SmHGBpjP9fMU/kML2ocLbWc5mbLHOO68GxNFxQB3Cmbp1
         RPTrrHSfQyOffRfKYI8TDwfGAOGM0s1NAvik5PSL3/Z7eTSx68UGl93SoLqvFVaWDFNJ
         VqrNU+1peOd8CyXQwnvkSNR3pAVO/WpTrEZfDo50S635j/hO0Ffq4yPD+zej1TGXZI5I
         uUgCHgMjJ1ri5Whrmhmka1qznkcxa43XyWNf8+P0WGkZHfYiLqDa657+oV2ExUo1/Dak
         er/A==
X-Forwarded-Encrypted: i=1; AJvYcCWIYSTjjN9EERNGqCBO4t7aVBTgEylznPGQszRa0FVHOX8NIGxTA+x6Y/2gayfIpz77Q3tQroLQO5EJ1JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouykKhOtZUOu9/CMy8c0MN6Iw9RblXUXDVCNYzw6knBkyAUER
	mmP8nRRTcJBJnAM1ige+lsZ1Lkp3MQEgQryXAV61WvZulM+YX4EWlARdnwOFQv6n9wb3GLnAkIc
	JN2JHsN0qS/R0JICNlmjSY+uIK0aCL06y57N+duBydA==
X-Gm-Gg: ASbGnctaclhHXB2fLNbObRjKtWax6v07i6lOnvRE8OnIOmzq3da4sf/0Dk0PfxDnDO5
	hR4q05VuePsSruMGBE498cRZJ/8ZM0XUi8n0Jpl/GNyQ9gHWYA2pcxJelg50G1HKUCZ1K0Ro7zR
	VxgrPPAggtpnvV2crvJcAhajWrMieB0KzsWR7wgb4VoDVL9Kys4Xe1eUIjhUexdudff1rzE55CO
	V6FGi1dQL1bEYTaO4dmsoBMS9XdMjBFWvBksJSGZ6K1tvrDprkISwepuf1mlg==
X-Google-Smtp-Source: AGHT+IF+JGiaAocZP3GUsrFBMxJlJkthqOzpiN6ZQpV1nwc776gUguSzq/7yFO9BdbU87/LV2qjV17GNwGes+DtCtX8=
X-Received: by 2002:a17:903:3bac:b0:240:83af:e2e0 with SMTP id
 d9443c01a7336-244586ef73dmr29790575ad.47.1755152331399; Wed, 13 Aug 2025
 23:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812174357.281828096@linuxfoundation.org>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Aug 2025 11:48:39 +0530
X-Gm-Features: Ac12FXyBqFyeMoQOpaAL4FurlRjkn-Zmez588T_Bm1WbHUu695lBgJJWNy1ckCQ
Message-ID: <CA+G9fYukypGY6DjcrnSCCHXekqpWQ1U7qWXJXKAp5aLpoxdZHg@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
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

On Wed, 13 Aug 2025 at 00:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.10-rc1.gz
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
* kernel: 6.15.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2510f67e2e346f399c76101231d19be2bc0844da
* git describe: v6.15.9-481-g2510f67e2e34
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.9-481-g2510f67e2e34

## Test Regressions (compared to v6.15.8-93-gd9420fe2ce8c)

## Metric Regressions (compared to v6.15.8-93-gd9420fe2ce8c)

## Test Fixes (compared to v6.15.8-93-gd9420fe2ce8c)

## Metric Fixes (compared to v6.15.8-93-gd9420fe2ce8c)

## Test result summary
total: 328235, pass: 307085, fail: 6419, skip: 14731, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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

