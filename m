Return-Path: <linux-kernel+bounces-814170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF27B55030
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870DE1893397
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A93093D3;
	Fri, 12 Sep 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dfdmcz0E"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CE21348
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685642; cv=none; b=WxhvegPAnheKOR20JtPP1hj9P5C3ucNaHyXwMdUQ3YVky3TRdhOv5Z5PsrzvVXG5D/9kG/77goENy+9EcJBHbwxh/s91Be1nCInaE2Ch9nm9GqIlOV63fMsZHYm2r9yT2sHiPMLdDwRaYp49OlhSjmPA2TPZlh1M/cl4agnsZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685642; c=relaxed/simple;
	bh=GsGVYveF6LPGpRIxaUGMCL0gNCUUve1qoJV1mW61tm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKQ8FYq2gG9cgcWuq4s6RPjY6WUWD63JqeBDi8yqxZu8iTy25cl7knQwM5+cQe+kONaevuPKpb9gwm1rvF5tvIjF/SKLFKmzTnul8hYEVSGR+6IcZxRLQ+r4gcnFlUPZPK+jZAWaCmH15PtYZbyz3LpdLPy6JZlEF3lpIgcwCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dfdmcz0E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e35d87f961so244227f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757685639; x=1758290439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLdSOVhorae1sJQKa+rEDUE+qmZFZt4ec4eMHpDkzvg=;
        b=Dfdmcz0Ei6mxxg0xq9C95ThHjxfyfDoB+zaW+q8geCh9Ph3r5QKNyneOKgyY329gXy
         uRsDopox4s49ePCoSSqCDOGsPl4npfUg6/sQbfjIVdbMkZyghxDiuBapObHzvRMcxago
         q498f5FTRd33nuxK9o8byA1HULkzAtTFuajsxx/PRVOXMeo9XtWypOY93aG9+YYcQesZ
         /aUrvanHEu37wf4aEZ4Hbd1jA5NWNcmmvyBoNCKMeNAYzFv05DLbxe9nIkIpfqH0z6VI
         WQYT93r9xSmBzTYxpLQ/ZHgrwNgf5KATToRdS6wD2sFBkN2hXIfU5+UXzut/8LVp+Bpe
         oB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685639; x=1758290439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLdSOVhorae1sJQKa+rEDUE+qmZFZt4ec4eMHpDkzvg=;
        b=KqEn9KBGp13deH7juewGqfSeGTwaJ4jGwrkxUUPALmkDZbMXZKMhwUfYd/rjDCVA6J
         66744IlvDfoHy15on3ftM+rnTolOLt1gSEpEhujtferqpm0pE/H1CToBRCffUaE9a7/t
         4KLt3zwOOt3LCzhHRywkY5+H7pA68cVZRSifx0lXagxHx3Riseom5uP18/F19k6/lonW
         JADRsAJjLsOXrHNoiVStDmkYJI2y188L0or8FYAXylhfVmRKT6GAfPDbVonVbaV31HJD
         o9kZMowSSnHhRKnCovN6TPFeolk5XZ/OW7ahKwuNK3lMCCoA9gvp3bajnRQ0tEC27vTV
         /PJA==
X-Forwarded-Encrypted: i=1; AJvYcCXefEz18IeoRHg5fKIDiwBgmNN6bbH3N+koA60yteK0raI+xY6Q+vfYRomxg7mI/w/qOyZwslaYW+foPUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfngLkgZNTxCqHBaxxAQ7L3bb30JkqRP8oz20PgXrJZXctrlJW
	P36erh6r/QCahZuRTou+BZ6/UGfqroqVk/k08fX5q6Dc0mtzP8fEWJVMTrMfsXTmAcc=
X-Gm-Gg: ASbGncub8JMeSYCKtgyhGc2NZXMU0RPhPOjbxrlTqWFZMzGQ+NiXVvGyL1ZJANmTtU3
	z7dLnRUjue7oXh43067LZ49QaguwxFPKQXyirUA/EmSyFmgRjBdNayupfdkte2zAber6dX+SdmJ
	i5WNY9cCPkDb6uFVVMPSynmWbuIFIyHfYmcoXIJvy/fnktnnh+s6xZyQYq7QHSjn2d7ZRdjYS1z
	birWq4zNkTn7KBPmEf7IEZTBYr4qvFsOHLv28tZKHJ6zkPVkpnJlv9Cj+nf1Z/XLUafddViRKu1
	5v7N3OLD4c6+tpcVRJrx+a1FjIZMZqScB2+1/EfK/SIp1dXpZE/9eEXAJuE0Tbtd6cwXtqpmBxl
	4n+QMO32l5CkMmkqGfGhGjK1NkyusxObrl4tlxdiYtpIN
X-Google-Smtp-Source: AGHT+IFAycuTssCo8AceTCLsclX+Nq0Z2MUF+Y17LO1+yDSCDwG3yDo6trmj7jip5dZZd6T7/JV4Kw==
X-Received: by 2002:a05:6000:186a:b0:3e7:52fe:80af with SMTP id ffacd0b85a97d-3e765a25841mr1345218f8f.11.1757685638834;
        Fri, 12 Sep 2025 07:00:38 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372bbd3sm62888045e9.10.2025.09.12.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:00:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.18
Date: Fri, 12 Sep 2025 16:00:31 +0200
Message-ID: <20250912140030.204650-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=GsGVYveF6LPGpRIxaUGMCL0gNCUUve1qoJV1mW61tm0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoxCd+uVI7zoylp+k/nnK1KCwoYHYoa5H8PpYUe
 DenY1MHmA+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMQnfgAKCRDBN2bmhouD
 1ycQD/9IS1TJN68/pAUqCF91r8kwaZba8h99B/tU7FDZ/OXR7Hw2C5HME2PznnQkhlPBnRlWU+A
 fOzL3H3sjAsILpSsdkLIDVpJkSnAi9UK5oj3L7sG4vRLY0aW77g+KNxvquI25M4qVbPlEQdgQTa
 r6OL+zllkIOSSr+NPtXHitLhShElSvu1shU9UN0fqqH6HwbGtEHD2Q3qn5g6pHMsV0JhnfigjxN
 baW9NMWLjOIecYaVfVqn/BQ7hIlRFo2K21RnE295mQKMR8il4/6rON2Q/+SsF+sgQTmg4Bpz8mT
 RWbvVIJUWV1uT3lPyiFg82svh+uqOOmdfYPjERpjYYnid+Lr4F5ESxWQLJnkWiC4O5pssdksfzd
 4B6HRtG61X9caAeSbiuNLcGPA3BCvHv5NT9gANRfirPTXyErUDFdI0ZWh+P3BC5FmQX7AdJlf77
 3lK7jrH2k4caIn0P2KwnqbIdvWP7l6UptoBV4+r3cqG/m629HbRB3Yb+5QR3DVf5pICCaLzOUIq
 MI1xJgPcDH4QNngfNnFRmiIDreK+KA+AyAarBowpjbd2r1LGwXRb2dvFBd8vG07bO0UbkYbgJSs
 RKz+t/WHuw7xgC9DSJtH+bkpSIEKFDnlzOYFgYcgiCx8oO12cMis1dRcxE5YrLCQphrNmX1XYIQ 4qezOqZdenAfYPA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.18

for you to fetch changes up to 3804cef4c59742cf695e7b41a9aabe8d5bb25ca2:

  memory: tegra210: Use bindings for client ids (2025-09-10 11:40:44 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.18

1. STM32 OMM: Fix ineffective/missing setting of the req2ack in the
   device based on DT property, if the value is different than 0.

2. Samsung Exynos SROM: Fix IO map resource leak if
   of_platform_populate() in probe() failed.

3. Broadcom brcmstb: Document existing, older devices in Devicetree
   bindings.

4. Tegra 210 EMC: Document OPP table for interconnects (driver usage
   will come later) and define memory client IDs as bindings, because
   these are shared between DTS and driver.

----------------------------------------------------------------
Aaron Kling (3):
      dt-bindings: memory: tegra210: emc: Document OPP table and interconnect
      dt-bindings: memory: tegra210: Add memory client IDs
      memory: tegra210: Use bindings for client ids

Florian Fainelli (1):
      dt-bindings: memory: Update brcmstb-memc-ddr binding with older chips

Patrice Chotard (1):
      memory: stm32_omm: Fix req2ack update test

Zhen Ni (1):
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |   4 +
 .../memory-controllers/nvidia,tegra210-emc.yaml    |  11 ++
 drivers/memory/samsung/exynos-srom.c               |  10 +-
 drivers/memory/stm32_omm.c                         |   2 +-
 drivers/memory/tegra/tegra210.c                    | 146 ++++++++++-----------
 include/dt-bindings/memory/tegra210-mc.h           |  74 +++++++++++
 6 files changed, 167 insertions(+), 80 deletions(-)

