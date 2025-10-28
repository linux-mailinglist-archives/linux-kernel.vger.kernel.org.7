Return-Path: <linux-kernel+bounces-873469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF2C14026
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E313ABDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F830216A;
	Tue, 28 Oct 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkFSOFbp"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9432E8E00
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645986; cv=none; b=Ie1TqwGJoE2ePKLUcWHkOsF8BUhoESQ/tOy3id+ZkOwyfJ6i8iKYRP116Rkt1hZbH0AM5k9BZjn5a/ywCu/Hfj2WZP1ALceUCcTUsOT447amgazjrMVwGkZtrwV6WyX4RAofibxaWpJ5YAS0/MfQ+MMhzGyBt6DH7PSXwthH7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645986; c=relaxed/simple;
	bh=xuFTTSxjbw31IOiYDJaMQMJCph6kYPo7mS0EA8TYPqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFYG6Wc0hRGETjK3otWJ/2syJ5uJdeXCh7i2GpdGtBeYaUW8lwfLmxXHTb0SJRaGqahuGyLQa7ZBKs9FvIWw/j00ksJwtPIuFHf7tXzaCsgIedZcp44G+ueEgFDJg79TedM/JkkU3wVb6jbygQ+4Nypel6ffD06tuyS3dQj0OzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pkFSOFbp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf1a9527fso3007721a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761645984; x=1762250784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnHUFoRvTM2Rx2g0aEwEG6pjIIjUXsEmk7FkUwoNIF8=;
        b=pkFSOFbplo3OUKXHhmPAkPZEZTwBs1mMz4yh6RlJ3nRlWdC1RueV9Qry3HLfm1OtdR
         Zv4zsNnUHplje+5tQdljQoKYmGjtmM8y41dwEUAKqkyePktm4OVYQj7OMranUbPTk3TS
         OSKzXeMxWX2+dKcnNQorXDdEs+ILrwdCQJOOZdF6SaWGzAChD7KvjAWnbUO+K4Ayc78F
         v4F0WltAuIk+rRabbScdhN/nrPGvKJ54jB52lLneDhMOyd6FRzmKd9PkG/JT7NPfeZXj
         0Jc7Pr54HgBU+gr8LmOP8dZ6R+vtegVelqoW6KoVFkayGELYSNf77Ky/epMTrj4w6Uqs
         v5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645984; x=1762250784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnHUFoRvTM2Rx2g0aEwEG6pjIIjUXsEmk7FkUwoNIF8=;
        b=vPlqXg37fUdhFSyBfk0ZqZ0KRwKj5lNsW4fNDkrIXC00BLxJOSvXdftiDUdnnHfJ6o
         DJcSV2PaGQXxq+qIHfNCGbunQgLMHq7GDgXzHVcqlBwnQdDCqWqSEH94xmzzaevF+7UT
         fJQsRJ0k9GNKlt4XaMeO8Tfkhl/pdP2m0lam2gMVKfERY5IsjvdEungTQU+k8tf3TPlO
         ieW4fi7kKBR5E+Y8cb1Gg00/f2lCn0ZcqgVh03qI5/PZ2Mf5uMLl0rF17ydy64aDhmH8
         dHzT+sKi+5h7eyyOHryWgqjrVwU0IMLlDNOaAQex6jLEun48+w996QJvptNw3chYo8xh
         xzXA==
X-Forwarded-Encrypted: i=1; AJvYcCWp4oDtmQe9KjMVFltuSaqTQ1koQQvuZr6RN7sUKmoFCAuSuxXdLY3pkVPhrjII1DBbgHXL+wbmQZ8g15o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAc70RAlHhyIhFyo8kA/+s1rEEBd1TFHRRjiAGUN1BbVfXmbH
	cttV+9QCm19qv3Q+JI6do4T7IQyrIUvJgjTvXsUoIEL/asGxLrg8ZqLIBiq7M5Y+NN2P4Gux4j6
	Zy5L3uYFbfLWw9ERk+hworZitEL6DkG6PRv9XYr5hug==
X-Gm-Gg: ASbGncs4gj/2jg1JFr0qSLno0f5AJJTty3YpTtfCp5i6TPkxL7YxVsB2qrG9KLmdfIt
	xqMma+27Zy5vHRZOXurh0meyP5MdcyBqCXB7nmZqwH83s/owdnOhX+TzkZ5XkT7xob8nFwcrxqu
	3RA/TzDhzmW6CS3KHTxR1/LQKHuJa/anmWi/W5Rym3Q6bAcuxq9SeMmiq4iRJ28ByAV+N/kwRQm
	t4GCrMHDXTUaOtbX+Gr0upuGCr6prD6mP5aaAWO+NrrsQKt9IIZl0DJy/ggwLGzlUiyaK+VKnk5
	0A6TgwcwKaUu0EptxaCjnnra1Q+eB11AMA+03xfRWX3WVCs0Uw8Eb5iyUtXC
X-Google-Smtp-Source: AGHT+IFNk7YjyZeFMPxp3FhKWGRMLBw/14xH9cNXCvEmCNWMRlsReSO4TqKwnIzYH3KF2rc7jFnz2I7eN6c/Ga2/VpI=
X-Received: by 2002:a17:903:41c6:b0:272:d27d:48de with SMTP id
 d9443c01a7336-294cc721623mr32406755ad.18.1761645983775; Tue, 28 Oct 2025
 03:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183514.934710872@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Oct 2025 15:36:11 +0530
X-Gm-Features: AWmQ_blZIRl01loaTjJ3A26avTqa9APme0NL6W_imSqUXdoRXMqE3-Jk1P_3Cvo
Message-ID: <CA+G9fYupug-BDm1C2Szx=-cj=WHLwV4W5VqiW9i8R0y2AiapTA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
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

On Tue, 28 Oct 2025 at 00:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 10e3f8e671f7771f981d181af9ed5a9382cb11f3
* git describe: v6.17.4-346-g10e3f8e671f7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.4-346-g10e3f8e671f7

## Test Regressions (compared to v6.17.4-161-g3cc198d00990)

## Metric Regressions (compared to v6.17.4-161-g3cc198d00990)

## Test Fixes (compared to v6.17.4-161-g3cc198d00990)

## Metric Fixes (compared to v6.17.4-161-g3cc198d00990)

## Test result summary
total: 130764, pass: 110823, fail: 4161, skip: 15780, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
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

