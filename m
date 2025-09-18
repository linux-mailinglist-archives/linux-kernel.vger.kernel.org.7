Return-Path: <linux-kernel+bounces-821829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88398B82681
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5045B1C22E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD41F12E0;
	Thu, 18 Sep 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pM2MptFk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCE12B73
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156219; cv=none; b=dh0vApVY3k5CxpmtKJW72csHhb0ek8wWbCx+fJo5AXGzRlE78IY4icPaUhoUf9xdFxG5F6994PIESHMS/XHTg76udH5AB38xLDCuE1YZmxbpZaVzv9ZqOMbq+k1fx+5RLsY/RBvkduWaSYqL0BDBleto3xVxtfHbyUj50fByN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156219; c=relaxed/simple;
	bh=Z6iykqCP6Bbd7PBUQgPY8pKSQ5qCdgcJUbUJzP8DED8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7btkjHyMJ4PYTwyu1Dw/MirNBH0BX/2sA8rnNmEsSP8xiQbFP5a3vRAtUQrd0ydz33aD1sjh4WGmJ3kWLzhZHXR1XJBAcOMM/o3A8JSbnLT0ovho2k31clc8mm1tmBnp96cveR2LdnZcaoqc8pK9JMbHVCF6Gu4wJG2Cd1+ZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pM2MptFk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758156215;
	bh=Z6iykqCP6Bbd7PBUQgPY8pKSQ5qCdgcJUbUJzP8DED8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pM2MptFkYNNDQVN4K4crDOWD/pgYcJJrmdYdrbZeDNjgyuyzkdxHwKZeqbMseUcNh
	 Oq2ZBopXtgfd6WLkiYl4D+zuIInAuLHFS9/ifD4ngih1hmmG2LU/X+B3U/OmcxgXcA
	 9FB9JyTnOEG0kzkVOSwYZO2/rsVFBvsgE3XP6wU4REXitwPRO+24f4U1d5Gg/XHbVR
	 bWmUM8DV1onFFXKI3nVfpDfZWsW1akVXJ3cpWGxH14++CcVX5BeyV1XeJZKKOObUqt
	 4tJMRbEmTXbcfDXyJ37e/S5OT6GKRmBYkt7jB87ss5mTPEpS/hhzr9jiPBqgTvInHe
	 7Xls11vrMn4PQ==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 530D117E0DC2;
	Thu, 18 Sep 2025 02:43:29 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Sep 2025 20:43:11 -0400
Subject: [PATCH RFC v2 02/20] drm/colorop: Allow parenting colorop to CRTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-mtk-post-blend-color-pipeline-v2-2-ac4471b44758@collabora.com>
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

In order to allow for post-blend color pipelines, colorops need to be
assigned to a crtc rather than a plane. Add a crtc to the colorop
struct to enable this. Either the plane or the crtc will be set for any
given colorop depending on whether it is part of a pre- or post-blend
color pipeline.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/drm/drm_colorop.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index d61c6c40e47162cb8b1e7db58b6746c43ac5d202..7a4e0d0c4a3d594abecef304b1d5990434cdb231 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -206,10 +206,16 @@ struct drm_colorop {
 	/**
 	 * @plane:
 	 *
-	 * The plane on which the colorop sits. A drm_colorop is always unique
-	 * to a plane.
+	 * The plane on which the colorop sits if it is a pre-blend colorop.
+	 * In this case it is unique to the plane.
+	 *
+	 * @crtc:
+	 *
+	 * The CRTC on which the colorop sits if it is a post-blend colorop.
+	 * In this case it is unique to the CRTC.
 	 */
 	struct drm_plane *plane;
+	struct drm_crtc *crtc;
 
 	/**
 	 * @state:

-- 
2.50.1


