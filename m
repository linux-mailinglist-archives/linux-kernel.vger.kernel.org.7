Return-Path: <linux-kernel+bounces-838945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1642BB079E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736721946A05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A97D2EDD40;
	Wed,  1 Oct 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B5OBzdAt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA82F069D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324984; cv=none; b=IvyHwLCB9Ff0wh/5kDGZd62AoB0lzt0FQOB6AWGoFLAlQdzH5JlBywCLaRQ8Y2poUh0wc1I/laATvupY579Uyth9yMaB26sr5tSLi0FLqZ32cszqbaOS9ecNUlhjY+vsttFSnOORp59h1iVh9UQTqHPW2YS0hA0Gzzk8N9fURWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324984; c=relaxed/simple;
	bh=BqlrzuF9SVJTOtBOmexpRoqMva+a0mHR+U4P2a9DVlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENxZdfjLh8MD6zo+PE1tosgDmJEuNJ5nGb/s0DiIQGb5Jw3XDoPAXkJgaj9hAxdj1rwPmhUT+xD2zUFPOcDa77lW0mqZ4zHskVZsQ847qIwlz6gUCVDtyzA9Y0XIrki5qWg+uBV/P3luKxpkgwKOWu2zicQFB3jfkoXm2Kke+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B5OBzdAt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9289D180C;
	Wed,  1 Oct 2025 15:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324885;
	bh=BqlrzuF9SVJTOtBOmexpRoqMva+a0mHR+U4P2a9DVlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B5OBzdAtSXH4tuM/4M8eQP/nyhHxgBAxKnN9LfYaT5nmlcZ0nuO85AUOkbTtup7/r
	 Py07Zp3bCxU0k2GSJuNA8JYiUBsvEmJgc139K4rHXjBH21L1vnkI5FmH3fezl1cpqT
	 y8hTh7Z8ufKvWf6PHy/bBmokGGr7vEriSysRlcig=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:20 +0300
Subject: [PATCH v6 08/11] drm: xlnx: zynqmp: Add support for XV15 & XV20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-8-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=BqlrzuF9SVJTOtBOmexpRoqMva+a0mHR+U4P2a9DVlo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SsjlBsCG6t2EJC+t1j88FFLXFresjnC6b7jB
 ZgExwo3eAuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rIwAKCRD6PaqMvJYe
 9WKID/9yRLmLsjiJGOt210NG9qGYGs6vsLOCMZ54xIYxjrIuzdmHGau6rb7lIgYMj+xZPBcGOhE
 sp1USHd/9gbxt4P+aLaMICzaq1OdLchZS0mI4oOYh/fHmEHaMExLLaR4MXKVmMCS2izQxmGNWfL
 Vzw/8XdwWaUvYpsXi4bVzfPFkLOGKgjkUKyRGFHFi8R+8aAyLJZd/BM8T+8jiFZLmToj5CZd6A4
 o/Bsg7b8QMjsagnF7+8na5zVeHEFfgMTwVerPz+TxmjfIiggAy0DJcy9+550V9xBe+zTiy1HJc6
 CvJHoYVy5sS3P189nItNYI1SZy5Bx7yJUwCMxXfEfYtH/CHh5zJezFeqHU4/B8pTVHx0RAfH+CP
 3g4hct8AWOWFgxd13jxATWbvjBnLRaNjBrtNeEqvaky7xQN2/6YoI08n8KqqQWOk2OUn1ksP7o9
 hhs5qPJ6nZwRn6hhskz/JVYXsNblDYzhMNms20y9MGdSHv76toYTSb2HQu2ateQUIMQXgWK5UYu
 K8Jc7CPOAzYNYScpNzvHzA2LEvEHuNBvZaGw5Y/4AXaXxn9DG6GWOldQkEezSzZFLd1cCc/vR71
 MaIDl5Eq29v4b8hmuIURNgGO+oKSEcNuDvBmetpA8Q2JxCAcZ6vxLWaw1lLxwCd2EgPK+PxqR/b
 pfhhZRLAhj3hAZQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XV15 & XV20 formats.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index b9883ea2d03e..1dc77f2e4262 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -297,6 +297,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420,
 		.swap		= true,
 		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV15,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV20,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


