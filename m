Return-Path: <linux-kernel+bounces-807475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A46FB4A4CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7094D1B285D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2889246769;
	Tue,  9 Sep 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBHt2jeB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AB20D4FC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405683; cv=none; b=mGmYvQzeHuftu1wFtPHfS+n7atxjNhNEOJdsLZdeWCFl2cyH7U4LcQLb1fBrmqsLs4PIOy3Qyij+Bl574a5ghkLHWR4rkBK8ovsM2ETxrLWkgd/9saKXT6x0lBqaVvWPFt7A4IjZffvUcwOnlI9sUc26GvSBBE5NPwxtWKr2Wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405683; c=relaxed/simple;
	bh=Y/R4UDZ+ZSvt+VaXgW1xyYWYXJ3iCy6juBUJfKRwCSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPoVIl58WhvR+tfZeNaPHExTG7soDve/PVt4GBER/HcqXjoe8bO3uH5sLaCjRA7nCvAsOXCNscTo+DbCYNO0RLSPRUD6ll9GzN3dRh1Cs16CcEk3fDgVN00umjy5/yUi/v2yH8XWX2XnzJmeWbj7j+A48pAIyGuyebuCb5dRQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBHt2jeB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b92d75eaeso3602737a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757405681; x=1758010481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIpgvsteZsFCH9XFFKILSkJ+RpxiXOarjA0CWs/e0Ss=;
        b=gBHt2jeBuOa7Z1cpO99PkCx/jc8kWQNtJTXHekg/JSooq8yERTzA0Owq3sZZr0sfdl
         dCcQdmAUUpYFuEiF0oGhQJqstiEDk7CMlH1N+2atvjQSVvbWvUIx87rNSzMUdXAgvd3i
         9Ov4n/h0ckwCOXTLO8v8/zIounM+3q6BIuttyKmsDS+Wd4LBUndgxO536KVYDcqzt4fk
         AFA/lFr/OZEMgl7wU23pAsI3pFZGyEb2wrXH6PaqHHsQOh/NENXFtKVmwj/lLVUbir0Q
         eBG/Z5K1hB9z1K0ZpkLworbne1dgvsD9ZDqV+X1nuOw7pdt8+7BvcFJc0hIdA8KwPKSk
         LmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405681; x=1758010481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIpgvsteZsFCH9XFFKILSkJ+RpxiXOarjA0CWs/e0Ss=;
        b=MkA5PkEv1r371Pv2FWitIN7MUCetLiw0U0w0N4DTaPEi473BBZ9r5M/hlRj+SxItVJ
         jWPobLMSYAhJMLiXjlQoQmBANYx20xpyToY5v0p7pvPoY0/nfnHZJ9HEpJi5JqF+6fRe
         lr+k3Khj5iU74p+p7VEhpJeFiG1Y8OiwzsIqaVIhAQgGAXqQXwmB71Wo5fgGyTx4Zziw
         JKaIpgbklfNUnL9sO4yvm9A6BUJM4eSCKAVmZqPJAPtr06Ewcw9tSDWgm6Ac5Rpd5sgF
         7gc520MwVP3SvqLvb6ODavxF1EHasqKJoFN41kIIPZjA0Y/CaKzKZ4QPARHg8oaHjPFc
         QEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXQaf1IfZDfh1STWW8rxpkJedmJQxdKofSgau73eBg5IaWquUBjlleX/Shsu/dmzIWpJBPhSsYSbPR8jRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvLhkqpXLn21460QEtXC46sMnrKwMOinE8kLk3rD8h2mk+zvz
	POOtIDirU1hn4oWcIBP49izJWNrLraTfohHNIYZbE/uxwZpKExlFNV9uOXaSLu5MJ/m6/ekMIM/
	UsxwuYQO8TlxcRfn52Wnwzn4E0ftJGpRr/ufoaJUeGg==
X-Gm-Gg: ASbGnctetgNkM8LG55Iw5D2Vh+fMcJwtODclz5RcdBgkw53M+OJYMrTS4uojh31lx+0
	mvXQ1KF9Htws/dFBnaMe0RTskRqw0BYn9ky4q/hTTXyhyoCwdpeC9QJ//gPlDWLCTxg5vg8wVdK
	FSkjWkk2RAns6WnWPVRRtnXQm8vMuirJMp5kgO26MeTixb2dFo1u3L9TPluLSZ9/CxTHmZLWgck
	sxrUV+/roDj/BBAxyW+kbkNsB/UKAEMWRDfqez33vUdcygt3+4SnUMrOjqZl0JEs/v3dxw=
X-Google-Smtp-Source: AGHT+IELD9aMuOIBvTjO5dI/RE7Ggtv6zlFzVxwqiI8iba1V70sNtE28/4+HPw/Dy2au9sKayL5Q3BSRVpKjTZNUggY=
X-Received: by 2002:a17:90a:ec85:b0:327:4bd2:7bbe with SMTP id
 98e67ed59e1d1-32d45037837mr13813712a91.4.1757405681401; Tue, 09 Sep 2025
 01:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 13:44:29 +0530
X-Gm-Features: AS18NWBX6sG9ivlDQZwj3uF48WgLHfvr7cs9tUI07CgvAn1-iGKNVR1tV29XcAQ
Message-ID: <CA+G9fYtHR3SbJthRkd+HfOMQQJ75L6fKNhU8uMmk5chRmN1G6g@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
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

On Mon, 8 Sept 2025 at 02:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 665877a17a1b1f125d4ad586fb5f032accb7d853
* git describe: v6.16.4-327-g665877a17a1b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.4-327-g665877a17a1b

## Test Regressions (compared to v6.16.4-143-g6a02da415966)

## Metric Regressions (compared to v6.16.4-143-g6a02da415966)

## Test Fixes (compared to v6.16.4-143-g6a02da415966)

## Metric Fixes (compared to v6.16.4-143-g6a02da415966)

## Test result summary
total: 348600, pass: 321208, fail: 6791, skip: 20601, xfail: 0

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

