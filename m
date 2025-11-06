Return-Path: <linux-kernel+bounces-887851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63479C393C1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EEDE4F9F32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F662DF14A;
	Thu,  6 Nov 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bFjxqH2y"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1C2DC335;
	Thu,  6 Nov 2025 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409616; cv=none; b=EGuTHuzaVmIjT/MK5OA2xj1lPizTmbVZ4ivX56pnmOHCX/NFnnfm2Jrcd2kTdS1HTZB7tQxQkH3SAqyQmZkJA7uTEluZD8c9NK1LrAkEJf/+gEp7tXPKA3LHjoPAcRmevdnZygvUDk5BWsWz6MUsaGRPbgX+QomCbMVf8NuawSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409616; c=relaxed/simple;
	bh=BXZoes8qb+ddWqRUmHuSTiecVSfbN/OJb4lUAm+Wmp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAieFNYkb3iZai4K+KdR7zkC+ixereKgyED69JtQS9C2lloFjJqznfn6/vAvYJ29Dt14HfFtdtCyuk/+EtT8AU4S8B0mxuY1Dcvq4CxVHA0d21WeViPVpZJu0Tf/gYDOGj4CuCbpkvPSFplCjkno9ghbx+UvuioD42i7DV4E0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bFjxqH2y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b5d45636bad711f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NfzLEn4Dx7zjpsyLCO2muoknZUAztMUcfKYh7NswnrQ=;
	b=bFjxqH2yIzqEB/WhhiL2GYO7tminlBqX5HJn01QRPWBSykCJAPh0kvrXg8g4Cq1tpCStRuOE77s1z8LrFukVmcdQXuFyJuv3VTdXCTyOtf5uGx6DtStyv+goAj9oSZo+BmJ8xVsZNyZHSFtRgTm1ORri2c7YFcBT+K4WbV1TcTE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:86ab3d51-33d5-4d97-96dd-f168668cc3d5,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:e06e196b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:1,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b5d45636bad711f08ac0a938fc7cd336-20251106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <kyrie.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1786610002; Thu, 06 Nov 2025 14:13:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:13:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:13:25 +0800
From: Kyrie Wu <kyrie.wu@mediatek.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen
	<andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Kyrie Wu <kyrie.wu@mediatek.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Nicolas Dufresne
	<nicolas.dufresne@collabora.com>, Nathan Hebert <nhebert@chromium.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Irui Wang <irui.wang@mediatek.com>, George Sun
	<george.sun@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Yilong Zhou <yilong.zhou@mediatek.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Pietrasiewicz
	<andrzejtp2010@gmail.com>
Subject: [PATCH v5 0/8] Enable video decoder & encoder for MT8189
Date: Thu, 6 Nov 2025 14:13:15 +0800
Message-ID: <20251106061323.2193-1-kyrie.wu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This series have the follow changing:
Firstly add mt8189 video decoder compatible, profile and level to support
MT8189 kernel driver.
Secondly fix some bugs, including vp 4K profile2 and media device node
number bug.
Lastly, add mt8189 video encoder compatible.

This series has been tested with MT8189 tast test.
Encoding and decoding worked for this chip.

Patches 1-2 Add decoder compatible.
Patches 3 Add profile and level supporting.
Patches 4 Add core-only VP9 decoding supporting.
Patches 5-6 fix some bugs.
Patches 7-8 Adds encoder compatible.

---
H264 test results:
./fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0 -j2 -t 90
    JVT-AVC_V1	Ran 96/135 tests successfully

VP9 test results:
./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -j2 -t 90
	VP9-TEST-VECTORS	Ran 276/305 tests successfully

v4l2-compliance test results:
Compliance test for mtk-vcodec-enc device /dev/video2:
Total for mtk-vcodec-enc device /dev/video2: 47, Succeeded: 46, Failed: 1, Warnings: 0
Compliance test for mtk-vcodec-dec device /dev/video3:
Total for mtk-vcodec-dec device /dev/video3: 48, Succeeded: 48, Failed: 0, Warnings: 0

scp upstream link:
https://patchwork.kernel.org/project/linux-mediatek/patch/20250811015922.32680-1-huayu.zong@mediatek.com/
dtsi upstream link:
https://lore.kernel.org/linux-mediatek/20251030134541.784011-12-jh.hsu@mediatek.com/T/#m847e35de0a5b18fac0ca0624a8559d84964ad5c7

Changes compared with v4:
--update H264 & vp9 fluster test results
--update vp9 single core decoder prob size setting and commit messages

Changes compared with v3:
--add reviewer to commit messages
--Rebased on top of the latest media tree

Changes compared with v2:
--add H264 fluster test results
--reorder compatible string for dt-bindings

Changes compared with v1:
--add v4l2-compliance test results
--add scp upstream link
--add HW difference discriptions for dt-bindings commit messages

This series patches dependent on:
[1]
https://patchwork.linuxtv.org/project/linux-media/cover/20250510075357.11761-1-yunfei.dong@mediatek.com/
[2]
https://patchwork.linuxtv.org/project/linux-media/cover/20250814085642.17343-1-kyrie.wu@mediatek.com/

Kyrie Wu (8):
  dt-bindings: media: mediatek: decoder: Add MT8189
    mediatek,vcodec-decoder
  media: mediatek: vcodec: add decoder compatible to support MT8189
  media: mediatek: vcodec: add profile and level supporting for MT8189
  media: mediatek: vcodec: Add single core VP9 decoding support for
    MT8189
  media: mediatek: vcodec: fix vp9 4096x2176 fail for profile2
  media: mediatek: vcodec: fix media device node number
  dt-bindings: media: Add MT8189 mediatek,vcodec-encoder
  media: mediatek: encoder: Add MT8189 encoder compatible data

 .../media/mediatek,vcodec-encoder.yaml        |  2 +
 .../media/mediatek,vcodec-subdev-decoder.yaml |  5 +-
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       |  9 +++-
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  1 +
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c |  4 ++
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 48 ++++++++++++++-----
 .../vcodec/encoder/mtk_vcodec_enc_drv.c       | 14 ++++++
 7 files changed, 68 insertions(+), 15 deletions(-)

-- 
2.45.2


