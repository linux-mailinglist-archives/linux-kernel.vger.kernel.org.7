Return-Path: <linux-kernel+bounces-842881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32811BBDDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E422F3B5C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AC26A08C;
	Mon,  6 Oct 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/A/w20Y"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9217E4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750321; cv=none; b=BrbTkjbHewiLyWV4ro3TKZsbKd6Rh4TX+8WWOWADpxayufGTk8aSr6ePeruHgY7IjxJomYkh8eiaG82i3smx0+bqdyaT2ZAyv2h8tSi8BVFqde+rWO5ScOZyDNRJmqUQchCzaHiRKc6G3TrY+Jf/Ku3G5Fl8R9suZ66HeqGAsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750321; c=relaxed/simple;
	bh=e5CBSXrn4RtHdVZca6FSaw5ibW+hSpYdEP3TSjb1z80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6c/BTYjYe48o2SLhhOvjcEs0fYEO69wvQ7tqsY1s2pKuZWnzkKRH68st18ZO1pLJaIPwRunoyoJ8uYuiAOpP+RylDU9FZaEwfYtAB0h0Q30Io+Cpt/tDlU2DG9P47HzOIpDetLEUb3o+v1oWktefzTs+iZ12VIDSzZeCw/cu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/A/w20Y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26a0a694ea8so37783705ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759750319; x=1760355119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCdUfSq56tzjd9BJmamnogQpujr952D9LtJP/K+DvPM=;
        b=S/A/w20YELdAPXUSmXi7Wlxl1HoO/Au9vya4EXq69dQE6cEjIKsO13B/XKhp9EEbky
         4AfZM3CbsGFvJlVpH7qUmtG72dt1TliYrbNQBtEusJJkIU/7hRgkPWVcuezCrRGHBJQ4
         YF7e1ZBEPuOlmSatcUSldUp+EhPqHri1mPkbu+w/JLtewkw74L+BYbm3LiKdMcvNKO1a
         1ugrk6A7JxtEkhyLPqOZdxMdwF1zxfC08NlOMSPd59m4qSzCnkLsrguk8bmLQ67oRvhO
         O6UuM7lsTXoDLJRbBTt1Rb4uRm2SqYak/NyQ1ab8wZpm3hV9jXOFDuLF5q8ExEQ+5hbO
         UxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750319; x=1760355119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCdUfSq56tzjd9BJmamnogQpujr952D9LtJP/K+DvPM=;
        b=t24hYSzaRkLHSXBHHkQvXDin0XfitypzPi+iaCSIzWa1MoTYDK8SO34a0MEfX6YWzj
         JI9hoLuSpWykwWqrym5KWlruLCcv0QDNTGqGEsQhuYg19+v9TpxNFByBKOkRUF044GsA
         gKs1t/eBRDPTrkzMBzhycxi3kj7jWPe1NWiCRgwUXecw0PrbJHv+hfLLEh9Sa8J//MLi
         YYvLp0VyLiN3afFOBcXSbfV/NG75hk4mt2VS/TRdy6YuWluahNn84dOVQhMYN9DVbMEt
         FikKnF9R0hCdHL4ZhTHZ2SCEePBI4E3cBKKZWL5Ne7JnsAu9lpWcloeAyT4tMwyWGeEl
         B9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVssGU70KElI/PjmdTsR47UdbpH05RadvqVyphY0OAGhQFmQLxJ80AJqBTzKBROo1KQfBnMtfL9GY5hPuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5m9pLqHlCwhvSU5W/PEx4fpqiSXZ4zOS0Yhle/yt1v9rj1Ens
	WxuXttJJo9XkgqtpctuYLo27IWikCum9B82WACUZsPptBn5IEj4bXxweKASPzusCZsgGRPBablb
	nl6JufmTbqXOLU/BTx+UaHaBDzrLAMCUYqo00zhlPWA==
X-Gm-Gg: ASbGnctTstz3DNiGrNaEmC70h6x2RLAvkMY5r9eF8eOZiSr2KfTkZhdM8pHiqAVj1Pu
	vFPidWASKD90RYGTLvPeiJjc26w3I3znFrCGhHxacVz5flyld1uw4XNGVne3c5fOocem/+9TWW0
	zFooHRNLjCILoE5Wv2o2ORyIkEk4AE0dJZAuw+58gfckwKNCBEy2N4HnxT4wjwgvpvGf0tcbu+r
	4/jdPJJ8tYkH+Jk6LTCh494xcB8UewyhZm1SgZnLTgTYRB8crHVCT/JVp7F6LyPzDW5MELPb0WF
	OoiHd9UdPjh6EWV7S2yPXVkm7R+yxoE+Lg==
X-Google-Smtp-Source: AGHT+IHk0BcyHGNjd8fw0KaD/j6uqPvdrOPp0sarkJmj00XawyQpO8GAec8OzHweFlDyK5jRXRrJR1iEX/aJ4XaNBSg=
X-Received: by 2002:a17:902:c94f:b0:267:b6f9:2ce with SMTP id
 d9443c01a7336-28e9a6dc5cbmr138177325ad.41.1759750318721; Mon, 06 Oct 2025
 04:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
In-Reply-To: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 17:01:47 +0530
X-Gm-Features: AS18NWB4sx-MUkILVHxbXiSvIkCbaL1n4-3C_QY4dTO4nEO29p1EMqNEWalh0DA
Message-ID: <CA+G9fYt+9QZ4TwEx7+m2S5Vtn7cq1N54oGceSR72upZJTrzkng@mail.gmail.com>
Subject: Re: next-20251002: arm64: gcc-8-defconfig: Assembler messages: Error:
 unknown architectural extension `simd;'
To: Netdev <netdev@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-rdma@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ linux-rdma@vger.kernel.org

On Mon, 6 Oct 2025 at 17:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [Resending with typo correction in the subject next tag]
>
> The arm64 defconfig builds failed on the Linux next-20251002 tag build due
> to following build warnings / errors with gcc-8 toolchain.
>
> * arm64, build
>   - gcc-8-defconfig
>
> First seen on next-20251002
> Good: next-20250929
> Bad: next-20251002..next-20251003
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20251002: arm64: gcc-8-defconfig: Assembler
> messages: Error: unknown architectural extension `simd;'
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ### Build error log
> /tmp/cclfMnj9.s: Assembler messages:
> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
> make[8]: *** [scripts/Makefile.build:287:
> drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1
>
> Suspecting commit,
> $ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
> fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
>          (".arch_extension simd;\n\t"
> fd8c8216648cd net/mlx5: Improve write-combining test reliability for
> ARM64 Grace CPUs
>
> ## Source
> * Kernel version: 6.17.0
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
> * Architectures: arm64
> * Toolchains: gcc-8
> * Kconfigs: defconfig
>
> ## Build
> * Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/build.log
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/config
>
> ## Steps to reproduce
>   - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig
>
>
>
> --
> Linaro LKFT

