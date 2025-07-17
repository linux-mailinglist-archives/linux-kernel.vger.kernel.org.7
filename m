Return-Path: <linux-kernel+bounces-734639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F0B08440
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB96A1C26954
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EEA1FFC77;
	Thu, 17 Jul 2025 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpjNlwJb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B81F582C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752729805; cv=none; b=UBhsQ2auHDHH9mTVP9J2cyhRjotOzBXW72efdHf15VpfeP8vZJZhvmWoLk/P0Xk6j8onkKblx4nFWGiObnj9ATHRDCeg070fnVvOBSCbOSscNZkK9dGXjZRn6XkHf13aiIaafmkpZAANU7UcDXmgEah1CK75IMoSiUCnzTRlbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752729805; c=relaxed/simple;
	bh=Go4DWykoSKJP1cS08Vxzg6QHAJO7yZfQSTkvC1QNlkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vwe2s/7koYtQV7zAG7ouJzUGaPjPiAEv6ufYguiJLwJw/s/TkocE0EM/MFtD5eA78sWxpcWRg36TEy3qxq5+LKmYkrSei2wesrUoSjM5CbPX7ykpcAfqr9qbua1KMpQV8Y678vhk5jg+MbEcx756LcFYcUwt1R4nsvY5uGLAalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpjNlwJb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso4308645ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752729803; x=1753334603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbNXNk8Bjt0C/jyZ3yLfvc663qoXwVQsDwn4FalQUM8=;
        b=lpjNlwJb/Th0fjNPw5Wvbljb7mYS2MstkQAa+4JGr+yQCYf0E+uHfIidQ78h4AC1Jk
         ZvFhhIuRUtDWEdohMkWJOktJYt3auFzHI4DeawTsuwt3H6J19/s6tFxAwoGPUvTNkGRg
         fgU1ZH3f8SRcesNO8IMn7V9vh7xa4BLPxljZf/PXP30SqTl1tFpS2CL5Gcf2HS4aqrvG
         MYsMmBnr5Db1GCELO4xEpz/RZOqUlT7ct2b9blQU5iZ1LEMhCxqwbC8DTM3xb9KGTGou
         h28J6Lql6axv48pgDF7oyXj2A4ebBbRDntY8qxnL2o0CoXclolD0VgWZyNM4BNN4JiYQ
         DSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752729803; x=1753334603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbNXNk8Bjt0C/jyZ3yLfvc663qoXwVQsDwn4FalQUM8=;
        b=AnBQGWqbVI+avrkqh1aqznrFplvjwY+p0rjfFWkmGxO4i9kMLug7WQ+vqdu0hAhDkJ
         jYMyaWjXaxcGe8V80MY2lVzA64LG6zRCGX0wYcNORkT2+dl+Z45fhVj5mW8PDeafibHT
         MMZNDO9EsknUbBzNUy9tLddXwTDfTpamgYVsq40a3CVaWcg5aYW78yNls7exrl/9imiz
         ZJRRpuI6VkJqC+J4YE13xcJWO6SKfAJ0YGdJzixrGGh/NN2V1WweJXgArt0NZa8+n423
         S6HviYEWX9hE0mN1sGQQl4Xjgml3SE375B6MnrKjQsB85Jid/Rb/jK4ku4CxHwiiKzDI
         5YGA==
X-Forwarded-Encrypted: i=1; AJvYcCUEn7ymKMdy3HE7waFaMPNSUYYcfDZu/gn0TmBH+CkEdNqjGF7GwzGZdMbgX7ZoacuCRzeOhQPfqncKrwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywofv37u6k+XjxRQayqlaTaEWcQppBcz70mZOrEerFYJqkaVEPE
	SN19ZuAi307ZFTZv8T8aYuIaMv1/+iiXr97F3qJEXgeJrfYkGYqAAjXlI/4TGP4VGca2VwYNfrp
	/f8gZCSKki6bFCF9sCFXMSGO37uQkuhnsFZIuGJJU0g==
X-Gm-Gg: ASbGncuSiGFBvDngCUAbuTTHv0bDA4VMPmF/heTVUEInqa2FOIiN4efEZ4ozHZw/JJZ
	h+WMakiAhh+vAV0Arfw/8OalvzT8wXijyElJuWEsc2TpQ1wf3kYk8hqc3RpjMaKSSFAL+AT6ktX
	3gAqLNbAdCjCvAGKoyK0Q7vk0i1GoiO1QcsRgeZ3BrgaeoG1f2SSHDPb25NwasHd7O8a1bs0QG7
	Q06+dvr1q/NBOLEbnXDLWJoRcJ8+K3gOHDeLO0M
X-Google-Smtp-Source: AGHT+IGC1euAAA5dE+kok7mdUFeay68s6sXYaX1cEPylz7XLvI+8baa/hLQApw+98wrPtjBWn3XlSJUgjxrkBDbUHL4=
X-Received: by 2002:a17:903:2446:b0:235:be0:db6b with SMTP id
 d9443c01a7336-23e2576c493mr78845715ad.45.1752729803488; Wed, 16 Jul 2025
 22:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716141302.507854168@linuxfoundation.org>
In-Reply-To: <20250716141302.507854168@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 Jul 2025 10:53:11 +0530
X-Gm-Features: Ac12FXzq-Ju7B9DM2i3Uy_CU19Kl5aGcWdwTnWvRw2hksW63aQqP_uvej_ipHLE
Message-ID: <CA+G9fYvwrnndRbDQA3y9Fy94_J0a1sixG6GfV+R1p1iN3+ATFw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/144] 5.4.296-rc2 review
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

On Wed, 16 Jul 2025 at 19:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.296 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 18 Jul 2025 14:12:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.296-rc2.gz
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
* kernel: 5.4.296-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6d1abaaa322ed206d965a1e36bd88e4ca921b85e
* git describe: v5.4.295-145-g6d1abaaa322e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
95-145-g6d1abaaa322e

## Test Regressions (compared to v5.4.295-149-g32230c3fbb24)

## Metric Regressions (compared to v5.4.295-149-g32230c3fbb24)

## Test Fixes (compared to v5.4.295-149-g32230c3fbb24)

## Metric Fixes (compared to v5.4.295-149-g32230c3fbb24)

## Test result summary
total: 31832, pass: 22716, fail: 1849, skip: 7132, xfail: 135

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 131 passed, 0 failed
* arm64: 31 total, 29 passed, 2 failed
* i386: 18 total, 13 passed, 5 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 3 passed, 6 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* ltp-crypto
* ltp-cve
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

