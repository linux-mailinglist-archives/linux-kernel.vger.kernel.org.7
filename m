Return-Path: <linux-kernel+bounces-826016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D07B8D55F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014A04E02AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1B25C6FF;
	Sun, 21 Sep 2025 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vC6Da8Tv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B7236A8B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758434089; cv=none; b=GW6Wz+gjHJ+PugxrfemGhjI7xf1XhXCFmfElyLTIvku1eqbiUgU/hlaLAtSx1dTB+EkhtEoEau3CJ66TPBQZvS2ARUTbMJDANS2907wuzJr3ix3tLyc/KDSdFu40AmTKyBZwSRa9lyC+bLD4szXKHKAZf7Uli8Ndwa9fnv98Xeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758434089; c=relaxed/simple;
	bh=8icpVoeO2bk7wCxtD3XszqXP8P9uhjGLSLvLKlZiSMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PK0TyrRTvePVf6tRLaYNTfrZPhcQTdDNr9WuD1sEum0F9LBblE+ilFbKJWTBcFXxlbrulfGxQLDGaKFCzPXv7ForarUWBBiz6YYz3GNqrYwUkt7a5+/r2ss4oH9axpXauENluFpwgKtA4ueuTKwGodDeNNL0u+kyoY0rW71VND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vC6Da8Tv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 776df61e96af11f08d9e1119e76e3a28-20250921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BNy9JUEk5SM7ujHcWVu+qwus9vysipdIfL068MRHlUw=;
	b=vC6Da8TvSReux9uhI3O4l9xiuqUyx7CWiajFQbYI9moKnVNZQ6JrdplQx71pIZ0PT3eTNdYsrTfS7bkR+eD5LrIHbdBi4vGywWpQNG91SCK+tD03SMdL8LOKtH853go3OUa+50yBvoTakUOMi9x9vSeovcSOYCFvRrfsNNRr9OQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:519f55ae-461e-4d43-b58e-6e38231563aa,IP:0,UR
	L:0,TC:0,Content:82,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:107
X-CID-META: VersionHash:1ca6b93,CLOUDID:bd3785f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:4|15|5
	0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 776df61e96af11f08d9e1119e76e3a28-20250921
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1984071481; Sun, 21 Sep 2025 13:54:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 21 Sep 2025 13:54:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Sun, 21 Sep 2025 13:54:39 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yongqiang Niu <yongqiang.niu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Jay
 Liu <jay.liu@mediatek.com>
Subject: [PATCH v1 0/1]  Support color matrix negative input
Date: Sun, 21 Sep 2025 13:53:04 +0800
Message-ID: <20250921055416.25588-1-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Change in v1:
- replace mtk_ctm_s31_32_to_s1_n with drm_color_ctm_s31_32_to_qm_n.

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jay Liu (1):
  drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n function issue

 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 26 +++--------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

-- 
2.46.0


