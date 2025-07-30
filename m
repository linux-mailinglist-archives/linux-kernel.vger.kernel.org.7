Return-Path: <linux-kernel+bounces-750226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4AB158DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C79160A39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B511F5435;
	Wed, 30 Jul 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="C/0oMhmv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE41EFF9F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856280; cv=none; b=dZfsYZQxrggHHb+BSCBx/ViIBMd3HQLXBR+JLVHYsA5Bsckgl2bIM9A7n+TN1TQYtYzdTsJE/8Dysd3kfj1ZmBDm4QIOFZ35xF8vRA1ydGKWsxxSEViW4DXnutjp7qev8hfFNiFeCr4h3nApUY5iZQfHcItvg6oKSfvRhs2D9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856280; c=relaxed/simple;
	bh=rn+F75Q915wmAwk9yOieQK+TRpHwahuag+EZMKYFW9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTBnE9GEwkJraIBqkeaIkJiZcm/J8u0/BdmVm2bdxD+yLN75bsYtt6qSfs+HzHV7SypIbVGycOI6WabBx92zBpF42P7YdZqJof2+jZG1MB4eTx/wp/K6HuwKZlcFmAEJK5yCBHt8bGqGaOU0PEHN2JPZNB1LLPLZmSWr9fkIcXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=C/0oMhmv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167afeso57275335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753856278; x=1754461078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTa7ttMugFu1yCj4YKK1TgSGh01SfTxQdJKN90Hkmps=;
        b=C/0oMhmvvAeAJ03ODT0kk3RoNXmtmKyElm/nq+oMGppCsDh94nP6+9lokJMyOqQQqY
         muN8BYpJmpnI97IP0cH4M86GUeH6UmMtmTG9/pHWGpzfnvfAPAcgDaZICXOTRhGWWsRO
         eV82Jl1RPy0lgk5BtSj6CPMiEIgKEYj5QDnXqJOOjx63oM7G5ktH/a1v+HNkjidnQyYy
         NXNi948YhviL8eSi3qCIQ8KCOcW9cW+tcvDeoHpl34hf0Z461/ax7l0wdv8P0NSrSLLm
         feMHTexXFA6ajSiz6lUxmJJB32Hu/sUNawpIVSiFPK0MQwAwhTa3AisCMzNtX9UyGVA4
         dpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856278; x=1754461078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTa7ttMugFu1yCj4YKK1TgSGh01SfTxQdJKN90Hkmps=;
        b=VKmjlsnIm9GHCEH4nH9tLLCVLLa0qFmm714AK99S541yrC983hT8KtRkG10DHwxCkY
         HVC1xB2kXZAD1O3bmfSYpzrtE065RV8l8QAdotOVpdpB04hzQCrDU57Y1QvHVhX/WY+e
         Mgqhp9sSVQfTQ0NnQ2xoVQFH1kV1IKi4pKfv4VrVX/fugVMyf5o2tCUgWR3zuEWC7Kz5
         EEv32CHo5xlvrewbqO4lIybCyxWb+GvyJWeXulS2Y4ZIdl/VePnmIYZYi3CfPcNex5Mn
         dEvCxGFKLfPhg1wrmYrG3lCKnox+yD3xt8ES9QVFVmvURGVllRS5GIxSdm/er4d6UHTK
         6TVg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2PxELFNetFrb9aw2894HrscpImoJPUl/8XXjADn8xL8+9nYn2C0di200E47kkwtPh6/PCq0EKt6qtps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe3QTcpnwKGBQpf5RYUe6Nvn9WplzbWdVplY06SYXqe6/TsM9
	AWjyhil4OPekBLyGDNnzb6dtCSwhFPypIEujEq+jGzf+qjzMPj8o5R5ctC4nR/gHu/Q=
X-Gm-Gg: ASbGncuPOzjvSujXblHVahOQjMo+Q20vqE1tSBi6lVlbmZRq9g2u+hasK+sKlbaIxx3
	/+ZpUEJOZyptGcrwsb867d8uJXxxJcRkICaOY5lPGR56IRgLqFqual86g03FrtRmYIERAedZ65h
	RymTNsG5A7TYe4uGb6QWCZS1m5bhrj55CgiRMdpFyP0ULptt5vE8gJdLu02DRg0lsPSBZ3xPIk6
	QIIzmb5W/+uQa0FGLkaPwpczy/vCY3LRVf7LXeUeXrt+3851rMPEgDanwWSW2mHgQnxqQy9mIhg
	cyL1/e2Vh3sWCLaFgg+VM074NB9jS8JJjg+CLATQyQYpu6cq9B0eb71ba26B3gos2TQZR6vHYI0
	ykDowdiVmYITO0WNd5Za0RyzzPJtbfR0uFMJDsAmwaP+k6+vGMu84CE60djjd
X-Google-Smtp-Source: AGHT+IG0UujJqciGiZSHs2MLJH0uOtfTc3Y0Ak8pUJ72jExypcRAeZTfDeAiGFaPBnABeOJag3a8BQ==
X-Received: by 2002:a17:903:2412:b0:240:468c:83f1 with SMTP id d9443c01a7336-24096bec816mr37844195ad.44.1753856277729;
        Tue, 29 Jul 2025 23:17:57 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm75017815ad.115.2025.07.29.23.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:17:57 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 2/3] drm: Add MIPI read_multi func and two write macros
Date: Wed, 30 Jul 2025 00:17:47 -0600
Message-ID: <20250730061748.1227643-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730061748.1227643-1-me@brighamcampbell.com>
References: <20250730061748.1227643-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create mipi_dsi_dcs_read_multi(), which accepts a mipi_dsi_multi_context
struct for improved error handling and cleaner panel driver code.

Create mipi_dsi_dcs_write_var_seq_multi() and
mipi_dsi_generic_write_var_seq_multi() macros which allow MIPI panel
drivers to write non-static data to display controllers.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

Doug, you had suggested a slightly different shortlog for this patch. I
adjusted your suggestion to fit within the canonical recommended
shortlog length of 50 characters. I understand that the 50 character
limit isn't a rule as much as it is a guideline, but the current
shortlog seems to me like a good compromise.

 drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a00d76443128..0f2c3be98212 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1075,6 +1075,43 @@ ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_read);
 
+/**
+ * mipi_dsi_dcs_read_multi() - mipi_dsi_dcs_read() w/ accum_err
+ * @ctx: Context for multiple DSI transactions
+ * @cmd: DCS command
+ * @data: buffer in which to receive data
+ * @len: size of receive buffer
+ *
+ * Like mipi_dsi_dcs_read() but deals with errors in a way that makes it
+ * convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_read_multi(struct mipi_dsi_multi_context *ctx, u8 cmd,
+			     void *data, size_t len)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	struct mipi_dsi_msg msg = {
+		.channel = dsi->channel,
+		.type = MIPI_DSI_DCS_READ,
+		.tx_buf = &cmd,
+		.tx_len = 1,
+		.rx_buf = data,
+		.rx_len = len
+	};
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_device_transfer(dsi, &msg);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "dcs read with command %#x failed: %d\n", cmd,
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_read_multi);
+
 /**
  * mipi_dsi_dcs_nop() - send DCS nop packet
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 369b0d8830c3..296ffdc9cd02 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -333,6 +333,8 @@ ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
 			  size_t len);
+void mipi_dsi_dcs_read_multi(struct mipi_dsi_multi_context *ctx, u8 cmd,
+			     void *data, size_t len);
 int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_get_power_mode(struct mipi_dsi_device *dsi, u8 *mode);
@@ -415,6 +417,22 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 		mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
 	} while (0)
 
+/**
+ * mipi_dsi_generic_write_var_seq_multi - transmit non-constant data using a
+ * generic write packet
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @seq: buffer containing the payload
+ */
+#define mipi_dsi_generic_write_var_seq_multi(ctx, seq...)	     \
+	do {							     \
+		const u8 d[] = { seq };				     \
+		mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write_seq_multi - transmit a DCS command with payload
  *
@@ -431,6 +449,23 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
 	} while (0)
 
+/**
+ * mipi_dsi_dcs_write_var_seq_multi - transmit a DCS command with non-static
+ * payload
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @cmd: Command
+ * @seq: buffer containing data to be transmitted
+ */
+#define mipi_dsi_dcs_write_var_seq_multi(ctx, cmd, seq...)		\
+	do {								\
+		const u8 d[] = { cmd, seq };				\
+		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d));	\
+	} while (0)
+
 /**
  * struct mipi_dsi_driver - DSI driver
  * @driver: device driver model driver
-- 
2.50.1


