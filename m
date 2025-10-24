Return-Path: <linux-kernel+bounces-869309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E8DC07971
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D2819A3E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97D346775;
	Fri, 24 Oct 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSONfhXY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547D338585
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328269; cv=none; b=jxnUazRHG7rBAfFFx68Y1hPSInXCJcIOTMDsKZAgUhq/AxnRw4jeoudYDk9OevQKs1f1pLNLnOIMQuXq8dpP4DgrVjcW4Pfkt6q4IH6jY5N2Zcy9Xi3RsfKYv6bsN6Y1pT5YLJbK4SW1wCFheyGeTgKtxM0YJfKPKrRcZJHbSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328269; c=relaxed/simple;
	bh=F6iAmNHD3Luf8UVaQkuxniLBvlzU+vxigo4O0hw+ZNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TeX8Kmwx2Yos7I71zbmdgoIyqsI6NPjslrjn2A7YX86WSFihlMcRcdZSpGNrcVcdOOwBhN7vtz/cr9O5mf/QFUA6idOkOChvCJMlJxw3txHzUzWKf4TKvWLjNb+Eh27u9TjwEVzmOQxP6EF+dC+4Qe4oP2R26G1Nzo/S5saTLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZSONfhXY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so21739835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761328264; x=1761933064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BkkNIM05MRslMrtDcvAYAmE9IErpoiznLkYTr/hTV8=;
        b=ZSONfhXYHFqvqScUu1ShPmS1hfFl1XSlDM5cPdqXbPbNht2WcxYgAQcwXrPFAKjULG
         FNVwxTQojKRyzQXPANUdmWozolqapWp7dtaxLGBdlfTBx/SeV3pihy3VoBTOv9fJLULl
         r2PG7H7l7ZgBmgk+7u6fdE7k0vQvKTW7Bs1LpjdWdIilFy3TQsaZPca0FaMw+KuNJlS3
         3l2epEn+zPHvYgONQ2u4SlnzZ/wSMUt2kDS5KtGgseVuB1UnptVvePRkaXk9c/6IqQBR
         QZoFrk1TcF3ur4neB/m9x+42YKsTmuugq2k6tbMJ4EpfG8zvEY+8e7f4s8chycqH672P
         C7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328264; x=1761933064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BkkNIM05MRslMrtDcvAYAmE9IErpoiznLkYTr/hTV8=;
        b=u8NY1FzyabP+59sxML6MOBD2SO91p+ehDNcSSgZ0BMbea4aNCFmrYA2UuJZF6uv9fN
         ts3ETE4MUlDgkWzfiH2l2j7C8IDNtka5irGKg4ymNWgShVr5g/9rOioQYAQJ+r5vyAAr
         mNi6YzG6+8glu2FY3TJ5dwttiI+zDqk3v4jHbXMRRqWk+D52F8aKVF5j8ZahYJgOv7vp
         kFBOaTFefH0nVFZP2C+YnvqvkbOaIqvoZut1g3UIAHW5xGxhxdBl+GtmI2qhwsQ9C6UN
         HGhaRA1L0lLztU8Ipj03cK7ylY9moNbqbwQKWCDXBIWEiOsk5CZcaVVsbEI6VHtndeoQ
         mIUw==
X-Forwarded-Encrypted: i=1; AJvYcCUhTyHV1e6kBUCixQVFIhdizjNCOcFPUZbwKi8GfjT7u4n06I+Vfdhw6t7PZjxyUN+rDMieKBKsS8Tr15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHPLyY5BICOfb9qmB5D2/5XA9Pa9/lH/YMd3CmTNRxl+UweB1
	CJcm8G4bF76z9RPIfXx+aFTCq720AmTIi65pUf1X7qnG21e1zwz/XMEVgEWbclavYtE=
X-Gm-Gg: ASbGncvlbfhGivU6iQUKiNCUpIGUkfU+vyCl/RQ0O90JwDcKHp5WZvMsic+lxODqzhu
	xYetY144e+PmR8OIgpsku3+jmUy6PSo+oldCRUvSskeGrmMINfgt5x5ydulrz1fMLnd7RV7PBLS
	2ofL8CVdnLxGWT2lTzfvZz+ZRtPzvB+nqY3GJMTR0ebZXcPCsE7Zzfcim5vlbV4ZFLfnFElwX5v
	WlKKBlPQPaP40JZ+ETZqVC0pZOmt6GB1qXjQ5G41kpySZ17N59d7QVYFAUqeoL8iDFU5AL0GPo4
	nl/0wGgh4EfPWx+2QWzFlxgmEBRnhdKFkMT6bGCvQFr0N0PWh+Ec+jOKed++KgD05bpmcAb7to9
	DR8xq7MDrpgFDY5qDudS85qlCScA7i8B1P5/4oqGG84yaLWG0SZBmWVMyTV8RYmmiCm2M+lVtnH
	cx8l+fDNxWwQruDZ6rUV0HDTvXzvQVcKVbjy4KuglHRHb5OO742nGJLmYYfIiL9Ok=
X-Google-Smtp-Source: AGHT+IGuCTB2VzxXr4BdWdJgj04b2GPHh8io8QNAnLWecfk99iG6qqbQtTimEzngfZJQ+vUUG31i1Q==
X-Received: by 2002:a05:6000:4706:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4298f5671c2mr3093463f8f.19.1761328264273;
        Fri, 24 Oct 2025 10:51:04 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e7622sm10321900f8f.8.2025.10.24.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:51:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/2] hwrng: exynos: enable GS101 TRNG support
Date: Fri, 24 Oct 2025 17:50:59 +0000
Message-Id: <20251024-gs101-trng-v2-0-c2bb81322da4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIS8+2gC/22MQQrCMBAAv1L2bCS7pKZ48h/SQ2zTdEES2ZSgl
 Pzd2LPHGZjZIXthn+Ha7SC+cOYUG9Cpg2l1MXjFc2MgTT1qIhUyalSbxKB687DN4WDIQAte4hd
 +H7P72HjlvCX5HO+CP/t3U1BpNQxoPc3WXZbp9uToJJ2TBBhrrV+rSZYNpQAAAA==
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
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761328263; l=2560;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=F6iAmNHD3Luf8UVaQkuxniLBvlzU+vxigo4O0hw+ZNM=;
 b=ouVjCdPSl7fPMeHYeiWolPcUlNg12vHEoXqNjHhaXd63O9uks3zaSartd8eLZeXLkrXwT5cCY
 XNmjsPndu2xBZSBSz3ao97449DqyuDNw4HpVv7szgd7EV/5zBSkdi4i
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

cat /sys/devices/virtual/misc/hw_random/rng_current
10141400.rng

dd if=/dev/hwrng bs=100000 count=1 > /dev/null
1+0 records in
1+0 records out
100000 bytes (100 kB, 98 KiB) copied, 2.03619 s, 49.1 kB/s

rngtest -c 1000 < /dev/hwrng
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
Changes in v2:
- dt-bindings: add power-domains. Collect R-b.
- Link to v1: https://lore.kernel.org/r/20251022-gs101-trng-v1-0-8817e2d7a6fc@linaro.org

---
Tudor Ambarus (2):
      dt-bindings: rng: add google,gs101-trng compatible
      arm64: dts: exynos: gs101: add TRNG node

 .../devicetree/bindings/rng/samsung,exynos5250-trng.yaml    | 13 ++++++++++---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)
---
base-commit: 73f7017e663620a616171cc80d62504a624dc4de
change-id: 20251022-gs101-trng-54b710218424

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


