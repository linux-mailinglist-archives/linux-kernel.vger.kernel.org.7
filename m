Return-Path: <linux-kernel+bounces-729856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86967B03C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C713BF651
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273F248881;
	Mon, 14 Jul 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PaagJttp"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063ED70823
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490021; cv=none; b=EiZPwoufeggUNUDW13QKkCPGrKVA3aIHWxKFcW4zewhY7/Rj05AMVd9e/nQhqPXg0DQwrzVL+cnG4tTQ9hjE9crtEkCFUTElBAVUJywejoxOMB0fqOsv98OaOjHx5mOcE3GqxCePydJoZVYxwrUVHGtHU0Z/aMrXO07VGPrIBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490021; c=relaxed/simple;
	bh=reGFruFMD+9IgOWfO/vcgksgOd2xdGFSFmKl9mVo3Ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNvxiLPSrJ6Ds3QYRJIZ8tKXSiSFqtSmlUoJ4DbV+asDBMLFd/zwVMVyC9GO5FpIluXY1LaH316d9Eqmvz+hSeLHmVAVrkbTvFfeXJlAAiozmwALVzTUn6Qio3CISmIBVBelx1K+dlOERfbgyAzjJ1sv2nGyk9PBv9EVyvdUhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PaagJttp; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56EAjuC92359657;
	Mon, 14 Jul 2025 05:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752489956;
	bh=m9QGcwxg2jM0MyzOfa5/VcVbOr2DjOXlGp1SoOM/jGg=;
	h=From:To:CC:Subject:Date;
	b=PaagJttpryxkfDKIfdNpGK868g02zbRac54K8tC0O5nbFD97bNWPcExm0Ju+mYgZh
	 UvgcGBehoVygS6cmMdAOQi8lIkdB6pyKnU5jp7MJaTqhQO2r2SL+s007oTx1njJ1to
	 WxyMd2xXFJnXlgpyzXvWX8Mnin6lhNqBHuqGTyp0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56EAjtYH265538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 14 Jul 2025 05:45:55 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 05:45:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 05:45:55 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56EAjsRY409568;
	Mon, 14 Jul 2025 05:45:55 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <jyri.sarha@iki.fi>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <devarsht@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <mwalle@kernel.org>,
        <aradhya.bhatia@linux.dev>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2] drm/tidss: oldi: convert to devm_drm_bridge_alloc() API
Date: Mon, 14 Jul 2025 16:15:54 +0530
Message-ID: <20250714104554.13441-1-j-choudhary@ti.com>
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

DRM bridges now use "devm_drm_bridge_alloc()" for allocation and
initialization. "devm_kzalloc()" is not allowed anymore and it results
in WARNING. So convert it.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Changelog v1->v2:
- Fix typo in commit message
- Put the oldi parent and child node in case of error before returning
  (as pointed out by Aradhya in v1)
- Pick up "R-by" tags

v1 patch link:
<https://lore.kernel.org/all/20250701055002.52336-1-j-choudhary@ti.com/>

 drivers/gpu/drm/tidss/tidss_oldi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 8223b8fec8ce..8f25159d0666 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -534,9 +534,10 @@ int tidss_oldi_init(struct tidss_device *tidss)
 			continue;
 		}
 
-		oldi = devm_kzalloc(tidss->dev, sizeof(*oldi), GFP_KERNEL);
-		if (!oldi) {
-			ret = -ENOMEM;
+		oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
+					     &tidss_oldi_bridge_funcs);
+		if (IS_ERR(oldi)) {
+			ret = PTR_ERR(oldi);
 			goto err_put_node;
 		}
 
@@ -577,7 +578,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		/* Register the bridge. */
 		oldi->bridge.of_node = child;
 		oldi->bridge.driver_private = oldi;
-		oldi->bridge.funcs = &tidss_oldi_bridge_funcs;
 		oldi->bridge.timings = &default_tidss_oldi_timings;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;
-- 
2.34.1


