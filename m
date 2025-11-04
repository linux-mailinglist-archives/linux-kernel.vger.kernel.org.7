Return-Path: <linux-kernel+bounces-884576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD504C307F6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A361897DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29898314D39;
	Tue,  4 Nov 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVV9T75A"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CF2C0290
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251951; cv=none; b=FF5YEdqvE985kzrutc+S12wCQ+aPdFRV2PIP0oaYWWqJ0tHnOCQzxIZ2vHHjB2cGJ3hM579N9n4/+5tWwuk/3IV/qnEqxNl0hJX3ot3LDsck0wTgqnbPGgEYM9liibe0G6fWpShhwyWZ4LikpwyW3QmU7wVo1ckuIKJGK3Zo0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251951; c=relaxed/simple;
	bh=Pr+RY2r+k2xdk0WLKLxatwgqY6B21A6JQV0qGJpJx20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2eftEkvsvtiAljv9c0IehrTn5lPhJbYXBHG9JLDfSnrzC/es/D3R06PAX8WwjjJlaFcGZ4JqFzsKuwpN7Hgwq9d4kPODD+IueUq70AdbxsE1UK3iM+jPMR0fRQiuZ6oDWy5eg7vlDH9WFPhfLskctEI+HhIg0U33WKHHYnHpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVV9T75A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so1582857f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762251947; x=1762856747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsUvrI+bVG+WlTg2GHY2axwhhFFNatFaC6KQ6ywH2FA=;
        b=mVV9T75ATTpGm/3Xoc5GFp9uorYdLhiMTGZXTtX3hQ9sBCl34Sqx+UO1WcJZg44xFI
         9SYexXKzSrXZXx7erSFnvvLjIfa6X/G9sKOKqR3R9coY0pRM5zwB948UUvZgy4ELwO43
         Fe8cHE7YbXq9qgrXaMG0eQDzRnMuFejRH8rPX//LazJI76U54xs0PqH8uG4w0ErRsYa/
         w4054WkNzI5JlIIgA9j7252+lfoqwWUDOsD41qTZ8W3nbGoW7nTDHRJfMXliGdJPvvFN
         xaWf6e9USGBoDLRnRZL5bkWriFUCi72Cg5QfTJ2z7ooRZUGMh5ZybV/o1R44kSci1AnG
         mNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251947; x=1762856747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsUvrI+bVG+WlTg2GHY2axwhhFFNatFaC6KQ6ywH2FA=;
        b=IOwRt9rsfDizVlwW74VOqXB/wjAHlzbNEISQADuMTbDZGTVph0oYYgfMmDI61XrFld
         hmLP7YFNR3Dyz/O/CQqI8k18TN1YUzB0zMZDned6Ik89f35PBYnLE7GmxAOLBdppGlQO
         78Y1PDKogyj5hT3V6lDl5tfw7kEU99hBImFBMsKGhPDTH8b8N1VpN1D9DI4ua02NBzzs
         HJRkX2rSwv71pI1DxEx0UBfxNa5Yh9Y+EGtOpIZWNZNDJvqJ9TJFmbTchR7wbfIP2T5J
         BDKWacHoErdW037DlCrb1F1MpewKEJoJMbdwoe7pxk+seNsNV8mkU+K1WkSph5dDPfzU
         9qsg==
X-Forwarded-Encrypted: i=1; AJvYcCWFFhlEvIRGM2EXJbniMRmg+VaIcNbshhZkA4G03URLgjsr6tlWeWEqdn/wPdbhAXP5ArpMyqhgBjsCnCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hHGCQLPgcvsfnaPSOOMSXL2O3RXvPCnw5M3Tuf+gggDSgBPJ
	7gvL4xwBkndAi8Rv9hfJP8zmX78zcmiyqe57pZGt3HXMSiBDzC+D+0sd
X-Gm-Gg: ASbGncswR7E9fkvdyXkslxLB/tECakw0iQFbgfyAxh8JMBs0Z2/CLST/3PJnhE5MmNg
	yE5R2Z2jugTy2a5ysH/XWaUDhROcRi1tIXtkrxD4ySybmxM0iHkvDGItYeJn5Oo5UGjxgJBIbAp
	ouCAXZclynnokz7C/tfHIWWy2iIDrpqRxAogcgBK12UNOQBT6vwDi+qQ5z4j0ky1fidYkrfWCT/
	tREPVuYRqQp8Mni+0aG1Y0iqh8MNdc0paR9x+dilBkfX9YisgMdD+/U7e0i5HMFXj8nsZM/SqXv
	o9PVZNvyh5ruuxxelPApVCFjtNMRLjo+dWrgX6rJQqeFKi7SwfwG/DcWiLaecOHGeeTOYRjxApi
	swjK+F5nVYwi5QjVy2VvqWLf5KEuhY6e5x1UtSL5v9fnLFI+mVJJ9ATcJ5JxD/iybV1yzXC5OnQ
	==
X-Google-Smtp-Source: AGHT+IEFVm7U2UQsd537HSbXE97LuE8N/Q+Vgp/0beLP0A4bKl4h9zVL2B9q7Oj0nO4Hkut8N8AkMg==
X-Received: by 2002:a05:6000:40dd:b0:429:cfa3:5fde with SMTP id ffacd0b85a97d-429dbce00c7mr2483596f8f.11.1762251946685;
        Tue, 04 Nov 2025 02:25:46 -0800 (PST)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f98d9sm3798796f8f.32.2025.11.04.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:25:45 -0800 (PST)
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
Subject: [PATCH v2 1/2] drm/tests: Handle EDEADLK in drm_test_check_valid_clones()
Date: Tue,  4 Nov 2025 11:25:21 +0100
Message-ID: <20251104102535.12212-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.1
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v2: Added Reviewed-by: Maxime Ripard <mripard@kernel.org>
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
2.51.1


