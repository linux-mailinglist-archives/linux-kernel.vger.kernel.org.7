Return-Path: <linux-kernel+bounces-866240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A4BFF454
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 557D44E0709
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40C23AE9A;
	Thu, 23 Oct 2025 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcaJqiR0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF01F5EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198388; cv=none; b=eDkYlC64kMlu4Al7emMzW9ibr1EAxCCl+Pd8MCOriawcD7s2L/w8OZ6DqncMeh3kZJxhGQwPvmdvWbVwtaGLO/n+FhmNEBfzOxzM2C80Sw7NjIiuqW1uotJwgF0EYSVH4/lcY5G0dubv6ogqVgb9P2syp4SqaXBWk/j4il3sU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198388; c=relaxed/simple;
	bh=mQtnE/Pk78fbCaWrJaquJiBun1a+J2wllq95qqjv6VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXna8T3EYur5rRiqCRLGgXf6158XUYEnGL+mYnLgPhKHSoMMM5pD97XUFN8qGFBXt5hSXXO8Hh+Y9HCf3cAkbOpz5HCWvVKyO0pxJ0TLuMcyoWE4mW4VHcxExqxVBO0mkon+V5o/eYmxC4HmhWGb9SZtERi6Oyrkl4+ArSrY7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcaJqiR0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471191ac79dso3834185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761198385; x=1761803185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwnxFDhqj/zOYumjR/NIec/9OkBezJdyMG3IFuZVCHs=;
        b=jcaJqiR0929zazLZNG+nJSXbrTaxjvT+9I7rKeE7fD/AYEsDmFEBq4O9qAGGBmhW84
         qUZs5SBFbmCmrhccZppofR+0nBsdd4Uh++AoAOIL5w7a7vnDkM3pZhJARgHTqx2ql4k2
         zSbFKKaj+De1OJV6AaYMb3Uojhb8Cpbsc+gqSJyCY+cJQwRE2a2xWmjxI+oH7FMAPlio
         G92RBsOa0i+c8oU7xvNISbv+p9mnvDj9J5hzSBxV24LbCfbQFQMmctdlz2zNNm++WCxG
         JisMPeFJ/1W0LHN5tDUtfEfNcdUbX3cTZT1BIROomMXbbCEWmnfYWnv5oTu8a4nkZVP3
         aHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198385; x=1761803185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwnxFDhqj/zOYumjR/NIec/9OkBezJdyMG3IFuZVCHs=;
        b=h6PyVY43LrFS4qSzYYm3ZwoaqPK1+9R65Cr+X2lpFFN4gGO/9nWcpcEqsM2ABknROi
         Awovm5fNS6p6bAp+xkv8Rq38nZ4RZQoJLQgd4aY1pzzsnghv6wl0dJBCjFzrPodgdN2R
         BWdJjFAm4/xeQZBSf0VPegA3MI9+yeBL/rR16UIOc1w0LfYH9RNyy0Xh8nc1IiJcZr4J
         u1W/PrghAXb4uTzqOOCSUOn+wUZFaZJ2bWi/X4h/roYYoYV4aZYtOnwX4CNmxibX/7AC
         KRML5IpuLEi1EGNZOB5uB1Zd+MlV+Up0PqtkSO/fQfBQjccrwvLPouV6VzpZtVz271v8
         t0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6xubR/viUes386YWZGj8PC6dVK4ytuqbG8gpyhtH3Tw0iOzbW8u/c4QZ35aDNKZHAystRyesLCQT0lhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZqf97A4S2KvhLl0KwaQyEULZSvsramRuFkbSpzGRo9Qe2xGa
	293BmcGyuloXJqD62TdBIj1pgfWsviu/q0kEQiuYzfv7ZFTIq2sMpZvq
X-Gm-Gg: ASbGncvq/SRQJzGu4gUvI/nB5VFWIqYZ/6gcCHCLlNmvY4rgzeFDmy2vT1bBLvrlXnu
	0AWkr0aNMOX3YlUa4fXaHVxZMPCQ4xzwHPyZktbHqTh9RvUV5d+6Ro8TWQNlXyYb/RRRFPqIHRd
	KAVe/BRMXOb3AlIFHByvKt4SMaZulgfdK0D/EXjFNoIbeWZ2NHOJLu5xm0TEWxlaMhsZOdp9S7H
	Lm5pqUB8v8lqKbQtOxmfHTVR03kwhMsXUs7JTPApEiwd3RwgAEnxqYJ0uNOQy7XyMAqBEbOsFNX
	6+9JYTkrY2oP29WWsPrlQAWXxdh2tPNwjdIoKSRsfd2zCxwjUvJtLL/VW3eJ+0yFLFTWhqw8QFt
	wBHg6CecbSlEh5Ly8Szwp+JuPhDhmN7CoBjs3ewYbKce31kBvSewOoRNvNI8T7DoB+DkqAyjyhE
	8YNTqG4pqT5A==
X-Google-Smtp-Source: AGHT+IHQc98eHStc6B7n1NtnALjErZ0PHeJrg9rNrymTkb6GNxWx6MBsyxvF0dpH1vuKnppid6VE9Q==
X-Received: by 2002:a05:600c:548c:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-471177bad0dmr162359495e9.0.1761198384454;
        Wed, 22 Oct 2025 22:46:24 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf3b51sm50414785e9.9.2025.10.22.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 22:46:23 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/tests: Handle EDEADLK in set_up_atomic_state()
Date: Thu, 23 Oct 2025 07:46:06 +0200
Message-ID: <20251023054614.6267-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023054614.6267-1-jose.exposito89@gmail.com>
References: <20251023054614.6267-1-jose.exposito89@gmail.com>
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
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
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
2.51.0


