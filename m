Return-Path: <linux-kernel+bounces-607116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B049BA8B820
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DD519055F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405324888A;
	Wed, 16 Apr 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FjDaDh4z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00834247DF9;
	Wed, 16 Apr 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804956; cv=none; b=ftIF5eb/p0X4cBmqSXY/mGKyLzCLK5ewpHCXm5G+Te5Yr6pqJ+LKWx1ftGKKILiCWe1dOkUP7dKeB7/mcaKzJFqG2xO0UwisLOjIKF/7QcV3kI70bKPa3iNqCXJLlpBAiqnnSx6xF1eYJyz+qs9PxL97qkz0uAlHPUUdRrZ+JWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804956; c=relaxed/simple;
	bh=obDUgJNbYdBki0yz8VYXoYOV87LXkXDBtFY5AiG0bMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bt7+ov4K8U36ugOezVihiSZe7Jj1mEuU3tc5s3L9J/bYgHzeWuftbb/OS8n88YvsMYxZX4wYVs/Z6rlvfpfBiraByDm724XikvRy7YCzB+paY6Nxvje9QiwthiJMa9xaD6UUu9h8zft0tsImhUpf2Q1EKZR96atPg7k7IwPwZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FjDaDh4z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744804952;
	bh=obDUgJNbYdBki0yz8VYXoYOV87LXkXDBtFY5AiG0bMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FjDaDh4zqHd/ElQtuC7V875y2Ma6X+hI2smalYRanaebqRiMe+GSKOTBR942iqd/N
	 9AxKGjeTB5NHpcIHzJ41TEvyV5vUhi4H86pn3jgzHSQdoxAU6UyY37I6MA7VrEM8Vs
	 PzxGCm9lpjYJUh1U2cLwCILplpeBHBW1zBFq5oDl0f8OX4WrEzytAyaqAJ1+hHr8H6
	 iKGhhGh1dulXSvMro6DGbwIOCA+lRTxh68Lu4fV7gxgmP3+zjsO+JI4yF8RELgSkke
	 t3MktpaNq5xw9CSP8yYlfDtD48AELlAW0dMtC3rQOneCE1oZu/xoUTc0qrIpl8y1p7
	 Um0yu9dvso+pA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8373F17E362F;
	Wed, 16 Apr 2025 14:02:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jassisinghbrar@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: mailbox: mediatek,gce-mailbox: Add support for MT6893
Date: Wed, 16 Apr 2025 14:02:30 +0200
Message-ID: <20250416120230.147844-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the MediaTek Dimensity 1200 (MT6893)
SoC using MT8195 as a fallback, and add a header for the GCE
mailbox found in MT6893.

Similarly to MT8195, this SoC has two GCE hardware instances, but
the event values are different (hence requiring its own header).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mailbox/mediatek,gce-mailbox.yaml         |   4 +
 include/dt-bindings/gce/mediatek,mt6893-gce.h | 312 ++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 include/dt-bindings/gce/mediatek,mt6893-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index 73d6db34d64a..277d290d852b 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - mediatek,mt6779-gce
+          - mediatek,mt6893-gce
           - mediatek,mt8173-gce
           - mediatek,mt8183-gce
           - mediatek,mt8186-gce
@@ -29,6 +30,9 @@ properties:
       - items:
           - const: mediatek,mt6795-gce
           - const: mediatek,mt8173-gce
+      - items:
+          - const: mediatek,mt6893-gce
+          - const: mediatek,mt8195-gce
 
   "#mbox-cells":
     const: 2
diff --git a/include/dt-bindings/gce/mediatek,mt6893-gce.h b/include/dt-bindings/gce/mediatek,mt6893-gce.h
new file mode 100644
index 000000000000..e6e50a87b850
--- /dev/null
+++ b/include/dt-bindings/gce/mediatek,mt6893-gce.h
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <aangelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT6893_H
+#define _DT_BINDINGS_GCE_MT6893_H
+
+/* assign timeout 0 also means default */
+#define CMDQ_NO_TIMEOUT		0xffffffff
+#define CMDQ_TIMEOUT_DEFAULT	1000
+
+/* GCE thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_1		1
+#define CMDQ_THR_PRIO_2		2
+#define CMDQ_THR_PRIO_3		3
+#define CMDQ_THR_PRIO_4		4
+#define CMDQ_THR_PRIO_5		5
+#define CMDQ_THR_PRIO_6		6
+#define CMDQ_THR_PRIO_HIGHEST	7
+
+/* CPR count in 32bit register */
+#define GCE_CPR_COUNT		1312
+
+/* GCE subsys table */
+#define SUBSYS_1300XXXX		0
+#define SUBSYS_1400XXXX		1
+#define SUBSYS_1401XXXX		2
+#define SUBSYS_1402XXXX		3
+#define SUBSYS_1502XXXX		4
+#define SUBSYS_1880XXXX		5
+#define SUBSYS_1881XXXX		6
+#define SUBSYS_1882XXXX		7
+#define SUBSYS_1883XXXX		8
+#define SUBSYS_1884XXXX		9
+#define SUBSYS_1000XXXX		10
+#define SUBSYS_1001XXXX		11
+#define SUBSYS_1002XXXX		12
+#define SUBSYS_1003XXXX		13
+#define SUBSYS_1004XXXX		14
+#define SUBSYS_1005XXXX		15
+#define SUBSYS_1020XXXX		16
+#define SUBSYS_1028XXXX		17
+#define SUBSYS_1700XXXX		18
+#define SUBSYS_1701XXXX		19
+#define SUBSYS_1702XXXX		20
+#define SUBSYS_1703XXXX		21
+#define SUBSYS_1800XXXX		22
+#define SUBSYS_1801XXXX		23
+#define SUBSYS_1802XXXX		24
+#define SUBSYS_1804XXXX		25
+#define SUBSYS_1805XXXX		26
+#define SUBSYS_1808XXXX		27
+#define SUBSYS_180aXXXX		28
+#define SUBSYS_180bXXXX		29
+
+/* GCE-D hardware events */
+#define CMDQ_EVENT_DISP_OVL0_SOF			0
+#define CMDQ_EVENT_DISP_OVL0_2L_SOF			1
+#define CMDQ_EVENT_DISP_RDMA0_SOF			2
+#define CMDQ_EVENT_DISP_WDMA0_SOF			3
+#define CMDQ_EVENT_DISP_COLOR0_SOF			4
+#define CMDQ_EVENT_DISP_CCORR0_SOF			5
+#define CMDQ_EVENT_DISP_AAL0_SOF			6
+#define CMDQ_EVENT_DISP_GAMMA0_SOF			7
+#define CMDQ_EVENT_DISP_DITHER0_SOF			8
+#define CMDQ_EVENT_DSI0_SOF				9
+#define CMDQ_EVENT_DISP_RSZ0_SOF			10
+#define CMDQ_EVENT_DISP_PWM0_SOF			11
+#define CMDQ_EVENT_DISP_OVL1_SOF			12
+#define CMDQ_EVENT_DISP_OVL1_2L_SOF			13
+#define CMDQ_EVENT_DISP_RDMA1_SOF			14
+#define CMDQ_EVENT_DISP_WDMA1_SOF			15
+#define CMDQ_EVENT_DISP_COLOR1_SOF			16
+#define CMDQ_EVENT_DISP_CCORR1_SOF			17
+#define CMDQ_EVENT_DISP_AAL1_SOF			18
+#define CMDQ_EVENT_DISP_GAMMA1_SOF			19
+#define CMDQ_EVENT_DISP_DITHER1_SOF			20
+#define CMDQ_EVENT_DSI1_SOF				21
+#define CMDQ_EVENT_DISP_RSZ1_SOF			22
+#define CMDQ_EVENT_DISP_OVL2_2L_SOF			23
+#define CMDQ_EVENT_DISP_OVL3_2L_SOF			24
+#define CMDQ_EVENT_DISP_POSTMASK0_SOF			25
+#define CMDQ_EVENT_DISP_POSTMASK1_SOF			26
+#define CMDQ_EVENT_DISP_MERGE0_SOF			27
+#define CMDQ_EVENT_DISP_MERGE1_SOF			28
+#define CMDQ_EVENT_DISP_DSC_WRAP_SOF			29
+#define CMDQ_EVENT_DISP_DSC_WRAP_1_SOF			30
+#define CMDQ_EVENT_DP_INTF_SOF				31
+#define CMDQ_EVENT_MDP_AAL4_SOF				32
+#define CMDQ_EVENT_MDP_AAL5_SOF				33
+#define CMDQ_EVENT_MDP_RDMA4_SOF			34
+#define CMDQ_EVENT_MDP_RDMA5_SOF			35
+#define CMDQ_EVENT_MDP_HDR4_SOF				36
+#define CMDQ_EVENT_MDP_HDR5_SOF				37
+#define CMDQ_EVENT_MDP_RSZ4_SOF				38
+#define CMDQ_EVENT_MDP_RSZ5_SOF				39
+#define CMDQ_EVENT_MDP_TDSHP4_SOF			40
+#define CMDQ_EVENT_MDP_TDSHP5_SOF			41
+#define CMDQ_EVENT_DISP_RDMA4_SOF			42
+#define CMDQ_EVENT_DISP_RDMA5_SOF			43
+#define CMDQ_EVENT_DISP_UFBC_WDMA0_SOF			44
+#define CMDQ_EVENT_DISP_UFBC_WDMA1_SOF			45
+#define CMDQ_EVENT_MDP_TDSHP5_FRAME_DONE		46
+#define CMDQ_EVENT_MDP_TDSHP4_FRAME_DONE		47
+#define CMDQ_EVENT_MDP_RSZ5_FRAME_DONE			48
+#define CMDQ_EVENT_MDP_RSZ4_FRAME_DONE			49
+#define CMDQ_EVENT_MDP_RDMA5_FRAME_DONE			50
+#define CMDQ_EVENT_MDP_RDMA4_FRAME_DONE			51
+#define CMDQ_EVENT_MDP_HDR5_FRAME_DONE			52
+#define CMDQ_EVENT_MDP_HDR4_FRAME_DONE			53
+#define CMDQ_EVENT_MDP_AAL5_FRAME_DONE			54
+#define CMDQ_EVENT_MDP_AAL4_FRAME_DONE			55
+#define CMDQ_EVENT_DSI1_FRAME_DONE			56
+#define CMDQ_EVENT_DSI0_FRAME_DONE			57
+#define CMDQ_EVENT_DP_INTF_FRAME_DONE_MM		58
+#define CMDQ_EVENT_DISP_WDMA1_FRAME_DONE		59
+#define CMDQ_EVENT_DISP_WDMA0_FRAME_DONE		60
+#define CMDQ_EVENT_DISP_RSZ1_FRAME_DONE			61
+#define CMDQ_EVENT_DISP_RSZ0_FRAME_DONE			62
+#define CMDQ_EVENT_DISP_RDMA5_FRAME_DONE		63
+#define CMDQ_EVENT_DISP_RDMA4_FRAME_DONE		64
+#define CMDQ_EVENT_DISP_RDMA3_FRAME_DONE		65
+#define CMDQ_EVENT_DISP_RDMA2_FRAME_DONE		66
+#define CMDQ_EVENT_DISP_RDMA1_FRAME_DONE		67
+#define CMDQ_EVENT_DISP_RDMA0_FRAME_DONE		68
+#define CMDQ_EVENT_DISP_POSTMASK1_FRAME_DONE		69
+#define CMDQ_EVENT_DISP_POSTMASK0_FRAME_DONE		70
+#define CMDQ_EVENT_DISP_OVL3_2L_FRAME_DONE		71
+#define CMDQ_EVENT_DISP_OVL2_2L_FRAME_DONE		72
+#define CMDQ_EVENT_DISP_OVL1_FRAME_DONE			73
+#define CMDQ_EVENT_DISP_OVL1_2L_FRAME_DONE		74
+#define CMDQ_EVENT_DISP_OVL0_FRAME_DONE			75
+#define CMDQ_EVENT_DISP_OVL0_2L_FRAME_DONE		76
+#define CMDQ_EVENT_DISP_GAMMA1_FRAME_DONE		77
+#define CMDQ_EVENT_DISP_GAMMA0_FRAME_DONE		78
+#define CMDQ_EVENT_DISP_DITHER1_FRAME_DONE		79
+#define CMDQ_EVENT_DISP_DITHER0_FRAME_DONE		80
+#define CMDQ_EVENT_DISP_COLOR1_FRAME_DONE		81
+#define CMDQ_EVENT_DISP_COLOR0_FRAME_DONE		82
+#define CMDQ_EVENT_DISP_CCORR1_FRAME_DONE		83
+#define CMDQ_EVENT_DISP_CCORR0_FRAME_DONE		84
+#define CMDQ_EVENT_DISP_AAL1_FRAME_DONE			85
+#define CMDQ_EVENT_DISP_AAL0_FRAME_DONE			86
+#define CMDQ_EVENT_DISP_DSC_WRAP_FRAME_DONE_0		87
+#define CMDQ_EVENT_DISP_DSC_WRAP_FRAME_DONE_1		88
+#define CMDQ_EVENT_DISP_UFBC_WDMA1_FRAME_DONE		89
+#define CMDQ_EVENT_DISP_UFBC_WDMA0_FRAME_DONE		90
+#define CMDQ_EVENT_DISP_MERGE1_FRAME_DONE		91
+#define CMDQ_EVENT_DISP_MERGE0_FRAME_DONE		92
+#define CMDQ_EVENT_DISP_STREAM_DONE(x)			((x) + 128) /* 128-143 */
+#define CMDQ_EVENT_DSI1_TE				144
+#define CMDQ_EVENT_DSI1_IRQ				145
+#define CMDQ_EVENT_DSI1_DONE				146
+#define CMDQ_EVENT_DSI0_TE				147
+#define CMDQ_EVENT_DSI0_IRQ				148
+#define CMDQ_EVENT_DSI0_DONE				149
+#define CMDQ_EVENT_DISP_WDMA1_SW_RST_DONE		150
+#define CMDQ_EVENT_DISP_WDMA0_SW_RST_DONE		151
+#define CMDQ_EVENT_DISP_OVL3_2L_RST_DONE		152
+#define CMDQ_EVENT_DISP_OVL2_2L_RST_DONE		153
+#define CMDQ_EVENT_DISP_OVL1_RST_DONE			154
+#define CMDQ_EVENT_DISP_OVL1_2L_RST_DONE		155
+#define CMDQ_EVENT_DISP_OVL0_RST_DONE			156
+#define CMDQ_EVENT_DISP_OVL0_2L_RST_DONE		157
+#define CMDQ_EVENT_BUF_UNDERRUN(x)			((x) + 158) /* 158-165 */
+#define CMDQ_EVENT_DP_VDE_END				166
+#define CMDQ_EVENT_DP_VDE_START				167
+#define CMDQ_EVENT_DP_VSYNC_END				168
+#define CMDQ_EVENT_DP_VSYNC_START			169
+#define CMDQ_EVENT_DP_TARGET_LINE			170
+#define CMDQ_EVENT_DISP_POSTMASK1_RST_DONE		171
+#define CMDQ_EVENT_DISP_POSTMASK0_RST_DONE		172
+#define CMDQ_EVENT_VDEC_LAT_SOF_0			256
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE(x)		((x) + 257) /* 257-263 */
+#define CMDQ_EVENT_VDEC_LAT(x)				((x) + 264) /* 264-271 */
+#define CMDQ_EVENT_VDEC_SOF_0				288
+#define CMDQ_EVENT_VDEC_FRAME_DONE(x)			((x) + 289) /* 289-295 */
+#define CMDQ_EVENT_VDEC(x)				((x) + 296) /* 296-303 */
+#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE_C1		385
+#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE_C1		386
+#define CMDQ_EVENT_JPGENC_CMDQ_DONE_C1			387
+#define CMDQ_EVENT_VENC_CMDQ_MB_DONE_C1			388
+#define CMDQ_EVENT_VENC_CMDQ_128BYTE_CNT_DONE_C1	389
+#define CMDQ_EVENT_JPGDEC_CMDQ_DONE_C1			390
+#define CMDQ_EVENT_JPGDEC_C1_CMDQ_DONE_C1		391
+#define CMDQ_EVENT_JPGDEC_INSUFF_CMDQ_DONE_C1		392
+#define CMDQ_EVENT_JPGDEC_C1_INSUFF_CMDQ_DONE_C1	393
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_2ND_STAGE_DONE_C1	394
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_3RD_STAGE_DONE_C1	395
+#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE			417
+#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE			418
+#define CMDQ_EVENT_JPGENC_CMDQ_DONE			419
+#define CMDQ_EVENT_VENC_CMDQ_MB_DONE			420
+#define CMDQ_EVENT_VENC_CMDQ_128BYTE_CNT_DONE		421
+#define CMDQ_EVENT_JPGDEC_CMDQ_DONE			422
+#define CMDQ_EVENT_JPGDEC_C1_CMDQ_DONE			423
+#define CMDQ_EVENT_JPGDEC_INSUFF_CMDQ_DONE		424
+#define CMDQ_EVENT_JPGDEC_C1_INSUFF_CMDQ_DONE		425
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_2ND_STAGE_DONE	426
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_3RD_STAGE_DONE	427
+#define CMDQ_EVENT_VDEC_CORE0_SOF_0			448
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE(x)		((x) + 449) /* 449-455 */
+#define CMDQ_EVENT_VDEC_CORE0(x)			((x) + 456) /* 456-463 */
+#define CMDQ_EVENT_IRQ_OUT_GCE_0			482
+#define CMDQ_EVENT_IRQ_OUT_GCE_1			483
+#define CMDQ_EVENT_OUT_EVENT_0				898
+#define CMDQ_EVENT_OUT_EVENT_1				899
+
+/* GCE-M hardware events */
+#define CMDQ_EVENT_IMG2_EVENT_TX_FRAME_DONE(x)		((x) + 1) /* 1-24 */
+#define CMDQ_EVENT_IMG1_EVENT_TX_FRAME_DONE(x)		((x) + 33) /* 33-56 */
+#define CMDQ_EVENT_IPE_EVENT_TX_FRAME_DONE_0		129
+#define CMDQ_EVENT_IPE_EVENT_TX_FRAME_DONE_1		130
+#define CMDQ_EVENT_RSC_EOF				131
+#define CMDQ_EVENT_IPE_EVENT_TX_FRAME_DONE_3		132
+#define CMDQ_EVENT_IPE_EVENT_TX_FRAME_DONE_4		133
+#define CMDQ_EVENT_ISP_FRAME_DONE_A			193
+#define CMDQ_EVENT_ISP_FRAME_DONE_B			194
+#define CMDQ_EVENT_ISP_FRAME_DONE_C			195
+#define CMDQ_EVENT_CAMSV0_PASS1_DONE			196
+#define CMDQ_EVENT_CAMSV02_PASS1_DONE			197
+#define CMDQ_EVENT_CAMSV1_PASS1_DONE			198
+#define CMDQ_EVENT_CAMSV2_PASS1_DONE			199
+#define CMDQ_EVENT_CAMSV3_PASS1_DONE			200
+#define CMDQ_EVENT_MRAW_0_PASS1_DONE			201
+#define CMDQ_EVENT_MRAW_1_PASS1_DONE			202
+#define CMDQ_EVENT_SENINF_FIFO_FULL_CAM(x)		((x) + 203) /* 203-215 */
+#define CMDQ_EVENT_TG_OVRUN_A_INT			216
+#define CMDQ_EVENT_DMA_R1_ERROR_A_INT			217
+#define CMDQ_EVENT_TG_OVRUN_B_INT			218
+#define CMDQ_EVENT_DMA_R1_ERROR_B_INT			219
+#define CMDQ_EVENT_TG_OVRUN_C_INT			220
+#define CMDQ_EVENT_DMA_R1_ERROR_C_INT			221
+#define CMDQ_EVENT_TG_OVRUN_M0_INT			222
+#define CMDQ_EVENT_DMA_R1_ERROR_M0_INT			223
+#define CMDQ_EVENT_MDP_RDMA0_SOF			256
+#define CMDQ_EVENT_MDP_RDMA1_SOF			257
+#define CMDQ_EVENT_MDP_RDMA2_SOF			258
+#define CMDQ_EVENT_MDP_RDMA3_SOF			259
+#define CMDQ_EVENT_MDP_FG0_SOF				260
+#define CMDQ_EVENT_MDP_FG1_SOF				261
+#define CMDQ_EVENT_MDP_AAL0_SOF				262
+#define CMDQ_EVENT_MDP_AAL1_SOF				263
+#define CMDQ_EVENT_MDP_AAL2_SOF				264
+#define CMDQ_EVENT_MDP_AAL3_SOF				265
+#define CMDQ_EVENT_MDP_HDR0_SOF				266
+#define CMDQ_EVENT_MDP_HDR1_SOF				267
+#define CMDQ_EVENT_MDP_RSZ0_SOF				268
+#define CMDQ_EVENT_MDP_RSZ1_SOF				269
+#define CMDQ_EVENT_MDP_RSZ2_SOF				270
+#define CMDQ_EVENT_MDP_RSZ3_SOF				271
+#define CMDQ_EVENT_MDP_WROT0_SOF			272
+#define CMDQ_EVENT_MDP_WROT1_SOF			273
+#define CMDQ_EVENT_MDP_WROT2_SOF			274
+#define CMDQ_EVENT_MDP_WROT3_SOF			275
+#define CMDQ_EVENT_MDP_TDSHP0_SOF			276
+#define CMDQ_EVENT_MDP_TDSHP1_SOF			277
+#define CMDQ_EVENT_MDP_TDSHP2_SOF			278
+#define CMDQ_EVENT_MDP_TDSHP3_SOF			279
+#define CMDQ_EVENT_MDP_TCC0_SOF				280
+#define CMDQ_EVENT_MDP_TCC1_SOF				281
+#define CMDQ_EVENT_MDP_TCC2_SOF				282
+#define CMDQ_EVENT_MDP_TCC3_SOF				283
+#define CMDQ_EVENT_IMG_DL_RELAY0_SOF			284
+#define CMDQ_EVENT_IMG_DL_RELAY1_SOF			285
+#define CMDQ_EVENT_IMG_DL_RELAY2_SOF			286
+#define CMDQ_EVENT_IMG_DL_RELAY3_SOF			287
+#define CMDQ_EVENT_MDP_WROT3_FRAME_DONE			288
+#define CMDQ_EVENT_MDP_WROT2_FRAME_DONE			289
+#define CMDQ_EVENT_MDP_WROT1_FRAME_DONE			290
+#define CMDQ_EVENT_MDP_WROT0_FRAME_DONE			291
+#define CMDQ_EVENT_MDP_TDSHP3_FRAME_DONE		292
+#define CMDQ_EVENT_MDP_TDSHP2_FRAME_DONE		293
+#define CMDQ_EVENT_MDP_TDSHP1_FRAME_DONE		294
+#define CMDQ_EVENT_MDP_TDSHP0_FRAME_DONE		295
+#define CMDQ_EVENT_MDP_TCC3_FRAME_DONE			296
+#define CMDQ_EVENT_MDP_TCC2_FRAME_DONE			297
+#define CMDQ_EVENT_MDP_TCC1_FRAME_DONE			298
+#define CMDQ_EVENT_MDP_TCC0_FRAME_DONE			299
+#define CMDQ_EVENT_MDP_RSZ3_FRAME_DONE			300
+#define CMDQ_EVENT_MDP_RSZ2_FRAME_DONE			301
+#define CMDQ_EVENT_MDP_RSZ1_FRAME_DONE			302
+#define CMDQ_EVENT_MDP_RSZ0_FRAME_DONE			303
+#define CMDQ_EVENT_MDP_RDMA3_FRAME_DONE			304
+#define CMDQ_EVENT_MDP_RDMA2_FRAME_DONE			305
+#define CMDQ_EVENT_MDP_RDMA1_FRAME_DONE			306
+#define CMDQ_EVENT_MDP_RDMA0_FRAME_DONE			307
+#define CMDQ_EVENT_MDP_HDR1_FRAME_DONE			308
+#define CMDQ_EVENT_MDP_HDR0_FRAME_DONE			309
+#define CMDQ_EVENT_MDP_FG1_FRAME_DONE			310
+#define CMDQ_EVENT_MDP_FG0_FRAME_DONE			311
+#define CMDQ_EVENT_MDP_COLOR1_FRAME_DONE		312
+#define CMDQ_EVENT_MDP_COLOR0_FRAME_DONE		313
+#define CMDQ_EVENT_MDP_AAL3_FRAME_DONE			314
+#define CMDQ_EVENT_MDP_AAL2_FRAME_DONE			315
+#define CMDQ_EVENT_MDP_AAL1_FRAME_DONE			316
+#define CMDQ_EVENT_MDP_AAL0_FRAME_DONE			317
+#define CMDQ_EVENT_MDP_STREAM_DONE(x)			((x) + 320) /* 320-335 */
+#define CMDQ_EVENT_MDP_WROT3_SW_RST_DONE		336
+#define CMDQ_EVENT_MDP_WROT2_SW_RST_DONE		337
+#define CMDQ_EVENT_MDP_WROT1_SW_RST_DONE		338
+#define CMDQ_EVENT_MDP_WROT0_SW_RST_DONE		339
+#define CMDQ_EVENT_MDP_RDMA3_SW_RST_DONE		340
+#define CMDQ_EVENT_MDP_RDMA2_SW_RST_DONE		341
+#define CMDQ_EVENT_MDP_RDMA1_SW_RST_DONE		342
+#define CMDQ_EVENT_MDP_RDMA0_SW_RST_DONE		343
+
+#endif
-- 
2.49.0


