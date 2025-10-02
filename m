Return-Path: <linux-kernel+bounces-840128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B0BB3A22
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AB6192572B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECF30AD0A;
	Thu,  2 Oct 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrIHaL4w"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2E309F1A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401182; cv=none; b=mqHuOljHjcScexbf/V45ND5QlsL4u0W7Fj+iqMNEwgr/2A/GLzkBSIdZb3nHZO/Gw2HtSK1CM0pzv8SCPJiMG/7LP0rf4H8imHH4D5FykWkhdhTXgoKZaYopYC7+mLPSVAbk7G6bo11RjrgVypUpoV6qTj6UeJ8FtxLbY81DDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401182; c=relaxed/simple;
	bh=tPprOdfHzL3a17EiavBR2uOFxXJwStXq+kTCl82G4Ug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ES+VYhic5dAPkYc8NxkINg66Hny2J/rrSIaZOHkHRdnrAGU4HkPmnTHgWgu8jgpOK/x1R7uHHyKK0N/l1MwsloWUHNipT4enXSMeQNN3/ggR0sly1mK6LGtcOpcetlmaGFXjJ0F8JamyqU9JnIKTbSMpdhgszcnhF88sUX+N/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrIHaL4w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b457d93c155so164499366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759401179; x=1760005979; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7P+sGtXRhq0usSaYxPiIMynq3nyv26DuyfZTuxL8VWI=;
        b=VrIHaL4wk1CAhF9XIp8ydHhKWtvV2AsENwBTVmhU+gR60mTxm1asrudu7AxE56OqmW
         ZDASuNMb+nIKpyI8jwBP4/Je6NnYvj37taY8FqHSHnyLupVwCVYPM93uhY9qzmmnfjW8
         wrNAI4/D1bMeUoq6xI0I2MqBp57F2XHz0pTd9CWVbQbpTNTFpz5/5xcyGRjhz9wFK1Xr
         oFG97ePotM64Yh6G2h4IqF4HLe9ERTkeU+6rsePJOLiyYF5rXcC5KrBa/SVFL/akVzVZ
         r8E6Rwap8li7ZUO7njx6YowzjblFX317hhZKCe5UWlUg0sbqVt3kpcr6MrVyHCLZORi5
         xY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759401179; x=1760005979;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7P+sGtXRhq0usSaYxPiIMynq3nyv26DuyfZTuxL8VWI=;
        b=ZV/BNQZLmMLps+iN4La8iZMe3P1uNZbo7oZPw4mlQk/hRilAFZm8VLs9QdqNucNYpj
         NUXnhpWAD2PU0tqFxcHR9Gp2Czek4yMxQQJ+ww1a0/JVGlOf0AsGkZuJxpmHqGk5x96x
         JRN3EMtilgDwaqCjTE4ok2ICRc2b9fSXXMB4uzSSDPsiTStmFNNprrypjS/DzHajgKVc
         0rh6p9xNoxau6WKPKFTccQQLUXPXv9MXcccJRdUVGRPP15pneOUKhjUml4H2rHiZ7oV/
         luZ/g1IY9+4DXJyN4dOC+nGf74Gvfj5K441jxjYZi6jBfEL6qf2LT5lsfsflrtVo2nxV
         e0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXH5xGcR7J0Hgr5gLO7cS8GK1TsR0Bw2TzxYr759MKNq3suYS99LPTdJXkXI7L+HRQyahmFz7Bs3/WqVeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUPZZpd9qN4Yofsvacim/DzTVna223f5tLlAqV9+XayGbEBs/
	TEBlzoSD2ds3jJxfF6EavvmSbI9zAluRWcyOQM43eAZc+u6aqRrj2fDQ5UJkpH5Ze08=
X-Gm-Gg: ASbGncvn0Lp3f2XYAY3nm8qF3h1lUegAjRqAvTeP0G+Ep4cQg7O2WMjvibTg8YuEkcI
	3SL2dK/jJLeDNmApjucaWaLnaae8r1TA7/gb7wf3h5NXN/p0riXjfn2EpPfjbu6ONrjIUHIr7AK
	0N/DfMdGD+x59evneoKtcKFoZi0js1NBJNmG8ngvxvo2NP9sBb4tKBcI95z9/wH4nfXkbtXYD7T
	VUxHXPd2dNzX642+52Pjo2sUdjLGT2ZyJzyB5C/3/0kKcc7PutQ4MlbBxShDRQQkD0/w8OQUFPP
	NDbHFvJ00OSZlnYPW3jstyx+ifs5PK8OiMMqK9h7V4Mx1VRFZ4s351R5/wK1KMC9iIScetGXybS
	RwLyxCTmiGl7w9vXP58dkISpYnWV+pMg9qxFXewHgrgrTB9f56myNvw41+h3ep0olUH7+bjmTWn
	FKoBkLhh+2uXMQcBg3aU6+LSc3MW/LMM4zcJBCZm6A
X-Google-Smtp-Source: AGHT+IE55OaBBhFZS/spDOtLmb4PerdgYY5yS2Ckb/IGy29/YmfIffHAN0iEIq0aghfbW8MKNL/xbg==
X-Received: by 2002:a17:907:3d94:b0:b3f:f66b:268a with SMTP id a640c23a62f3a-b46e30e957amr846825566b.19.1759401179405;
        Thu, 02 Oct 2025 03:32:59 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4871167172sm170262566b.65.2025.10.02.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:32:59 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] soc: samsung: exynos-pmu: gs101: avoid SError for
 inaccessible registers
Date: Thu, 02 Oct 2025 11:32:56 +0100
Message-Id: <20251002-gs101-pmu-regmap-tables-v1-0-1f96f0920eb3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANhU3mgC/x2MSQqAMAwAvyI5G2grrl8RD1VjDbiURkUQ/27xM
 jCHmQeEApNAkzwQ6GLhfYui0wSG2W6OkMfoYJTJtVIanehIv54YyK3W42H7hQSr0hR2qKcqzwh
 i7QNNfP/ntnvfD35ip1hpAAAA
X-Change-ID: 20251001-gs101-pmu-regmap-tables-8726ac9f853e
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Accessing non-existent PMU registers causes an SError, halting the
system and rendering it unuseable.

For gs101, we can avoid that by creating the underlying PMU regmap with
the read- and writable register ranges in place, because on gs101 this
driver controls creation of the regmap.

This series updates the Exynos PMU driver and gs101 in particular to do
just that. For gs101 this is easy, as the exynos-pmu driver creates a
regmap and we can update the regmap config to pass in the registers.
For other SoCs it's not as straight forward, as syscon_node_to_regmap()
is used which doesn't allow passing a custom regmap config - those SoCs
are out of scope for this series.

With this in place, invalid registers (by drivers, or even plain
debugfs), are now simply skipped by regmap, leaving the system useable
in that case.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      soc: samsung: exynos-pmu: allow specifying read & write access tables for secure regmap
      soc: samsung: exynos-pmu: move some gs101 related code into new file
      soc: samsung: gs101-pmu: implement access tables for read and write

 MAINTAINERS                                 |   1 +
 drivers/soc/samsung/Makefile                |   3 +-
 drivers/soc/samsung/exynos-pmu.c            | 136 +--------
 drivers/soc/samsung/exynos-pmu.h            |  11 +
 drivers/soc/samsung/gs101-pmu.c             | 445 ++++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h | 343 ++++++++++++++++++++-
 6 files changed, 797 insertions(+), 142 deletions(-)
---
base-commit: 5eb97efbe6a375944984e7fb69bb632d2879c841
change-id: 20251001-gs101-pmu-regmap-tables-8726ac9f853e

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


