Return-Path: <linux-kernel+bounces-821632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16690B81CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48941757BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896B2D6E41;
	Wed, 17 Sep 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UNP5+YUz"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009582D9EDF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141602; cv=none; b=PnHek86VfQeDFG0Vok44hQt/ZO0UxmLU8dhTEADnXgj/KOsCEuJCGKRxCYbT9P9Ta1ngMC4mmUQUBTuXvRjTxowZ/9i513bygSJw5CK+rBA2IKhRQnA0AIOZqU//Khrjy6Nf3Je+DAllA4lEWeBvM+76lbioW9Bxf48pdsN8p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141602; c=relaxed/simple;
	bh=qqnbS9rqMsj1rB4xnfIJF/p4eY/TssS0siNKXl3AUEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlFtRsfL/zwbX0RG54zjZ1PEZ8Oyh+8Ne8rqV6COS+iQWZDk+YOG9EDytoGCMVns5xerkoUf6VLfD4jZbNLdWeaMTeU1cwEerMIS/Ars0f5uR1IutY4nr7hGovB5y/HJBPteNmIEFfpHQidEhJw5Sf6u/Hm9mC3q5xjM3TCL+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UNP5+YUz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-757a43dbed1so233611a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758141598; x=1758746398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlE2XvlWhnA2ABQbcQ4oy9Jbw3QeJ2UFeo4NqvS5QIw=;
        b=UNP5+YUzgQxw1pTXNonNmJBhQAfOjXBBBIsUcOgl91VT/t743DMK8+v/sviQB/Ojj5
         afSHv7tv9b3WORt+huxOrpcH0H9pOQhVn+F82jarpq/BY+JHt0XpdZGCHwGUz4ovz+5P
         a1uyOTQEAOpCBkX9gpZKQtvOoRLg5kpYjqZN5nbrRb34yP6dptlsZmOIV+05dKLd1L38
         X7S90goa6N1/0Ycvh5i1+O/rf7OvD/j6/nwqKeL1rzGFkq5cMVKSlwm1oQPZsWgvaSNJ
         3wCsODbKQ2qsryXt9AXkTwSk1M46eGamY+5aRkeAIxKtrkqYIxsGe8wm17rZFwz+TCMl
         s/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141598; x=1758746398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlE2XvlWhnA2ABQbcQ4oy9Jbw3QeJ2UFeo4NqvS5QIw=;
        b=iXdmdGfFM+F+z+XD2Wy3t9NsXxdnL2VJJ1Czy30HUgkHo/+KtKTlvGe+nGXPJNK0WK
         wlLaD8NsP6RA4DN5qJS8ly+LOgdqevhZAC/LF2AMfuc3LhM/GRYAuIYqs2vyIeuZjtb9
         TzIrIpdTTBG/S+bRm7t35DVRoMIssrcBGcBVAtS8GV7J3VnqIV0PFdr1++eRcykiZD7V
         fm72rsxUrrQVdROH4b+DfjpKAOLDOTRvfMEv1as2l/UYM3JAABhc7ou4HnEl6bMKlB41
         nh5r0zdCuzgqKvffjRPd26of703mIJrGcKrpOAZNR+aSHSbit2C79xosKZOjMwxO+n2M
         kOAw==
X-Forwarded-Encrypted: i=1; AJvYcCXYcKNMuuNKiMD8VzEn/8pCxv+MOS6Fe/fwTgCEuZW5R03JQ7s1DCZSbQsplV6RsgS0mdziXGDFWuSZuYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxG98GxbmuXwjLh3X6J6ErXxqLJZab+8x0s2OMM22U9wVHe4ku
	Z6xyv+feHBe+0Xe0lbx9aKqJePK0f/lVGLvB2alsiPvLiJkej3biQVMm1blis11a6Ds=
X-Gm-Gg: ASbGnctl50HToscr6/w40g22I0vE2gwTujLQGUoswu/pzcvxGyboV6+J4KbnnTMBoYD
	hrzKDTbdpo2IUPt8QTFAHZbUGpn+/19fKIFzA4EMSoEY66lpmsyCRJeLQDezKpIbzpM1DnTMEea
	vlGOF6NyHqq7hz2jCiMNzrVBMgO6oG0VjoNN7Re/T6+NRhAWk+YnYukS4++TSrjSOtXqzynmF71
	DL8kOwXV0/caLtu8ELlKk6MbwAS0jaMhivDILPIaLnktNWizvvnHdoy4eP6yD8JVR6oy+PULlbp
	yhPOiARgi9Wu1vl04a5SWc4pJKZammQxCYn3a/gXb4PFcRBmRYcdrAFfuJZE5maVPFHohm4BJ+i
	M2z9njGSwlknIW6tcmiY0smMg11iamliOR3u2SK3BNB8jqw==
X-Google-Smtp-Source: AGHT+IHJ+MtcylglFdQt2qEtC7PA/j3pHm2e97CyHVndFWZgGKYkr9xCa5w5+zSce3ZPKsTHvPPqBg==
X-Received: by 2002:a05:6808:21a1:b0:43b:7b7f:bd43 with SMTP id 5614622812f47-43d50ae48a8mr1618319b6e.12.1758141598018;
        Wed, 17 Sep 2025 13:39:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d8eec45csm124036eaf.10.2025.09.17.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:39:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 15:39:22 -0500
Subject: [PATCH 1/2] iio: adc: ad7124: inline ad7124_enable_channel()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-drop-nr-field-v1-1-5ef5cdc387c6@baylibre.com>
References: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
In-Reply-To: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qqnbS9rqMsj1rB4xnfIJF/p4eY/TssS0siNKXl3AUEQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoyxyLzZtS2epSyGDsYeLocHaQ9VGWc3MjYpd8h
 aOci9n9Q1aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMsciwAKCRDCzCAB/wGP
 wIHCB/9THOY+HeHFnljVUZTSlDnSJOXNITRyNThcucG7oxSMrQjvggt6Z5lTHD6Hip74lLlsDrI
 kdgzQZv/kNTGr0fkzpB/Di82LBPo5VZbHIsWnqHHipKBJl4gUwSAYfaraNCD7ybDyGo8GOa4PJn
 dMY+ayYKooZ9W0jySa8ds5KY8eJ8NfGbgs9gIPhhtczBLd1BrUNL//69zBt7mHvTjlMbb6ohwzl
 icDVn5ibkYTD4VFyLHn4vrWKgoXlnM0LS1fMU7Y+5dFWx0DfVd/vunQCX/oSUDOYCw5NFbqscau
 40mX1xbztjk51BlfQ8jAWD5LfrofViuwGyjR2YxUt9WkZDeS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Inline ad7124_enable_channel() at the only call site. This simplifies
the code by avoiding a bit of extra indirection.

ch->nr is replaced by address as that is the same value and avoids more
indirection.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 910b40393f77de84afc77d406c17c6e5051a02cd..c61a95c5881a69e38c21ce4c340a0a61864de22b 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -627,14 +627,6 @@ static int ad7124_push_config(struct ad7124_state *st, struct ad7124_channel_con
 	return ad7124_write_config(st, cfg, free_cfg_slot);
 }
 
-static int ad7124_enable_channel(struct ad7124_state *st, struct ad7124_channel *ch)
-{
-	ch->cfg.live = true;
-	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(ch->nr), 2, ch->ain |
-			       FIELD_PREP(AD7124_CHANNEL_SETUP, ch->cfg.cfg_slot) |
-			       AD7124_CHANNEL_ENABLE);
-}
-
 static int ad7124_prepare_read(struct ad7124_state *st, int address)
 {
 	struct ad7124_channel_config *cfg = &st->channels[address].cfg;
@@ -654,7 +646,11 @@ static int ad7124_prepare_read(struct ad7124_state *st, int address)
 	}
 
 	/* point channel to the config slot and enable */
-	return ad7124_enable_channel(st, &st->channels[address]);
+	cfg->live = true;
+	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(address), 2,
+			       st->channels[address].ain |
+			       FIELD_PREP(AD7124_CHANNEL_SETUP, cfg->cfg_slot) |
+			       AD7124_CHANNEL_ENABLE);
 }
 
 static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
@@ -1555,7 +1551,7 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 			 * after full-scale calibration because the next
 			 * ad_sd_calibrate() call overwrites this via
 			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
-			 * ... -> ad7124_enable_channel().
+			 * -> ad7124_prepare_read().
 			 */
 			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3,
 					     &st->channels[i].cfg.calibration_gain);

-- 
2.43.0


