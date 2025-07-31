Return-Path: <linux-kernel+bounces-751553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9995B16AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2C818927A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4423B626;
	Thu, 31 Jul 2025 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GsfC5GMp"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68E23F27B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932235; cv=none; b=uPuMMwgZiYXuu3KtSEr/InZ4hmNn1qxcdrID7IIJdXuUfYgKrZSHNpzxdgIf32M/r7xITGrqyM7jaF+dDfhA29MEvXR+C254YA6i4NgGtSP+5IFe13ZtElN5O3UucschhZ3M/hioLQaxQf8vkv1Ak6ONnhC2PTuuat6TdIJuojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932235; c=relaxed/simple;
	bh=LLFmmNUX/DfeDumtfAPB0PNqG1IDii9NIMiRI2MPg3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEf7RVcJ6SjrqRzk/9YO9EfbnK7x3ZKvA78OeWMUyH6QjF6UIshzRd1PnBthcA+OY4UmmaBrukG8Trk5m2Fc5z1JWE07IwNtPY+emnrjsM2m91O0zPja6jnB9xpru3pklvDnF22bWebWCOnSW7Kp+mlZtzbRe2Hyr18Feumvud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GsfC5GMp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24003ed822cso3529635ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753932233; x=1754537033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO3wVwEDuSYhrQ+FF5y/l5gPvVgHJtS+tEfRcRSUajo=;
        b=GsfC5GMpMtYRzPX9tM/lW9f9Bxyq3YL+TRYragSk9tjtpotzCskkdTRKE7xPWzTYv/
         s4soT8W2gRVn6A49Z9dxdMHMaDtdAjnKBoQ/d1G0gX4rBcwCL1jTATBqG8bOXaipUXqY
         PjMc94uVQOs25FMWVTy11ZkJis8PwJsTyT1exw1HqEE/KbYRKYyL9VGs38Xm/3yU1Ab6
         nOtmIB+AEhk7Cm3/YxIdRk4J3pek7NRKw7GsJCDxgIt3mCl9jC/rKpL8xDvpx/RN2Yqp
         gM8mq9LYI7OX1m9HwUQYUDKbHrni28zakFSO5NCpVOO8uic0ZgFRAmDXhnpFemidipA7
         lgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753932233; x=1754537033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO3wVwEDuSYhrQ+FF5y/l5gPvVgHJtS+tEfRcRSUajo=;
        b=N1J/3wVJWWISS5VRaheNerkivfFVrzesSoqjgtXIpYb4jd98htcz6RxCNkrH9a6HNI
         tMaUxtcrfjNQdzaVXQxh+w+MnW1a9e0fIJv7pCqpE2nNxxBxYCcdxO6jJXbqHAuBH8uF
         FN8b3LimVZpCYBPcxJCL+QsoBxdDhNeDq7w/mXmpy47dqfxKqDgx3JWfftL7DrTOidt/
         YFtqoQZNTHqkywA0J+KYYWTqoal5eCulRSdvwYUdD3PKuX85flPWO8dYb++6TgWaNahx
         /lshaSt0CXA+wgIFFnxG4fry/M9qqxIj2x82c93tlU6NA7F9TyCE+zJmPfB4qOoV3T1J
         CiIw==
X-Forwarded-Encrypted: i=1; AJvYcCXaImrZOT8PIO7ph62fiFXtm4BN4LuzubxqE57vdyUe5LyVkBToZCtrhRX8PsUXYvAPtmbPIG6e3j3lPF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweywjFc9C0THEUA1y4H+ZykZBvPslLoPUZPwleE1ND6m+fywnE
	zoSTShKA/gShTcBi2XtQXebhVR5lB942lFPJ2emK5LXpjkrep9tq5RdaUAwMcUp/ubs=
X-Gm-Gg: ASbGncsob7Fa5IEI5lRGbVh8zx+lr7M0MJuG/dKULp0DBtXmluWATkFcoknNXnyvpQt
	G1BrZrUzMtZqVPrhXEA2q2w4+DDxk6kzN1GZymh99udH1ANxmfUuIrYBnub5EWSqj9rfwjia9tn
	cGYmVB4k0eMsZyAUNWi7jYBZ6CVHwhhizLX3D7nS1P3LylWKN1Kg9bsyIOrJ1Xz/UNZ2yHAV9s4
	aFBDB9MQwZC59nb3sVDUGYiU1tHBbbM0D8Sqxg7IHfasMv09m/h7UhNV0QfcBBQjIqk5b5/zX2H
	d0qBK574TSnn119/hlQk/OjOJSmr8NVrTJOUFHTvu6ob/ZS7lGt0umf1JD0fbFYshwkHTbtFaCT
	VYWCZL4fmwm2iGW8/v0JcrXavNcAKmJEwMn1Otfdpw5zVqPTwKrNGT5vz2NJY
X-Google-Smtp-Source: AGHT+IE18gcw1L9AiSBmhHHznkEqWPINFS1vbZ9/Dmhaw4XfpgJGvjyRPijQawkyMW2EZS4l0LoVIg==
X-Received: by 2002:a17:903:3bcb:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-24096a9ddcdmr85611615ad.16.1753932232544;
        Wed, 30 Jul 2025 20:23:52 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f15092sm4854795ad.66.2025.07.30.20.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:23:52 -0700 (PDT)
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
Subject: [PATCH v4 2/3] drm: Add MIPI read_multi func and two write macros
Date: Wed, 30 Jul 2025 21:23:42 -0600
Message-ID: <20250731032343.1258366-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731032343.1258366-1-me@brighamcampbell.com>
References: <20250731032343.1258366-1-me@brighamcampbell.com>
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
drivers to write non-constant data to display controllers.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
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
index 369b0d8830c3..f06c753603ba 100644
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
+ * mipi_dsi_dcs_write_var_seq_multi - transmit a DCS command with non-constant
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


