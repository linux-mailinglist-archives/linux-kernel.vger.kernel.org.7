Return-Path: <linux-kernel+bounces-733646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B10B07756
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E871C4027A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86D202996;
	Wed, 16 Jul 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAo5FcRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4114A09C;
	Wed, 16 Jul 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673660; cv=none; b=ia024UfoHFMYPzLtUfCWsNLo3RnmkJaR7D8VgIT336PyInkUhKfyb1CiBHMRdkhuv0e29qKVRsjBJdnhx5cknEe3QJJUPjnYsN3XZILqRPIYrzGY27Xldg1kERF0tj4imIVEBzh0kiSTb9bHLxJn5MdGoC4R7/3jvUAHWr1cijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673660; c=relaxed/simple;
	bh=N/5vs2O/O/RBR2chqPpw/Dxeb040MtYLeUEhMQ9qX5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glRTklL6ica7D1WZ8aQL30TAbkTiGooegflfj8E2sPIBhTfbYWFXL6Z1Hqfb0KyiKCwxoLtyQY5fuiQZLLBPyn9m21GmPffsn534hW4LPxwJbykzLNnstgL9uSRpTazbp78oY39xILXhrc+ugm8oAJ3zcJmu11WCvfaM++1qlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAo5FcRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2563FC4CEF4;
	Wed, 16 Jul 2025 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752673659;
	bh=N/5vs2O/O/RBR2chqPpw/Dxeb040MtYLeUEhMQ9qX5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAo5FcRN3PXz9NMNZbBrnh5FsWvEZAldcGzxToXaPCn9L6QZ1G2PxLG1TtSbFXbD+
	 UCO91ePfKzLoJS6NAPQelNjTppFvVUpX14k19rb7VUlHKFufBDBg59xFG/kbL01O/c
	 bvf3EIbrQfFOjM911H5/xI6MK6hSDm+BiJmFlto/wAPgGAnXI6//3Cb4HHILwc5EcC
	 qvcilSKvD5kefx3BaY6EI3g72PRLRi/QKW6iQHt4geq4m+noGkFtc8yZp+jwyZIQC6
	 bqafS29hdEf1WK0HVBn1wfigpzm8PvmAx2tDNsuW9hEOBhvNrv2MRgGmnT3A+VDMeT
	 J9wzrSTL6uL3w==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH 2/3] drm/imagination: fix clock control on the J722S
Date: Wed, 16 Jul 2025 15:47:16 +0200
Message-Id: <20250716134717.4085567-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716134717.4085567-1-mwalle@kernel.org>
References: <20250716134717.4085567-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J722S won't let you set the clock frequency if there is no device
using it. Thus, the assigned-clocks property won't work per se.

As a workaround, set the clock again during the probing of the driver.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/imagination/pvr_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 8b9ba4983c4c..e7a7cc1bdf93 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -16,6 +16,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk/clk-conf.h>
 #include <linux/compiler_attributes.h>
 #include <linux/compiler_types.h>
 #include <linux/dma-mapping.h>
@@ -641,6 +642,14 @@ pvr_device_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
+	/* Set any 'assigned-clocks' properties again. This is a workaround for
+	 * the clock handling on k3 platforms. There, one cannot set the clock
+	 * frequency until there is at least one (enabled) user if it.
+	 */
+	err = of_clk_set_defaults(drm_dev->dev->of_node, true);
+	if (err)
+		return err;
+
 	/* Map the control registers into memory. */
 	err = pvr_device_reg_init(pvr_dev);
 	if (err)
-- 
2.39.5


