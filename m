Return-Path: <linux-kernel+bounces-821777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8FB8238E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810CB2A708C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71329BD94;
	Wed, 17 Sep 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iimFhSp/"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A222A1E1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150211; cv=none; b=s+/7+bdt26Ewh6PXvL3FDrVfkR8EF66rfFKWFrK3r/ivlPLNFsUiIb1IDqhLwY7/sOZx1uhtrLyNh1D8jbRBEBhwKbDNzjnBdoaC0kQ0HrqG8bgq69ucjr/Zbzp6LQ5Kmzm2V1pMGUzjoSx7MWiz4TepswvBZ9glWC1t6wwyDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150211; c=relaxed/simple;
	bh=92Lb1dbr/uLlyqmvc9+kaoxRoIos4vu/2DmMFebeSJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IwA+TbrhtNQRk5CXusiZNhrib+/KQjkOHzbVByZ+YujWvOciLrVSyfHELTSlBmK2/PYhYQzAsKjKXfz2PXxyRXZ70xDVKdtnWpuXwcHCEAMpKaumjAOEGyYP9San6beTzGoq/MfpiGEKcGJmjHZLJVVdwcdCHz+LQ4k+8Ba/iTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iimFhSp/; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-331d60b0a37so100136fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758150207; x=1758755007; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sro0/bS5na0sNEElkvSspggD9qSi9uDK/svyZ3CTTs=;
        b=iimFhSp/TixJsO0Rw/kxYs7PNBsZbf42aW0igd3u1hQ5YVlggza1utOA4mLjLyFtsb
         f4Vqp9MmlT4PwQ/R7vFM9CveGTa5m7o/UWWC0k8FFbAJ0zmQ3NZehC32rmv+p1tm34Jr
         IyLpj0dYyYm1P/fLKnuISqBedkCMcoaWzYApBQEMyvPuyo1DDgwAz9bg6lAtV4wnfYWN
         kBUcpmKjclokjoRcwiJ+ue4RC3bYu5zPfVWsoUN21zspQHR0msRT7etDyELb6IHkb+Xx
         gtdjyCnEIBVHoG9MF8Q+FaUBoV3TZkMgFKLEmoSSri6DcgTnRfPIE8tGpQMGDGnE/DFu
         0klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150207; x=1758755007;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sro0/bS5na0sNEElkvSspggD9qSi9uDK/svyZ3CTTs=;
        b=wiQ9dmGdyyuUlik/jXR9pckdjjKqkewAvZQnvhJkmGfPmxda/pncH+7ajuA2FWk0JJ
         HoiJ/Sh2nA4TYhwCsdBxTw+qwdc+m9Qhv2QaVVvpjB/ZOsqHVyBoIFACnz4LCT6nPkX4
         ruJXV/5Fhqaw3H4bSaahZWo/tNhkHSW+YM2vYfNSYExOqIF2dY4BL5QejqbwF0zt5TdK
         6kl82dtkg3kVMVJ2gEj/RoyPfUG96jd/To4IX4a9WdzWMwKs5ilcr3KA7rpN8md/V35a
         fWViL+RIyepvBJ9YVUAQRZ5t6Gm62PGH4H8pJbM5NsgMgK5zLpPQibUzuP5seTaRdXfC
         EPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWx0Way0GLKWzAm7rFX7RDKlTVrHZkd7GwG8qGaec8IwaD8o2uVs08196oUnGCGEBvOs7LTR99T3vTaS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kyrua2Xu/ZcGXn32D7QQLdvu0Edu0avplehJtxi8+mJ3686C
	fcPX3kwNZFZJFyvQI5afZrUbGqOtD16uJmdOzdxCZGj0l5NKgWScWmuL1XZZdqK3oag=
X-Gm-Gg: ASbGncupKUbSb9smZ20uv8t+pQl37hxILlYakX0jR9zyoK7jKzGe0D025+jspVGyizJ
	WOKAN9GUhxgfBxSn8EW4gfxL0iAakh9DC+9/Z7J6vW7YA1gcv23o8aDcm4LwmksOYHXsNHcZ+yr
	LdHMgdKggDR/ILaEpfKnSHK3vyvdpBci4qF5SUeIfvjQieHOQrlA9cFSUYgvZCf/iQ2bSuJwAQm
	8UXVNRyK1phsgfepXdynBmlTp7P20SOzvGPP28BZCTTvtVsOqU4qHqFhF8nVf/UjVyZ/9rXQrmV
	VVVCP6vnUWjLaDEBv085knfTvPeTwEkPdzZ69DHV4d4U5QrmizYGImF693339qDfi6Iam/hnYpC
	s4V+JKCz6xW6+dHubz7lmNNCf7uHmsOJ9wLmDFQ3QsJJaZpqt+orxtzSFkA==
X-Google-Smtp-Source: AGHT+IGn9QO2T7gAeZnWqMU637QROCA+lWMpTp479usnGI7/StlRpgVcssub487UvFYbjNtiSlpn6A==
X-Received: by 2002:a05:6870:709c:b0:332:ea8d:b4d2 with SMTP id 586e51a60fabf-335bd7a5f75mr1856596fac.11.1758150206763;
        Wed, 17 Sep 2025 16:03:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7690b909d9bsm366708a34.0.2025.09.17.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 16:03:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 18:03:17 -0500
Subject: [PATCH] iio: adc: ad7124: add debugfs to disable single cycle mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-v1-1-c83ab725faca@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADQ+y2gC/x3NSwoCMRAE0KsMvbYhHyUzXkVE8unEhiGRtIoyz
 N0NLoribao2EOpMAudpg05vFm51QB8miHdfCyGnYTDKnNSiHTI39CmOOG2OoxImCq+SBZ8NE4s
 PK6FwLSvd4jcOROtmytaqMC8whh+dMn/+p5frvv8AEhltfYQAAAA=
X-Change-ID: 20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-c378ef330b89
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=92Lb1dbr/uLlyqmvc9+kaoxRoIos4vu/2DmMFebeSJw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoyz43EJTD09ZrwzvV0Rzx2oM7FV6GB8v+Zy5si
 Ac5rlAbEyyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMs+NwAKCRDCzCAB/wGP
 wEK/B/9EfIq+CTSMjrS7ULICUXR3v+ImWTs6Snpoiet1s9N3Rx21q6YlMCneVJwetX6Zf8ArU6D
 6PnxNHJbeQpZodUC9zWXFk2ML0Hj1JVnFCctoQ5f5eb50HvfP/jgvAyG2xC5skvda54JWorPJRA
 pJzHkkbcQj2AgQThiFGr+7Ds0gpUW3szb7U3m1T7hlrYXoTZL6HC3Yaqp/na8IpA2enWQLvO1C/
 cTw7xvtrkIHjvu6nk31U8ezuibhSNsRFRKa9WcJVNKfkOU46jEn1u51GgUR/Yaas/C+2/RyUJuI
 zlYidUp3MEHEsC5gnoVjTfgNlEmXpWMxkOXePsvCZPL/j4sk
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a boolean debugfs attribute to allow disabling the SINGLE_CYCLE
bit in the FILTER registers.

This causes data to be read on every conversion instead of doing the
usual 3 or 4 conversions per sample (depending on the filter). This is
only needed for very specific use cases, such as validating the
performance of the ADC. So we just expose this feature through debugfs
for the rare cases where it is needed by people who really know what
they are doing.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
In a recent discussion with an engineer who has used these chips a lot,
we confirmed that we made the right choice in [1] about always enabling
the SINGLE_CYCLE bit. That is what is needed in normal operation and is
the expected behavior.

But there are some occasions where we might want to turn it off for
hardware debugging (e.g. to peer into what the filter on the ADC is
doing). Hence, this patch to add a debugfs entry to allow it.

FYI, there will be some trivial fuzz between this patch and the "iio:
adc: ad7124: change setup reg allocation strategy" patch, but I expect
changes to be requested on that one, so will likely work itself out
by the time it actually gets picked up.

[1]: https://lore.kernel.org/linux-iio/20250910-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v4-1-8ca624c6114c@baylibre.com/
---
 drivers/iio/adc/ad7124.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 910b40393f77de84afc77d406c17c6e5051a02cd..ad6edbc792db35a644df37fce62bf95b79881455 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -10,6 +10,7 @@
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -223,6 +224,7 @@ struct ad7124_state {
 	 */
 	unsigned int gain_default;
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
+	bool enable_single_cycle;
 };
 
 static const struct ad7124_chip_info ad7124_4_chip_info = {
@@ -560,13 +562,15 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	 * sampling frequency even when only one channel is enabled in a
 	 * buffered read. If it was not set, the N in ad7124_set_channel_odr()
 	 * would be 1 and we would get a faster sampling frequency than what
-	 * was requested.
+	 * was requested. It may only be disabled through debugfs for testing
+	 * purposes.
 	 */
 	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
 			       FIELD_PREP(AD7124_FILTER_FILTER, filter) |
 			       FIELD_PREP(AD7124_FILTER_REJ60, rej60) |
 			       FIELD_PREP(AD7124_FILTER_POST_FILTER, post) |
-			       AD7124_FILTER_SINGLE_CYCLE |
+			       FIELD_PREP(AD7124_FILTER_SINGLE_CYCLE,
+					  st->enable_single_cycle) |
 			       FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits));
 }
 
@@ -1609,6 +1613,18 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
+static void ad7124_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct dentry *dentry = iio_get_debugfs_dentry(indio_dev);
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
+	debugfs_create_bool("enable_single_cycle", 0644, dentry,
+			    &st->enable_single_cycle);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -1629,6 +1645,9 @@ static int ad7124_probe(struct spi_device *spi)
 
 	st->chip_info = info;
 
+	/* Only disabled for debug/testing purposes. */
+	st->enable_single_cycle = true;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
@@ -1686,6 +1705,8 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register iio device\n");
 
+	ad7124_debugfs_init(indio_dev);
+
 	return 0;
 }
 

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-add-debugfs-to-disable-single_cycle-c378ef330b89

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


