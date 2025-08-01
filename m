Return-Path: <linux-kernel+bounces-753029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E5B17DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C0D18813EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5C21770B;
	Fri,  1 Aug 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYL0cPZq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943720B1F4;
	Fri,  1 Aug 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035169; cv=none; b=coUSgUmzDczvCVBy98qynZW6DAK7vdif1MSJfbxTdVQZ5Kv+JOfSMSMXsP9CGH7KK5/TkSfNVa3dGwZsEX7ErVBLZ42tVm+3Wll42lcxVex/ANWRSghKIGL8WWggpxbEH9KxG2s1bcIYOMQWAuGZuZcbPvt46rNSRPL5ZwN0F1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035169; c=relaxed/simple;
	bh=UPN2BtjFTPrNsAhc0hr0QepQVBNilRoSpsPBwysfjg8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q8qZG9otXr9aWVgbSKUyP7styh0VW/k4xP6AYdncOmX9ExeLPqq+1Rxa7QHoPVeKcHjxZa6PeJdymWcHo7MWAUkCF1bJr7LCYsTGqarpPv1ihSzveeYSbGY7z1wNQdzB8vOud2I6mKTWxQ+Qm3wyzE/9W4cRpeIOYO7FoCepIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYL0cPZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A42D1C4CEE7;
	Fri,  1 Aug 2025 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035168;
	bh=UPN2BtjFTPrNsAhc0hr0QepQVBNilRoSpsPBwysfjg8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VYL0cPZqCxuK8i+Vi6dqDSoGzXWJwNUNA7/bJFqMDpIDrdme3/NvLvVOTNtoldaI+
	 vUawJRPXfdsQzLus63GRHc2m2RCTD1DBAvpgVZzu8/B7KHj64fbjyfABhznJwBUNN9
	 22QHEHaJGqcIGIvWih72WzwnXx3VTPVauXIDh9mW2p5Ym/0WSLPBDtIxcpig0aOlT6
	 NZi/4CHoOzGA+L5ylr4WW/hOBiCNWNzIhH0GoPEQ4bR2mSSnjYQVsuHQrkgMboEsdM
	 37qLTauHaklM5d+V1O4QTmYOZ5MEu7FcaMnB6D+PYJwkre/0WuvzTL1yNAvDqDxFMz
	 7ILsRJ+AcgfIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C42C87FCA;
	Fri,  1 Aug 2025 07:59:28 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v7 0/2] hwmon: add GPD devices sensor driver
Date: Fri, 01 Aug 2025 15:59:19 +0800
Message-Id: <20250801-gpd_fan-v7-0-548b9d8f57d7@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANdzjGgC/3XMXUvDMBTG8a8ycquVnJO3VhCmFSbovYjISJeki
 9qXtdJujn53s4KsVLx8Duf3P5LWNt625HpxJI3tfOurMgx1uSCbrS5zG3kTNkGKnCqQUV6btdN
 lJJRjNEG2iWNOwnfdWOf3Y+n1Leytb7+q5jCGOzhd/zY6iGjEOBVgjAJN5TIvtP+82lQFOTU6n
 Dp1dhicU5myMkscQjZ37B/HgouNsi4DlCxTc8enLj47HhyAtIIz0Imzcyd+naAIcHYiOEljx1E
 IRy3MnRxdervqq+9+BaztX97TO7l+LnAba0zNw14XF3i4yaHgWB/Kj8fdztw/5cuxM6kNw/ADo
 T3ErcwBAAA=
X-Change-ID: 20240716-gpd_fan-57f30923c884
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>, 
 derjohn <himself@derjohn.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754035167; l=2352;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=UPN2BtjFTPrNsAhc0hr0QepQVBNilRoSpsPBwysfjg8=;
 b=qZVC7oDXZenuFnLpeXV1GazobxhLyCgLraqXeNVH2Nr4/qDCoLgdqZeWZ/7hhaHqbOt6vMfjv
 u+VYXmiykzADL53DcBAK/nuEsgS39SyUqnLJDxTv6bLfrvriOe/NrZD
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped IO.

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Tested-by: someone5678 <someone5678.dev@gmail.com>
Tested-by: Justin Weiss <justin@justinweiss.com>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: command_block <mtf@ik.me>
Tested-by: derjohn <himself@derjohn.de>

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

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
base-commit: 0db240bc077fd16cc16bcecfd7f4645bc474aa7e
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



