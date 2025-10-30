Return-Path: <linux-kernel+bounces-877892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27716C1F47F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A944050FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56702340A69;
	Thu, 30 Oct 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H8cEYKS7"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C0314D16
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816426; cv=none; b=O6wcFJLYp3eacfev85IDZV9pRRTKtqXbuE4ysL9Tusu1sgl0wmqSGKXujaDh+GIQ5a0gGrAqG96Ui/p1YoPamlXbjBBIzYEN1eUiv0copyRMOF22h+sxolHBNjMoiYWA7i9Y7SWXf/F0q8oGfiMtkWLJP3YWi5avDyIstfOK4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816426; c=relaxed/simple;
	bh=PFszx48unL3OZdOKxZC+O4/dOvgkdgU64h4yg5QoZts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIPPX99tyQuc9IZZcIEELOh/gXwLpd0yh4gSq6HNn1WqQjgEjlqOCl9XdM6EeiWrtaenx5PhWfgAvcDdavA+5YDXX3E4u2zXEIpQrv3xjWOortxLcay1b5XYHdaWbqPuOEEJSrd7pc1BTQ4T3lphOlKrfXulAfZHGlnqxWHLxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H8cEYKS7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bcb25so455345f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761816423; x=1762421223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmA+fxDwXNd4r2km4orWOLxYXAzQdDkMb/ExdCUz6S4=;
        b=H8cEYKS7gEvV1g3l2fNNGUPyw0Otz5hI/EdGOSAdqygJOkyI03uFiTOpAgPV02i0yA
         kZWrPTNGmmBEAfzbWpEXtjWSwx1JldcDVBmgGPXZ61Q82+i7Tics/dir9twY+PK0v50u
         3jyL3BwEaR8RPkNAgfBKhII36ZSEJhvy58mioYhHX3h3sEhyaX/6oOYtIq3eBP9anrXq
         eZf10eovKsqcFgmdyiP1htiTW1oA8Cgy5XkKQleMYyepocTAq5ZC7k5Tj/np/AA1mggX
         lvHEP0gK2BHPpSdGgF5uTdD6CCrTrTx+bXz2/8SwlVaJa5uUrdse4DCjvoBV4ySlZO1x
         AMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816423; x=1762421223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmA+fxDwXNd4r2km4orWOLxYXAzQdDkMb/ExdCUz6S4=;
        b=WQ2dX1ikMFphE4GTko66F/Q1v191pZIPFzVLBGnD9qC3Q5hhFHHDk+qNof0PYXAZ4v
         xhrw+VxK67bhEA4wBpC7AUklKTe65XtxuQ+2sYGOZHBswXULWv4lzIxHgHOKy/u4BGFS
         g+INgtjOcZFwWigRQfO32jswrHXEJBfqAgwt6OPWqtzDOFRCrO9A+URPYzU9f+AoChkA
         1Av3hHP9qndXQ6VGdUSQ18+mCrB6y6eIi+Zhv2MtrBDkCY7QBRPNXDWplFlR+0BI1aa8
         DVqQoRBIzcFhqdoSyI2M20/0FiNdi35xJbyQe+Q/Od7q6uR7P7z87hJo/7C1rMruBU4v
         tJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXVpy2VO8u6T0lxb7Iz1P8ZyW10NmyTIWN1ZbIECyP91GeZuPDRtlLpP3fGFfWH36WDbVPgr8EeleqKs8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CBK+8gfG1xevPvOm5VOKnpl09TQMh0esYXT3WFrMVbY3Ti4Q
	wTkYof2Vq76etJBw8cA0odhWIXild7OFIsSBxG56Ls7WgUe+M5XD1x7JNDxcVK/0XEk=
X-Gm-Gg: ASbGnctfhKwg9smdysqqHytLu2htK/OGKOkyyKMsvji507OtQq8j1K3ROfJOvda0LRG
	n+Y53CkhJUI0g48Xm638kcyRH10d9mCngDL50oMorLepmHN6ppf/G4DO9oCGHovf3z9wkYNIppN
	VmxeCHbB81O72afuaYrdmy5x3neHnUu5xEjxp2p8FZrQP3KB3ZWsgyEI9CtGCGFZPDHGfSsFVyL
	QvynzgZxjR9B4th924qCgJgobNL6VQNgKbc4/rrGYH+0gimbAE1JGcq5JfmfjSdHFpCtZd+iczW
	r7+sA9G32qVpKIQD7HNG2+k94ILX63ucqBE02Yfb4GvISJXalrlWtF5EjwwIeMmS8nhzsH1j4kG
	02m17X4SGIugJCFAAMVziaD+kOQ3mb7l09Y+hdbZGkCVmAv5CZ5WelVqaHWh2etXDkA5QqcU9xQ
	==
X-Google-Smtp-Source: AGHT+IHQFpBNqStZU2m7ArSoDKfBgtc5gawxk4l8iU8TmUA/zx/GzBMN7nc7bDYsG15F0FLbqaObcg==
X-Received: by 2002:a05:6000:430d:b0:3ec:d7c4:25b6 with SMTP id ffacd0b85a97d-429b4c8c17dmr2230439f8f.27.1761816423068;
        Thu, 30 Oct 2025 02:27:03 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477289e7fd2sm32748615e9.16.2025.10.30.02.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:27:02 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:26:09 +0100
Subject: [PATCH v9 2/3] firmware: ti_sci: Support transfers without
 response
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-partialio-v6-12-b4-v9-2-074f55d9c16b@baylibre.com>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PFszx48unL3OZdOKxZC+O4/dOvgkdgU64h4yg5QoZts=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmfZdLa79JSd9ZK1y3jeXLxcQcdrbfDgFdDhUfDJ/5f
 T4Qq3Cio5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYSeofhf4go144rH8qdN4dw
 878ReTKj2XCrZ+RBhtCinS3zZ7V8es/w392+60AHs1z9zTQPRef+sNqMzdvlp7UUOp9tL5eILH7
 CDAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Check the header flags if an response is expected or not. If it is not
expected skip the receive part of ti_sci_do_xfer(). This prepares the
driver for one-way messages as prepare_sleep for Partial-IO.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 24ab392b4a5d0460153de76fe382371e319d8f2e..4db84a92a517b0aa7bb8d47e809d9848a16e2cc4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
@@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
+	if (response_expected && system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
-	} else {
+	} else if (response_expected) {
 		/*
 		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.

-- 
2.51.0


