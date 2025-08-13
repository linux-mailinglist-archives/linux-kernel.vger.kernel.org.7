Return-Path: <linux-kernel+bounces-767704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1BB257E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE27D9A6737
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672272FE58A;
	Wed, 13 Aug 2025 23:56:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD22D4B6E;
	Wed, 13 Aug 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129391; cv=none; b=U9Yq4gDEN67+7VA6Tv9BfaTqKyDKfSY5uF2g1e0khi/VNtyu3PwkIYn2g2vuFhwD/71qqni+nI21m2Z9EDk5Sz9NtT6ayU0Qu9HXnZr2LrUNwnnZJnM8saBv7XssDhDg1VKSrK9lTOrks+O5rswRR/vRRvL2QwQzUdv0Y1zmLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129391; c=relaxed/simple;
	bh=0gMaOXiwCkO8Yv/bNLAgqvbF38VbP+tWgQlGJwyd+y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scj59ybEx6CuWQZ0/o2qgfy74F4tc+klowHHDNymDYAnjXmvDtHTwSvaoQciVkyYFowiYr6CSIOFGfWEHKKce+ZEwmU8OHOu2tVqodYPGZZFLDCm4O4q6exfu4kE+UuaF+WlWHk4bNACVMHifNIsLUGtOmR3DWLdS+CeSCxeO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B603D1595;
	Wed, 13 Aug 2025 16:56:19 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262E73F738;
	Wed, 13 Aug 2025 16:56:26 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] regulator: Add X-Powers AXP318W PMIC support
Date: Thu, 14 Aug 2025 00:53:27 +0100
Message-ID: <20250813235330.24263-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the X-Powers AXP318W PMIC, which is
used recently on new boards with Allwinner SoCs (the A733).
It features 9 DCDC buck converters and 28 LDOs, plus the usual ADC,
interrupts, and power key components.
I am marking this as RFC, as this is untested, since I don't have hardware,
but at least the datasheet [1] gives enough information to get the review
and discussion started.

Patch 1 adds the compatible string to the binding document, and adds
the additional input supply properties.
Patch 2 is the MFD part, describing the regmap and all the interrupts.
So far we support the regulator and power key devices, the ADC and
other pieces will follow later.
Patch 3 adds the voltage regulator rails, this part is crucial to enable
any board using this PMIC, as we depend on those rails even for basic
devices.
Based on v6.17-rc1.

Please have a look!

Cheers,
Andre

[1] https://linux-sunxi.org/AXP_PMICs (link in last line)

Andre Przywara (3):
  dt-bindings: mfd: x-powers,axp152: Document AXP318W
  mfd: axp20x: Add support for AXP318W PMIC
  regulator: axp20x: add support for the AXP318W

 .../bindings/mfd/x-powers,axp152.yaml         |  18 ++
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          |  84 +++++++++
 drivers/regulator/axp20x-regulator.c          | 159 ++++++++++++++++++
 include/linux/mfd/axp20x.h                    | 127 ++++++++++++++
 5 files changed, 390 insertions(+)

-- 
2.46.3


