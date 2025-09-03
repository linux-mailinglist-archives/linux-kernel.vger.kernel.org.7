Return-Path: <linux-kernel+bounces-798259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD1B41B60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B68C189908A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7732EDD5E;
	Wed,  3 Sep 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LJoHRHjv"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2272E7F0E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894202; cv=none; b=VZwNuuHZnwAmyXR0/42F7B271OPFn99Vw/Mi7elPDYuNN8cp8grD/uJiIjRsWRpkbu5OInPpQT7pLBdw9u/hNShKcvGGozh/eiUy1Jz+eh8frw4h+Iqjd1/Xl8+HO+OFXK81L0LkwFsqk1rVEsrXrnZTZOJxVh4BWm9DEXGH6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894202; c=relaxed/simple;
	bh=7hcJtoKz96MP1kleoQGPKalCRs8nLg3KPAVtTQpBByA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nM5kmmjuWIlFRQp1RAwXHf1znimVSPNz8AwKdhTnNtOLcnykYiHOwZVDlGJe4Hz6BA98yBdxNqr0SuTzdTuC7bFtl2dY1VCyEq1w8FLc745X5rHFwgC1cSC84Aq7LlcrgSIKqd0aale5WPAtfsRh11bmjcJ1RvE1FH5jbg0yihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LJoHRHjv; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583A9YU73203122;
	Wed, 3 Sep 2025 05:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756894174;
	bh=slRkOAjbwsQJ9PNnE2zqAAP48jTqeSs0ZLjOG/bAxJU=;
	h=From:To:CC:Subject:Date;
	b=LJoHRHjv6/oJwER7btyTVw99cg1zYCh6N7ADhJC1xMJ9FAsyPe+0WNiEEtFnDBRVD
	 fSTPN2NAJa4x3wEWbTEUeQmMdNDglbdTkVMwNoE2zerL18EhZa8lV5TmfKNmvcvw5e
	 M10Js9UNgA2502bsWxVC8AiP9VdqYjmzhGP5QCjY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583A9YWW3523442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 05:09:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 05:09:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 05:09:33 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583A9TG11114995;
	Wed, 3 Sep 2025 05:09:30 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <bparrot@ti.com>, <sam@ravnborg.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <h-shenoy@ti.com>
Subject: [PATCH] drm/tidss: Update Videoport SYNC LOST IRQ bit
Date: Wed, 3 Sep 2025 15:39:29 +0530
Message-ID: <20250903100929.2598626-1-h-shenoy@ti.com>
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

Update VP SYNC LOST Bit as per register description for
DSS0_COMMON_VP_IRQENABLE_0 give in TRM.

Link:https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
Table 12-597. DSS0_COMMON_VP_IRQENABLE_0

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")

Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 drivers/gpu/drm/tidss/tidss_irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_irq.h b/drivers/gpu/drm/tidss/tidss_irq.h
index dd61f645f662..0194010a7fff 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.h
+++ b/drivers/gpu/drm/tidss/tidss_irq.h
@@ -53,7 +53,7 @@ static inline dispc_irq_t DSS_IRQ_PLANE_MASK(u32 plane)
 #define DSS_IRQ_VP_FRAME_DONE(ch)	DSS_IRQ_VP_BIT((ch), 0)
 #define DSS_IRQ_VP_VSYNC_EVEN(ch)	DSS_IRQ_VP_BIT((ch), 1)
 #define DSS_IRQ_VP_VSYNC_ODD(ch)	DSS_IRQ_VP_BIT((ch), 2)
-#define DSS_IRQ_VP_SYNC_LOST(ch)	DSS_IRQ_VP_BIT((ch), 3)
+#define DSS_IRQ_VP_SYNC_LOST(ch)	DSS_IRQ_VP_BIT((ch), 4)
 
 #define DSS_IRQ_PLANE_FIFO_UNDERFLOW(plane)	DSS_IRQ_PLANE_BIT((plane), 0)
 
-- 
2.34.1


