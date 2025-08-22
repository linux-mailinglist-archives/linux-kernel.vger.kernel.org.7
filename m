Return-Path: <linux-kernel+bounces-782576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F7B32256
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264595C3FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1F2874FC;
	Fri, 22 Aug 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qp1zDczV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63928EB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887801; cv=none; b=gytFk1DwlGcmtdF1hoKARWrxSN27WUy3ICW9oq4ml9Qz4WAvuTlWUYPHI8IhhDT/oIB73ZCYx5b8fYt6fedXElXsQhCIXaQ8hFbCcVst6j39qbOSOkhj7Ogd72tIar5t+QqcWSoen/bgzDNXLDUDk9OjvJA7/2t8fvACcKkBEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887801; c=relaxed/simple;
	bh=ojMWLu9sR6XdGXpcfVIIZPVqzPufzHlxziClp8RvZuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DcD8aJ5Cud5XOeWedaoi0eLUAyDCN20wKz3trEVxVgmGKN6YEjs2cxyBnW5XTVWfBca7L4jrrtleCk1JzVdIjRGXVJXngzhwdlgn5s+3/hDhwqZLBOCYICx7v+8ZHZ08RY8mfES+zDeh8zI8zCn31yJJMgjWrxUqm7WwzBylzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qp1zDczV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755887795;
	bh=ojMWLu9sR6XdGXpcfVIIZPVqzPufzHlxziClp8RvZuc=;
	h=From:Subject:Date:To:Cc:From;
	b=Qp1zDczVZTuL+KKSr2IZlvqdH3/8Y6QxXavfHVcwdXakerqipjLzv1xqzn6zjw9nS
	 JCt4PIpVo7dSuYysFkbX8+LcF1aa4CIOY9OodbCsczlOVGuh4sCDhLE3g4NPkxirWp
	 XgDaCvVoU/10UIhfLRtl5ZSKp6Hs6R0AWhEeIgNQdVAfVIj3Rl0mxFu9mBf0bQyY/b
	 XaBCBI2ft6njRroOTCJKWe6boNB/pNfe7amjyRE8JJi9/t9AQrWlcw2UK+szQZftP+
	 JxoQ5GvUlQ4I8k4gCvBNXjJTD5tAKvPzO2LOE4SCra4hg9lLU36M7mK/kpFlTQFL4j
	 E9deI22a44jgQ==
Received: from [127.0.1.1] (unknown [IPv6:2600:4041:5b1a:9400:62f0:406e:ac79:4a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C6D017E110D;
	Fri, 22 Aug 2025 20:36:29 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH RFC 0/5] Introduce support for post-blend color pipeline
Date: Fri, 22 Aug 2025 14:36:10 -0400
Message-Id: <20250822-mtk-post-blend-color-pipeline-v1-0-a9446d4aca82@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJu4qGgC/x3MTQqDMBAG0KvIrB2If1S7FXqAbosLjV/t0DQJi
 RRBvLvB5du8nSKCINI92yngL1GcTSjyjPRntAtY5mQqVdmoW6X4t37Zu7jyZGBn1s64wF48jFh
 w3bUoxk7rpgKlwwe8Zbv+Fz0fPQ3HcQKcyOaBdAAAAA==
X-Change-ID: 20250730-mtk-post-blend-color-pipeline-498e1a9cc53e
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2

This series is based on "Color Pipeline API w/ VKMS" [1]. It reuses the
same concept of a color pipeline API but for the post-blend stage
instead of pre-blend, by attaching the COLOR_PIPELINE property to the
CRTC rather than a plane.

Patch 1 implements the necessary changes in the DRM core to make this
happen. The remaining patches implement support for this API in the
MediaTek DRM driver in particular.

This series has been tested on the MT8195-Tomato Chromebook with a WIP
Weston branch [2]. Both gamma LUT and CTM color transformations have
been simultaneously configured in hardware through the API and validated
(test commits in weston [3] and the kernel [4]).

This is a very early implementation but I'd like to get feedback from
the community before moving forward. For instance one notable thing
missing it to add init helpers for the post-blend case for the remaining
colorop types, as only 3x1d LUT and 3x4 Matrix were needed for gamma LUT
and CTM use cases.

[1] https://lore.kernel.org/all/20250815035047.3319284-1-alex.hung@amd.com/
[2] https://gitlab.collabora.com/nfraprado/weston/-/tree/post-blend-colorops?ref_type=heads
[3] https://gitlab.collabora.com/nfraprado/weston/-/commits/post-blend-color-pipeline-lut-ctm-test?ref_type=tags
[4] https://gitlab.collabora.com/nfraprado/linux/-/commits/post-blend-color-pipeline-ctm-lut-test?ref_type=tags

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (5):
      drm: Support post-blend color pipeline API
      drm/colorop: Export drm_colorop_cleanup() so drivers can extend it
      drm/mediatek: Support post-blend colorops for gamma and ctm
      drm/mediatek: ccorr: Support post-blend color pipeline API
      drm/mediatek: gamma: Support post-blend color pipeline API

 drivers/gpu/drm/drm_atomic.c              |  32 ++++-
 drivers/gpu/drm/drm_atomic_uapi.c         |  50 ++++++-
 drivers/gpu/drm/drm_colorop.c             | 147 +++++++++++++++++----
 drivers/gpu/drm/drm_connector.c           |   1 +
 drivers/gpu/drm/drm_crtc.c                |  77 +++++++++++
 drivers/gpu/drm/drm_crtc_internal.h       |   6 +
 drivers/gpu/drm/drm_ioctl.c               |   7 +
 drivers/gpu/drm/drm_mode_object.c         |  20 +++
 drivers/gpu/drm/drm_plane.c               |  36 +----
 drivers/gpu/drm/mediatek/mtk_crtc.c       | 211 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |   6 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h   |   2 +
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 100 ++++++++++++--
 drivers/gpu/drm/mediatek/mtk_disp_drv.h   |   6 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 107 ++++++++++++---
 include/drm/drm_atomic.h                  |  20 +++
 include/drm/drm_atomic_uapi.h             |   2 +
 include/drm/drm_colorop.h                 |  17 ++-
 include/drm/drm_crtc.h                    |  19 +++
 include/drm/drm_file.h                    |   7 +
 include/uapi/drm/drm.h                    |  16 +++
 21 files changed, 781 insertions(+), 108 deletions(-)
---
base-commit: d152eee7ae3b72e2ce70064a7ad9764f7ba8641d
change-id: 20250730-mtk-post-blend-color-pipeline-498e1a9cc53e

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


