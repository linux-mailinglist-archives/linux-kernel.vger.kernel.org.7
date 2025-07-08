Return-Path: <linux-kernel+bounces-721214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B19AFC632
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381F17A6FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D32BF3E4;
	Tue,  8 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7YsaUmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632B2BF00D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964741; cv=none; b=mcAhrXY5CRsJSO6aAHsbZR0YK57pDdwe6Pz0k4YeKdpQb3i/RR+XuxPRSd8Vbko6AHz5gJ87b9/UfmZ/Fq1zYTJE6kt1eMYyeGJ8AQDstp0OBNXWxZTbacDsW23uvp0NL9kZKWgr1rdq05HIyWxX2ILEmw91dd+oioMeljKtPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964741; c=relaxed/simple;
	bh=QIqY2h1NWf9cbTcj6mUj2T3JGhmfNBfrg9dpy8GlrF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbDJaZqzo2c/nwJ0h/yNBh4JEpXeLo5DEyJvZraP4rpMxn7X1j6UV3IrXdyq18vsOrLeYx7PG7EKs8MuAgOVnSS+hXSw/JUG/J9/4qOP76ZRmd924XmTsYyr4JhLNNL1+JkEkq0lXX2s8EIX6oEWAKj0oMXBhwasuMWcdHsxqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7YsaUmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8BC4CEED;
	Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964740;
	bh=QIqY2h1NWf9cbTcj6mUj2T3JGhmfNBfrg9dpy8GlrF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7YsaUmVCdo9PWttJRs+Qb0hOI4FD3haWcT16lpz/lEu4mHt+B1iUFFv0rQ7A/jTb
	 6t9yMwH+UdZXYs6yY+wjFuvvdX+Q1bmFaVsYZ0RMg22vxcwwYYS62oNFd2Ml3+Bcei
	 ZLTh2kP8/aBDlMeMpgD6H0V7TZZOPjo6eZrHJLtNz8NUSPN2lZSNhhSzj2saAG3HKq
	 VP6+WrxU9ULoYEzdSKH6UHTL6VKcUUsJZR2ZBKgtIo3JPwqtzc6HnBcXIGW5BDeYDt
	 T2rFCoK0udDUw0NmdEZw3TXT5fBfHTiLeCyALTQsPPIWWAHxKZs4r1M/XQognu64Dt
	 cubAg4HkHvsDQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ43g-0000000042H-1tXm;
	Tue, 08 Jul 2025 10:52:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] drm/bridge: fix OF node leak
Date: Tue,  8 Jul 2025 10:51:23 +0200
Message-ID: <20250708085124.15445-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085124.15445-1-johan@kernel.org>
References: <20250708085124.15445-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node reference taken when creating the aux
bridge device when the device is later released.

Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/bridge/aux-bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index c179b86d208f..6642ac6819a0 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -17,6 +17,7 @@ static void drm_aux_bridge_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
+	of_node_put(dev->of_node);
 	ida_free(&drm_aux_bridge_ida, adev->id);
 
 	kfree(adev);
@@ -64,6 +65,7 @@ int drm_aux_bridge_register(struct device *parent)
 
 	ret = auxiliary_device_init(adev);
 	if (ret) {
+		of_node_put(adev->dev.of_node);
 		ida_free(&drm_aux_bridge_ida, adev->id);
 		kfree(adev);
 		return ret;
-- 
2.49.0


