Return-Path: <linux-kernel+bounces-795862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BEB3F8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B461A8757B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD22ECEA2;
	Tue,  2 Sep 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROqW1Pv/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B412ECE87
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802059; cv=none; b=V4kD8OZtdZJG6pFceDBgAwXBh93c7H4t3u0Bp6X/nTWPK9mXhx6xPIS3N2tazdXIyaf/ol5zJ9vIKp2H8M4cAHL0NBFkvTmeWXKMZD67r7q+IaZv083nLFoNJwwZZDkM/akWVLCDaL1tfDTSwZgx5efL8nmk1hvaytWRivRKq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802059; c=relaxed/simple;
	bh=6y3aIMSfaSkH8Ni+8XNxtNqvzdtes72Di9oihgPJJu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sjwoxme5fYAq4INRTOmLjGzHXMDgG2DtZ+IOS4QU+M1Ng02Y9zHw4mRdHcgc06U059yLkCaxDQq+W0la4VTe9VYI5QbVQiL8f/Ogo57I0+G80TOuN+Tyudmie8DakeNJnisJsWRGXZ/vm4UBkAk5SGiYC94144DH570sk5tycPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROqW1Pv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85923C4CEF7;
	Tue,  2 Sep 2025 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802058;
	bh=6y3aIMSfaSkH8Ni+8XNxtNqvzdtes72Di9oihgPJJu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ROqW1Pv//GU9c/bbW5HHgd+xBAFtBD8xsXz/Uc4reii0BIBmGEmlQ8OCKuuMpy2J2
	 N5a9AMJySEOm5nIs0cI2PoQ4JswyEZIqCXYUAlPU+N7RAYJ1OctTqYNjFuMk3mlX+G
	 5q8yNTUrDTW62lfkJ9fHzMFPc9C5+ObaMNDDziva10aHl/74MqLcxvILq/LWmbftw1
	 3L/Mb/LU5Gk21uhkUCHrY0s/BkLuKVPPa3dIr0WVvy4wX8bZYHmWiGA5fHgZZ9WFTL
	 pOsYCNgSfGHcySt/9Mxp3701b/7IHBDRl/iR6Qh0qvzifnxP33UZOtGN1W9xlkoV8A
	 8qRUKfdSGJu+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:54 +0200
Subject: [PATCH 26/29] drm/tidss: dispc: make accessors accessible to other
 parts of the driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-26-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6y3aIMSfaSkH8Ni+8XNxtNqvzdtes72Di9oihgPJJu4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVh9wOcr5m3HGpdkK/8tfz3TzrfvioLjNav157wiFp
 e/MXrLadUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ2Iox1llMvyhXm+69pWtJ
 Tf8ubeHlqYu2xe/1NchjSm8onnc431PkcnzTsQ2Nf1Vf73m28/m3k4z1Qc2b/sxQPfF1q/jC3B2
 tRybdXPH13Hc2/sK1KYpFLp82rKvO3hu50Nxpwr3YW0wtt57sAwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++--
 drivers/gpu/drm/tidss/tidss_dispc.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 2f9cf95d6d0525a02d8adaae968aa551b7e27077..18b6beddfe51f9b5c164481ee2ef0fa289e63318 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -504,11 +504,11 @@ void dispc_vid_write(struct dispc_device *dispc, u32 hw_plane, u16 reg, u32 val)
 
 	CH(dispc);
 	iowrite32(val, base + reg);
 }
 
-static u32 dispc_vid_read(struct dispc_device *dispc, u32 hw_plane, u16 reg)
+u32 dispc_vid_read(struct dispc_device *dispc, u32 hw_plane, u16 reg)
 {
 	void __iomem *base = dispc->base_vid[hw_plane];
 
 	CH(dispc);
 	return ioread32(base + reg);
@@ -538,11 +538,11 @@ static void dispc_vp_write(struct dispc_device *dispc, u32 hw_videoport,
 
 	CH(dispc);
 	iowrite32(val, base + reg);
 }
 
-static u32 dispc_vp_read(struct dispc_device *dispc, u32 hw_videoport, u16 reg)
+u32 dispc_vp_read(struct dispc_device *dispc, u32 hw_videoport, u16 reg)
 {
 	void __iomem *base = dispc->base_vp[hw_videoport];
 
 	CH(dispc);
 	return ioread32(base + reg);
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index f5d5798de1ba550dedbcba36b1ef41d5ecceaa0c..b249cd0da331bf801992a7f38ff9031a5f8da0b8 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -181,9 +181,12 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 		       u32 hw_videoport);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
 u32 dispc_plane_find_fourcc_by_dss_code(u8 code);
 
+u32 dispc_vid_read(struct dispc_device *dispc, u32 hw_plane, u16 reg);
+u32 dispc_vp_read(struct dispc_device *dispc, u32 hw_videoport, u16 reg);
+
 int dispc_init(struct tidss_device *tidss);
 void dispc_remove(struct tidss_device *tidss);
 
 #endif

-- 
2.50.1


