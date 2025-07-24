Return-Path: <linux-kernel+bounces-744886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653AB11224
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255963AA339
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F41246BA5;
	Thu, 24 Jul 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="jER9ZHmt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B20239E97
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388627; cv=none; b=lMchBul0/XCIvWi+OKpRYaoMcLMHYufpaqrtHEjB2kyjnbocNxWk5ZJwqLQyhnzfgOUyWQSSLcrozoZiMNe0TdTzwr8lNEaFFmnMjyiutfo1iLgmz3zRWasZn4MbEcdn1f9HwqHj0GuSeE217C5cOx6S8lJadNo6GsX8zVMpyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388627; c=relaxed/simple;
	bh=dOzIfOlfdE8v4g6Un7FNFy8FVfvT/2CSsf2AjeqPRX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsM2ahu2QMRLE5KihqC/YCAODSp9SZoE8Ax/DBal9FGWJOcBIeJt0iAO/IWU+xrMCLXO1HLEZOs0iaMvXPLsgzZwIKHXUKSq1E8Sd0D/svgYkGwO+miBvrXhi6CZr1SlzPC3j7BqmTPbul7b4coKp2hTmfqDCTBw5DHDDW/iwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=jER9ZHmt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1380609b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753388625; x=1753993425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4zUj/idKOirKhzudfRqBBLM0pFf8X+XkqCIOZ++mo4=;
        b=jER9ZHmtmyDwMzWfqdV39ZEHS70g/giWH/6wMdNOKqT595L/4tpI7G/EIsATJYDFhk
         7s45zlYToEq8MFBhVWoQellPP78xZATpm3kl3gGA5RmeJUVMbYVMpDHojzmn/sgsEba2
         +H4ybjoMrgv42+pSUDmv9ux0ilx5huH5uA3sIKVcNQy1dn0GkLS6Sb0/fWOfuVoUmP2I
         hpz1m65mGR+Qa4ifGJXFx2NYEpt9SPQuAKiN3HvSf1ieCV0EbIGQFDg/Q9ZZAMIph0UN
         b0ko6EfQndoI+c0FYdHGM49o5Rd2OgyXwbhLNjUAm2MZpoC6/gIo3RGjrRDwx9hwOF3e
         bgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388625; x=1753993425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4zUj/idKOirKhzudfRqBBLM0pFf8X+XkqCIOZ++mo4=;
        b=oeOmjIq91mi7r1xFy9EV+T8rKXbh/LFBMgTKKC3zig6YYiwWzSE7zGqnO4KqTDHnMH
         ZMm7JeQpNM+rKsxvb1lBjQFs+pxKLXzvestWhe86al6xRvUSIqb135uR/3ymGBv3RcOm
         P+MA/hRequmgFMlEs4v76hSeIgCxWM5qfcofdtls+R5Qa9g9VC9jDM8/j8uckWtPJXF0
         Z/jhIL8b+0h9bOYnGYyFh6R12zN54UJXw2z2eobWrvAx1TZ799c8n84P+VcsWw4Dt3F+
         3K2hZ/wGr8SmYSYS72uVH/hBlKViMQzDvAQ29TiWy/3k+uvGUmYuKOYIoTKxs7gIIoJe
         JMYA==
X-Forwarded-Encrypted: i=1; AJvYcCXLE7u3sWhJDLCr/3OWuEuPzo+13mYoNd25BvSATDP3kthafAfo+bFVZHwXP5Jvu6NfPndOA00YXkr/1aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxeMlvTRXGq+McruPSrCI1LScy0qtbuO47zqBWfJnoVsaGSgl
	YZldayJZGp6NtPfZWMXUnufQWoVlgook/GjkfZCN+1hd1FuLuKPRVekioIqGH2Bcfew=
X-Gm-Gg: ASbGncuHlk79108J+dfrYkfGyXdIQtmID4S3JbpCq+W0PwZCIkstttkdTxM1jCnPAMv
	VVN0l+Qnr7g251ND0KQP1hujZ4BFHdBna6mgCXthZWakf0T+pM3VFBIz3UONKAos3gneLTPIrJO
	jg7uLbcv8F452xK5NM55TmXu3qomlug7Atq15XEAyPOOemVnuSwgA+GiLHll+FOcarQhCW3e8NW
	03Ddew7DchcsF+hsmTRvCQoIvJt6EOBydNC6CSZ/+9N9iW+w/hvybNVGoofK3PaPQiqoo7umfFh
	SAc+yGkIt3Qy6Im2cNdpbf5fYaYXeK3pR01UNBN7NJSVj8xsq7mmhmJ+t3U4B1WWscv1JC7ivPK
	8Hsnhg4CLe8+13/LFFyXrQ/Z6d1V6lTsh6vR1av5d6mEz1wImb1PmQifOIsx4
X-Google-Smtp-Source: AGHT+IHd+bt4vHJ39l4CpLf5WhIwZLQkiEEpVe8TOKkAb1COeGQGReplWtQ1IyJKNtoQWNlr1/1dZA==
X-Received: by 2002:a17:903:b8c:b0:21f:5063:d3ca with SMTP id d9443c01a7336-23fa5d73fc6mr46051295ad.16.1753388624999;
        Thu, 24 Jul 2025 13:23:44 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dbfccsm22077815ad.138.2025.07.24.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:23:44 -0700 (PDT)
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
Subject: [PATCH 1/2] drm: Create mipi_dsi_dcs_read_multi()
Date: Thu, 24 Jul 2025 14:23:37 -0600
Message-ID: <20250724202338.648499-2-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724202338.648499-1-me@brighamcampbell.com>
References: <20250724202338.648499-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create mipi_dsi_dcs_read_multi(), which accepts a mipi_dsi_multi_context
struct for improved error handling and cleaner panel driver code.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a00d76443128..227b28555174 100644
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
+		dev_err(dev, "transferring dcs message %xh failed: %d\n", cmd,
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_read_multi);
+
 /**
  * mipi_dsi_dcs_nop() - send DCS nop packet
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 369b0d8830c3..d17c00d299c8 100644
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
-- 
2.50.1


