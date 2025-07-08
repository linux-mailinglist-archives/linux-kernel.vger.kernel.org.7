Return-Path: <linux-kernel+bounces-721064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4953AFC44F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1AE7A7306
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1502989A7;
	Tue,  8 Jul 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="lL5qgyb5"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FB29ACE0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960353; cv=none; b=IRMaQVpjqJ0bd6Pi/cJ4wb3anjicCj4HQL9FUgCSMw/0nwRy43E/EyEVl3xyAuTFw1HJ7EAUunF5+G1YvyHLMAauacMj9BBf/hoQpwlOz+oM8t0lW7hEdR0SV/fQ+n2HC9Uc+KNndN6kApmSctHcPmUoQUklayWy//ST7YbFPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960353; c=relaxed/simple;
	bh=K49WJ9x7l3EnNvQfnQzsEUFr9wWh/GX1Tv+cJukjR4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xsc9xwITDlu5uab/DGb0QuFuvuiDrqM3udbnNzLdndYuT0B0ildufZf7dcRADo/eqLVncM7U/1ltzOSGxZ1qQSSa8hv39GNbx5P7CaeRvJSSgWwpVLOEdgZWia6ywEP43+Ss25CMlrv4NiZ/V0tZI4RI76cAkaa74oXowMPi6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=lL5qgyb5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7481600130eso5457842b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1751960351; x=1752565151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFUiRqJ8ldtxTynjrbllEzn54iuQyuslXMfdn6+3Zb8=;
        b=lL5qgyb5Svp9+A6ZOP+2UyOJ268fyxPTvo3AdJ8zjfPh3/2maUIXL05PC1PDTtV5Vn
         P3Az3UA7HGkTJX0xJl09Mt2jf5cw4b/saE9rSQssmJz26BIB5VMLZeoGtvYVzvFFmIre
         WpH7LVCCvuhgRu5NTGc86KRfQzuc4+MyUy/jmtx8TKxYOCvRV3ZHvduUjlSazBQs1xId
         d8LVMZx2ULf5Pcs9lxJ3HAF/cEgkkEbdvT7YGxdb1geEPPMChgI56wjiS7qXu1STS85n
         alSqaaxn1nUAPelcLwHA2ghu0VirGV3NAx2gvVYkeCLNbP/rNTJ7/6OLAe1tfM4a/uTW
         ezwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960351; x=1752565151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFUiRqJ8ldtxTynjrbllEzn54iuQyuslXMfdn6+3Zb8=;
        b=KzQnYkTBXlz60D2Jy8xYgcF6jRtkDBVMDVrgv6g51auhXnuP42jFREm5GPPuw2vmcs
         TaGBsgzAUwx33K23p0oG7iZObmGuLmEFRg8eUubZZs9wbt1LwFCiesCOhSAJHDVfmCVG
         5Iq42pbMV1Ra0zgtTQ0AuiUbPuS9wWvTVK0MHXxzZYu4HIg+7/96ZJ8B6fPgvkobeiz7
         4qEVypaUs6xcuQHEdsPV0UYnH6SQTu+yICWcvczUgKRmSrziJOdcpgQNUSVHfkJ5JRlB
         V4xQLyotEWH/XYUDxuhwWp264J/tYZRrFwTPOM3a0WHbaflNcad5xJ4+wtpyICSG5eC9
         bvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKBbeZYUVuqQwAERDLiyjifjbPdWSvP0R1JGKa1vsESOK36PEebQdK4wDAy6MusDQTaKHy/L36DH2C8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zcyVBp63wVFux8iqsLLZUW8ewXSSSowRajUz3zP9ZKlsMQNp
	HlOTzzLtifTCjN/WCbMtu5y27ZJ7cI3YpO05xoZsvXMnIH+1BUA3SGo7Pmo9ptfaQKa2eCQrRTb
	+SO3Q+uRZBQ==
X-Gm-Gg: ASbGncsx2ZPSbHioZuqJ1qiTp/nRAL4np524LPzFAMVlVYSeFWgvcU4bZR9V8J4TonT
	Vb9pEXyTTjcVX1AVzIz6g1EbQv/IdQBMpEZu9LNV2Kl4BwMCtJpjMN3LcEbPcZ4ewsHwgstrh6U
	WSeP2FDq43ClZZfVeDF7RWPlsmgSfVpy1vrxvw9ccvgFbgzmkfpaINH1qeKTQt8HIEEDyTkfDca
	Awz4kk4SkgGjpdZREfWm1IxT0MsFmTjqS+pIvAu6GWx8IrgbVdZGRw8Cb+Zi/rEwQdyAiMsB5zK
	eYdCd/4Dpy/LnbbsC5pZY/nchECjN1g513S8yh0Qhqcx/B5YiGKBtvN44qlvlwyAi1b8g8h1wbn
	NxyRgBq76bX4jIGcJjsRzlmXUlFHD
X-Google-Smtp-Source: AGHT+IEjjvMwCxlNvfS65ducwO3zjwiKKWiiOevnyebt6KaT7pnYdCus6N5MscGP8SruBVriyB/gpg==
X-Received: by 2002:a05:6a00:2e17:b0:749:472:d3a7 with SMTP id d2e1a72fcca58-74ce6689123mr24357739b3a.18.1751960351056;
        Tue, 08 Jul 2025 00:39:11 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a540bsm11633523b3a.140.2025.07.08.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:39:10 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 2/3] drm: Remove unused MIPI write seq and chatty functions
Date: Tue,  8 Jul 2025 01:38:59 -0600
Message-ID: <20250708073901.90027-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708073901.90027-1-me@brighamcampbell.com>
References: <20250708073901.90027-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the deprecated mipi_dsi_generic_write_seq() and
mipi_dsi_generic_write_chatty() functions now that they are no longer
used.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 34 +++-------------------------------
 include/drm/drm_mipi_dsi.h     | 23 -----------------------
 2 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a00d76443128..3b8ff24980b4 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -772,41 +772,13 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
 /**
- * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
- * @dsi: DSI peripheral device
- * @payload: buffer containing the payload
- * @size: size of payload buffer
- *
- * Like mipi_dsi_generic_write() but includes a dev_err()
- * call for you and returns 0 upon success, not the number of bytes sent.
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size)
-{
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	ret = mipi_dsi_generic_write(dsi, payload, size);
-	if (ret < 0) {
-		dev_err(dev, "sending generic data %*ph failed: %zd\n",
-			(int)size, payload, ret);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
-
-/**
- * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write_chatty() w/ accum_err
+ * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write() w/ accum_err
  * @ctx: Context for multiple DSI transactions
  * @payload: buffer containing the payload
  * @size: size of payload buffer
  *
- * Like mipi_dsi_generic_write_chatty() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
+ * A wrapper around mipi_dsi_generic_write() that deals with errors in a way
+ * that makes it convenient to make several calls in a row.
  */
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size)
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 369b0d8830c3..f9cc106c8eb6 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -285,8 +285,6 @@ void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size);
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
@@ -379,27 +377,6 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 					  u16 scanline);
 void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 
-/**
- * mipi_dsi_generic_write_seq - transmit data using a generic write packet
- *
- * This macro will print errors for you and will RETURN FROM THE CALLING
- * FUNCTION (yes this is non-intuitive) upon error.
- *
- * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
- * Please replace calls of it with mipi_dsi_generic_write_seq_multi().
- *
- * @dsi: DSI peripheral device
- * @seq: buffer containing the payload
- */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
-	do {                                                                   \
-		static const u8 d[] = { seq };                                 \
-		int ret;                                                       \
-		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0)                                                   \
-			return ret;                                            \
-	} while (0)
-
 /**
  * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet
  *
-- 
2.49.0


