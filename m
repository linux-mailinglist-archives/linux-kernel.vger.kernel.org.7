Return-Path: <linux-kernel+bounces-741046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D926B0DF67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA55831CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA12ED865;
	Tue, 22 Jul 2025 14:41:57 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC22EBDFD;
	Tue, 22 Jul 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195317; cv=none; b=iCIdPR6MhXmKYvVxrx7/apuhIPf4TqJraLjIlfTtsPnOSahyNjzlUoLrgBun3wiR/kkJnS1wZvhayr+IZBF1W4e2pi+Vv8kr+JFnnATBFeuit02gHAiYkx4HKDt3HGbviZxpFASq/Oy0XN2Qn9DSoijJS6gs4NZroLlrqded2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195317; c=relaxed/simple;
	bh=CJ32DjOptoB7KvxuPypA+ror4zNwEHUflLxk4bWDq+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF6NI7aul03fY5463JzN8w6YgfDVo7fHQ6vzk3kSwwKvJOHa+q5v4snJcsoCYPKLclNNV0HezmSdzRddqT6830YnOyx5CGRpjabi9FqsuDhvIMvt8YFvVrJiSi+JArt0vDARSRyI4E7dWfV0/5BcRUdWFs7MEl8e9Vhd0D66N3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 2BDD61C233B;
	Tue, 22 Jul 2025 16:41:45 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id 9DE371C07C3;
	Tue, 22 Jul 2025 16:41:41 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:11 +0200
Subject: [PATCH v2 09/15] drm: sprd: select REGMAP in Kconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-9-054276ec213d@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
In-Reply-To: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

When compile-testing this driver with all other drivers disabled,
sprd_dsi.c fails to compile due to a missing definition of struct
regmap_bus. Ensure that this does not happen by declaring the
compile-time dependency on regmap in Kconfig.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
index 1afcdbf6f0ee3304f2297835241c9bb10d422154..828384d42c5aac4bf194558f22d9a77f7c693572 100644
--- a/drivers/gpu/drm/sprd/Kconfig
+++ b/drivers/gpu/drm/sprd/Kconfig
@@ -7,6 +7,7 @@ config DRM_SPRD
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
+	select REGMAP
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have a Unisoc chipset.

-- 
2.50.0

