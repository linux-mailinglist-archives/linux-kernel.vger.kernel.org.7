Return-Path: <linux-kernel+bounces-664355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F441AC5A73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E097B0DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B92820CD;
	Tue, 27 May 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kqad6loZ"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5352820D8
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373026; cv=none; b=hQaU2RuSO6hsfE9pG1PJqHqLj/fiGDrVZpGQ4eF3iLGk2V6NH9YH92dV+xBATvXO0wQ02s0CttqxlN5vCWADWjCd0Du3uBrCTR6xYlIZNtrzwoASySlbOTnO5T3MZxS4wXOAioZlqxNvcPtxghsGZMpEGXA81vWkHQPo9H3idOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373026; c=relaxed/simple;
	bh=9ZjEEkSo7oamxUV8/kkmOW4raxYWt+MpkVs4/JaB+Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnG3jyL9Q3rMlyHgVgFPNbXe222tOzr49I54x2GgFRNQMkqhnYjKrDjdsQaqz5O5sqMIgpIZ3TkfU0/TjI6DijSGupBFtlFo7G5N1gKCHYAb/a3ZjOtawIAOeRolPSVt3AuS8ffqJEfEhSOJreXPXH8j8ieQ7y3doZiCY4JR8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kqad6loZ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fabb948e5aso2039476d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748373022; x=1748977822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzh5gGj0L9x9hiYqVH28xNFh+kP5yncVy/q4QDCe6rE=;
        b=Kqad6loZoVZUMdee+yHvI7swoH1LtUCIUq4Osh/JKsuC4DSauoABCwnlodt6wFFrcS
         JexI7Iua/JVWfqtQv4z3YTugWvAklWDI4g427VY/R7wv9LF5fQElG+W0TnxIcpKUYZc8
         QDPPkKLfmoDo++t5cxgP1sk12pjxdU0Qdi/nUAWrMzv6VvyhnDu2Llw5ABRbFJRxj+HK
         X38MwTHrDMosI87V4aFgyW/kAcP4a2q6KinxU5m4kNMhcUkqaBFy3y3p04e6Qmc66yfV
         05KLdb7KAVX7MZj8MhgE0mUYZm5a+M1ZxiBwSlk6NeAiMH1lL4kZke0DkqUn/8cOLQOk
         KKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748373022; x=1748977822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fzh5gGj0L9x9hiYqVH28xNFh+kP5yncVy/q4QDCe6rE=;
        b=mOOzNCCooJMq/9OuX5ZFN2NJqAGSm94OHtu6YouMyyV8VykBPd/U7oWGp7dqHvekr7
         4h9P580Ss2IhWuS0odHQ2fxRTtU0EfeC3TBOiybiXfu5YAhKliSOLfzGRd3S1JqnLsIY
         C/DH9Xd+TjPe13IJ2KdqMSBA5vAAGS8JSmzVPYRR8Cx0vMTi4go/Y525XAs13LKcH6jo
         jxPFEhx3vCLC+K7SDKNGviEsyUUOo9QQQEFsvxd3YPtCOXs4eiHXKvzVwNV8hPbRqvUF
         wONIkoTBcvGgT/6LTSYuxMuLtDXuQpPvDs9hUNhpQS9rcg6PAVEBm+zsJU+0enZRnELS
         13Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWYbjv2lsS078syL4GcjuqMU7EsxUDkTNdeMbWhtpeeyRsqZceMdRTRvsfVKT2kXCPgDjPXpogxJA5uoWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72hQTASyKjRV/Y3om13jtcYtWdKXqnJfQltwMxFEMKYRzzHWd
	JhMxZiwsO+YPZri5hDry5tnWaZQE7KlbpJkyEKqnAmlwSAyLccyUg3eNfduYxwio7iks/SFY0X1
	FEE1RIgmYSSPQU0H3PyuJJuybLkLelTD/fedh+r60MA==
X-Gm-Gg: ASbGncsDehip/CFPFaAiqdpi1oww3uc0kEUpirhZnropyIfftrX/6mpEVgkTOoOczrR
	rViUVXUtqfCG9tq4uhMNOB1K1NbIPJ5839RHSlWAAC3lYluDvzpcRmW2wi5/hQw2QeCmKbB43tN
	F1nd/IKVvvGStE+mFuqBX2jbO7P75VJi8bm/xuUZ08hd9Fi8grvwUCUkc2kwcqT0dc
X-Google-Smtp-Source: AGHT+IEAyP4bFrFlByFxZhysJxt3eVrGqB4zTaztj4w2bAbFwdvJbJSP992jlIyDkWtuLoC/HK0y4GpyUTMG9dvXd2I=
X-Received: by 2002:a05:6214:c6f:b0:6f5:426c:1d1 with SMTP id
 6a1803df08f44-6fa9d2a2b0emr258744886d6.34.1748373022639; Tue, 27 May 2025
 12:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162513.035720581@linuxfoundation.org>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 May 2025 00:40:10 +0530
X-Gm-Features: AX0GCFs3iqXVh76ekgUOxxAimf4DD0DS3mAuvBBQhLP26ciRAJB0Gnl0rEdKb8U
Message-ID: <CA+G9fYsvuqySTdV0Yqi3i-cyBh6j4Rw2_ze46RSUPrz0sbA2Xg@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 22:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on S390 defconfig builds failing with gcc-13, gcc-8 and
clang-20 and clang-nightly tool chains on 6.14.9-rc1.

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: S390 defconfig crash_dump.c use of undeclared
identifier 'NN_PRSTATUS'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build log:
---------
arch/s390/kernel/crash_dump.c:312:8: error: use of undeclared
identifier 'NN_PRFPREG'
  312 |         ptr = nt_init(ptr, PRFPREG, nt_fpregset);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:274:56: note: expanded from macro 'nt_init'
  274 |         nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc),
NN_ ## type)
      |
^~~~~~~~~~~
<scratch space>:85:1: note: expanded from here
   85 | NN_PRFPREG
      | ^~~~~~~~~~
arch/s390/kernel/crash_dump.c:313:8: error: use of undeclared
identifier 'NN_S390_TIMER'
  313 |         ptr = nt_init(ptr, S390_TIMER, sa->timer);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:274:56: note: expanded from macro 'nt_init'
  274 |         nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc),
NN_ ## type)
      |
^~~~~~~~~~~
<scratch space>:87:1: note: expanded from here
   87 | NN_S390_TIMER
      | ^~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:314:8: error: use of undeclared
identifier 'NN_S390_TODCMP'
  314 |         ptr = nt_init(ptr, S390_TODCMP, sa->todcmp);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:274:56: note: expanded from macro 'nt_init'
  274 |         nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc),
NN_ ## type)
      |
^~~~~~~~~~~
<scratch space>:89:1: note: expanded from here
   89 | NN_S390_TODCMP
      | ^~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:315:8: error: use of undeclared
identifier 'NN_S390_TODPREG'
  315 |         ptr = nt_init(ptr, S390_TODPREG, sa->todpreg);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:274:56: note: expanded from macro 'nt_init'
  274 |         nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc),
NN_ ## type)
      |
^~~~~~~~~~~
<scratch space>:91:1: note: expanded from here
   91 | NN_S390_TODPREG
      | ^~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:316:8: error: use of undeclared
identifier 'NN_S390_CTRS'
  316 |         ptr = nt_init(ptr, S390_CTRS, sa->ctrs);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/s390/kernel/crash_dump.c:274:56: note: expanded from macro 'nt_init'
  274 |         nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc),
NN_ ## type)
      |
^~~~~~~~~~~

## Source
* kernel version: 6.14.9-rc1
* git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git sha: 10804dbee7fa8cfb895bbffcc7be97d8221748b6
* git describe: v6.14.8-784-g10804dbee7fa
* project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.8-784-g10804dbee7fa/
* architecture: S390
* toolchain: gcc-8, gcc-13, clang-20, clang-nightly
* config : defconfig
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xgl51jcJfVGQZw8dKSuEJNFtd4/config
* Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xgl51jcJfVGQZw8dKSuEJNFtd4/

## Boot log
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.8-784-g10804dbee7fa/testrun/28574235/suite/build/test/gcc-13-defconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.8-784-g10804dbee7fa/testrun/28574235/suite/build/test/gcc-13-defconfig/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.8-784-g10804dbee7fa/testrun/28574235/suite/build/test/gcc-13-defconfig/history/

## Steps to reproduce
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

