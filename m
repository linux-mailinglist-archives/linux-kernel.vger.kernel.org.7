Return-Path: <linux-kernel+bounces-821828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9FB82678
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B41C22DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178921F8677;
	Thu, 18 Sep 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ljWOjq5D"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702912B73
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156212; cv=none; b=PV9DWBOTHcjtNtAfGqwAVo6bjx4Dzm2OmztYkg7MIerZL6CEDtCkzK+wosqJG+VmatE3EQd0cigMqTrDlZaciFpK63veyqr+tgJd1kuoQ8wXJCpfjA1mESS836Tkcc3EexzzU4pMX/FEHN5MCIpkI9GPCyn4d7/MSs9jA3Xw7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156212; c=relaxed/simple;
	bh=/0mpBbdAEWX/vOdWoDChg/5XjulmnR5K1jdXZOMdla0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TepJZoSe4tqN4UV+W+ug9ATrImJP/ysITnC4yRJ7gwyxPEGGrfqLsrFbjEbzYbv0lCAbQ2ueHKv5cxxmS/U77LagvDyfLlDEI0ZYWUqc9cMjfI9JSuVDbDEGiRbAwPw3CRMBaQujFHnDBEI6d3A3dKNYyayXiC/ijZZ8JpTXOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ljWOjq5D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156208;
	bh=/0mpBbdAEWX/vOdWoDChg/5XjulmnR5K1jdXZOMdla0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ljWOjq5D83YR6fnv5Sipc6h1icUQO5e9fk3y2zaAG8JVkJbr4j1nObFFgWI9Eea+F
	 hDL4iyFj5CBWhCSXiCg4XcIf3HTjZnXGCf9MzrtMmUt3ayD8uz9xyF2pW7vIKMrdcZ
	 IqLsOhxyX6br0BFuS5RHpm6EHk33OQMOj6m4uSIYtlYP8M6a7wqd0nXqqdM97GohZd
	 SQ3KXCkCVHSFITar9aVb/poyzudc2QXeH9nWD3NkM5IhG09yYPDRo9s7Axajm0ESxc
	 wPqwc7TKNEq3SBPvPNvTTT65JwM+fmkgydfkodJ9bCfCS0zOF/SfADzSofFLTD6XkS
	 GRZAWeSQTFOUA==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E666917E0147;
	Thu, 18 Sep 2025 02:43:21 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:10 -0400
Subject: [PATCH RFC v2 01/20] drm/crtc: Add color pipeline to CRTC state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-1-ac4471b44758@collabora.com>
References: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
In-Reply-To: <20250917-mtk-post-blend-color-pipeline-v2-0-ac4471b44758@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com, 
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com, 
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com, 
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 xaver.hugl@gmail.com, victoria@system76.com, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, 
 mcanal@igalia.com, kernel@collabora.com, daniels@collabora.com, 
 leandro.ribeiro@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

Add a color pipeline to the CRTC state to allow post-blend color
pipelines.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/drm/drm_crtc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index caa56e039da2a748cf40ebf45b37158acda439d9..77c0c04a5910a2263923e06cf37535697e20e1c9 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -274,6 +274,14 @@ struct drm_crtc_state {
 	 */
 	struct drm_property_blob *gamma_lut;
 
+	/**
+	 * @color_pipeline:
+	 *
+	 * The first colorop of the active color pipeline, or NULL, if no
+	 * color pipeline is active.
+	 */
+	struct drm_colorop *color_pipeline;
+
 	/**
 	 * @target_vblank:
 	 *

-- 
2.50.1


