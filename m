Return-Path: <linux-kernel+bounces-748945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347BB147E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1764616DDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD923D2A2;
	Tue, 29 Jul 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="aCv0LkFF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186F242D88
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767892; cv=none; b=sohTzXGM7n8Yf5DJ+CwHO7YCudYMVSRbLNSQmYvT4BHQXkgu/uyTEXuQg8nKGVlzqEjuG7V/0ID2PKQjQTlt0WG1hSzy3W49ZI55+OxwJe11ZWBf4MTuvnYcSO5htD3Ycgr+hsJoOUtwya9mrUcv/C26J6H8PppZN0Sh0s6VDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767892; c=relaxed/simple;
	bh=6U788oA/mMogHkuQXtX6agrhu6ltQgwoolGw2mxgYb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of0OPYnesWqMwNT1IrnyUUufjcxE/FVObXEOwN4lBVhm3DzNWDY5N2Qr8mf8bbKP8hrIGhV8CBJaCWMpebOats39l7oT2Wu+qTTdGCD9uXL4SCTJvhn7tbocNHg0r2cL4VQP3rqW6WwRkU4D9A92mB6hHMvvNg21v0Njkw7FbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=aCv0LkFF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748f5a4a423so3555256b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753767890; x=1754372690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIA0s5nBGDK7qRgcFeqARdwufY8QewmJ/Lc2uYtcY/w=;
        b=aCv0LkFFHH32apVs1oz+05xeaHDBflWDJ/WX1NDM0T39G/1STKKElhr5Dl7y2xbBfK
         ibRm786sCWe1mCwYbydr73XVPy0QBckzYoay5hvNdJV0ztQ2AdAS3BjnXw8g+qcqVsrY
         XYiNGtFSR+2Ag05Mwkq/IHyJbIdNvmPLeTERd1kQAEfTEw386imwOaIEngl6tLyBhCmD
         uQ0B9/W0WtIpz973SZ0tNyg1a2Sc/1uvxui0UfaezQrfyvlxLe5x9Jel4jJz7TpKWYj6
         AyezWR5UQzXRoQh38V40hGfJUj4XoFkuQCPC2GzxjkJ+stPigKibkeBd2QhCSk3gnrId
         wtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767890; x=1754372690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIA0s5nBGDK7qRgcFeqARdwufY8QewmJ/Lc2uYtcY/w=;
        b=qNd8vbRZbsuPthehrmjYRlgRZn5AK/Jh6LbPEhsr6WVQW1UCtwq9WN2Qv0rBlbcOep
         mcNQ44amwAYARcK2W2EMKHf0+ggY/zHjYEpEdnSC9zu1xmUnkmAtlf5/45G+3vIehvqP
         xyRJZrEkFuClMB+RZZpMz+bOq5nQtb59BYJmCWrI+RM/PuAvzu+/ErHNAZZUiUHM9P5X
         VmB+GkX4pQS+xrGl9Zt3+yTFQSaiT0w5JQNDHeJfV5aZrT74bK5SPsmJndm1KgaZ6RHM
         l5a+4u3ikv2auTI2Gn6kw2cebNKnKmH34Nvo13HilFl2YuNsWZFh1tJW0jcJ+1bxU0dF
         ZzJA==
X-Forwarded-Encrypted: i=1; AJvYcCWmZfyrWFc6m9NmN9LPjPLGRDrvowEy4XbFoUXlxMuMiR73vG/0x1nWuUsuB1WMlJz8jw87SAid9rFRTHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWubCellCVxx6YxzpTx3xc5jdlXio8bhc0kCtcOHIsqZVWwqz
	wjhXUhMIbnOiquWZnISOfZg4wOpBYmEnzsxKvd2yhT2S5u2N2zPktJms4bZxmiN2J9k=
X-Gm-Gg: ASbGncs9r/kYS0qW73Ly6Ocj6/vxP7Oj4l++mI3+KZeKOL86XCsvbqs4999r0K1vmA4
	LYaKV4yq4eQmTg05LSyFn+dvd34WyoTzORMBF29lHRL8Gauu5uPB7WW6kmlrDLs4rQhnrCwkFwA
	DsCqFq3YCPbU1eCL4eRcyxS0VCA8tug0WVkEmMeKg+ybAb1XTqxewEURZoSwtaX7QCyt5JOD6ue
	azn43Yfyk9UTFIrlBcBsKGC9KgbpOF3zhasXwxZOxD7snuCjnC/ubu9ojpgZGiJG4Zd6PcIDH74
	gUkqFa9z4pRTfS6du0GY/jNCcnq6062mZ2ai9f7WovF9d491sl5aBC3j4WgTJg3hQCIj470BQ1W
	Nxv1sCfqNRCGNMAjvCExeNcbeKHM8qZzCTPFBwwEZLhKp0FB++A==
X-Google-Smtp-Source: AGHT+IH1AKSCrF7h1/BRJs0PIKPb3nVQd90FUyuawr5Z43EXY+Uh73yi3uR1uHQBQf3YpLhP51DbMQ==
X-Received: by 2002:a05:6a00:cd0:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-763345c79femr22488250b3a.4.1753767889214;
        Mon, 28 Jul 2025 22:44:49 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a500sm6972462b3a.22.2025.07.28.22.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:44:48 -0700 (PDT)
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
Subject: [PATCH v2 2/3] drm: Add MIPI support function and macros
Date: Mon, 28 Jul 2025 23:44:34 -0600
Message-ID: <20250729054435.1209156-3-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729054435.1209156-1-me@brighamcampbell.com>
References: <20250729054435.1209156-1-me@brighamcampbell.com>
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

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---

I looked into using __builtin_constant_p() to extend
mipi_dsi_{generic,dcs}_write_seq_multi() to accept both static and
non-static sequences of bytes and store them accordingly, it looked
promising at first, but I found no such solution ultimately. At the very
least, if we find a solution at some point, my hope is that cocinelle
could be used to replace each of the new var_seq_multi() usages among
drivers with an improved seq_multi().


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
index 369b0d8830c3..bfee4071e89e 100644
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
+ * mipi_dsi_generic_write_var_seq_multi - transmit non-static data using a
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


