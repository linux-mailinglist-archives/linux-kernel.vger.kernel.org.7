Return-Path: <linux-kernel+bounces-869766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19EC08AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723A51C841B5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDEE275AE2;
	Sat, 25 Oct 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6SvKMbM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94644272E45
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366778; cv=none; b=PVZn8EsJ8vv0LsWt49vPiMftCiHe0+bbktipl5Ozbliq3O7d13vuF4czkGMBfuyyVwGsxDkhNw0/sWRskYufqfG5PjDKddX7kvtf7X5OTDbCPV1BW4OQDsaWHFkkW3vF3pPVDoMZsSL4k+XA5z0aMh+UPWNhwwoiHOJmzeVqDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366778; c=relaxed/simple;
	bh=J/zzc1ja43MRTCgO8LF4bp6opHtC/iF4Lw9TqE0/ybQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HY9SsCwD/yqoRPBLeS6RPcFT3+NyAy/ghJt/j5abwTgqTMrLZ5KW4VdqjD6yxXZqCg+2bpNVIBMQvqRm3oNUcyj/lL5gJ/VVJwRGRsMj+1PMUQaAg21hrsKtdhNaUNnxEJYm8DDwCM0B/3VYtH6jc3hEJeOjfcbWOoM1O1aSSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6SvKMbM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3737d0920e6so44922911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366775; x=1761971575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU3qD3/P4X3aGl+GxoTABgHAWYmZmNCs4mQEkZTLmtc=;
        b=g6SvKMbMx5mK95nUcQ8Jn+I/cpwcGYIi26wVqPU/lWP4xMdse69QnKDcbuOdGaD3w3
         PCX9I/W2jOcGx10GSufAvchvpuxcYRW/sAd6WlFe1s9fMZ5ysWtJ18Ntg+f9tba+q2lz
         UaNL9Vfbm+xVLgGh5FVvHaVq9fSBAtDp/SIw8w4K1fupzRiUb4UrKvtp3DJNeN9mXYbm
         GPCkTz4CtA1JunK1dW1hRisRsS5aiSQoPsJ2NM/k2YA45pRC0H1whuToVmW/h8d4/H74
         myoTCuaaaFlDnXZqctENXy+l6rO6UaqHrfxahBmcUirPcuiur3lhUlothbIOYD4dOwqy
         Nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366775; x=1761971575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU3qD3/P4X3aGl+GxoTABgHAWYmZmNCs4mQEkZTLmtc=;
        b=LH8dFjjHMwfij8Abmus+QNC6VRQ/gL9I97du/+ofvM/c3vflSoRC8btAM8b/8Ygo8u
         xJqwp3y6k509BUAzZDboG7mMeBEpt/6jhGBMc3m5ul7Zp24XHsJqY7H7zaSzEnfYykn0
         Yxi4oOVmAFpp2m4Eq4XOqbNmdVyHxDr8Axqyw1sRQXZednY7k0bdfug80R2SDNQjae/G
         Il9dG5xLa19GltBowAvlZDNoaJ/UNEy+g3kgnN6ObdlnKcyeKDl8ucOrff5kgbjW0xqu
         rZLLlm64EfXQ2BnicjKi1mk1lI11/1z1XtjCziq/pbbOOLKr7EVQTw0Mv7PU4G0FAzCk
         23Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUR8G33VEKdgljyk0VUw8keXEuL/Xrwm3mt8lV9b040taMPjgzw4I1D851/NCfemrGGmiP6uhohKR3mCcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG9pKVLdHgAmoONiW+Wh+wLiOWbkit1KnkUr8HeAzXWOGur3Z
	Vd9RnodKdzshDX4aMltGHfZuwuhxBQUDFBYxmERQgTmDZPwVogoWhVJo
X-Gm-Gg: ASbGnctJBcLtXURomK7zgr0EwC3C6IDgsGoSkYCgh6Dj/TlfAVsFTBOOZqnrFBKMG5d
	MDeVkSe20wc8ACOhbeRQFNa+upaTNyyL8oW0iLE+LxaQBpCr38V3CWa+XeV6W0BWTzyApYu5krx
	leabY1gSUienHX4KLEIGK8Ahej2L4o4FkggRAbpeevgp3lCyvK7o/XZ+6ChdmfZmYCUAB+i6VMy
	02Ft7YYZD0yMl5jkZcL7UJUuDzo+YkpUioOghswVCQVOm4vx+Apntik5ZH3Zsmz9sicUGB8aV8I
	5jWg9hbqHasUcaKDQpomjbEQmcOI5ELpg+HRSc3U/ahK24WkmWEntJYed4z26hyBI//feaEHI6X
	ZGEbfrDSzo/5A7X0Q5DphzulBhYCDRk50M7mAJRXyi7ckRMyQCWFfEdv07jmwL5c2dr1JJ3fphY
	dL
X-Google-Smtp-Source: AGHT+IH/eF1EDfMQXoqCn1NhnMmPtXp6P1wcPRtuabMRfy3u2y12SFECgEV2LqHRoicJ+PYpOzbYLg==
X-Received: by 2002:a2e:a916:0:b0:376:4430:b545 with SMTP id 38308e7fff4ca-378e4648542mr13765001fa.49.1761366774636;
        Fri, 24 Oct 2025 21:32:54 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:54 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] thermal/drivers/sun8i: get calibration data from two nvmem cells
Date: Sat, 25 Oct 2025 12:31:27 +0800
Message-ID: <20251025043129.160454-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has calibration data in two nvmem cell. To be able to
add support, the ability to add data from two cells into one array must be
added.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 77 ++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index aa496e1ba..d6d8e13e5 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -303,43 +303,70 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
-	struct nvmem_cell *calcell;
+	struct nvmem_cell *calcell = NULL;
 	struct device *dev = tmdev->dev;
-	u16 *caldata;
-	size_t callen;
+	struct device_node *np = dev_of_node(dev);
+	struct property *prop;
+	const char *cellname;
+	u8 *caldata = NULL;
+	size_t callen = 0;
 	int ret = 0;
 
-	calcell = nvmem_cell_get(dev, "calibration");
-	if (IS_ERR(calcell)) {
-		if (PTR_ERR(calcell) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Even if the external calibration data stored in sid is
-		 * not accessible, the THS hardware can still work, although
-		 * the data won't be so accurate.
-		 *
-		 * The default value of calibration register is 0x800 for
-		 * every sensor, and the calibration value is usually 0x7xx
-		 * or 0x8xx, so they won't be away from the default value
-		 * for a lot.
-		 *
-		 * So here we do not return error if the calibration data is
-		 * not available, except the probe needs deferring.
-		 */
-		goto out;
+	of_property_for_each_string(np, "nvmem-cell-names", prop, cellname) {
+		size_t len;
+		u8 *caldatapart;
+
+		calcell = of_nvmem_cell_get(np, cellname);
+		if (IS_ERR(calcell)) {
+			if (PTR_ERR(calcell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			/*
+			 * Even if the external calibration data stored in sid is
+			 * not accessible, the THS hardware can still work, although
+			 * the data won't be so accurate.
+			 *
+			 * The default value of calibration register is 0x800 for
+			 * every sensor, and the calibration value is usually 0x7xx
+			 * or 0x8xx, so they won't be away from the default value
+			 * for a lot.
+			 *
+			 * So here we do not return error if the calibration data is
+			 * not available, except the probe needs deferring.
+			 */
+			goto out;
+		}
+
+		caldatapart = nvmem_cell_read(calcell, &len);
+		nvmem_cell_put(calcell);
+		calcell = NULL;
+		if (IS_ERR(caldatapart)) {
+			ret = PTR_ERR(caldatapart);
+			goto out;
+		}
+
+		caldata = devm_krealloc(dev, caldata, callen + len, GFP_KERNEL);
+		if (!caldata) {
+			kfree(caldatapart);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(caldata + callen, caldatapart, len);
+		callen += len;
+		kfree(caldatapart);
 	}
 
-	caldata = nvmem_cell_read(calcell, &callen);
 	if (IS_ERR(caldata)) {
 		ret = PTR_ERR(caldata);
 		goto out;
 	}
 
-	tmdev->chip->calibrate(tmdev, caldata, callen);
+	tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
 
-	kfree(caldata);
+	devm_kfree(dev, caldata);
+	caldata = NULL;
 out:
-	if (!IS_ERR(calcell))
+	if (calcell && !IS_ERR(calcell))
 		nvmem_cell_put(calcell);
 	return ret;
 }
-- 
2.51.0


