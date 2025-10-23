Return-Path: <linux-kernel+bounces-866239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA2BFF44E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16EE189DD67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B741DC9B3;
	Thu, 23 Oct 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF2lS5TN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADC35B13C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198386; cv=none; b=bNUGg+oXPWGD+eYcSOSLISFIsaJ5jyb76IXi05fQB7waRobZmvW6w5XrC5e4Jr74ISAfOwv7PgDDStXRoM3fEwZ4orwiJz62XXSL2Rd3Z5aoWiYkZuLIvm8m0sD1IgLTzbQnjKXTenL7FCnrlu75qKFDAy02QGZBoNMmS3GpcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198386; c=relaxed/simple;
	bh=Zl+2ISN6qzMat1JVzZWIK7uayDhQf0iUrjQgMrexcJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QdQbdC87b8I9XN8WVl2uaArkEshJnawiPV5K8aG09UCo3nCu7M7hLqSaN9y7Ze0UCAsRNajUcz2zcn3AJ1LkjnSYSRLD1YZyPUr3IdhGKe6oGjk9HZHdi6AfJwWfDziYywexVLuIQxrX5Z+FZMZoPA53bvBqO89U0meU5B+dC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF2lS5TN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475c9881821so3218635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761198383; x=1761803183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+fuNZVjOzBfehguINbliZJdnuGZFQWDcRhaGc8hzwM=;
        b=FF2lS5TNcRlkXHdBnjqifsWCzhpO8V3heWFpYc1chko0/k2Jxm/Q9BurEzgR82w+cj
         Kyk9c8kGApyB+3WliB4SYtzMeT8WswljDBpvs7rIcG1Fbrvg1Al3uYGjoAb7SDU9oA+L
         L9lfv/PGY3cA6dRzvy0UtJOXpel2mlRKXEt1tgmJnAFQeNar8363PuFhyY9cvoSskIDN
         n8CECq9mdm477lyDoupwMCVuTHlLV3K1YutSq7waqq/b5sJFzeekIH4wq1JXodQoIWXB
         k7VaVVsBwTFaQqiXSi9by+bbbv00RkCmilJCYOv9JqbEtZvYZ78g0TIO8CiVf47BstXC
         CYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198383; x=1761803183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+fuNZVjOzBfehguINbliZJdnuGZFQWDcRhaGc8hzwM=;
        b=PFz5S+xnLGsAtEW5XZDvtZzI6xHEZOEx38LiHrTYfWQUlhWTJ+QHEkesaVfOkzSjbl
         tEU+HBV/Zzu7qJiA5AJ/E5reWaM7piNJgnNwfMQOcwEuEwWof7XO7q7ljHphKy05Pkf3
         ksClkcd4OcHGj/fCNQcQ5g84zKb9qIXXDqtY/jKkO40UPTc4DwNLLz3ZO0U2n+RDfwwS
         fNgFZWVgDoG9PyzPLXV9LyMHx/sjD2joL0csmfX7TZxwRU6Si1sWq0bThCn8IZ2FHQBf
         LlIkq94HfV4w1V9rXkrlbSQahYkSX6mkeVxkO8s5qUzwOsAB35GxvAs0KqCUwGhM0Xkj
         NvRw==
X-Forwarded-Encrypted: i=1; AJvYcCXafGNWqzyuSUSn5DrMVOEjAhoRWR6NROhc+0h2yXvWIfr4Tvp9UVGPQh+v/MCjHl2aNfvz6xrE+9/EU5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMF9wMHBSbkBkgo9hO+VzANSr69O3UuEFABHx8vO7lY9uOl6vC
	esIrgDtJ3rKb7APz0mbKhfUvGS0FcLo81yIn7lHJEqxXsEtrMKJIiexh
X-Gm-Gg: ASbGncuu5rJ4m/VABVL3iAE2b8msfBIMYca/OlxTIxkGr2AKJR/OG3XosCpHoNe56Z4
	dJVlpDZuLIfsG4woesYY+sqn/U5xEb6ewdwKIh442ira+76atTezKhL2aiyRAame5ud/kUHoS9S
	0GpApGbPJ7PVsvOmIrGXtkwEjmcpN4uHwyuetjfKDH6+TrI3+Pvyh2nPyj/CtQ72RChsYhwybcr
	sqXrRDgVlvTx1ff/TOjb08qh47m52zBHgVe8K+6IsdJuq3eoXmkO0jHIKwZ8QgXZfFjC+/6hTd6
	9PSh2zc+N072xcrERs0kQypvWvUdN2YoSJ6y7fHEZOTYXyhrTwaXk7W5S1uhyR+WU2huq3pftoF
	wWV1uM/5i4Iyeki5cBYU51Dxa4+F9Lgg/lyRjNMgHa9PKTnpI5ri9hJRplsggR/lDc9cOzSQ7t1
	gr/SMOrUdWyg==
X-Google-Smtp-Source: AGHT+IExgoQzmmle3sIN1LH12hgZAmIRTnFnwVZCgFRS0GsdJQL5qbeVch7bnMJqPYEKU6bE9Moc+w==
X-Received: by 2002:a5d:584e:0:b0:407:d776:4434 with SMTP id ffacd0b85a97d-42856a89d28mr3012068f8f.30.1761198382987;
        Wed, 22 Oct 2025 22:46:22 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf3b51sm50414785e9.9.2025.10.22.22.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 22:46:22 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/tests: Handle EDEADLK in drm_test_check_valid_clones()
Date: Thu, 23 Oct 2025 07:46:05 +0200
Message-ID: <20251023054614.6267-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fedora/CentOS/RHEL CI is reporting intermittent failures while running
the drm_test_check_valid_clones() KUnit test.

The error log can be either [1]:

    # drm_test_check_valid_clones: ASSERTION FAILED at
    # drivers/gpu/drm/tests/drm_atomic_state_test.c:295
    Expected ret == param->expected_result, but
        ret == -35 (0xffffffffffffffdd)
        param->expected_result == 0 (0x0)

Or [2] depending on the test case:

    # drm_test_check_valid_clones: ASSERTION FAILED at
    # drivers/gpu/drm/tests/drm_atomic_state_test.c:295
    Expected ret == param->expected_result, but
        ret == -35 (0xffffffffffffffdd)
        param->expected_result == -22 (0xffffffffffffffea)

Restart the atomic sequence when EDEADLK is returned.

[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2113057246/test_x86_64/11802139999/artifacts/jobwatch/logs/recipes/19824965/tasks/204347800/results/946112713/logs/dmesg.log
[2] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2106744297/test_aarch64/11762450907/artifacts/jobwatch/logs/recipes/19797942/tasks/204139727/results/945094561/logs/dmesg.log
Fixes: 88849f24e2ab ("drm/tests: Add test for drm_atomic_helper_check_modeset()")
Closes: https://datawarehouse.cki-project.org/issue/4004
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/tests/drm_atomic_state_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
index 2f6ac7a09f44..1e857d86574c 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
@@ -283,7 +283,14 @@ static void drm_test_check_valid_clones(struct kunit *test)
 	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
+retry:
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	if (PTR_ERR(crtc_state) == -EDEADLK) {
+		drm_atomic_state_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
 	crtc_state->encoder_mask = param->encoder_mask;
@@ -292,6 +299,12 @@ static void drm_test_check_valid_clones(struct kunit *test)
 	crtc_state->mode_changed = true;
 
 	ret = drm_atomic_helper_check_modeset(drm, state);
+	if (ret == -EDEADLK) {
+		drm_atomic_state_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
 	KUNIT_ASSERT_EQ(test, ret, param->expected_result);
 
 	drm_modeset_drop_locks(&ctx);
-- 
2.51.0


