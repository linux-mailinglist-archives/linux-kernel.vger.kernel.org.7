Return-Path: <linux-kernel+bounces-871159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC7C0C8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC051188B6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C662FB63B;
	Mon, 27 Oct 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLd+k9jD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E12F5A29
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555411; cv=none; b=i90wKcFsnNeNm8ylxhN2CDUsodPKsCbcfWH8TNVkdVP89eqXM/MmKK4uy18b66NT9sfEdh4OKmZ8C7kYNo57Rj4WrwmnQ3/0CqOKyEjTDYfH+zt0LfFraGcHyYuTFHYhFkkNkIfgmZIZBccw3vWHDTAP7zlm/SJXlSTNugH1Zi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555411; c=relaxed/simple;
	bh=GfH5HSIKG5vJgzEj+X68rTPCf27ssZ6UVJw48ldkXy8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=riwFBHYNLM4x+CdbzWSor2tj5V9y4YoNuZRyro/BI8EGIEHAnGb3a6De6PcNQauEIz022gVfKVe7RkTUgimxMi0FTNUt2n+kyZR1TL//vXl65gd84fars/43V6creA3vbWsVfDK4iUDMHw7VWwdv/zP09sWtWu+Oaj/WS8C4/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLd+k9jD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so4474618a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761555409; x=1762160209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEKtCxt8nIo5AAXBRjH/5vryo/ZaVKRjuXDR6Hi5YuE=;
        b=YLd+k9jDPiOR4DzlenemRWEPjXu5rvR+N92/VxDysU48igMFAHnJVOuYMFIhgVwKIi
         JDkjact4QSihlJI4X+7+Fq69eSZ6A7eQvy/2e94VhCiUP7OpxuVjy9MsOhc4d5Vi8Vd/
         eIYq29In1UHG4OXTZrKvSN2nbLPremJVDlPbNoXc0mNbgRt2zR47fB+WcMPGreODHHP4
         5nDlUUt/kRRTizDXEXnOfyH6KU9vw+v8AjILFDb5lGkBOTWSLErxL07xnNYiCwjCfCRH
         GEOEMajWlhs2jelTiEPlh+24a59nqDVIM7vLSslsGSX0WXmjO2dBhImIs1U+yi8Pn3E1
         Jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555409; x=1762160209;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEKtCxt8nIo5AAXBRjH/5vryo/ZaVKRjuXDR6Hi5YuE=;
        b=GLI4vKDGnMV1ouehJEh2ZEZ6mbX24kIsroD/3uFj83gqMn1rPI0Rm8vFdiTkZ9ltw+
         N7VrQehGLffgC613g7q/KMWqJUtWd+8JZGUDpYUydinmyEom6KVbFnCteXBPGWrX+FiD
         GwMCUdQ8V3bsHQKy/A6ZqS9IKFHJek+KMVsts8r4ICgikOBj7Uya3525J4WYyO5pZUsg
         VDp/2/qIiBRoIEnJFXsLzyYOHLwcjeiFouijV9OE10rVE2jWR15Aj8QT/lxCffaJFKE0
         zgt+zsmFEHU1WEUHGVZyR780B1GIWC4oOzEbg5poFyt6JRc8urWCjAkLsWJ7jtZMm8nP
         bBuA==
X-Forwarded-Encrypted: i=1; AJvYcCVP2qmeJK4UMGBzLcgoxjeO+wPGTBwHWdtZIji77fwBHeWPTVy5Wc+GKxtJT9+B4kpC/6bIvog+fJWfueU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qcEL4B4Ji40ILKYBuvxqdOmICTsSAC4whF5qABklymL0YfNd
	6fFO0T3z35iRYpg7VOvgxf6mV3yesg+nNHIREb4CaxHrtwIF9IL1OaQi9R4UMjoLCTf7bvZsNlk
	Cx61Ny/2DVWf98vs2NsO2CvKPuAvrB5Z32z75YcwU4Q==
X-Gm-Gg: ASbGncsWVnU7RaBlowou6VcBnEBllx9Rlv+kI/DFDwu9SqPA/io+YrOtZSEOTmq5OaZ
	TjFNm6NioRtcxDBVcTbhCasZASY9UmXPHT03VaH38THGo9+1ah+AVARJ5bxOVI2BwDwRLa3+yCt
	sX70cJdK6tYrKf5YgzQ0fFxUpPPcf/bEpKAzKRVWv+2Mca48qi4Z6WfR8ArozcK+bDFyakb7tBi
	W7o62gODxWb9oM/CvxUZFHsudZSpwWFsCceSngxFUybFVBAEjfK+rm7xO6ofrM4RE3bicyIEOqs
	NLeX09ji9B3BDfU+0d3cQYaErNuoaYXApa21ZNjF1DJ4qqs7eZQi1cyPBStzOg==
X-Google-Smtp-Source: AGHT+IHMTIIFLA5mgk1HP2tn5C+IZfCTCdQhL9lHvE1auNKQlgk4Tb9Ecb84rLUsDS+i/shyTUFa12dikG6jGXBHIh4=
X-Received: by 2002:a17:903:244c:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-29489e15ea4mr133599525ad.20.1761555409385; Mon, 27 Oct 2025
 01:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Oct 2025 14:26:37 +0530
X-Gm-Features: AWmQ_blJuZ42rueT3RfdCwJIhx-741RLJJ31SSl37TaWRIG6sy6Xm1B0UeYV3a4
Message-ID: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
Subject: next-20251027: s390: pf1550-onkey.c:154:12: error:
 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sean Nyekjaer <sean@geanix.com>, Lee Jones <lee@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The following S390 allyesconfig build regressions noticed on the
Linux next-20251027 tag with gcc-14.

* S390, build
  - gcc-14-allyesconfig

First seen on next-20251027
Good: next-20251024
Bad: next-20251027

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20251027: pf1550-onkey.c:154:12: error:
'pf1550_onkey_resume' defined but not used [-Werror=unused-function]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume'
defined but not used [-Werror=unused-function]
  154 | static int pf1550_onkey_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~
drivers/input/misc/pf1550-onkey.c:133:12: error:
'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
  133 | static int pf1550_onkey_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [/builds/linux/scripts/Makefile.build:287:
drivers/input/misc/pf1550-onkey.o] Error 1


## Source
* Kernel version: 6.18.0-rc2-next-20251027
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20251027
* Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
* Architectures: S390
* Toolchains: gcc-14
* Kconfigs: allyesconfig

## Build
* Test log:  https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/build.log
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251027/log-parser-build-kernel/gcc-compiler-_drivers_input_misc_pf-onkey_c_error_pf_onkey_resume_defined_but_not_used/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/config

--
Linaro LKFT

