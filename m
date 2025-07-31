Return-Path: <linux-kernel+bounces-752173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59874B17218
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5641890191
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD602C3257;
	Thu, 31 Jul 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGc86efY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195E2C159E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968754; cv=none; b=Cf2y3SiE7TbUh4T6zWnUNPg/yRUzUHVzPnUT6EEDqsL1gV+eYiZFz3+LijvzGUAmVDebpaAtEoCwk8aLW3omnW93zjfNam3gfXdyxk65nbniw/36yh7RDos7OG4nHx8e8PcqOaigCoYhrNEJlvzkgf5dIDPI4XvEWVbHRGBApts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968754; c=relaxed/simple;
	bh=DwLv3NVgK+NLuVZxUkGdJBfD5FPTwniAQK5bZRxIfmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a+y27PTtyb/rXDzJEyG0wG3RLTi29eV99Xowft1gejg3lCAAkIpN3/6afwiZ17L/bimCIgCUJZQnXDOvHw/zBSJIDyS/68CFm/MpqGbNJw29+byEtt4BC7j2L+kzLPn87E3/ByW5KAzl+h2szPr130w9smSTq3lSigi2HQeZrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGc86efY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-240763b322fso3930215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753968752; x=1754573552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmXYzT6zJ9rS420ixrln5bVB+UwoUFt5tecWAfMb5OA=;
        b=gGc86efYP2En6YuMKLUdrZOq0nhhITXlO5//ZBQ11e3Q0NPHvOnY4sbUr/XtJ4BHJL
         Gx+PPlUqXPznxtXp9jQiKZQO/+2NwosveIjW5qmuOOd+cEcqAd111WYWVL2zx9MpPbXI
         5hrtUXGqi5O4yilelYqyRFUrz3fszr8AxcIn5UAeZqeHCb4YENlTi3eE3+XR5ndyfFD8
         iz7t5mKmVnydNrl8IgHwrbkqN949PS0necqiRPHrbJMwE/c1cPoHO3AM7xG8PRsm6rXv
         rt4rXFH0wC8tIlFRCIVuDyF7Us1haFRookHHGy8W8yoMIuwb/8Nnf8E6uXnFixEsKEOo
         ES/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968752; x=1754573552;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmXYzT6zJ9rS420ixrln5bVB+UwoUFt5tecWAfMb5OA=;
        b=FroWqm/WN5WPOCQEJi1W/6hG+DzOuOWkFnNqJfZ+6+IyATpvsEzVGhul7xFnoEwcQR
         SkPrYUVEA6A6jSBx0hZISNFBEa0wRTqmQOwtQIt1e2HEz50rzqJqNIrD3Hd7nZU4qRRS
         /gwe05rwL2hdcHc+LbH9j6SskSmopQib6NtSqu+JmBJAXfgsax6cFvH9dS8g5N1UV6Tq
         n733f7+khYD1y5yfQd/MR2AOoa8e+RXI+Mon93cbrxr3rcFtKJatFaNa9YWd7Ghvfnf1
         mYteJ7dlLTlCRbbNywQg1o83FgR/JmnHbtMklCIDuBKrM5QmNgJRsD3BTOaP+SwhLHD9
         BJoQ==
X-Gm-Message-State: AOJu0YxoOAGQj48V0PZBnoXyer5Oj1/50P/CEqHYvyBvKARY65QKghTs
	wQVNnnRu1HV0Jv40EKnX98rdN7rgkkcR6d+avP53au1zm28Ls6XHVk4mkO8xa41ohwx2gpHzyqT
	t9HNzr8ETQ9LJEh6vdq7WHO83QjyEj9qb3Axu2oYo7lVAD7N4j5ENf8U=
X-Gm-Gg: ASbGncsA7wanrkJyo4LKinqOCZa1UVSOltDLili9yGNonDfkxRsXWz+yUk+nYpBW8t6
	tfVZz5TF5qY/Wl5QC54vfK6kgNpTiqkEPYyrh53phpkw1gNE19/GyfDtFcvMHLQGAMJg+GTwwjo
	Zwmee6IICuADNKPgpBT7uBQGtQ4ejqoZ4iV/oV80KSlQrBP19qhWTTLBDx2Q832Kp7BFQto+yF+
	tjmx/HuiPnLNmxmLF/7TyWIfoKYx/sE2qmIUbFD
X-Google-Smtp-Source: AGHT+IHMOlGLBVMZYIfdD8TgOlG751bAmep6oG9qqVy6znDcDyIXiYVE8rT/XtpzFlKEZWKLciEH9UdIeYkn8YVABic=
X-Received: by 2002:a17:902:ef11:b0:240:725d:c396 with SMTP id
 d9443c01a7336-24096b17fb3mr112149505ad.34.1753968752058; Thu, 31 Jul 2025
 06:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 19:02:20 +0530
X-Gm-Features: Ac12FXz5D2sJ8CLUiMTBbTCix6pCoDq6lk-VMWBeOCc2LNXohdtN5ecn-7jz4iY
Message-ID: <CA+G9fYv-c6D6tJKw9x05+U_VxrpTAQCKADTeYg4jsjaJkX+isw@mail.gmail.com>
Subject: next-20250730 x86, s390, riscv gcc-8 hardening.config vmlinux symbol
 `.modinfo' required but not present
To: open list <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Regressions while building x86, S390 and riscv64 with hardening.config on the
Linux next-20250730 and next-20250731.

Build pass with gcc-13 with hardening.config fails with gcc-8

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

First seen on the next-20250730
Good: next-20250729
Bad: next-20250730

Build regression: next-20250730 x86 gcc-8 hardening.config vmlinux
symbol `.modinfo' required but not present
Build regression: next-20250730 S390 gcc-8 hardening.config vmlinux
symbol `.modinfo' required but not present
Build regression: next-20250730 riscv64 gcc-8 hardening.config vmlinux
symbol `__rela_dyn_end' required but not present

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log x86
x86_64-linux-gnu-objcopy: vmlinux: symbol `.modinfo' required but not present
x86_64-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1
make[3]: Target '__default' not remade because of errors.

## Build log S390
s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: symbol `.modinfo' required but not present
s390x-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error

## Build log riscv64
riscv64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffffffff81e5b000, is this intentional?
riscv64-linux-gnu-objcopy: vmlinux: symbol `__rela_dyn_end' required
but not present
riscv64-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 84b92a499e7eca54ba1df6f6c6e01766025943f1
* Git describe: next-20250731
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731
* Architectures: x86, s390, riscv
* Toolchains: gcc-8
* Kconfigs: hardening.config

## Build
* Build details 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29316787/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build details 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29317240/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build details 3:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29317236/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29316787/suite/build/test/gcc-8-lkftconfig-hardening/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmb9OdgONks9mQHuMJ5hkW09f/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmb9OdgONks9mQHuMJ5hkW09f/config

## Steps to reproduce
 * tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8
--kconfig defconfig \
           --kconfig-add CONFIG_DEBUG_INFO_REDUCED=y \
           --kconfig-add CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y \
           --kconfig-add CONFIG_IGB=y \
           --kconfig-add hardening.config

--
Linaro LKFT
https://lkft.linaro.org

