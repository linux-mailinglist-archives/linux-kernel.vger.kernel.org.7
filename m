Return-Path: <linux-kernel+bounces-876208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B3C1AF77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BF9586943
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667CE34E759;
	Wed, 29 Oct 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dVGPvrbw"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434434EEEC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744667; cv=none; b=XbvAXVrnXj53IM7qKjBRkbm9OdzICHnNOPFJFhwRKTMdaXLT7NX56wfnjig8dXUwlOXD1rdqtERzt14ZYdYiB7ABuRiu8zyTmgPTqHR0Drym5hhFUWAMnay7RMdLdTOB0yUv7I5/E3XZYShSGeE5Mn8G8kc0VP2oJ+65Qce+i0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744667; c=relaxed/simple;
	bh=to6N0s2e3g5+ds9m2twnzI2TlMbRSBVJUFTnMgjwSAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXISLuWG4u1L2lTmp3ODyptxz3pSR1IulcXZDgNxazY1bLIdhmBDnofCup4pY320a1TVVwLl9pgWCQasLUbQyDusLgTU3cF6EhOaA5MYUIpoXiaGQajUExXYhs00wSoey9cSJG3C0yQcgYdJZsGxaL6Z6bkY6tvwZ96Qxk9kaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dVGPvrbw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4BD13C0DB01;
	Wed, 29 Oct 2025 13:30:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A35F5606E8;
	Wed, 29 Oct 2025 13:31:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75B1D117F809D;
	Wed, 29 Oct 2025 14:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qMP9RjOBCxKmLcvhFceO5QO4aOVeU1xn/DHi3LCTl8E=;
	b=dVGPvrbwyxy6NPnkU/YOR+Nz+AMrR25ymh7vHZRbY5yAlL1O/d12lo+hk9MytdVexhi13a
	rsTCSjG5MZiVsaylY5afR3MvkGowBuhe14cUjkRCPg8cB1HKkR80Fy4IfIypTjsfoivtnW
	4CqcgapoHiFybzSnQDsNaHNo8U6ZLN+8jz6pcfehCdvPR/kVnEzit+ovCVDk8tdvNbmaUi
	OdRtV0o1DoEYD8s2gF9P7rmiCb5u4KHBoHS7q8SB9i4//5ZpI15PhAs+h990tcnqUw+k+F
	xKztZEeD0aST4zG37wx9vo++BmADVg+6XWo0Z0XEAtayMaY9Ms3zMmO6wd3icA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:33 +0100
Subject: [PATCH v2 23/32] drm/connector: Export drm_get_colorspace_name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-23-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=to6N0s2e3g5+ds9m2twnzI2TlMbRSBVJUFTnMgjwSAk=;
 b=owEBbAKT/ZANAwAKASCtLsZbECziAcsmYgBpAhbreUvmaK15r9x36RGTfxku7ZhlBYc76vQ7d
 kWgQB2KCkCJAjIEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4pXfD/iLXsc3N9OqiBx32aDwvZ/Z4YCSay/VDoLRfjjzEOCJELxWHj7+veweFdcyegM9pxN0rQz
 SXNXxmKpo7/023p4FJ9rvQyCKiYlamDSJIlualT/dIZw/qnB0Ml7GHB93EQDpwkRMFmIVCUQX1v
 8/Eofv9AvvUKCVFIbbLRvCzxx86h+lvBmCwSGNXn6EfQRNLlRgSfRnfaOASaoZVMTSonW1Ec8K4
 3bZMOeE1zchwMmQJzHyuyu2Ls9I8hY8isCrEkPiiz6XryaoozQ//+NzPKNFithwrqFMGsQxrwoA
 qLdAR64cPduXra3SvJfWaGsUzB5O9K1B75G8zSD8qoIfBsk8ukTbCQ9O0oCHMdNRxV8xKeTYd6x
 afymUQJy3Ll8hVCzmHKhO59F/Eg4CRkY/Feao9xx+2TDAk/ZKzczpY2acPxjxNo+D+dDajN8VFL
 QsotzH4r/2Gbvw5Jisy+RUM6VQbNog5MIT61POBXvwVcW+hKa+2sN4YjBnS3CQYPlcWdmvomTLs
 rV/RPgq96UsxzMMLLDUavyHi0NTRl8Yqnv2M0/kTvQPyG5THh+BP4Qt1TW1QuYyZnh+EYjO5QSj
 XMQ0iX5PfSf1bNfeQB6q7HNiIMVfZX1esn4sFl85YxV4jj91l1Cfxt8uwke8B51XrzhJLLulmRl
 vYvl6e/7D6MBB
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Export drm_get_colorspace_name so it could be used by VKMS

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..5b777fb75b05 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1362,6 +1362,7 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace)
 	else
 		return "(null)";
 }
+EXPORT_SYMBOL(drm_get_colorspace_name);
 
 static const u32 hdmi_colorspaces =
 	BIT(DRM_MODE_COLORIMETRY_SMPTE_170M_YCC) |

-- 
2.51.0


