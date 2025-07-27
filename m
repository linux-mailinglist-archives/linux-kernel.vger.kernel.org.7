Return-Path: <linux-kernel+bounces-746990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D688BB12DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7180848011B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795F7155326;
	Sun, 27 Jul 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jVYaZ339"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90157263B;
	Sun, 27 Jul 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753600592; cv=none; b=mmpAmppOZkxIx6X9cGVRI/0DVp54Z2mZm2GK8UUbB2Uapp+W4BC12IrGYYBvMk+YFruCFNeCEXylherCxkxiFpiash77EDzBj6Guo+bcYonEr+3EDuDdka4jRCzkP7RzNUHBdmEWPAcJhRvpfz3vdL5ZmHfGDum4+4LVbQA3K8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753600592; c=relaxed/simple;
	bh=Zg/zGC9ClDlS/GkHS27vHrKW3M3e2ATN7M/J6nVooTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkA8CMguLR0U2IUm7PrYnkBdskjXajz+/YxcjNTAW6SVTGcTvV7K1kLs8nM9vmHJvByxEosgoSeXvovNoEZh+A8MXBxpncn0NcsBKaUo+oU4olSaCOZmDpuYokW5bY/1XQxpIUNQQjGitkzejmyP8H4wF/8Ukm9COQMYQaow42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jVYaZ339; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 968f79406ab911f0b33aeb1e7f16c2b6-20250727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=P2axRt7kp87WizBRx7EY7gZVCvOymR2hXiii9+E/OHk=;
	b=jVYaZ339EmIYINjHEHF6WTvQPH9YokUnGYuklbrNGM3FW9zzEPpL3IhmU4X+1kJVhrMxNn5H4HAAeNwN+4f7FCo8KWyia4INv0uqnc7OssLxrM4G6lYk8QShRgzgra2TcA7MYfJ1TTDvSf7OzhUmhGB7++g8gaUFs7TJ2aVnMQ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:fc5b87d7-ba67-4ccd-9ab1-402e0f4192d1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:475dd208-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 968f79406ab911f0b33aeb1e7f16c2b6-20250727
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 957084052; Sun, 27 Jul 2025 15:16:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 27 Jul 2025 15:16:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 27 Jul 2025 15:16:13 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Jay Liu <jay.liu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hsin-Yi
 Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/7] porting pq compnent for MT8196
Date: Sun, 27 Jul 2025 15:15:50 +0800
Message-ID: <20250727071609.26037-1-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: 20220315152503 created <jay.liu@mediatek.com>

add ccorr/dither/gamma/tdshp support for MT8196

Change in v2:
- Modify the ccorr driver code to optimize the ctm_set process and avoid affecting other ICs.
- Modify the tdshp driver code to remove unnecessary code.
- Update the dt-bindings of tdshp, including clocks, description, examples, etc.

This patch series id base on [1]
[1] Add components to support PQ in display path for MT8196
    - https://patchwork.kernel.org/project/linux-mediatek/list/?series=955361
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jay Liu (7):
  drm/mediatek: Add CCORR component support for MT8196
  drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n function issue
  drm/mediatek: Add TDSHP component support for MT8196
  dt-bindings: display: mediatek: disp-tdshp: Add support for MT8196
  dt-bindings: display: mediatek: ccorr: Add support for MT8196
  dt-bindings: display: mediatek: dither: Add support for MT8196
  dt-bindings: display: mediatek: gamma: Add support for MT8196

 .../display/mediatek/mediatek,ccorr.yaml      |  1 +
 .../display/mediatek/mediatek,disp-tdshp.yaml | 50 ++++++++++++++++++
 .../display/mediatek/mediatek,dither.yaml     |  1 +
 .../display/mediatek/mediatek,gamma.yaml      |  1 +
 drivers/gpu/drm/mediatek/mtk_crtc.c           |  5 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 52 ++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  8 +--
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     | 30 +++--------
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +
 10 files changed, 122 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml

-- 
2.46.0


