Return-Path: <linux-kernel+bounces-734668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E7B08491
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AD47B8B66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE1206F23;
	Thu, 17 Jul 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr/HrUbz"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68576204598
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732401; cv=none; b=QoLOF4qslxOY+9sQgrpAgwZespsIMMyHzlCM0Iq1vJsD4npck13Qyoa1q5M5L+KXhLDv1zXBM5fwEMf7oDzqZWNL/5KjApQexsnKLjlOA3FoZVPX58cERRiiWEo1a9CE0G16t79iOYC1fbEEb+jxaXCIOZE4YB/kHHqpnLEf29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732401; c=relaxed/simple;
	bh=w/XNXA0/1Ho+Fsc2IZ/94LPEGGsUlTvRDCA0izkaS2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVYWfYgYsUq3pBp0AcN7xzUY9D+JwlWVF9ftSY9QyaXG+1f+gWeLw406KdcgdiLoRq+I8N/wZNbnDW82wDDdML7FwGHrvDPw47huGiw0PCJeZPtBrAzMgvrIuGIMSgIz2aNTYD9eAuGmfk9X75NjnpP6enOry5MlToTjGMfTvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dr/HrUbz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a71d9208so372967a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752732399; x=1753337199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IV5c7k8FkRHMfVKUwEzdiWKabmC2jryJUoHOy4flaA=;
        b=Dr/HrUbzj3gKIkVDRXX3V563dsvakYaM7cpXbxtts71ai2wLK9rMMa4P3jJtaEzlu3
         1NmfN0Is+KO6l2JAYnKSHZZika5SPPG5BvjYJit2QLiUV0qyIRWYHC97FYq9jtMFnhTT
         P658X2INGOLcd2uJiErTCbDCJmbVqub79NijT06jh6/iuDiy1xZ7tTcM7Zd/CB1uPJJm
         UOOV9hykZENKe83vvswfgs06OWjE9HLReYwzfPBlS13JrTkFY3iisBsTJMGUxdj6jJBo
         9JTbU8mPjkCzQ64wRU+rGF0zQ3hVNLY8kJ/9On42lznhAu84brwq1UCRQhhLSY7zhusu
         uK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732399; x=1753337199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IV5c7k8FkRHMfVKUwEzdiWKabmC2jryJUoHOy4flaA=;
        b=npGBjb6GNSfpFq2iyKTlzR1W+HSMGmAt0q+lpR2goMII+K3WT0u34FBVO/moOSMMD+
         QerEF1shN0XYJ5eSTWyVxEm5gjf4ySyRBnCgzL8E3TbKH29SQk6TClb8NL2pz0GGysGt
         fyE/e2UKJgRPKab2wJBZ/zal8AkSXKnKQVo54dH9v57zmcwTzt8rz/Keju+mCyHN60dd
         s4dHxGnKZ6aRQL//zeqic3i1GLl9aGvG3TPajY8ZUmmaX1qSEDsDL9CmyXntFIz54Boz
         1bchUffItcY7B85QQwbjxR/rkSnb4H+9ky3wGBDNouwvG2X8fKCszEA0RGAKnBkA5G1I
         Nmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUoHkuacKX2LwVKFGndV0ebg08jbWBksK22SmOXWyn0mrPIr8/i6RcCd8TfdQyWAQdFoizKoPsUSYb9+Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqXV9Ix8JBNyl+LEmNXT2LSR8X0ez4RaCijC1IKw/TxNsP/v/
	VYoco4bBtZaCSTXyZGWS9kRlwsNYYECWwpsw4cmPSNigTaJoe0krvLLIhftJEp6A5cbA+cgrUl8
	nSVUcJwyi3EdL9uqQ9OWAgX6NCWZWRo3WyIL/VWU3XQ==
X-Gm-Gg: ASbGncuoLvnJ8HDTwuwkH8DZmyufV/Zg1TH/V4cF4zPmZfIZOmPMSRRk/nZTz8Vf/A3
	ZJuL1TuphH0BKmpZh1/LC+6WShFc3MnIk1Os8g2h0KceijlfuMr3dSvqJPCTy83Ya1m13T5LR9i
	NGVjSnk1ZX/Z5CAQnUUeVhBQFi69mVaCW7SbMAIgsuuS0SvxNUlzPoJgq+AwgH3YNh3BSXaRaYQ
	vdXyZFGTbnAu1TfGcMRCeh3sjSHKvq76gHRxCkvSL5CLfzl1nE=
X-Google-Smtp-Source: AGHT+IElD+hWffueY9O2l5MlqFuqIXzGyCKBnFzcuaWJr5IbzPpnXRMfFI73nz6+ivP3Lmv0Z3fyQZbpDdsSYxJ75Ro=
X-Received: by 2002:a17:90b:4985:b0:311:ea13:2e63 with SMTP id
 98e67ed59e1d1-31c9f47c919mr7014030a91.13.1752732398519; Wed, 16 Jul 2025
 23:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163613.640534312@linuxfoundation.org>
In-Reply-To: <20250715163613.640534312@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 Jul 2025 11:36:26 +0530
X-Gm-Features: Ac12FXw75ij4GhIMb8FWW5TzSpjmuX_6qgN5xYsecfajFGkyv7O_tsvhp9A2AFw
Message-ID: <CA+G9fYvnLqHYteeXiucdCJzpcxJ=w7v+RFn1GE2pa_LjFSNV9g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/209] 5.10.240-rc3 review
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

On Tue, 15 Jul 2025 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.240 release.
> There are 209 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.240-rc3.gz
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
* kernel: 5.10.240-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2067ea3274d013cacad86f86222ade38d0f51a7b
* git describe: v5.10.239-210-g2067ea3274d0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.239-210-g2067ea3274d0

## Test Regressions (compared to v5.10.238-353-g9dc843c66f6f)

## Metric Regressions (compared to v5.10.238-353-g9dc843c66f6f)

## Test Fixes (compared to v5.10.238-353-g9dc843c66f6f)

## Metric Fixes (compared to v5.10.238-353-g9dc843c66f6f)

## Test result summary
total: 41250, pass: 31019, fail: 1800, skip: 8248, xfail: 183

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

