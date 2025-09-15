Return-Path: <linux-kernel+bounces-817633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B54B584BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060434C4E60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8053064B4;
	Mon, 15 Sep 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgEe1LH5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0330506C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961466; cv=none; b=VTelEI6hmD98J3ivs3apqjV+BgS4rZUQG8EBiXu9Ft3UrHHm9R5GVSXjVNSLy2QnTtpyt3/Rf+OFiIb+v/56hwyXFyRqns0h+xxGKJc2oCTM6eEK/mPYhz7VYoWOe7zFs4vhohBUwfpwfYSbw4gxuGXt7mFOJLqW6+LAkD3+pmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961466; c=relaxed/simple;
	bh=KHf1K07NTwkhv6Wp3wTHX8eW6RchNhIV/ZMDf7/E9CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXW8jFcJnyYiViAwvn4uwjpCwKGkQ5WSwH60RPwsmntmdXa61aWTOiG8QY+rWUVAIXQSFNL2dqqKaUTO9Rv8kTJIRqGDSzS8M+TEpBpDZdWAzai1tD24c9ZILOUqAzykF6mkWdRFF1EUAxwAGTsrW+YLeVHnfzpTPSM3RWYLQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgEe1LH5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0473327e70so135352466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961463; x=1758566263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGAd5EwTueREEYaKyLu1qn1htBR/b/MdV1Cw2/PFlS0=;
        b=IgEe1LH5kTWDDWZYM9ujEEIwXqmYMMskqvPFfzZ8FoXThu/Kf3HhqtwDi/2FwewdHl
         UBL29cU/bdW+tGUV7CP1XrdNfhmKYs/beAqp2ckAbc/kB/1IeCgADklf4iycbmVgSgfg
         PVhgrqwzMCvIgW7a58jqSggkiHUnI6DETgtPd5qxWxz7iM/MO29hhKduePAqBTMyd/vo
         OrIq/aC11SoKXI+O+rSIRuzrCNTkGYnYSIxrAZ/SUQmqhc46c5ohpImeolZw63oOZbEn
         SVKoKmCGeG52nM8sH500c6xxp+eCxhGsUoN38a8aFWEtxnKfsRpd9XkEPaui+923Pgrn
         adeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961463; x=1758566263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGAd5EwTueREEYaKyLu1qn1htBR/b/MdV1Cw2/PFlS0=;
        b=HF+5FZmV4rGEifqq4WCuM88hqNt5n3RaMKL4N2357SwzPsMLpMYhewQM/7isUNdbBn
         g0tp/5FBI498S1TQJ39oy7B9A/jLPQTOIuIsddpoyOANMgW8T9kwPlHqy81w8v78VbzH
         hZn+XXzdIDOT4PG89XkbvMKLw7fOs6NaJzKfxpT2lwlVAjqSL9+r5H9awb4aGQq1fdnT
         px/sT3vJ5zrKxu4DE9DgiOA85sL3rqHyasqL9o0Abwu3i2HqiiMJUYvFahCLsTxB+PWm
         cVbi7iP6y7sicrYm94si4BR26VHMolTBvib1H7anOiiDin4yy5ASBl2mO7fYBQ+7bBkA
         f0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs3VtCuXoe3CJX6C8DplBro9KcO/NYh7kJ2sUAbIuNvrTE7amtvT6a0BjUts8xZNoDBilhsgv1bSkrGwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWHvCOnzPmkBMJY9lun0EEmJOw5v1g0W5UxVJBMkevJODn/0w
	NdZpQgt/Qwa4CclQl8zXHmXRFuZq3jF44j9K1Bsh1XjcNexGERJkeJgD
X-Gm-Gg: ASbGncsaTA1S/5t+kLxp9QFDsId4yPb4HpVtBFLIP5FCquPBe7kqye/+QTug+ZeoPRU
	iosBTLKS10GgWzOOMVrr9Suug/EiXPe6HCKdXCfkx/XGN70Dnduw43ka+V3j0XmZVitvoMYqAsN
	9DzKGJIv3Leo8OJJeP9sRXhlN7skq17fvAkYFNNYJcD1B3Gg7SZHe3C880xstUDNLCfOJfj/Fnn
	pM9uhz58U9wjZtULsyWDbdDSm43DNHdywAtP+AkjdUWr/J3/y1cADJICtA++sY/0IFpwQXVyOKz
	/aIAMuNr8sVskgituJDcmmzz+ydIhFi8F7YG6JDMV1DwqJNc6N5qDcTIO31TsC7CvxtOYJB+Grt
	Cn2vbdpMmdk3r9bqDx8ximRvcHvRzCK089tzvumxRM9bkttAteJU60oJxBocXASv3izdt4FdYDr
	zcL6M=
X-Google-Smtp-Source: AGHT+IHUmkUWx/CNy9iKmZXK/Te/bh1246ey7N6I2lziuHZZC5hu9GTBD+URO/efKjEPAxGfYJB4Ww==
X-Received: by 2002:a17:907:86a9:b0:b0c:be67:f556 with SMTP id a640c23a62f3a-b0cbe67f693mr747768166b.38.1757961462682;
        Mon, 15 Sep 2025 11:37:42 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da33dsm1006476466b.1.2025.09.15.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:42 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 4/7] spi: drop check for validity of device chip selects
Date: Mon, 15 Sep 2025 20:37:22 +0200
Message-ID: <20250915183725.219473-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we know the number of chip selects of a device, we can assume
these are valid, and do not need to check them first.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* dropped removal of initialization to SPI_CS_INVALID

 drivers/spi/spi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ad965eae9c9f..91e2f4f504e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -623,11 +623,6 @@ static void spi_dev_set_name(struct spi_device *spi)
  */
 #define SPI_INVALID_CS		((s8)-1)
 
-static inline bool is_valid_cs(s8 chip_select)
-{
-	return chip_select != SPI_INVALID_CS;
-}
-
 static inline int spi_dev_check_cs(struct device *dev,
 				   struct spi_device *spi, u8 idx,
 				   struct spi_device *new_spi, u8 new_idx)
@@ -638,7 +633,7 @@ static inline int spi_dev_check_cs(struct device *dev,
 	cs = spi_get_chipselect(spi, idx);
 	for (idx_new = new_idx; idx_new < new_spi->num_chipselect; idx_new++) {
 		cs_new = spi_get_chipselect(new_spi, idx_new);
-		if (is_valid_cs(cs) && is_valid_cs(cs_new) && cs == cs_new) {
+		if (cs == cs_new) {
 			dev_err(dev, "chipselect %u already in use\n", cs_new);
 			return -EBUSY;
 		}
@@ -684,7 +679,7 @@ static int __spi_add_device(struct spi_device *spi)
 	for (idx = 0; idx < spi->num_chipselect; idx++) {
 		/* Chipselects are numbered 0..max; validate. */
 		cs = spi_get_chipselect(spi, idx);
-		if (is_valid_cs(cs) && cs >= ctlr->num_chipselect) {
+		if (cs >= ctlr->num_chipselect) {
 			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
 				ctlr->num_chipselect);
 			return -EINVAL;
@@ -730,8 +725,7 @@ static int __spi_add_device(struct spi_device *spi)
 
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			if (is_valid_cs(cs))
-				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
 
-- 
2.43.0


