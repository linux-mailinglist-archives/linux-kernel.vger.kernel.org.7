Return-Path: <linux-kernel+bounces-873868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2FC14F84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EFB6218BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7E200110;
	Tue, 28 Oct 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOyNuhZ8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80371F4606
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659153; cv=none; b=PP6RwuAcwCnH6zfiu+MQ/XC/tL8X4CN/XodzgBBwf/Oj4DkkypfuoN9AKlEkyD7PAA8iDE95T5a+gkQ+8Ma3wd5VcxLdK/nftjYh5iRblaIRC24RB+QXKFXrUqxYotRnFmH+UIwsl1f+5UY0srfLHTZbKrK0q/r/KNY1h3qwv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659153; c=relaxed/simple;
	bh=gAweIO9n8J08eHn9APdNJjAICf2I1cbLYhJ+XHIC6sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN3U3l0j22Sw0L2W+I3yNrrD+ApJazDygKH0JvNv47JId1df6prkfcD2UGIxzsdTHn5olMeBwc+c/SPS+n5d/q0gA+YG6nIvV1uIYKwoCUCcWFc+3A1nWirryVAVfu28tKKQOXZ/CpGHeZKDV0WbtFVZNSsQaJxf6WYEfd3FJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOyNuhZ8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so88765915ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761659151; x=1762263951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXp3oSsESI1TV0Y+956qT+rO7jlyOrnA6aCow0zk6rY=;
        b=sOyNuhZ8oiEnJnzLYnAGrtaFNiFXnBVbNcbZSKznhaqP848j+2r0gPYhIew9YLKly/
         csCrJQtsIc9J/xF5nwqJNi56gotFNocV3nFpxz9l6lCp8a2na1G7QND/AmwViHplyxnD
         be8B1myUTZarWHIeBgbXlXny4U6IbSeasfYjBVWjpifd3W4VPho3esbUXs/jxmbvBWY2
         aEycaxoAsrCrzYyMxYkLTywA3EiqCk7VFNxaucFpigPk6b54wTTJi8kJF3bXmDB7rFrX
         1c+//ZkbnEvuAp3oHHOXCpKuHfCTLvubCBf1U4T8M7sn5vHTFK6PQ+5HQCR3GSafOfuN
         4kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659151; x=1762263951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXp3oSsESI1TV0Y+956qT+rO7jlyOrnA6aCow0zk6rY=;
        b=iScbYu14/Nj00Kwa+bTPNdQctwKMXIV67Vq8J35ElOg4fU5ppdAWtRI6w+8NIZGKEq
         iJlXYchJUeyppF25mH+SObi+bAl9RllLvJ2UkGCyy7vIYxIQsT8oNkDFlIz0lbQhn61L
         vkOwArzuOB1yUGM7UxGT1Qvso4XT1UCIUikE583bsR6WSzf6gn50Cf29zzfrEPetNJI/
         bH6QD8/mVy/ITjYEzREnG4XdBzfjhZhRyrrye7okaH/aqWJMqgPcfDvcfEWfjk0q+Qep
         zz19JumFEEPpYTmZy3K4gEQYFf3KepoXu6ywLHpJuCAgkG37HTGiFjJUR1KN3hzh/VdP
         Lq+A==
X-Forwarded-Encrypted: i=1; AJvYcCXKZxELohP3O3RX9OqjM6ucCFR8D+jRyBFb2thFWVkwWqvBRRmBSkwKe6WgdrQt1IfLM57ugBFbb+28ZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtVCQV/C9s5O7nt/FUvfBpSiC887b/5EvnroOYgmqaJ5bXpO3
	EZD8nMS5VjYdlb91rv02vhHQrIyV5+jgNoT3Dk1e4RZrlpGjPRj8HgAoAOIX8QHQMVy/SFakz2A
	XsvDEL6ku2li1lf+fYo5HKbEbmg63bAdJeVvQBCwlVQ==
X-Gm-Gg: ASbGncuy7361vfgp70NuuniltBPvkGSQ3yjvhYuvWCvIIv0vMtit2KthgIsKn+BSHbJ
	K77Jh2Rw7/8++IOWYSjG7EqmKtXWEKC47P1giaTl7+i7YOZWaBgygFRIYnCtSDDlaE2mEoAKZye
	y2y4WokWeTn/zHBqp6t4jLot27i6rSWakymaC1eTO0hKClg+7ZqhR9EEr51+4+sikF/uFjPecTW
	5acFHMPIHTtTGHFiiaqQ9vm47hpjJiYsbje1I/VApFzHEZsje+Pedjs3RFy9jXAdPLRtzlxuITK
	WEZupt+Vx7kx5fEkObjz3McBZ0sGfxsoSxQu7uTUBC+3wVyUBw==
X-Google-Smtp-Source: AGHT+IHxZ/1XB0XTooTy20gF2J6qp6ErSqlur+nLfC1cS2f0htQwqZP27n2jGLSGOe9wQ3S48YkxgzPbfK7mTrgqi24=
X-Received: by 2002:a17:902:c40d:b0:290:94ed:1841 with SMTP id
 d9443c01a7336-294cb51b8d8mr48988685ad.41.1761659151099; Tue, 28 Oct 2025
 06:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183508.963233542@linuxfoundation.org>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 19:15:37 +0530
X-Gm-Features: AWmQ_bn3RK4ifsADAyfT2YCeNyByQ1FJjNTINqrzgb0emwEGcjVldmM9i7J5uE8
Message-ID: <CA+G9fYsOAFpZfQ37Y=En+PesV+Voa80CQgkU_Y4y2Tpta4+2Wg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/224] 5.4.301-rc1 review
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

On Tue, 28 Oct 2025 at 00:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.301 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.301-rc1.gz
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
total: 43391, pass: 32354, fail: 2994, skip: 7851, xfail: 192

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

