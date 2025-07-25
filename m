Return-Path: <linux-kernel+bounces-745395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A6B11956
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37983AA5F70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844ED2BDC01;
	Fri, 25 Jul 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPTJ3eeB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8C262FED
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429386; cv=none; b=pqGo+TLNnmB1XJIFbpD1kxAysih1jxFcSAAkrHaIPYY0vS1t2eL8gLlCIUK8mPLF6V7S+2vCi5u+1x7Mn6fuNhdVhe5NdEPflWN0uPyPyX15OZ3TxVWGj2CmBC/3fhHudc/mqWHyZqttZycqARwl/b55jsMP9sU9gtGB+xqbjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429386; c=relaxed/simple;
	bh=EjB9rdz31V935PwTHxBHCYPbwVDHTu9kCqt+BydQCw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GCbjsnQFebcm9dp0CjWn5mPEtYZcdMPYH4Yl/6FLAs2DhmI+jiDJjDRGotwY9WguuAbn9FwJwD6bZTtkadkaq08r6JNa5eViTGM6LNC2NMPHl1q8E3xH/43M8SVbEkrlBkKnvKxVI+GNXe0F4+KdWsSUrNbp0XooRie4R/Kf3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPTJ3eeB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c8a505177so14711415ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753429384; x=1754034184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6A9eWb8jLD3CX4uWt67BOw6P0IxcLuBPt2ZgUNQsy8=;
        b=zPTJ3eeBNb/ANlLcjG4Oy0CoQsM2+lGu8AXCQBPq3KFwh5MlFmwwiHid3jSBZn7gv0
         xF6nxqn2E3SeVNqeCjMfRaGlNEQdwwxXPn3jXKUBv+d1P7EdZcHGG9Ne0hv6tUGvwtxQ
         XNUqQc4pNaWCeMT+SXrhKKOUl35I651uDAwR2iP/1pJN6k9D++Xg1P/PRMcZcWaMM4Ri
         +iGKEkaykuqSeRKDdgFRlCCVuPAhLZD2dUrBLca5F3h1ld7N/6RKqNehn6tZ0C8i9x1E
         JAdaFD9syDSU0yrdcKUk7igqnE3KZyAVavYAZvMcYNQb4v7Uy+9VGpeA4yYFA3+5u6vQ
         DW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429384; x=1754034184;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6A9eWb8jLD3CX4uWt67BOw6P0IxcLuBPt2ZgUNQsy8=;
        b=TcJCSH+N3llR7gnAlts8ts4/Zk3iN/7zP5ZD3CIvwDhvxCD4t7a0QXtYkWHu+nbeqV
         x3q3gQuKoZjRNnBJ3WU3W5CqrcYSvST5HNTxH+Qhs1TncISYP7a96EFAAGMOUt7xAF++
         nztm1A0Zc43wx1FiuE73X2oLWUFNcdAhD7xfoA+TwcXdrY/CUM0w+9QeiVg6X4PQgSa4
         reWIq+GheGo9WIsQWr2kONe4Xy/d6WXEDGQWWL3D1uclbasxo7oXkCT4Eola+GU3kB6C
         wK3CfC2/ZkzzR0cQlMFwYi6XXEzJMuwM59DoYQnbTC6a+bQ4+oKdKJaeytPAXnKAs4cW
         JLpQ==
X-Gm-Message-State: AOJu0Yz2Coqf8RPYWmmDPuwtt4Rk0GY+GQdaFvfkAwynGIOXLiy/lM/2
	z6V0GLiE+zebGrgwZx5TgPcbxWrM9xYfaFmlMr7PARmA6pMCE0BrrkfsQQy1VweOKwuUyma3J6C
	j99rmJGV8dXj5XJAhRHLocDcoumPuvN3qIkWgXAlsObzRGo/aTqhaNqk=
X-Gm-Gg: ASbGncsWaeSkJKLCUeWKXYRKZ0ZV2xdVgc/CUvGKYP/Y/712LFd+cWj3tO8VOrFXmDO
	9bVcYOhms542l6pqT9hCxm/zUVWed2mvpqHHq0035c5iSYbMH/IRBaJiSnvBycaOFtAAtNCN51G
	LqeNXuzX+b6oqZ8UoNXSzEow+VS1HHPeS2YKXYO0Mmo0mlJBdCWhhIW4tX0j+VOdb+Ku8OUqTwn
	1L8MZ67lqbA+gHe6IcvZbh8PsMmc0V5O7cdS7w=
X-Google-Smtp-Source: AGHT+IEp4yZltn1iEhku5b0BcUr/ZNUbZr9VJ2s3ZKzfyejP8ux9369sbYm6mfNAuhTfixuEu4GOK43HMuYchrNOtkE=
X-Received: by 2002:a17:903:46cc:b0:234:8ec1:4af1 with SMTP id
 d9443c01a7336-23fb2e7c3e1mr15487105ad.0.1753429384481; Fri, 25 Jul 2025
 00:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Jul 2025 13:12:53 +0530
X-Gm-Features: Ac12FXwVCzv5N5zea2jLa_Q7rXwF-illzX5YacV4yqYK_TUIYP730sgY7-VdPXY
Message-ID: <CA+G9fYuBnDVaiZ6Mqhr=4Y2quAsqeZoGfJ158xJ1-Q5HHw=cBw@mail.gmail.com>
Subject: next-20250725 i386 x86_64 virtio_ring.c error variable 'id' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux.dev, 
	clang-built-linux <llvm@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions noticed while building x86_64 and i386 builds with clang-nightly
and clang-20 toolchains on the Linux next-20250725 tag.

First seen on the Linux next-20250725
Good: next-20250724
Bad:  next-20250725

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

## Build regressions
* i386, build
  - clang-20-defconfig
  - clang-nightly-defconfig

* x86_64, build
  - clang-20-allyesconfig
  - clang-20-lkftconfig
  - clang-20-lkftconfig-compat
  - clang-20-lkftconfig-kcsan
  - clang-20-lkftconfig-no-kselftest-frag
  - clang-20-x86_64_defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - clang-nightly-x86_64_defconfig
  - gcc-13-allyesconfig
  - korg-clang-20-lkftconfig-hardening
  - korg-clang-20-lkftconfig-lto-full
  - korg-clang-20-lkftconfig-lto-thing
  - rustclang-nightly-lkftconfig-kselftest

Build regression: next-20250725 i386 x86_64 virtio_ring.c error
variable 'id' is uninitialized when used here
[-Werror,-Wuninitialized]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
uninitialized when used here [-Werror,-Wuninitialized]
 2113 |                 BAD_RING(vq, "id %u out of range\n", id);
      |                                                      ^~
drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
'id' to silence this warning
 2077 |         u16 last_used, id, last_used_idx;
      |                          ^
      |                           = 0
1 error generated.

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250725/
* Git sha: d7af19298454ed155f5cf67201a70f5cf836c842
* Git describe: 6.16.0-rc7-next-20250725
* kernel version: next-20250725
* Architectures: i386, x86_64
* Toolchains: clang-nightly clang-20
* Kconfigs: defconfig hardening lto-thing lto-full

## Test
* Test log: https://qa-reports.linaro.org/api/testruns/29243926/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250725/build/clang-nightly-defconfig/
* Test run: https://regressions.linaro.org/lkft/linux-next-master/next-20250725/testruns/1727064/
* Test history:
https://regressions.linaro.org/lkft/linux-next-master/next-20250725/log-parser-build-clang/clang-compiler-drivers_virtio_virtio_ring_c-error-variable-id-is-uninitialized-when-used-here/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/30LiHiVcyjXbMOk2IAEwlO93ZaH
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiHiVcyjXbMOk2IAEwlO93ZaH/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiHiVcyjXbMOk2IAEwlO93ZaH/config

## steps to reproduce
 * tuxmake --runtime podman --target-arch i386 --toolchain
clang-nightly --kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

