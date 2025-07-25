Return-Path: <linux-kernel+bounces-745772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F22B11E56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A077A4EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CCB246BC9;
	Fri, 25 Jul 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEEhQoUi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0119343B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445978; cv=none; b=BIT3nnXww5CSmJ6o8jTtszwNWWQ0ftGY4lsVdYLArLwddi7lRe3Uz0UoaXtqeeUs55PlLRwznA8wz+l+DpkdseNZnBLiO7Inbl42tFz3tO9FZMRQ4WDVR4u92fU81L0AYDExtCinevZafs1l19uXS/ztKVr7VVmwVKSfv4e7HEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445978; c=relaxed/simple;
	bh=C0Hps5C7VVp6TMJa5SSauLjDYas/RuYUmWcHmSjZVvE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MZuY35olHil2Kr5X+W5SLYJaModDEaNr5J6qPTpQfqMODapIaosPg7s3XjhVFPmhuPQwcGCkfZb1L+qn2wKC4FJ+O2SBZkpOJDdy6Nvg1su0c6EfTZJmHdZ4S0ak4Xob450bftrIEmE6SMZd2xDrp/i5XQpCoFoL0S+qyKK2ssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEEhQoUi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dea2e01e4so26129455ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753445976; x=1754050776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NeMfxo6+NjtkxLuUXyqyKSelgastqUQJsatQRBwVL9M=;
        b=NEEhQoUi8aw7gVz9S7RUOn0EpZ6sZZBXtdJhETduRQNut86xa6uyvjlOruHOaLwWGR
         lIW5aBvdlp85Ug95xubBgEZOo0g8a/yo++wCr/q2vYpREYRPVU4SbxtynPTp/cf/908U
         /x6gbiG7nVFLwJL6q9DQ9gJ/Wr7uwpz1FHxn09e5Kq1bUVfErW1Qd842MKNhEeFLi1Fg
         N3MzTG+cPj4ymf2D7381kHxktIS508x8YDBGfEOG1Kv9GF8sziy6vhCpIPo/9eIZ1F6n
         ydKd+rcO3PBm1Q2Aqw+dK300JTFpKBqeGKQYVn9GMw6F2LE2pUYQIFL0sbICZDYHZ3U0
         nkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445976; x=1754050776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NeMfxo6+NjtkxLuUXyqyKSelgastqUQJsatQRBwVL9M=;
        b=OkvN2qvRe0nkyzbu3Qba65QuMCcoTzhigHGOWPv3I8k5jM+aIyKbuMr1YrN30572jR
         VUAPZmJVyiCQKmewBdeIqMXKMST7BVI49WIYbd53yWupShWV8dnp8OtWx/RGsdpHi/yj
         357vr2Zx0KRjZrmJ++sFWdOZCWyqpWx+w3FOMI2hk/SBc9bzKQ1c4QcA2iHDZyIrquLf
         7vxGjlx3TEHfuPSmFTV9qsZAj+wm25Txc6tcaLK2ZgEZb/vjpqiY3M/371qfSAzmHeVJ
         2A4/RNhogukwLB1p8WfHCE9nMAzc0pCI0Bnn1ruH6akt/nj/+1GBAdg7AdrABc+RR6qZ
         T2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUKglw20BTnwU0NxhsD8YSsbMNjmPuS8SP71tBnY4T3xXXcN4LnSwYBwbC71kAtGjElW8MU4u3sHcWRb4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRKb2lPf7rhnDbnuftitscWbivNU/5k448OlJC4pjpl45UaZn
	4UbY1Zyp4XTjIxlwtDdFDpiedYahrvlXk0PBrD6MoEk9HPU2UcWPYSbuP8uFLlI8ejSlRltlPOb
	PnG+ZRktdOibZ0uJhMYDKxiBKRodAgeSxsuBCpCQzWw==
X-Gm-Gg: ASbGncuKwMJAyC2zqMHf6BSkrhlhRiuOg4JEgUoLL6i0ZjCvPxMBbZoxScf9uQpteZF
	D2mpEFBI1M5Xmrv11vMqe/EOeTT6WKVILXTyEnV7b2SVvdQBe0K7qPis9EKIGp3BHefdHqs45W4
	u6F4KO6mAkJQoz3CHkGaDJ9X3ClLWxfmcXYO1Sbi8vgQfdl0u5EvXeH5XiZ2MHO0QfW6esOHj0P
	LISelvWOwKuI6Z+epPbPy0um3/sIlpxk2vyjy4=
X-Google-Smtp-Source: AGHT+IGdYljlX5X3dzqQG4BZUzWT+e8A4L5gJt/XoCo4bLpcHRLiUWIeX/SHGfQbsZ8DVFMGkkjaR0FrY9REWiry2is=
X-Received: by 2002:a17:903:1b05:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-23fb30e42a3mr30388225ad.38.1753445975730; Fri, 25 Jul 2025
 05:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Jul 2025 17:49:24 +0530
X-Gm-Features: Ac12FXwd36DF0XFKorhLZXh2IFhKm9PTaX7sVXvKuHjnNnv3_TFODhgbB7WE3cU
Message-ID: <CA+G9fYs2LDdWX-w=7JA26tkYN450qg0230H9mfB-PymqmPsZ4Q@mail.gmail.com>
Subject: next-20250725 nomadik-rng.c undefined reference to `amba_release_regions'
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions noticed while building x86_64 and s390 builds with gcc-13
toolchain with allyesconfig on the Linux next-20250725 tag.

First seen on the Linux next-20250725
Good: next-20250724
Bad:  next-20250725

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

* s390, build
  - gcc-13-allyesconfig

* x86_64, build
  - gcc-13-allyesconfig

Build regression: next-20250725 nomadik-rng.c undefined reference to
`amba_release_regions'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
x86_64-linux-gnu-ld: nomadik-rng.c:(.text+0x6fa057a): undefined
reference to `amba_release_regions'
x86_64-linux-gnu-ld: nomadik-rng.c:(.text+0x6fa05a0): undefined
reference to `amba_release_regions'

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250725/
* Git sha: d7af19298454ed155f5cf67201a70f5cf836c842
* Git describe: 6.16.0-rc7-next-20250725
* kernel version: next-20250725
* Architectures: x86_64 s390
* Toolchains: gcc-13
* Kconfigs: allyesconfig

## Test
* Test log: https://qa-reports.linaro.org/api/testruns/29245454/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250725/log-parser-build-gcc/general-ld-undefined-reference-undefined-reference-to-amba_release_regions/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/30LiIUwnkUApDe74DgNCqkngoPB
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiIUwnkUApDe74DgNCqkngoPB/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30LiIUwnkUApDe74DgNCqkngoPB/config

## steps to reproduce
 * tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13
--kconfig allyesconfig

--
Linaro LKFT
https://lkft.linaro.org

