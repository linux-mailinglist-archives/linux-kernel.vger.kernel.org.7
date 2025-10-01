Return-Path: <linux-kernel+bounces-838948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FEEBB0828
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A13B3BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49EF2F2606;
	Wed,  1 Oct 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iXw0QNt5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C12F1FD2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324988; cv=none; b=sz+7s+jbrCcg1jwj5QW6xps+V+Kun5a6eqTybZNZgbFJAu+kxb9VaFJvSeoQaFVpZn1yD19TpobMzw++OceV2DYubMHeC4PZyYxatYwvhnmkB5WZ5IEnVc+tW3lbr1c8+vE32A/MalX2mvnD5xheqQxI9b8fqgPbUqWlq01Yank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324988; c=relaxed/simple;
	bh=Z4gNQ9UWmg8H9YFAi8N+jXqbfBppeZnMk/tmq5k2slI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUCjeMOBRJYtfi2V4w6duqNQfzeT1SfpcN30htMQEdjFueazzmWuGWoNnhrBGeKYqS1R58Q377ZVGpE3vcg3YjOHyaGooqc7u8imkNUzstmTaZLj1sxrX3MJpK0+Ojr50hjdCp2DRyZXL0YT38HkS7DVeQYndLo27Jt7MrSKgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iXw0QNt5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B83D19AD;
	Wed,  1 Oct 2025 15:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759324887;
	bh=Z4gNQ9UWmg8H9YFAi8N+jXqbfBppeZnMk/tmq5k2slI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iXw0QNt5bU8P8raD8mTzXneQXaVochjSwjAIh8vIUYNORHRz6hTYyNDMcZOtYz6Gk
	 Pnk9lmsmyK9HleUt+UuhlEbejANCBP7QBqrEoRmAvluAtHVXcxtCi0Bgmy//7ZqELr
	 yCPjgnSVBR0CJuTYPg6UZslspfwgN/URCc2UfXyQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 01 Oct 2025 16:22:22 +0300
Subject: [PATCH v6 10/11] drm: xlnx: zynqmp: Add support for X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-xilinx-formats-v6-10-014b076b542a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Z4gNQ9UWmg8H9YFAi8N+jXqbfBppeZnMk/tmq5k2slI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo3SskYkFp71Muh/vUeiWioR8OLa3U9Z/Il8HAI
 lOM9I75I8OJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaN0rJAAKCRD6PaqMvJYe
 9ak5D/4keFN+7hSFuZnonz+gZBC9uEwApG91/goDKyuXfmHO2g1O3ubofSDBSPvup6LdJUQobdz
 Ye5ROKzfhx+AyeFVcwcjAVZPP96nQxFn6jOd5J8X0qCT0gI6QeJZaOD+7YOgIL92bsJbZ8hbIPp
 EJnC4ukbUkzgrWejxmeV06/o1XISDsvPsgrU10PcjMzcfSEsCPcFfyHeJDT4AJujxdNOMaToeqb
 mx9aTzI5qyrQhgT9RPaNPxZ9XC4Yktt406dnv2KMkKNZxz6As7fgNreAPjq7KckthBMc6tKG9Sd
 4qyZkIjjy++saCjxL0QYAHnW78K2/BjeNW3Y9LYhgVDpW36xFWP0acqBje1F4AFrwa5pu+QjS7i
 4E08hnN+vFQ/YK6Cj5CswnGg7y3L2tgivO3FJymWBTShsjTg8OjtCJrkeo6rLMAyMtYLoiI3BMt
 gBTpqAWrGksduaEU3XuyWQBXQOE1gh2EOVd09ziE1/OSuDOThqD/pzmB3RJ28zmN6lcb1ihzJrG
 cm2GCA6fJOcjmSJZE2cSxFQ7d14F28Vb7QHisMwBt0Zt7bpkhvTGwKhKqxx9a9IeWDRENNmvxCy
 9OuB2/vrdjb8SlTyU1vsfKa1UHZTE+cmKtfmdqv68W1YW2XvgoMxGxqD2dJs+KoCFpIUmaafPRw
 6Iucigxyk+8Ge7w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for X403 format.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index fe111fa8cc13..b7cc7a7581ad 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -317,6 +317,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_X403,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


