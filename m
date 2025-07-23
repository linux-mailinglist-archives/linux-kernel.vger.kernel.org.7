Return-Path: <linux-kernel+bounces-742151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93DB0EE04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61356C3A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDB283FF1;
	Wed, 23 Jul 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFMOx8H1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22588279DC2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261506; cv=none; b=NFtsB8lTLlu5qjXrDX2ZYPz2pl63b1R6zq7xnR4DIB/mV7lIIr7kvfyMIV6ZmFgpHY26eWoyccJlyjBEo4hNPfb4dPokU0bk8zcTD4q66RpOc9ZslUOTo9WS5uJsj/2rheQN5OFEKSZ4QvT0Pz/MXjumePcw7CnHhv2DnyHA2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261506; c=relaxed/simple;
	bh=jKxS63Re37hcFm6L5FR0wOlWb0i7sX+Y/k5+Rp76jT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeO9lgFrDHCaulJVyLLbb3rZLijhc/Qy3ONemOom00gj56gnZ30X3P9+r8KNR343sapSZDLWmh29I25zoIJCZhCpMgj89INvFmwRTVtzoj6S/VB+iFUB/iXZzhN3WyBFcYnoNeRUN7niUZ8Jq6gg/Fa6Q7NjYigyoXLvQRIObjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UFMOx8H1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0b98ccc57so110365866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753261502; x=1753866302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoZCnvfP/rwehZqm543p76Ydsjj+4/YJqR0zDLYGaAE=;
        b=UFMOx8H19Rsg+CgmUAAmFzOKd2j9tmv6ECE2xMLR585XbhVoXzIBeQhOkUuXL1laB8
         cVbHq3hSkVT+Vusvbko4fH4427/vMQOZg4MElhG/yZP3TkKEym5CJXZNZ9iRQpwookT4
         EuvCUjwvKKZJrOw8ibTBt0RyKZ35s2aMl/Fvr2Rh63tRymOgdhg5ywaOhICcfhPk18Jc
         LMCEGgNYb4+zds+UJHdjiuJoEdO1un0vQbCGkEMgjQFrAqQPIIGoTSl5xX4CmNBwc5OQ
         pYnTji++M5eHtBFsfTgFixngOp50NRZLJBiEkwhCua1GBwHUUaoTSqn8V/RUCyw6/IiZ
         NFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261502; x=1753866302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoZCnvfP/rwehZqm543p76Ydsjj+4/YJqR0zDLYGaAE=;
        b=HJvFSlbtBS6LlVwEOK9ZYY44Pept1dB7XiCqCN/dSigCXCE1bVwkKGK27hqbIha4pe
         QEicIxLH9y3GRNVfcKIl/OCzfhEsuYfYDiWfC8rIeulcs1oRXvrOE0vTRa61kxTj11r4
         o0hvaYx3fX6va+z4FvSikColSC3qdKaTUiFCf5E96P2T7kboTNDHgjmkkpSOd/X8zb+7
         E4QJztH0UDKJKDMgOyMKP1sFeenYYm/yTRsEmv/FYAeMFfJZlMUfTbgCpuVxQQC8524n
         dQrT5d55Xndoh4AwaygWxNpRJnCtMPksp4wv+bWotPy/DduHld/hYpPSQQMX/CgVezyg
         mgiA==
X-Forwarded-Encrypted: i=1; AJvYcCV/DuGYj1Qe0eDeLRX27L/3lqLo3laGywB6/n19kN3QkMBoofmSzsWYhGsQDNbx1l3447MJm1nfZWRnbyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRt+QfvFKcwyN23R3zSkynekJ7xWupUwxyfDxlx+l8qgzARZPe
	9KsSnpQwaMVwCqOplWb5xA9d2SinkIg3gEtPPk+rj8k2h7uCqMYvu7EtOpnkRbtrcTXz8aAoqrU
	VnwRA
X-Gm-Gg: ASbGncut23pZTBL2EHyr7H7GG+SjqG2JvDvSzIlXOtpHAP+9UoobyTDCS9d40tZUEXm
	hbAiqTK/UTyHYPlHhqiszBOrNY/lN82Ujm6LrsgbGj237Z1QUm9pD8huD3XS2GrbQmFfyxRlTws
	VyJZoAS5e4XB/SF/i4Yzo0HKgKeVFTqpkbe/uyMEGRVJ0EsD3An/0tNrXU/NhHB9ODmi8wO3pC8
	i2bW4pB9fJ0HbySpgRfFfvB4uh+j9f9+2wLKjVfyjvU9hQ91U+LYl4on5PnhK9BzwSeehE3v9Ch
	TyYfZ8hq69CKiVe2eLjR0D2HuM5S0NQZvqLO4w1ED5XJNG4PxrUtvUSzM/o0DfhIKNW/amKywJy
	3eC4Qjo/y2Q5NAcH/OmFTymvnj3caJAsH
X-Google-Smtp-Source: AGHT+IEfzsllmY1ddx+Lz3lhSzSUYagxITt83zhZt/m63TVAuXGg4evDnAWl67hB8SYpI35/gQ1tAw==
X-Received: by 2002:a17:907:8688:b0:ae3:617a:c52 with SMTP id a640c23a62f3a-af2f64c62aamr72965566b.2.1753261502178;
        Wed, 23 Jul 2025 02:05:02 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af22f6fa6afsm208165466b.120.2025.07.23.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:05:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] samsung: drivers for v6.17
Date: Wed, 23 Jul 2025 11:04:55 +0200
Message-ID: <20250723090455.25295-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=jKxS63Re37hcFm6L5FR0wOlWb0i7sX+Y/k5+Rp76jT4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBogKW3mDzwNTJovQ3V2taqJr+0T0EUFr4aTJQrU
 U2eCAEqgvCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaICltwAKCRDBN2bmhouD
 1yR5D/wLSF3mWxeCh6hr0nA8CzfZto/VRm7x52o6glrfAIZHQ/zaOZ1570ojQRpZeJP5mZm4qGY
 eCpgfc3Cl1f3osmJKLI+ojFPlK2gH/ipqWahqcUL3RsUoLEivfyXNMYgVXTlWkTORjB418lS8G4
 fC+/aTu3X6UgYmwLBP8r10DUaCbsZDfBDbr0mNCU1VMLKphSgTRHrJ7Fg8HVk8mXucjIsd0J/5t
 Wl9bVoa0hc/QJMAZO9hG2pK0KaAuIHgs/9GSO9HpcyHnlMKbMOvg09YptLZkXDUDs2zTlRF5wnB
 NQXTtkM/pqAfz3z9cWqPeRK4OkEILvtOIFeYAIO+qd8n3Pa3B7DyBhlf2r/xLCh6FOKtNtHp1dX
 tk1JND/+6NxXlw4Zt9WkiAj6vA4vu7Do4i1DEdR2dlB/C28jltww4CsTGu48nkO66/6iD1vCAA3
 ZMeQciN0yfxEl7fRNBiHs5JSXdSW8axGHEtdSU8PkD71n0nSR0Fwxf4RY1JSEk7vFdeFJlUUuio
 z03+FSDx3pT2g/B3sbq/trspGQa3YpomiGIBGJvvId9fUwkUa4CHy5DxEbDObIScg4zIs3oZ8W8
 GikDwiW3shZzRPhee2lB943Ur5FpLQDYG1LGPmjsUY7oMlNhTaPs2mEsEmIWjvC7ivChoKGwVrB R22rNCovyB27l2A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi,

Late pull with minor things.

Best regards,
Krzysztof


The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.17

for you to fetch changes up to 687d974a218a719f7e729bef9c498ec36f18115e:

  dt-bindings: soc: samsung: exynos-sysreg: add hsi2 for ExynosAutov920 (2025-07-16 10:41:42 +0200)

----------------------------------------------------------------
Samsung SoC drivers for v6.17

1. Google GS101: Minor improvement PMU binding.
2. ExynosAutov920: Add HSI2 system registers binding.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: soc: samsung: exynos-pmu: Constrain google,pmu-intr-gen-syscon

Sowon Na (1):
      dt-bindings: soc: samsung: exynos-sysreg: add hsi2 for ExynosAutov920

 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml          | 3 +++
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml         | 1 +
 2 files changed, 4 insertions(+)

