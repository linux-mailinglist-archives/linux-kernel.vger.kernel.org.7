Return-Path: <linux-kernel+bounces-788013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACFB37ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554907B1DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F43451AD;
	Wed, 27 Aug 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAMD0AvZ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4E3431FC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286781; cv=none; b=qB4CSvNUm1sO81xLqX8/X9hjJlBkRsQMZ8psYe7HQ7Vx6RxqRhsM14ihsmV2pxP7Braes8RB+8AAfkrEXMLi2JGtBtsexz9jr8oyVLo4FS+YSyU4MRlUOxod8PnFc2EDNC2euBusdSDNCUog55uFJlmOgd/TJTWB6Ao5+6nwXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286781; c=relaxed/simple;
	bh=ijsvinMsyvw0y2W3RvJVA/LaBuLCajMeHEsODWMvu1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9zJ9pR+PnI1t1dhtyBxX9rZ2U27BkMojJscpGfs7YGi4xQm9Fz5Dt0skYs0Xr1NjkTMcKIsDV5N/8O7xx8f7b7rvxBBoTtxAItFhoY5anD90TOtauwcVcVaIPnmP6zKQ5LIxIkxqfQNqSJiGA1IapLm+rP9xPnRpU50C49mPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAMD0AvZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70dc6d81b87so4959516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756286777; x=1756891577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RObNvhRzj14YrAIax+dM99xs/Xf3Y4EHrFUMEOiDAYE=;
        b=bAMD0AvZvmcnYtReOREyVyexQYznTXl5ZkID+GSTUp/bD/q2t2llGjzHsehmR9RE/t
         ifSV3uugEwddHdcIOly7RINEvACk5sW+7CMv12vSgzff0f6owFvdHbRnGYDr3iAfUd9Q
         fQ2puo2wenC5G6oK/yFnHnNDoSZ4gov8DtmBkHF1Pq7FHRhMI95dYYnT/3QQR/BpCbfL
         qn6M26zviwMekdl8uo1SXXBC63gyNy/TTuuCVaBKOtG1Di3YwL6nYWu5w5P5PcqaTfEh
         lZUzaiHvzvNx8zuQblw3XuCGGX0t60GWV8pVX8n7LJJd5fhED2FWKXPD5Y6HZWJLeuVw
         RM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286777; x=1756891577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RObNvhRzj14YrAIax+dM99xs/Xf3Y4EHrFUMEOiDAYE=;
        b=oXYQPycoVRWvrZr4x1Hv+qZWb/qzsz4VZku5FcIpoZWPyQSFsf6NtwxYV/vseJMy4D
         2V7Ux4jAVfnUn6KNzfk82Tcn2CNtUSxeaIrt4+5C43snoLCoRonpGZ/IsD4a0hWxLtos
         JegiPjO785qkNh2+v+QVDsVdoBs1rY2b29uK+pU+6EPqhZYNrDqbYNtU4PjGAdwloLua
         jm3GRR1y0x2WuaWB9sOcLO+fOZcf/ecO3YzCkgXVIPyaTpZRXbEQegN94BAEJRdblCOQ
         zt8S/xVzvi/mytRaA72niz/hulh96Onz+Z3od7bfozAw55GwEgQIqyYeib2b2c0ftdyw
         3W/g==
X-Forwarded-Encrypted: i=1; AJvYcCXGLK2jjTp9dRTmV/pbB+Gk8VPcy1XKpxCOtw1YQwaYc23+gNVrL5JK4hemkLCXHuEco7DYWcY5cZUY+rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJA8a5KQlK7nDDmFifk25Am4l04st1whMJPP0X4RHPNHhaj1c4
	RgpjPa/D1ml1ao7a4+svqA/TSWXaFEgOoDubnYDBoBdcUC5TMbFIoR7l7vdGrnyRW1F5iqgEZAk
	bBror12h3ZFyv93VapvEsWB4yFRhHnH1PiNm0c97M5Q==
X-Gm-Gg: ASbGncv8roCnJVbFK21M6plspIS1E2yCtdZo/jCUpXcEDdwte/BsRcsMmhR2ydLm/iL
	463RXW0HHxsFerDQt+oS0ZNjZV/PH8l50Cx/B9yyZX9kope2HB+fpzG5G9NQHH9QhMSTXeyazT9
	2Ar7/eGpibnG852OOWQa0sGP2rKwY55X2fGb6/Iy1J7FVxflBnLpdh3imgoc67qdy6GWaooSqrf
	9hMQkalX0DmL9E7O8Ht7BNsLBM=
X-Google-Smtp-Source: AGHT+IHjJ8ojfehejC6rUtG2n9YWVWEdlo8h3+JG4hp5aDstD/xNsnAnq5uvb/MrWZkcfry6UfWdzDOZp+dxXTeBdvU=
X-Received: by 2002:a05:6214:4c86:b0:70d:9819:8799 with SMTP id
 6a1803df08f44-70d98198c61mr126143366d6.6.1756286777207; Wed, 27 Aug 2025
 02:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110930.769259449@linuxfoundation.org>
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 27 Aug 2025 11:26:06 +0200
X-Gm-Features: Ac12FXyfQSMfovOH5u8fKvG_4IT8L7R8HIzuMNFjhYcsK1bP_QGHDLPsal_-a3A
Message-ID: <CADYN=9LgcCC-QLMpQNuKq4wW9iOqZqPrNovEYY7r3=TRsidbgA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 13:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.149-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build
* kernel: 6.1.149-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 3c70876950c1fcf1008baf5be67b598127de7679
* git describe: v6.1.148-483-g3c70876950c1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.148-483-g3c70876950c1

## Test Regressions (compared to v6.1.147-254-g7bc1f1e9d73f)

## Metric Regressions (compared to v6.1.147-254-g7bc1f1e9d73f)

## Test Fixes (compared to v6.1.147-254-g7bc1f1e9d73f)

## Metric Fixes (compared to v6.1.147-254-g7bc1f1e9d73f)

## Test result summary
total: 226713, pass: 211004, fail: 4615, skip: 10850, xfail: 244

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 21 total, 21 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* modules
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

