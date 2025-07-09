Return-Path: <linux-kernel+bounces-724124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F09AFEEE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEE01C83DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5721D3F1;
	Wed,  9 Jul 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rI4fuBV7"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9E21B9F4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078966; cv=none; b=TOORGc+WYgSsUBNljTRIzF9h0ZUlXEFafJndj3cIuRGYkG2wkx4pWMd49flJ5JzzhSLmoPAavqszk4wGe2SY9U3zJNTSzMQtC4TaF/nytj5LdUbpAetS/fLirmWsnsTNCl8S1FNatGtRqqP14XV4ybYNQ/MGKRLd6RpFPaPFZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078966; c=relaxed/simple;
	bh=T/YxpJHaLl0ZEYjXbomfYbdvkf7AfwrF0GJmnkQ6J0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e90akb2Ah6Jj4J4it7nKHAqIg94K2fGHExdzCKg1hw85IxwVS5z90dvjLb+hvpklj8mvLteVYr3taGhLSvvpmzOl4B7aToUww7NlafwmNnaVWAZxpbq9DBKKXpFRnJgxUlJhGkMSUWhkFtPgippUm1Q58IyhRJ8Ht8Ec4NH7uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rI4fuBV7; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40669fd81b5so87374b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752078963; x=1752683763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2NCv5ZUnXAsXiQ1y5qCYPVBgj3kCuUiatyrb7NyC8w=;
        b=rI4fuBV7AO/cb5VzTMA67RCM4x1V0JDmWPmWdV6tDjDdAVkSLGG6u15Kc/XF2o94S7
         8nA0v6pMrF9YgzOUhqjXF4Fu9Nw6Ha1xCh9YK+I1GDnP5a8fVm6qblT2t4TWp76Uk2Rv
         KMtO3Sw59qFnvVwoVodpEuPF919uy1c0vLF05Ai1bja5KpGcS/OLMD8goGSKGgTJuTA5
         YcWKPIrmqq+Gb4G9rgUNjEVLGYd7vIRO5l9XflCzj9n4a7RH3Yg/yNZjzCad+Vmbk1aZ
         UokTR/iaDkG5yaWZsB/61ltfvVztjoTcvVtfYtpyUN9JXSUu+NYMK3aizQY5GkWKZuma
         Iw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752078963; x=1752683763;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2NCv5ZUnXAsXiQ1y5qCYPVBgj3kCuUiatyrb7NyC8w=;
        b=f6LMljm3XHJ5u1IyeovA1POnce96wurkUjX5JI0fQJQa1ZFZhYZufz+my+enZl0EqI
         j/bpU2ZUSbYH88K4M81amFyy+MSqDg6A41K5EPF0f9v8D51xjVY7xjR9LcUd+e5c6Bgm
         BI/Cpcu0PPwmct2rCP3XB6yknBwYgl8cTtFzQnvbyGMGBew40+952YFFYumIMF3PMa85
         eiGQs3lkg1T5FO4Jkicu9p4yCwJ2SrJGhTBKQlbi8U/gTq4X5/JnGjZ3fT6ofkFj3CBO
         RZ9d6ynxLCNtbM15gTQBh1ZKHMg3OpoC+RgoqNj8YXeg87qmntKAAXCWa0KEaRpVjvJz
         w7bA==
X-Forwarded-Encrypted: i=1; AJvYcCV7vKUqr27idosdDeCGXP1/sqjuQFqo0IcAuLxOCc8WWzMesBlGYasF2ZBg1cvgLJPGMH6q7bGeJNW4Fe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEov0mHK0ryW4j3SuKzPjk4cMzLmbJIVx08b75gi7J2277Luj
	ucGhTVIAx212s4ZPm1nlsX1U0ftys0nwZTIvLuF4GSmqFBU+vfKiuwQtnhSZ6Z0l2eI=
X-Gm-Gg: ASbGncsCtgaf3qxO8OPVI9vkCW5ZaZTJVo/yT/66EvBv6/+U9Hda95WEH4vUWHQbOuq
	BiUhmdtpTi1GpVhLe/S/Pe6fYz794z6bElNX7flSlOG8Yk4BWhdG/6EohNBdV5+yzka1a+4MJI+
	nWFTacteki+GLmaZc570nRobY4aLKXrIUjNPXxFaVtNwIU/jMpwKXqj09+NyIYPwfIhrm+pGjx9
	pDelhPPtG1VUCF/lEcwgMOfLc4zTBSwpCQLv0XGpD59hDHpoa+9AdW8kiCFCrOqlU2RvOa730un
	THYF4wDgH6M8wRMT4hPdh8XbYjBi2hGV6AOdUaZaxM55+KoeCugP9IjsgbOjQeSJHnsW
X-Google-Smtp-Source: AGHT+IE+a5J4989lV0mNG3uoJIobk1P3f7G6nnrVcQuEoPyM2xrG7xGnluW8sIs1Q7PkyM/QB9HmCg==
X-Received: by 2002:a05:6808:3012:b0:3f8:d2f8:d735 with SMTP id 5614622812f47-412bcf88924mr1867517b6e.33.1752078961998;
        Wed, 09 Jul 2025 09:36:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:ddc3:43e9:8174:1067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02ac747dsm2071589b6e.33.2025.07.09.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:36:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Jul 2025 11:35:52 -0500
Subject: [PATCH] iio: adc: ad7173: prevent scan if too many setups
 requested
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-iio-adc-ad7173-fix-setup-use-limits-v1-1-e41233029d44@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGeabmgC/x2N0QqCQBBFf0XmuYFxQ7f6lfBhdae6UCo7GoL47
 w09nIcDh3t3Mi1Qo1u1U9EvDNPoUp8qGl5pfCoju1OQ0EiUKwMTpzw4sY5nfmBj02WdeTXlNz5
 YjCU1OfRtauNFyJfmot79X+7dcfwALA9yMHUAAAA=
X-Change-ID: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7214; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=T/YxpJHaLl0ZEYjXbomfYbdvkf7AfwrF0GJmnkQ6J0I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobppph0m67SJSY5refN+iWtP3CCO+qC4Mi6bGc
 5WyAu6VjyCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG6aaQAKCRDCzCAB/wGP
 wBujB/4za2HUMD8opIpTpE0X3c5+k7wNbl9Y2qcT7EGEYysPLv9oVSRVEw72ZIEoeKTLGIsuClv
 WLgXr+t1KF/Q3R6T073OgUZpLya06ZCpQKh4YCkShSgi8f9QpvZty+3qI58M1iWn+rT0cpJRK6G
 2+z+NjoxQmpJe4C0Et3OTfuuE/OHLvo+gh3xDWQMEg+RQFNA17JurkNxFABy/Znc8iNvUR61Pj1
 yvToRBdfcX97XmM31uKT40AAjV1vln2S9VdA5bgwh8KqH8F3HkqEYtvz71AIgeRmeWB3HX6xrrH
 bW5sh2tvl64T+Wv7DRzNe3uruADnTioJgnkXlK5w/cfkXu2/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
the maximum number of unique channel configurations.

In the AD7173 family of chips, there are some chips that have 16
CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
GAINx and OFFSETx registers). Since commit 2233378a8c60 ("iio: adc:
ad7173: fix num_slots"), it is possible to have more than 8 channels
enabled in a scan at the same time, so it is possible to get a bad
configuration where more than 8 channels are using unique configurations.
This happens because the algorithm to allocate the setup slots only
takes into account which slot has been least recently used and doesn't
know about the maximum number of slots available.

Since the algorithm to allocate the setup slots is quite complex, it is
simpler to check after the fact if the current state is valid or not.
So this patch adds a check in ad7173_update_scan_mode() after setting up
all of the configurations to make sure that the actual setup still
matches the requested setup for each enabled channel. If not, we prevent
the scan from being enabled and return an error.

The setup comparison is ad7173_setup_equal() is refactored to a separate
function since we need to call it in two places now.

Fixes: 2233378a8c60 ("iio: adc: ad7173: fix num_slots")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I know this isn't pretty, but after puzzling over it for a day, this was
the best I could come up with that didn't involve a complete rewrite of
the setup allocation algorithm.

I don't really understand why we care about which setup was the least
recently used - it isn't like we are going to wear out one setup by
using it too much. Maybe it was just to reduce the number of SPI xfers?
Anyway, ad7124 has a similar setup allocation algorithm, so it could be
nice to eventually replace both of these with something common that is
a bit simpler, e.g. always use SETUP 0 for single transfers and allocate
the rest of the setups in order for buffered reads with more than one
channel enabled. And just always re-write the setup each time so we
don't have to try to keep track of what each slot is programmed with.

Also, the commit hash this references is currently in iio/fixes-togreg,
so if that gets rebased, it will need to be updated here.
---
 drivers/iio/adc/ad7173.c | 87 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index c41bc5b9ac597f57eea6a097cc3a118de7b42210..d1d6c20fb1ee3f8479e8faa2209206e208adb90a 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -200,7 +200,7 @@ struct ad7173_channel_config {
 	/*
 	 * Following fields are used to compare equality. If you
 	 * make adaptations in it, you most likely also have to adapt
-	 * ad7173_find_live_config(), too.
+	 * ad7173_setup_equal(), too.
 	 */
 	struct_group(config_props,
 		bool bipolar;
@@ -563,12 +563,19 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
 	st->config_usage_counter = 0;
 }
 
-static struct ad7173_channel_config *
-ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+/**
+ * ad7173_setup_equal - Compare two channel setups
+ * @cfg1: First channel configuration
+ * @cfg2: Second channel configuration
+ *
+ * Compares all configuration options that affect the registers connected to
+ * SETUP_SEL, namely CONFIGx, FILTERx, GAINx and OFFSETx.
+ *
+ * Returns: true if the setups are identical, false otherwise
+ */
+static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
+			       const struct ad7173_channel_config *cfg2)
 {
-	struct ad7173_channel_config *cfg_aux;
-	int i;
-
 	/*
 	 * This is just to make sure that the comparison is adapted after
 	 * struct ad7173_channel_config was changed.
@@ -581,14 +588,22 @@ ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *c
 				     u8 ref_sel;
 			     }));
 
+	return cfg1->bipolar == cfg2->bipolar &&
+	       cfg1->input_buf == cfg2->input_buf &&
+	       cfg1->odr == cfg2->odr &&
+	       cfg1->ref_sel == cfg2->ref_sel;
+}
+
+static struct ad7173_channel_config *
+ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+{
+	struct ad7173_channel_config *cfg_aux;
+	int i;
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live &&
-		    cfg->bipolar == cfg_aux->bipolar &&
-		    cfg->input_buf == cfg_aux->input_buf &&
-		    cfg->odr == cfg_aux->odr &&
-		    cfg->ref_sel == cfg_aux->ref_sel)
+		if (cfg_aux->live && ad7173_setup_equal(cfg, cfg_aux))
 			return cfg_aux;
 	}
 	return NULL;
@@ -1230,7 +1245,7 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, k, ret;
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		if (test_bit(i, scan_mask))
@@ -1241,6 +1256,54 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 			return ret;
 	}
 
+	/*
+	 * On some chips, there are more channels that setups, so if there were
+	 * more unique setups requested than the number of available slots,
+	 * ad7173_set_channel() will have written over some of the slots. We
+	 * can detect this by making sure each assigned cfg_slot matches the
+	 * requested configuration. If it doesn't, we know that the slot was
+	 * overwritten by a different channel.
+	 */
+	for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
+		const struct ad7173_channel_config *cfg1, *cfg2;
+
+		cfg1 = &st->channels[i].cfg;
+
+		for_each_set_bit(j, scan_mask, indio_dev->num_channels) {
+			cfg2 = &st->channels[j].cfg;
+
+			/*
+			 * Only compare configs that are assigned to the same
+			 * SETUP_SEL slot and don't compare channel to itself.
+			 */
+			if (i == j || cfg1->cfg_slot != cfg2->cfg_slot)
+				continue;
+
+			/*
+			 * If we find two different configs trying to use the
+			 * same SETUP_SEL slot, then we know that the that we
+			 * have too many unique configurations requested for
+			 * the available slots and at least one was overwritten.
+			 */
+			if (!ad7173_setup_equal(cfg1, cfg2)) {
+				/*
+				 * At this point, there isn't a way to tell
+				 * which setups are actually programmed in the
+				 * ADC anymore, so we could read them back to
+				 * see, but it is simpler to just turn off all
+				 * of the live flags so that everything gets
+				 * reprogramed on the next attempt read a sample.
+				 */
+				for (k = 0; k < st->num_channels; k++)
+					st->channels[k].cfg.live = false;
+
+				dev_err(&st->sd.spi->dev,
+					"Too many unique channel configurations requested for scan\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 

---
base-commit: 2233378a8c606f7f6893d4c16aa6eb6fea027a52
change-id: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


