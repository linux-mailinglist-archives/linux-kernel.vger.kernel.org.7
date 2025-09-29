Return-Path: <linux-kernel+bounces-835965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41ABA875A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C969189D022
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE62BF3DB;
	Mon, 29 Sep 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qqrxn9oU"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C52BEFF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135915; cv=none; b=snGhaDX6ziVdky1x3uFA//QzhipNkoXT3hEHPkT6j/4n78hGZKxxCvb/dBP4t8LalDgcV6yrH7SqdUjrf1GUNEMeZMs4m1pOzBpZHEhn3rXNfR7T60XhLz6Ps0qoeECRhgtHeG7CwR7RaJaN4s39y0KAbGqLPDj2Nt9UJCePHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135915; c=relaxed/simple;
	bh=AoqeZG+Y7JqNjpeEOtwTImwnD++IczLuSVx5a5pmasg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBFGjCJOPs68sKe8Fei8g2MfE9d7YH8Aj7odXcXNkBoncjUGs0CBv/Q0P3bz/ur/Lgb4zOGoclG1v6hPx6fEU+0TKHuklVi1pttGixLbxppNjLqQqnEXJGywIR3mnITeJeIkUOPaBFAMZ9TZshAVlQJW6M0W+L5TYUeI2ZBBeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qqrxn9oU; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58T8djGI2642312;
	Mon, 29 Sep 2025 03:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759135185;
	bh=WmjriLKM6CWc2Dcf+e4Tl37Kp0aXaSv9AkJHr17d4jM=;
	h=From:To:CC:Subject:Date;
	b=qqrxn9oUYMUUDQRiv0mb3nxmg6QOc/Oe5dbkyuVVBg4fTsZ9vE5CwEuWDafdDLYM7
	 B4CtlfbT+i70KFoC3NYAIEa8aKiAQfDx1qxpwhbpqqSdDEn9iukzDQd0mLoSYrUaLa
	 tIUyt2OjfscKUHpgWRaK6H60MEjky86QTkAUC6vI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58T8di4p2995694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 29 Sep 2025 03:39:44 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 29
 Sep 2025 03:39:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 03:39:44 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58T8daaN927539;
	Mon, 29 Sep 2025 03:39:37 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
        <andy.yan@rock-chips.com>, <mordan@ispras.ru>, <linux@treblig.org>,
        <viro@zeniv.linux.org.uk>, <aradhya.bhatia@linux.dev>,
        <javierm@redhat.com>, <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>
CC: <lyude@redhat.com>, <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 0/6] MHDP8546 fixes related to DBANC usecase
Date: Mon, 29 Sep 2025 14:09:30 +0530
Message-ID: <20250929083936.1575685-1-h-shenoy@ti.com>
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

With the DBANC framework, the connector is no longer initialized in 
bridge_attach()when the display controller sets the 
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag. 
This causes a null pointer dereference in cdns_mhdp_modeset_retry_fn() 
when trying to access &conn->dev->mode_config.mutex. 
Observed on a board where EDID read failed. 
(log: https://gist.github.com/Jayesh2000/233f87f9becdf1e66f1da6fd53f77429)

The series addresses this by first removing the unused legacy connector 
initialization, then switching the driver to consistently use 
drm_connector pointers and ensuring the pointer is set during 
atomic enable so recovery paths like modeset_retry_fn() work correctly. 
Once that is in place, mode validation is moved into the bridge through a 
new bridge_mode_valid() hook to reject invalid modes, 
since the connector helpers are no longer available. 

Patches 1,2 do necessary cleanup and alignment and patches 3,4 fix
the actual bug introduced in driver by commit id which enabled the DBANC flag.
The rationale behind the sequence of commits is we can cleanly 
switch to drm_connector pointer after removal of connector helper 
code blocks, which are anyways not touch after DBANC has been 
enabled in driver.

The later patches make smaller adjustments: lowering the log level for
noisy DPCD transfer errors and moving HDCP state handling into the bridge 
atomic check in line with the DBANC model.

v6 patch link:
<https://lore.kernel.org/all/20250909090824.1655537-1-h-shenoy@ti.com/>

Changelog v6-v7:
-Update cover letter to explain the series.
-Add R/B tag in PATCH 1 and drop fixes tag as suggested.
-Drop fixes tag in PATCH 2.
-Update the commit messages for clear understanding of changes done in patches.

v5 patch link:
<https://lore.kernel.org/all/20250811075904.1613519-1-h-shenoy@ti.com/>

Changelog v5 -> v6:
-Update cover letter to clarify the series in better way.
-Add Reviewed-by tag to relevant patches.
 
v4 patch link: 
<https://lore.kernel.org/all/20250624054448.192801-1-j-choudhary@ti.com>

Changelog v4->v5:
- Handle HDCP state in bridge atomic check instead of connector 
atomic check
 
v3 patch link:
<https://lore.kernel.org/all/20250529142517.188786-1-j-choudhary@ti.com/>

Changelog v3->v4:
- Fix kernel test robot build warning:
  <https://lore.kernel.org/all/202505300201.2s6r12yc-lkp@intel.com/>

v2 patch link:
<https://lore.kernel.org/all/20250521073237.366463-1-j-choudhary@ti.com/>

Changelog v2->v3:
- Add mode_valid in drm_bridge_funcs to a separate patch
- Remove "if (mhdp->connector.dev)" conditions that were missed in v2
- Split out the move of drm_atomic_get_new_connector_for_encoder()
  to a separate patch
- Drop "R-by" considering the changes in v2[1/3]
- Add Fixes tag to first 4 patches:
  commit c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
  This added DBANC flag in tidss while attaching bridge to the encoder
- Drop RFC prefix

v1 patch link:
<https://lore.kernel.org/all/20250116111636.157641-1-j-choudhary@ti.com/>

Changelog v1->v2:
- Remove !DRM_BRIDGE_ATTACH_NO_CONNECTOR entirely
- Add mode_valid in drm_bridge_funcs[0]
- Fix NULL POINTER differently since we cannot access atomic_state
- Reduce log level in cdns_mhdp_transfer call

[0]: https://lore.kernel.org/all/20240530091757.433106-1-j-choudhary@ti.com/

Harikrishna Shenoy (1):
  drm/bridge: cadence: cdns-mhdp8546-core: Handle HDCP state in bridge
    atomic check

Jayesh Choudhary (5):
  drm/bridge: cadence: cdns-mhdp8546-core: Remove legacy support for
    connector initialisation in bridge
  drm/bridge: cadence: cdns-mhdp8546*: Change drm_connector from
    structure to pointer
  drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector
    earlier in atomic_enable()
  drm/bridge: cadence: cdns-mhdp8546-core: Add mode_valid hook to
    drm_bridge_funcs
  drm/bridge: cadence: cdns-mhdp8546-core: Reduce log level for DPCD
    read/write

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 258 +++++-------------
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |   8 +-
 3 files changed, 72 insertions(+), 196 deletions(-)

-- 
2.34.1


