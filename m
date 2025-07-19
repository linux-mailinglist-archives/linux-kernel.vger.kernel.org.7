Return-Path: <linux-kernel+bounces-737604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EACB0AE44
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F033BA97C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE512222CC;
	Sat, 19 Jul 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="DAfrqHNI"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B861E51D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907618; cv=pass; b=CXssu16UBDbX4i52gprh1TZIvy2MydpkLDKc/bHtbxn+S895RiX8Ez9BBf3S0cBocUjeTn6lCXQ9+b2qF6A8nAM2gdR+NZE86U/8IGSbQ+nFU3gQmpUrnbcPKI89SXWEn9wrUql4F9KPxTlW3fp5cXY2unGjRsnD+n+SkGdQlk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907618; c=relaxed/simple;
	bh=P82HZxG3L48rg4ge5f70V0N8EO916obPJ7k3B7Fd3jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KEiex0Lgyzu2sHrpY8lIJhVjjhDv+Gzkf0rdq5uNY/fHjEPuslO2UJ52yQLrwF0rqTZquHQP9IT23e6vSF7zniiDA6OCY56ifFuOq9AFlKlzQIDXng32zPznymQ44elwseiOkgOJ33ygui0OvpD6EaqmRWF1BvO+C2/zJ9FRqok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=DAfrqHNI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1752907597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tv5PtB/Hu0pilIetNsmQ8GuCl9Blw4g6utc7I3xb4Gg5bSglvP2IAOT08JkoaDtaueGoGl7W8XeV/kY7B18zEueCZHOQBw7FkEOCZO3DUqKzEWDtioxvGrSuDLYR/00ExjqNmutnCPMKZALgIA9M68wjPjS/SLDOuZ5YkhRIhvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752907597; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LHHndUs+/G5YW9qx+xWQMhGSrQiJOYOxKpwiXLvTjD4=; 
	b=J9Gg8BZ4Hu8LrN5jAWdG8xXcdN8RODt53r1YHiqUGw5Mw7fYpnmp4GchY3OPUF+zf4g1Vp4QVybOn4DGEctAhvFrELtGyP6BqCUiBSeJppQP5APttY42mVQHG7XIvI6Kce23ty2h87kBjjeiwLSFh1UvQXEvAuL/cpGErA5fmBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752907597;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LHHndUs+/G5YW9qx+xWQMhGSrQiJOYOxKpwiXLvTjD4=;
	b=DAfrqHNIFLYKxJLY3UrTlPvNkcRk3XRcSOk0Ql1kUxWQUg6cqmAiBurjZmFU76dW
	ik51svEVHL17MoIcOHDU1mNTDgkOvIxvE82drY7SOhLIUKg5pWOfEvY00ojmu+8xTxJ
	wKKVGNQTMrSqOLwoG4nF3xsezxb68HvJhrxSY3aQREYlkKCxdWD/POS+qzjUoQMWpkb
	NnJqloVoYPaBPMan/hmGfpVo8mSXkXaiVyoyXN9aXz9Z43e8kDsZTYYf8vKYlIIBve2
	Tji0PASQhUY3GDgYjsc9Ibko3plTz9gvo2gvQXSg4nIpg8YQ9euAThOxEJX0Jb1hanV
	OX0PGejKGg==
Received: by mx.zohomail.com with SMTPS id 1752907596122572.0044863390824;
	Fri, 18 Jul 2025 23:46:36 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH] drm/etnaviv: set the 32-bit coherent DMA mask later
Date: Sat, 19 Jul 2025 14:46:24 +0800
Message-ID: <20250719064624.690606-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The etnaviv driver wants to use 40-bit DMA mask and 32-bit coherent
allocation mask, to be able to access memory up to 40-bit, but still
limit page tables to lower 32-bit.

However, the call to of_dma_configure() next to setting the masks ruined
everything -- of_dma_configure will use the coherent allocation mask to
clip the DMA accessibility mask, leads to a setup with both masks as
32-bit.

In this situation PRIME imports stop to work because of SWIOTLB getting
activated.

Set a 40-bit coherent mask before of_dma_configure() and then the real
32-bit mask after it, to prevent main DMA mask being clipped.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
This patch is marked RFC because the practice looks a little dirty.

P.S. unfortunately the testing situation isn't mainlined yet -- I am
using etnaviv as the X.org 2D accelerator on TH1520 SoC (with
xf86-video-thead DDX), and importing buffers from powervr device
(open source Vulkan driver, hacked to add xcb WSI support). Both devices
are a few patches away from mainline, and the display engine
(VeriSilicon DC8200) support is a big TODO.

 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 3e91747ed339..cded63904c65 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -650,9 +650,11 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 * To make things easy, we set the dma_coherent_mask to 32
 	 * bit to make sure we are allocating the command buffers and
 	 * TLBs in the lower 4 GiB address space.
+	 *
+	 * As coherent_mask may mislead of_dma_configure(), set it to
+	 * the same with main dma mask temporarily as a hack.
 	 */
-	if (dma_set_mask(dev, DMA_BIT_MASK(40)) ||
-	    dma_set_coherent_mask(dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40))) {
 		dev_dbg(dev, "No suitable DMA available\n");
 		return -ENODEV;
 	}
@@ -668,6 +670,13 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 		of_node_put(first_node);
 	}
 
+	/*
+	 * Now as of_dma_configure() is done, we're now safe to set
+	 * coherent_dma_mask to the real value.
+	 */
+	if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
+		return -ENODEV;
+
 	return component_master_add_with_match(dev, &etnaviv_master_ops, match);
 }
 
-- 
2.50.1


