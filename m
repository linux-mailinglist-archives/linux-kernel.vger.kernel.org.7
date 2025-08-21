Return-Path: <linux-kernel+bounces-779937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42213B2FB49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE81CE7773
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12615E5DC;
	Thu, 21 Aug 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpmcPQfb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174F342CA2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783813; cv=none; b=aciKfOvX/bb1e86KNkYNOAhe1seiSMsX4YPr8AoPLW2Pqzoy0nlMmpgVa8/ZI5Enn15rajGOJ0IWhpU5nTSP/2yJeAkN/IPtUu73tl8ol56SgmVcBa708vgAqwM96ErVw9PnhNHvbB9hsmXQhvtlkUAo/Srd+FusN55nuWggfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783813; c=relaxed/simple;
	bh=kDR7IcPzIqy9bbYLH2uEiJyNApziIC+MQ80BckAIB5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+Uqtotcy74DOr9Nx0jI8IWiNqhX64JT4yDWr4UUGGoQFN/5zzIUP1vIrJffirM+MhQ7WtnhUfWe5rrbHx2aXIYNO8/cB//hA3RsHG83ALptQjdAD4GIkAsXhVN6B6P/7JCb2claPz6qdHySbyCTNr2Esj9n9YzLBT0mAdsev08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cpmcPQfb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-245fb4c8738so12249545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783810; x=1756388610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TKKxJUqDz6CrlAYZ9i2quMno6mJSPy8hdIxNc2ssT8=;
        b=cpmcPQfbjUlWMhJNPPc7JicgOpKyhLXw1DdQkTh3drNSnOPdLFEjlpdVdNsOUcPZwj
         3I2QDYSrdLYTEA2kYP4yHGsxNkihn4EF2+JecaHUUANhJuGXAF90HdE3qQ/hC96qpnKz
         K6m2/QDiPgIEUEPW/LoUCJGp/pw3qSKOihaFaOIRpmP3UXC49t0FhvavZHW55GdaHwPz
         AU41+5hBmVNCuMloRaYD1Rc1yUiTPFSiZ7PnVwI7UkNlaRBHoyLzFkV1YXbIeWufPxLb
         7yCuZnwEUPTCTHGMme7hQNobEenKwGb7Aqlpw183GNRtU8b2DYtRhx5lVuK+zQ3W6QYj
         /KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783810; x=1756388610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TKKxJUqDz6CrlAYZ9i2quMno6mJSPy8hdIxNc2ssT8=;
        b=eppqHCfSxjbvDtPcEqZmo4Vh0EvmoLlJlZDcZVLcC9FttLHMT4R/4MIMGayPPKPxo1
         J+9LQCoxA9uOmoyOfTH1zOUSHU+a9XydIX3jOBuZp5tqFaya2SPYKfddvDNyl5BEd/D7
         0iJ+lUa5Lzwaq33mY0FPz2RX8dhc5LfARZyABqW7Ym1gE21GGGETw0tdzjKv87ekRauu
         BkCqVU3V5x2MB7sMG4E0Lx5QRNVNr/mUeqIsOFXJDuN5gvkHoB0udclqBm1AqzUVCbV9
         J5dGtzq9xFAbQFzdTz//bkbOTdVJwnrUjakl7lyMGgO9cose4+DQz8fTK2ff6tr2y4bO
         8rBA==
X-Gm-Message-State: AOJu0YzKiZwRaulU5lI9zUo1CD9sDdG87DaFurAvOBlIl9yBy1WO9I1T
	zeI9nPHpb9MbTODPXZ1+Q7K4rsuJSYt2IVtJEJeySauajXfomuHrtlSIq7g0o6qvTog4rznQA57
	Z91MdArO6x9SLUOhQ63twiDVIyfUmdAaMjw6yade6HDKpPdIvBY62OkM=
X-Gm-Gg: ASbGncuWRQkc5j/OfiV5bktIVlRl153d0i4s7ZPHCHm5ZPqFztLRthZ/UsMT+faFMmB
	MlLhJ2WDtCenOBYnplV7f7AAv9P5YFJ2Y163khVDkiIGUCr/b5pOcOPVAoTgLdNaOjFsGYdPXcT
	uCMKEkBfXys59nRjQ6KcJdweQagBRamPN8X8ZDM88KPnJbJzvb3ggPbwVa6lxSfWlSHem85hffT
	WdOhRQ9IavqnD0QhWAeVkpJ054oBYFmoLFJ0AtMmtjkv4QMc4o=
X-Google-Smtp-Source: AGHT+IELgByc3NnsMiO4ohlSNnw7P3I9l1WOk61YcazCJ1eLTSo0Jd6s6qKsge3KcqTIkNDOkvcx67/Y6od2fhS10yk=
X-Received: by 2002:a17:902:d584:b0:23f:c760:fdf0 with SMTP id
 d9443c01a7336-245fedc8c92mr33954055ad.45.1755783810391; Thu, 21 Aug 2025
 06:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYthMAr3w=U_GmbLPgMb7xNdjbqmxYWF0iUEuJzxnw3dxg@mail.gmail.com>
In-Reply-To: <CA+G9fYthMAr3w=U_GmbLPgMb7xNdjbqmxYWF0iUEuJzxnw3dxg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Aug 2025 19:13:18 +0530
X-Gm-Features: Ac12FXweVlItcIxXxm0jYGOpeOdEH-mXExl8DfwFQGTW8B_Dt-4zHZjVzLsg8Gc
Message-ID: <CA+G9fYvkpmqGr6wjBNHY=dRp71PLCoi2341JxOudi60yqaeUdg@mail.gmail.com>
Subject: Re: next-20250821 cacheflush.h:61:3: error: incompatible pointer
 types passing 'memdesc_flags_t *' to parameter of type 'volatile unsigned
 long *' [-Werror,-Wincompatible-pointer-types]
To: open list <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:26, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed with mips defconfig with
> clang-20 and gcc-12 toolchains.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20250821 cacheflush.h:61:3: error: incompatible
> pointer types passing 'memdesc_flags_t *' to parameter of type
> 'volatile unsigned long *' [-Werror,-Wincompatible-pointer-types]

Anders bisected and found this,

# first bad commit:
   [30f45bf18d55a411f576afe48d50e78a2eef7e23]
    mm: introduce memdesc_flags_t

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> * mips, build
>   - clang-nightly-allnoconfig
>   - clang-nightly-defconfig
>   - clang-nightly-lkftconfig-hardening
>   - clang-nightly-lkftconfig-lto-full
>   - clang-nightly-lkftconfig-lto-thing
>   - clang-nightly-tinyconfig
>   - gcc-12-allnoconfig
>   - gcc-12-ath79_defconfig
>   - gcc-12-bcm47xx_defconfig
>   - gcc-12-bcm63xx_defconfig
>   - gcc-12-cavium_octeon_defconfig
>   - gcc-12-defconfig
>   - gcc-12-malta_defconfig
>   - gcc-12-rt305x_defconfig
>   - gcc-12-tinyconfig
>   - gcc-13-lkftconfig-hardening
>   - gcc-8-allnoconfig
>   - gcc-8-ath79_defconfig
>   - gcc-8-bcm47xx_defconfig
>   - gcc-8-bcm63xx_defconfig
>   - gcc-8-cavium_octeon_defconfig
>   - gcc-8-defconfig
>   - gcc-8-lkftconfig-hardening
>   - gcc-8-malta_defconfig
>   - gcc-8-rt305x_defconfig
>   - gcc-8-tinyconfig
>
>
> ## Build error mips
> In file included from include/linux/cacheflush.h:5:
> arch/mips/include/asm/cacheflush.h:61:3: error: incompatible pointer
> types passing 'memdesc_flags_t *' to parameter of type 'volatile
> unsigned long *' [-Werror,-Wincompatible-pointer-types]
>    61 |                 folio_set_dcache_dirty(folio);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/mips/include/asm/cacheflush.h:42:27: note: expanded from macro
> 'folio_set_dcache_dirty'
>    42 |         set_bit(PG_dcache_dirty, &(folio)->flags)
>       |                                  ^~~~~~~~~~~~~~~
> arch/mips/include/asm/bitops.h:89:70: note: passing argument to
> parameter 'addr' here
>    89 | static inline void set_bit(unsigned long nr, volatile unsigned
> long *addr)
>       |                                                                      ^
>
> In file included from include/linux/cacheflush.h:5:
> arch/mips/include/asm/cacheflush.h:70:3: error: incompatible pointer
> types passing 'memdesc_flags_t *' to parameter of type 'volatile
> unsigned long *' [-Werror,-Wincompatible-pointer-types]
>    70 |                 folio_set_dcache_dirty(page_folio(page));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/mips/include/asm/cacheflush.h:42:27: note: expanded from macro
> 'folio_set_dcache_dirty'
>    42 |         set_bit(PG_dcache_dirty, &(folio)->flags)
>       |                                  ^~~~~~~~~~~~~~~
> arch/mips/include/asm/bitops.h:89:70: note: passing argument to
> parameter 'addr' here
>    89 | static inline void set_bit(unsigned long nr, volatile unsigned
> long *addr)
>       |                                                                      ^
> 2 errors generated.
>
> ## Source
> * Kernel version: 6.17.0-rc2
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250821
> * Git commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
> * Architectures: mips
> * Toolchains: clang-20 gcc-12
> * Kconfigs: defconfig
>
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29616797/log_file/
> * Build details mips:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250821/build/clang-nightly-defconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRYnoYJbpEW0zZyTGvO2w7OCn/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

