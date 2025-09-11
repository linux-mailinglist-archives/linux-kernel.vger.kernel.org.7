Return-Path: <linux-kernel+bounces-811900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD7B52F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C5D161EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E693126C5;
	Thu, 11 Sep 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hod9mBrO"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934D311C2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588873; cv=none; b=m9hSMDuIywtX1T1Z2jZjGFBm2iXpGo0thQZOBaX7HpfKs0/naO4rudS8yK6F4HlYkbijuWNd0zlQV9lI8ijTX6VSapI9eHFjCRxEKv5GeZYTFIJ3llZJa1mHMwLBhFxU6dOSs6QZZHlFHsfl4naKf13hbJR1U8OO03vz2JA51XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588873; c=relaxed/simple;
	bh=mgTLTLACjhM9EBGHYwseoPp1aR5txfklo9jEXFmIxNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsZxJ+sPDtcGAw1KggNnXl5Cm1gNiV4pvVm9RbgG64xZQv956RAQM3+mfvPoB00ZWdtWa+X+XyCe/FsqavH53wiWFk8L2NDHZv2bPrubFdlxchpTFNl6bsW8v+j1lao9+NXS4tiwgvBlT5FiaeLMBsP+YB4Ti4Tb93YNlebBhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hod9mBrO; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BB7MSE789549;
	Thu, 11 Sep 2025 06:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757588842;
	bh=eFPOsL/px2E+fmQT2eS4LFUjQzfYRFJgDTiudOOWFAA=;
	h=From:To:CC:Subject:Date;
	b=hod9mBrOZi2SvoCJMj8wZnBQfx8GhzMR6gD4ssUyXixv8vEC9FYcnO98kAvS4fHA9
	 q6VgUVYeuLAFJpcIfqfXrBqvdY3C88Ak0yJIhyQOqojl6WQ+L+nFgxcI9ZpaeSRD2C
	 Z0yRRLIHq6WbbjF9G+gtoSx8oEjxSSsPFN6fhWDg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BB7LaF1014037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:07:21 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:07:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:07:21 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BB7FP32031347;
	Thu, 11 Sep 2025 06:07:16 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v6 0/3] Decouple max_pclk check from constant display feats
Date: Thu, 11 Sep 2025 16:37:12 +0530
Message-ID: <20250911110715.2873596-1-s-jain1@ti.com>
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
supported pixel clock checks using clk_round_rate().

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

Changelog v5->v6
- Drop caching logic
- Add comments for tolerance value
  (We are targeting another series for reducing tolerance value)
- Minor fixes in commit message

v5 patch link:
https://lore.kernel.org/all/20250819192113.2420396-1-s-jain1@ti.com/

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
  drm/tidss: Remove max_pclk_khz from tidss display features:
  drm/tidss: oldi: Add atomic_check hook for oldi bridge

 drivers/gpu/drm/tidss/tidss_dispc.c | 78 +++++++++++------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  1 -
 drivers/gpu/drm/tidss/tidss_drv.h   |  1 +
 drivers/gpu/drm/tidss/tidss_oldi.c  | 23 +++++++++
 4 files changed, 54 insertions(+), 49 deletions(-)


