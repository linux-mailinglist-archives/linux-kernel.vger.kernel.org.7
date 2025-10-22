Return-Path: <linux-kernel+bounces-864813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47840BFB993
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F33B65EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967B333745;
	Wed, 22 Oct 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXwqpnqZ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5C33342B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131982; cv=none; b=eA+oqBmJfV3wYDMBZKkCKyt9HTz9dHLxbickWzXQmt3cS+Gz60+7v7/I1YCURHiINJhCIg6Bw2LtgasCubigWKlvGUlIGLdLhvfm2ytGr76eO/+61c32WOclMuGaYY8oxC/Metim/GRdCgB9FO8YqxUNy4zFyAHGtv+6CqWPV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131982; c=relaxed/simple;
	bh=d06wTerR1sR2T4EONqcyBchEQMucKU4Nk79E8aTrujQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PW/zryeeaMfFzSz61IZDsqW2zfZ338BzkM6cjWBGKsAo1Uv0LmsJPDJ/iSUxuErghbp9RmSuJPVBwia8lEToTuLL28Inmk0pfYd4rZCUCst6EG9n0RszIxqIf/ana7gcrgdOwlOy9+5qnq82aUahiPGaDMcVT0hHbrFYeL5q5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXwqpnqZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42421b1514fso4250762f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131979; x=1761736779; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T/x7HAWx7iB0lp5HpZ068PQTi7UotyqR4HqE7amHBc=;
        b=FXwqpnqZY+ZHpgKDQ3aFVX9VY/rlQNbYmHniflF3mxbAQngE1JfiZuNWLkjz2LMsRA
         gz1y/il3E9DLyDAh/UcUTEK6ijx9tvUZmkDHGcXYbrPEY9kAIyIcAIjehFzx1dsZ5Nh1
         VhB3soruTmYLHu/QroGKQ/KNvuM5+UPcvdpqTcibQ1PDCi9kTYRr888Xnk0pmKmjCKAU
         tsmS82TwXdNFr9QfvpRkFW5QuGv6ucg2FjhqsTuavC7jF9USvRIxs0aQ9pa0cfJRabtC
         CJdjKtRNO/z9dZyrW6mfw/bQ/n8NPOptR7kFEAAvDaNjSJDKL740j1KO+7FcNd9AcL6E
         QQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131979; x=1761736779;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T/x7HAWx7iB0lp5HpZ068PQTi7UotyqR4HqE7amHBc=;
        b=pExQ7z5FSTjrnOZhrs51CLvEz1yrz8nkdYlnWc1HA7FBr39x8RfMpNjRM6SD2Jy1gM
         ccf5tb4ba+HohDvdx4CF3CWAMUV0OC/bK10l6WiKvbXMiMKv5e7cRJ6R/4Tdbjk3Fe1V
         LEZ6OamnkMpFGyb+OreJT09NHEo3FCyLTpjVN2WnK8QDAGMk6aFJchzYEKFdWjwwsgFC
         qEmwRhZjjn7r4fxDQN7uwPih0W/g6c3xgwJUZxlFBSs6/QRlYvV/CH5I0j35DiIucUUM
         oHiNyvb1TQfVv6RLixNG4MjKFZC7tU3kyTO1m6Tw5iqTTCaWcVViFA1DXKXsTuIw1Qba
         GtEg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHs1hHjgofrXSZdiMRyIlT/16unySSWPEPibdFac3mHg6v23PGa3UmmflJ9NSngrnY/VZ9SFZdbzRRE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qR+3cTzF2kBqWGhQ2aycbh/YtV8O7aSspm7yUzP91ujtOTqa
	p42Zx6wVLvExL4m0gBy652vpbx3yEM03BRNeWfPn2FRGx/oJjW190hLz0+6iArjf2ww=
X-Gm-Gg: ASbGncuhUrI/sNBpUtJbEp7gc8Apz5Rn5VEyL54HLeBIojypS48XI+3dbFXuwZ8bge4
	MTh7b3MFGkJOw1jsIB8r4SZd1HNXHs1FSdiIjN9AYjR0nbmm+zkCbGqnPHDw6rVMB19AXWaSYrD
	DyqLh9Z3y6iZ9R/QMFt5Cw8J9H95skcUJrUi7+jbvhEv9yeF8NEvPh9Fw54v+0nX8MB+P4LougY
	Ji1vll0RPYzlwgpxIJ8g4orOWTo0gWXjQaUHmR7Vf4uVNmsIjlieEPfV2eT9a1zJyuaFoaiZKc0
	+C3vjZDVJzHtGLIRX8LGTLuwdblvbj74/eYz+V7K807Kj5zrVY9ohgzTis+Vk0HB1Zt6rMM9lc2
	qr9r6ep4E81M+wMacXJfO42TZwEeJei1g7LaJuy2RPJj5m3NOsl8cyazAFQ13SVkBVaTSDf1RW2
	+ry9HyVTVBV5vlPKe0eMI1hmEDEsSgCdkIsLqiaX73DXRKiqyUKWVG
X-Google-Smtp-Source: AGHT+IGv86ynL42pHYdUKBw9RuU6yCngSbjdQh4SHsDnbLpVSdE137PiVhtffxXXGOOfiMwcQOf4Gg==
X-Received: by 2002:a05:6000:24c9:b0:426:d549:5861 with SMTP id ffacd0b85a97d-42704e029bcmr15217601f8f.42.1761131978148;
        Wed, 22 Oct 2025 04:19:38 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a78csm24820692f8f.26.2025.10.22.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:19:37 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/2] hwrng: exynos: enable GS101 TRNG support
Date: Wed, 22 Oct 2025 11:19:34 +0000
Message-Id: <20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMa9+GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3fRiQwND3ZKivHRdU5Mkc6CYoYWJkYkSUENBUWpaZgXYsOjY2lo
 ANfjsVVwAAAA=
X-Change-ID: 20251022-gs101-trng-54b710218424
To: =?utf-8?q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761131977; l=2271;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=d06wTerR1sR2T4EONqcyBchEQMucKU4Nk79E8aTrujQ=;
 b=IayhEy+ddWFifvTeb3lqukHgT/sBVfIIGHwKHkGUx79QsEmrV9yt+ClYCAmmEUlOhpghFHU3G
 ur6VZXs4GzcCQwFr/ye1jOP0bndyBkeKexTNX8yhHUO+6Cu2vG0XAR7
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Hi,

I propose the bindings to go through the Samsung tree as well so that we
can match the compatible with the schema when pulling the DT patch.

Thanks!
ta

---
Enable GS101 TRNG support. It works well with the current Exynos850 TRNG
support. Tested on pixel 6 like this:

10141400.rng

1+0 records in
1+0 records out
100000 bytes (100 kB, 98 KiB) copied, 2.03619 s, 49.1 kB/s

rngtest 6.17
...
rngtest: starting FIPS tests...
rngtest: bits received from input: 20000032
rngtest: FIPS 140-2 successes: 1000
rngtest: FIPS 140-2 failures: 0
rngtest: FIPS 140-2(2001-10-10) Monobit: 0
rngtest: FIPS 140-2(2001-10-10) Poker: 0
rngtest: FIPS 140-2(2001-10-10) Runs: 0
rngtest: FIPS 140-2(2001-10-10) Long run: 0
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=380.570; avg=385.422; max=386.964)Kibits/s
rngtest: FIPS tests speed: (min=75.092; avg=81.784; max=84.771)Mibits/s
rngtest: Program run time: 50908949 microseconds

To: Łukasz Stelmach <l.stelmach@samsung.com>
To: Olivia Mackall <olivia@selenic.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Peter Griffin <peter.griffin@linaro.org>
To: André Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: semen.protsenko@linaro.org
Cc: willmcvicker@google.com
Cc: kernel-team@android.com
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

---
Tudor Ambarus (2):
      dt-bindings: rng: add google,gs101-trng compatible
      arm64: dts: exynos: gs101: add TRNG node

 .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml       | 10 +++++++---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                   |  9 +++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)
---
base-commit: 8ebc2add3e2d076adc5cc3e8c9bef268f7f1cb31
change-id: 20251022-gs101-trng-54b710218424

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


