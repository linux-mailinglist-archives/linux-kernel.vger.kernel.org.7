Return-Path: <linux-kernel+bounces-858467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05ABEADEB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 894DF5A17DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281C2C158B;
	Fri, 17 Oct 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWcqrPv0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226C2C0F6F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719371; cv=none; b=r+Zsyh2+eqBOa5IUmhrEHZHoziroCpli9Ny5ujyCTqcd7oU7yBYglJZAltj1rHXU4lKS063v4DyHeVXNq2efnWmJ6MkhDG5sBVSxuda4yH88Qo+BehjcDfShUSxq2Yy9FTTTFuPF/b8+Q8mgCdYPVNZQkU8uxLhfh8Avcu1TSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719371; c=relaxed/simple;
	bh=v2Xi8BRCop79aLfKUyFbjXnCh53GmVnNIX5OfaejQSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzyb1FQ+Ml/hWQypuZNcRP6WMSBetoqhjvUDdE4BA99JNsOOTZC+U4xHauefCD9CFj/nvxhwefz/mQuvG9zKmke5rUiTd6/ViguOZwAM2EzYLa1FvjoUJV/pBmc600PA7dMQKL9XpMK0gdT6xyGm0nyE47xl/VcoszyNrUwCSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWcqrPv0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso16391355e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760719368; x=1761324168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRDCn2mU4BEifqlYf0hPzCDri6dg23TBWxghZYVQqdg=;
        b=NWcqrPv0xazKJC5D8dwMdWySPFj934I07f4/ijIMcde2iWZEyi2d1j9W70VFqD17vJ
         +Q1EQ20TdM5HRSWr0a75FY30TSqRafMfTaIGuwrmpPdILoByf6NWkMwIicWXFrro46/Y
         lUeV8TtXFZHDHlktb9nVdQYGu4A39OIukhTlBSSrPxKK2SpF8EoczGh881oT4NVQJd/2
         On4onrI2BwzPy3hscAQ43Z3WFPuH8RRjkAmKwYxT0/5Mi3noPjmVA96fGcYfGMdE11Y9
         8y1IPtt02Wbk9DDz86ryQWlLYrfDIezbgFT9Z+GqtDMg9RHDNaIRb/JbpGoiMfE9m7aF
         InvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719368; x=1761324168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRDCn2mU4BEifqlYf0hPzCDri6dg23TBWxghZYVQqdg=;
        b=dEjds/JwePhJCLLtmQ8LCBoM53rc0dpew1kDkYq4q5adJYwSk1VV8C8jhDfmmd4V8s
         1bkVl6xKUCazBd9mijHLRBhcG1CDyCy+eXCCrUdMKoMoEb5K6wJ0Najc9vHIPIzdxfBD
         VPVjLkXzhGpPTMiar7bCkDAzaJ2OW+wOijCtWXu6/sVOI/evMvWf5VsobITL8IgWbnmu
         T54jmuE8lLoiUbDZFbfcf9oXARH1a/iQ7zW4a9u5BhX3t1dexNxuWgtq9KbqTDRdQo45
         XXJVIKm9Zl2cryziU16CJv1bEb650PWClRFo+/ZoGjbtdSRvuXe5iCNJ29Lv/u942l09
         0D2w==
X-Forwarded-Encrypted: i=1; AJvYcCWs5D9bNlcotedb5zqNcezMBIs3s4ZY6ctUq+OcUaw40P2jlgWCFeqAAQHYMwm1K6+GM2FqHCJgPKgP2pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEilqW6M9HXhzrgtQypyd8wXHIERSXAhn7jKM09rz1VmERUyHx
	4/8eFJ4jLtQe/Cph6Jt1xh8imm5da3Rd8bxpiQaj5hqzzHzVZP9OmvE3+rEeCacJPeg=
X-Gm-Gg: ASbGncuKAwvudpy8JPI6EFdg4+OzkXbV67iLqF59q+9+D/iSrXr1rG1ESPMBsU5CCgo
	GpBv37B9t4BkHNcMEZ47hjARcFrHr5lMMtnqJDKsKDxIcI4VydeinqWhNr0V1Sd5U6VdGrMyVk4
	9UaFFLiVZBgmIUBiU+FBgpwrNQ8dOGvfVAHJFLJ0XZLMuQnYLBOYYfOlzStg3gPY6R3C5kJiW9g
	ThJDzMlJLKXU3lQZRqFA036lO8zpSgZN0Ded6GcACiVkewAo5qyV+5cLGi0fFyxnEDzKBaeXx7g
	/yylz03HnW0DnOpYcZ2zJuFS7f9xMOkAcwwpLy/ugBd8bSIaDmDq4eaEi2rlgjO0rYgy7cFrq9X
	FVcEVwNEVTG2vvo9lZtugUDVWSk9AqaK6SnCE9kKZCOx5kW1C6I2EpkoRBPkbCn3gLI7Zsqb3zg
	OJ7fvjE65a0rYDoSzlDSYIH4syeeJq8cE=
X-Google-Smtp-Source: AGHT+IEFldSqsX/P0Cu6c6dOrmrq1vRQoqiz5CJFLdZxVdw9U7KxznvLxXxb1tOd0Cjkm82QLwlpJg==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4711791c3b0mr41013315e9.28.1760719367811;
        Fri, 17 Oct 2025 09:42:47 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:f253:278f:af81:a956])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm3392125e9.1.2025.10.17.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:47 -0700 (PDT)
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
Subject: [PATCH v5 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Fri, 17 Oct 2025 18:42:36 +0200
Message-ID: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
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
	* V5:
	  - Rebased against v6.18-rc1

	  ** Jonathan Cameron
	  - Replace DRIVER_NAME macro with its literal string
	  - Used FIELD_MODIFY() wherever it is possible
	  - Complied with the 80 chars convention
	  - Combined two variables in a single line declaration
	  - Removed the 'remove' function as it is useless
	  - Changed s32g2_sar_adc_data structure indentation / format

	* V4:
	  ** Christophe Jaillet **
	  - Used dmam_alloc_coherent() instead of dma_alloc_coherent()

	* V3:
	  ** Jonathan Cameron **
	  - Removed specific IIO_SYSFS_TRIGGER dependency in Kconfig
	  - Fixed headers
	  - Avoided macro generic names
	  - Used IIO_DECLARE_BUFFER_WITH_TS
	  - Documented buffer and buffer_chan
	  - Fixed single line comment
	  - Commented why channel 32 is the timestamp
	  - Renamed __<prefixed> functions
	  - Factored out the raw read function to prevent nested goto in the switch
	  - Returned -EINVAL instead of break
	  - Removed explict pointer cast
	  - Used iio_push_to_buffers_with_ts variant
	  - Fixed ordering operations in postenable / predisable
	  - Return IRQ_HANDLED even if there is an error in the isr
	  - Fixed devm_add_action_or_reset() to return directly
	  - Used sizeof(*var) instead of sizeof(struct myvar)
	  - Used model name instead of dev_name()
	  - Used dev_err_probe() in any case in the probe function
	  - Fixed indentation

	  ** David Lechner **
	  - Kept alphabetical order in Makefile
	  - Changed explicit GPL-2.0-only
	  - Removed clock name in when calling devm_clk_get_enabled()

	  ** Andriy Shevchenko **
	  - Fixed headers ordering and added the missing ones
	  - Fixed constant numeric format
	  - Ran pahole and consolidated the nxp_sar_adc structure
	  - Fixed semi-column in comments and typos
	  - Fixed indentation
	  - Moved data assignment before iio_dev allocation

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

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   63 ++
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1006 +++++++++++++++++
 4 files changed, 1082 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


