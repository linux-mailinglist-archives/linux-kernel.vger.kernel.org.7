Return-Path: <linux-kernel+bounces-792922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D07B3CA7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5C581733
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3D17A300;
	Sat, 30 Aug 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI1QjPud"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95442065
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552626; cv=none; b=Y9/5YEwXEN7E+T8j5sV/9vsJ/Rqr/dW4N4GhhLtIDaCPkc9W9OVMJRYI7XgLsTv7eYknYGOwfp73XEFw+ZbS2c7/fIDAh8b558pVw2gaOvY7CCB4RE9heSJiSpSJWqOpOfPbAyTLO3S1StQDlGiqugAZBU8Xcw/87tGxzjngnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552626; c=relaxed/simple;
	bh=E0gq6DxSh3Mfd2fh/IwMmACtaozlVHjrWxf6F/SWbtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlDQgds3fgpa2guZkkTVjAo/PS0m0eQL2fQaUzObJ8SBtsVW5HNT2C8KtPESlC1GvuKZFogSTU7wX+hZ9fei41hlkn+RwV26bM2WXPhECUHHA+JW7b1dZlL8dFUIOi28BBVADUfMQkHYjCA7HxKfm3aHE4n+OTYEYjQx/sArLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aI1QjPud; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cbe94a190so495904a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552623; x=1757157423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrtE3Q82QK6+GBZEOdbY1kXklQMDVX/x3b7hwZm2YeA=;
        b=aI1QjPudCyTq/xp8gEd7LybOkLQdjMZLCtxKRkFu9OdIrvN3HPg6YuapnlTkY/JFcl
         b2gdu48tNSSSoc9vnKEfnGla+Xw3c2R75c+XV3q5oAK9WFP8gzb6u5aoZ0h9wxP99XVj
         Z5v9mARDEe9aNdV9wk7tg7Kwu3O1sE0A5QE/kz82IIB6WmNxmyotCtIj9075zK3k7o8F
         iI1XveOLoMjeoGvDFSi1jVnnNyZPVhCMFL9lkShc5rsUtZC/0zPvws+rGBw5N2DEO4k8
         GwJ0WRWOtf1koZB0WXvpDERsDdD23E/JHvoakWhnzMUUS4gqOMJ+gQ7EEXddNmEjp1ZD
         Wn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552623; x=1757157423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrtE3Q82QK6+GBZEOdbY1kXklQMDVX/x3b7hwZm2YeA=;
        b=HjLo008XRWJlYF9sLukxfcXwcMaMH8yGAtAJ00zIFr2kmEzZmImHlePIoXxuF0Z1lu
         bb1S3RzCF17l1kPW4sUm1jQRSQxirTxxPJDzvcIBmtlKMMwff1nOZY301+26Nf4xE9lT
         BbIcT12j8WFxOR9y8D26zZJif6l0hBi9NKve9FbzBzI9/J7rE7lByDoWSA5AgKGn1ZHk
         ug+6Asb+PA5ORyoyPvs3W1orQAfeoD1jr2/EcIQ2sWR0NYwZsIdIaXZzg5Q92PJIMCr/
         okwD63wVNGxDJN4TS1H2yKjbIgnznCyPu3goqhwRcG5Xed+C2tNqegqeSRD80SZV93wK
         WURA==
X-Forwarded-Encrypted: i=1; AJvYcCX0wbzBgSjT84jelRWMKOgnF2Vx5HCyynywSVNyv0nhpLjOFJL4RXqbIHG1aSzOLFAbN0eL7wvWfB2IDc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPEmo9MdDd0Fa+2o61jvkZlRs1t6HrRJUhTLf/9rT27NGOanV
	v3pjtiKXjESjYZBT0UOcIPlvjI9mXAbf7Sx6ag/eTEn5V7wc6qCl37cphsPLZcY0II8=
X-Gm-Gg: ASbGncvLt8TnOf9i5GwH3XHYveKjKgyFrdCWTFZO+Q440wSkepWg/QZ8psXYz9sypzu
	zokxksbNn4xFMmHT2q0uTbaExWkrcwXpeKCq6yROUjQu6ftWJmSdq0bOeuOhSNZ4pRk20KmlEsk
	LcjrTqdVl4QyIVGRXJ4v4Ll2xYPQZ9PTqWeiXw7ZFNK3hL3pyr2blE4U+PxC+GsrywzFZfIt1c1
	A1zAtjsGnjmDXxsO+lfscmyynTxSJWXzx/Jc67+hgw/tVu/NPGUHRFQfzZx61Z635mD3Mgi0Yi9
	z0mQLSUKBxZkPbLtT2FkjW2yG+snatmYQpfAvGMWQMlLKDEzaiGHIT8yKsVVeXumJE6gdmLO1nV
	ZLihPT+7O2I/mZxohUPer942t8jyJ7uCdVvLiksRlpAGNs9gSOSBZf7Y=
X-Google-Smtp-Source: AGHT+IFmornV4ZdIWfTm9SgoE8/HBXaeK1TDUM0EwCR7nq5XRu9/CMvRo+RGrgPCIIEx2ABNZ1/nTQ==
X-Received: by 2002:a17:907:60d4:b0:ae4:1093:d41d with SMTP id a640c23a62f3a-aff0377c96emr287174666b.0.1756552623239;
        Sat, 30 Aug 2025 04:17:03 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0236d310casm117780166b.44.2025.08.30.04.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:17:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: samsung: Drop unused S3C24xx driver data
Date: Sat, 30 Aug 2025 13:16:58 +0200
Message-ID: <20250830111657.126190-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=E0gq6DxSh3Mfd2fh/IwMmACtaozlVHjrWxf6F/SWbtI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBost2pee9d1wG5IpSYQufkayn0uDTUfoHK4Aojm
 OXjHWzf67CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLdqQAKCRDBN2bmhouD
 17DuD/sHmEpQOmJ+f3J11DHtrw0RH+Din6o+TGdXSZkDpyWNmfyR3Xbulz29+2OQ9GyJ5fnIEGH
 OLRyAgwoUVLWTc07Fjl+bEhfalWAR2p8AhxQF0SRmS3m2ufITSQ5KdAwimM/8W6Bw5PGfLvrhL2
 KC4E83y8qrf7Krj6osG0+HAEW8S1TqGswumOelaNzFH/sWoBWgovhA3ypaBGd867OQy9UnrCtkG
 8pTI4zK8UteCTyGOw7Gfgdtr4jGfMQEMoaXg8GDKHwvtJNgRd4EyLrW6vTtHi5gbTY5/5fsOH2A
 wUUAFzC5Ao8fwf62Rkk2NDtC/DObwKKj0hWv0LIfjNx6dgoJ2hvW4Y9puHX20m4FMHiLI8tU/AT
 6V5/uEJ6ZNJKoU0IG2kh0AU+rjLyxKGrJZr0YQEFdr61FXzNau5KyvXFyrfjPn3Z9YxEg1hrpq4
 9nHiBgQknrqncCa9akOgrJtcvM74QO5ypeMcZY2vw5YFmbsBjHPTk1TLEk1cnsM1UHziIBaH9O8
 scmcmclkkmZGx9YwJqpsq7HDUGXYxBXnyiDrRQUh/oa6QMOkCSdjOYyRUQHKWg23Zwtxzyww0Oo
 KOnEucRZFZvUrDPek+tDpT5WPFVH6xlgcf4RC6f2XkkGTQK9v7N7OsY/IyEBYjtGbt+utUqtSnO owzZc9hxRnRPe3A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Drop unused declarations after S3C24xx SoC family removal in the commit
61b7f8920b17 ("ARM: s3c: remove all s3c24xx support").

Fixes: 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 1cabcbe1401a..a51aee8c5f89 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -402,10 +402,6 @@ extern const struct samsung_pinctrl_of_match_data exynosautov920_of_data;
 extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data gs101_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2440_of_data;
-extern const struct samsung_pinctrl_of_match_data s3c2450_of_data;
 extern const struct samsung_pinctrl_of_match_data s5pv210_of_data;
 
 #endif /* __PINCTRL_SAMSUNG_H */
-- 
2.48.1


