Return-Path: <linux-kernel+bounces-878152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C10C1FE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1199188CB20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A8351FC8;
	Thu, 30 Oct 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na0Z/6vM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9D334381
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825509; cv=none; b=PdpJbvbA18zSxlF+agjMg2ikXtUAIWakfx1KwVjQW6nOZQO4JFlUUSbvwE6O6b9K1m8eivNU4Tdt5DuzRaoNTxPziMZaBKDPkEXeshiLkQ7T1ZPqJX4XmGbb/GrcxidLIS7v0hD4oRJ6KzvcZgASnHmxTKRhGBgx2aNlBSu/ZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825509; c=relaxed/simple;
	bh=sZNW52iY85l+p/HOpEFb2S81aet8Iw1lQAC4ADUJqwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5/cZvUVbzfOKjs96PpjVm2+RqmVm3PvthGrEAjGrZfumlPbGTjPD3hACkqW5s+Y+O2samZQqP/5knMaPhNu9n2oBFbc4OtEtIIbpYakXorVYYPZsrWP3o5P/i7wgM0yDce8jwWGp3bLHyH4wtp3kBbL1911dUjwsZQQqzUMNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na0Z/6vM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d78062424so48926566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825505; x=1762430305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPxRIbahOA8JF1fBeI0tVZJCAEXOLdeMtoMqodgWGYs=;
        b=Na0Z/6vMBL8Zc7h1ETExdWzjpN9Z8UywQ+xiWnf79uQKa6j2k/WBFPRzykM8VP9ulB
         3fHvARhWDZqM1bpH+Xo+AFtjMngczUtuDRlFE42JnDVISMJ27xMRZ2EbvNX8U5dm6+Tj
         u2D5E1aQz1psL+wEkkwnsYYrQksyy9ISQUCYRMrKxkV9DBYm0tpW5xw1TzQzJ3/dTQbR
         81FUnWU24I6FFfclQ5V0zKVfate0e629Rd7DoxNLPkyMwZvbgX4qzh0r+eWLa0oGF6iY
         pNQJ8nB3IcDaCdXAGEPHqBx82p9l2P1UDEDICRgGd7RcMxBvtepE7aNNHkFtyGEXXFbV
         1zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825505; x=1762430305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPxRIbahOA8JF1fBeI0tVZJCAEXOLdeMtoMqodgWGYs=;
        b=CamsmFqMmS3h3KMZMbeC1gbUnwJnafmsQX8wKBBS/QJeiSgTjOUfyYlhyz+3vdx3mH
         UZ0Ds4Gmywv5eelPBx2sth/QDnkcmqu7cUWkxshCBZF/nwjtARxe0T7+xaU4y5G3Po5r
         W6y4UQxwOjPxyoBymGKF5M3L/oj9GFUKMO2v0urfbv3t8l5nNVW8dhsuSHVFmQQnPIxU
         IluMJ48XR/6/3HIUffVf4993uvKuyEaQSNIX9VdjPiVHkoxNmB2ELVf32Y/tdeY/TKal
         zcSqd5QqFkSBALPq8sZ/3LAUIskisG3iCVrfkdib9gR0YcLUFPvQig5j3Kszk7rQGEpM
         XyYA==
X-Forwarded-Encrypted: i=1; AJvYcCV60uOfpTWxZLoffnssAiEsnrh0HosJgYHKk5P22b65Qs32UmWG3aoH99AcQoaLRC+uvcN2JjqPsXyt0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVtLhxYfsCDqkfA6lFLO2lT3JzlyMKMakowRTPSq2Oypa+0Ur
	MB6zhBhrgDugx3x60H75pSXJs8vb+ak9/3ec9XgQvRxWU5cGd4umVRai
X-Gm-Gg: ASbGncvvw5+bqKLofkubuNe+NNjOK4e3VmHbdgmZiBslM6FvxLmD1kIOaNlJqlYLJHH
	uGige8VU5kAPut4pGSLt25JhWPB02DJkvJTAstv6cmW7lKtz3EH6lFc7i+P1HSalc4iFgjIYZuq
	jcaW1rzuF+WLNUkXse7useCam7tDe+KDVc/tv2VWvL+fk08fa75FmGtf89Rxsgh+6KxUNtY4Sx2
	lm8nVylw5sCyWH6FXjCAKODZgao3jlOtnX/dOGQpxLumGzGNTdCAMtc6N03p1GS73B6sLqI7PJt
	X2M5MqCQRqlhj2hrPRhRHb0HCkj0jnvaJ/fRQw8w7Xm1GAqov4p/bQfk9G2WB88gt+dKS+d5cEP
	LxG2O8VP1hLWhva7cfdZb7I5NDvJoJcyJW+46V1o9PuM26POtk6rLyi/Jbd0WWop8SQE=
X-Google-Smtp-Source: AGHT+IHeSvgWKMHX9GjmCJ+A3zvrNHDZSYQPKt5DrHCbP1HCW+BvdIN08JLaAeXVo88A33OVPe//Xw==
X-Received: by 2002:a17:907:dab:b0:b70:30c6:c169 with SMTP id a640c23a62f3a-b7053bf1e3bmr282001866b.18.1761825504572;
        Thu, 30 Oct 2025 04:58:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm1752564566b.5.2025.10.30.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:58:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Tarang Raval <tarang.raval@siliconsignals.io>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] media: i2c: add Sony IMX111 CMOS camera sensor driver
Date: Thu, 30 Oct 2025 13:57:55 +0200
Message-ID: <20251030115757.33695-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for Sony IMX111 CMOS sensor found in LG Optimus 4X and Vu
smartphones.

---
Changes in v2:
- added nvmem-consumer and dropped eeprom
- switched to unevaluatedProperties
- dropped flash-leds, lens-focus, orientation and rotation since they are
  inherited from video-interface-devices by unevaluatedProperties
- dropped assigned-clock* props
- improved code style
- adjusted colorspace definitions

Changes in v3:
- switched to devm_regulator_bulk_get_const
- set V4L2_MBUS_CSI2_DPHY bus type unconditionaly
- removed pm_runtime_mark_last_busy
- removed properties from port endpoint and bus-type requirement
- removed unused headers
- adjusted register macros
- added vblank and hblank
- swapped register writed with known purpuse with macros
- container_of > container_of_const
- added return check to group write
- adjusted PM similar to imx219
- switched to enable/disable streams
- dropped enum_frame_interval, get_frame_interval and set_frame_interval ops
- devm_clk_get > devm_v4l2_sensor_clk_get
- adjusted default_link_freq calculation
- dropped imx111_id i2c_device_id
- improved code formatting
---

Svyatoslav Ryhel (2):
  dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
  media: i2c: add Sony IMX111 CMOS camera sensor driver

 .../bindings/media/i2c/sony,imx111.yaml       |  105 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx111.c                    | 1548 +++++++++++++++++
 4 files changed, 1664 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
 create mode 100644 drivers/media/i2c/imx111.c

-- 
2.48.1


