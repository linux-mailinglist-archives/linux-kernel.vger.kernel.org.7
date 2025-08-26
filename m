Return-Path: <linux-kernel+bounces-786054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8AEB35469
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321591B663CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259672F90D3;
	Tue, 26 Aug 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOJ6LFF8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC22F83B2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189265; cv=none; b=qv0w9kpcQSCvImN7+KZjqzDh+qtPNPTjbOUH+cs9qSYOG6JmpztOSWRM/qZ1GYu6CSAgOCCcqzH+HqY4yHIKklm6erkhBrWw5m7uqAFL7LQDN79wPgy4dhETYcfzW7Bj9PDnLsaVPkRX+6gE3GX7EEgyHob34z6/+ckDwSw9fDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189265; c=relaxed/simple;
	bh=S7v/e+cN4Wf16k7rEO/bWPt2ZPC0mpZbm9jUun95K3U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ryxggl3tUtQEboN2/x1zwW+M8pLH5da8duUUI3owyGmbGREwgYr0bPAz6BD2JuYXzWIqfEzaT7baDLiQxSatlmq9wGlYVzbic/7AVX6tCDvdZ0X/GkSj3XlUXwg32pCCaZUSO/YudG3+eYfLR5k2gSo4vmz1aUUnKzopVo6eEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOJ6LFF8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-246181827e9so43191145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756189263; x=1756794063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFYRl1ZFHjhZrd7h6GtCM5LUiRUxEc7ppUKwn5M/+7g=;
        b=eOJ6LFF8yWpCQP6cJyI1u+rIDWkVNEsBZQc1RGVEll89Mrmjjap7w4D6jH0WpHHQ+G
         Me8MnNND38sbC+MZfR8SLPhhtXSJeL99MaVqYnXlLhanT2BdaIGJzfJejPwi9+PoYCkZ
         KjN564k5I3wLq+MgLyfRaR67vx+GSZyOujiUom56HMKwbDk6pP7WxRrT9gwTowtHQ2jE
         evVtVwufi17xWG7LZA0i2vEY/G05/wvTbRaN1Y30LXQqoj+EycCVg7YJqdLg53cRrvoj
         UJoDxKxn60OocwkqVRPBFbzchtto+7hSr5WWoHBqOtpiSYI5NyYXUYxxLG0+8y+q2uP/
         /h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189263; x=1756794063;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFYRl1ZFHjhZrd7h6GtCM5LUiRUxEc7ppUKwn5M/+7g=;
        b=klMwOpXJTt1gyI0TrZSiQv0FqA4qRXMfCNm2c3zUmGO9u3EUcMZENSrB0EsIjGgPZh
         xN6HT7yddUOKzliZA96eCLM1EIII96AJDxGnPc4fEm9HMXqXjgVAs95Xwq4zbjAjYrpn
         rNvY0wW4j7aV5BgSkSioQpR5xth66nWkMzmhE4zQ9BtvCeMVR7yBEGV3cMB3zoHrWYuJ
         8L6144rNxsdPHG4apEbvCpgifICWeGq/2bWfPQ+Gn1h/Zcpg7goWJsTuoXKGl2i8wUZc
         HYyABl4fx7zcKGHfGHTIhZ/GmtvFD88mUcPER38V8lnuwnevttWEwhvgRoeV5l5ZiPu5
         R9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWZc0Ws8W65/fFHcx6xQust5VvMxq51QENtQFOOXNBx0aIlbViMTTq94b1pv6VAyeuzy6ZFGXFa4TtAXm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPq5CRrRiOaZHenUF9N2lFOefAAdOc/UcfCXWrL3lxWBkCjlKv
	4XhzIDDtUuHiaDOlK9PpswLC81rK9ZYwfaOCZj2mm2m18Z4faoEO2eWSRpfa5S6YUbDyrVpWInh
	0RdFoOwnTa4CC3JTZMbwdWGVqRvaKwdhujdBKqqaFZg==
X-Gm-Gg: ASbGnctfSFicMyvAm0PS7de6axcqjXAxpiqvFN39M6v+kSHekJzitcdke0YIN83OrWv
	aB/DDP+jXsm6t9TZxSWz6kWdIigrl6yUlLBgr6Mgw69n4O7xm3YtI8GAlSKTEoNQynGwcdgAKUQ
	41LVbSw6V02hQxpvo+GIz2aLRroutVFUGNJT+aTqAy3IBg88TEy8kwNaP+fn/dNHQDhO/WDBF+R
	VzZUlcRgExRPL3wf2/9PwsLKZ5Umzqi1aBliVg=
X-Google-Smtp-Source: AGHT+IEaOAsyEwvYZhL6gwxls7OPv3CjgiN4RcC1NbjL3gx6dd9cjdG1OkopmuigZ7xW+OLJUx5JyXWtdmH6vWAFnIU=
X-Received: by 2002:a17:902:d585:b0:246:b41a:bb90 with SMTP id
 d9443c01a7336-246b41ac045mr106384895ad.2.1756189262339; Mon, 25 Aug 2025
 23:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Aug 2025 11:50:50 +0530
X-Gm-Features: Ac12FXxpo9Z2nstlPDzyogezkDDH4eyaoMNNWqxf1iMYZc7Yw19lKOYzdQTyf50
Message-ID: <CA+G9fYs2Wp33dq0jeuWqU+67z3VzP2LyHBXSD+SecqqG2OiJfw@mail.gmail.com>
Subject: next-20250825: riscv: pgtable.h:951:40: error: incompatible type for
 argument 2 of 'page_table_check_pud_clear'
To: linux-riscv <linux-riscv@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed with riscv defconfig with
clang-20 and gcc-13 toolchains.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250825 riscv pgtable.h:951:40: error:
incompatible type for argument 2 of 'page_table_check_pud_clear'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

riscv:
  build:
    * gcc-13-lkftconfig-rcutorture
    * gcc-13-lkftconfig
    * gcc-13-allyesconfig
    * clang-20-lkftconfig
    * gcc-13-lkftconfig-libgpiod

## Build log
In file included from include/linux/pgtable.h:6,
                 from include/linux/mm.h:31,
                 from arch/riscv/kernel/asm-offsets.c:8:
arch/riscv/include/asm/pgtable.h: In function 'pudp_huge_get_and_clear':
arch/riscv/include/asm/pgtable.h:951:40: error: incompatible type for
argument 2 of 'page_table_check_pud_clear'
  951 |         page_table_check_pud_clear(mm, address, pud);
      |                                        ^~~~~~~
      |                                        |
      |                                        long unsigned int
In file included from arch/riscv/include/asm/pgtable.h:139:
include/linux/page_table_check.h:125:75: note: expected 'pud_t' but
argument is of type 'long unsigned int'
  125 | static inline void page_table_check_pud_clear(struct mm_struct
*mm, pud_t pud)
      |
     ~~~~~~^~~
arch/riscv/include/asm/pgtable.h:951:9: error: too many arguments to
function 'page_table_check_pud_clear'
  951 |         page_table_check_pud_clear(mm, address, pud);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/page_table_check.h:125:20: note: declared here
  125 | static inline void page_table_check_pud_clear(struct mm_struct
*mm, pud_t pud)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:182:
arch/riscv/kernel/asm-offsets.s] Error 1

## Source
* Kernel version: 6.17.0-rc3-next-20250825
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250825
* Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
* Architectures: riscv
* Toolchains: clang-20 gcc-12
* Kconfigs: defconfig+lkftconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29652465/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-13-lkftconfig/
* Build error details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-arch_riscv_include_asm_pgtable_h-error-too-many-arguments-to-function-page_table_check_pud_clear/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrb0XugzFZYDePlPNpSIVTzeB
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrb0XugzFZYDePlPNpSIVTzeB/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrb0XugzFZYDePlPNpSIVTzeB/config

--
Linaro LKFT
https://lkft.linaro.org

