Return-Path: <linux-kernel+bounces-862709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A83BF5F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 938314E9752
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F82F3607;
	Tue, 21 Oct 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgIsgCF6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9B2E0B69
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044949; cv=none; b=Ags9sJuKqVJppYEx78fLfdNdTmCECW/8f5W5eepBHyS/mUVLf8iON0GdJtIdID9wugXvTUldX76OOSC3b0m6pYtvGrjA3hExvT1BJfDZNkiOByYgW9NA9NGknTsVJIBMft8doMaEBpwCDgSQ4zg8qeDtXbyhQPMyfmWyjhdP4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044949; c=relaxed/simple;
	bh=0Jj/oz3j5238pHi/+PUT7w3mAJ0abt9UDzN0aejE3p4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EnC4fg5cC02EkL79/DBKDFbVsbNvmXvEvjQ3wKMDgIOBohwJ6J0SCn1R9d+02rHZLdP2w22LfIXEk2hsJMkLtKVeUyju31wJHhuy/I8WI2zH6R+Vkc4+Pm2tGj0s+uYXp/RySWFmzbfBiJ/ZG0Lca2DLygTbap0zOwc85MdkRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgIsgCF6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290ab379d48so49720555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761044946; x=1761649746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clvqVveEl4VakYM5nZd2uVSfls27BpwOnq3AhL7nZXs=;
        b=DgIsgCF6HAAgB51XcOkXw9wSe4kQSyViwQDQp0/M1NhrobdURa7+PNtmr/O9lKaZ3k
         2w1lD8jLkmwFFdW3y8v6E3F2+Lo983W0BIf6PHOs8zAvUaVy3/+kRuSE3DT0xiCauDWo
         NKRTvC+G7+IAO0pFur1WpUV+Z03HErhR7Fz3QFPk9tY8UIz0SheWGKkzbLnFgA8WhuSd
         PArn/e61Fzfb0OtOBf71aGfmvJ/FZCaW67aA4GkIJLSjEV0+QsJYlvjK/mkIQUWDTBTk
         JF2s4rlER2ynVr9myjCofPKLSL3zRhHyDDAAASzkLc8VnNt0JDxz281WDLJqygGhVupN
         FSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044946; x=1761649746;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clvqVveEl4VakYM5nZd2uVSfls27BpwOnq3AhL7nZXs=;
        b=Aok8VaJ0rOEEY6s5qkPl5d0+IS8jzvzOHPIem5U8haxXvkUmbv6m/q0MPLfrHpf8t4
         fp4lzojxB/+dK45xiEGcnAp3GNCsfJw8kaFSAPYYVuX5bzzYuakPKS9ocLkCr1yhXc9H
         PdU5ke/+adUaBaNWMPGUymGgWAY+XNIWm9u37P1pj0HiDZMBL0iVBOI0VGIgqI5REAd/
         2vtD6c0JYBNyztXT/7SfnkTuXiEA55FDl3eTcQ0IRdhDNZ/EBpYCUOfiag5Den2ULnOb
         hzHBltunGdRf5nwunQwQIMjMu/1IuPCW9vIQFz5tRtz24oYz4CDWjbLM1oIRNjBUBfYH
         zAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzTweYRb7oiqJgl0a7mZTG/dIFxU/RgV3oL1hY6KAlJ3q/DnoGJIdXqxFFLQUP9so2WcrLtZ3Wcdz5sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyG9gA2t8O5Sn0fW7DEk/B5IkOXxYjM97+7zjhiVYtreuFmqAh
	SAkmP4yQ3TtOvg1PuhEVAJbRqYFtx90hOAaerweTtw/Zh74h7DUMHdmshf+g/IlUoMJik3A5Xkc
	2fOeAe9oU1xJYnCCaAdESMs220l5jgfKHzfSmRAHw/g==
X-Gm-Gg: ASbGncuWp949M1Dc68GNKM6K6BULw3djdarJjOtQo6Qg7GMU7nZX91HbQzqPclOMCkd
	+Plwc3SCLVQxZ5rGANNoxjcIrK10VkTQGAZJw/E+k7KyJVwJQnWWyIgoSRss+t584dj7FlPqnRV
	Vo9oKDL+KKx/bryHUB3ZZxMGEuVEea5+QnNCLM55jVd7fHbnGZfqxDsqd6xBoP09ePwYiywEOwS
	axXnmk/a0dnzs35hlj7MsMrvkljpanefqvRiposW0qrYKjk4AcmF4uMJajDp9fIdKi6GvAgUuCC
	mPApKWVzL4QIXS3b9yaF53+SKmIVpuAPfrpAbpaxorl5vNDMQgFtEo1+zxre5vhlhvva
X-Google-Smtp-Source: AGHT+IFDGXUp9tKVVOyQcA7+CvoT4bVfCCGV2+qBmOVEr+wXy9Mo7bFJyDSAnV0yMljTfotevCIwB/WqStf9CbjQvMw=
X-Received: by 2002:a17:903:4407:b0:27e:ef27:1e52 with SMTP id
 d9443c01a7336-290ca1218dfmr195009785ad.35.1761044946535; Tue, 21 Oct 2025
 04:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 Oct 2025 16:38:55 +0530
X-Gm-Features: AS18NWCNxSm7rurPtBIV1Ywyd2Z1uJw_dWK2NUhN3UHurWzm1qYuCb5CL-5txYM
Message-ID: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
Subject: next-20251020: selftests: helpers.h:10:10: fatal error: kselftest.h:
 No such file or directory
To: X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"BALAVIGNESH #" <reddybalavignesh9979@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The selftests x86_64 builds failed due to following build warnings / errors
on the Linux next-20251020 and next-20251021 tags with gcc-14 and clang-21.

First seen on next-20251020
Good: next-20251020
Bad: next-20251017

Regression Analysis:
- New regression? yes
- Reproducibility? yes

### Build errors
x86_64-linux-gnu-gcc -m64 -o kselftest/x86/single_step_syscall_64 -O2
-g -std=gnu99 -pthread -Wall -isystem usr/include -no-pie
-DCAN_BUILD_64 single_step_syscall.c  -lrt -ldl
In file included from single_step_syscall.c:34:
helpers.h:10:10: fatal error: kselftest.h: No such file or directory
   10 | #include "kselftest.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[4]: *** [Makefile:86: kselftest/x86/single_step_syscall_64] Error 1

### Suspected patch
  git log --oneline   next-20251017..next-20251020  --
tools/testing/selftests/x86/
  4d89827dfb274 selftests: complete kselftest include centralization

Build regressions: next-20251020: selftests: helpers.h:10:10: fatal
error: kselftest.h: No such file or directory

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Steps to reproduce
  - tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-14 \
     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/config
\
     debugkernel cpupower headers kernel kselftest modules

## Source
* Kernel version: 6.18.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20251021 and next-20251020
* Git commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
* Architectures: x86_64
* Toolchains: gcc-14 and clang-21
* Kconfigs: defconfig+selftests/*/configs

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251020/kselftest-x86/x86_avx_64/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/config

--
Linaro LKFT
https://lkft.linaro.org

