Return-Path: <linux-kernel+bounces-762331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB5B20501
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6393B1790FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628EC21D5AF;
	Mon, 11 Aug 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/Zrfoe7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D51E3DD7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907343; cv=none; b=DUzEAOwZ24ZV6Z8lCLfIgfRvGc1tnYonnuDvx3qRyx2KoN28XuDZUQp7vS7QtojGzEhJJSYcdViHrHDwNySAyNETnWSCUQ0r0kViDQwK0QnpjwDSKfobvyVkEds1xdmdQkd8GTl1nUOkkwg5YsvcKNBpulndf2qQLKprXSOOwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907343; c=relaxed/simple;
	bh=jLaBOecsmkOo92ziWTJ0CPhxVFZ7C/JCTojDB2zrOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZI2vtP/MtK0mDSoiqCqjIzqcUzDfPgQgHwv8IDMFbjXaiLF1e7TeREkZECCNdr3L8D/EHPxCNeWYvfqOSkLQYBca7ngMFjmu3PH9oOU4ootspr/WGpEFKXHuZwDkjJl31O6NYEIeQ/uTKOqmydnXDzkK+cb4ZgD49hZjWZkLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/Zrfoe7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7825e2775so3703919f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754907340; x=1755512140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InWEj8yfNZNXn9Ghid4W7lwyxvfYCt3pMVPvqhpg8n4=;
        b=A/Zrfoe7zfer2GpgvPYWVztBk8oDtlTn43HjDwcDi3x/z8fQksX3z4qeqKK3FPEOfa
         dhea+YI2JHT0yMQd+aq+XNuffVEKf9MLWCV3CGAe694SbKUtHkmvDOz/b93uWH0aFgsE
         uFHrGhpFtSHjZ48RKpzhZ22cK/6hshmtNMR12Dk7nmdZBzHZXrQ980e1e08fmSql9muO
         JboEyHwbTo38p58xcfd1KY07vqHcgnBWUCoxSinxrwB6I1iLdwGqwlRGCeXQP7Oz5F0h
         LuNawjCDdGqD4PG6LjKWVAIllEyEQ7LI7lYhfpFWvg/9cvwueMIO+G8Ry7LAc3a45iiS
         IXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907340; x=1755512140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InWEj8yfNZNXn9Ghid4W7lwyxvfYCt3pMVPvqhpg8n4=;
        b=AOfT/Wd/0OYTM4d6c6cmjM/uMO5j2mP8NFJxWk3vKamPBFIVnZ58zqfLhou0YJDfMX
         98zKK740P26+WG2dS/+sFNlCeSTea+QSbEO0dcWCD1N3qKBb2i3PU7yq0YQeURNV1hIu
         7TlujGkbmvVc4RDqSd6FUy61BqxwqpoFCVn68D7Fz6IVtKS4a9iN7jgiMowZDucCJgTf
         yPRG6DYbGsHpG2r7JCw+4ieE4srMgRZy7AK9UcX7hGjvHn47v8MAp0dPtZzmOomRGlMf
         KmrZpWp3ZdV8ys3RoHz27QR+ov5oUFcPEc+n/dtF8GwUmvVyDDg5/j21Wirnb1sM3Cno
         RPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnDbuN7lqopVf8kjwEkFeb+GdNjJ78ZDoTQE97YXyQSPBzYy/gk9EyDQm/NxQlKs95KaPUoHtYo2uMxBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkooZxRu4i2ynaWQmIFJ9reCMU49BksUwSDCdcpXpwAuvNvIY
	9ibuzazBR7SdacDXvlhsCXBWq63Nbrrx3vbRsPjfHSEzDalqNMCAI2OP
X-Gm-Gg: ASbGncs3J/yBv1JGmJz0hAS6D2hMLjy78gQ7Kw4Ny6eDhBK9MqkbS6DTdfb4t0saV6u
	0G78p00JwHwTwHC81AO0/1cXa/fF6ULh3wXpx95wF9FRTJABmUQC6Lptmd2WIELJpZg/hfQSN+y
	qS3uR5M+kX3vO3D5vV2dVDxNnI1qN9bY1PQMaZ5xU8W78MHjIAaVWPKNzQjHbtcKjzYvD1/rNqI
	43ry5/gyZsduZUdsvPJyfkUtC64P5iSG3y+aJEUnpLTONJz1UutMQtSxnmUYR9+fglSVnLObfFw
	Xxin6ZqkEpsSBWfl4nw909ZKoUH3waG3sq4O9OZAsX4Y4XwYtp06q+Uio/d/1GYai3lQsyPA6+N
	0prmeSQv7uBa0BxgD6jQ=
X-Google-Smtp-Source: AGHT+IGCO5Yz/McpdLbvstrjp9ON3bvmgmsZGX9z/NKfsYRx7kZ/KBKj5mqJ1Hqz+AjQN6N+krHxDA==
X-Received: by 2002:a05:6000:402a:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3b900b4d494mr10608677f8f.24.1754907339468;
        Mon, 11 Aug 2025 03:15:39 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm38989438f8f.33.2025.08.11.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:15:38 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/vkms: Assert if vkms_config_create_*() fails
Date: Mon, 11 Aug 2025 12:15:17 +0200
Message-ID: <20250811101529.150716-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check that the value returned by the vkms_config_create_*() functions is
valid. Otherwise, assert and finish the KUnit test.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aJTL6IFEBaI8gqtH@stanley.mountain/
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 51 +++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index ff4566cf9925..b0d78a81d2df 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -200,6 +200,7 @@ static void vkms_config_test_get_planes(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, n_planes, 0);
 
 	plane_cfg1 = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg1);
 	vkms_config_for_each_plane(config, plane_cfg) {
 		n_planes++;
 		if (plane_cfg != plane_cfg1)
@@ -209,6 +210,7 @@ static void vkms_config_test_get_planes(struct kunit *test)
 	n_planes = 0;
 
 	plane_cfg2 = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg2);
 	vkms_config_for_each_plane(config, plane_cfg) {
 		n_planes++;
 		if (plane_cfg != plane_cfg1 && plane_cfg != plane_cfg2)
@@ -242,6 +244,7 @@ static void vkms_config_test_get_crtcs(struct kunit *test)
 		KUNIT_FAIL(test, "Unexpected CRTC");
 
 	crtc_cfg1 = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg1);
 	KUNIT_ASSERT_EQ(test, vkms_config_get_num_crtcs(config), 1);
 	vkms_config_for_each_crtc(config, crtc_cfg) {
 		if (crtc_cfg != crtc_cfg1)
@@ -249,6 +252,7 @@ static void vkms_config_test_get_crtcs(struct kunit *test)
 	}
 
 	crtc_cfg2 = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
 	KUNIT_ASSERT_EQ(test, vkms_config_get_num_crtcs(config), 2);
 	vkms_config_for_each_crtc(config, crtc_cfg) {
 		if (crtc_cfg != crtc_cfg1 && crtc_cfg != crtc_cfg2)
@@ -280,6 +284,7 @@ static void vkms_config_test_get_encoders(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, n_encoders, 0);
 
 	encoder_cfg1 = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg1);
 	vkms_config_for_each_encoder(config, encoder_cfg) {
 		n_encoders++;
 		if (encoder_cfg != encoder_cfg1)
@@ -289,6 +294,7 @@ static void vkms_config_test_get_encoders(struct kunit *test)
 	n_encoders = 0;
 
 	encoder_cfg2 = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg2);
 	vkms_config_for_each_encoder(config, encoder_cfg) {
 		n_encoders++;
 		if (encoder_cfg != encoder_cfg1 && encoder_cfg != encoder_cfg2)
@@ -324,6 +330,7 @@ static void vkms_config_test_get_connectors(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, n_connectors, 0);
 
 	connector_cfg1 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
 	vkms_config_for_each_connector(config, connector_cfg) {
 		n_connectors++;
 		if (connector_cfg != connector_cfg1)
@@ -333,6 +340,7 @@ static void vkms_config_test_get_connectors(struct kunit *test)
 	n_connectors = 0;
 
 	connector_cfg2 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
 	vkms_config_for_each_connector(config, connector_cfg) {
 		n_connectors++;
 		if (connector_cfg != connector_cfg1 &&
@@ -370,7 +378,7 @@ static void vkms_config_test_invalid_plane_number(struct kunit *test)
 
 	/* Invalid: Too many planes */
 	for (n = 0; n <= 32; n++)
-		vkms_config_create_plane(config);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vkms_config_create_plane(config));
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -395,6 +403,7 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 
 	/* Invalid: No primary plane */
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
@@ -402,11 +411,13 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 
 	/* Invalid: Multiple primary planes */
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
 
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
@@ -419,11 +430,13 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 
 	/* Invalid: Multiple cursor planes */
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
 
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
@@ -437,12 +450,16 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 	/* Invalid: Second CRTC without primary plane */
 	crtc_cfg = vkms_config_create_crtc(config);
 	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
+
 	err = vkms_config_encoder_attach_crtc(encoder_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid: Second CRTC with a primary plane */
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
 	KUNIT_EXPECT_EQ(test, err, 0);
@@ -486,7 +503,7 @@ static void vkms_config_test_invalid_crtc_number(struct kunit *test)
 
 	/* Invalid: Too many CRTCs */
 	for (n = 0; n <= 32; n++)
-		vkms_config_create_crtc(config);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vkms_config_create_crtc(config));
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -509,7 +526,7 @@ static void vkms_config_test_invalid_encoder_number(struct kunit *test)
 
 	/* Invalid: Too many encoders */
 	for (n = 0; n <= 32; n++)
-		vkms_config_create_encoder(config);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vkms_config_create_encoder(config));
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -531,12 +548,15 @@ static void vkms_config_test_valid_encoder_possible_crtcs(struct kunit *test)
 
 	/* Invalid: Encoder without a possible CRTC */
 	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid: Second CRTC with shared encoder */
 	crtc_cfg2 = vkms_config_create_crtc(config);
-
 	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
+
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
 	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg2);
 	KUNIT_EXPECT_EQ(test, err, 0);
@@ -577,7 +597,7 @@ static void vkms_config_test_invalid_connector_number(struct kunit *test)
 
 	/* Invalid: Too many connectors */
 	for (n = 0; n <= 32; n++)
-		connector_cfg = vkms_config_create_connector(config);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vkms_config_create_connector(config));
 
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
@@ -669,13 +689,19 @@ static void vkms_config_test_plane_attach_crtc(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
 
 	overlay_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, overlay_cfg);
 	vkms_config_plane_set_type(overlay_cfg, DRM_PLANE_TYPE_OVERLAY);
+
 	primary_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary_cfg);
 	vkms_config_plane_set_type(primary_cfg, DRM_PLANE_TYPE_PRIMARY);
+
 	cursor_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cursor_cfg);
 	vkms_config_plane_set_type(cursor_cfg, DRM_PLANE_TYPE_CURSOR);
 
 	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
 
 	/* No primary or cursor planes */
 	KUNIT_EXPECT_NULL(test, vkms_config_crtc_primary_plane(config, crtc_cfg));
@@ -735,6 +761,11 @@ static void vkms_config_test_plane_get_possible_crtcs(struct kunit *test)
 	crtc_cfg1 = vkms_config_create_crtc(config);
 	crtc_cfg2 = vkms_config_create_crtc(config);
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
+
 	/* No possible CRTCs */
 	vkms_config_plane_for_each_possible_crtc(plane_cfg1, idx, possible_crtc)
 		KUNIT_FAIL(test, "Unexpected possible CRTC");
@@ -799,6 +830,11 @@ static void vkms_config_test_encoder_get_possible_crtcs(struct kunit *test)
 	crtc_cfg1 = vkms_config_create_crtc(config);
 	crtc_cfg2 = vkms_config_create_crtc(config);
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
+
 	/* No possible CRTCs */
 	vkms_config_encoder_for_each_possible_crtc(encoder_cfg1, idx, possible_crtc)
 		KUNIT_FAIL(test, "Unexpected possible CRTC");
@@ -863,6 +899,11 @@ static void vkms_config_test_connector_get_possible_encoders(struct kunit *test)
 	encoder_cfg1 = vkms_config_create_encoder(config);
 	encoder_cfg2 = vkms_config_create_encoder(config);
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg2);
+
 	/* No possible encoders */
 	vkms_config_connector_for_each_possible_encoder(connector_cfg1, idx,
 							possible_encoder)
-- 
2.50.1


