Return-Path: <linux-kernel+bounces-825167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57599B8B27D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8616F1C266C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF7322C9F;
	Fri, 19 Sep 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP7iblUt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C9315D42
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311776; cv=none; b=edM5VBwpDPtKlaCQw9c9eIvxuwaFxYawWjXOEwUNpm+NqzK7Gft/YtlDTWltcX58RDbRsP+y3IcQV68wXbsSAd0xbZYI03poQVX0DZoc2DXrRpOkITLtn0yvZNfRUOKOJ6XG4CwuDYxGIg9hdBPhTWpi2WZUJs2KPoWcY66gaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311776; c=relaxed/simple;
	bh=h7sweuEsEGlPSYr+1OEUZsfHCl7ayvbSe+dikNXkK/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktpyoMX9cEwggnXgeaIqljfaNzXrDgO05MwlJDLdPDWarruiO6bvz9z2gw6epYMt+G4s5YozW1vtfgC7l1xx9eXh1RvQWhZ6eG+Ig4G/TcK7vJFHZW8o5zKDvtb2Sx9nf+xwr4Kj8gsN6DJ69hpj9EFGF6+nZtw4aV5ExJ0IUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP7iblUt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso18345195e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311772; x=1758916572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llSNvslw2CsU40qpSC7jOlhETQzQ9c1QPwEF6mALsL8=;
        b=PP7iblUtS/k0EbFTthrrl1Tt2vXO+4RAJ2SlTHoOTYfIXuvESDcBVAva7DF9vMLrge
         aHFmZQxMB1DkUaFxtxQs/HxOOHCe+AnYWinuDvvQOoqim+3TEq5HCQZDjiHU6XGie2I1
         Bdea4k7VRdl+zkMmt0kvJMxlchIiJKZRvCwnXzTxtHCQEo7LlHR7LZzlLKyRXn7rnZFg
         YmyOjUBDDwqSxE6kzt2oSXu0w18q72ry+Grnc+tNMHs9NiuPkeOmkfBGwmuuchi653OI
         f2wMhwk0H/I86gdMixFjo+1nuo9YShw/cn6x/YC6NS5J/lqqhSmaXV/JnGN5p7DjKbSS
         5XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311772; x=1758916572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llSNvslw2CsU40qpSC7jOlhETQzQ9c1QPwEF6mALsL8=;
        b=OC5V6tIB6EtkWtukVMmFjEsd7CNbJoW0AAbh2BC2lAMmihHMuADonHfq2aVxlVEVhx
         Fmq0LqRuSy2Ox/uYa7ldYuGj8xNeVuZ0hksoSJcHs5anr6hj1ykjBVCy7QXdk3759FCR
         JBVbsB9LMmSkDgdj2N/LXVk2kIvoDwjSxxLrbGE0rGV7IFTVks6Smy/oLgakWwZCXOBj
         eQhtF2JwXmJN62751XJS9Q6P8i0tuZfDozC7Bn1WrMAxIOltj7/yH08tvYMv//TGo/7+
         dRNaHhWxCZV5snoXer6gjT2qbtlM3j+SHFhsuGw4O+zpTite+3gAHUkeS1fxKnH1Pk1Z
         NPyg==
X-Forwarded-Encrypted: i=1; AJvYcCXd9pKrpTtu2jpyYEu8rrMUVd+yPG55q9xyjZP2nmm/S4DSwrIoMIUMrgDX6k0+cNT8jCVbY0N/44SoNvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrpzPIBl1I9YLc1tiHRjZ5jhPgI1WwrLCgTjWPfdzcTnC2PDy
	LLzmxgH8Cu3e0LnbxjHds6ohC4/eGtmu1zvzZbf78gegKOwEAV1RuemGJt5bhQ==
X-Gm-Gg: ASbGncs9vAWuOjtW7nMbd8zYw34GVhSvPy781rxw9Vx/mHi7uaj+jT8aNhyQTZD3D0o
	ig5Bzd5hXfHWBVt/yi2VszsIVrfxIrltGIchd8oP0SOjs5SxrXy1gVLfh9HEm07NP7QK8jhhckP
	YiBWjM1eg0ZtpJGuR7hmHZ3TelKAagtNpQpvazskwDt4J6r9GqJO+h9nBdyxTx04dwxsFlhaONk
	5HjcNfFQlvq06/ErlgWkooHFMiJTekko6vIQVq/3MNpNQek9H+G09lB4WANi95N2BM4nBywG9Z2
	kyBnUNZI8RPXQ2HtzDcYr8dbKOi7dJUqsxcPBk2m5L4VeJQ8zCwaTvY4gp/m1wuMyniSN/OHQiE
	nv9E1ltIegJidp+1xLDtZZ4YO2Px7JYoFOA==
X-Google-Smtp-Source: AGHT+IFcYVfJ+wi2LF4/5toTMUmLRgsE3vKXz3aeW7P2gPLBbkp1ZGcAwumQdy1dQXmI6Iv1rP0I2A==
X-Received: by 2002:a05:600c:5250:b0:45d:d3a1:70dd with SMTP id 5b1f17b1804b1-467f110c297mr36255215e9.35.1758311771608;
        Fri, 19 Sep 2025 12:56:11 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:11 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 4/6] staging: axis-fifo: remove get_dts_property() helper
Date: Fri, 19 Sep 2025 22:53:58 +0300
Message-ID: <20250919195400.3180039-4-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
References: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_dts_property() wrapper around of_property_read_u32() adds no
real value and duplicates error handling. Inline the calls directly in
axis_fifo_parse_dt() to reduce indirection and simplify the code.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 39 +++++++++------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c500cb0555b7..21fcc9150d7e 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -502,30 +502,14 @@ static void axis_fifo_debugfs_init(struct axis_fifo *fifo)
 			    &axis_fifo_debugfs_regs_fops);
 }
 
-/* read named property from the device tree */
-static int get_dts_property(struct axis_fifo *fifo,
-			    char *name, unsigned int *var)
-{
-	int rc;
-
-	rc = of_property_read_u32(fifo->dt_device->of_node, name, var);
-	if (rc) {
-		dev_err(fifo->dt_device, "couldn't read IP dts property '%s'",
-			name);
-		return rc;
-	}
-	dev_dbg(fifo->dt_device, "dts property '%s' = %u\n",
-		name, *var);
-
-	return 0;
-}
-
 static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 {
 	int ret;
 	unsigned int value;
+	struct device_node *node = fifo->dt_device->of_node;
 
-	ret = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width", &value);
+	ret = of_property_read_u32(node, "xlnx,axi-str-rxd-tdata-width",
+				   &value);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,axi-str-rxd-tdata-width property\n");
 		goto end;
@@ -535,7 +519,8 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	ret = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width", &value);
+	ret = of_property_read_u32(node, "xlnx,axi-str-txd-tdata-width",
+				   &value);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,axi-str-txd-tdata-width property\n");
 		goto end;
@@ -545,30 +530,32 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	ret = get_dts_property(fifo, "xlnx,rx-fifo-depth",
-			       &fifo->rx_fifo_depth);
+	ret = of_property_read_u32(node, "xlnx,rx-fifo-depth",
+				   &fifo->rx_fifo_depth);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,rx-fifo-depth property\n");
 		ret = -EIO;
 		goto end;
 	}
 
-	ret = get_dts_property(fifo, "xlnx,tx-fifo-depth",
-			       &fifo->tx_fifo_depth);
+	ret = of_property_read_u32(node, "xlnx,tx-fifo-depth",
+				   &fifo->tx_fifo_depth);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,tx-fifo-depth property\n");
 		ret = -EIO;
 		goto end;
 	}
 
-	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
+	ret = of_property_read_u32(node, "xlnx,use-rx-data",
+				   &fifo->has_rx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
 		ret = -EIO;
 		goto end;
 	}
 
-	ret = get_dts_property(fifo, "xlnx,use-tx-data", &fifo->has_tx_fifo);
+	ret = of_property_read_u32(node, "xlnx,use-tx-data",
+				   &fifo->has_tx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-tx-data property\n");
 		ret = -EIO;
-- 
2.50.0


