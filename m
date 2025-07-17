Return-Path: <linux-kernel+bounces-735649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38158B09215
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACE17BECBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850492FD5AD;
	Thu, 17 Jul 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="FQtJ3Me2"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8C2FCFF2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770505; cv=none; b=hpXSBGJu+UFlWQbaBLP3sKVS8z0dZgX284MoBi9Srw5w1Jy5rfEMzQa7jnHG0OC6Afsb4rZnuszbeQmswnnPo4GbYMKeZAbhlwP9+nLiY/Sm/pFCMlOtKxDMii19zbhuexLGLqbi6vfTHXmrU79qmBW2IoT1y/SqUaX5aqWN8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770505; c=relaxed/simple;
	bh=qGfGL9bbADl7T/84kq26vlHmw3OgWOMa60LT2BU8GRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQmmN9RyTpHD73kzveVvw69upZz/PXE5jRquFULJCQy9nVuS4pRECJ2/s0NIsrqotQyial31pbNxiYyBMX12FndDGL+TpIL8KhsfYI6qN0/gNDLfaOSyZFUelf1KcZ0DFku9uEiB+JN348bxRZaE8dRVw/QoF2GzY0F3stbkiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=FQtJ3Me2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-879d2e419b9so769805a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752770503; x=1753375303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6U6F7ktOHhXsfwCj268J79W4P9Jk1oA5CQY0LkezaM=;
        b=FQtJ3Me2xPjLMk6an4OaoO6H0mEvHBvRTVV+LU57f1hxv865PXs8bLIyEKsQVL6dAj
         s22lJnDlLnYkDRaYOibS6Is2noxUv9WdfH5Ypz1I5KpQk1JJybZy/nqGeFkWh5Dglw+2
         ao9bHX9/jpa6ccJjMd3BFYvlSXjl1l/08NMQeTYIfzREiapeDhlvDr2Dd7svcOH/jWO9
         lbuVwwpGTA5D+hzJmF7IfbgaI/8hECjCaa4SGRWX1WzMjpsGoZ4LmnhM5FI+fWmdFOVN
         chachtScXCJC+JicHiWaxtn49IJNHRkxuviMo6HEYfcC47C2giff8VdTBWP9Ju6FlTfV
         ku6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770503; x=1753375303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6U6F7ktOHhXsfwCj268J79W4P9Jk1oA5CQY0LkezaM=;
        b=u1DKm/mjV5SacZp2esuKoswiNtCm4Psmjm0RgIMNPNXqz+BgvJ86GDX4E1jd+eCVIY
         hCx/gaPFGpcSed/YjVZdHnyaI0As1ClDqoQNY4peZ50bLiwso8nAndORnRGLKKop5BbT
         QF4q6S9ZtQdj9QEGPCy4/h7EU7MURWhpqvC5xGPfm2lwh4bcXC2tuAg8Gjc/8toFCWQ4
         wC760CPPE9VQBV1pADreEEDN70Ob6grS5iCnBYCq+K/6RHh5lF/b7HsI90mSZX7vq3ge
         MLpbFOD/ZOCLAWCQ2H9286cpv1DrpNWJpB7Vcaqgl/9Ihai3ZrQ4TWf+NrrAjEfiDLOT
         2yfw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbgaUab+cDCgiNE3p2giz+6aCxHW7/Pec1hukQ3OJYCK4Rz79yPTGYwrlL+U3mcuEcoLeAF2AcDJYUCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzio7TS/j3xfcRxIA68mmpjD6CETTUpt2xoo6BqwL9k6hCxjYsZ
	3P3rs75NCvo+S2sRPLBXZc+9ymexAzDoS1fmbXSMLLY58SrIX+PqqIWnuV30xdWLJ34=
X-Gm-Gg: ASbGnct8s+rQ3iM+ZCrlhMDnbZJNQPbvoppeCSADxSHMXGl3WuWphmSnCiTG0KgkH6f
	7tPxLdgBZ3k4RW1Brl6KMQ4jYthBXFc2qypgxRdC/d1Zx3y36Eu4SdvNcmgv4c9qQjYPuFjX6VO
	2/oLz25krc+sm1YQuNBy/mbk3uWhW8q1R9EusPRgtSM4dQsbmdsA8QdWgNzJubuhODJMuQHKkPx
	+pM8AV6QPcNiP6nUZRAr79sTvJnKg/ZNs6+ZAWnBvu4+NqaiNccoci3c0JG7t8j4jqTrLrcPSnv
	UArKucJafFjgBZuq+52h7vtkHhoXtXuPP5VsWKO2SqwC7/a9/PYeEA5Coha/1gBLP3Fb2nNQ7gI
	lfbfLVWkpr5itBBQAyxAM8TzDvzlLxXY1nIlZU0Y6MyaRGrnoAA==
X-Google-Smtp-Source: AGHT+IEtjvc3xhBloO4ZME3CaseiMwB11gSyKFagdHpdQow/ZgQmvELeyGJVwsRPmXNuF5C1d/10Og==
X-Received: by 2002:a17:90b:2542:b0:311:d670:a0e9 with SMTP id 98e67ed59e1d1-31c9e75ba9dmr10555061a91.21.1752770503322;
        Thu, 17 Jul 2025 09:41:43 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e8ae4sm1821750a91.24.2025.07.17.09.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:41:42 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
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
Subject: [PATCH v4 3/4] drm: Remove unused MIPI write seq and chatty functions
Date: Thu, 17 Jul 2025 10:40:51 -0600
Message-ID: <20250717164053.284969-4-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717164053.284969-1-me@brighamcampbell.com>
References: <20250717164053.284969-1-me@brighamcampbell.com>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
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
index 03199c966ea5..1ab28fd70c8a 100644
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
2.50.1


