Return-Path: <linux-kernel+bounces-686777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0203AD9BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CC7189DE97
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA562BE7D4;
	Sat, 14 Jun 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SNrJi/Wn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4A2BCF45
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749892527; cv=none; b=rYArXZ5XY/NW+aFWRJpGY4HK7+/PWRck2asin09COJ36NmzbDydQXnLB2S0cAjjj55xPlOI8Ncmj9Z3awPF6MUbJu3cYF29SMxylPSGva20cydFuGXNlpnzhfeNiLsOciJWok6zuvgA0/XzPkRcKHdj98mrfnnBjmv4VRZtDgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749892527; c=relaxed/simple;
	bh=jPCY05kPPAmWwowBzuxbBJeUM9t50mKfzkwLsJbwfJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiA666uOKy6vTAVvcPyhtgwM3T+S2TKHUlLsP8CZN8EZmRwsTaCJ4pqH7dNDl6L0BKSbZkqiXjL8QlE3ViqdKajsQgEMAa6Yh0nF5GCgPSn5gcIHIa1RH/zoXESe0fqnPPiuBzRzbm5iB6oXoOajTnF1TvdHGsTSyl5CnIRp1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SNrJi/Wn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742caef5896so2573210b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749892524; x=1750497324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYRTvvdIGzq7CdBFFP9ONngkQPMZn1HDEsVvSCMMDNY=;
        b=SNrJi/WnQg7K1Djx6EcEsT2Wl1cz6k4Ov6aWUPlMF99DmSvOhXtyKcaKypV6tRGQEB
         6r4/bSRDxjczmu0ueQNWMf7zAV9nRCFyeJcPo/e7aD19ZUskl5o01FYlM19OesgEQAi8
         jjAGbgUB/zj6NloiMUy4aobtD1VDieu/WW5OTn1nsvazSfWYGXEevC/QRhoE2WMU+j9e
         d9kw8kts9G3wuPr4WoBsy3HCSrs81G0ebQfb1vcGnxBwyFhhpmOf8l0CghyhDfqeQ9/p
         IxNHMsLSrlLsOI0Y0DCp7kdigJQ/kgn3HzxQObV1dETdAeSc05AyFgVmXCnL6jBxTwPO
         JpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749892524; x=1750497324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYRTvvdIGzq7CdBFFP9ONngkQPMZn1HDEsVvSCMMDNY=;
        b=RJBqfsjwAChuYa/CBVdmlP53kjkIuqmx/2o06xVOyHJTskKO4FvBQS3Xw9DVYShE5A
         /9CF82GUoLKLvDai7MJP4gH0wV0loX9rHywByj6aCH9bOgQwO2doD529UbbcQkJDPqKr
         TzWOL/M4j9Av7oYRRwaEelKP2QSVemvFuRPoKyJEJELdQpeFqPJL4KsBqrVS/10oCp7i
         izXBvtFtUMfuUfWOGLGYZ3n9O3hmo/jVnnkXz6fNoCsG9yDCzvSIjRS+55VN7UO+6SyT
         DU0TBMXfmvroiD21KL90k5o3Kuz73986wP0nHWofkdZCBsy7BM0Xz/18oo+L1kBqkKIU
         rMZg==
X-Forwarded-Encrypted: i=1; AJvYcCUmRHPD4B9ffeLV0QqSKQ7TR/RABBGmh1iD1sHZxD7AJYBKkXKmgogYYrfQQiReepIU6w4cLeZIXAO6XsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvE4VU7BfmKCBSdJj+tY9+QSvJ1bhp/R0GdfnYAQCHSzcLx2yN
	j7BmfNy9M/GDFkW3uaB7jkp4djKec2RrKLgU/FeeLJeI4jZvrwso9DL4dsV7PTXjzw0=
X-Gm-Gg: ASbGncsBzDeQTJ83sOPEy6EUECyJLE/c17AcPTh07Mk6jeetI22o2dtnzxJ4d0ydDs2
	a1vGCRWkFJuksDfq4E8K5Nj8d97x0IaGzRjNFJgcVKsW6JYN6GyZXyXWqW00NPFIg2EVD1GxDhj
	HkLu7t0fIxyJiOvRZjpHs8g42nDDPc0IxD7o96ftTp+tLpYRPdrFPpwl4alRtkhFqYkUS6HEcD0
	Y1bN0wIsYdHHXT8egfptqxBONl5JEYA4LBIUybZzTPlH1gH5iTRHqRXoQasPiuCpkiaI786862t
	fh5LWDj9NNk53p7TALeDBFUWyHDxoN5+nUuEe/28z2oh4eShv3ceFtOU3HtUndWovIlOx1Y3Pc/
	5zIRHiEmonx7rrv63bOj+t/Vy
X-Google-Smtp-Source: AGHT+IGLACzGINeLzDAekt4Nq+kEFciWTt+wr5CrDD1kNgZwXpFw4VeI59kMC+hduQurLjcXbkumOw==
X-Received: by 2002:a05:6a00:230d:b0:746:298e:4ed0 with SMTP id d2e1a72fcca58-7489cf99f60mr3017945b3a.13.1749892523829;
        Sat, 14 Jun 2025 02:15:23 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm2969630b3a.20.2025.06.14.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 02:15:23 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: maintainer for TI's ADCs' driver ti-adc128s052
Date: Sat, 14 Jun 2025 02:15:04 -0700
Message-Id: <20250614091504.575685-6-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614091504.575685-1-sbellary@baylibre.com>
References: <20250614091504.575685-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the ti-adc128s052.c which supports a
few TI's ADCs.

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..bf1c7fdcd2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24719,6 +24719,7 @@ F:	drivers/gpio/gpio-thunderx.c
 
 TI ADC12xs and ROHM BD79104 ADC driver
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
+M:	Sukrut Bellary <sbellary@baylibre.com>
 S:	Maintained
 F:	drivers/iio/adc/ti-adc128s052.c
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


