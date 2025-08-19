Return-Path: <linux-kernel+bounces-775270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB89CB2BD68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10191BC4ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715C31AF1F;
	Tue, 19 Aug 2025 09:25:57 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE831AF1D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595557; cv=none; b=BlIUdwHQa8UufdWuiDNwzH3lffLtaVcuORhlsf2zJHp/FQBaL1UjSHUN7rR0vQ+hhCzqHe0dyDiNx+se8HTQ2MQADY2fb9cvxV9ePTVpZKeEeoJlEDJqjHJ3vgA3HrwqnYjD2h3SF3n3FfDHdLpF95mZ8xePqusSZqMj30Bch7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595557; c=relaxed/simple;
	bh=z/Zo0uVMOkZx3+nxUfBN34AH2w2JXvRGXA8IHP/N2aM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=FM3EedIEMIpbBKWTe6UN8ANq6PfmsDQ+4REz3ltdHc6CgM4CFida0nrRw7aYdNu7ZBDFqBI/tDRpuwhWa9C7HwpC/sAVorDkFDxawxI/vg8LMC4pDDt3PDSdd9pi4dLi2OT+iYBgtQXqtgwMJ/BMHazIdmMftkSL45d5IYduGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c5khn5n3Mz6G42S;
	Tue, 19 Aug 2025 17:25:45 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 57J9POZx082163;
	Tue, 19 Aug 2025 17:25:24 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 19 Aug 2025 17:25:26 +0800 (CST)
Date: Tue, 19 Aug 2025 17:25:26 +0800 (CST)
X-Zmail-TransId: 2afc68a44306ffffffffbba-845b4
X-Mailer: Zmail v1.0
Message-ID: <20250819172526465q0DlaK4mMznBXD0SIjXKm@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <chunkuang.hu@kernel.org>
Cc: <p.zabel@pengutronix.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vbWVkaWF0ZWs6IG10a19kcm1fZHJ2OiBzd2l0Y2ggdG8gdXNlIGRldm1fa21lbWR1cF9hcnJheSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57J9POZx082163
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 19 Aug 2025 17:25:45 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A44319.002/4c5khn5n3Mz6G42S

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use devm_kmemdup_array() to avoid multiplication or possible overflows.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index d5e6bab36414..e700c0f0a3a2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1003,7 +1003,8 @@ static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path
                return -EINVAL;
        }

-       final_ddp_path = devm_kmemdup(dev, temp_path, idx * sizeof(temp_path[0]), GFP_KERNEL);
+       final_ddp_path = devm_kmemdup_array(dev, temp_path, idx,
+                                           sizeof(*temp_path), GFP_KERNEL);
        if (!final_ddp_path)
                return -ENOMEM;

-- 
2.25.1

