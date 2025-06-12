Return-Path: <linux-kernel+bounces-682643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97250AD62EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2747A575E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D592550D2;
	Wed, 11 Jun 2025 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="01z/EGVJ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E62BFC76
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681792; cv=none; b=lQB+tU6bzBhoj9tEn+gaOXzeTUzFAmTnjE5xMPXX1jfFb7OpzPleMHUcINkSsSVBoAuxmChR9kOOs5jTRIAck2HbhSQVShfH1PSDkC/25RqGVSvANZMaRaQKzSm58nUW77ssmqRStuCbsQtKbHJzf/ualmrxRTJK13hj8OkLowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681792; c=relaxed/simple;
	bh=PE+CsjhnIQN3X+3KjjOXuO9jk19Iju+HayM9vpAuU1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhJqARTd2tkgm6RaeEOpZsKh8fZjHl40b70XIPAK0pgx19fWbvWMcVHx5DxqTahsHaThl5ptpJJJ8EPqvLwdKHGyq0PCUveyFNcA3dE7NJMzwR2nb+cA7kxlUzdpvIH+0guUHxs4DDExtpm1FWP60SvtorV7aGK7/RSIOZfh+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=01z/EGVJ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4079f80ff0fso864974b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681789; x=1750286589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIUkxS3NJlxCBqe+Jr2tfFFp8ENb+E8Z8dAwWew1sZ4=;
        b=01z/EGVJH4AU1BIQYX3ErxycQwUN34+cC2SUH4YMUZpAsiMbpNSNkLFhTZxLiZuMKd
         1T2DZ/QrvAKv50rO9pAomBKkq/PiMFghSGxYrjKr14PXC1nbaI+oW/iHZn85ftmeLK7V
         gtLIOpSmJtkAAzIkcowd8f5C4ZRuZ77m6EWV72zScP1zHzJXQV+FNDWau/p03ughsFMZ
         JcC/UwkypQWno8HR5fRjZqvOMPTtVjjRB6cQsw05z/JDH7NVAARDwj/FrhK2Oa3DhCSu
         5gqklboQtMB4MP0Tc/lZ8ZVnjhuVBtIvKwOoFBj7U7pZDskbnDp28HCmqpXVbwBichdr
         yxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681789; x=1750286589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIUkxS3NJlxCBqe+Jr2tfFFp8ENb+E8Z8dAwWew1sZ4=;
        b=tCleVLDlQvGiJxQHb5rKN56EBBeBiqEZM7UWAKZ4cr9mMEDDn6yavdSNeiQgh4TJVb
         sMQ7ImGav5VzYN18NMjXictRzszUkR2n2Pu2aEFxpfiJtKnkfbkaeb46nOv6WfDjXEuF
         xnClKPLuK0hsRg+KjwqFXxM8b5nMLXcyXfO+oOUtaYMG9TXNVmMzkY5PeytkR000RFgL
         s6w0WiDHv/Jsr6q9z6/3mPELYr2/rrpP2oS0aCP19/1U+nC5FftHxOKqqHc8kOclTkEC
         oKfz4a9CTH2ty4qQMKZE1F6mJccYCDwCAK5uEA6pjQ32k6naWe6dMT4w0PcmJysOmHNn
         UdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWxLktJYQT8f5yzZBnA7p1HBHlCojDE4YIPMwEAX7GyrhwefQGJS8a8PrrfV/VZ+GEYfpz7PnU6ktUwMto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxP6ZRVleGym9uBWD81VtV68cP3s4iIvkpei48bzTGmGB6+NR
	xcpmcs3+MjxvRhQzD7ge7YK038b2eWb3Sl2vATJGK7CQ051OYwJyDEPpKRbsHk8eOTc=
X-Gm-Gg: ASbGncvGuVSpZn9C9Um0LlQ8SIIV+Gs2y7jUm1N11DH1FeKQQNc3x/Ucjb8cC2kRaxL
	zo7MvbG1m3QXT0NkJDPTU2kkHCLWXVrRw2/7yYyC98ZSvD4lrs7SYQJWmQlPzBnbd+hEj1gscGl
	Bsho4zhQRBbs5OsyUj5XDHJLL7gpqk20PATLbJnfFW4dmOsvKbhFyX45qkjAXiF2+PeDyx6Qiol
	4TBDNGjd6Ukz6255o5n2Y//Nz6Cy2xBfsOZgjcdA8MT806z7Pr6zgRa+43LXt8bzCNgE1U+rIYZ
	fqHbQVq57DLY0JK+QMyjcaHsZVmAQ6FUiYVqp3OyvEBsXnXRQGeM5fhj2diUXE1c0Vqs
X-Google-Smtp-Source: AGHT+IEnYQuuP7+Ed1yUnqPwBXcm60N0HbHjFFI1Q30n3CnvRs0c1N7PubAsOKk34Bxp6isS1gHJpw==
X-Received: by 2002:a05:6808:181e:b0:408:fef8:9c91 with SMTP id 5614622812f47-40a65fee5edmr1014965b6e.5.1749681789569;
        Wed, 11 Jun 2025 15:43:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:20 -0500
Subject: [PATCH 28/28] iio: temperature: tmp006: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-28-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PE+CsjhnIQN3X+3KjjOXuO9jk19Iju+HayM9vpAuU1M=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgY9GS1AXDDpXtL3P/xEFQ0nsgDvgF6m8S2Ri
 XNCmUul8aiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGPQAKCRDCzCAB/wGP
 wPyqB/9hXsNHRRXkGxsp4YsM2uNtCavgRRTmB64f/KIXhTDYL1RBaHe1kfKU8iu4OLH+gBGaKt6
 aamU7fhFYq9DAZMXKztJTGp4Bn5UPjmsyGKezfM1KqyY5wXinyUHqiDAa6WFesxPAWSYBW4YhuL
 jjsA4pN6Yl0BLbsYRN061SYdEaoiVyNw5oLsxaeCRQCpjdYZ5kEyewIQcC9SYSb8m8YhpDprTXv
 WqEiMd/n7RM4kkOE1jWOSNJ+od1fajr5bI6tF+f2LNjMT5hE/qs1NYFOOBiY+WfrvFrl3aPqZc7
 060EeNImTcoO1iHforX5lOBvZ5p77oTZs6uZ7OSYFtt07WgK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/temperature/tmp006.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 29bff9d8859d017e1b59536c531f732a2d749631..10bd3f221929d1b58b7e6a6bd9a75d5d068edf84 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -254,11 +254,9 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 	struct {
 		s16 channels[2];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	s32 ret;
 
-	memset(&scan, 0, sizeof(scan));
-
 	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
 	if (ret < 0)
 		goto err;

-- 
2.43.0


