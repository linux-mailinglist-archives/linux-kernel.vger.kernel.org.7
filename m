Return-Path: <linux-kernel+bounces-737634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2EB0AEAD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018751AA7B66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6A238C2C;
	Sat, 19 Jul 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="kQrcP5Pz"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A4237A4F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913630; cv=none; b=UsHItEJzxKPXbU9GIAxL5W+AfB43fLSn+0kENCDoZ1KG1LsnMu9IUqfC+5uJSvMj5ejlAe1iI8KX3ZegSIpP0wPyXt1cc5pGsQnkMXhyhboJIyZsmVcHgGha05qfS3fo+Xik4H92Em+HvhR1xAiBdgfy1uDnJvGqtMQ6foE8QV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913630; c=relaxed/simple;
	bh=bd+E0gQII7XeyGUMZUuFdsAUXKc9B1flbUYFWuIacjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taSoW91gCXWcPSvB1TuS4PvyuQzLOOU+EEaQRVwGkz1J1Hq3CDgV7eiquTW9RxYmL3uBddPy7V9PtUKxYX9qM68hHvmvv8GfApNhXnqaRvauTPyZQItw3+viKR5b5YLzSHogfYIRUH4wEbkK5sYGxuRzllUxEwxFkWyndd8iRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=kQrcP5Pz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31c84b8052so3066271a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752913628; x=1753518428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJeA0ZOH8c7XggE0U2uw5Qes21v9D2XQPKfKpRuKve4=;
        b=kQrcP5PzF9yNRxyA50oYb8ITE4TRgWb3mxoimeatCjz4djJevLOsQ2jpG4S6RVJfC6
         2p+RYhiLKjFHke7wcYK8fHR13d2oasOrQky/z/bCx6fRr4II/6KnvUn+8Zoc6muVQKwk
         xZqt2RpEOgtUvS4f6L9MdnpURvjt5Ie4ocJvG3BInfvOt25tVp3Dv72WbXtHWye9geNp
         7nVecNACOdNB2BohhM0cXnRZh06uAO0aSolVxdQMtEOjV7R7La9hAAziUH70jTBzVmY7
         HYqt2j+hBD5bHWyPTtZqz7AoZ4fpIxz8A4OrKXNzRazSUWsMxRuGSg71wjpOYLdRW5fu
         GuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913628; x=1753518428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJeA0ZOH8c7XggE0U2uw5Qes21v9D2XQPKfKpRuKve4=;
        b=uLbHm2UkXNIriD1OuCpbSZYdiHBDyAVptrRZnqXZ7GLIkFgCXXSgFlvTQgCvj604HA
         8yt19QCiT60NTyQylaCY1DTc7qeZEYizRSez4JMrNPrS+o7JIJhKRO3wF2a2zCzD+gE6
         oSeEoLbP96QoD/ApWX1nJMGBL/tC8elkFpzmjPca4wRnwjonqJErF72la/h7WW/BuzrO
         q27CiDvCTaccA7LpsXtq7ozoqc4OvLCSPRGTt/hFefFUlwesXsc5KNbDa3MJRIXA5UNQ
         D+E0N3cMPXWv/+XOm98N1Qe1m9XZvPpeYcSYFDARAFgxHIpmsTCNBZzdk+ozY0U+46ce
         +OlA==
X-Forwarded-Encrypted: i=1; AJvYcCUDY2P5lcEiH6CMrNivQ2SLCbYJSsoV7Lyl5uLpCqgTWOmImEtqEuFH4nJoEBWylkeISVQKzwagPEif24o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4cJz0sbzkeE7HErmqXk5z6KCX48fzLugWBPvIgpo5PgRJYav
	ZXHg6k+9PoB6CpbZA8I1NJpgj6DDUtUuFUkejxvCSBfh2B2d7g+Wf6gQwBf3B2k0jDs=
X-Gm-Gg: ASbGncscgMn0o7d2QMA4ACdnHefNgDbYdfDH2qWc+MKzSFl5emKeY+CRx3if+fCoECR
	byF0/RgictR1vHXyZqje2fXSw9FDKTGFJubBFb/mzpkiH9XcwV+MMa3HXWRU84W9RTemRo2964x
	g+Rx7ZGnyRjiRSzVIY+mcSXVmYX7eijK8gOHTCbbxqXR3BkbNOU7haf2kVsVfkI99GC8F/7ezu7
	RFlYrvBEvrwzt5UzlO3kHoepsY9+fIGQjzB6GmkehkHyFCc+CaZaRjRGcl1R0qjFDhYmt51iAjU
	/vORpY12qwcEEBEzlyd3b+OftcRU+BfJeAK0j+chtuiGalq2Xp2VW8hCzstUZ7QsZWaqE0Bq3Hq
	Y4UxvjFsl9L9h4mDSW+LQ1oVUOVyIN6Wck0+rWjXs8HDwD5PpVg==
X-Google-Smtp-Source: AGHT+IEtGHThs3c5zaWTIBYa9eDjBCvzdPq04CWI3MnLdXSZNpbYivBg67p870OLCeNcYRQCUXTizw==
X-Received: by 2002:a05:6a20:729b:b0:235:d4a:1318 with SMTP id adf61e73a8af0-2390dc6512emr16725964637.38.1752913628137;
        Sat, 19 Jul 2025 01:27:08 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb157635sm2475260b3a.83.2025.07.19.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:27:07 -0700 (PDT)
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
Subject: [PATCH v5 3/4] drm: Remove unused MIPI write seq and chatty functions
Date: Sat, 19 Jul 2025 02:26:37 -0600
Message-ID: <20250719082639.307545-4-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250719082639.307545-1-me@brighamcampbell.com>
References: <20250719082639.307545-1-me@brighamcampbell.com>
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
index 4a7ca1261105..dff00d725236 100644
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
index ffdfcb57cbd4..528b5979ab8b 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -285,8 +285,6 @@ void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size);
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size);
 void mipi_dsi_dual_generic_write_multi(struct mipi_dsi_device *dsi1,
@@ -387,27 +385,6 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
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


