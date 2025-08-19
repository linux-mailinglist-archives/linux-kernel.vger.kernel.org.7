Return-Path: <linux-kernel+bounces-776398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48343B2CCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19F81C20111
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DBF322C86;
	Tue, 19 Aug 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WYKJQRCa"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BD25229C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631316; cv=none; b=N57It+VRpf0AvqVDdYwLPIZyXQyQ1lJvEzNHq/R4ixJJMIKz6KKkzNb1/hT7Wm0Ih5R+vjIc/FF8ucngUyfMCqF+CFkJZHyhYtSAeT1C+saUsxY+99CZv0pAXeLuCMlxdabxDGF59yPZIqADb4fVbo0spADdYX2rTJWRIggRCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631316; c=relaxed/simple;
	bh=y0HuCLQdVPYu1EN8dPrtj/WwRKsvNzpxh9lHwD4vr1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/CIGDljPBTF1IGfvV7QBKD9jvyCl/6no+bHvkkLP4xsjtaOipL7sMgH+4edYsKD1RzI1tBFCW47SJFmFpMvkjnHffeqxKzzf/hv9oIG/avdh0BgU3wYyTzRldWIkWVGrvg9KwfU1wdFx/+xtl7+PHv0dB9DYHaFgnRDVNH8ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WYKJQRCa; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JJLKGd3021859;
	Tue, 19 Aug 2025 14:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755631280;
	bh=4/rsd/1Jxo/NW4HKBB95A9SHIKdcULGeyqOF1mu6tg0=;
	h=From:To:CC:Subject:Date;
	b=WYKJQRCaV6MoUbcZ5K7NxlKYyJ03T00gwIXBJ/Iz/wYtbEBFtXn8bGu8HdJn49LTx
	 bXR6Ixg4vmZGVXLJD9AzcXcUv/SXrIhy4tpitrRwWoTu1l3borB4Ynz3T3Gv9BlwRd
	 Y/5C4pQWVE+DyZP1NUhMPlXD/urKz/XwnsI8Yq5g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JJLJug1249357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 14:21:19 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 14:21:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 14:21:19 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JJLEiD3205034;
	Tue, 19 Aug 2025 14:21:15 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v5 0/3] Decouple max_pclk check from constant display feats
Date: Wed, 20 Aug 2025 00:51:10 +0530
Message-ID: <20250819192113.2420396-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In an effort to make the existing compatibles more usable, we are
removing the max_pclk_khz form dispc_features structure and doing the
supported pixel clock checks using "max_successful_rate[]" and
"max_attempted_rate[]".

Changes are fully backwards compatible.

After integration of OLDI support[0], we need additional patches in
OLDI to identify the VP that has OLDI. We have to do this since
OLDI driver owns the VP clock (its serial clock) and we cannot perform
clock operations on those VP clock from tidss driver. This issue was
also reported upstream when DSI fixes[1] had some clock related calls
in tidss driver. When "clk_round_rate()" is called, ideally it should
have gone to "sci_clk_determine_rate()" to query DM but it doesn't since
clock is owned by OLDI not tidss.

So add a member is_ext_vp_clk[] in tidss_device structure to identify
this and avoid performing clock operations for VP if it has OLDI panel.
For the same checks in OLDI driver, atomic_check() hook is added to its
bridge_funcs.
In the atomic_check() chain, first the bridge_atomic_check() is called
and then crtc_atomic_check() is called. So mode clock is first checked
in oldi driver and then skipped in tidss driver.

Had the tidss_oldi structure been exposed to tidss_dispc.c, we could
have directly checked VP type in dispc but since the structure is defined
in tidss_oldi.c , we have to add additional member to tidss_device
structure.

[0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/
[1]: https://lore.kernel.org/all/DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org/

Changelog v4->v5
- Rename is_oldi_vp[] to is_ext_vp_clk[]
- Store both pixel clock round_rate and attempted_rate to reduce
  clk_round_rate() calls while validating modes
- Code changes suggested by Tomi[2]
- Minor fixes in comments and commit message

[2]: https://lore.kernel.org/all/8cd9d1c4-2e9f-4766-b224-21925c4f991d@ideasonboard.com/

v4 patch link:
https://lore.kernel.org/all/20250704094851.182131-1-j-choudhary@ti.com/

Changelog v3->v4:
- Minor cosmetic fixes in code, comments and commit message
- Pick up R-by and add Fixes tag

v3 patch link:
https://lore.kernel.org/all/20250701095541.190422-1-j-choudhary@ti.com/

Changelog v2->v3:
- Add changes for OLDI
- Rename max_pclk as it is misleading
- Change commit message to make it more appropriate
- Drop unnecessary zero initialization

v2 patch link:
https://lore.kernel.org/all/20250618100509.20386-1-j-choudhary@ti.com/

Changelog v1->v2:
- Rebase it on linux-next after OLDI support series as all of its
  patches are reviewed and tested and it touches one of the functions
  used.
  
v1 patch link:
https://lore.kernel.org/all/20250618075804.139844-1-j-choudhary@ti.com/

Jayesh Choudhary (3):
  drm/tidss: oldi: Add property to identify OLDI supported VP
  drm/tidss: Remove max_pclk_khz from tidss display features
  drm/tidss: oldi: Add atomic_check hook for oldi bridge

 drivers/gpu/drm/tidss/tidss_dispc.c | 85 +++++++++++++----------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 -
 drivers/gpu/drm/tidss/tidss_drv.h   | 11 ++++
 drivers/gpu/drm/tidss/tidss_oldi.c  | 27 +++++++++
 4 files changed, 75 insertions(+), 49 deletions(-)


