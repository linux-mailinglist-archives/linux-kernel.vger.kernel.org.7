Return-Path: <linux-kernel+bounces-733459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2354B074EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC9E1AA46A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8B2F3C2F;
	Wed, 16 Jul 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lh6khaKa"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C522127C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666279; cv=none; b=MICVfS7BFJwMLWMcIngxFbO7cGHSozEMrZXJVZXIYMEdQmGMrLbsOUpo2pR+H6PMKEwyy9hEaCfy+10Irnrb+MWVc8YWrtlgb0/Z5PTZdprjkc5255MV+NUHsfQ0Qh3II+Ps2quZ4jLV0Em3yJU1Q3xB1Guk6nvbdB91opmglUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666279; c=relaxed/simple;
	bh=JnOG6ooJhnbu69xt4DZN9M0n0dNgDQGpilBl/b+s1kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slhy9YC7R20BNLGOp1096QnOmvDsz0lrxONcz3c8lMwCWSfp1jW9Eu1eeKtSYE37pqBKftWUNxJ25RoIF0F3KB1ZTFimVprWpV1Bp9ejuM/d5K09IWMq9GoBkBbDwr6bvm4c1CRYS4QKUFX92xMnugU1IqSJaSrpxL9zY4WzHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lh6khaKa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso5544692a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752666277; x=1753271077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Vrzj9Fu7WIJeE2OnRZTO2T6pseUqFryRb+fWlv6fw=;
        b=lh6khaKalRJ/EVFZ0QHczCMcp3Gqdc1l5FNgL00erZp5dGvBDUptv8UZPKuXelfM/K
         nevLPk+knU8ADoyO5HBOkLB2tJwh5wC3BvRzoembzQjJIMw+ZsusfHSxGzyL+9A166U2
         wAYaN/C3WNtOMzMKK1xGqme2Ct9AB/cU8Bv/WQTYABVfoGVXhOjC/O/3+5aHJ0uPoC/4
         eQX0sCLL21QeTfM0Nook1oIxyki/bUVCgt6oYelTdAdG1pxcihvmt7kLW9w3H4SBxwk3
         OV6Vj0wLcjeErp41lkwhBrf6bswEqHT4P4A42xfbl16ae0ImporPK6T4RDSNZG1pU7Rz
         RM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666277; x=1753271077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9Vrzj9Fu7WIJeE2OnRZTO2T6pseUqFryRb+fWlv6fw=;
        b=l6Nj+/EsVBoM/oaiiY0aqvRQMYFljZwmEVHARAZvtXt8uPSDGExlNWdWvydWHLmZBO
         HP/k+ylvRv72axnVwmY5oofy7n6pDSggOmf1yLMwuP2O4gBx+HAl9W1izQMajfA2hQT/
         k+/JTuvg4nuCB9NUHGxuektb30/zGkZ3hut6iDnjQPn9i34BFUmKqs9Y8nPAawZzo+fG
         LySZX+NESW1AA0uUBd483FUikLtwZhqZqdyz8t80NoP8kuRBBFgwSGNHwi6v15h0Aj1+
         ZSVpg6zW4f8giyodWQupchlXLaXAW/hUzwTyOrxdrIXsAD+8XVOLXxJUScecivCSwS04
         LrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwD+SbXGU/SgxokqwxnnO4GJ2go8yZM7+vHC+dWaGQb00eXSKgUQ4vtB2T7FJPBuHXFxmtdGTnW2VKey4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjq1Dp7zKOKkhv0kKf3Tu06owwuf3bkQ/d3IegeaECpsv+9xyq
	hl3WA3ZEjOSgBwRb2HcAY3n80rglotidfPT3cs69uoHSUEG3pLEqPrPkQapLU+vxiashs73R5lf
	c+Pr0PirJPZfsGXXWrmcHmlMtmnRrm0FmKc8gAQ1V1A==
X-Gm-Gg: ASbGncvK1ex5UI8QUKKlBl1cDgf5pb8wUnqnG28owYLG7b8FtaD76gCckPXLADVdneY
	TXucs9hmGUYBXeT3/COSWitqqfoUdfSJN2c3osNmcNea0RFxACOUd03NGhMZNGFerhPAgcs+cTk
	R2pisGBFHZcaFhod2OT8ZWgywbvhUfj5qbNg1bUpO0xxkTNDyWDMYu9ruoXMsiYWXYa0UeqPY+M
	ho3B70o1xf1IntaA5sAeGjtkALF+ECg40G4t1cm
X-Google-Smtp-Source: AGHT+IFNEGCm4dlaIj+7IRWJC0AscMoG/Wnk3C9p4eF8l9ElmPT2xzCbzseXHqg93ffcOeAzDsnVK1buOBoIc1vLXC4=
X-Received: by 2002:a17:90b:48c8:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31c9f4a8027mr2910872a91.22.1752666276531; Wed, 16 Jul 2025
 04:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163542.059429276@linuxfoundation.org>
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Jul 2025 17:14:23 +0530
X-Gm-Features: Ac12FXwh_cyJTG8bELy58HCa7WlN5iVTMr6vUGIj2yM5KVONAlV5bNbRfch_oSU
Message-ID: <CA+G9fYsQdL2XhjF_cHSni+ABMHoe0aDiwV_zyT=Y+-k8ovr20A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Jann Horn <jannh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.99-rc2.gz
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
* kernel: 6.6.99-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 9e2d450b5706b55c38eae29739b1b81ddd7e3b9e
* git describe: v6.6.97-114-g9e2d450b5706
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
7-114-g9e2d450b5706

## Test Regressions (compared to v6.6.96-131-g7b8f53dba183)

## Metric Regressions (compared to v6.6.96-131-g7b8f53dba183)

## Test Fixes (compared to v6.6.96-131-g7b8f53dba183)

## Metric Fixes (compared to v6.6.96-131-g7b8f53dba183)

## Test result summary
total: 288485, pass: 264299, fail: 6263, skip: 17525, xfail: 398

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 0 failed, 1 skipped
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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

