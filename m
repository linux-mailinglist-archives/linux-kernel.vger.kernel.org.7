Return-Path: <linux-kernel+bounces-779569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC16B2F5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FC8AA541C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E730AAC4;
	Thu, 21 Aug 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub132h5w"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AD30AABC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773829; cv=none; b=ucpKZwxP66/al6JwqB5Z3MC4ijlM4rxExZ74kjK+pVIoe2S37W0Xs6KuwiuNVKXYBdm+nkCrdlbI1Dr4l28/Dp7jD/W+nl6sEeR6FDA0UvLU1cPmabTNBT8Ib00iAtw3lY7Nf+DTONlnLUOYd7pzXDvnNYa9H8ElK1msxxEJ6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773829; c=relaxed/simple;
	bh=GKkrz4iTgMP3imRBkVGMq2ugMtvxmgGCSinBgcoSxj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=opHfZhnx8UQO01OK7e78nUjRhg95/d7XFPfvZXeB0fb1FO89tZzvnk0YwFhotKOqW6YSZCgQjzATCqio0goCGOXu4nLYQI18Ju/55mhekq9jTdpUbPF4jzgqx3pvISnACfqzxJQ7wIqpcy3JEhjxdXRW00mCtfK6gZOQKqnDBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub132h5w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-244581c3b43so7444955ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755773826; x=1756378626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXsydsgT+UVZBwSeBHcvaKFCB1p8eK/mNY2QWJNzsz4=;
        b=Ub132h5wLZljsceEqWrqYBoiEsksJnjp9idY//OntJWF+Y3Fbv84Jdwr3ZS2yi8gQb
         OvTgeTa/xhsP1m7hJIWI6HsUkqPEjangqFFXiC/hXNHja9hrkTXW0O4Gw+dBh+3WVh33
         VsIlcN2xx9eE+6xuldQxj+A/SYtFJVe2JMOYgNEEJueTSEgKmmj4mJkDsgZWQlhcn2LG
         JReW2S8/fJtUeCIcVB+V7W2ojXF39AUJdX+U5qMxckgPyaeKT3Cbrq9b8ChozbKMlbOL
         x2I91SFfFevszOZlu5In52jME6bCM+2XJfnGWxVE1XIq1m/RRquPa1XZ7GA58r/vIKdy
         f4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773826; x=1756378626;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXsydsgT+UVZBwSeBHcvaKFCB1p8eK/mNY2QWJNzsz4=;
        b=Tr12JfuyB/XhcxmEJLLzXHCKhL5RAq/Ft4FoJwyMkQRW2VYo2NDXPdAbEIVpxsR0Lp
         qiSby7gyO//s7lH+Se2cefpa4JdBJHxovF4/dTwDinqfdh2uRpyQSerQxiOlJ8wPT4mV
         zA6lMa+mWnz4+XFV7k73CgFyUNzMicH1Qbd2KVgcycpI9/qXKrNZkGnu7QVw5yhQzM6l
         8u+IIFlO/vjM+e+tuf0awYySiRiz5s8ycfW2d1+VI6UzbJJ44bmi2CQ2b0G08GxSLwpN
         3HYNYDfjboYMogxa2abgnV+4L9idg9IC4AI4caVbJSZTG7Fi2rxtFuvXgHnBg+Rz2jEK
         9aCQ==
X-Gm-Message-State: AOJu0Yz50ogK5+4y5HqrFAGq3yP9VN25KfI9GxBFFfDbbqujLdqT5ats
	wiQO57Uoywlaxb5iVsd7AaWRDKrB3vTh59CTMkAN5IHMt0FcevQQr7Vz6HYyrIiJO7SMdzZQXYo
	c/Fmkd4dGQirmrItbosKTKJbcAqcY1K9yOsrfg7IiE9vxDRGL/W8IXZE=
X-Gm-Gg: ASbGncvXcW4Y1oDHfzujHz2jGppDX8kzhV6IN1Tq/fX0qjYTv7F2YjNFsfK8MBdTeUT
	KwNGoa9ULJVVi1pcBq9BlWIZimxPLH/yNh8zc1HWjZ0NLbCr5zhuoBtb40WJpkH47UqJ60BuNxJ
	mIkWzBZ8xzL2XessQ7hsBCQBcaVta72Cq8XPseD1upBegtyDKHNF1jULK7wSHKE9yJba8EZv7fe
	uRI99WnbNKmXS3Pb1FefpSDgf51n8ij1cyrOQ==
X-Google-Smtp-Source: AGHT+IFA9JWo/za7RvCQ3N8qUZg3xh+FzJDUXahmuU7qDSv65XS/0qQKuLW50NG6gdpjZGNKx/9zfTkOGpG5BzWpnok=
X-Received: by 2002:a17:903:b50:b0:240:6fd0:25b7 with SMTP id
 d9443c01a7336-245fede05e2mr27786565ad.38.1755773826455; Thu, 21 Aug 2025
 03:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Aug 2025 16:26:55 +0530
X-Gm-Features: Ac12FXwxxHIFgYcRpbKhe10fmgTcb2IwuVwDMdkZzGeMc7x8TUDiIvJE5OkVtOk
Message-ID: <CA+G9fYthMAr3w=U_GmbLPgMb7xNdjbqmxYWF0iUEuJzxnw3dxg@mail.gmail.com>
Subject: next-20250821 cacheflush.h:61:3: error: incompatible pointer types
 passing 'memdesc_flags_t *' to parameter of type 'volatile unsigned long *' [-Werror,-Wincompatible-pointer-types]
To: open list <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed with mips defconfig with
clang-20 and gcc-12 toolchains.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250821 cacheflush.h:61:3: error: incompatible
pointer types passing 'memdesc_flags_t *' to parameter of type
'volatile unsigned long *' [-Werror,-Wincompatible-pointer-types]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

* mips, build
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-ath79_defconfig
  - gcc-12-bcm47xx_defconfig
  - gcc-12-bcm63xx_defconfig
  - gcc-12-cavium_octeon_defconfig
  - gcc-12-defconfig
  - gcc-12-malta_defconfig
  - gcc-12-rt305x_defconfig
  - gcc-12-tinyconfig
  - gcc-13-lkftconfig-hardening
  - gcc-8-allnoconfig
  - gcc-8-ath79_defconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-bcm63xx_defconfig
  - gcc-8-cavium_octeon_defconfig
  - gcc-8-defconfig
  - gcc-8-lkftconfig-hardening
  - gcc-8-malta_defconfig
  - gcc-8-rt305x_defconfig
  - gcc-8-tinyconfig


## Build error mips
In file included from include/linux/cacheflush.h:5:
arch/mips/include/asm/cacheflush.h:61:3: error: incompatible pointer
types passing 'memdesc_flags_t *' to parameter of type 'volatile
unsigned long *' [-Werror,-Wincompatible-pointer-types]
   61 |                 folio_set_dcache_dirty(folio);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/mips/include/asm/cacheflush.h:42:27: note: expanded from macro
'folio_set_dcache_dirty'
   42 |         set_bit(PG_dcache_dirty, &(folio)->flags)
      |                                  ^~~~~~~~~~~~~~~
arch/mips/include/asm/bitops.h:89:70: note: passing argument to
parameter 'addr' here
   89 | static inline void set_bit(unsigned long nr, volatile unsigned
long *addr)
      |                                                                      ^

In file included from include/linux/cacheflush.h:5:
arch/mips/include/asm/cacheflush.h:70:3: error: incompatible pointer
types passing 'memdesc_flags_t *' to parameter of type 'volatile
unsigned long *' [-Werror,-Wincompatible-pointer-types]
   70 |                 folio_set_dcache_dirty(page_folio(page));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/mips/include/asm/cacheflush.h:42:27: note: expanded from macro
'folio_set_dcache_dirty'
   42 |         set_bit(PG_dcache_dirty, &(folio)->flags)
      |                                  ^~~~~~~~~~~~~~~
arch/mips/include/asm/bitops.h:89:70: note: passing argument to
parameter 'addr' here
   89 | static inline void set_bit(unsigned long nr, volatile unsigned
long *addr)
      |                                                                      ^
2 errors generated.

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250821
* Git commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
* Architectures: mips
* Toolchains: clang-20 gcc-12
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29616797/log_file/
* Build details mips:
https://regressions.linaro.org/lkft/linux-next-master/next-20250821/build/clang-nightly-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn/config

--
Linaro LKFT
https://lkft.linaro.org

