Return-Path: <linux-kernel+bounces-798023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B8B41883
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4B254074F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B32EC085;
	Wed,  3 Sep 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzM+dLsM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D52EC574
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888132; cv=none; b=fH1HxmjXxDKnwFBcHXgT/LQcosadzurNJGe/RZfRSTHGtWKwLDyu8F5gMwQmM/wbu6Njdfs/M2Lrm8EWBYNdBRuJddGg7Jr4RXoWctsAXjAXPJJI0efJ+cYTZQ5giNDrJd1QLdLPFcsUijTeQgycAMrGyuSXfnQU2GiEH9svJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888132; c=relaxed/simple;
	bh=1Wym7Nu8boFhEFpKuUAnQJFtOt+aiYW99MGI9WjtyNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdY89EXbtETlWzvIGmF4h48WBSJgIkDtt0IsdhVn9MUXK3h1PgOlXQsN1SfYyWHjDKKsWpzjKLeR5u3QJ/v/Ht3KVwmL5Z8uE+dIeqF+zm8zN9k51WifVWKST8MxMArUIEB9HW/rAw0EyX37EEmdOdxIXj52YImimitt01yWAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzM+dLsM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c784130e6so14178335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756888130; x=1757492930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLdFeYJfsJKqx9nSy+skvh05dFulDLtOnZYFfC/PFRM=;
        b=DzM+dLsMY90/KjFeqqt22otWyWpAjsnj1Z1JEMnzZ5d2ZFeIE9dLVflw7VHEU0HxOb
         B+gexaodksBYEz9aI2srPCDvSgcM620lab/SBURIlJf8qUxiFWxsXaIsKPRKLm4xM2j3
         62BeSger8wlvGPtbUy3Jst/abAtxMMEQooGT4xlwmvytu/DN56WAXbwklepE8TN8iNNY
         dv/nw+fKjHZuLtZAh3zEEbYrRuxb4iA/mc3ESTUfjYFhMbZWYPjvzza66Wmj1KlBH52Q
         h+juutuO5ReDRMS0JOEo/t9VJdK9tbF7KU8aGZVlnTTS7VXHkPkLvUbGHRPvWRW2f8YI
         Plug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888130; x=1757492930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLdFeYJfsJKqx9nSy+skvh05dFulDLtOnZYFfC/PFRM=;
        b=aETgeY7sKIsT8MCmiqPVlVfHamINcf2ClJam/rMo3pALq3FSH7sdTNIw3Lz6OEth6e
         mUf8njGSl8fzyojrT/HqH1tX/Dw83IfrLOzjWGCFiEf0ydVJsSkkx9u0FK0Id7y74+eO
         bB538M/WoYspKAUSCUE6wkQtVyFBoyUJOYfxsGAgML/r0tA8C22ts1JukkioWpkczgDC
         0WxKeSr1+s9CrmvOgiBha9UapMcJg5oelifMVP/fS4GDxs0/Vsyvxe0irOTNle4cNd2J
         jfPZNLDcNOWiZn84W23QcxUGsbXD+TMpx382qd0cz8slO6cOIWFpiPdgIvZqd4SO9jJp
         vL3w==
X-Forwarded-Encrypted: i=1; AJvYcCXiIfjtHuSlzU56O59OjJkw43h05B11wQ5AdZBRbKYjWMYG+bfprkWiVq9wsryx4Iet2yNOCikhVOfNbUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSr4dah8j21buqQO6rUGCs2+S2Oq/k/Otv8ItM5nyhmFs7qNQ
	98eTHo6Ickhl9lUz8sseylaiOZlMOUXAsRZ45XT1HyVKdUl4UExjh4KeYIfJzjUqqDXFL1RGber
	aNF4KcZbPVuJTmWyfYJYexoXadPFQCg2EQWatiyDtkg==
X-Gm-Gg: ASbGncufzaQdjVpYIM36rwv0+MuAZRONBJiKYVPJL7ZS/XQK3JHZO+Q2WsC6bh00cKj
	abF7zL3J0WWsl3DHuDofdhkaFsWvvJbFEWiZ9OQvNtUPbAV6DeMC0P50nkV4Z8qIEuhZc6AXykV
	pkLPACRYLkgWlL1OBMmANDMCFtHsU4JJvv2EYJfc4gBzgCO+Hn8g5GhOIT3wrOjpvomoUmsfUUr
	FpC3iFAAFpCGNkx5mGkTGRorJrZWHdhlXZC2f6LgGgjgTdfN4c=
X-Google-Smtp-Source: AGHT+IFa+3oFduUGstIxVZlUPFivKo6G2a3ngt5XNcSYKiNIJHejXq4G+jm39VsJCLYhYa1GOPB0rsCi1WwOgIqzKgQ=
X-Received: by 2002:a17:903:987:b0:24c:180b:d103 with SMTP id
 d9443c01a7336-24c180bdb6emr52728045ad.15.1756888129560; Wed, 03 Sep 2025
 01:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131935.107897242@linuxfoundation.org>
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 13:58:37 +0530
X-Gm-Features: Ac12FXx9HCXftwKC32N7kq9QfFr14TNGWUGwqxvrn45DLYReD-NSj3e0oV3dW2s
Message-ID: <CA+G9fYuKHWwz60jKchZ5cTZVt0p+kg_DLFqHchrrdkUbSCdC6w@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/75] 6.6.104-rc1 review
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

On Tue, 2 Sept 2025 at 19:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.104 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.104-rc1.gz
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
* kernel: 6.6.104-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 12cf6be144d1470c08fbb5844926e5b617dfde95
* git describe: v6.6.103-76-g12cf6be144d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.1=
03-76-g12cf6be144d1

## Test Regressions (compared to v6.6.102-588-gdd454ff512a6)

## Metric Regressions (compared to v6.6.102-588-gdd454ff512a6)

## Test Fixes (compared to v6.6.102-588-gdd454ff512a6)

## Metric Fixes (compared to v6.6.102-588-gdd454ff512a6)

## Test result summary
total: 276426, pass: 257769, fail: 6102, skip: 12184, xfail: 371

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

