Return-Path: <linux-kernel+bounces-728545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89542B029C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 09:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730AD1C2468F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43AE2253F9;
	Sat, 12 Jul 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXfmtrJd"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617812206BE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306569; cv=none; b=G4AIHYNXV/IgLzw7LuWL3mEFQXenvV8yXoR/zlLn2Ht6zRALl7pW0J6wXPezijjySThG0q6D/Vs4nsJa3fHx7RWsIu1KZL/gGSXWisocOByah0lQCw4sp5253n2Z7cg4eLXqn92htOJ+fqYJXhYiwOrBIDuEfNvTemhEmIb6alU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306569; c=relaxed/simple;
	bh=1MuKM66N+VpDrAadh8p/LAH+Y+Guai4ttqwz7vBJaNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DE+8AmwBD3sJWGqeMVMr6X2vV8k3UvnjrG5creqXVFMCH7TP7VzmqLFAsWLLSDoVxRauR9tla9ooX7q57KlF1y8WR/Mt/EGf0ndnZg2A8aCTxoW3UdoYtovLn9dA9ytPlaf2zF5p470MrUDkX5Yy305WTpR4I+eiaZOnajnd9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXfmtrJd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752306555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1hEMfGUsaTb+Yy5uX2svn+tvEyF1FLF6gJK6rBT3z1Y=;
	b=LXfmtrJdfLfu9dm8NC91mhS0flxAQjRDHGW9Z1Y8xedWGzRs4SA/xJ9SXnNnt/5cmgpYMU
	iPyuyV/sI/2GF2ME7nCNXZDWeCuaRW60Mxp4W+UZwcaHCZKsmdioKzP1DxwVJ8hC4grA0M
	SEETsKbyHJ+O1bvhxoVIXa0cYQmMm0E=
From: Ze Huang <huang.ze@linux.dev>
Subject: [PATCH v6 0/2] Add SpacemiT K1 USB3.0 host controller support
Date: Sat, 12 Jul 2025 15:48:59 +0800
Message-Id: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGsTcmgC/22Oyw6CMBBFf4XM2pLSpjxc+R+GGGhHmESKtlAxh
 H+3wtblubmvFTw6Qg/nZAWHgTyNNkJ+SkD3je2QkYkMggvFC66YeWt569DGmGal4aJUVSGElhA
 jT4d3Wva6a32ww9ccW6dDhLbxyPQ4DDSdk5CnWc6czuBn7slPo/vsV4La3f9Xg2KcVabVSmKjp
 BGXB9l5SQ0GqLdt+wIpcEWX1QAAAA==
X-Change-ID: 20250705-dwc3_generic-8d02859722c3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ze Huang <huang.ze@linux.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752306549; l=3386;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=1MuKM66N+VpDrAadh8p/LAH+Y+Guai4ttqwz7vBJaNM=;
 b=dAWAK/ya87gUhcMsd+jqyT5tQZCy2XpKae+r+SrK66YK5bjUiK7HfcRV/8ykUt6jAAWdjQmm3
 Pe5/j1UJ38YANTv8fBdP7fTMUi1SWseq8yCfTy8+oAG4cwU4CMeTuy8
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

The USB 3.0 controller found in the SpacemiT K1 SoC[1] supports both USB3.0
Host and USB2.0 Dual-Role Device (DRD). 

This controller is compatible with DesignWare Core USB 3 (DWC3) driver.
However, constraints in the `snps,dwc3` bindings limit the ability to describe
hardware-specific features in a clean and maintainable way. While
`dwc3-of-simple` still serves as a glue layer for many platforms, it requires a
split device tree node structure, which is less desirable in newer platforms.

To promote a transition toward a flattened `dwc` node structure, this series
introduces `dwc3-generic-plat`, building upon prior efforts that exposed the
DWC3 core driver [2].

The device tree support for SpacemiT K1 will be submitted separately when the
associated PHY driver is ready.

This series is based on 6.16-rc1 and has been tested on BananaPi development
boards.

Link: https://developer.spacemit.com/documentation?token=AjHDwrW78igAAEkiHracBI9HnTb [1]
Link: https://lore.kernel.org/all/20250414-dwc3-refactor-v7-3-f015b358722d@oss.qualcomm.com [2]

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
Changes in v6:
- replace SET_RUNTIME_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS with RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS
- Link to v5: https://lore.kernel.org/r/20250705-dwc3_generic-v5-0-9dbc53ea53d2@linux.dev

Changes in v5:
- drop DTS patch (will submit when PHY driver is ready)
- drop interconnects and update resets property in dt-bindings
- remove unnecessary __maybe_unused attribute and PM guards
- switch to devres APIs for reset and clock management
- Link to v4: https://lore.kernel.org/all/20250526-b4-k1-dwc3-v3-v4-0-63e4e525e5cb@whut.edu.cn/

Changes in v4:
- dt-bindings spacemit,k1-dwc:
  - reorder properties
  - add properties of phys & phy-names
  - add usb hub nodes in example dt
- add support for spacemit,k1-mbus
- dwc3 generic plat driver:
  - rename dwc3-common.c to dwc3-generic-plat.c
  - use SYSTEM_SLEEP_PM_OPS macros and drop PM guards
- dts:
  - reorder dts properties of usb dwc3 node
  - move "dr_mode" of dwc3 from dtsi to dts
- Link to v3: https://lore.kernel.org/r/20250518-b4-k1-dwc3-v3-v3-0-7609c8baa2a6@whut.edu.cn

Changes in v3:
- introduce dwc3-common for generic dwc3 hardware
- fix warnings in usb host dt-bindings
- fix errors in dts
- Link to v2: https://lore.kernel.org/r/20250428-b4-k1-dwc3-v2-v1-0-7cb061abd619@whut.edu.cn

Changes in v2:
- dt-bindings:
  - add missing 'maxItems'
  - remove 'status' property in exmaple
  - fold dwc3 node into parent
- drop dwc3 glue driver and use snps,dwc3 driver directly
- rename dts nodes and reorder properties to fit coding style
- Link to v1: https://lore.kernel.org/all/20250407-b4-k1-usb3-v3-2-v1-0-bf0bcc41c9ba@whut.edu.cn

---
Ze Huang (2):
      dt-bindings: usb: dwc3: add support for SpacemiT K1
      usb: dwc3: add generic driver to support flattened

 .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 107 ++++++++++++
 drivers/usb/dwc3/Kconfig                           |  11 ++
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c               | 182 +++++++++++++++++++++
 4 files changed, 301 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250705-dwc3_generic-8d02859722c3

Best regards,
-- 
Ze Huang <huang.ze@linux.dev>


