Return-Path: <linux-kernel+bounces-826332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF997B8E35A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FAA17BEBC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECE1E8324;
	Sun, 21 Sep 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfg2YKrH"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577219CC37
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479950; cv=none; b=npMaw7GcJe2j3G9mnMLazTplcVSTvA+QcpqNFKZ6/vB6OR8Eos/JZRkDuyN9a2SRL7ZQf9sqko5zaarf6jTjqljjvxzKvAl/1jbPhvIgatfXXquz8+uw1/T5MGjdtM/EfR4c9f3OFi1BlmivUY/xds90ibCKackZF/qJTg01puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479950; c=relaxed/simple;
	bh=LdcCRqz3KtQXSXoTHb+8mA2gEpy9f2TJgfnQhNHNteA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA2mJ7HUD3+29picsaD429MJk6gVejeGFo9lMdKKLfK5CyMc+47o5v1yIBcoMszEqwDkkve9Po+uWzjARHwnNO49xIylpfDUpVsVu8PN5EGE0vqjoB7DuM7phEtept7o7CkZa8FeHUIhQSLIRGmeeXGyiP71yU2/KCGmdsIhvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfg2YKrH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5229007f31so2736892a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479948; x=1759084748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq6jXGXLG3JigntJa3VtN4WdTvDP+hByOjJ1Pi4yPUY=;
        b=Vfg2YKrHaVbn+0gOmc+C4h7ftRMzmYRT7Q5eaFoE4eAEuaKszB2UTVKK8tVRaWDXT7
         hk7dQ65KvpC1x2pD8HDH45bD30YdIcXwMkAD3mzMHlXoGWU6TYGMtAbM90YmLT7GzFpo
         033tFrgOYrHx7O9nTWaSREyCDsTyaafm2we5psQxuCKkBJlBw5E1hSN2v4IuiFeATEES
         Q8gjlM7ToqHt9PgXiQDWN/iqKXnT2djEriPmxU5XC1BPuzmmZSU6nfleDHjSlD3YeHLM
         gSXzj6L5t7QBYYAAig//zNrtPWdKPdKAtnt7HHcOM5+Uf4Snv4x564JeCrOFcwf0fXtt
         PE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479948; x=1759084748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq6jXGXLG3JigntJa3VtN4WdTvDP+hByOjJ1Pi4yPUY=;
        b=YD3yUnoorEUlCtAFLB/XDLIbd+Z7NcczSTpb8IH4+GEqEmq1lsFC9WPuWOHqgLHxvA
         Yzr+GcUbQAWP1LXFFxcB4w0f6DLsvhhlKcWbjKdlWd2I0goNOyS2imPzzP9DOkQWoYLs
         p9DhzfCfxoNdHjeE+GhusVQ4wugVgpkgHYDKewS2adux6y4dy4YUP086/YNuzlYv2M3g
         O/XnVVfOFcCtDtDeKRNjf2LslcF1yeno5D3ltaDwdB6XQGpWFVGBDQ7SrIHwIUgS5unt
         cFEFS1lPynAGVc5ycXE6gp7+MeVtoL/6AX55INEfiTmOWL84IAAHNWv4wksRzPfwgNsR
         MWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI9kH7m1F5JrvT4IM/yjfPDDPsRchIOeCM+NqUm7AtPyuNITqB0SKcGSv3TAvRWS8NKlTcsXbEOdFeuZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fo92zp38bbGp49lrH3eFsgiw2Pnk9nNlrLaI+BgkUvT1zCzK
	USGOhWn3pAaYc/8W73WrnDIsyKI5q4rX20Q2U6fn+Q9OMsXwDO+GSH1z
X-Gm-Gg: ASbGncvPIl+ENb189MLl6eUq5lh7D1eLZF13xUStLgLZ+P1dpWuIySbhEmSnkGJl384
	FI/TpHH4GnzDrZVY/5fRkgUFopKYm1FTWFvngq/KhyGj0uwIQpZFE7GNjB0NWjY0JyXgiab/VQy
	+UYm3wezUwq6DRPYAn3Phuyyyu+J36toeOLeZxNgmrHHChB4oLx6qTuoCpFKlQPw3vYG4LYAu60
	0X8mrsyUBJEzPbTjNOsyeYCnvhvgQ8gvfp4nF06yUWZ9XEck4nsoT8iBufSHlEE8amSQFoMA887
	PZW3dSxO148m5XyFDXZrvDuBYy7fcCVBVJInChbA5id7m8Es0Rrh1GhitN+jUIIvx1zttJofZuJ
	SuW/G5IGXLN0LD0T2HQ==
X-Google-Smtp-Source: AGHT+IG/tBXYTLYsn0XwDsfXDr3GxHXFm/OCmsG97SH6xg+8qlRPLcBgWhtCsUeNNJUVJ4KN1b1Ujw==
X-Received: by 2002:a17:903:2347:b0:270:b1f7:2e5e with SMTP id d9443c01a7336-270b1f730b2mr82568485ad.22.1758479948106;
        Sun, 21 Sep 2025 11:39:08 -0700 (PDT)
Received: from fedora ([45.116.149.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm111053795ad.88.2025.09.21.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:39:07 -0700 (PDT)
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
Subject: [PATCH 2/4] drm/mipi-dsi: remove deprecated write_seq macro and chatty helper
Date: Mon, 22 Sep 2025 00:07:20 +0530
Message-ID: <20250921183720.237761-4-rtapadia730@gmail.com>
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

The mipi_dsi_generic_write_seq() macro is non-intuitive because it
returns out of the caller on error, leading to subtle bugs in panel
drivers. Similarly, mipi_dsi_generic_write_chatty() is redundant.

Both are removed in favour of mipi_dsi_generic_write_multi(), which
provides proper error accumulation for multiple DSI writes and is safer
for panel drivers.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 32 +++-----------------------------
 include/drm/drm_mipi_dsi.h     | 23 -----------------------
 2 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 3a9b3278a6e3..bc847ab5c822 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -773,42 +773,16 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
 /**
- * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
- * @dsi: DSI peripheral device
+ * mipi_dsi_generic_write_multi()
+ * @ctx: Context for multiple DSI transactions
  * @payload: buffer containing the payload
  * @size: size of payload buffer
  *
  * Like mipi_dsi_generic_write() but includes a dev_err()
- * call for you and returns 0 upon success, not the number of bytes sent.
+ * call for you.
  *
  * Return: 0 on success or a negative error code on failure.
  */
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
- * @ctx: Context for multiple DSI transactions
- * @payload: buffer containing the payload
- * @size: size of payload buffer
- *
- * Like mipi_dsi_generic_write_chatty() but deals with errors in a way that
- * makes it convenient to make several calls in a row.
- */
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size)
 {
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 57a869a6f6e8..e4d26ed7a62a 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -288,8 +288,6 @@ void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size);
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
@@ -382,27 +380,6 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
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
2.51.0


Test message

