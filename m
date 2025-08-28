Return-Path: <linux-kernel+bounces-790793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B27B3AD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AB93BF78E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAA2BE032;
	Thu, 28 Aug 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XdrKrUeC"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7328153A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418133; cv=none; b=GF/2OZhYhu5sbbMGHrUVXBT4TUJlEaZJKxighF9Q251RLIfCiL4POVqMZaCoXqEaqRoE6Z91xN/hZbCkDguRotL+ewBiUknVIuJP+Lqq58djmQ7BCuC9BcfChLr1KW/INmU+ASk++Zvo9MtIZiKJplVHhVc/dawBJ1ZdlMxw81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418133; c=relaxed/simple;
	bh=nxi+An4/A0ZCcQ5dW8sc/ikKMdLvt7njVMGP00aQVeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dNnD8KEBPVJlem2oIjgYevV9wTRMUOFmAZqjz6mKw/vxrmXB0KUyBXVnssRZTomK8gKWYorRctqMfAHe822QER+wmMor+1cqyOlVbdVZkfKzxu64iudiJcUov79XnuP47IbErMjWKA0LkfyN4vn6WIKgXSNKr/Qq9RWb3F2o6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XdrKrUeC; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30ccebcc7e4so608144fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756418130; x=1757022930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcr4BkxRn85jyEUc38hv805cvGNHKaquY+c7WmCuf9Q=;
        b=XdrKrUeCReXiAJn5WEYn9VNJoW1IY0UOP4KBbO2bHzs8t7KtdvVX5yBImm8MyRre4w
         77/RVgnauIw8TBeMyDDefECEAwCokKMn/Y0sju8m8roMuPp+BNRGo86J08eS0VLTlwls
         8JUNnDuVPqQLKOwa8T0jH4gd+3Jdea9O7r0j1WWlHHpKhk3XxSMIp7eCAcnGe/KowDbL
         KbSSxO+BwTJo7KEj5B//H/aMnYDmqNs4MboyPboTFvqXSqHJCvmDFjZLX045FAa5izS5
         Kc8kffmWGDpeTHDEqOOnxf1LlsmdbBnWcGaNjwBie7wMxG624CSFGd74HdOeauOixleQ
         flIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756418130; x=1757022930;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcr4BkxRn85jyEUc38hv805cvGNHKaquY+c7WmCuf9Q=;
        b=KwpDaFWBJf57xFQ1ofWZ9wERBx0j/x8mxkuocMOUBpnaViCo/kau67nSgPPNzEy0cF
         xbC+NEVHNxo6HTv9784tdn0bbhvkQ+IuhkdI5Uh3SXMADzTpKnDLJFhb07DQfRcf7OdC
         3IQHoFA72JSdJaDrylQY7xYbpOqVhOsc9pqe70UsMxZ5TW9FrRf0nuSW4D3F6XIgyQOJ
         V4AmQDqSuOegjJFLG8sf0sHNnWnAaqmwU/sxoMDlKurNOpQigVDftcOPhsXQLS88XNla
         YzEpx3/sGX/eenbvQhIrEFDf081MgM5BqzsEmRUfr0S4S2aWs/EALRyUGanxz6DalkU4
         Xgfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJRWJt8GmaTAswROr4lPc85nX+nkqoe498G0veCk59fpc/dx/dTBjFO1S1dIfbJ2m6Ljx0JFxGCdpFBRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2KL8Bx3OEGWX2+LSn6gbRJSw42F2uaHEEYFI+U/hXzfQ7rVK
	c9hd8l5FNj2DZvramwCGbg19muHR3iWwWpSBdtDCLwOlkwcgZly7T5uw8N9YhVV3LS30Dx5Of4s
	ydN1M
X-Gm-Gg: ASbGncuLlpNorrHDAozkWgQRg+3zUroQYp2T71eKL4TC6DSV1OzfASml9plDFRpUukt
	iVVXGS2RZD3B70T8OGWgNP7teFrHp2MzYsf3IsIIkOUJJmYZJhNK9/nobdDTJtyYRe95jfsmCgG
	6SyTr1AJ/KiCXKfklTD7BJYkYGKtK9CWV9aMcViTNpcgv93Fdy8dJXJUFXY4g7NPhpRH+tux5xM
	pVbtHvOM3YKjerQeESHT98MQZUS5llc+YMugQwHbKeXCiEK7ysbp8naXF4pjL33DjfnqWUNgbFr
	k+SGt6o10trR3CHbhHyY0YakApNkEUdzs3EOQrekw6qFYBEev0akXJdnqSURUU9DqdclaB4n6eX
	5SB+XQGF6HiUQUA5MK9QYXb+SuDBtbmaciv8iuwg=
X-Google-Smtp-Source: AGHT+IFFjAU7kjcywaAzZknUOjVBjmrsfsAXnB28DcB8oKezuCy+v8KNFFfoJWLYYikzUmfGOB6QiQ==
X-Received: by 2002:a05:6870:9725:b0:30b:b90a:6b20 with SMTP id 586e51a60fabf-314dcd219c1mr12803248fac.23.1756418129684;
        Thu, 28 Aug 2025 14:55:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7455853804asm136084a34.33.2025.08.28.14.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:55:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/4] iio: adc: ad7124: proper clock support
Date: Thu, 28 Aug 2025 16:54:51 -0500
Message-Id: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvQsGgC/42Q3W7CMAyFX6XK9bK2Tru2XO09Ji7y44A12oQkV
 CDEu8+Apkm74sKyji1/R8dXkTERZrGpriLhSpnCwkK9VcLu9bJDSY61gAb6ZgAliYLUznINLXQ
 yphAxSXsI9lvmU4whFTlANzUAelDdJJgUE3o6P1y+tqz3lEtIl4fp2t6nv/zuJf7aykaOo1e9M
 +Ct9p9GXw5kEr7bMIu7xQp/2BH617DA2M5Z7ydnPozq/2FvzygJjyf+U3nmEUZnlLyfqWwqDpr
 rhHPgbc2eNfdCy46Pbz/9dOfHbAEAAA==
X-Change-ID: 20250723-iio-adc-ad7124-proper-clock-support-7249022a7349
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=nxi+An4/A0ZCcQ5dW8sc/ikKMdLvt7njVMGP00aQVeQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBosNAvSQzFBqoOIaJtXUcHQPXzwTilekXbLU4di
 SXMQrQNDtOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLDQLwAKCRDCzCAB/wGP
 wLYyB/44txB1NWBfotRPjY+FW7l3OS/1/7pdpa+oTR4hMK1mBYielGMAAWUr3AiHn2bQFLsDPAs
 +uQ4eAuLslswcvrhNRDXbRvImcqohysjptDx2nk6eJqllc5myJ8mUfwRcIX/unqW71M+1a9KAcJ
 8v6kEHmIXvsCu8ua0yj7lnc5X1Pgfo9O1HIZiWkvfHYjfTQc0eNFsvUJuHCAMCSIQDHHE9SBfv9
 PmPLXA086U36vzqghUHv8pA3dGZUBjoWT7Uh05dUOsRCvqt70I2tRO4jBE4hJWUGFMJIpwZlAbT
 kZoAYiMjeqzzDyyHVLQ6iz0hJ9Gwd2ERnQ85gpn2S0m0+V4T
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

I started looking at adding some new features to the AD7124 driver and
noticed that the clock support was not quite right. The devicetree
bindings had a required "mclk" clock. MCLK is actually the name of an
internal counter in the ADC and also the name of the external clock
connection on the evaluation boards, so I guess it came from one or the
other of those. However, what the hardware actually has is a CLK pin
that can be wired up in one of three ways: not connected, input or
output. So the existing bindings making the clock required don't make
sense.

Furthermore, when looking at how this clock was being used in the
driver, I found that essentially this was being used as a way to
select the power mode of the ADC which is not at all how devicetree
bindings are supposed to work. The clock rate is fixed and the power
mode can change no matter what type of clock is being used. Again,
this just doesn't make sense.

So here is a series to fix the devicetree bindings and actually
implement proper clock support in the driver.

---
Changes in v3:
- Use %pfwP instead of %s.
- Add compile conditional to fix compiling when CONFIG_COMMON_CLK is not
  set.
- Fix conditional for enabling clock output.
- Include cleanup.h for __free().
- Add st->clk_hz and ad7124_get_fclk_hz() to handle external clock with
  rate not exactly the same as internal clock.
- Link to v2: https://lore.kernel.org/r/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com

Changes in v2:
- Picked up review tag.
- Wrap some long lines and tweaked some other odd line wrapping.
- Dropped mention of "hack" from comments.
- Use __free() instead of devm_ to free temporary name variable earlier.
- Link to v1: https://lore.kernel.org/r/20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com

---
David Lechner (4):
      dt-bindings: iio: adc: adi,ad7124: fix clocks properties
      iio: adc: ad7124: do not require mclk
      iio: adc: ad7124: add external clock support
      iio: adc: ad7124: add clock output support

 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |  21 ++-
 drivers/iio/adc/ad7124.c                           | 170 ++++++++++++++++++---
 2 files changed, 165 insertions(+), 26 deletions(-)
---
base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
change-id: 20250723-iio-adc-ad7124-proper-clock-support-7249022a7349

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


