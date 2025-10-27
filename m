Return-Path: <linux-kernel+bounces-872601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B3C118E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9838403189
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2B32B981;
	Mon, 27 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YsZVu58N"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F944328638
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600433; cv=none; b=Gt4oG4+et0bWdDxvC4TquWo0uoPifegsOYiV77TunKkAupNKmbjdWUhyUmwW/phPdWOJ/DEcL2ufvW4f9KJGA9rqq3V8eD+o2Rfw34T4CHJllzFoCcR3stUdE7AH33mtNUvb6SxSfRGsvP2/n4ZhLxqgazTXmLSw7cfZmO+MzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600433; c=relaxed/simple;
	bh=S7lxwQ/+I8o8T3Zvl8AGIl5zNm5XYyT8gZP/qwSMjvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZU9xqD8AlcoE/ulSfoe24Pd+UO8vcYv7h9vixzHozUKBPNAIb5mCLEqTW4HiSFsauK8FhtkX7ptNjNX0ZzIND5szs3+RC4nWl56/K38AFvMsMuBTufF5kySEgeeuMe4OJ7w7wCB1nZeHSaOw2tzLGCNYE7NIRQK3ucRYfK34I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YsZVu58N; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RLQUC02490408;
	Mon, 27 Oct 2025 16:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761600390;
	bh=3LA3zzpEcmHb6DEIkmkNwmCkfljv4gF+vsBJrx99r1E=;
	h=From:To:CC:Subject:Date;
	b=YsZVu58NApL89IAL7H2XCCHl8h/e3BDDLdxKeTZOsrWfmc+47Bc80G9ptBrW0ubJK
	 pJB/7tiAAEuiN7vZdUinG5SofQZarvzPJD+vcCyfjVLh62z490F5LlQPmZso26T+/d
	 5ACaBS8AZu7up0BRLh1I4QzF7pzMsZKxJRHhHapI=
Received: from DLEE208.ent.ti.com (dlee208.ent.ti.com [157.170.170.97])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RLQUOL1491660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 16:26:30 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 16:26:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 16:26:30 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RLQP5k1301370;
	Mon, 27 Oct 2025 16:26:26 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <mripard@kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <jyri.sarha@iki.fi>,
        <maarten.lankhorst@linux.intel.com>, <simona@ffwll.ch>,
        <airlied@gmail.com>, <tzimmermann@suse.de>, <h-shenoy@ti.com>
CC: <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <s-jain1@ti.com>
Subject: [PATCH v7 0/2] Decouple max/min_pclk_khz check from constant display feats
Date: Tue, 28 Oct 2025 02:56:22 +0530
Message-ID: <20251027212624.359235-1-s-jain1@ti.com>
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

---
Changelog v6->v7
- Remove both max/min_pclk_khz as suggested by Tomi
- Use mode_valid() instead of atomic_check()
- Squash patches v6 PATCH 1/3 and PATCH 2/3 which is a fix to OLDI
  series[1]
- Minor fixes in commit message
- Update comments to include more reasoning to add Fixes tag to
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


