Return-Path: <linux-kernel+bounces-894930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FDC4C78C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA881888DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D7257846;
	Tue, 11 Nov 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jh6LIRvy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA72757EA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851148; cv=none; b=eEM6GYK1KyeFY3+7poXlM5AR5r+lJ63XrYCQiGy81XZn1lW4OJZGkFbzhq/k0ipfS1AyVVt/YwtgkGNVRZ3MEyKoXbBo5Mu9SIleTGp8vg0eztfIHjj7WghhGYKhaWODUmO99Jc10a+KrUs8TRkelRr9kiPdoXMAetLmIrcIyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851148; c=relaxed/simple;
	bh=AOtxztYb3EUCtWNh0dzQl6PgAK/9e+Oi10O5JPoqGo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=syw7fTZVqzWGCoTjmtL3CAi4uLM9/FMArfwf3RNCUXGodfSBhfyVlgrOtkP5ptRYuJS/DWJMVpi2fvKk4Pe4XMPhLH9PQD8Xjj1J+rgD2vWS8rIF/Moxm7v3Le/C/10Cp/w1aOI1jciXbBxI45Ga2yqEafaNL+CDxT9dFuCS6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jh6LIRvy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762851144;
	bh=AOtxztYb3EUCtWNh0dzQl6PgAK/9e+Oi10O5JPoqGo4=;
	h=From:Date:Subject:To:Cc:From;
	b=jh6LIRvyb5680qh6eoFuSxCsS8+ArGe3FK9/qzJEoSmtRz2ntM7Mb4bTVmmQzN3e6
	 j4pKsxb3onlQK3Uh1SN5DjmczMcg0ROBoBLlXR8usMf/yduegz0jAujmQPiBsfUFwC
	 mIIBXqAgtQfzUh/8TQMniH6DP80D5Z8p1s4jRmgEzdWvwY4bT+Lyy8LIxK4pTzQVhk
	 EiOO0GtUB3OLMy3n7KdAbw2my55p84M63pYVjCSarhqaQSUO9HPxmBbLWERTb9FZ2v
	 RvK03gfr4TA/MreDaCafqE0IbouGKxAn/tbtIV0f34+xSo9OZzocEoyIBqQYssg1NO
	 abMMlPbqw9aFg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9A7C017E1318;
	Tue, 11 Nov 2025 09:52:24 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Nov 2025 10:52:11 +0200
Subject: [PATCH v2] drm/amdgpu: Fix kernel-doc comments for some LUT
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-amdgpu-fix-kdoc-lut-v2-1-bcfcc82e962d@collabora.com>
X-B4-Tracking: v=1; b=H4sIADr5EmkC/32NTQ6CMBSEr0Le2mdoa4G48h6GRX8e0AiUtEA0p
 He3cgCX30zmmwMiBUcR7sUBgXYXnZ8z8EsBZlBzT+hsZuAll2XDBarJ9suGnXvjy3qD47aikLX
 VjZZ1RwR5uQTK/Wl9tpkHF1cfPufJzn7pf9/OkKEoK22UvTFe1Q/jx1FpH9TV+AnalNIXkYsEN
 roAAAA=
X-Change-ID: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

The following members of struct amdgpu_mode_info do not have valid
references in the related kernel-doc sections:

 - plane_shaper_lut_property
 - plane_shaper_lut_size_property,
 - plane_lut3d_size_property

Correct all affected comment blocks.

Fixes: f545d82479b4 ("drm/amd/display: add plane shaper LUT and TF driver-specific properties")
Fixes: 671994e3bf33 ("drm/amd/display: add plane 3D LUT driver-specific properties")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Collected R-b tag from Melissa
- Rebased onto latest drm-misc-next
- Link to v1: https://lore.kernel.org/r/20250823-amdgpu-fix-kdoc-lut-v1-1-306bcad41267@collabora.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dc8d2f52c7d6..e244c12ceb23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -368,15 +368,15 @@ struct amdgpu_mode_info {
 
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
@@ -400,10 +400,10 @@ struct amdgpu_mode_info {
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
base-commit: be4cd2a13a31496c7fb9e46a244c4391b8b7cf31
change-id: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee


