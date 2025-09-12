Return-Path: <linux-kernel+bounces-813814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EE0B54B05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A99C7AEB35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA452EE612;
	Fri, 12 Sep 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhVfks31"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2B274FDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676770; cv=none; b=utJ5IqcrGGwb/qPGpS6rpS4PTQtNSkvsq7BDtnabVE/aj9sOs3+VC5r3dT4EiGlctiS1nBgFc16lTzREsHAwWky5gohDiPJQ9UhySvKUFwCCXumCBXf0LOMrnJoKwA5Xf2unNkwx9qWYjyGODUElwbo3d1SNQOYgj1TwGBr/ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676770; c=relaxed/simple;
	bh=mEjJFVIYIe7tqpxYWnwn8npcdZ3rzCy2M6nLHqTd3WY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=akfkNvUgeWllq4CI4EBWkaFHRfama32BBiAXd9mBN+BLxwc9nxy/UxDLH09UD64Wsh/KRqKzInHP0YVw9W93kGvUgx50G/uJMuCXVTw3XUM7i1m9pBdZO8uEGgyc9tH0wC2olAMn40NwuCAYQEBYHbHxuTkCYva5uVFV4+oNRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhVfks31; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so1082375a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757676768; x=1758281568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6Vu9krI8L/L917eJRdmIwH3Jf+YuSh9fi/gZdnGGTM=;
        b=uhVfks31+0tcoVyU0GVpuTuBPBKY4lB1FDJ5XgACl0jUahUff6jWNOqMHF1Teq0DSz
         MKLzWdnPqVv2oxkuf8PTybCakTNdK4ETOw7VmakDHzWm896g21AZlWm7waq3hWr1LGHQ
         zePyhUg5J3RtXp1MJIB5i9idbBbnRwzWIeHqp8xqX4/SgMvOXQYMm/iHFLAyMPHv3wNE
         bWbArj9TWcprjsWdNkqUNHNtF0sjmrKaGUCZUG3M/UzVy47o8dd8mWGiOaZwmbf0HS8p
         l7kGHURM1tsfCKP/b3YX1HeAPOthQwSVXL4eZchuchq11tpbiDZFWGsUmb3se+D7GncR
         ddEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676768; x=1758281568;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6Vu9krI8L/L917eJRdmIwH3Jf+YuSh9fi/gZdnGGTM=;
        b=OKNQQJAJrA7ty/2jodQ39MxyVzYCFnGzPZrZmYm6L/uolH+U0lmW/81yclRmbWbhQZ
         OWGltnpJXTN3Spuueg6CcW618puTA85w+/4GFLOtRhDYxdVwx4AvPjaLaG3/wSkl29Gz
         txvZ4nDonR/NloaG3WVYmMXUwZVNK0mOSkfJeqFxxi3BzDInvFnLke7ymiEMzfNpjJs5
         gifYYpE49CtbrA5+9//D7Fuwrli4K6IDFbv6QHGiy6NR6UsPj8d7Iy8uHrN9vW0SJ63z
         QAj2MAJgT+Zric4npDXzVMba+GibnJ4WEvsaPm2LYtNcoz4wXdFpoTAxdYPQh7jr499q
         Vv3g==
X-Forwarded-Encrypted: i=1; AJvYcCW25fW/R4lzduE59rWNVJO9DysyBi/6+CgSg1rsV3C24g7BTX2MJPR4+dMAJ9WwRGH9NTiJEytj0GSw3tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJ/Edw1W9s/f2a9rTxeR52w5gAlUnGonNYh3TnrV4zQbAbckV
	XhoOHPJ1L4PkLoT0u1JR3RE8ggy68SRFV9274JSKEocjIEi/DN9l10ic8w79nJPjJg9/W7nHkZE
	zeGHTVCEfEr7rJTbecA5fRWi5b1WwD+goRQiRfih77A==
X-Gm-Gg: ASbGncvLFus+AmhWd0mWOe3/Enqzt8qB96UNJqHBQd3j4lQfVjaUvppow3ECAuxrxEb
	oNcQZWyeETB7SxRJKZMSD+EP70pvXsjION6YTbzgN4NoLyjYvKL/iH4s4unnCgRQQZ6cIzN8j1T
	iPUNBSvzVRD4KheYsJeRj7BWxVfI8vUzDZLEuO7dEXr3EyW4b7DPs2xtiGqs/q8YLNWoS85/vyw
	KcFW4mmTcCtJ8GRSHIqwLfjH7QkQyekByssUT2icTsCZax7JFbZDfiM+zEix1QobDkDDjSC4+5X
	uVNNc5s=
X-Google-Smtp-Source: AGHT+IF1n0wZVljtgQdO4YjkTkuDA16K7j3EGrt+LavVV05cNjZjVMw0mRnQJqWQrvbyjkw61l+wH9wnd6eTRWsTKWg=
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id
 d9443c01a7336-25d24cac4eemr35190575ad.6.1757676768437; Fri, 12 Sep 2025
 04:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 17:02:36 +0530
X-Gm-Features: AS18NWCRkwK2BEtW0uxWjqehT8uEFjWUmULflZWeqoftij31KvQE0_RmSXQs-jg
Message-ID: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
Subject: next-20250912: riscv: s390: mm/kasan/shadow.c 'kasan_populate_vmalloc_pte'
 pgtable.h:247:41: error: statement with no effect [-Werror=unused-value]
To: kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on the riscv and s390
with allyesconfig build on the Linux next-20250912 tag.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250912 mm/kasan/shadow.c
'kasan_populate_vmalloc_pte' pgtable.h error statement with no effect
[-Werror=unused-value]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

$ git log --oneline next-20250911..next-20250912 --  mm/kasan/shadow.c
  aed53ec0b797a mm: introduce local state for lazy_mmu sections
  307f2dc9b308e kasan: introduce ARCH_DEFER_KASAN and unify static key
across modes

## Test log
In file included from include/linux/kasan.h:37,
                 from mm/kasan/shadow.c:14:
mm/kasan/shadow.c: In function 'kasan_populate_vmalloc_pte':
include/linux/pgtable.h:247:41: error: statement with no effect
[-Werror=unused-value]
  247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
      |                                         ^
mm/kasan/shadow.c:322:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
  322 |         arch_enter_lazy_mmu_mode();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
mm/kasan/shadow.c: In function 'kasan_depopulate_vmalloc_pte':
include/linux/pgtable.h:247:41: error: statement with no effect
[-Werror=unused-value]
  247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
      |                                         ^
mm/kasan/shadow.c:497:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
  497 |         arch_enter_lazy_mmu_mode();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250912
* Git commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
* Architectures: riscv, s390
* Toolchains: gcc (Debian 13.3.0-16) 13.3.0
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29863344/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250912/log-parser-build-gcc/gcc-compiler-include_linux_pgtable_h-error-statement-with-no-effect/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W/config

## Steps to reproduce
 $ tuxmake --runtime podman --target-arch riscv --toolchain gcc-13
--kconfig allyesconfig


--
Linaro LKFT

