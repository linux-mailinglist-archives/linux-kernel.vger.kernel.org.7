Return-Path: <linux-kernel+bounces-752244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C381BB172E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776AB3BDBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF82D1F7C;
	Thu, 31 Jul 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqnRJmtW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E32D12F5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971125; cv=none; b=knln7A0PEcW3Qu0xyx17sqAdx3wquOLnK0rBlyNfnBl7/XkuKylwVhb+DuYY0F3L6ahZpUSOb1N++XFlsdWjr7zBtJa4AScXSsBbOdO9evftoMWY05XAO6xJDjq0gRqelkRQCtcOkwp+fJwks4TwDt/VYzwVBx8DyVnfAe3JAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971125; c=relaxed/simple;
	bh=TH3fCZPCy4YyphExJVOAQdZ8iXnIWWWw+CoAeuxr3Ps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TUHlcCMOCipNFslJOBMSF+yetJ1cEr9sFWOwjl06yQtwwn3nlDgF/uCTxtMcsvdSPaYERQLe85Fz2rV6Ge9hwdBZMiLMwHnAyEyI4vX+BTGagpLHrBrnoSvmJ0njJRtfGvHXRRq5iYct+9z62jEgL6eL66+jLdAvT8atx5I9qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqnRJmtW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24022261323so22596705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753971122; x=1754575922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=REQVjpTsrsLvJl/SEHd88cRQSz2tJb2a7A9OwH842ak=;
        b=mqnRJmtWDjBsAGcBqJXhXYzi7AZmpoFVWtVQjbMn1KTC8PpaOCCrrfhekvL9TPbOA5
         1hUKp7KKEdY7Bj7J3KlxuaOZC1xbll1lL7YqGnEJ21GE7HOJyeS4NtN9fvbOfivKAXme
         i4FOW2VLsW4kH75FMKrSq2k8oPRJ7d9Pk6G0ggYhIAqTvxQUv/waiUSRc2kzWG3mhw/b
         /2oKbE7P5WwI7AJY7uXeFqPnuHr62JK9V90W+E3o8+cJqad4zs+7+6F6pxCbH8bffoZV
         Nc0XLzfvQtKQ8Qvzyh6o+7m9BEZ2lwjqwVWF2BEEzI0P2gt5YIm0mcH33FaOMFqqczVk
         cWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971122; x=1754575922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REQVjpTsrsLvJl/SEHd88cRQSz2tJb2a7A9OwH842ak=;
        b=ubJQvtHnJI4mgSLMN0a/v0WWHAcTJo/HnmNTE6j1pKsrvlPavybw89NNOh13CajXMk
         16uZRb7rbMB+tTZFWmcMnRcyKI8p11R0BC4YITD0ZrKfKNqJNr1rIKMF8dJr/eYVRGkx
         SIO/AdIAJbyo21ckbvQleNhx+yIQk1vCJ+8hIuL9R60pZCHOPet+qNmiYHI+Gjz0IPaC
         RPS9yl41sd2UxsFqw6OZKVcNZSOOXeRhQqWSuESG9lANRNj2Pg0MR+CgVkkeiChynIfx
         EFUHDUEh2vjmF2Qq497wVfP/XSGw9r6FVLJxip3x0KbDw3GGNXBs0iMD6ilyIKzDnV5M
         NeEw==
X-Gm-Message-State: AOJu0YxdDVbR0jbEs+K7t2gLJTXYFvoe2VODV6flc1NYGxeRpip5//Li
	3XYxAvha8xJY6DAjm12H1iRq9NZ5733hv2QM409vUPsEntl5fxXHV+MGKR2fQ1SkMzOiJp45xXp
	llBH9xKzNn+A1STTRRV9FwHh8uJIy8NRjV5mrKlp+k+6BbGrkXFpaAC4=
X-Gm-Gg: ASbGncuWejVMJQBwM0vUiXKwbplfzIEk+RcnZdLPZOhQpM9ulDgP+NJKv9BUnSKdZkF
	kwDYPmIWnqOAbyL37QCmJvTAelh0YsKi0XzZCUYflTQQSbUv8b3jnbf+uePQRc8bCyHwlrgeCLO
	LvqQlyO/tTAloY8OvzAf3QZOCM9hVH92ILY4dTuKfCpE5JicIEkObIXgcSL/whYDXpWceO61Mbx
	XE7fz9x4glrmQ2MojHXkvetm+0y1AfXOi1izLb4
X-Google-Smtp-Source: AGHT+IHFfipkwRQ+1K4xVlGJXDzqCVyVvmjQjtepMnIjmmMksReYrNJ2xhZLKNYVlub943plRlIYBtrdspjKLTHKge4=
X-Received: by 2002:a17:902:ce8e:b0:234:24a8:bee9 with SMTP id
 d9443c01a7336-24200a0a192mr33923355ad.4.1753971122562; Thu, 31 Jul 2025
 07:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 19:41:50 +0530
X-Gm-Features: Ac12FXxL-rGTjN1fNAMIPyVHVoE05EOo4i2s7AKGH0E5aPdsscvXESoyUk_z0Hc
Message-ID: <CA+G9fYvMS94GL5kMmHKSGSQqTS0XgwiYnETf_bLYYu6nTRNP-A@mail.gmail.com>
Subject: next-20250731: arm64 arc riscv64 parisc vmlinux.unstripped warning
 empty loadable segment detected at vaddr is this intentional?
To: open list <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>, kees@kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions while building arm64 arc riscv64 parisc with defconfig
on the Linux next-20250730 and next-20250731 with gcc-13 and gcc-8
the following build warnings noticed.

Build warnings with gcc-13, gcc-12, gcc-11 and gcc-8 defconfig

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

First seen on the next-20250730
Good: next-20250729
Bad: next-20250730

Build regression: arm64  arc riscv64 parisc vmlinux.unstripped warning
empty loadable segment detected at vaddr is this intentional?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
aarch64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffff800082720000, is this intentional?
arc-elf32-objcopy: vmlinux.unstripped: warning: empty loadable segment
detected at vaddr=0x80306000, is this intentional?
riscv64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffffffff8202d000, is this intentional?
hppa-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0x11400000, is this intentional?


## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 84b92a499e7eca54ba1df6f6c6e01766025943f1
* Git describe: next-20250731
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731
* Architectures: arm64 arc riscv64 parisc
* Toolchains: gcc-8 gcc-13
* Kconfigs: defconfig

## Build
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250731/log-parser-build-gcc/general-objcopy-warning-empty-loadable-segment-detected-at-vaddr-is-this-intentional/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q/config

## Steps to reproduce
 * tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

