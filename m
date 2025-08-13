Return-Path: <linux-kernel+bounces-767116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50BB24F70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDEC723560
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46871288CA2;
	Wed, 13 Aug 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XwKHkSIO"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB1287511
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101784; cv=none; b=RgC0A5Y93366yP4KTDGBt0XHdsGxSs36MENep9WFzPwyfuKCDU1onFmjytKwarZpYS08cpzOBizfUlGB+x02B3q7XO0OQ+VmRzLoI7ioh1WF7ezp2Q2c0TaPg0MEP8H7f18M6VkrWGccrummYRh9un0OeERYI6ik3V7tBU7eSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101784; c=relaxed/simple;
	bh=ApN79Dtt5jypekO/KhlE1DLYefDIQhV0vkpnkiN4Xko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox7Z3TwDkCwzJKD426Lal7Wx2s2mdZoMLaIXhaKajlTw8qhysb3oaf8W2i0GJDYG37qg10C/t6aax/d/sDCid/a2OYBwKTq5HGpmii8jcQcez4mee+av03i33iu+OvEjiB5AUAVtf/l7N1IM91wSz5rt7X1ALFsUgBIDH70PDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XwKHkSIO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TCFyd8etVT9azwaPs92BWUORGBNE2YBN4q+4LkBM8Do=; b=XwKHkS
	IO0ibfv7Y+8QCxivRG8baE2TiRouuIuPToduD3zcmvsySw8T41QCLriBJ5xAHpMG
	2NMSncLeg0c3DaqmJx7VfNnU3PEJjiGIML+8F5PKnljjUo3nBxbg9iSeJPNey2o7
	e2f4JG9LIUzVlOUOIWACzKhktltgXkd4sd+ip+J97lUE0omIyKSYDzbMWYZS0ZqK
	+5uO6nDnsW/AnNoRIYz0VNVPf0vT9r0jzIzeqfG7nivoIdgH95O913q/ph99qcU6
	YfWjbrglkO/K6k3nSoaNbRwEfALrgWZrmKlmNWFQ0iJRfvZFD0j8wic82EJ1U13Y
	BYgbKGILeqMmwlIQ==
Received: (qmail 694745 invoked from network); 13 Aug 2025 18:16:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:06 +0200
X-UD-Smtp-Session: l3s3148p1@pgdOeUE8MJVtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 05/21] iio: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:51 +0200
Message-ID: <20250813161517.4746-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/iio/adc/sun4i-gpadc-iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 6b8d6bee1873..e4bc2e199a07 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -154,7 +154,6 @@ static const struct regmap_config sun4i_gpadc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
-- 
2.47.2


