Return-Path: <linux-kernel+bounces-777437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE81B2D964
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A536A1C26A94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7727781D;
	Wed, 20 Aug 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwGMkAP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1E1B4233;
	Wed, 20 Aug 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683449; cv=none; b=ppI303p7QJ02vn9nANkx3Jj0pWoiXwnhswBDtXsyT4npntt9fL+owyme1mdjJRP5COzHguvVgX0hESZ56SrndDvXMHmugFM7Pn+Qz0numn/i+aQ40FS6JB2w/bMy/yKyQDGFoVdokvaef4JZsmp6hVy5kC9NAYyLwZSPKBFE+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683449; c=relaxed/simple;
	bh=TXa6SwADZW2EnuROnuMdq8thNh5pAy9oJvtuOdFbs9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e3Zs8Cf0TmXXgCpPUGXmstHbQxfYd0KowTBJZJNua1FaYnigHbd3Mbo3kNfdtiF6XXUR1D+Eb/hpb2cfZ/AfvbToz0JrwsNyaqLsbk/Rjx21Z6Y3YZWpeBk+PvgXgLSIxYWd561aLMRzONRksTebzuYoC7Gap3pVOihQlzqL40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwGMkAP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03363C4CEEB;
	Wed, 20 Aug 2025 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755683449;
	bh=TXa6SwADZW2EnuROnuMdq8thNh5pAy9oJvtuOdFbs9k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pwGMkAP3fShXsgmIxrDNbGfSts1T4hTBVJm2cid/yzLOfjeP1FCMK+ej0o+F8IyTy
	 c3QUhXDiY94NGRtIvDB/IGVAc2eUr6dmqnx0MiD5TXvk6EnAu+WPwSY64BBmAYWExa
	 fI8CdiVpigXQQ2F/MKXO+PKLZ8YhCR7wMOlWUZPJfTA/Hj1f1ExhvnNIBbsBgO1OL+
	 JETPlI9OzjTVHNJTHw7rgxCdfuaqSnhZ0byZ1uTrdJcX/Hl8B8WkiXUDB6mfa4LWPy
	 ahglHaosGsDKQNmJ898OYCSQChX1zsQFE6Q30LDjdYjDeiaklhVl1FWn3crB7m1DqM
	 XMqvbDjpv2Pvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD0CA0EDC;
	Wed, 20 Aug 2025 09:50:48 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH RESEND v7 0/2] hwmon: add GPD devices sensor driver
Date: Wed, 20 Aug 2025 17:50:37 +0800
Message-Id: <20250820-gpd_fan-v7-0-10c8058f4dba@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG2apWgC/3XRXUvDMBQG4L8ycquVnHxXEKbbmKB4oRdDREbaJ
 G3Utls7u82x/26oSEfFy5Oc580LOaDG1t426HJ0QLVtfeOrMgzyfITSXJeZjbwJMyKYMCxBRNn
 KLJ0uIy4dxTGhqVIMhe1VbZ3fdUkv6HH2NHuYotdwnvtmU9X77oEWuts/WS1EOKIMczBGgsZin
 BXaf1ykVdFltOTUyd6R4JxMpBVJ7AgkQ0f/cTQ4ZaR1CRBBEzl07NSp3rHgAITljIKOnR06/us
 4JgC948EJrBwjnDtsYehE5ybX8231tZ0DbbbPb5MbsVwUJFeaTMztThdnZH+VQcHIal++363XZ
 nqfjbucQZrsWyh80kKGFpypJDbKcWnk+LMMv72xaf5jj8fjN1HgY1gQAgAA
X-Change-ID: 20240716-gpd_fan-57f30923c884
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>, 
 niecheng1@uniontech.com, guanwentao@uniontech.com, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>, 
 derjohn <himself@derjohn.de>, Crashdummyy <crashdummy1337@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755683447; l=2789;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=TXa6SwADZW2EnuROnuMdq8thNh5pAy9oJvtuOdFbs9k=;
 b=77K97mhcCeUPSUzAKn5zfKgB4jRcNrtMlxnyg46exXHlHVP43IF2mkcf81i56tXInbmviizaw
 tec0+mxfAtmAG6uf3276jfrqISM5ICFxxTRG6QF/ZR2jdRfGpGC6RLt
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

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Tested-by: someone5678 <someone5678.dev@gmail.com>
Tested-by: Justin Weiss <justin@justinweiss.com>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: command_block <mtf@ik.me>
Tested-by: derjohn <himself@derjohn.de>
Tested-by: Crashdummyy <crashdummy1337@proton.me>

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

---
Additional explanation: Based on the concerns in the previous version
of the discussion about placing the driver in the x86 subsystem or the
hwmon subsystem, I currently do not see any intention from GPD to
integrate battery management into EC, and would prefer to keep the
driver in the hwmon subsystem until the hardware manufacturers actually
make something practical.

---
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

 Documentation/hwmon/gpd-fan.rst |  71 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 753 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 843 insertions(+)
---
base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



