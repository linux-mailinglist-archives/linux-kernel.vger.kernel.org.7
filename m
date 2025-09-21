Return-Path: <linux-kernel+bounces-826333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86AEB8E360
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F6F17B0FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA052147E6;
	Sun, 21 Sep 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD1FWs1R"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2C137C52
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480001; cv=none; b=UJZlAMN5EGdFaO0vdnMORKmQYA5Z4/ieIlhBqdg5uS4tl55mFiOL0g/2XqE0o04VWnMNaoHO1RY02tS11qtDL68chg/ywS4LZ51EXHYM2m1ABKlkV6PWwXLWfhH3GTuqLsdQG+TbBUE9pOsc/aKd1A5ymhCoGt1YeUBSwDQRpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480001; c=relaxed/simple;
	bh=GXW9MbqWA3jLNU9CtKF7MwkNis6w9KLGzmXQONCs8K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUGTT5D0SV3Q7sr7T3BN4/R5UPZ7GWCGCNQOVyb2Xj8TjxSN7JOcqjuIB6wt9o0ridNJ412OO20K+WjLypj2TS7dYh9PPwF1MaQaQXs6QICVV/aDhmNsLuRN9i21sKQ4MfTcM8ooyu5J0rwbZgEnmqrBO6Mr/bMQZoxTVVAtDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD1FWs1R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf6058aso49414505ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479999; x=1759084799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoB7cKQN4+UN4qFZ4riutgjHBwdWBXWlGksmHEe4AKI=;
        b=fD1FWs1RoYb4ZrtewnsI42ZaxwrS/7ddD4gBE9N62c8ycvqHQrAEXI/M6hBsjzCM6/
         P6yhQAuQy93Wc8iXoo+VBxhJubWWQhKV3RxT8GavV3QYENXcMczR+FADX5a4p3Y6c6Mx
         AfywTbr8JZ5GCw67IUEDQcMB/hKspqh9wyv0OMpJXbZgiPX47gVoydmkdlTCW/pz8gqc
         Mu+/3pInbZBwVkdt7igyXzUKhMYfCc+jOyK+iFld7fHMWpZoLUvPxT3xQE5A0Px1Q8yN
         KJftHGBq++NNRsFyTktl/wbPpJajTU/20WqMK5OPMp87hSSVAIIVuuOsqfmgnERMiXFp
         l9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479999; x=1759084799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoB7cKQN4+UN4qFZ4riutgjHBwdWBXWlGksmHEe4AKI=;
        b=AScakx4rKs4DzI1j95+kUmlN7JsrbSAAillb63MTZIlwlB8PYy4vrQ1BGbumd/H4TI
         a02zW9MkLTc8dL8xVX23Ambj7Hoch4vLh7/65GF6RYvUJpwfyn6ig5NLKFUN297Aj1E9
         btuuboURUvjOQJ99jt26aa9ZvjDN90SvdBg2lFk2/Cl4EN6JwL+PojmkZywpsvCj2BuQ
         yvCsQ9rZkMsyV3m8TS/QLff0rakf3BbibZboFP86t/tZ7xOgCaU+hn/jgOncLulCIcuv
         U0YKuXwS9tvIll3E/rGd/Ce/1Ib0mE6F7X5BxZGHrwAc/iq2EgYuTaCihdLPG56j2Uk9
         42gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBGnXT6vqUS7o5wE5Am0iEWYifLeS103a/UX+IN94tRZH2E1hS7xNZob7vIdNfXc7aJz3R4DR5eak9llk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHSmlp9umr77IFA9lxg5uN4KNV0gTTTFmxlJPfIjZXFOOSbhsm
	0Z7wp1vUdCXPGSUIm6/POqOY8rVLhNsbcuu61+DiQfgFDfJ88MhZ6BJT
X-Gm-Gg: ASbGncvQo0JWm5Pf7pTagYIuRLffCdLoCj6y7Kte5pTcvEtt9+s8+90xqdOFJnUu1cL
	X/rUnfwTly9kCtiq1BF02MfjWaqurh9laUjPuG8GYpyfHGUIStvPOjxjcKp1XWkX64S/mfruljD
	MCZUxPDKSY22GpMGPdHlrVkKNqNsLxKDaEP+1Tz1SGqQUqPHD4STLTHUJqlGwDpzu+EhXjWDaeL
	SmL/oUHCTPYWTI7N8lj9lB6JbGfyp4hbw1+cpwMObUhO6G92ofa6ZAIrY0LcEPIK/WeNhvjKipE
	byyUrmWwvx2O9yzG7XIS3FTA3q4eCInmj3rHgZrtDQVh/JWY7XmB1Rv7xn7CO2FU9F7vj9wGn7D
	OVqjAm0aWUpJ2bqAD7Q==
X-Google-Smtp-Source: AGHT+IGHyO6EN3VS1Dx3b+5swr3ajzqvhmea+cALQsD7c13Q589dV7pWvt5n7lRWNnlqSlv2oFO2+g==
X-Received: by 2002:a17:902:fc4b:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-26f7db2410cmr91789895ad.47.1758479999035;
        Sun, 21 Sep 2025 11:39:59 -0700 (PDT)
Received: from fedora ([45.116.149.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm111053795ad.88.2025.09.21.11.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:39:58 -0700 (PDT)
From: rtapadia730@gmail.com
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jessica.zhang@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH 3/4] drm/mipi-dsi: remove deprecated mipi_dsi_dcs_write_buffer_chatty
Date: Mon, 22 Sep 2025 00:07:22 +0530
Message-ID: <20250921183720.237761-6-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921183720.237761-2-rtapadia730@gmail.com>
References: <20250921183720.237761-2-rtapadia730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

The mipi_dsi_dcs_write_buffer_chatty() helper is redundant and
non-intuitive. It has been removed in favour of
mipi_dsi_dcs_write_buffer_multi(), which handles multiple DSI writes with
proper error accumulation.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 32 ++------------------------------
 include/drm/drm_mipi_dsi.h     |  2 --
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index bc847ab5c822..c2fcc219cb58 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -926,40 +926,12 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
 /**
- * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
- * @dsi: DSI peripheral device
- * @data: buffer containing data to be transmitted
- * @len: size of transmission buffer
- *
- * Like mipi_dsi_dcs_write_buffer() but includes a dev_err()
- * call for you and returns 0 upon success, not the number of bytes sent.
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
-				     const void *data, size_t len)
-{
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
-	if (ret < 0) {
-		dev_err(dev, "sending dcs data %*ph failed: %zd\n",
-			(int)len, data, ret);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
-
-/**
- * mipi_dsi_dcs_write_buffer_multi - mipi_dsi_dcs_write_buffer_chatty() w/ accum_err
+ * mipi_dsi_dcs_write_buffer_multi - mipi_dsi_dcs_write_buffer() w/ accum_err
  * @ctx: Context for multiple DSI transactions
  * @data: buffer containing data to be transmitted
  * @len: size of transmission buffer
  *
- * Like mipi_dsi_dcs_write_buffer_chatty() but deals with errors in a way that
+ * Like mipi_dsi_dcs_write_buffer() but deals with errors in a way that
  * makes it convenient to make several calls in a row.
  */
 void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index e4d26ed7a62a..cda981a41bc6 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -326,8 +326,6 @@ enum mipi_dsi_dcs_tear_mode {
 
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
-int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
-				     const void *data, size_t len);
 void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
 				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
-- 
2.51.0

Test patch

