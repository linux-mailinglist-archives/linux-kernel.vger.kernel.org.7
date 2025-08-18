Return-Path: <linux-kernel+bounces-773813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A893B2AAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9651BA5DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32588322527;
	Mon, 18 Aug 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="npSLXima"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9C321F21
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526687; cv=none; b=QrX1VfBgTlIrgrTwalgA5jyfXwkLAkD190zvN16ZvMwUyFn5AlR+3LUPTz0oTxExOYYjg+QGJMtTBbL41b49K1SLTrwejd9nWgtLqGjXJ6OVD8KUsd8hT61jIo1CoFbjbEwpyBvq569AhQayaMUdcibM3aXR64KJJeavYR6y6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526687; c=relaxed/simple;
	bh=6wt+TFbCgRTq3CoWDUzF4dMYm0Zd3ReDlyfg41hupY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KtnCmNurHWgiP6VSEMDxMUTnm9IVB4KGFAdKcA/ulN9dMmd6AjYhqgOj3MnhujwpRcA6dcTupo/8zJi4dyI1FI4/gPBWG/OqowksNRq1xbkqHPgYP3yOFOLzettiWmCSLifnOsdymxK9PWhEp832nIv4ZUtZeYQOudQTPzvfYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=npSLXima; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755526678;
	bh=6wt+TFbCgRTq3CoWDUzF4dMYm0Zd3ReDlyfg41hupY4=;
	h=From:Date:Subject:To:Cc:From;
	b=npSLXimayB4//c9tMXNr2mK6QsIj6HoqPX/U4mXW6Us64vmnnGNoC9/0LeafiN12T
	 VpYX+NpH9NCr9BuZxF55rKGX+ZPuL/6GX/MhxtViq0SRKfTZfqCgKQzh7ctSAKjS8d
	 PScY3YgtQsTepeFyP6qHWF8SjgU3agxHRsLnrlFgZSQ3x4qDYdIha4YYgw9UoVAHgd
	 YWHVn3MlEDBS1NGbuuYCEMgOSqhte4/bAWcOHEK/wKPK7GZTq3DHYr/A2UiSteaYwy
	 5or++qxd5fJMY5/xx0FO8mQRYi64vUmG4vdtU86FzNU5dfyKkYwJDxGOwuzGgNb+VB
	 BM08j/NgsSaAw==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7501617E0100;
	Mon, 18 Aug 2025 16:17:57 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 18 Aug 2025 16:17:52 +0200
Subject: [PATCH] drm/mediatek: mtk_hdmi: fix inverted parameters in some
 regmap_update_bits calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-mt8173-fix-hdmi-issue-v1-1-55aff9b0295d@collabora.com>
X-B4-Tracking: v=1; b=H4sIAA82o2gC/zWNzQqDMBCEX0X23IX8IAm+SvGgca17SGyzUQTx3
 RsqPX7DzDcnCGUmga45IdPOwmuqoB8NhGVIL0KeKoNRplVee4zFa2dx5gOXKTKyyEZovAuzbe2
 onIO6fWeqjZ/32d+c6bNVfblDGAchDGuMXLom0VHwfwH9dX0B3FFenZgAAAA=
X-Change-ID: 20250818-mt8173-fix-hdmi-issue-287cf353b077
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Guillaume Ranquet <granquet@baylibre.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755526677; l=1911;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=6wt+TFbCgRTq3CoWDUzF4dMYm0Zd3ReDlyfg41hupY4=;
 b=4cUsJwhO61paEKP7kGx01MrdfPfAETpCU7wZnArg2FB5y23RYgiOHFovUTjQwRAslChXPhEXA
 PdpVCLQqgVZAZgiUf6SqWiViaGpdXmWuDdGySW/NalO7PB1SX9SNZ85
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In mtk_hdmi driver, a recent change replaced custom register access
function calls by regmap ones, but two replacements by regmap_update_bits
were done incorrectly, because original offset and mask parameters were
inverted, so fix them.

Fixes: d6e25b3590a0 ("drm/mediatek: hdmi: Use regmap instead of iomem for main registers")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 845fd8aa43c3c91659808d9e6bb78758d1f9b857..b766dd5e6c8de6d16bff50972b45c3c1a083b985 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -182,8 +182,8 @@ static inline struct mtk_hdmi *hdmi_ctx_from_bridge(struct drm_bridge *b)
 
 static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
 {
-	regmap_update_bits(hdmi->regs, VIDEO_SOURCE_SEL,
-			   VIDEO_CFG_4, black ? GEN_RGB : NORMAL_PATH);
+	regmap_update_bits(hdmi->regs, VIDEO_CFG_4,
+			   VIDEO_SOURCE_SEL, black ? GEN_RGB : NORMAL_PATH);
 }
 
 static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
@@ -310,8 +310,8 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_hdmi *hdmi, u8 *buffer,
 
 static void mtk_hdmi_hw_send_aud_packet(struct mtk_hdmi *hdmi, bool enable)
 {
-	regmap_update_bits(hdmi->regs, AUDIO_PACKET_OFF,
-			   GRL_SHIFT_R2, enable ? 0 : AUDIO_PACKET_OFF);
+	regmap_update_bits(hdmi->regs, GRL_SHIFT_R2,
+			   AUDIO_PACKET_OFF, enable ? 0 : AUDIO_PACKET_OFF);
 }
 
 static void mtk_hdmi_hw_config_sys(struct mtk_hdmi *hdmi)

---
base-commit: afb39542bbf14acf910012eee2d4159add05d384
change-id: 20250818-mt8173-fix-hdmi-issue-287cf353b077

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


