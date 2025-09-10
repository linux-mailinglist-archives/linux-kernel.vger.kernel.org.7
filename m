Return-Path: <linux-kernel+bounces-810584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B00B51CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BBBA00B28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C032F749;
	Wed, 10 Sep 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wae7y6si"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2632CF7F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519892; cv=none; b=uq6zfrN0GI+YmMmAOvlGWcV108Z2rfwEdkzH63sVpbML/tNLFu5Q0WUA6989cFxgb93DsF/cO8YXsQUDYQUoUPsbeGdxSrQE3edC5eGDpwSqDgyIp3+R3nOHk1xUnx7YMkynZ+bBidVtm6ICqhLC7DBOE26QwkqZEeTL6UaTwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519892; c=relaxed/simple;
	bh=0OXy0pIlk1rrTtpMa3bUiDD9A6fnxy7GK4ztvEBXy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyKs+qrPR4FRvi6yssn4ZVJULomEXdVKXpuJWMmRMHagjz7Lp/VseLdReJ7nbNsq8S2gJ2GhkMZMtJOoRIpElH2urM3DBQFJbJYFyMThI7ikOnzcse5IRxGps57TLB44f17UaZtKiWCjdTNXJsplZ/cnu0sEsNFjhS3+BdShhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wae7y6si; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3dae49b1293so3593674f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757519889; x=1758124689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ6CTb9QgukTBV6bS9gxx7JwKyJl+T8wYIdJWg2p/8g=;
        b=wae7y6si1VBXkptU5+3lrvpOAFWKnRnsgnzI9bC7CTWms/wbYzebfs0OGaId6vbFM2
         Genj9Nv5rFGhBfJqA9KPOWAgWDlHdl5YD7AY6YGpnVe817DqJlJ88u5YdtAnkQCJepQ7
         dLDJqinLSS+tUBU8oL/kBomRV7caxRJ0H6QQSnZPpKK7lDZFHB9M3e3GY1TVs2je6PJn
         a1SikCox5MKCnd6giCjcwFkyxCzqgVwksqH80/B8t2Jh+Lrnxcp9SgAKxx+48ycw062V
         pUHEYRkiNwbE4mNIPoGnJS/jRxTGV+ysXKD9ym+GO9nrwtquYuOMxEsIDeW5QAGshyzy
         PbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519889; x=1758124689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ6CTb9QgukTBV6bS9gxx7JwKyJl+T8wYIdJWg2p/8g=;
        b=MuUqSe4Ew1pXCnRXhvEzUqtMBCkFpamf1Sk6DnPHAkiUHnpDZGXuCsFuudYM0ENPhz
         dKAjbRniqg3qlh0/UlUi6MQru7nLUnS6PMUsHS31ijoLw01N2kwgUp7/pm0QRAjE48Ew
         dB2CMnYC9kh/cc7YMHo2fcapWWQ30+sgEGWrJGCbNaqsm75t48psHh3vQtBTomCpEQnq
         eM0tdwchCb9Gaj3N0iZPfyjr1KSNej+jqqnXFxvfLxcMoyDf6T/zc6bS6hnekVgJgrtI
         DVKGl9atfiEVjloPtaVk4dCJbOJ3HuYvHz1Ky1nKYZjW4blJzFB1kDZ792if60ISilGM
         UASA==
X-Forwarded-Encrypted: i=1; AJvYcCVzvDtEeM6w691B8D1Pwcj7C1mL99fnZk77w5tmrFScLCWvzFAw2u9a+/X+0YqED9duV1q1PaHnFcD4MdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2g6yPAKeprG1pb9Fy5scMbVjAEk6qmILVXwNIs2jA5B3VOT7
	dgC/LijsRjUMRMk+nM6E/M2vUeIEFbJzQ2bUSX0Wj1s3/bUjD4/u49xEaUbdE+XcCPE=
X-Gm-Gg: ASbGncvFqNZeEenOlp0oSWCwbh8rSBX7AM90wPcI6bqiq6Cw6rum+es6YQyU4gFIgWs
	BP/AWjTy8DJXT64mrhVdXjl6i3iVEAFPdNYwb7oqaUTWQ2MNQ1WvGEAVa+/QNRjjiy7WB+dSGu2
	SzdgwSq5F2GwBmns+ij3CV5FfgzAfIVtWzLW4YfU1tuWzg8+YlC6kSD4gSiTimKVizBpXBgzV6B
	2uyUeddwvHzELAVmr2nXS+nBLejli3h98j2pR48qzUeTnj9ZwvHDk88LEsC9obB3YKetc5liXUw
	ZdVU0E3Xh0cEOEr8O/FfPW471ZaBPdGsIIHUY3hRWZZmLVjGB/4x8vdbU3A/yCGvgyvYnIXlGwm
	NEJnJYY6NScC/eiMQGO+eB6tRd4B1kKrSaEDNqXMpBIQ=
X-Google-Smtp-Source: AGHT+IGxtk8aUU60lUW/tWlArM0SdaxDZo6GGAqsTWAWeM6Yie0aGFijwOZEXm4dntS9JpH0TcFNHA==
X-Received: by 2002:a05:6000:24c1:b0:3e2:ac0:8c55 with SMTP id ffacd0b85a97d-3e643c1a48cmr13871860f8f.55.1757519889267;
        Wed, 10 Sep 2025 08:58:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea3csm7490325f8f.49.2025.09.10.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:58:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed, 10 Sep 2025 17:57:54 +0200
Message-ID: <20250910155759.75380-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 platforms have a couple of successive
approximation register (SAR) ADCs with eight channels and 12-bit
resolution. These changes provide the driver support for these ADCs
and the bindings describing them.

The driver is derived from the BSP driver version. It has been partly
rewritten to conform to upstream criteria.

https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c

After the V1 posting there were some discussions around the DMA code
to be converted to use the IIO DMA API [1]. Unfortunately this one is
not yet fully implemented and merged in the framework to support the
cyclic DMA. The current DMA code in the driver has been used in
production since several years and even if I agree it can be improved
with a dedicated IIO DMA API in the future, IMO, it sounds reasonable
to keep it as is until the IIO DMA API supporting the cyclic DMA is
merged. I'll be glad to convert the driver code if such an API exists
and allows to remove code inside the driver.

[1] https://lore.kernel.org/all/c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com/

Changelog:
	* V2:
	  - Massaged the cover letter changelog to explain the DMA
	  ** Andriy Shevchenko **
	  - Added missing headers and use proper header for of.h
	  - Changed macro offset zero to be consistent
	  - Remove macros REG_ADC_MCR_NRSMPL_* as they are unused
	  - Changed delays macro under the form 100000 => 100 * USEC_PER_MSEC
	  - Replaced PAGE_SIZE by a NXP_PAGE_SIZE = SZ_4K macro
	  - Replaced read_poll_timeout() by readl_poll_timeout()
	  - Changed error pattern "error first"
	  - Replaced variable type 'int' to 'unsigned int'
	  - Fixed bug right instead of left shift, use BIT(channel)
	  - Returned directly from switch-case
	  - Used guard(spinlock_irqsave)()
	  - One liner function call
	  - Remove redundant {}
	  - Write default values litterals instead of temporary variables
	  - Changed variable name vref -> vref_mV
	  - Removed unneeded error message
	  - Used dev_err_probe() consistently
	  - Removed successful driver probe message
	  - Removed redundant blank line

	  ** Nuno Sa **
	  - Replaced of_device_get_match_data() by device_get_match_data()
	  - Removed iio_device_unregister() because devm_iio_device_register() is used
	  - Removed "/* sentinel */" comment
	  - Removed CONFIG_PM_SLEEP defiries

	  ** Krzysztof Kozlowski / David Lechner **
	  - Removed clock-names in DT bindings
	  - Fixed minItems by maxItems

	* V1:
	  - Initial post

Daniel Lezcano (2):
  dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
  iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   63 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1026 +++++++++++++++++
 4 files changed, 1103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


