Return-Path: <linux-kernel+bounces-838936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE27BB0766
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230992A17B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22992ED164;
	Wed,  1 Oct 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="trFvogi1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592A2E7BDF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324971; cv=none; b=Yt2m88VV7D4NNwP5PcEyqEAMZmECXU4xktY9HuOxtX34sjcU5L0Ju6InRr4cQb6ctdQuH7HqPRbtwpiL757gq74gPGLsNkc+8ykdTa+NYcArTEshboK8g18lli+4PYJI3PNjaNWWLTJzYrdMp0sMOnnAFoT0mXEas1MsqtBJEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324971; c=relaxed/simple;
	bh=tztn0kyH+Of9Zzr5Fu0ONfRf43JS7/RDhGUij6qb3Mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1Hu9UmShlK/IfXl1Oxh3xGx7R1q9H5OSb9mCP5ZANSUzmcuyiNzvNnRWXjUyU88tMdKKRUpCJs7UdO54IlcBA6aEHHtyzCzGV83iSEqwp8tcMK75ae/2ycCiMkO+JqHx8+s//vFf8uIO3XECY9aGPrPCXPzpa2zww2FHbJ7SpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=trFvogi1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 851A34C7;
	Wed,  1 Oct 2025 15:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324878;
	bh=tztn0kyH+Of9Zzr5Fu0ONfRf43JS7/RDhGUij6qb3Mo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=trFvogi1uFzgZok12UvXtGLQ5vMps/vUpD+ViH+qBXXINVWb5OdRIx61UyH2lD2Br
	 Rzstn5tMVb0NaOEwUcSnV/QXQPJtgPTdio95sCZwCdxmPPwkMQqUgjsJMvJNrdf5yC
	 vQKKhoB0HYzKR3QZ6ybfUECVXhtW8bVIffmApXYc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:13 +0300
Subject: [PATCH v6 01/11] drm/fourcc: Add warning for bad bpp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-1-014b076b542a@ideasonboard.com>
References: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
In-Reply-To: <20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=tztn0kyH+Of9Zzr5Fu0ONfRf43JS7/RDhGUij6qb3Mo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsgNVdn6D2ZZ1DR0l6y9qmAjyIft/P4xsvqw
 16HnW3NcF6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIAAKCRD6PaqMvJYe
 9R7AD/9Rk0zCfiabAmQpjRSsz3YvlbpBV7/QTYZnkKhQ0uknsZ/Gli54CQz3T+JYhbbzqlI+QRc
 h5pyF657doRhJPt7GfLcTfwKee0PNolFeBVWvZ6oNdlMPHzPERAUMf7lfy1Kxx3YgjF4mh7P5HV
 +Tr8t7NY14dgQarcCPlwCYDzwgtCji9Jpz9Fhps0T8woBZu1NJDTB7RahchobOo/Fjj1TBoXvIn
 UjKQmLjXk15YdiFupdI7EmDgi3PDRjk8txX6RxWyV7C9NbwL+cLwI6ZK1/QI2sdBtAcbhA6AKZT
 ohcNcQa/3b2RRXKzvHIIUGat0uw9pHF3mXiIUnWMkQbEV5iLZVKv+/SXGO3yGHaXO5YvAJ4mB0M
 sOeAzDBI76deLmoyPtjuOy7IkG7vehl5z/5fAWVEzrH81moCCo+oRpsNECdZdZLB+gE4NkWssUh
 oiJl32ZBF+1oLHaouU2HCWRK56kmGQ6Zf90x3ewrBxRCCq2Vx/Sr+7uW1mC5OUWna0zbkeGJmKC
 wOZIDNFwVb+SmCa3TIlEhP/hAE9U7CA/Lu0IRdpPdZ9p2dfsNE4RCCNPGQGKLz9TN+1gt7zsvDO
 0eEMdLDdh2JvI2tEvUPMAcX8cA5FrutpJ43QoiyYGju11AKBAhSy9tO0krZfecau0iC5dtahkbl
 2q5tp4+qtjL4m/g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

drm_format_info_bpp() cannot be used for formats which do not have an
integer bits-per-pixel in a pixel block.

E.g. DRM_FORMAT_XV15's (not yet in upstream) plane 0 has three 10-bit
pixels (Y components), and two padding bits, in a 4 byte block. That is
10.666... bits per pixel when considering the whole 4 byte block, which
is what drm_format_info_bpp() does. Thus a driver that supports such
formats cannot use drm_format_info_bpp(),

It is a driver bug if this happens, but so handle wrong calls by
printing a warning and returning 0.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e0d533611040..e662aea9d105 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -491,12 +491,20 @@ EXPORT_SYMBOL(drm_format_info_block_height);
  */
 unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
 {
+	unsigned int block_size;
+
 	if (!info || plane < 0 || plane >= info->num_planes)
 		return 0;
 
-	return info->char_per_block[plane] * 8 /
-	       (drm_format_info_block_width(info, plane) *
-		drm_format_info_block_height(info, plane));
+	block_size = drm_format_info_block_width(info, plane) *
+		     drm_format_info_block_height(info, plane);
+
+	if (info->char_per_block[plane] * 8 % block_size) {
+		pr_warn("unable to return an integer bpp\n");
+		return 0;
+	}
+
+	return info->char_per_block[plane] * 8 / block_size;
 }
 EXPORT_SYMBOL(drm_format_info_bpp);
 

-- 
2.43.0


