Return-Path: <linux-kernel+bounces-800911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443BB43D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92E01C85450
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA4F3054D5;
	Thu,  4 Sep 2025 13:47:19 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1D2FF15B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993638; cv=none; b=ZMr2q2EP5rSXoPwfPGDIIRQeztE4tMG6WmgKzbnT78XHGmD6FWZBtKYCuWFF3b49ohV1VjecAjm6LkvXnxQPgwdDQIlbRuDCm9l0D8wonBpZquwtJCFrLB3s6P3eLRZUbly/9BpAtuO7aLTOP9f9MYXepA+wAyWbF+Lss9VS1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993638; c=relaxed/simple;
	bh=yhmNO8kAwgjI7F4lopKN7bYdjuqkraCH3NplpwR/hXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gXss1qaqwMv+TDVILINOO50eifFnySwxeK+BZ+iTSAJfw1yoN+9RsiHTQorU+DJ93OlNTPITmUtcDpdc0LRF3XxQR1BLGw4eVBOWUbNscM9WAPsBLRCwqLrxqA2wO9oJlqp1wMY/XWYwSgoCnY5n1pdeHGTq4krZ5MSpKuQznxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 240022050;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 04 Sep 2025 13:46:58 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Date: Thu,  4 Sep 2025 09:46:49 -0400
Message-Id: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=wdouglass@carnegierobotics.com; h=from:subject:message-id; bh=yhmNO8kAwgjI7F4lopKN7bYdjuqkraCH3NplpwR/hXw=; b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBouZU510BBX/Sa4rcZBYXRQsanPm9UONywRBRn7 qPnGnUJ8cWJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLmVOQAKCRDsC7i5TzYe FCGOB/9TDfWdUptK9pC92C9xZebJZ1YvI3PwBR4ztLUAQUhN43u7AS/SXTnSTGcfV9JCJzSsHx1 mLJxx1yKbTk60yaEl853MV/F7LXXNe+pBLhixhytQ/7duPOhc1c2CcMCgUi7/Hk3HQ6/eO7Sy8g 70JLgHGNRvm9BoXUGqMOuUG9WHEMn2wiXfKn8KM9uqDx1A8+TqgM/3CA1KFCBH84D5Y8+aXwfYF CXV2en2llhwAJWseWtXRphTvr8FPyetGtXIffvfYSnGuzQm+wVs7L3mSDH7Ofn5MhwMRhZGlxxD lx1ZKAZSXq3jjTrqI1VzaAOXE2qTXLgfQ02C9xPUfxMBrRgO
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp; fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
Content-Transfer-Encoding: 8bit

I wrote this driver to read settings and state from the nxp pf530x
regulator. Please consider it for inclusion, any criticism is welcome.

This revision (v5) adds a proper compatibility designation between devices
in the family, and fixes the devicetree schema to pass the dt_binding_check

Thanks,
Woodrow Douglass

--
2.39.5

---
Changes in v5:
- Fixed compatibility match to properly fall back to pf5300
- Reordered patches so that devicetree schema comes before the driver itself
- Modified nxp,pf5300 schema to pass `make dt_binding_check`
- Link to v4: https://lore.kernel.org/r/20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com

Changes in v4:
- Added REGULATOR_ERROR_OVER_TEMP_WARN to pf530x_get_error_flags
- Added EMREV to the info print
- Link to v3: https://lore.kernel.org/r/20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com

Changes in v3:
- Replaced REGCACHE_RBTREE with REGCACHE_MAPLE
- Replaced pf530x_is_enabled function with regulator_is_enabled_regmap
- Added status bits from INT_SENSE1 to pf530x_get_status function
- Added extra context to info print upon chip identification
- Reworked devtree to not require nested "regulators" subnode
- Some minor reformatting of comment style and long lines
- Link to v2: https://lore.kernel.org/r/20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com

---
Woodrow Douglass (2):
      regulator: pf530x: dt-bindings: nxp,pf530x-regulator
      regulator: pf530x: Add a driver for the NXP PF5300 Regulator

 .../devicetree/bindings/regulator/nxp,pf5300.yaml  |  51 +++
 MAINTAINERS                                        |   6 +
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf530x-regulator.c               | 378 +++++++++++++++++++++
 5 files changed, 448 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pf530x-6db7b921120c

Best regards,
-- 
Woodrow Douglass <wdouglass@carnegierobotics.com>


