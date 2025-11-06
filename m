Return-Path: <linux-kernel+bounces-887854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B1C393B5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CDB1A264B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963EC2EA15B;
	Thu,  6 Nov 2025 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="McLhhyYM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FC2E1C65;
	Thu,  6 Nov 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409620; cv=none; b=gO5npVHpFBj10SX/wONBhx/NuLjWTgUbQOhu5V0pZ2XmGdlSPo1FoDkuzZPD0o2knonaBJBHJJO4toHKl/wXto6QM8Lvsp+6kc1uqzfvFHfxr1T2/M9Z1eJmLjYFo4wy3S0KNQDFNjmawtBf9W6fcLZbGThyk+ibLpMxFSyRGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409620; c=relaxed/simple;
	bh=LAVIjVrJjGaXxTfrEge99N4owEcPuSzPaev7VRibWak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhlbFf4PoMXCJLNBB9z5ed975iwtpXrDdB7zAeY6R0Jb2IhreHfNUp/vHS+y/y6NRAL1zYfdlxIp9wYWcxBoo+wZKroQZEGMt7BDfKa0AWu2car39D19wnTYF+FXanIKdXR3Bk2b8CMLEZt9QhlCwzh/42o98JQ9ePljMlh6gb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=McLhhyYM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8e96dd4bad711f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xOnnF5KlgRkr6DCjY5NoztvD/sMKbI8fpZbffl8nI58=;
	b=McLhhyYMqVa58XaiI19M4kwPd/kTxxjV7v+GeE4GDm2PsaYugR+lD6mtlnt6uo9Wy5DFlabr+GIiTpSBkTmQFI8UsULLMqg43ScVcE9ys5XsUYEXfPhfLrlkjWokLE29nR1VoAnZ86uZ9UmDDaaYvJBehJ4UKD/KE/Rj0kqKmEs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8f971131-cc2f-43b3-a749-664310871c29,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:461331e0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b8e96dd4bad711f08ac0a938fc7cd336-20251106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <kyrie.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 804810107; Thu, 06 Nov 2025 14:13:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:13:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:13:30 +0800
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
Subject: [PATCH v5 4/8] media: mediatek: vcodec: Add single core VP9 decoding support for MT8189
Date: Thu, 6 Nov 2025 14:13:19 +0800
Message-ID: <20251106061323.2193-5-kyrie.wu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106061323.2193-1-kyrie.wu@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

1. add config to support 4K prob size;
2. Previously, calling vdec_vp9_slice_setup_single_from_src_to_dst
with v4l2_m2m_next_src_buf to obtain both buffers resulted in -EINVAL,
interrupting the decoding process. To resolve this,
the interface should be updated to set both src and dst buffers
for metadata configuration.

Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
---
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 43 ++++++++++++++-----
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index fa0f406f7726..d966914db4b9 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -23,6 +23,7 @@
 
 #define VP9_TILE_BUF_SIZE 4096
 #define VP9_PROB_BUF_SIZE 2560
+#define VP9_PROB_BUF_4K_SIZE 3840
 #define VP9_COUNTS_BUF_SIZE 16384
 
 #define HDR_FLAG(x) (!!((hdr)->flags & V4L2_VP9_FRAME_FLAG_##x))
@@ -542,6 +543,23 @@ static int vdec_vp9_slice_init_default_frame_ctx(struct vdec_vp9_slice_instance
 	return ret;
 }
 
+static size_t mtk_vcodec_get_vp9_prob_size(enum mtk_vcodec_dec_chip_name chip_name)
+{
+	size_t prob_size;
+
+	switch (chip_name) {
+	case MTK_VDEC_MT8189:
+	case MTK_VDEC_MT8196:
+		prob_size = VP9_PROB_BUF_4K_SIZE;
+		break;
+	default:
+		prob_size = VP9_PROB_BUF_SIZE;
+		break;
+	}
+
+	return prob_size;
+}
+
 static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *instance,
 					       struct vdec_vp9_slice_vsi *vsi)
 {
@@ -616,7 +634,9 @@ static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *i
 	}
 
 	if (!instance->prob.va) {
-		instance->prob.size = VP9_PROB_BUF_SIZE;
+		instance->prob.size =
+			mtk_vcodec_get_vp9_prob_size(ctx->dev->chip_name);
+
 		if (mtk_vcodec_mem_alloc(ctx, &instance->prob))
 			goto err;
 	}
@@ -696,21 +716,22 @@ static int vdec_vp9_slice_tile_offset(int idx, int mi_num, int tile_log2)
 	return min(offset, mi_num);
 }
 
-static
-int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_slice_instance *instance)
+static int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_slice_instance *instance,
+						       struct mtk_vcodec_mem *bs,
+						       struct vdec_fb *fb)
 {
-	struct vb2_v4l2_buffer *src;
-	struct vb2_v4l2_buffer *dst;
+	struct mtk_video_dec_buf *src_buf_info;
+	struct mtk_video_dec_buf *dst_buf_info;
 
-	src = v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
-	if (!src)
+	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
+	if (!src_buf_info)
 		return -EINVAL;
 
-	dst = v4l2_m2m_next_dst_buf(instance->ctx->m2m_ctx);
-	if (!dst)
+	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	if (!dst_buf_info)
 		return -EINVAL;
 
-	v4l2_m2m_buf_copy_metadata(src, dst, true);
+	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &dst_buf_info->m2m_buf.vb, true);
 
 	return 0;
 }
@@ -1800,7 +1821,7 @@ static int vdec_vp9_slice_setup_single(struct vdec_vp9_slice_instance *instance,
 	struct vdec_vp9_slice_vsi *vsi = &pfc->vsi;
 	int ret;
 
-	ret = vdec_vp9_slice_setup_single_from_src_to_dst(instance);
+	ret = vdec_vp9_slice_setup_single_from_src_to_dst(instance, bs, fb);
 	if (ret)
 		goto err;
 
-- 
2.45.2


