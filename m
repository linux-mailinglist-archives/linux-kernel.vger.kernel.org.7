Return-Path: <linux-kernel+bounces-862727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C6BF5FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B88A7353A07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127E2F3C10;
	Tue, 21 Oct 2025 11:20:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04002BEC4A;
	Tue, 21 Oct 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045626; cv=none; b=oMjaSy2QsANWdGTDd+1pjq964G+xixMwvN1czDVT4xZzX3XniHyX98xnEGfkwJ1y8ArzQIXQUOM4xTDfEmRmADtR+w46VFYiHBLHHfE9gr/R0dc55WLAIEAl/T1wfQB8zhpbEQJmrWRqfMJelZG0zVTxeHPV8n9puD3YST218V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045626; c=relaxed/simple;
	bh=hPWs8ptQ1QGyoYP0WVkAaMz4f9u8U+CuIyDcFo1CHRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+3ZCbkUf/vjH4Mt7LKlMBWS16RM1Lb685ix4LA1DSccMuzAE7Mv44CFP5FRg87hWw43BkduoSWyDHLnQNyrYNR8psumYYade3b4ecSIvL+hWCgQft4D1+ppZaglUjfx3ZarJwu3QY1eFfkF6aCYjQDlNdh7dQo6EdzIhfTUTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B691063;
	Tue, 21 Oct 2025 04:20:15 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.33.8.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C6B3F63F;
	Tue, 21 Oct 2025 04:20:21 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] regulator: Add X-Powers AXP318W PMIC support
Date: Tue, 21 Oct 2025 12:20:09 +0100
Message-Id: <20251021112013.2710903-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the X-Powers AXP318W PMIC, which is
used recently on new boards with Allwinner SoCs (the A733).
Compared to the RFC post, this now has been tested on real hardware,
with the full regulator description for the Radxa Cubie A7A board.
This also adds the switched outputs (swout1/swout2), and fixes the DCDC
input supplies, which are combined in certain ways.
Rob, I dropped your tag on the binding tag, since there were quite some
changes.

The PMIC features 9 DCDC buck converters and 28 LDOs, plus the usual ADC,
interrupts, and power key components.
A datasheet can be found linked in this Wiki table:
https://linux-sunxi.org/AXP_PMICs

Patch 1 adds the compatible string to the binding document, and adds
the additional input supply properties.
Patch 2 is the MFD part, describing the regmap and all the interrupts.
So far we support the regulator and power key devices, the ADC and
other pieces will follow later.
Patch 3 adds the voltage regulator rails, this part is crucial to enable
any board using this PMIC, as we depend on those rails even for basic
devices.

Based on v6.18-rc1.

Please have a look!

Changelog RFC ... v1:
- tested on hardware
- adding switch outputs (swout1/swout2) (to binding and code)
- fixing DC/DC input supplies (in binding and code)


Andre Przywara (3):
  dt-bindings: mfd: x-powers,axp152: Document AXP318W
  mfd: axp20x: Add support for AXP318W PMIC
  regulator: axp20x: add support for the AXP318W

 .../bindings/mfd/x-powers,axp152.yaml         |  28 ++-
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          |  84 +++++++++
 drivers/regulator/axp20x-regulator.c          | 170 +++++++++++++++++-
 include/linux/mfd/axp20x.h                    | 129 +++++++++++++
 5 files changed, 410 insertions(+), 3 deletions(-)

-- 
2.25.1


