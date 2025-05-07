Return-Path: <linux-kernel+bounces-638628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E9AAE874
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 20:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E6C4C82AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672628DF41;
	Wed,  7 May 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8ztvkVO"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3C28DF30;
	Wed,  7 May 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641246; cv=none; b=N6TCYWvV1acbF7k1cna1i0QdvIoKZgs+nWDzpEnsSUyy7Gs4rrKbyxp2lO6NZ7OHpAOrQ/vvb5We0Q5B/WCU6sIYfBDb6kfggrSruo+uXOrVuNxeAOmuw5eD4V1kERWziJPlqCiApu4aQVCYleLVlbh3pZmz9ByZWFslB0q9FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641246; c=relaxed/simple;
	bh=OKmzj21Cc9pdlcW2y3OgR3ibFf15z7JPAO4FnsN12ww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twCmDoNaj/JfBX3tOKS4CjVq6vBHp1H1hHlG7zjO4kQIvMDH6c0ce1/MSmOfowI2nzKVDIYny8MVcp4dnTp+csk3ShaKzZxD7KtO2MtENy/jXICFV6EHGMUKlmx07LFc+4oIaXdl3mts5uK/hF3TzqmnueqGDXRktXzNHmoEGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s8ztvkVO; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 547I6Ymj1446487
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 13:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746641194;
	bh=NVe4a+S5FD4l79SJhGfpOjn4VnAuMASZshHPHhAg66s=;
	h=From:To:CC:Subject:Date;
	b=s8ztvkVO9b+DjRaJsiPipKMq1rNpIAwkiZ76GGJ+Be7rvGeFkGUiP1sr5S/ni+AjY
	 5HEH0E6quR5Cqa8b7LfxbQyhSGN+v8wFZVd3ZHOayY/ef3ywu3ZJpS43aLS1itw//H
	 Lq3qtbUUYDvQnk8300eAAo2Sw8WKtFPMQ+A/uVg8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 547I6Y55115176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 May 2025 13:06:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 13:06:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 13:06:33 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 547I6WY2035911;
	Wed, 7 May 2025 13:06:32 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <j-choudhary@ti.com>,
        <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH v6 0/3] Add support for AM62L DSS
Date: Wed, 7 May 2025 23:36:28 +0530
Message-ID: <20250507180631.874930-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds support for DSS subsystem present in TI's AM62L SoC
which supports single display pipeline with DPI output which
is also routed to DSI Tx controller within the SoC.

Change Log:
V6: 
- Move hw_id indexing logic to skip uninstantiated planes to
  internal functions dealing with relevant registers

V5:
- Use hw_id instead of index for places where it was missed
  so that we pick correct base address for vid region

V4:
- Update vid_info struct to keep hw_id and instantiate
  only for actually existing pipes

V3:
- Make generic infra to support truncated K3 DSS IP's
- Remove AM62A updates from AM62L DT binding updates

V2:
- Fix incorrect format of compatible string (comma instead of
  hyphen) for AM62L SoC
- Use separate register space and helper functions for AM62L
  due to minor differences in register offset/bit position differences
  for first plane

Rangediff:
V5->V6:
- https://gist.github.com/devarsht/f64b00754794d22e57ac18ec09a7b019

V4->V5:
- https://gist.github.com/devarsht/a0e6aa7b1c19f47facd0058962e3c3c2

V3->V4:
- https://gist.github.com/devarsht/1e75c9e1ac0cdfc01703a0776e31e782

V2->V3:
- https://gist.github.com/devarsht/24fa8dd2986861efa431352d19ebbb41

V1->V2
- https://gist.github.com/devarsht/11d47f25ca9fea6976e6284330ddf443

Links to previous versions:
V5: https://lore.kernel.org/all/20250429143656.3252877-1-devarsht@ti.com/
V4: https://lore.kernel.org/all/20250326145736.3659670-1-devarsht@ti.com/
V3: https://lore.kernel.org/all/20250306132914.1469387-1-devarsht@ti.com/
V2: https://lore.kernel.org/all/20250204061552.3720261-1-devarsht@ti.com/
V1: https://lore.kernel.org/all/20241231090432.3649158-1-devarsht@ti.com/

Test logs:
https://gist.github.com/devarsht/09a5d64a507b7ccc096e857f122eda70

Devarsh Thakkar (3):
  dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS
  drm/tidss: Update infrastructure to support K3 DSS cut-down versions
  drm/tidss: Add support for AM62L display subsystem

 .../bindings/display/ti/ti,am65x-dss.yaml     |  21 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c           | 197 ++++++++++++++----
 drivers/gpu/drm/tidss/tidss_dispc.h           |  13 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |   1 +
 drivers/gpu/drm/tidss/tidss_kms.c             |   2 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |   2 +-
 7 files changed, 192 insertions(+), 48 deletions(-)

-- 
2.39.1


