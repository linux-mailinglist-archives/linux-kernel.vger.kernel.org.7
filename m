Return-Path: <linux-kernel+bounces-802885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6FB457FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A5E7B1026
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519834DCE1;
	Fri,  5 Sep 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+ewCXZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBE2E8B9A;
	Fri,  5 Sep 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076002; cv=none; b=W4o+eQ/3WGhNWRNK6EIqgIqY6APBWHD/+a9AmkO31BhZzSIiHdADDUxjyC7gTaazKD3FP8fC4PqaxhjeibrmhpjA2cgXcXn5D6D8EWkFQIolrcQYXWkJQJqXBfMi9rTLmO52G+JMxXGMtGMTipuaPhow44MJW9IpVIjJ1D1tJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076002; c=relaxed/simple;
	bh=tuNjf+8cgNDQrXfELfd8MfwKaydQiJBd15X3JTiaVHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WwfOQ3kicdGCTa0uaisPVq7pZCAZqLbCuKf08DqVQzKu/UUnRzuy/Nt9aS16tvAH3Nmgc6q7hNMkbiZLeRCHM0Vi2cnmNU9oLR1Y6D3vUlZUpVFzYM6NGC633TU+nDeCL9VAgSvUPdeM6gz0dyh4xuY+XO6Up4tsypa+Hc35Dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+ewCXZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E37ADC4CEF7;
	Fri,  5 Sep 2025 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757076002;
	bh=tuNjf+8cgNDQrXfELfd8MfwKaydQiJBd15X3JTiaVHs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d+ewCXZFowTgbRTiG8clttMssAcJSt8LODmfoETFpkhGJhbZ/PpEJn4vV4zni9qed
	 P0hIjnhCZgdFR6fBoPRnl8UQwufq7y1URE0G+/1G2ytmS+aehZk7V+gxj9BKfnYpGZ
	 BEGANnM9xC0ph/OTwnoaMEXFdGvDXBkR+IHYlBONpoRM24PXBGhqckYT0RUAXIQz2t
	 +at6cyd/9IoUBEvrOlJ2Z37Oei8oks9wp9IIhB1LYM/zwDLGCcrgbtMBS00VWS+N8c
	 tFXxvh/S/rCJVkuvInEnOyHlFnWrZeZv2N02drLOj+x7DxZx8+nxSvWLjNpuUJb+9R
	 MfTjA0w6G0pQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB5CA101C;
	Fri,  5 Sep 2025 12:40:01 +0000 (UTC)
From: Woodrow Douglass via B4 Relay <devnull+wdouglass.carnegierobotics.com@kernel.org>
Subject: [PATCH v7 0/2] regulator: pf530x: NXP PF530x regulator driver
Date: Fri, 05 Sep 2025 08:39:41 -0400
Message-Id: <20250902-pf530x-v7-0-10eb2542f944@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3aumgC/33QwW7DIAwG4FepOM8VMTiEnvoe0w5ATIO2JhWJo
 k5V332Q07S1PVr4/2x8EzPnxLM47G4i85rmNI2lMG87EQY3nhhSX2qBEklaiXCJpOQV2t4bb7F
 pUAZRmr2bGXx2Yxhq+9nNC+f6cMkc03Wb8P5R6pinMyxDZre55K2hQgORjqBNR2A7JIhsVaO66
 HrVHD85j/y1n/KpikOalyl/byuvWF3hCA1LRDDketAWGZxiBWRscKE3vUL9W6mLrGqL/v3YiiA
 hNpLYS6OCb47BldwpcZ78tKQw78N0rnv8S6qS1KiRTdsZ0z5JbrP149m6CgZNLHctEr8Q6LFAR
 WipC1oqbstZXgjtY6EtgmPiyA4b2/VPhPv9/gOMj28WPQIAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451;
 i=wdouglass@carnegierobotics.com; h=from:subject:message-id;
 bh=tuNjf+8cgNDQrXfELfd8MfwKaydQiJBd15X3JTiaVHs=;
 b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBoutohDHhJ5uUpBNqYocZVZoMS8Xc2VjO5yhkD2
 eKNYeo4szCJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLraIQAKCRDsC7i5TzYe
 FGk8B/9ZBU4eLtPe/tBr10uO4xRYoPCCt+c/ptYIyUsqqaJmKdsJMPnZStKFfqSsoKp+pW5Xq6j
 +tjojpaMK1HNmQwztwpr02u+21CTFXiD2ZoUTGo07qVBrpjgA8JCeRf2YxxFM/mcphkRhS8KAzn
 KlQX0Z2kA2Qp/vDMSRIIwjxkBbwF7bKX4P5TA+iFP9Qjj2YoRbaE97nneJPncPdGbnOA+u7Q6p4
 W9Bounm/XiaX0ZUQpay+a9Y1e976vA4UgQ3nclh+xB1lf8JBfI5e2dyYVZH03n3HwJQmwO5Xkex
 sr9+0fmH/chPBluCPwTG1/LIXXvb3pJ0m0e3TQLLDey0si5z
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp;
 fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
X-Endpoint-Received: by B4 Relay for wdouglass@carnegierobotics.com/default
 with auth_id=514
X-Original-From: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reply-To: wdouglass@carnegierobotics.com

I wrote this driver to read settings and state from the nxp pf530x
regulator. Please consider it for inclusion, any criticism is welcome.

Thanks,
Woodrow Douglass

--
2.39.5

---
Changes in v7:.
- make vrange and pf530x_range_desc const, removed unused driver_data pointer
- Drop "nxp,pf5301" and "nxp,pf5302" from of_device_id list, allow fallback
- Add Reviewed-by to the dt-binding from Krzysztof Kozlowski (Thanks!)
- Link to v6: https://lore.kernel.org/r/20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com

Changes in v6:
- Make sure that the device tree binding properly references regulator.yaml
- Link to v5: https://lore.kernel.org/r/20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com

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
      regulator: dt-bindings: nxp,pf530x: Add NXP PF5300/PF5301/PF5302 PMICs
      regulator: pf530x: Add a driver for the NXP PF5300 Regulator

 .../devicetree/bindings/regulator/nxp,pf5300.yaml  |  54 +++
 MAINTAINERS                                        |   6 +
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf530x-regulator.c               | 375 +++++++++++++++++++++
 5 files changed, 448 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pf530x-6db7b921120c

Best regards,
-- 
Woodrow Douglass <wdouglass@carnegierobotics.com>



