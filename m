Return-Path: <linux-kernel+bounces-814524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F1B55526
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66C17BEEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901F32145E;
	Fri, 12 Sep 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aHkQJStw"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3B326D60;
	Fri, 12 Sep 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696059; cv=none; b=Z2wJoHQqd5DYwFx7PrqINlzlWUJaZcZcykQ+LMycprSc7arIZWysD02syv0n6vcCPfVlXWCJ++VxeIE6QyyYTs/4o5nurLSW04kSIBYuscwunE7ZpBDWEKUBsKA/uSpSA8Avpc/+6D9p0/5/NNgiVR8GSaCYaZ0zc9a7SvzU4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696059; c=relaxed/simple;
	bh=bXIVsKAF399XK4av2bzVOpUyU8+8nZD1CF+E2epBbbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BHxiNkulMpJYsUeGrUZN7tZfv1uSJ6yXM1jn7kuaUeTgaNqPvI0n//Z8XSWtmiaoQkvSVqbyFfQ9QMx6FQ/zNAhieDz/UfqXavPbOFYSuNm6Auwcdu++PEM0iujZRxCGkKT1BujdLGLEi+72+P+InAh2FvtMZc9DU3bNwQ92Hd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aHkQJStw; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757696044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XB+kXwXNKwlFMZlruLnoK7GtoQ6rz9ZNuPsx179Ax3g=;
	b=aHkQJStwok7tY0hD5yJCQSPb0JwMJeXd40YhaFlpeB64BuaVa2zFYOaaI6ok6bKb/QCr85
	obNCTawPApDE6WUNM48gq0PrlqESlxWd99ZTI8de8Gp9iqv5PtetKtWYfOfr1Lcf9uldRX
	kzXBJfWk5AFlDYJz4lxsQpUPEIVHfGc=
From: Ze Huang <huang.ze@linux.dev>
Subject: [PATCH v8 0/2] Add SpacemiT K1 USB3.0 host controller support
Date: Sat, 13 Sep 2025 00:53:46 +0800
Message-Id: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpQxGgC/23OwW7DIAwG4FeJOI+KGIGhp73HNFWJcVukNekgp
 Z2qvPtYeomiHX/L328/ReYUOYt98xSJS8xxHGpwb42gczecWMZQswAFRqEyMtxJH048VEbSBQX
 OeAQgLSq5Jj7Gx1L38fnKib9vtXV6DUXfZZY0Xi5x2jfF7lqUiVrxt3yOeRrTz/JKMcv2/1eLk
 Ur60JPR3Bkd4P0rDrfHLnBZiopd4RY22FZM5BA1EnlttxhXGPwGY8WG0Ld93zmwxzWe5/kXhYm
 HME8BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757696039; l=4082;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=bXIVsKAF399XK4av2bzVOpUyU8+8nZD1CF+E2epBbbw=;
 b=4ASiPOoAk1nxtG2FXhpO+v7ra+o63UgD0fIQqlcQc2MrzhWqlSZITs7JmT9w4DL6O6vuyRNpM
 /SfbqKQqK0IDudFrStgMROcmugm7VVUVnYfxVmVuhmOCEm1D5E0aFxC
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

This series is based on 6.17-rc1 and has been tested on BananaPi development
boards.

Link: https://developer.spacemit.com/documentation?token=AjHDwrW78igAAEkiHracBI9HnTb [1]
Link: https://lore.kernel.org/all/20250414-dwc3-refactor-v7-3-f015b358722d@oss.qualcomm.com [2]

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
Changes in v8:
- dt-bindings: remove the PCIe reset which will be managed by combo PHY driver.
- driver: fix incorrect `dev_get_drvdata()` usage in PM ops, as `dwc3_core_probe()`
  overwrites the device's private data.
- Link to v7: https://lore.kernel.org/r/20250729-dwc3_generic-v7-0-5c791bba826f@linux.dev

Changes in v7:
- dt-bindings:
  - add reset-names and reset-delay properties
  - add pcie0 entry in resets for combphy init
- dwc3 generic plat driver:
  - drop clock cleanup and handle with devm_clk_bulk_get_all_enabled()
  - move devm reset action after successful de-assert
- Link to v6: https://lore.kernel.org/r/20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev

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

 .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 121 +++++++++++++++
 drivers/usb/dwc3/Kconfig                           |  11 ++
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c               | 166 +++++++++++++++++++++
 4 files changed, 299 insertions(+)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250705-dwc3_generic-8d02859722c3

Best regards,
-- 
Ze Huang <huang.ze@linux.dev>


