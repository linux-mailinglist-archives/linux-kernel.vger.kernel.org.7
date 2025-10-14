Return-Path: <linux-kernel+bounces-852257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A21BD88AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57821923C84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD44308F1D;
	Tue, 14 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="baVjpEAT"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD1302759
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435199; cv=none; b=J9C/tOoiPJ0CgQBFQOLFhyuKABP4EDGeClAO0O0/AslWD6I5ymzCx8YIVH/rpD2gNpwtAG4R56eM/2VDyuoIJVk87YvwuotGSin7NVc30KJPK1lhAvfUFTora06f2UkqMRKT4e9IbWywxv8MRZkGNmcb5TMXy6q0aZGFQkimPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435199; c=relaxed/simple;
	bh=BKX/SEHvoqDXgROfbL946L/5jV3H1dHhUIwtC0pjs9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YmKpowy5X20224X7Kg2VG5ELZp/dXpb5kz7DR9mtUDES05yl4EuGBo1CMGIQT9hsdzomFqzR2wNDXk2kyPMPOLTnrKYM4y8qtC8ypAIzceAREQQEz75B5aXymeqt3j6/b68KP1v67paWyIfKC7BNCml75gAT8HYNjvCfvgFzPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=baVjpEAT; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9jbc51039155;
	Tue, 14 Oct 2025 04:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760435137;
	bh=xJnpH64WIbJe4VECnuRUSab/bQa0ZTRtjedXiSHIiuQ=;
	h=From:To:Subject:Date;
	b=baVjpEATAQ1wSdDfdY1SG7MvqIj5c45fMXzj4TOibVfVSDqjzJOmFs4Pt9Pcg2jnR
	 bewC+ZxD/Rpvc3wpqNB5m4s4pEtnpa7fFkEe0TYo4Hsw/QCPyeZun+5eRqbNIezak7
	 Ol4bgmcQ0UW8/KUYK3GCHWfjROZYikL7ALpCSSAw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9javR350621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 04:45:36 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 04:45:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:45:35 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9jSjS3359281;
	Tue, 14 Oct 2025 04:45:29 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
        <andrzej.hajda@intel.com>, <andy.yan@rock-chips.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <javierm@redhat.com>,
        <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
        <linux-kernel@vger.kernel.org>, <linux@treblig.org>,
        <luca.ceresoli@bootlin.com>, <lumag@kernel.org>, <lyude@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <mordan@ispras.ru>,
        <mripard@kernel.org>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <s-jain1@ti.com>, <simona@ffwll.ch>, <tomi.valkeinen@ideasonboard.com>,
        <tzimmermann@suse.de>, <u-kumar1@ti.com>
Subject: [PATCH v8 0/6]  MHDP8546 fixes related to DBANC usecase
Date: Tue, 14 Oct 2025 15:15:21 +0530
Message-ID: <20251014094527.3916421-1-h-shenoy@ti.com>
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

Patch 1 adds a connector_ptr which takes care of both 
DBANC and !DBANC case by setting the pointer in appropriate hooks
and checking for pointer validity before accessing the connector.
Patch 2 adds mode validation hook to bridge fucntions.
Patches 3,4 do necessary cleanup and alignment for using
connector pointer.

The rationale behind the sequence of commits is we can cleanly 
switch to drm_connector pointer after removal of connector helper 
code blocks, which are anyways not touch after DBANC has been 
enabled in driver.

The later patches make smaller adjustments: lowering the log level for
noisy DPCD transfer errors and moving HDCP state handling into the bridge 
atomic check in line with the DBANC model.

v7 patch link:
<https://lore.kernel.org/all/20250929083936.1575685-1-h-shenoy@ti.com/>

Changelog v7-v8:
-Move patches with firxes tag to top of series with appropriate changes
to them.
-Add R/B tag to patch 
https://lore.kernel.org/all/ae3snoap64r252sbqhsshsadxfmlqdfn6b4o5fgfcmxppglkqf@2lsstfsghzwb/

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
  drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector
    earlier in atomic_enable()
  drm/bridge: cadence: cdns-mhdp8546-core: Add mode_valid hook to
    drm_bridge_funcs
  drm/bridge: cadence: cdns-mhdp8546-core: Remove legacy support for
    connector initialisation in bridge
  drm/bridge: cadence: cdns-mhdp8546*: Change drm_connector from
    structure to pointer
  drm/bridge: cadence: cdns-mhdp8546-core: Reduce log level for DPCD
    read/write

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 258 +++++-------------
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |   8 +-
 3 files changed, 72 insertions(+), 196 deletions(-)

-- 
2.34.1


