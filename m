Return-Path: <linux-kernel+bounces-745430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD4B119CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD185A165A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD582BEC41;
	Fri, 25 Jul 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPKnR/7i"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139912BEC33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432155; cv=none; b=IBl71wLSc+NYpRARCVOpDXDUMaGAqmnn8BA741ivJKFTSgLUoSzHhkw86YU8ftg8JLqU0wTUjHgWIoXrGRTf2wYY9g6IbLQ/42GKwJ/sdHdh3pko2QpxrNLgdkemNSoR/iuDrEYOlC9g730Zb9JT6285ImaZM5skCYsEBRBy6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432155; c=relaxed/simple;
	bh=Gzfs8ekUj7A3y/LG9Rcdqmp5q5m+aBsb1GKoNaKBk5M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R8qngg86tSGzWD6xGb+VQ5oPSyxr+ZxQfbkIqVMaCwD48zw90kPrYMXsmHumnhjljhe6zHXwKRf8fozj7EGNEHQUPDXYgzKLHKUu3c2uvUzBXr1R3TjnmnURrDjaLKLpAjOBKZsEkSCNojVvOJ79oWO80/lVd9k4ZmTvuPr4JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPKnR/7i; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3f7404710aso799598a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753432153; x=1754036953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6SlG4p7PzGNJex+qeliN43z/Wd9scMaF4+MTCIpEF4U=;
        b=aPKnR/7i/8GfvGb23PZssKWeCOQ+YnbUSDo8n1ymEHnN6VaBcDI388T00svNojF2/g
         Zyy7DOCTSOoU8BDRdA8r55gt3ythmN08kfU6WJfwE9qqNIP35Cttqn3YbqxR57xa/+tq
         cDkku3ER1wKUEBHjGbrNqIyfC0bYGPciqZKnT+mHKKfQ2B0mFxEYcZTPSu0Azrr9Y0gf
         2S7b42Io2h+vJq/uRwFEa+6T+Ouu8EvDVRC2xVdhq93dvTPoFFdXt7YZkvu6NqOyLmkN
         KPxCxl+LZDPvhw1i4w17M0t/dCq7xZVj8z2mnvLOvn682E1MdpediUziaFrRHqvUGwu/
         Y4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432153; x=1754036953;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SlG4p7PzGNJex+qeliN43z/Wd9scMaF4+MTCIpEF4U=;
        b=EGqqGwVY/wAVn4WyBTe9IF3TYDqZ0CQ4tYCwzmrLXmomqMe0qcJAPSTq/SS9RNr+RD
         ko6hs5N3wvLUw2dn2zGNmR6ZpHBw5KijaDs1is2JHJY8j8vR9Ies+O2XWnGVqr7g2icS
         YYv0b4R3sw/2tFJ9gBZPhqn+FP2yF91jvl7PN2wlEZi/GsEON8vRsmigvz+XA8WM5HzI
         TaGoqSe2YUBGWs05nQ4BffN0m/NPPvXtB7/h5Hetx6+yFtWUzdLrrN3RjF9dhjv1p6mQ
         GyBwQ8cQvO9vTkd18Si2BjnaXucOW3sM1OjEy5f0qfnmqJPgu9RjTT6Y2TdprLe+P/jk
         q8HA==
X-Forwarded-Encrypted: i=1; AJvYcCViI0ra9E7DMMcrpXRQit4v6xEF5NWHuLfAXMIPpbHwi5VpbNYzEfhgpD461rKRGmYykbnlayNS8s111v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvOEr9vLADi7T7CmRos0xCXQvxooaUOfRxV2Mcr3m8KcMhCAN
	mw5fBJKbFv/gYPretAG51/nDcYPw0nOWoJEMAPmIpc2ZD7U4SyXX78zbk8/g4KjaL/RiaR8aUWJ
	nVZXLui35jDwEkEKRHIBgjteXGKMz0lzVQJr0/er9sA==
X-Gm-Gg: ASbGncs3mzb68SWB7ihvyi2AwY9OMv3CXh+kswMSHeN/E23k73tgmIgDet62Gis+SsL
	35gwUWEqL9Ih9ocTKsEt6G+GfL50/s5K5J08WXq4+P9sfaAhDAFFgUy0Y/WX2YXAlkKZecs2sDX
	srn3C8qYH7C8OOQ5Zol5ellJxG3KNIa6xhuC9u440GBAdQoeZB7lM40+tmTuWPcaOP4FkwJ6r8t
	R8fum0rJv5mtAWORYsak4jZMcVuX7Y+vfSco4c=
X-Google-Smtp-Source: AGHT+IFSOXd5d9LlBPfvNONAe739PRS1T7pG7hnn8qLMr/8kfPoBeVKvxu7CgmKTzBsjPnN0S5gW0/AjsKP4cqXAV5c=
X-Received: by 2002:a17:902:ea0e:b0:234:c8f6:1b11 with SMTP id
 d9443c01a7336-23fb3167767mr14742145ad.44.1753432153221; Fri, 25 Jul 2025
 01:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Jul 2025 13:59:02 +0530
X-Gm-Features: Ac12FXzWcEWmXcr7ADQOYVMNJ8JhbU_ZioQdsFR-c7JnlJg189CYfO6gbl9zBIk
Message-ID: <CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com>
Subject: next-20250723 arm atags_to_fdt.c undefined reference to `__sanitizer_cov_stack_depth'
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, kees@kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions noticed while building arm builds with gcc-13 and gcc-8
toolchains on the Linux next-20250723 to next-20250725 tags.

First seen on the Linux next-20250723
Good: next-20250722
Bad:  next-20250723 and next-20250725

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

## Build regressions
* arm, build
  - gcc-13-lkftconfig-hardening
  - gcc-8-lkftconfig-hardening

Build regression: next-20250723 arm atags_to_fdt.c undefined reference
to `__sanitizer_cov_stack_depth'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arm-linux-gnueabihf-ld: arch/arm/boot/compressed/atags_to_fdt.o: in
function `atags_to_fdt':
arch/arm/boot/compressed/atags_to_fdt.c:135:(.text+0x118): undefined
reference to `__sanitizer_cov_stack_depth'

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250725/
* Git sha: d7af19298454ed155f5cf67201a70f5cf836c842
* Git describe: 6.16.0-rc7-next-20250725
* kernel version: next-20250723 next-20250725
* Architectures: arm
* Toolchains: gcc-8 gcc-13
* Kconfigs: hardening

## Test
* Test log: https://qa-reports.linaro.org/api/testruns/29244662/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250725/log-parser-build-gcc/general-ld-undefined-reference-undefined-reference-to-__sanitizer_cov_stack_depth/
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250725/testrun/29244662/suite/build/test/gcc-13-lkftconfig-hardening/history/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/30LiHIefapv5cGlikeKrTz4lSKR
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiHIefapv5cGlikeKrTz4lSKR/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiHIefapv5cGlikeKrTz4lSKR/config

## steps to reproduce
   *  tuxmake --runtime podman --target-arch arm --toolchain gcc-13 \
              --kconfig defconfig --kconfig-add
https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/netdev.config
\
              --kconfig-add
https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/systemd.config
\
              --kconfig-add CONFIG_ARM_LPAE=y \
              --kconfig-add hardening.config

--
Linaro LKFT
https://lkft.linaro.org

