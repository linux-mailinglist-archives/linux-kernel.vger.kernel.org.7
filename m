Return-Path: <linux-kernel+bounces-724341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977FAFF191
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9D91890071
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7B23F40A;
	Wed,  9 Jul 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDNcYaPS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F823E25B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088446; cv=none; b=nz5jX9uLMp8TWXBQbpw29ACmGosPUG7K9+D7j20sQQzq6in8b99TuEsRTAr8Z1QvzgOdV16WjRcBOTH2V1gD5p+h/uHdwVhsNX0hrdMFAVVGvg4LMzBs1TSLN1MuPTIHIN1vCcqlP5j8lUCrohHklpg7j35HPX5yGX0bgiuGFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088446; c=relaxed/simple;
	bh=zHDAgo+3usMVt1m3EEn01KDZ4SXsamOfc9Zt4WzYYcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkIMcuAFYbIdV8/tFxGibkLw4fYEF0J34oDTj7z+MNaA3GlyLdSmz9UXQEE3idrFlmOkQ6Zk0BkNnhj9RxkB58w731lx4BbwEHRikOP1VvPB+8ZMroXgKzTFpWFdEWrg3QWIqQAqjhcGheuPoQfuoblz8C/5BsYAFV1jYIXYe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDNcYaPS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450828af36aso200155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752088442; x=1752693242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LO2SvKCCqko+0I0eG/Gzz/cIcDsvNsYtE0Nh9DYuiN0=;
        b=sDNcYaPS/eXYFC7nF1pKmAG8GQT4TIIdN38xtjIWCIEoYHSyjVnbV2fkU01TiwLJMi
         l2RR/DdLzA9BEkSgMO6PgKc/TCOLX/YjSFcjACezjx/tKdET5xWP/NJsF4FwZoLOQH0W
         Tj41S+I1OMM0dJ8c6np7eKgfucbZiMkk76TW2YO8wOTXmPrYMjZy6rgya5FMK1ZKads8
         JCr/Gl/GOkLtC8JZAdXDvvCXvKUKiHHefnw3eHeLj9pzbA7JzovbIpFM6rrTMpAUykbN
         YNovUCCv1gMX62o0LWCVJT/Q/xfaWHonn+JH/2NLqtCRC78bPSDNV+Kj1EVS1M+Ookwq
         aD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088442; x=1752693242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO2SvKCCqko+0I0eG/Gzz/cIcDsvNsYtE0Nh9DYuiN0=;
        b=FnthROnW9BpxR1h6QoZaTdSEJkwyNY+akNRTfsw+O3dvvnYglYvjJ7txJg1ifkbWpL
         ZzD/GPGjq6KCKq94M7BlklHXKIl5Lm7F9wrVpH+ASZaOYADVY4tkt0P1fDgK9v33atRJ
         lW+LxMD50XH4gfNFoo/ngE6zViZTUpjoWVY5VYK9INRghwL/Z7Vvb0wPH/rTxiCrhhzL
         L+tFnU/+PelX+7SCYdFx0cmHaoOhECqTjmYn1/0ZmKTF8eKT0FudrKxRD0i5mpiFRWdp
         y5aPsArfHebupeEFtzM+2EZ0KcDMXHTVQmi2HOGsNkazMLQ4baAlvUEZ2X2raqhnpJU0
         PPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbhzOl1XlrGXyw5e5fnlI5grd03jbTvCz1BCXtPDL7FI6x1iu+GjNEESFNBZaJ1XuSxCneSRWXmaMTnkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLw3Moj2NNccXmUXtaNqqtEFbSnYJYPfoa4cSnVXxpxN9MnDIm
	wt8ss8IjS8KgK9ntqK9bLb1yv2KJolaOSsDGjtUb5oHF1dbBB7Is4+KV2Eyis399xus=
X-Gm-Gg: ASbGncuN0KH30SNKcPUQaLpSmzyjTMiVnOrh1lF/enGgIQho4D8/id4YWLSONJMI4Vb
	bp3YGSJCdyNWgdlP8JLvSxYYMD+TwoysEAxFE6N/qsHHv6RYsf2Qno6PQtsRQrdyoYn2IVqhkDd
	Or+kbx2s+HisAGplU63AZ0KJekazUHmfRL+1fIcS5b/Cy4DKgSPutW4nNn4h9hEyVs/aQHriipW
	hyMsB2Q40DOhvX+XiZq/8WStKB+o8IUa1ReKfDgiXKdvr/Bw+qQ/3ObOItCH4poK28XwpP+1xLp
	/rJ9X27xR/nr9ULZNiDyhhWN3oumd5znyvax+NyLwwgAsy9GqSKNOJviMEglib70t/ChpCWUS7Y
	=
X-Google-Smtp-Source: AGHT+IF+y4VS+J+ifAdhQiRONDZqZsKUZRm/2F/D1x8s7RGynhJsmman4W9nCsHt84pBRtIV7i+ROQ==
X-Received: by 2002:a05:600c:19d1:b0:453:9b3:5b70 with SMTP id 5b1f17b1804b1-454d53eeff3mr13735995e9.8.1752088441748;
        Wed, 09 Jul 2025 12:14:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97353sm17115944f8f.51.2025.07.09.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:14:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-clk@vger.kernel.org,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.17
Date: Wed,  9 Jul 2025 21:13:57 +0200
Message-ID: <20250709191358.171004-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=zHDAgo+3usMVt1m3EEn01KDZ4SXsamOfc9Zt4WzYYcE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBobr928v6ljIcAcuQ3vV9rIKJq6n7Tm/0r2elL4
 FOSeEekazqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaG6/dgAKCRDBN2bmhouD
 13qOD/9pbiV+Cnbqp0KsjL6cy1H+uJszH7jFQPm4e7juzTsGXcLalJmneRiviNHPeQlhY4Re2Fu
 sHLTlU59BDYNC9BHWjmfHo4jqxNh3FWStRKxTWvurS4QzcqRXtmhjwQYHSc2aLRl48Lvt5gDur2
 RrNnEZ3l9sh1m2mV9wldUyBmloQwS08tIkYd9LQKLOJ2KWRr2PYi2H7ezKcVbCiqaNdua7eWlGb
 NGPeEMf+mCVnEz0zobdeYe8nzsKgki7BPDGbBR/hurovDsQSCwag7G+nuOM/G17yne6mKayaVfa
 8fpx5NWgQfZGFaqTuWJVJeruhv6P370Rme8tVIb1d/QgEUv99N0JiZqOFTmZtT1pSKvn+tigY2Z
 kLGHC6xW0/ZqexuNCujKcptcR7pDcBFxuzCiwufFjTyMFbWcJ9E991WA8GLKRBfArtcwACYxqPF
 /3Hp23E/jm/b0xsWKTVMuxFSrh0o4yoKZ3f99WAHWSpEWGaGADCLg5+hm7wiA23Lz6S3PQaywP5
 22cXVmRAjSkOes+0ADM3ViW69HlVCDoZ/FcN8o8xy0z4MyAIyZ5Mgn7YA86ZGu/dgr0BTgymzbb
 dfC003omx/U1bsB+mODbyrgVy9C/GE3PVFXOuafmfkb9undGYLEc/7NMzciiCwrRSRafYYoeA0R S+lSfuRP3SDJgEw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Clock drivers. The bindings were kept on separate branch, just in case, but
eventually they were not shared outside.

Best regards,
Krzysztof


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.17

for you to fetch changes up to 2d539f31ab0eb3eb3bd9491b7dcd52dec7967e15:

  clk: samsung: exynosautov920: add block hsi2 clock support (2025-06-12 17:28:11 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.17

1. Fixes for clock topology on Google GS101.
2. Add HSI2 controller on ExynosAutov920.
3. Minor comment fix for Exynos850.

----------------------------------------------------------------
André Draszik (3):
      clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
      clk: samsung: gs101: fix alternate mout_hsi0_usb20_ref parent clock
      clk: samsung: exynos850: fix a comment

Krzysztof Kozlowski (1):
      Merge branch 'for-v6.17/clk-dt-bindings-headers' into next/clk

Raghav Sharma (3):
      dt-bindings: clock: exynosautov920: sort clock definitions
      dt-bindings: clock: exynosautov920: add hsi2 clock definitions
      clk: samsung: exynosautov920: add block hsi2 clock support

 .../clock/samsung,exynosautov920-clock.yaml        | 37 +++++++++--
 drivers/clk/samsung/clk-exynos850.c                |  2 +-
 drivers/clk/samsung/clk-exynosautov920.c           | 72 ++++++++++++++++++++++
 drivers/clk/samsung/clk-gs101.c                    |  4 +-
 include/dt-bindings/clock/samsung,exynosautov920.h |  9 +++
 5 files changed, 115 insertions(+), 9 deletions(-)

