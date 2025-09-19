Return-Path: <linux-kernel+bounces-823786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB7B87704
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A31A7C5447
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A4522F;
	Fri, 19 Sep 2025 00:01:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5597E9;
	Fri, 19 Sep 2025 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240081; cv=none; b=cetxTlLWZzeRsAUANX2s3kp8XHBkVdFAVfv+dB8baU/4AT0Hx6Y/TyEwNedULrNEVvXRhld8eGli5q36c5FCuRNAuojZ+8VjXYklnsWX1Tn0dYHxTFqIpfBoAgR3lVgPNp+bXTGySSl/oSf1H8u/p0vmy/0DZGOsrJ0fYfpZxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240081; c=relaxed/simple;
	bh=TquqI/yPBwY/lnpBzn9JPxiS8I6Bb2ayX14FH7LZfs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ht1Z4j9VHEmxmY2a/uaI1LwXK7Z3IT8h0FWQxIybWpwJ18i8xvJQvLpTIHyaE3gjnG2FYjDIMh58gbiLgZLYWZt5oe78i8LG9IGnKpSR6ViUnD8rGmXfIJUMztYbLHWEu7Ms/1aTvF56hL3YG2619aOStVZX83m/3mXEEN7k5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2FD1762;
	Thu, 18 Sep 2025 17:01:09 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE5D3F673;
	Thu, 18 Sep 2025 17:01:15 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [RFC PATCH 0/5] mfd: axp20x: program poly-phased regulators
Date: Fri, 19 Sep 2025 01:00:15 +0100
Message-ID: <20250919000020.16969-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series introduces support for X-Power AXP PMICs to actively control
poly-phase configurations. Some AXP PMICs allow to join two or more voltage
rails together, under the PMIC's control, to achieve higher currents and
reduced ripple, by offsetting each rail's phase.

So far we were just querying the active poly-phase configuration, as all
boards were using the reset default setup, which matched the board's
requirements. This information was just used to leave the coupled regulator
alone, as its configuration is synchronised internally to the "leading"
regulator.

Now boards with the A523 family of SoCs often come with an AXP323
dual-phase regulator, but use a single-phase reset default. However this
regulator pair supplies the "big" CPU cluster, so definitely needs a
dual-phase setup. Ignoring that leads to an immediate hang as soon as the
cluster leaves the safe 792 MHz/900mv OPP.

Looking at various datasheets of AXP PMICs reveals that there exist
dual-phase, but also triple-phase setups, although the latter is only used
by one PMIC at the moment. To be future proof, the following DT binding
design is proposed:
- The "x-powers,polyphased" property is introduced to list phandles of
  regulators that are phased together. Only the lead regulator needs
  to use that property:
	regulators {
		reg_dcdc1: dcdc1 {
			regulator-always-on;
			regulator-min-microvolt = <900000>;
			regulator-max-microvolt = <1220000>;
			regulator-name = "vdd-cpub";
			x-powers,polyphased = <&reg_dcdc2>;
		};

		reg_dcdc2: dcdc2 {
			/* dual-phased to DCDC1 */
		};
	};
- If the "x-powers,polyphased" property exists, but the list is empty
  (like a boolean property), the regulator will be removed from the
  poly-phase setup, so the affected regulators become independent.
- If the "x-powers,polyphased" property is absent, the existing poly-phase
  configuration will not be touched. This preserves backwards compatibility
  with the current situation.

Some off-tree downstream patches use a temptingly simpler solution: the
secondary rails just list a boolean property, to opt in to a poly-phase
setup. Besides becoming slightly ambiguous in a true multiphase
configuration, with three or more regulators involved, this has the big
disadvantage of not being backwards compatible: a missing property might
let the driver turn the poly-phase setup off, potentially breaking
existing setups.
The design proposed above avoids this problem by explicitly pointing out
all participating regulator rails, at the cost of some more code
complexity.

This series introduces the DT binding changes in patch 1/5.
Patch 2/5 refactors the current poly-phase *detection* code, to introduce
a data structure describing the known pairs. This should be considered
regardless of the rest of the patches, as a clean up.
Patch 3/5 adds support for connecting dual-phase regulators, patch 4/5
extends this to cover the one used tri-phase special case.
The final patch adds the property to the A527/T527 board DTs that need it.

This is a prerequisite for the upcoming DVFS support for the A523 family
of SoCs, as all those boards so far require to actively enable the
dual-phase bit.

I am marking this as RFC, to get opinions on those questions:
- Is the proposed DT binding a good solution? Shall the property name
  be more generic? Is there an existing solution to this problem?
- Is there a better, more generic way to describe poly-phased regulators
  in a data structure? The one proposed in patch 2/5 just supports
  dual-phased regulators, for simplicity.
- Do we need support for the special-cased tri-phase setup, as seen in
  patch 4/5? This is coded as some special case, but technically the
  boards using this tri-phase setup (Allwinner A80 based boards) are
  happy with the PMIC reset default.

I would be grateful to get some feedback on this, so that we can push
for a solution to eventually enable DVFS for the A523 family of SoCs.

Based on v6.17-rc1.

Cheers,
Andre

Andre Przywara (5):
  dt-bindings: mfd: x-powers,axp152: Add polyphased property
  mfd: axp20x: Refactor axp20x_is_polyphase_slave()
  mfd: axp20x: Allow programming dual-phase regulator pairs
  mfd: axp20x: Support tri-phase setup
  arm64: dts: allwinner: a523: Mark dual-phased regulators

 .../bindings/mfd/x-powers,axp152.yaml         |  14 ++
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |   5 +-
 .../dts/allwinner/sun55i-h728-x96qpro+.dts    |   5 +-
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   |   5 +-
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts |   5 +-
 drivers/regulator/axp20x-regulator.c          | 190 ++++++++++++++----
 6 files changed, 181 insertions(+), 43 deletions(-)

-- 
2.46.4


