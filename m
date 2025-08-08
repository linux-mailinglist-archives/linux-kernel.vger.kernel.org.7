Return-Path: <linux-kernel+bounces-760076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12DB1E63B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EB57A2B53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA85273D86;
	Fri,  8 Aug 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XuYDVq6/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4D272E7F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648007; cv=none; b=azCVmoL7Vs+5nqb5kuNmoaQmeFTqfd3kxU6OCADiurBCTycsi2v1XqIZNzhODlyrIjEVuqRrsrgxxxiyGvFpjv/j4gNwQwvsKpcVrANyzyd7SLMcjLNZjSgpTReXmyyGp0PIjHakWfutvgeqxdd77uTbagfeJC0se1q/TCIqZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648007; c=relaxed/simple;
	bh=nf5h1lNpleNGuRl1UxQ6idA0pn7vVFi/xWcII3JgkvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaZpamnNmW+JuNXwTcwSiknR0PFc8ivgAQsuryp/o2V1anrQzyCHSlKBA8hfGJ6MR3TGWX6P9PQeu04R4S8K6HBN/7+0k6Tb97msBknxfAos4HFi3ROKSEMaEc4kvkz93WLFwneGqKjF2I2gBrOJIm9gW+QebnpNHNvBv6Pr1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XuYDVq6/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754648004;
	bh=nf5h1lNpleNGuRl1UxQ6idA0pn7vVFi/xWcII3JgkvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XuYDVq6/PUBXKvt3WdNPtCfXSv4tMht8of1SsoVik+9NJ5S/vHMf6l7gb1q18868I
	 9DhUPo0FRvCGigq/EQPqzEdB1QQ4pld6GSpz1XVoV1kp6412nvsWxNnzuU8FKo0oMq
	 mzDav6+6WyCEJuLMjFgF558IGVtUGILBTHiRVB/FtdZgeroFEfGTp5tTpvoL2Yh9Nd
	 T8m4FqgLYFst8hOUioJkq2PYxvVxXyERyujf3X6Rm1Bmpe3b5OTTXq6wqKgGGwLDyY
	 a241oSry5VW8i7wfae1/Z33+vas8Gl7xj/2W39w1AIa/SPL5Jrkzvtyq1Mu9jCPHtv
	 +IltMkW0+h4Sw==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7282A17E0109;
	Fri,  8 Aug 2025 12:13:23 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 08 Aug 2025 12:12:11 +0200
Subject: [PATCH v10 01/10] drm/mediatek: mtk_hdmi: Drop redundant clock
 retrieval in mtk_hdmi_get_cec_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-mediatek-drm-hdmi-v2-v10-1-21ea82eec1f6@collabora.com>
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754648002; l=1400;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=nf5h1lNpleNGuRl1UxQ6idA0pn7vVFi/xWcII3JgkvM=;
 b=edtZnff7qnJqLIBEeReiUZ3kiy09NLgimvwuBq5wQ79sQzHm3ZXeENMSPSenFakreoHXYmvKo
 gd72/k1VvXQAN8FvRYOSVpLWs49UZE54EPel+NIRSxQpKV9o2jz+NHW
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In mtk_hdmi driver, when the CEC device parsing logic was moved from
mtk_hdmi_dt_parse_pdata function to the new mtk_hdmi_get_cec_dev sub
function, the call to mtk_hdmi_get_all_clk was kept in both functions,
whereas it was only called once in the original mtk_hdmi_dt_parse_pdata
code and does not need to be called a second time.
So, remove this call from mtk_hdmi_get_cec_dev to keep the same sequence
as previously.

Fixes: 7485be967f7f ("drm/mediatek: mtk_hdmi: Move CEC device parsing in new function")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 845fd8aa43c3c91659808d9e6bb78758d1f9b857..0ac4e755bdf8aace766feffa57712a8fbf4ff791 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1349,11 +1349,6 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 {
 	struct platform_device *cec_pdev;
 	struct device_node *cec_np;
-	int ret;
-
-	ret = mtk_hdmi_get_all_clk(hdmi, np);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");

-- 
2.50.1


