Return-Path: <linux-kernel+bounces-876271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35481C1B3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258596E0552
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337583128BD;
	Wed, 29 Oct 2025 13:47:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2C2E54B9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745662; cv=none; b=sOHq9e5XYbrwhYEqw0I9IjW5AzQkxRIyiJ0HNqtQSP4TOLLO9iQtZ2LHy9r5CH5tmyzHEvmVfIx3r8TUCgNCV8BYAhD+dH4oE3IYw+aYa3Ew52r+ztyFUrp02tFHsNjs4yJykCZYE4oqz0lQ32P/pDAUjQDwXpfuPrqUW7n4jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745662; c=relaxed/simple;
	bh=zW+sN6SKjdscQ67npb2WOEkK2UoV7iuiWl78es7T0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPObP0M/FDzQVRk/lzYnaJXjv+JH5OcGz1qX2e+l4MN050eVhayfSPpCUw5s1RaFaonuzFJtSe4wIRkHElX+Cg3NbBreim3/gVOvqR03KBY5w8qgYALLNmrfV2TMXYhBYTYWCbN22X0POoqAkfYUwPeT+QG70WcUeX3bximiZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C2CC4CEF7;
	Wed, 29 Oct 2025 13:47:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Donald Robson <donald.robson@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/imagination: Fix reference to devm_platform_get_and_ioremap_resource()
Date: Wed, 29 Oct 2025 14:47:35 +0100
Message-ID: <2266514318480d17f52c7e5e67578dae6827914e.1761745586.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to devm_platform_ioremap_resource() was replaced by a call to
devm_platform_get_and_ioremap_resource(), but the comment referring to
the function's possible returned error codes was not updated.

Fixes: 927f3e0253c11276 ("drm/imagination: Implement MIPS firmware processor and MMU support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/imagination/pvr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 294b6019b4155bb7..78d6b8a0a4506c80 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -48,7 +48,7 @@
  *
  * Return:
  *  * 0 on success, or
- *  * Any error returned by devm_platform_ioremap_resource().
+ *  * Any error returned by devm_platform_get_and_ioremap_resource().
  */
 static int
 pvr_device_reg_init(struct pvr_device *pvr_dev)
-- 
2.43.0


