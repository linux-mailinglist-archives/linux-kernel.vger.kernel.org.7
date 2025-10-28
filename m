Return-Path: <linux-kernel+bounces-872985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C48C12CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B027B463D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB027CCEE;
	Tue, 28 Oct 2025 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HUBJvcw/"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6B38DD8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622823; cv=none; b=Fx3+E5zpwzZnCbP3NgfegZyDbcWgrFMchJ/S00d2q01hNP6lKsAoOb8dlbvZ7CN8a6LC2PRgLmnhE57Fiz6+p06LnGkiBGdbJ0GBBa99iyXM7DXMzv2faX+QFK63uPlLPTe3ooH0JHEuc96dAwdiUntWjQBap93mma+7ce90buE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622823; c=relaxed/simple;
	bh=fJu3F6FScUeIBrZvUBrP2KlA9r+9+d+TtFmE/+TLPOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErsyGJ9LMkQ9J06m4miDRZ3lj3fz/rXEvdDEXv7q2hxfo2GXDxZiJyoul7o1wlsgHYwItnTVh4ai2Xhp+6HWZQnSPDakhlUeYheFbAGDTvSNfb4BA745+qoHjqB3eNb48ck0wGPvczQ36Y4P1k/J0anxhITOb1zefEYDLmJKvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HUBJvcw/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S3e4Rx2565428;
	Mon, 27 Oct 2025 22:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761622804;
	bh=GMHURBN9iy48Q2pZ0MQRELI66/qN4xOQu+Etl931CYw=;
	h=From:To:CC:Subject:Date;
	b=HUBJvcw/saG0sR1C3ga8ebAc/aE1FtXXrE8l0RhM5IEb0EDlSsY75wxsJBM8uPqwK
	 E8ieamrFikvNcNHepSYpYKcMCwqyfmXt6fSVtX5QSWWzXG70oveSMTmvXH++RES2gx
	 +QfRt0Mnc3wMdn1ODIUZ3HJH+xknbHVZwM2fLoAk=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S3e42P1393687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 22:40:04 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 22:40:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 22:40:03 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S3dxWS1685770;
	Mon, 27 Oct 2025 22:39:59 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <mripard@kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <simona@ffwll.ch>,
        <airlied@gmail.com>, <tzimmermann@suse.de>, <h-shenoy@ti.com>
CC: <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <s-jain1@ti.com>
Subject: [RESEND PATCH v7 0/2] Decouple max/min_pclk_khz check from constant display feats
Date: Tue, 28 Oct 2025 09:09:56 +0530
Message-ID: <20251028033958.369100-1-s-jain1@ti.com>
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
removing the max/min_pclk_khz form dispc_features structure and doing
the supported pixel clock checks using clk_round_rate().

Changes are fully backwards compatible.

- Remove max/min_pclk_khz and use clk_round_rate to validate modes
- Skip OLDI mode validate through dispc_vp_mode_valid and add
  mode_valid hook to validate modes for OLDI bridge in tidss_oldi.c

Note:
- Resend to have modification in the Changelog v6->v7, correct
  PATCH 2/3 -> PATCH 3/3
---
Changelog v6->v7
- Remove both max/min_pclk_khz as suggested by Tomi
- Use mode_valid() instead of atomic_check()
- Squash patches v6 PATCH 1/3 and PATCH 3/3 which is a fix to OLDI
  series[1]
- Minor fixes in commit message
- Update commit message to include more reasoning to add Fixes tag to
  Patch v7 2/2

[1]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/

v6 patch link:
https://lore.kernel.org/all/20250911110715.2873596-1-s-jain1@ti.com/

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

---

Jayesh Choudhary (2):
  drm/tidss: Remove max_pclk_khz and min_pclk_khz from tidss display
    features
  drm/tidss: Move OLDI mode validation to OLDI bridge mode_valid hook

 drivers/gpu/drm/tidss/tidss_dispc.c | 87 +++++++++++------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  3 -
 drivers/gpu/drm/tidss/tidss_drv.h   |  2 +
 drivers/gpu/drm/tidss/tidss_oldi.c  | 21 +++++++
 4 files changed, 55 insertions(+), 58 deletions(-)


