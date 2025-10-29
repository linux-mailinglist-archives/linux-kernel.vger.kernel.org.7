Return-Path: <linux-kernel+bounces-875343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21471C18BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B3F400441
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38AC306B3D;
	Wed, 29 Oct 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzYlXslg"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9B17C9E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723564; cv=none; b=DWGd9sjYQzg8w8VDIFkLpn88aqcWADDTzx6qx0cM4p990xNv+gpFrlkhq304JzxzzRI2z2erXEGB3TDQ9sf7SschgjI/z0LvkpukAVmLlqW7rQxkQFQAEfNcIXfR9Wc52ytWehSoPFzLi8V4Zam0JjMwfNH5zkWDbbElF0EWLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723564; c=relaxed/simple;
	bh=/JFh+3LPy60YlqQVGEPu58K5Q/bIPhCMyyVlguHwuqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbExxc/Hvh2wJ9jDPkAKzr4fEFjDICLTTeX/jmL2lrtAxKiH8tv4xcIuZvdvmw5ccJeGXZsECj19cxnj53OOxjR+46x+UKcdPnXEE5f3B8Q0vREecuJf+GxCDdtMZGX/kh6wpsAEXwya86Kmft7iwiSYcxADex8jYDjjrsSOzI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzYlXslg; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e1a326253so7350130d50.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723560; x=1762328360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDSTvm6I7Z9dV0aw5wR/XsQb+iBxI8+PuZvOk4XUwuI=;
        b=yzYlXslg/wCm+RHtuA1stQdduKfd2DgpUbqTeaRhMi4UpqDuNyx5nYKA2yMtvDRrAg
         SasEVxZwC78I2yqD6RtzS03WKjFfKYksZcdfq/MHRAXPrHdn5bJTzmJjE0ogFTjMkfST
         ltSviBTI7LCbGIj5QiGoLpzUfik21DZosDICQI4hCym5/Bpy9K8uZoephqtQPqSjUYqZ
         WsHJVuWvh43XO7bBQVz/Xim4rpawn/JdZJ6lEHTOThaqFerLApmeqi0G94S5LZjafZR5
         d+8VRZZbJHnfyBGUaBRgpBCAR7n5/jYFG/P5C8HI0V/YbNOmm2b3WjsqlmpgJ2lY2y3q
         QTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723560; x=1762328360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDSTvm6I7Z9dV0aw5wR/XsQb+iBxI8+PuZvOk4XUwuI=;
        b=HU6JffQZ4Qgmyj6oVCzDYj78aq+IhPrEqSI8C7xNCzWmmFEmmLlZdI0ezTbh9xuls/
         2lDYcJFTJUFXIe/1HASQgjrG7yrKLpZ08+aoLhVygSReixI+xuMxMBQ3MCPdRKWVOJYI
         qpxP5r6Wsja6TmzJQpWM8MUGWWmgiMpAIt1MMqsatxq5F+VPKgiVmeM/0jXNjqlGXS13
         UfgZbKvlOIi9hU+r6T7FYM/zw33nYzZ0SLwh90hij+wjY3tJZesBXyQ3sxsbmKuuNuk7
         Roz0X7jvW4p6sM8JLnqwCtsBpukW9JG9NQCesY0baNDqLWNudqW0gU82XC50hjD25991
         gzgg==
X-Forwarded-Encrypted: i=1; AJvYcCW7f83nfcRODRwsdbvyVjSrnIn773I6reLMrHRdZj+mT6ktsgjVmAnIpIwDlvFyEfuhqZXB9NByumRFcIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCy/AgGpL5gZRHMOzP6vHPpNVJt71F3QbYo2EZJy7YcS80L5a
	FRRAp7RE14g/En16zDJrCbGumcgp+0LFzHZq3kvJZ4kHd1iw6eKBIhsQwS0RxJrrzEO0cljDHdd
	V4LyJqeUwWvs4a9BbtjJaohdK3C+FUQXZ4hFB9oi+Ng==
X-Gm-Gg: ASbGncv8cJxByuC6JW64mZp1o4pIpzYQKw4omL7A2ea/V6koRHM9CnVnpTwWuT6EL7h
	UpkH3tNNZwGV9TsoJXVtNYw/Zbk5tglmVdzLQ1N0biGoh/jv2GPqcfUvuRxdtVh79PRcsYyhwOP
	qoev1zO0suU14y5i5tItoihTqPm9zxhUg9itQ+N9st7IQK5+yh6YhWwCU8RfOMgIDPoWM6+366C
	2l8N9sBpRSkPR4mHVKo+fwhN7BgV7C5btNVbE9xacSboQsRyGVd9QRbbHj4p3Qb/f80D2cxGOFa
	hunybyqbrZc+u+3AG2VmL+k6bYPyc6KNEwp6q6X/dOyqV6rZkw==
X-Google-Smtp-Source: AGHT+IFq3zS3MIyOP+iAVuTj7vgZAAlt1EuA/KihYBvKksT4hVlGzpDdRH7eFvRWtTh03xV4G8vGdBBCEp4TqjS3jeY=
X-Received: by 2002:a05:690c:e0a:b0:784:a6d4:dc21 with SMTP id
 00721157ae682-78628f9f39cmr18988517b3.52.1761723560103; Wed, 29 Oct 2025
 00:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183508.963233542@linuxfoundation.org>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 Oct 2025 13:09:08 +0530
X-Gm-Features: AWmQ_bnvWTk6H8dKB1rQNe6WlieEdRYXn2d2BWlHBWPEkwzDm1pTtkWgdvJlqao
Message-ID: <CA+G9fYtiz2b=BQOjCFKT=m6Cb08R05t3w881DMa8R6k6Mot6pw@mail.gmail.com>
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
>


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
As others reported the following build warnings noticed 5.4.301-rc1.

## Build log
In file included from include/linux/list.h:9,
                 from include/net/tcp.h:19,
                 from net/ipv4/tcp_output.c:40:
net/ipv4/tcp_output.c: In function 'tcp_tso_should_defer':
include/linux/kernel.h:843:43: warning: comparison of distinct pointer
types lacks a cast
  843 |                 (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                           ^~

## Build
* kernel: 5.4.301-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4e89a6191515a2237a64d19f93bb359dc7f5f573
* git describe: v5.4.300-225-g4e89a6191515
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.3=
00-225-g4e89a6191515

## Test Regressions (compared to v5.4.299-82-ge1a2ff52265e)

## Metric Regressions (compared to v5.4.299-82-ge1a2ff52265e)

## Test Fixes (compared to v5.4.299-82-ge1a2ff52265e)

## Metric Fixes (compared to v5.4.299-82-ge1a2ff52265e)

## Test result summary
total: 39799, pass: 30266, fail: 2455, skip: 6960, xfail: 118

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

