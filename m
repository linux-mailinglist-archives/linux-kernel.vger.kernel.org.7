Return-Path: <linux-kernel+bounces-873504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705B3C14156
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D1F3AD1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EC2E6CD2;
	Tue, 28 Oct 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlzpthFo"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FE2DEA68
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646833; cv=none; b=nXl299HPBZ9qi8aaC+ombjbr/weR0jD0LjI0b450ICc12I4ctX2I9bhqKzlcHZpfSM/Ibm3itErIQ7eS/5ppZZfrjZpPuuuavAttu/znfPZrrw3npnb4OIoVLI6K9HQ2weKboO11SLh++hIijoq8Jo5JMaZEVauSLK7MrNNVqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646833; c=relaxed/simple;
	bh=eSFNiXFx43S3A4d+ejmP2xbSVcwXKr0EzyNrmVQhHKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aryJOmS4xMnDUySNsJQA6iEKXSGAiAcMScLQZc74ZuIRanltYC5FjAnGVZ6X/fqRu7/R/fRJ3P/MA+YuDBIMY9OLA/Agrv0txKdyp8Hd0oxHfrsB/0A2uXUZIkvLlo/zEeHlf3LkcOmWq0Yu2BwwOiNIhOc7WHHbZO4eXwzjZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlzpthFo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550a522a49so4818763a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761646831; x=1762251631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq4sVnkdiYdepHbDyI7xtiG1vW7SU8QixEUbKdub3hY=;
        b=vlzpthFoKskHFPV5ONM2aTmJqawhUFAuX5EHpIcMkKuLCZ79x3gaf/CAzyWAbFR9kh
         3PfOk5tOKeSj3Oxcp56eYlDOIW2k5CWZnJgyBNnwxuVczAj1qa0ZIKylLC5M4edNeBkJ
         iWv/URg+HwjBIz+8h6Elhjs6ponNtw2N1HVIeQAyuhr7tvBiaUhcsw9ojvcQ/ErRxYLW
         sR1ggpqixWLdZCah9kZuS2cfXm979Vx1emVHaPoz+LCFdeCOZMGzTFRgymMEfGOhmayb
         mlR3NMJEKFPA6yjBRU/UGCanwtYohMQf23+FdrfW5hbHlMO9/XOi74wvLs0xcWkbKOLy
         iGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646831; x=1762251631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq4sVnkdiYdepHbDyI7xtiG1vW7SU8QixEUbKdub3hY=;
        b=c5Bgm/f5daGX6+xyxhfRbqmM2Lm7G2NFFSx5v0GJv5PknEGq5cLlLbJS99qYysdTSf
         Vf18YQKMWOSQwf6GI2IX5ibGxVKU+QPCeosVG706tKWGpnmSwScr+cxvwr+cRqNRzXdJ
         Az26HRzFsT/LByij2Al3a2poPJWslEwfslqlkbVqOoDfaSQ31K8biK/nVwkzrtlUmPSX
         uISILU3Dq1eQdzIa6Sya6P5AWsZ1dhfYHttcNbOlsQUCM+HWq3013rrv2+uGYSpLNlog
         +GW3Xrd2DilklbTmQ4sjQVJojTn4kSuSls5hkMkLhNiH+psizEKgDo7bUbv1QxosImib
         pIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnIB+CaOBPyMd3AYJgzHihM88qvFuXdBt//FVDqZrgjGAGGBORU0YZWWTJ8YZzKWtWKMqDcfLWbccZqR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUji80zrpmE03CCT8yzU406BsrlLeKrxOpDcpoH5jJqI0x5pg
	zyoCSJ97yMULKl+wwor4ljF7U+OrKg3+bwb8BZXpr+VFrTLd2xx1tv4vSSQrTdd9CD0DPG8Qy6I
	8JQ7uDnqUEjVjtDF0uuWCRPuajF0VNCNP62zukBPAzA==
X-Gm-Gg: ASbGncsJ5SxJWMQNpO32hdq9d+nB/fcFmIT2W4E92j3bldcGFEV1A03oSyQmk2MdFvK
	2diNpa8zvewVQ3xQXSd2o6xugm//OSIAwiK4I9Zfgovm7C4VbX8jl5jrJJjr0ZMwqzfqChCbpcM
	4iyUyfurPMUyfBdslHbxykqUiPqrlHPuaHiu7Q4QGCBUOmVre0Omcso4ZOFt3CnnY0FOYIsFK1w
	vZbwl5GjZMSbDlax2TDotisl7maSTH7yJMjxozV/XatupJlUFzGJpAk+sMqmzqtqzPmFjvK9Gm+
	a3hFMStj+kte+zsd4QfaEEhL7Ca07EJzCl58PcYG1JxZ9GBdxA==
X-Google-Smtp-Source: AGHT+IFldgoZnTYpegshPt3WhgAJkKOgC2UfKDSM7I9r7rEprRzETX/+HEGXS3kOWvKcTAnMGtvDYT3HmFJ22tXW93Y=
X-Received: by 2002:a17:902:eccc:b0:270:ea84:324a with SMTP id
 d9443c01a7336-294cb507cdcmr34772335ad.38.1761646831072; Tue, 28 Oct 2025
 03:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183501.227243846@linuxfoundation.org>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 15:50:18 +0530
X-Gm-Features: AWmQ_bmdgCG3iPCBh-32nnzF4A8j0YtwyvHQpjYBoywaDuWUqsbGxGX8tLliR6Q
Message-ID: <CA+G9fYu9EFx08rvnjceS1jNhfjB3BPDtH-ceLuXYdsPtfntibg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
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

On Tue, 28 Oct 2025 at 00:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.158-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.158-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f6fcaf2c6b7f6ed4e6ee10532555e1e16764c435
* git describe: v6.1.157-158-gf6fcaf2c6b7f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
57-158-gf6fcaf2c6b7f

## Test Regressions (compared to v6.1.156-169-gec44a71e7948)

## Metric Regressions (compared to v6.1.156-169-gec44a71e7948)

## Test Fixes (compared to v6.1.156-169-gec44a71e7948)

## Metric Fixes (compared to v6.1.156-169-gec44a71e7948)

## Test result summary
total: 86941, pass: 72310, fail: 2561, skip: 11898, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 132 passed, 1 failed
* arm64: 41 total, 38 passed, 3 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 10 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 32 passed, 1 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

