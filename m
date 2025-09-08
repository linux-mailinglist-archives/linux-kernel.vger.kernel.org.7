Return-Path: <linux-kernel+bounces-804979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD82B48297
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFF23BE67B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9E1F4192;
	Mon,  8 Sep 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbKQiCN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710F1E32B9;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298352; cv=none; b=q/lw2OcIUm7HFJbNTRiM1426Gwf5cMckeHq6yaRLPhIxVN6T/pSZ9m9c6jCkkWWixhWFfbZL6fFsEfJFf6NzsvPCzFiuLO8fz/vAZtgir0I8Dky0sxXIUdnfEhfaC35wssY8RupWIhPhzAjA8GlIicJ8RjVPPage3QD6LQFh4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298352; c=relaxed/simple;
	bh=VlQ+fCB+M02Tun0Cg1gDM4KSeejvTJCZ9PTIGgb0l70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DH+a+Nza17xHMH1DoAfPbqRiAo59zivxOZLblDtbgbt0tfg0mCoR9qHou0NcjOHMM+ALSSdKXgpLP5tJQm77XKTUj31d2k3+qEIFkZVweov0BlLwmq9jZV2VhDzVpMFFz8icjSLn/hgHoR3KbbUAOLVA4xqu8txxFposgqevmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbKQiCN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D675C4CEF0;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757298352;
	bh=VlQ+fCB+M02Tun0Cg1gDM4KSeejvTJCZ9PTIGgb0l70=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DbKQiCN0mXS2jYtb8n+fnQGND4AYKOoa7R30XDwAcZVkyDKd/CzDa0hivK3mCiuFP
	 1BYz26Wcfmic7nzb+kQk0JkWWKzI/yrrNjBKmQMF4MjzCgYmMMc5FL0yYMyNuQR4V+
	 GFJzcxcyaODChKG971/wPE/mvaqx4ZMyv9bLrE/SwxEx+UMq0tscUaBEQT+NUgvKYw
	 W4SxfFDi0jw1RDGiAnXUwp7bGmurJuWgbR3QuOd0jF1j/LBa2cnLR6Pj3W5/d9YyTR
	 gWijkbh51AChWcY+4nBTHE9MjqUtiS8esxwdi6toKTcSjJr8FxWmvtxWlrOUALZiUc
	 zBlqsTiFS3sNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F2CA1013;
	Mon,  8 Sep 2025 02:25:52 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v9 0/2] hwmon: add GPD devices sensor driver
Date: Mon, 08 Sep 2025 10:25:43 +0800
Message-Id: <20250908-gpd_fan-v9-0-7b4506c03953@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKc+vmgC/3XR3UrDQBAF4FcpubWRmf2PIFQrVNB7EZGyye4mU
 ZO0SU1bS9/dbVASU7ycZb8zB+YQNLbObRNcTQ5Bbdu8yavSD9F0EiSZLlMb5sbPAQHCQKII05V
 ZOl2GXDoKEaGJUizwv1e1dfmuS3p59XOWN5uq3nfBLZ5ezzNaDCGkDDgaI1GDmKWFzj8uk6oIT
 hktGTrZO+Kdk7G0Io4cwXjs6D+OeqeMtC5GImgsx44Nneod8w5RWM4o6sjZseO/jgNB7B33ToB
 yjHDuwOLYic7Nbxbb6mu7QNpsn9/mt2L5VJBMaTI39ztdXJD9dYoFI6t9+f6wXpu7x3TW5YzSZ
 N9CwaCF9C04U3FklOPSyNln6a+8sUnW2enkxxD4axASBdy3N7EemW6f6vdFwHqrvAXJCVfMoTB
 n9ng8fgMLVnyWeAIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757298351; l=2549;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=VlQ+fCB+M02Tun0Cg1gDM4KSeejvTJCZ9PTIGgb0l70=;
 b=DFvCSSaNtt5d1rnOGKyjPlySnLwJZIpRrg+MUNNTEBevYKoka9AXndtj4ZyCEtoltN9iN4oLG
 JupqTB0TLdPAFhlCdTR2qCci4snhqGrWPkYq7xegZsKQVvufcTud4rK
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
Changes in v9:
- remove worthlessness EC access mutex lock
- just return EOPNOTSUPP on device that not support read pwm in auto
  mode
- cleanup code
- Link to v8: https://lore.kernel.org/r/20250904-gpd_fan-v8-0-0752584f16da@uniontech.com

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

 Documentation/hwmon/gpd-fan.rst |  78 +++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 715 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 812 insertions(+)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



