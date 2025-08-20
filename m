Return-Path: <linux-kernel+bounces-777759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59710B2DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F12E7B673A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC131B10F;
	Wed, 20 Aug 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USNPPT+U"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC531AF21
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695645; cv=none; b=Rtor/uU7vwJNBWokwnnsi+ES1vqpIQplOrevjSPcaQaa//jqgX5CJ8FuiP6karHueuyAktVTKEGSh/t8b6OfQUdQ7DjaiOMINfdUz8UP14GNfMFiIenB3UtCzHOKdZEgJyc1IDKHP+Yp3p9oAoCwLRcA8tSSzYjaSsI67RhJ2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695645; c=relaxed/simple;
	bh=KPSqciT5t06cKS/juMXRjSVgnjxRqIsScfumcMkysfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hAxmQuKxT9SJP7FfWkycSKfuJKzM6i3yukxEWLi5qCNSdLPoSJu3VBO7F7isA2cR20CrX05j6hhDHE3EJpxkZLV1Zc2lyIkJs97kx8ztSa1ZCBFLeRKHhOhGePL9T1tszUc1Us/655ojf6yuolgPPz4DrzDehlxabpcCqRdQZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USNPPT+U; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47175d02dcso5335224a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755695643; x=1756300443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEhLj+QpdbdIXsYiUCu+v2MbxwMNrA1QXcK0xjWmvUg=;
        b=USNPPT+UVer55b6F4DCtWQz+eZxdh0mdzvT/wvZb5KL44j1742JdeGHOQa08aPKAA6
         Q+HwoQ+ZlXsuaGA9/4vt8eX05eDSX+lyBkFgwOTqv03Xz0WeiNJ70KFeaiAc5UA3FVls
         oXP50oTcW2COz6TV3wBvBeyAcFVYlD9FWYirQ6YI1yxbg3CKpS5FdHCIyT+jQ93VGcxr
         nI+iG1QaodB/0ud+KWjoqGyR9ncjatJuaziVaVE6yI3GV/RsWrTH+OwKTs6nJc1RfFhU
         ABq/EnAYxVpSWaoNr+DXO5XN8tuPTAOwnPJDpJVcln1rfPo29uUEijE61Gmb2Z0arfn1
         0GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695643; x=1756300443;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEhLj+QpdbdIXsYiUCu+v2MbxwMNrA1QXcK0xjWmvUg=;
        b=Ky3I6MhhcmtKNqygY6vNL816Aaqn8i4j17p7FurOo0G6nr/pUlsyC4kGr53q18GYkN
         Xw+/lf8t/I21h+jnXnGPvigjvbDDDNKuAssncEJDkqDC8tIigh65f0kr4/L9fQIr/HhL
         HBqVgCOg3iyJMkGRJhw6oE+gmINiNIVWxwl3xvG5YDvVnMBhNJ2QAd4AXQ/RZvqvCvAN
         LOBGj6EhPDjiwenCvYrcZ26dIrbXw86XZyKMDcmLGxnbuF4WTBtGIbLMQ4rbkihdVhGI
         L4cOKzOKqMUxG1X+6bhCyroo0kGYemhNm8Ce9aRVlBg5AmsrzazUM+tYj22YVHBTmqiY
         3Ziw==
X-Gm-Message-State: AOJu0YyPqwwURrVShJgyogNnI50Hrdjgb0x2kTted/8odyDztPdc6gMJ
	goIFWh0fhWBIcOpZMD9c/aD9xgivryKDxmejKmZz4j0ELxWzyQ7MThe2lwFKY0lu1SIDKJri5jo
	wnAtwmk1TdHGU/f4tvVRkcPL8Wvz8xEkYagJ8EHXF7RoCXdPjM3J9OBs=
X-Gm-Gg: ASbGncspog8efqVut+zuyoqp5kMST/wf4Naf4c3iz+fZ87nl/2sEOraE5gE08AvVvTE
	wX3kkuYxiyDZEiZfnhKXwDr817l9+Ais3r6SimBQLQ7Mz2IQg10SdmmZbuMmRys/LS6FCR5vnqE
	Rmnv6dcCOaikAQZeQ2FCN8W69k7XVNl425b50zd2Bg64dx3r+HPiGKzkPZ7Nqc+GzhAJooRUcL0
	kCIDvMcdDNJqHNHxtk4gtIpu5vKcOSN7IJ+gu0=
X-Google-Smtp-Source: AGHT+IFBJmOUaT50s2oqxUyYw4FxsnPw5mGp4PfDEiEg3YvV4hdLkFdHYDMKytflbhE2y2paxnWvZ4jXvQbb3KvxgAs=
X-Received: by 2002:a17:903:1b48:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245ef1728b2mr39549355ad.24.1755695642929; Wed, 20 Aug 2025
 06:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 18:43:51 +0530
X-Gm-Features: Ac12FXxC0MUMoUEpSUxG3tHBnH_B58ps1yvcBAmlPD_lH0pv4jzn6YQynSvCFy4
Message-ID: <CA+G9fYtS9nDqC7g-B4285gmxDNRkYQixyPYMuzgDg5-sy2FumQ@mail.gmail.com>
Subject: next-20250819: sdhci-cadence.c error variable 'hrs37_mode' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed with arm64 defconfig
and x86 allyesconfig with clang-20 and clang-nightly toolchains.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250819 sdhci-cadence.c error variable
'hrs37_mode' is uninitialized when used here [-Werror,-Wuninitialized]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
drivers/mmc/host/sdhci-cadence.c:297:9: error: variable 'hrs37_mode'
is uninitialized when used here [-Werror,-Wuninitialized]
  297 |         writel(hrs37_mode, hrs37_reg);
      |                ^~~~~~~~~~
drivers/mmc/host/sdhci-cadence.c:291:16: note: initialize the variable
'hrs37_mode' to silence this warning
  291 |         u32 hrs37_mode;
      |                       ^
      |                        = 0

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250819
* Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
* Architectures: arm64 x86
* Toolchains: clang-20
* Kconfigs: defconfig and allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29595553/log_file/
* Build details x86:
https://regressions.linaro.org/lkft/linux-next-master/next-20250819/log-parser-build-clang/clang-compiler-drivers_mmc_host_sdhci-cadence_c-error-variable-hrs_mode-is-uninitialized-when-used-here/
* Build details arm64:
https://regressions.linaro.org/lkft/linux-next-master/next-20250819/log-parser-build-clang/clang-compiler-drivers_mmc_host_sdhci-cadence_c-warning-variable-hrs_mode-is-uninitialized-when-used-here/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31UgO4773uaneRjyDrf418EXcDd
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31UgO4773uaneRjyDrf418EXcDd/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31UgO4773uaneRjyDrf418EXcDd/config

--
Linaro LKFT
https://lkft.linaro.org

