Return-Path: <linux-kernel+bounces-877025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F6C1D018
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E81400CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66093596F3;
	Wed, 29 Oct 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV8reXkb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC330CD81
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766151; cv=none; b=QpzjswX1rpOagI30xUADElhSWuQxumDVuoJfrB2/pMQPC5xbCJDX2vPKRsUEm4+jCRkjL6E7nmu4wyN59WakMsfPJe0D532WtT/iqfw1dUf0+y/vx9IqfeBRgAp9/ztVNKcrXJb19Gy6wcTaqWzS1GrdMd/hfGuTppDoMrGuXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766151; c=relaxed/simple;
	bh=2wqxvv1LyQFzj8yk+I9X6hMiGmB+zBuKRmM0nZOP2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEc9qJF+CkYyl8viob/ICfasXN4HrCdufkRMHp+l8MGh3Sr4FoMao80KE3z+N5eowTemW2TMhUUQbH5arP4c9DmkX2VJ0JrVlqQL8cug6dkE1nT41aqlWWZBKsrfVgYJX2sBUWN8mOhP1oWcl6P/1b3uzXXZ99fOQT5gcdnyBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV8reXkb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4736e043f9so43830566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761766148; x=1762370948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKKJA6fRomltCp481BiLWPXK7LT4XBfRN+VIaJM7fMU=;
        b=HV8reXkbUK1Ebe1t+6oHtOQHE5GtRzTimSUH0QMURm46xDZQQo+HVUn2nQqAG84GhY
         NI7Qg8xshfo0kHde4UPuQcQvPoX+eo/humrQvd1TrN3uxHCYpKOhmb+5PNJV2AfdQ4H5
         UPzBhYCXUqezxy0tRNN52in992rjPVnAUCFtiXHUK30YaGUZ5R11exm1l+/F/xhlLsRh
         j2G2ZPvkKyHXxWhq7g4IjkpZVitV6IJ7uxXyTfzifgZzIh079Wf4LCdIiA8uVKzaur4Z
         oQLdATU1PL96ijVE1/ofbPGNRvT0PMdv7WvNTu4Jgoz5ZZBOfHCka8FkiGG1ajBCCA9O
         yG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766148; x=1762370948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKKJA6fRomltCp481BiLWPXK7LT4XBfRN+VIaJM7fMU=;
        b=UZSSVAGtdE833voejwGuARC5p/HHUSwh4C0fElnrJzhM6BiYIiBqkgoPcDp4SibmNq
         DFFhafcPEev5m6dzpSNg4IZeNUxpFE5NqIBhFpkSEoLuSRJq38BdxDaqOZ33+4ON35/m
         SlusbQI/sTUKFFeyfptwsD28zrKvr2sGO5bSE0V7E3W46eP+5mV6DeJYqkGSVI6fuoML
         1eq6aRRhzZUL16wGm1iFFwqdbxpUQfUUA0PWOchyd3Ojv0YGndvaDJlgxend/0dQHRLe
         Q1e8skkYp2uOn9hNb8GFScV2Dcquq2YrqDxNsWdfOToFv3nLhcahpE1EyEk52OpvDKJI
         UMoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7g0AJ10cK7bOQbsm/FoMhnKDqNO65ddp1JWlVxlp8bj1/q5sSq4Q62X8tt0n7oNXaZBEcpmKr+0f8/o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifdUtGHST2sQlxU3CO1vvGKKqNY3BEbQoWU9dDWFPPDYfNQMq
	ss6eu7Sef6ttkLLWhCgN4AglbE1tEDlOn5kW3ETwXZ1zHHOsMvQ3G4YK
X-Gm-Gg: ASbGncuAhXoNzn4XC34AMcAGS8Jfy6DQLOMuZmtiCZD1cckw69g4DvXFYOXv5fjPjcW
	NdmtHLg06ghsnv988/G9hEbookcZsgJ6Iav1AmR/G1A3dQOF0d/56BoAe5P2V1PhiW1gEvemRpY
	7MAZrLnef3M5j3nFQuEwyVcIIqN/9bR1/z6HzgxJHXrdC+YTu24lSLTZcHZRJBQCmXfcZ4KfyJ2
	ZdcI8WFS2Q1K+m176Z73HfLew5jY/EaBUFt7seSjfVoRazI0vUF/SQvxoALY4xvUAL1Xem51KjQ
	iNkPdaAmV8+UB6ME8Z6LMVbhNTMfYyiouzxMg9Qt5gTUIb0UZPvsP9cqanQeTdmDW3+Qy++m6XH
	r0WJXTJvqKJkw0h3DNe312ZdAxeHPHXDCG+F+8mdkhUH5s26/2+kIitOC7VxIUdVVvyECarVd/C
	kF3vF3JvfPG62oYY1Ymv1D5ScRJlZXCm5x5HrxNKtqJFmDjrsU2uVbqdRJYeH8bw==
X-Google-Smtp-Source: AGHT+IEDxtG1HkFG0ON1dBWQF24t0hiWuuyPwYA2hBUikGtOaNbTeVCqCxQo2KWiYZfh50Es8IqNeQ==
X-Received: by 2002:a17:907:9721:b0:b3f:f207:b755 with SMTP id a640c23a62f3a-b7053b2a721mr28389066b.6.1761766148261;
        Wed, 29 Oct 2025 12:29:08 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm1496673266b.75.2025.10.29.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:29:07 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/4] arm64: dts: freescale: imx93-var-som: Align DTS with hardware revision
Date: Wed, 29 Oct 2025 20:28:45 +0100
Message-ID: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates the device tree for the VAR-SOM-MX93 to align it
with the latest hardware revision of the module.

The updates include the addition of missing peripherals and devices present
on the current SOM version, namely:
 - WiFi and Bluetooth module (NXP IW611/IW612)
 - PMIC (Dual NXP PCA9541)
 - Audio codec (NXP WM8904)
 - Resistive touch controller (TI ADS7846)

These changes ensure the DTS reflects the real hardware configuration and
enable full support for the mentioned peripherals.

Stefano Radaelli (4):
  arm64: dts: freescale: imx93-var-som: Add WiFi and Bluetooth support
  arm64: dts: freescale: imx93-var-som: Add PMIC support
  arm64: dts: freescale: imx93-var-som: Add support for WM8904 audio
    codec
  arm64: dts: freescale: imx93-var-som: Add support for ADS7846
    touchscreen

 .../boot/dts/freescale/imx93-var-som.dtsi     | 332 +++++++++++++++++-
 1 file changed, 331 insertions(+), 1 deletion(-)


base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
prerequisite-patch-id: bfa4df6e3787b415218cd441317fb838824e06c3
-- 
2.43.0


