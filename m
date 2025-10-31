Return-Path: <linux-kernel+bounces-880715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CBC2661B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EB742598E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FD3557F0;
	Fri, 31 Oct 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ecJtDpaW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021F350D47
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931721; cv=none; b=cmZZYR5nYGW5aevKncVZJj9XAofE+oTa5Zsyi5pH7u6ZrvDgYRyZdAa0wbpenLR9PfoPhrF9XWY+7tTwj2qtfooeCMbiaezvAjnc5JSKmD6m3iUhndv38ZHO01AHFy7HHH3SYmtQDiDFRQSSCYFleot34eyKVPCeUThR+2oAsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931721; c=relaxed/simple;
	bh=L2jskCFzVI8vu/VxoOiuw8oJHvcjhXC0BGW7Tik0EZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbSB3tWDEZYjE3tXCd+0V0bL1Yx5+WTz4UKFh2y0dx3oxbV5lxoxD7zGuRgQNfO+pU0bD/QznlruKY+fx4TdKuWjHJKrlk0MIL2E6kFMFdUztRh1Q0PWdZbc3bTRpFHyih8UeIdszWhHU1miCEoARyABZ6QNuPlIN/E6ol32IE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ecJtDpaW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12DF3B5;
	Fri, 31 Oct 2025 18:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931607;
	bh=L2jskCFzVI8vu/VxoOiuw8oJHvcjhXC0BGW7Tik0EZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ecJtDpaWBSsdWbqTB9WfO0ZAgCfK6oPUBQFzr4ywkc8ILhY7PBrk287JgiwN8iYgX
	 +aJOUevbMNbzDVzfQyifE/oRFZIc6qgbo/i5RrWT/GEL48whOkLQLKJX/jjrxAydkU
	 mKQ+vN2+hTsI/y1wDef537z7BWF5pDJFHCizyLCc=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:26 +0530
Subject: [PATCH 06/13] platform/raspberrypi: vchiq-mmal: Update video
 parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-6-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2277;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=chq8KEMAdpSsSzxQiDjebF7K761kG8qgjKO6tzXXFxo=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGZeNUdnT5uwGciICWjn0Bs341CwEpZvzpCw
 F6gnxeQh7aJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxmQAKCRBD3pH5JJpx
 RXzsD/0UKwNYQXhWfszp1SLk0j7aatmNyK4ciO8eqrV2Qq+TfuYyP79JDN7/nwMKwndxEV4MiBO
 3oOMK8DR9kt+OiAfIxR7I5Ccb637XMmOVj6EHcZUUA9HsmOYpZfERK9isM44t/2L4lB1Pv9MjDe
 OdXSxrQqw1qWGMvZyX+v1tSWF8K5MKeNlqN7sqtHXKKAS4BIaD7ZwWQbsN6PzkfLFUkFu4oKRsC
 pyCXm3wbRD2P3OBdZOJBq1UXrlO7jVRoavxU32hce80+2OYnOsB5Rvj1a2Wuak3BALVtIB6+gNy
 TCjsskoEsQL2T/6u3bB9QXSCBevOPjFeOBgNXV9hfzEUB7nNIfg7LNfuTMkCg4ph9cYx5GS7F47
 kkgmpcbzruKOkI1eszELBykdlzJuXLAIga6PayDg/sdq4Hj6D7XsI6A8k2vA0TCJY+Zv1qLArlp
 sZccIkJ63nylB49Q8QY4eD5CEMDQ0OxVQMuoFR0rFUzZjvrGOYWKYJRM9FuxjsM2pJp7onoOkUF
 FQyYhsCNjSfvOpifwJNQMzndAUTu24n1zu56tSLZIH2ZV1AGwGxsBE/4zJoznSZ7/tb1W6SrRiu
 /2iQqDdYzpp7a1tvyV0JGfFLJJpVilUifHmLefxy7w8GIBQneVXnALlOw6KNLxvRbADnN2Dk9gS
 7CLz6YS2tXlKTtw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

mmal_parameters.h hasn't been updated to reflect additions made
over the last few years. Update it to reflect the currently
supported parameters.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
index a0cdd28101f2dd67fd6b64ce1c95c0cbbfe15fc4..0a4fc9252b1798d883047e22bbfca050017f938e 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h
@@ -577,7 +577,43 @@ enum mmal_parameter_video_type {
 	MMAL_PARAMETER_VIDEO_ENCODE_H264_LOW_DELAY_HRD_FLAG,
 
 	/**< @ref MMAL_PARAMETER_BOOLEAN_T */
-	MMAL_PARAMETER_VIDEO_ENCODE_INLINE_HEADER
+	MMAL_PARAMETER_VIDEO_ENCODE_INLINE_HEADER,
+
+	/**< Take a @ref MMAL_PARAMETER_BOOLEAN_T. */
+	MMAL_PARAMETER_VIDEO_ENCODE_SEI_ENABLE,
+
+	/**< Take a @ref MMAL_PARAMETER_BOOLEAN_T. */
+	MMAL_PARAMETER_VIDEO_ENCODE_INLINE_VECTORS,
+
+	/**< Take a @ref MMAL_PARAMETER_VIDEO_RENDER_STATS_T. */
+	MMAL_PARAMETER_VIDEO_RENDER_STATS,
+
+	/**< Take a @ref MMAL_PARAMETER_VIDEO_INTERLACE_TYPE_T. */
+	MMAL_PARAMETER_VIDEO_INTERLACE_TYPE,
+
+	/**< Takes a @ref MMAL_PARAMETER_BOOLEAN_T */
+	MMAL_PARAMETER_VIDEO_INTERPOLATE_TIMESTAMPS,
+
+	/**< Takes a @ref MMAL_PARAMETER_BOOLEAN_T */
+	MMAL_PARAMETER_VIDEO_ENCODE_SPS_TIMING,
+
+	/**< Takes a @ref MMAL_PARAMETER_UINT32_T */
+	MMAL_PARAMETER_VIDEO_MAX_NUM_CALLBACKS,
+
+	/**< Takes a @ref MMAL_PARAMETER_SOURCE_PATTERN_T */
+	MMAL_PARAMETER_VIDEO_SOURCE_PATTERN,
+
+	/**< Takes a @ref MMAL_PARAMETER_BOOLEAN_T */
+	MMAL_PARAMETER_VIDEO_ENCODE_SEPARATE_NAL_BUFS,
+
+	/**< Takes a @ref MMAL_PARAMETER_UINT32_T */
+	MMAL_PARAMETER_VIDEO_DROPPABLE_PFRAME_LENGTH,
+
+	/**< Take a @ref MMAL_PARAMETER_VIDEO_STALL_T */
+	MMAL_PARAMETER_VIDEO_STALL_THRESHOLD,
+
+	/**< Take a @ref MMAL_PARAMETER_BOOLEAN_T */
+	MMAL_PARAMETER_VIDEO_ENCODE_HEADERS_WITH_FRAME,
 };
 
 /** Valid mirror modes */

-- 
2.51.0


