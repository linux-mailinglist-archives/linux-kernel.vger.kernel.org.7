Return-Path: <linux-kernel+bounces-875039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9CC180E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 415A9350A23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233DC2C236B;
	Wed, 29 Oct 2025 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNWDmBxT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33B2D2494
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705195; cv=none; b=DpZhTXlrZCsHU+2G1VOau1wrwfr4XV5oiKD1hXyCkYoYEHxRIbONs8o4WjF0GYxjz5QqEOw5vkxmnnQv2iE/msVEiYff6P5sRMVRKhgDYgmiDftBtpGBQlgmIqcHpHSptrRIskODsi179MhyirvznvjSgt+RIkhTrirw87rpaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705195; c=relaxed/simple;
	bh=sZuB1Q8LX0nxxFMpEUz33o8Iks1w9uNnsPwhX+IgudI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tz0+HbMuoK8vr8Uuuq3NVLdxcVIF/FfAqvGOrHEAE03DZqph4FOLgY+cbvFBXHLMl2Lvnmn0p3Kfo3lesdR/68YGDhtjGzqH68S8toMHg47uGtYh6iNSQ2578NYSZOE0ZbehAsNiAew0MbQsmiRGtwltV4uaoRGknJ71M0LEeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNWDmBxT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso751638b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705192; x=1762309992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FzStmFr3Nqbkz01CHYK3w4vVL3ZAJh3Fiq4695g16A=;
        b=CNWDmBxTxbmqgZvWIvrYWNbgESZpJS/QC4fPC34/KITiBwjKV9DyrG9DFgW6JWAsmW
         3lECcanKovamlQ2tSDlkpvZd+R4Mz5o4xPIblyW2beMNeDYHeJK2QJ6K8LVfCKljWKBH
         nTXaOh7Zqw/c9gYiA5Y4GbHXJ7nWHMYk01UFQyMHjUpRxcH3UGhIgaIwfdxZKz7SDOTC
         0M9ibhKjgbBz5s+muihqVmF1wLgSvGI2d1MAJqZLAOmGLD1kWC3NIRVbs4a8zIwB1nHj
         6urBypbZ/K/BYIfQgtuNMGtERfwqeuiJCdiZ0xgTby+zuUkyf+RpJ9wutvcL2gUqCXaH
         l8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705192; x=1762309992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FzStmFr3Nqbkz01CHYK3w4vVL3ZAJh3Fiq4695g16A=;
        b=IaNWCrlFWCCxxLPHG5oMys7oMvYZGq0dvSAwTK2F8xA2m7yuyO/FyVemCPq86S8OKV
         5hD5qxMp5KkNWaLA7+8iFAbT8/ooQ5ipn9C/5c/uA9SBRZ6rK0SaW5FhQoBJevE+kxc8
         jDWR9qKcagXt1YH4+qbkpo/90iyuNAlXR/MUedx3ihX9JooT0WQE12wBVkRun64HBMlz
         vzI4YwWRU1WuhKmzfW3fHob410l7v6auuKLtzT/awpaC9Pdz3M3176oI7BiDyfFZkwX1
         NwaP5VJmVfTCwWLknSjPJXDhQK1DA8nWIt37ten6WND9y/hHg058VUjds7KB704rFWZB
         KdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7cBt/5ey3rRImp3SgoIoM3JxoLHbTEcU8+dc2wNNCI+e5vMzxXaPOnqfbf06HOmKapdRThSFlyXboOeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0B6tQF240sUp66P+yBijZ0Hjm8S/z90ObTfBZ5GGf2KL0ceMN
	wZIokT3iL/Jx0rf6pJQF9+qzW/Gtcs5CvMSHL4JhRBScqH7IvfmbYGdy
X-Gm-Gg: ASbGncsePGgZ9H5pbFx3UWt9cJrwxIIuWCQjInJC+hbMU2kXz7/SpzfATGA//sLWyO0
	VmNwNC1rVemKOv882W3JNuUtS2WMwxBj96SqzvQjY1+JAkJolBZuZvk3llmIutrxsnO+QgyVvSb
	0jygegsFq0KCz8a6ADrSEZnbGXwT/N7bfvNHCjfTgrABl7uCStnUgpsoh6MqqWhkueTsgJaObCW
	r78hxCz1W0V6ifEDoJzZ4aTyLSNZ+5aVz0dfLdjGbmMaHv5tRoRYZLxcMiBFbrpGtr6mr7M6Ezu
	/SmJ7xVWwV9ov8yzU4UA4BoQoeTA69x/dQzX0UFlcNV1w9SLDjx1QMuaCaoCkUw20JaxXeoomlP
	L9gwtvPg/u9Ha8HLPXLMVY/bEi8vz6jsB1YO4sqznq3dO/Gg9vJbAuu9kVokW5wK8Hl0s0mS2Po
	RuiTrOe1t+Xev9Uecg0SKoSxVpkX1O0g==
X-Google-Smtp-Source: AGHT+IH7KgMBxH7VkWb4N2jyhkjWC2IXZfjH+rgQl28193AGI8ufVi7cMJxC+Z/Z1KoZcdqkFWSKag==
X-Received: by 2002:a05:6a20:e291:b0:342:4318:c12e with SMTP id adf61e73a8af0-346538169e3mr1333017637.50.1761705192564;
        Tue, 28 Oct 2025 19:33:12 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm11826966a12.10.2025.10.28.19.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:33:12 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH v5 0/2]  Add support for MAX77675 device
Date: Wed, 29 Oct 2025 11:32:51 +0900
Message-Id: <20251029023253.150257-1-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

MAX77675 regulator driver and device tree bindings

---
Changes in v5:
- Fix subject prefix order to match subsystem ('regulator: dt-bindings: ...')
- Drop unnecessary '|' from description fields
- Drop repeated constraint descriptions from YAML
- Rename 'maxim,en-debounce-time-us' to 'maxim,debounce-delay-us' for clearer naming
- Used common 'reset-time-sec' property from input.yaml
- Remove duplicate description for 'maxim,fps-slot' and wrap lines to 80 chars
- Drop the node reference immediately after registering the regulator

Changes in v4:
- Remove the 'maxim,max77675-regulator.h' file as it is no longer used for bindings
- Eliminate unnecessary '|' characters where they are not needed
- Add and modify code to drop references that are no longer used
- Remove dead code
- Add detailed descriptions for each mode of 'maxim,en-mode'
- Rename 'maxim,latency-mode' to 'maxim,voltage-change-latency-us' for clearer meaning
- Update max77675_parse_latency_mode function to max77675_parse_voltage_change_latency accordingly
- Fix errors detected by running make dt_binding_check
- Fix incorrect indentation in the YAML file

Changes in v3:
- Removed unused variable 'value'
- Removed duplicate .list_voltage initializer
- Wrapped of_match_table with of_match_ptr() to fix build failure when CONFIG_OF is not set
- Updated driver code to match new DT binding schema
- Changed regmap_config from REGCACHE_NONE to REGCACHE_MAPLE for improved performance
- Added volatile_reg() to mark status registers as non-cacheable
- Missing explanation of `maxim,fps-slot` default value
- Updated DT binding enums to use string values (e.g., "low", "high") instead of integers
- Converted several binary properties to boolean typei
- Renamed time-based properties to use standard unit suffixes (e.g., "-sec", "-us")
- Added default values for properties
- Removed unused macros
- Renamed macros for clarity

Changes in v2:
- Fixed build error due to missing 'max77675_of_match' declaration
- Removed duplicate '.list_voltage' initialization
- Corrected value usage in regmap_update_bits call
- Added CONFIG_OF guards and used of_match_ptr()
---

Joan Na (2):
  regulator: dt-bindings: Add MAX77675 regulator binding
  regulator: max77675: Add MAX77675 regulator driver

 .../bindings/regulator/maxim,max77675.yaml    | 186 ++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77675-regulator.c        | 861 ++++++++++++++++++
 drivers/regulator/max77675-regulator.h        | 260 ++++++
 5 files changed, 1317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h


base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
--
2.34.1


