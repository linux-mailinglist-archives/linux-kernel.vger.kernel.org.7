Return-Path: <linux-kernel+bounces-838949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4573BB07B0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7168C1946906
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DF2F260B;
	Wed,  1 Oct 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="khsU2APj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C432F1FE9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324988; cv=none; b=XymibS4jkJE68T2+htA+hX9Ij+FRTqEw5mHQjNhlmLXm6isSxHO7MImigG/ww/ns10y190iYSzm58VLSd6K29+er+06eonfn+wUMazRoLHDaKf3ysWu9V6T0CH0tz2mzV88GiO4cTeUrI+xb10VCGRb2x8wlCIVGA5JelO8AufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324988; c=relaxed/simple;
	bh=LLJhV2LallcFwhanB+wQUXczMwB4XxYcFq1ZLrudUL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4OELVN1+2JtboGwE8AKYDP9bY/xa0e14/haBs1sCrO6Rd3/Fj+97zIEPoeN6+gVxjhSIOL39bGAoB47ylh1nLUgw7pJQ9e5ZbY2ELtsZKNhHtmZQAVO333/RjGV8Bai96IWHsUEILKbq2wX8Px6I7hYxQ91BU3EsHLxDkfPOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=khsU2APj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9740EBCA;
	Wed,  1 Oct 2025 15:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324888;
	bh=LLJhV2LallcFwhanB+wQUXczMwB4XxYcFq1ZLrudUL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=khsU2APjJexd87l2z75tK1gHeG0zowsOkrWUFz4T8bNHeWWeyTJuo+5ti5ukumoMB
	 HN+9fsC2jmfhqIopDyX7BEITpyVphzlI7arew8hrIxwOSt7K+WBNorVd3nTZ3pmCur
	 MYzeiW04kyy1wOB8eofyRkgoWxD5HGXepx7a4Xx0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:23 +0300
Subject: [PATCH v6 11/11] drm: xlnx: zynqmp: Add support for XVUY2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-11-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=LLJhV2LallcFwhanB+wQUXczMwB4XxYcFq1ZLrudUL0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SskGYeMExv8ixkDTqYrKTmF3tPIjgjyGFyRK
 QMDlXQyH+2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rJAAKCRD6PaqMvJYe
 9Rr0D/9fZ27rpk5xGJjeLhWt5a2DSEgBz5wrzK1MfCjEdkqcAZGoEFaBVRhY5GhVwwKByglXoDw
 SnKgiPxnf4d5M2TYHR1yuLkAgzEkj3rxZweK/h6m0A9LuXVmQc1a5Fb8zKuOliTw50i0/fTdQpJ
 /03mwFBDna82lA7ZiEfLgHaIAPuWQpeu1X5RoDt6sC/ulv/d3OeOjcirNk9HWXwMB7r3296THaS
 h5z3+bMFl1XrdzZM7zHMNcjcht6wFg1uwJyROFNOyHgqwQ8pxLxVmQYPUDe6UHWSjZaNaWVeVyF
 wNWzvg1emfigMt/17nU5EipujouJ4ECuctiK49pYCMsoOXi23x/wokvzLg/322lylWqJHGwacMz
 fnHN0qhVjDTENWMca/dgEceTNUV1mM8UvUaYJmy0DpJisQmJXQxPhBxcj591lnlP2bhsyGt/j48
 HACDVG2fNHpEVeNHT+A3m+gNqnfW0Qew1uKQnJbaBlLhNux9iGAWfefDf8DO8T+rPgLPhZOK7PW
 w2YzbHK3B1HEUDZr87vKVvTduGBqJtg15lulOA+MxcWisyAKGjvb352KdD08OcARcPufbi0aUyc
 uoKoncrz7Pc/ZopXgqm/h5ceAOthWo7/s0uSho8oRkKWWi5EbRoiaHZrw4ky7R2v/qHMVj9T3Wc
 zZqhy+QLz5qgxbg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XVUY2101010 format.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index b7cc7a7581ad..f548f375750e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -322,6 +322,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XVUY2101010,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YUV444_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


