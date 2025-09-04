Return-Path: <linux-kernel+bounces-800289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C2B435D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B568586555
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531742C21DB;
	Thu,  4 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR6cj6Pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99118286D7B;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974822; cv=none; b=ftQqrr1Yu80fRfKCRcvv2xxVJVPZ52ZVCDgMX0e0kPuKietQ8ZVS7pNMgx24f/uWS5EiwzthlVM3SLrUJsKpVk00ADB2bNw2kDFZwmuuvZS7NU0slJartd2gdEzdrRMCp5qIhHNxkq/Ub9cH3pGi5NmhQIOQHzoBqi7pYusNJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974822; c=relaxed/simple;
	bh=GNtVXyetoXXsPzwMZdtfYe4Fsl9TGhpYaapAdK05kzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZwJ54QXEZ+rg97zCEefSRc4p2Misb9/vqNx8yq3aUsTMszWFBvp57UkZ2h3YAv6WOv4nOMQaHwLwJYnYKaI/yqbag+1udDxRCCFrI3OHfp66f17SYVRSQgIL0Bt2gI3nvD+YZ+o1Po6dt/LjWDhe7gk/44UU4TqaYBv97PfrOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR6cj6Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40280C4CEF0;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756974822;
	bh=GNtVXyetoXXsPzwMZdtfYe4Fsl9TGhpYaapAdK05kzk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZR6cj6PfUrvyLOHdfK5JKCjGtSwok34/OGrJyhChwawPRE/JMbsXzJP95zfx1BKEl
	 bdzOxiiEanUrNANePZnseQ8EiC6xa97dpSHnd2qQbxwkUoGymx01blmD6Y0LeIuvDY
	 dnPGIh5ftNNFR4tKCTUmRW4WYrIhm+7ektmCeVUQ9TcmDqqamnr4ig89Nd+U4OML9N
	 or2VNhH2gA9vsUv7FHKIkrzbstVs5nvorjU1QQmUOmbCCZyRI8XMA+8s3SaD3Cp3hr
	 46TRAo4pek3bOeTVUb3PNvVCwVRfIMS0HQAijlfyIKDHaf23WLdKd6y9my80QrWjFN
	 /9KhlW+ml5QqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D52CA1002;
	Thu,  4 Sep 2025 08:33:42 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v8 0/2] hwmon: add GPD devices sensor driver
Date: Thu, 04 Sep 2025 16:33:40 +0800
Message-Id: <20250904-gpd_fan-v8-0-0752584f16da@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOROuWgC/3XRXUvDMBgF4L9SeusqefNdQZhOmKD3IjJG0iRt1
 LZbO7vNsf9uVpTOipfnJc/hQA5xaxtv2/gqOsSN7Xzr6yoEOYnirFBVbhNvQo4xwhQJ4Em+Mku
 nqoQJR1CKSSYljcPrVWOd3/VNL4uQC99u6mbfF3dwuv7t6CBBCaGIgTECFOLTvFT+/TKry/jU0
 eFzJwaHg3NCC8t16jDosSP/OBKcNMI6DZgTLcaOnjs5OBocALeMElCps2PHfhxDGGBwLDiOpKO
 YMYcsjB3v3exmvq0/t3Mg7fb5dXbLl08lLqTCM3O/U+UF3l/nUFK82ldvD+u1uXvMp33PqE0MK
 yQ6WyHCCkalTo10TBgx/ajCL29sVvR2En0bjH4bQJlELKw3Wo3M4ng8fgFUBzk1PAIAAA==
X-Change-ID: 20240716-gpd_fan-57f30923c884
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 Jun Zhan <zhanjun@uniontech.com>, Cheng Nie <niecheng1@uniontech.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>, 
 derjohn <himself@derjohn.de>, Crashdummyy <crashdummy1337@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756974821; l=2686;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=GNtVXyetoXXsPzwMZdtfYe4Fsl9TGhpYaapAdK05kzk=;
 b=hQp6X46rBJBkxwsH5tVqIvmPgwgbdYjBLI5lafg/qh8job3V4zVJs+gkDeyQ/KS4m7NPM4dXd
 kcpZsuRdjMZA5hIparanpxZALt7sCRJEt12p/enejCFuJrUBEnzUncR
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

Sensors driver for GPD Handhelds that expose fan reading and control
via hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped
IO.

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

---
Additional explanation: Based on the concerns in the previous version
of the discussion about placing the driver in the x86 subsystem or the
hwmon subsystem, I currently do not see any intention from GPD to
integrate battery management into EC, and would prefer to keep the
driver in the hwmon subsystem until the hardware manufacturers actually
make something practical.

---
Changes in v8:
- add mutex lock to protect an entire hwmon operation sequence
- clear manual model action
- improve error check
- style fix
- Link to v7: https://lore.kernel.org/r/20250820-gpd_fan-v7-0-10c8058f4dba@uniontech.com

Changes in v7:
- Add support for GPD Duo
- Change email from cryolitia@gmail.com to cryolitia@uniontech.com
- Link to v6: https://lore.kernel.org/r/CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com

Changes in v6:
- fix: nullptr and label followed by a declaration
- cleanup: clean up code and rename some function
- format code
- dmi: add 2025 new GPD devices
- Link to v5: https://lore.kernel.org/r/20250211-gpd_fan-v5-0-608f4255f0e1@gmail.com

Changes in v5:
- Rebase on kernel 6.13
- Remove all value-cache related code
- Clean up code
- Link to v4: https://lore.kernel.org/r/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com

Changes in v4:
- Apply suggest by Krzysztof Kozlowski, thanks!
- Link to v3: https://lore.kernel.org/r/20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com

Changes in v3:
- Re-arrange code, thanks to Krzysztof Kozlowski, Guenter Roeck, Yao Zi!
- Link to v2: https://lore.kernel.org/r/20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com

Changes in v2:
- Improved documentation, thanks to Randy Dunlap!
- Link to v1: https://lore.kernel.org/r/20240716-gpd_fan-v1-0-34051dd71a06@gmail.com

---
Cryolitia PukNgae (2):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan

 Documentation/hwmon/gpd-fan.rst |  79 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 786 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 884 insertions(+)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



