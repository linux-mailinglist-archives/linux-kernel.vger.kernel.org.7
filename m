Return-Path: <linux-kernel+bounces-884577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E8C307E7
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328F84E7D39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAFB316187;
	Tue,  4 Nov 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZi0TXAy"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A12367B8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251952; cv=none; b=FMjuB29CYbSLf0RGKMwP60GRnAgzx99lXnkUN7bwXgdTrsdzXaNXQXYp4YJqb/KLlFUxRVIN2lfl7RqTf2UTdeHvcfBQXBW2tlAcxwhdpY4Ad4AG49mHsmZzdn/af3QZQ80z6APn9OLo7sEA4i4ojmL6LtyjPS3mIrGhy6xtVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251952; c=relaxed/simple;
	bh=HH6aeDaGVuxB3jXUwelH4MBTU0Ba7MgdB3kL4P4v+dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nA0qK3dob5T+RzdJwMUgxWcXmClIJ6exHppHolorPMw0+U9UmU5R0KcIVfu4gYahKi529Hmr/wSGmAmkelKl54dylXIZRzPU4fr0Txlcfavs2rBl3R2O/hXjcb08IvqMPoFSOjiHnUvs0xJpW73XJ6iYod66Mjw75mmeQaSiS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZi0TXAy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso44182835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762251948; x=1762856748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhBQ8vjBwEIJBmvGBsGuhFhSJEVfR25GCo3phCvZG9I=;
        b=ZZi0TXAyellSnX0MSSOPKbBreRsacS8ZWQXjs/akUeUMlRAFmca50ups6LBGZk0MTS
         AS55/7uflNdNensV/J2QwXLz8h9WUE9a2Z+erJ6nj9eX5fSXSSJss7e4tIzOYvouTajv
         /gSyEIBjEEMrmd+3qReZyXoclfqVe6GwCKDKn6NLQ7vE3MhGsOQPhM7rD5q1C4vQHRa9
         oJTEK/H0hWBb6Dxk7gtFZnub5xp3X92dZrpXMaX0AIpw93fKlX0YMKh8RD6Bp+E1FSdo
         v1jPPjWGF3T6RPjDn1++YqkfCBnaZGVzd28xaAyV/MG5bjGC18VZ5g26MNbIPNiYW/H2
         9FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251948; x=1762856748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhBQ8vjBwEIJBmvGBsGuhFhSJEVfR25GCo3phCvZG9I=;
        b=jret4v1HO8P8XY+EOJ6QsNFyiNJ7f7uahijKwnQllpZLPkNhh0QfEXGQUBuy5PEp+e
         wPPanMVmla+hupwd/K41V+Cg/eyFYpyDpBzaW9QW+gcu1odXq3RNBbTO02l0EtAPofLc
         TbmjWdjiCda77/nxG+N0sasMAIsQre3a3TniySGyVZfi/1CV88H1OgG9W7/ssYNg7TVU
         msoDHVgmuXeNxES7jmVs4lVt1UnCTCnthT+qUfIF39lkz3oAn8Kf4dM43+ja6tspJ705
         Vv8DhtF2qfZpQA1Fr0+xSvSNqBL8aEYXK0tyabjI+8c/1ineTVBlS6CtLkNUN6qg3Srq
         1CVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2QDPzZ0b7ltAzjNioYoosrIoNpoNMXDNxct6C/8+lTn+8f4jBB1A1wrd4iMSob2PsrPvqzmHCdCMO+zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuBx19x9rendRB4wYL4jZ34EMOfamfRoTIYGn2+uYC3OrM7Dz
	6QlA3X+dwiCk/UG3fgoKrYgJGvWwIgF07pyfb1ivjL9AcBGo0chZVFEmgXt1uwec
X-Gm-Gg: ASbGncu0jnMPumqaWwAlwN1HvTESo5kkwDJ/zJP6YRuy1/Fa/0XMP08T0MuKEWER+DJ
	ECZnkA2RMO22UN1c+5gM05Fr8oKXwoL3NTXmrwsEx7eDRFLnOESOCSLh54z5H6HGnCb/YQbM3n9
	bdzNFBhO3LTj7+RYf3TBfOmoXzPd8N7GW7JRVwduIUprnWuqFuhyjonbaPMJ7KNljh6stkfWQk0
	9r7j3Pp1z4J6+3xGh2vYViHPUHNyt78hmaDv3x1Ej2WIAAZpUuin8yL49uRJ43O8sToPbc4CxM5
	ZMYC7sWbDh9r/XpZ9C+XLEciwCR5FIqZA40vf3+O7S/4yTbWJbGOdAgRKj31QtdWUmQVS0LrwN1
	TqKAXnhLic1FThORotDQIf8n/LLsjy2T3iXQokuMd/X/JgGaPqHgEasDQjAJ/9lUVK4sGd5vqmx
	gHhRi0u9Ca
X-Google-Smtp-Source: AGHT+IH+9hXN3zecAOt94R0UMzn3AXAI06qnGLK2FptskRb06g7/FXm0009aQA/07/l5sYYgqXvRtg==
X-Received: by 2002:a05:6000:2c0b:b0:428:5860:48c0 with SMTP id ffacd0b85a97d-429bd672650mr11506975f8f.7.1762251947818;
        Tue, 04 Nov 2025 02:25:47 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f98d9sm3798796f8f.32.2025.11.04.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:25:47 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: quic_jesszhan@quicinc.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	quic_abhinavk@quicinc.com,
	dan.carpenter@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 2/2] drm/tests: Handle EDEADLK in set_up_atomic_state()
Date: Tue,  4 Nov 2025 11:25:22 +0100
Message-ID: <20251104102535.12212-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104102535.12212-1-jose.exposito89@gmail.com>
References: <20251104102535.12212-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fedora/CentOS/RHEL CI is reporting intermittent failures while running
the drm_validate_modeset test [1]:

    # drm_test_check_connector_changed_modeset: EXPECTATION FAILED at
    # drivers/gpu/drm/tests/drm_atomic_state_test.c:162
    Expected ret == 0, but
        ret == -35 (0xffffffffffffffdd)

Change the set_up_atomic_state() helper function to return on error and
restart the atomic sequence when the returned error is EDEADLK.

[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2106744096/test_x86_64/11762450343/artifacts/jobwatch/logs/recipes/19797909/tasks/204139142/results/945095586/logs/dmesg.log
Fixes: 73d934d7b6e3 ("drm/tests: Add test for drm_atomic_helper_commit_modeset_disables()")
Closes: https://datawarehouse.cki-project.org/issue/4004
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Added Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_atomic_state_test.c | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
index 1e857d86574c..bc27f65b2823 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
@@ -156,24 +156,29 @@ static int set_up_atomic_state(struct kunit *test,
 
 	if (connector) {
 		conn_state = drm_atomic_get_connector_state(state, connector);
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
 
 		ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
-		KUNIT_EXPECT_EQ(test, ret, 0);
+		if (ret)
+			return ret;
 	}
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 
 	ret = drm_atomic_set_mode_for_crtc(crtc_state, &drm_atomic_test_mode);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		return ret;
 
 	crtc_state->enable = true;
 	crtc_state->active = true;
 
 	if (connector) {
 		ret = drm_atomic_commit(state);
-		KUNIT_ASSERT_EQ(test, ret, 0);
+		if (ret)
+			return ret;
 	} else {
 		// dummy connector mask
 		crtc_state->connector_mask = DRM_TEST_CONN_0;
@@ -206,7 +211,13 @@ static void drm_test_check_connector_changed_modeset(struct kunit *test)
 	drm_modeset_acquire_init(&ctx, 0);
 
 	// first modeset to enable
+retry_set_up:
 	ret = set_up_atomic_state(test, priv, old_conn, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_set_up;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
@@ -277,7 +288,13 @@ static void drm_test_check_valid_clones(struct kunit *test)
 
 	drm_modeset_acquire_init(&ctx, 0);
 
+retry_set_up:
 	ret = set_up_atomic_state(test, priv, NULL, &ctx);
+	if (ret == -EDEADLK) {
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry_set_up;
+	}
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
-- 
2.51.1


