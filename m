Return-Path: <linux-kernel+bounces-819652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE3B5A417
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1087B30F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53028CF5E;
	Tue, 16 Sep 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jn3PbtYV"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759C31BCAE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058791; cv=none; b=IIYnNa9DtaAey1ocT2gAH3yEtYG1dq4ks8hh9vbrgTdR+G6p2+0HSKYPxv7vav6Gbtx1wsGCz5yNrzk47jKXOsy/FkBZIQx81Yw/FtGtEc26p1GhR46MBIIfctVFaCtLr4CeU5nGFjrkGgkmL5Sm/ZXbKEzWopvI8lhVT8EPNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058791; c=relaxed/simple;
	bh=alWkRwRAHUDZB7EnggR/adBGG6zbmWfLbEJBfdYcj2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=icEwaOcz345CbXbyt164mvow9svAaPZvVNdahOobd9Cb2qCjJ6NozoVK7J6wAKvhFIvxDjNsHnc5pnK5raPPn/QcYVSxllklOGk3+kQcwa/y0pl2SKp8cNpbidT9rUBVsFqB1d26qQWwjObr4rA/At5WhhEX2/UB70SAMbq0PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jn3PbtYV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74526ca79beso5049544a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758058788; x=1758663588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zxLzz2OSGaMAYAW1znXjOojON6qtPgLCC+6TCF9gO8=;
        b=jn3PbtYVtg4bx8s4NMqfsKpMnpQaUQiHg/7D3pEIY9fQs/kz20WhFpIz7Xn2y3cUja
         402roG2cSJKR5Uyrf5OlDSRid1BXxJFy8QRiotlLFKyGr0C5q5KERuh/pR41xgkHjubs
         rQSfu4a4XDjqzNe7W3fsHWwaqORV1Bt+b1YfEo6a5nFUj2rqhQQhBMhjxdm8dpJIRPFc
         ovKH+LDl12KGUoR3zJLKkfcoJfVBHvLzPE121rtzOj/lQBU/NUrdQd6xZ+cHXABn/DYh
         wUFF2PVq59GoyebBWuNfhTPGrvIKdk5BqMa3xt5mFeeXTX2Ncl70QJBpJkCQ3mspBPkF
         9KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058788; x=1758663588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zxLzz2OSGaMAYAW1znXjOojON6qtPgLCC+6TCF9gO8=;
        b=RpP0hvV1z0xxmgnvLRbGVbuzqt19XF7muP41I0XsDjEqM4pDVS/9mKiNNA72H2295l
         qxF9kXTdbMTbsM+307UJYu4DCSdTabFI0C0OZw5u6xiElkRLiJ12TUKzAOZEnUBYB+23
         7h/KUvI+nLDjMPeSS9wIVoLTBNkc77G9UJDkip0gqlWhKplS2egDOYGMpEMz+MPTN2BS
         kTlEBoC6hdE1eNWy2Vgrv3ZeN8Q67T3n7nPcB12U+qlcthXLcgxnvr3ijMesz12S/plH
         W6RwlKgPY5+9NTl+yeXjV6eV7cotms8kO2cwuFx/zoyN+0nSL7i+KOH5mC7CaLb+4XTV
         RiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVew13YbYj+h79+PMfuAIkPY6NwgPCWouqgQ3Ow1PhpRgnokHwIXg1toKHTYItilgj4IUDdxm4kZVZ+NMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHszgyX24KCrmpoioMNFmVt2BPBct5HyDhrfKd655+5RS35Z0U
	Dc8j6NKxAxrqQVGnYHF5QTjEVk+Bv0arCooWX1vGhQb4ZAVsC2weA7NeMqHSIgmXttI=
X-Gm-Gg: ASbGncuPJwBVB2cr86dyJf3UcvPhp6rPoOH2HJSd4qV7UUAW8cxp04IrP+8WzqVM3Hq
	kFNTMd35kI2A/UXIa84In4E3SRu7+sS+svSatd/nQYXjEGGIcbKEMgUF+8WyqnZNvIVB873EoAs
	A8n6zZvv2ORwjoIX+p3g2FSkTYRO84W7d88wX0mAKjlRV9toAi9FeRNm4UwdRUDk3BjTNQjVRnn
	LmFbgiu2DD6V5bTjQqanad6Tcm2cMDGV0nV2XJQTOZKy/XfyshneaF1FlrlBAvrezm9+k2e47yG
	m3Xd7AnYlKGBAE1xVdPcBGAKbmNTq9wyZ2QV1CTRvqsNubEfMacEH26WGE/s0TrRWbw85LOWSEZ
	WtjaTUo4SU1GxfJ7IWWWmRKuDmQbD
X-Google-Smtp-Source: AGHT+IGre/KCb6a1RdLu4xBexWyZJStZZ/+A1kmo1GEcLIld1R+mvNJEbZVCp1l/G0Io1jEPSJJ6Eg==
X-Received: by 2002:a05:6830:43a6:b0:744:f113:fef3 with SMTP id 46e09a7af769-75355ac0e09mr10835133a34.30.1758058788173;
        Tue, 16 Sep 2025 14:39:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7576393e95csm2683819a34.22.2025.09.16.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:39:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:39:39 -0500
Subject: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABrZyWgC/yXNzQrCMBAE4Fcpe3YhifZHX0UklM20LthEEilC6
 bsb9TCH7zAzGxVkRaFLs1HGqkVTrLCHhuQ+xhmsoZqcca05245VE49BanrrTpyxpBXs/d++4OW
 /xYgHhwGtHA2kl47q4DNj0vfv7Hrb9w8ib8fsfAAAAA==
X-Change-ID: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7c6
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=alWkRwRAHUDZB7EnggR/adBGG6zbmWfLbEJBfdYcj2k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydkcshTt3rKPh07vfUj25Gmmk4zbnBQP0CdbV
 caC14z5M1qJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnZHAAKCRDCzCAB/wGP
 wO2VB/9lLJmpbop69c8faJfzJi6En5Nu0hHK394RXRbavKAIflgT3rMscwYEqim0vZ5ATfUW+kY
 hKQyOY7m00BN6w+YU/ycSh2luVmpQ8zuXr7XpNDcTUIGqXbW+i25fur3435sn5bnFsp9Bg5xCsA
 Elt96lWZx2yYHZobqeHQPFG7Ykb0CIdlngW4OHe5iWqps8V3d3ZpmDd8PtnSY+f9W+64nufh+M5
 RN+HDYxIDHjS2E50eZ1mrJNuSdxxSSLMHfPE0Lf87PvNJtNFdig928meNiREa8Vv7voKkJMDAhH
 lwjQ2stPwBU7chNRTWgjv+9A5JdoCl4sFYJO7P4AbZwEDCiH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove __ad7124_set_channel() wrapper function. This just added an
unnecessary layer of indirection with an extra call to container_of().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Just a small cleanup while I continue to work on this driver.
---
 drivers/iio/adc/ad7124.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 910b40393f77de84afc77d406c17c6e5051a02cd..c24f3d5127cb83eeab0cf37882446fc994173274 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -657,20 +657,13 @@ static int ad7124_prepare_read(struct ad7124_state *st, int address)
 	return ad7124_enable_channel(st, &st->channels[address]);
 }
 
-static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
-{
-	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
-
-	return ad7124_prepare_read(st, channel);
-}
-
 static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 	int ret;
 
 	mutex_lock(&st->cfgs_lock);
-	ret = __ad7124_set_channel(sd, channel);
+	ret = ad7124_prepare_read(st, channel);
 	mutex_unlock(&st->cfgs_lock);
 
 	return ret;
@@ -965,7 +958,7 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 	for (i = 0; i < st->num_channels; i++) {
 		bit_set = test_bit(i, scan_mask);
 		if (bit_set)
-			ret = __ad7124_set_channel(&st->sd, i);
+			ret = ad7124_prepare_read(st, i);
 		else
 			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_ENABLE,
 						    0, 2);

---
base-commit: df76e03e8127f756f314418d683bad24b460c61f
change-id: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7c6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


