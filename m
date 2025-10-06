Return-Path: <linux-kernel+bounces-842879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD470BBDDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405B33B3A68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2126A0F8;
	Mon,  6 Oct 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sICFFsxk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF379EA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750215; cv=none; b=AHfpzZXGJkMgKZtoFShTTwhslK6f6nod4tVC9qZDqYXBpfFEyM7k84fgEUwXlt57YAJ3tj4li0lqlJEyxmkSol3iq55lx1nmDN54TaIPh2egKckDPFi1f5AkHebHQL1XDA5fftVemkvzTKvK74T+bL8vvShIQtMw1Wu31e/7RFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750215; c=relaxed/simple;
	bh=osn5ew/lMxGyS0lnJ4uClg6NxZuq+qP+tS/nSidtHrw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rytcxEC7pfRRehyjX71xSFziKAI2hHcjAF+Mt+2TkTQPncH/9G11ZiNDHJOCzXHkpciwcbVz19XvEyqLFTfnKMw6MLBfGN8vt3pQnaZ++rYvZz7T/htT0UY1/m7tWJhOj8ou6zfKIm0W+ueNv4o+sNpjWwkgtU1jkLwjBN0dAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sICFFsxk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d2c35c459so33974955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759750213; x=1760355013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A1b4UieRxnHeJDLUzPk+Z3+ZvYx2PdGFKhNe67w07jY=;
        b=sICFFsxkdT+akEKw6iK/BVkjDyLG4VjCLi+FLFKz34htnKbZ+3xaJAgbKPuocf7mst
         ckVI4bTdGP8Uf9yF0StbFOsuHwu9VUuCabSMuGUzFCPIFzDOcK9aYWsATE5keWI2vC0x
         PXbGdjWL4U8Sn7ZC+gf/CmTUHZQRoSO0jII3cncmwl8TzKuY7MGqP38xnRiTj187sxlW
         vtm+cJr8j65AVVBfc55lYWVwavvpy6Pa/SHs1GyweOJe0aeehp+LJVBFuoXMf/UhouqG
         1UL0RJIYRYuiHSNAF+78/SRmChRmuYyu+ovzxeo6NcrQK9YLC8C5k80qJxnrXUxHMsVv
         y0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750213; x=1760355013;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1b4UieRxnHeJDLUzPk+Z3+ZvYx2PdGFKhNe67w07jY=;
        b=i7w6UxfNlLMq/XXCFYl13k2YKv0QXRmAuwzkpToAOjszyv8mL7rCRiGIti0qRqwyA2
         nUCqcSUdlys7VhK/XJHu1GhJIeEqTpZW+zrVTVbGuEc6RfedQKjeTdQqP5c03BOahvDI
         1WudYtCaQ7cQQ+Vfjv6aK5bLt9siT8exfu6uV72MTuvMoFhkvrR6HDn2BKo8rwT1xfSp
         FDSlfM0XvFCcvNOo2ak9dIV5eA8YgR2DLX/9GQyl582L8HIBcLm5dCGiitMmTobSTgJC
         T7WvP7Ac7W5uYyscelkzmT9u6SDBSRQnt/wbr83ReHnNk1egX3NKN0aZhJpCBsRzp21v
         YnKg==
X-Forwarded-Encrypted: i=1; AJvYcCWOl56Inr4oJVuVJfwJnmWOQ8HRPKVL2x2LtQOFABhiJ6NLhSS3M0VobASihy7wJyhW/6/U1E7JCi8lfBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSmgLbLqyn9xjw1kkiFgyveIHIA9h2IGOGh3IOqXjbmoUe1+I
	qm+X5U59WAGtIxSvVY/ytQelfiDmGHnfC71v16htXrpbU35O5BL5ZQHbIX/35L6zmDfo382g7yo
	CZLZKeSisqmXzPeJhW97Ei8GwPeVjm+UXQYuvHLgvhQ==
X-Gm-Gg: ASbGncsvotErCpbpkGlT2vne/VOysZa5WlWmSb+Aoy+lgORJquQubz1oJRJzYFgV2jy
	abDIrYglHnTCuaQvW4F09bHLy5NJ3tR3mlZkgbGKFR+ak9qbIZs9ANOZ1VEmVV3eqf+4OzV8hQ2
	o+z/dAWmdJYvbVws7jqJPoygAxLzMFkMGHeG4YWiVbV9Llu4dFiDRQQ7CHYe1CtcnV0iJ/zVbMj
	pXP2GQER2tH6SGNF7nX0DnAQHWy+RLUcrvsoC15aK6CKX5dOEA5/lkG40XGmOVVm0GXtCecdcfr
	HAJZUxirzjmrGDopOrJqICo=
X-Google-Smtp-Source: AGHT+IE7/BR9FHufOHH3BLOQUgqTtS1rfbVXN5odMkAwRA+sZP80yDXLfwd06HD6VkaXe09XBa5fi7EiEGqxb/9Ze6U=
X-Received: by 2002:a17:903:178e:b0:274:6d95:99d2 with SMTP id
 d9443c01a7336-28e9a6a90e8mr136255395ad.39.1759750213517; Mon, 06 Oct 2025
 04:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 17:00:02 +0530
X-Gm-Features: AS18NWAcN9W702ErPzrjZGWWRgZjF5wGQGJwFYbwG9GAp2PHp_NMPerrOOnYfiE
Message-ID: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
Subject: next-20251002: arm64: gcc-8-defconfig: Assembler messages: Error:
 unknown architectural extension `simd;'
To: inux-rdma@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

[Resending with typo correction in the subject next tag]

The arm64 defconfig builds failed on the Linux next-20251002 tag build due
to following build warnings / errors with gcc-8 toolchain.

* arm64, build
  - gcc-8-defconfig

First seen on next-20251002
Good: next-20250929
Bad: next-20251002..next-20251003

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20251002: arm64: gcc-8-defconfig: Assembler
messages: Error: unknown architectural extension `simd;'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Build error log
/tmp/cclfMnj9.s: Assembler messages:
/tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
make[8]: *** [scripts/Makefile.build:287:
drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1

Suspecting commit,
$ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
         (".arch_extension simd;\n\t"
fd8c8216648cd net/mlx5: Improve write-combining test reliability for
ARM64 Grace CPUs

## Source
* Kernel version: 6.17.0
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
* Architectures: arm64
* Toolchains: gcc-8
* Kconfigs: defconfig

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/config

## Steps to reproduce
  - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig



--
Linaro LKFT

