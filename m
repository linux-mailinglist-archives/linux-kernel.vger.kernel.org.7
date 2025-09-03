Return-Path: <linux-kernel+bounces-798247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D9B41B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2801BA5469
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3BF2DAFDD;
	Wed,  3 Sep 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1d4eipZ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAD255E26
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894104; cv=none; b=qWZDk8K6cWZth16FF+JGWSJr0zjloJ0AGavo6kxKZouk+aKB9eN+RxWwDvbSBxbRfdxXIh3LkvhNgcq6JpCPy/crwRixxSMGYdSQcAff1sGhRjXDF00SISTeeQuG7mZUSEn4RiTPcSlbEuVWwtgCISWrwxOyrh2gJ8eYHxqeDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894104; c=relaxed/simple;
	bh=N60bxwoBK42jCkCkhaiyJ2RpMvLMJ+7cNdqT2d4o0Pw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fVT5nHcvk9up4xaH+6dpRy/DIuxAz5fdv7YpSSE8fJNjs+K2J/oNd5u9Hu20A7U8k+qd+erTbASWkLskBEq4ilgr0HvEpyKES6lGDn25MYJovd/XrZIG5L1BHBjNFYIcTEziZG58BMqr+AJ24vuy5prUFnOusPZauaYGsfq6kyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1d4eipZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so2277728a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756894102; x=1757498902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8UwOAQLFxlapL4wJjDPziLZroOio1WKHWOdBe615V4=;
        b=G1d4eipZmRAJMGwYANGG4YXgARox1s2XRDXBe0IhBdHj52CJ1hDV3FtPUfYXwsUHbp
         9JQL2iZ92RNL41yNq8f9TOdpLtWCGoS8zkJD+M2XeTktoPTsx98YD61Y378aSB94QuAk
         QLV5/F//T5vRz+9LW4xN8pxA0CaRvcvZuTxPoquzNdT6vkLfUTcx0NjN+234x9dirtRc
         b3O2SN15nno6jgQoprBXztLcv1NsMYlaj8m/+30Om8eCGtFgmdlLI8DyIt5BsFuZKYC8
         RKJ4HsQO3fNbsluZCcIUl0/b3vSfwOA9xTyWCJTfQt/tzGu121TucPN0pYN0A//3n7MS
         ibDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894102; x=1757498902;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8UwOAQLFxlapL4wJjDPziLZroOio1WKHWOdBe615V4=;
        b=et0R0cp1vYZmdkSN/pKIZDTTmOyqPHFRsAVQOCYbnVMwScfgAx8VeV4BmhLQgK7xpZ
         /dUSdL/FACiAIHUk80AZDCcSusDKrlPm8C2IrkMiAGtgFKQ+cLdUAap1x4WRRBx4hg2v
         bTlK0lQgHdWuPhod3csOpO/Ev+JRg+/IKdm+/NP5y2l1HSGb4qbbh3bLSTR0o7LjNQin
         fEobBuu4MbAew6UpnFmCrLAQ1k9Ys1nS+fEsPHVZc6YVuUJS8MH+T4d8gFBkIe+rBOf2
         LEgPu+1dkLbkhoIp0xN6hIGDLpZmie+ryvcBn/lZgjTFm/kkczDAXd0wZPqUCQjACLzt
         U8EA==
X-Forwarded-Encrypted: i=1; AJvYcCWQS3Jbp9k+NfBdNkH3+PVjLqMqWlCLr/5DcgVwh62E+F8hU+0ERsG7sIKpuBhRUlN/9ukPbILK2UTXe9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3POXcWqn3NU7+4WwI54GF1efJDy7ib54YZ2OzMvjPc1MaCGa
	co7OkIJI1igN4+UJbwc5iQqgg3tHEksCPQXBzwGH8J6wZSdMnP3Q461EcZRiKhq/IEDKzIpS7Q3
	1pVYL1/h6XMAYwvgPxqobVOdmyS+Alef0yduEPob5bQ==
X-Gm-Gg: ASbGnctv/B15o2TftrkRTIdAHXfMJI0tklZ/DBq2Eg7yadcqqgfNJvDFjKYQLziiDfd
	UizUTqEursHtjw94ufWBmKEsR99owOG7GaGS9M0/1cc4VurFP8s3ET9TpiZwZDZ6xNboHi//Nw/
	lhtDuBaKin9thjYQkR2eT2cj8pH3TjYVJjrDNHG8IQe/L3GDkZUpi9sOXsH01WR1iGh6ebqhJH3
	lq2wPJTrNpJMfWZABECnjHD9uQq3o0kvxdK3X6d
X-Google-Smtp-Source: AGHT+IFXPS/WTlketDT7Ry+T0jvnXkJWiEWLHz4L2qR0cIclYFFQxTiDX5NTPXgKjBbk7T07stAxT1Awro5pXflUEHw=
X-Received: by 2002:a17:90b:54c5:b0:329:8160:437a with SMTP id
 98e67ed59e1d1-3298160446amr17933963a91.24.1756894102326; Wed, 03 Sep 2025
 03:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 15:38:11 +0530
X-Gm-Features: Ac12FXxzMFZM2zT7oOOLzDits6M_03K1dnyTRhCYTrY8QuqW8ke90eorpMyKwq0
Message-ID: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
Subject: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14: error:
 shift count >= width of type [-Werror,-Wshift-count-overflow]
To: clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	dmaengine@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Vinod Koul <vkoul@kernel.org>, Guodong Xu <guodong@riscstar.com>, 
	Nathan Chancellor <nathan@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors were noticed on x86_64 allyesconfig
with clang-20 toolchain running on Linux next-20250903 tag.

But the gcc-13 builds passed.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250903
Bad: next-20250903
Good: next-20250902

Build regression: next-20250903 x86_64 clang-20 allyesconfig
mmp_pdma.c:1188:14: error: shift count >= width of type
[-Werror,-Wshift-count-overflow]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

x86_64:
  build:
    * clang-20-allyesconfig

Build error:
drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type
[-Werror,-Wshift-count-overflow]
 1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA
addr capability */
      |                     ^~~~~~~~~~~~~~~~
include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
   73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
      |                                                      ^ ~~~
1 error generated.
make[5]: *** [scripts/Makefile.build:287: drivers/dma/mmp_pdma.o] Error 1


## Source
* Kernel version: 6.17.0-rc4
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250903
* Git commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
* Architectures: x86_64
* Toolchains: clang-20
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29752023/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250903/build/clang-20-allyesconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4/config

--
Linaro LKFT
https://lkft.linaro.org

