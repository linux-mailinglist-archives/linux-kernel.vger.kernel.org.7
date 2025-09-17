Return-Path: <linux-kernel+bounces-821454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B352EB814BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FF36275C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA62FF64B;
	Wed, 17 Sep 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b="BbMYj2Nx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jj2Ss5bD"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B034BA24;
	Wed, 17 Sep 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132278; cv=none; b=iRlj0n1BjOxoYVAvAtMcbqa2+JvlTMLmhPkcjTqSAgVn59URKpG8tZEFizWGWSO16L7w/NDzqaUP0d8bMJZGSFKVR95R+bkzbTLxwvTf7ZU6funOExANN6xL0TO9RS5FErtKC+z7rT33KBWzI9+IQht5DOwK0qqbLCSKShwyce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132278; c=relaxed/simple;
	bh=todZsB+sIRV2E9TUHrIPRgeJ0mUNTpiPKG4aFGalm/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ON2KuYMSzD/OdAI0+PQMRTFlCtwmnoSSxDDDodADRoMKGbvhuKbmNU9Ssf7DP5YUAqSTHB4dzG6gktOrsSRNXExt3KzDur1XwN1Dod+DIoeZHeOwlHyRmVuCdO4x924v5m9TFTHiiwGSJPdpW4afknDiDy6OZSNAydLn+wFABbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com; spf=fail smtp.mailfrom=bsdio.com; dkim=pass (2048-bit key) header.d=bsdio.com header.i=@bsdio.com header.b=BbMYj2Nx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jj2Ss5bD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bsdio.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A272FEC01CE;
	Wed, 17 Sep 2025 14:04:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 17 Sep 2025 14:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1758132275; x=1758218675; bh=MmY+rQ6CX5jSxSv8cWbPf
	wXi6SSyhtzs/3Z2Z1CrXyE=; b=BbMYj2Nxl0uG8TrrV+4MPx/MCLl6dy7zI61qa
	xBM0nMs1RBwkUYUapcvKROnSvxMGden3l78ZuxwEWN1qQOaArdoQKzUGjW9DJ/JM
	/EJyIwJR5JIO316qTScS4VHvozdl9qBGUjFRy/ofHFKmVJ5agECrly5cMjrlE1Ga
	9f4BscYy+IFx3IzSaDc4h/BFEGukmOn7DDmER3WMfwbRSO84GHPWoahEckuVLc8J
	wRbCvF4D1r0ZuFxfABGZ5b5NK5tYJbCcLY7XWesPxPVS3i4ZdIDMCwhpZl/zb33H
	tXZHVj5Mv6BXQnVlRZcA33nHs2OxS+ptlfXrvbOswoca/3zNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758132275; x=1758218675; bh=MmY+rQ6CX5jSxSv8cWbPfwXi6SSyhtzs/3Z
	2Z1CrXyE=; b=Jj2Ss5bDsETXiZgw8z06njHdzi09K2fNOYwhRKOFT59LtHAClh+
	bM+0FYmfrWYYj04ER54Yl6pGOgJnkjFjT5u3uQmZgXD+oj5NTFuLAXj9SRn2Mmq/
	6+mju9Erp8FP9QxkcrhLsOFAgaNaEz6ryGgZJnFGCJX1l2thLFh1fIogst+x9eRv
	3yLNxpxrof+oS8JLi0vY6mGwueN9NSjHDM/QEfAbjiBr9GHKz/bjQtC/QvqeX+H1
	+SVeYZ42s0AMHl7HNWgeePRVkjrrbDVDuTXyGve8F0s2stE+QzuYRhzeUlGMNTTr
	HQmkv80oIb5hKsS0HKuF02GPFfW6pq6E9+A==
X-ME-Sender: <xms:MvjKaBtfT7UYX4UvmktezWeYaOG9mpp8GTuTWYluG3GKGizyq_WwWA>
    <xme:MvjKaGQrU1alR1FA_ai-FXWJVqJvZZjQdiCMfZRRridgRa8d52KkRm07mfR02zNLQ
    _7ovBrp1GplZB9Y0Lo>
X-ME-Received: <xmr:MvjKaAKL5vpkJTwu3HW-8dCdsSEKQV6rlI0Vx8ZZ1Wmg6-FRdz2ehfLeYwfa4dNa6N8tTAKSWm5y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    eghedvvedufedvheehvedtleejteekudfhvdekffevudduhedutdekfeehheegheenucff
    ohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtggtrgessghsughiohdrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehroh
    gshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfiestgho
    uggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvthhrvg
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MvjKaBs5kwkIojafz6Rn0y2e9cFGWP988O5fGOwjAd7Jh2UwDKb8Wg>
    <xmx:MvjKaP8obK4yI20rtg5irglefP4zhIukd0Xm0IfWPaOslY8XD4X4VA>
    <xmx:MvjKaD1g9YhaeciocwmF84hAUTHD90wdaDq93DJqZU0XNoq_mCuYww>
    <xmx:MvjKaMjVxSxzopX5fSUUhsxtz2iugk2RAuhctS3lKuFHP1jkW-l5fA>
    <xmx:M_jKaE7Ey3LRWLTDa2HFRiC8e7nHzmeuInpx1vEOF7oPXZvy36zT-znf>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:04:33 -0400 (EDT)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 17 Sep 2025 12:04:24 -0600
Message-ID: <20250917180428.810751-1-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
processor. The BMC runs OpenBMC.

These patches add a device tree and binding for the BMC.

**Changes between v1 and v2**

- Reordered nodes to be in alphabetical order.
- Removed status lines.
- Fixed naming.

There are still several warnings from
make CHECK_DTBS=y ARCH=arm W=1 aspeed/aspeed-bmc-asrock-altrad8.dtb
I believe the only one which is reporting an issue in my dts file (as opposed
to included files) is the first, and that's because the code partition contains
the TF-A and UEFI areas. I couldn't see a way to suppress it.

aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@400000)
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01\t' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02\n' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05\r' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#


Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 633 ++++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts


base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
-- 
2.47.3


