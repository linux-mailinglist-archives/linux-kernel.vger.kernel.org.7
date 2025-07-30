Return-Path: <linux-kernel+bounces-750412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB4B15B13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5E17B0C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915492957C6;
	Wed, 30 Jul 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAggZeWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8529552B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865850; cv=none; b=SNGogaNhIEAFyTHqrhstjHZUsXQbKjCctbhXzKF94vfwLQxOytxx+pw/hQ319z+iJq6VdeBock/JiAF4zAekR/i/4eoyL6yjqDoYgO3rmfiuEopKnOoTu2s6zZu19Dy/0ltMFH8BeKzKb7ev9biGvqtIujNF1VfUthKZUNNxEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865850; c=relaxed/simple;
	bh=fsk1q+vbHOBdJ2fmmzNm81hQGwxIASDXY28bXs1Y6uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imLLHogD+9W4JJUjMo65JjNw8uu0epLGhnZ8qdajHKqrAkxH6iuB+y0r+4ODweNNWDlLYKW6bDtzSPtsQyvQJ0ZVsXqKNucn+MueWPg7roieZtN6dcstxaQhE7FKaRLCNF1LaT0F3SDkFfhybu4lb7AcC5Ft8kAXT6+TG6GCbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAggZeWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F25C4CEF8;
	Wed, 30 Jul 2025 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865849;
	bh=fsk1q+vbHOBdJ2fmmzNm81hQGwxIASDXY28bXs1Y6uU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CAggZeWQ3/LTmz0mqZSSau3DZMlBPU5t9p73DwEnDhUADqCswDKH8Z3+Lxpopf11o
	 gPC7Xz9jhghVBQS05Iu9OCXASWV93rcet9MFyfXdEIZMkpP2Yw7zfBmFYTJ2N51hEu
	 zf5yElaGkDa3B53aIpvTuWqci20UjVBAzNyydQ2zio87YE5MuHrdHuSRLW+yQH6sed
	 8C5vcfpZnHw3YeTDxcgQFmB/oHtR8H3GQpR1MilHxxJdri+xqXs4mRKVcPl+JOVYYV
	 qbkFeGBxOGjKy7gGC/nbJc5TbN3wvKei1QfxU/Fmv2timvLMeTcs1a4J0bbTdT3tl0
	 UHnsOeOYogsdA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:06 +0200
Subject: [PATCH 06/14] drm/tidss: dispc: Switch FLD_MOD to using a mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-6-a71ae8dd2782@kernel.org>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
In-Reply-To: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fsk1q+vbHOBdJ2fmmzNm81hQGwxIASDXY28bXs1Y6uU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd95KWHZ+xKmJemGuareipfWYv7cOZv6SqyoYEzLPj8
 3+fcc+lYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkjiZjfWHj4rdqSpNCZGqO
 3v8qxzR5/p1bUVuaj26N6PbI6M489/76hzZvRnUnqSshv/Pn/vl6kLG+Qo718n1u8R9HIt9/VtT
 ROLTs6YZNkcv5pmQxvy2zOF7ewJLl6px4d+FNGYlorsD1utcB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_MOD function takes the start and end bits as parameter and will
generate a mask out of them, twice.

Let's pass the mask, so the caller can generate it once and we would use
it twice.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 30f281221a5de6b69cc3edd2bf643cf0f8bea63b..e4729a5b79ed5d554e05c020adb7e2d3e7a8f4d3 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -607,26 +607,25 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-static u32 FLD_MOD(u32 orig, u32 val, u32 start, u32 end)
+static u32 FLD_MOD(u32 orig, u32 val, u32 mask)
 {
-	return (orig & ~GENMASK(start, end)) | FIELD_PREP(GENMASK(start, end),
-							  val);
+	return (orig & ~mask) | FIELD_PREP(mask, val);
 }
 
 static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 start, u32 end)
 {
 	return FIELD_GET(GENMASK(start, end), dispc_read(dispc, idx));
 }
 
 static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val,
 			u32 start, u32 end)
 {
-	dispc_write(dispc, idx, FLD_MOD(dispc_read(dispc, idx), val,
-					start, end));
+	dispc_write(dispc, idx,
+		    FLD_MOD(dispc_read(dispc, idx), val, GENMASK(start, end)));
 }
 
 static u32 VID_REG_GET(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 		       u32 start, u32 end)
 {
@@ -636,12 +635,11 @@ static u32 VID_REG_GET(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 
 static void VID_REG_FLD_MOD(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
 	dispc_vid_write(dispc, hw_plane, idx,
-			FLD_MOD(dispc_vid_read(dispc, hw_plane, idx),
-				val, start, end));
+			FLD_MOD(dispc_vid_read(dispc, hw_plane, idx), val, GENMASK(start, end)));
 }
 
 static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx,
 		      u32 start, u32 end)
 {
@@ -649,20 +647,19 @@ static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx,
 }
 
 static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 			   u32 start, u32 end)
 {
-	dispc_vp_write(dispc, vp, idx, FLD_MOD(dispc_vp_read(dispc, vp, idx),
-					       val, start, end));
+	dispc_vp_write(dispc, vp, idx,
+		       FLD_MOD(dispc_vp_read(dispc, vp, idx), val, GENMASK(start, end)));
 }
 
 static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
 	dispc_ovr_write(dispc, ovr, idx,
-			FLD_MOD(dispc_ovr_read(dispc, ovr, idx),
-				val, start, end));
+			FLD_MOD(dispc_ovr_read(dispc, ovr, idx), val, GENMASK(start, end)));
 }
 
 static dispc_irq_t dispc_vp_irq_from_raw(u32 stat, u32 hw_videoport)
 {
 	dispc_irq_t vp_stat = 0;
@@ -1155,11 +1152,12 @@ static void dispc_enable_am65x_oldi(struct dispc_device *dispc, u32 hw_videoport
 		dev_warn(dispc->dev, "%s: %d port width not supported\n",
 			 __func__, fmt->data_width);
 
 	oldi_cfg |= BIT(7); /* DEPOL */
 
-	oldi_cfg = FLD_MOD(oldi_cfg, fmt->am65x_oldi_mode_reg_val, 3, 1);
+	oldi_cfg = FLD_MOD(oldi_cfg, fmt->am65x_oldi_mode_reg_val,
+			   GENMASK(3, 1));
 
 	oldi_cfg |= BIT(12); /* SOFTRST */
 
 	oldi_cfg |= BIT(0); /* ENABLE */
 

-- 
2.50.1


