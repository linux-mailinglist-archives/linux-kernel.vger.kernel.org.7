Return-Path: <linux-kernel+bounces-782711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3AEB323F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CE87ADCE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6FF31E115;
	Fri, 22 Aug 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IQb3uoCx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C303128CC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897112; cv=none; b=EBYFoxaelM0TBiyDHpA7WmSb+3ymIbe3hwndQPTDuymug7SaCkQQ5umT7FtdrkuAL+MUGiXL5YbjqdQZ6NuXHu0skcVj5V29QG5EP7R6wwZ8k2JNM+vy/dEQO4JHiYozHyG0qJ5AleFrYA4gUMU7NG3qAcMNiHpurDeV8HJgTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897112; c=relaxed/simple;
	bh=akdSKAL7tVI8pIQYJXa6n3Pb4+YuTDZ9DIiQXpW+W1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MRLQTzsvEgbzjUb8/yKvJEGkc7WshotbP7LJPchybdAgrxiC+G4ykkFwg6/2V8qTlDAkRGZzHSi00F5Qapkd0unfhW6GGtAvJ5RhLWeCj5AhVhm5j10FAuamasTn9r4Wdidafc7p0ArptKBfy96Aj+Pd9CxHoHQe0Np7YAjwLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IQb3uoCx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755897108;
	bh=akdSKAL7tVI8pIQYJXa6n3Pb4+YuTDZ9DIiQXpW+W1o=;
	h=From:Date:Subject:To:Cc:From;
	b=IQb3uoCxgz9EJgxgtyL9YBHM6u3VY1izwzCzUz0KK2cwUAPbTU0kSYamyGVroOLP5
	 DxJ28/l3zj531dJw1MlvxyCo0V5m9980qVJ14TOdjnXtk+lcd+ytXTvyP12HkUmSvI
	 rY2pE3G9hq/tJquJDoZpM7xBaZ01bo12pyW+hZ04oZGgiPPIsmArVuUKMNLW7VH1TB
	 hIbFcSmratRRLpyOq0AIJjfPzu4ZkQR7NER2RReOMUpI7G41rWkdqkfGxbVfKaeOXD
	 PlG5KvHts0xf2LoNziU84xmFxKaU+nbCP9RE65xhWN1WW3uwigy5ZXxmj5bkY8DPjb
	 JTnxxf/74/NQw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 35A3D17E0C54;
	Fri, 22 Aug 2025 23:11:48 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 23 Aug 2025 00:11:35 +0300
Subject: [PATCH] drm/amdgpu: Fix kernel-doc comments for some LUT
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-amdgpu-fix-kdoc-lut-v1-1-306bcad41267@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAbdqGgC/x2MWwqAIBAArxL73UIZonSV6KN0s6UnWhGId0/6H
 IaZCIE8U4C2iODp4cDHnqEuCzDzsDtCtplBVEJWWjQ4bNadN0784mIPg+t9YSOVHfUo1UQEuTw
 9Zf9fuz6lDwwD8VhlAAAA
X-Change-ID: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The following members of struct amdgpu_mode_info do not have valid
references in the related kernel-doc sections:

 - plane_shaper_lut_property
 - plane_shaper_lut_size_property,
 - plane_lut3d_size_property

Correct all affected comment blocks.

Fixes: f545d82479b4 ("drm/amd/display: add plane shaper LUT and TF driver-specific properties")
Fixes: 671994e3bf33 ("drm/amd/display: add plane 3D LUT driver-specific properties")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 6da4f946cac008ac865cd6d8a06fb0bd84d646d5..c3ad371658065388c10b7cfc45377b0465bd24ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -366,15 +366,15 @@ struct amdgpu_mode_info {
 
 	struct drm_property *plane_ctm_property;
 	/**
-	 * @shaper_lut_property: Plane property to set pre-blending shaper LUT
-	 * that converts color content before 3D LUT. If
-	 * plane_shaper_tf_property != Identity TF, AMD color module will
+	 * @plane_shaper_lut_property: Plane property to set pre-blending
+	 * shaper LUT that converts color content before 3D LUT.
+	 * If plane_shaper_tf_property != Identity TF, AMD color module will
 	 * combine the user LUT values with pre-defined TF into the LUT
 	 * parameters to be programmed.
 	 */
 	struct drm_property *plane_shaper_lut_property;
 	/**
-	 * @shaper_lut_size_property: Plane property for the size of
+	 * @plane_shaper_lut_size_property: Plane property for the size of
 	 * pre-blending shaper LUT as supported by the driver (read-only).
 	 */
 	struct drm_property *plane_shaper_lut_size_property;
@@ -398,10 +398,10 @@ struct amdgpu_mode_info {
 	 */
 	struct drm_property *plane_lut3d_property;
 	/**
-	 * @plane_degamma_lut_size_property: Plane property to define the max
-	 * size of 3D LUT as supported by the driver (read-only). The max size
-	 * is the max size of one dimension and, therefore, the max number of
-	 * entries for 3D LUT array is the 3D LUT size cubed;
+	 * @plane_lut3d_size_property: Plane property to define the max size
+	 * of 3D LUT as supported by the driver (read-only). The max size is
+	 * the max size of one dimension and, therefore, the max number of
+	 * entries for 3D LUT array is the 3D LUT size cubed.
 	 */
 	struct drm_property *plane_lut3d_size_property;
 	/**

---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee


