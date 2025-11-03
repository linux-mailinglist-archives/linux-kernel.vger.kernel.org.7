Return-Path: <linux-kernel+bounces-883153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE77C2C9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0C646244B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C622BE7C2;
	Mon,  3 Nov 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTCxV/sj"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDB1E3DED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181812; cv=none; b=pf4f151YFBs3eKzC4tdn4DpCcKJarmwVh/J+p7RDQujzriaohANGcI+uqAvk44K9iG539cxAY9/36/e7/IugyalmOBRqTlXe4vUgLZKGksHpo2gZ+rChwghY/BATalFcZ2rIZu0jZyNuzNaqCcml1A76yFf5jynIN/MCsS29pFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181812; c=relaxed/simple;
	bh=+dN8MGig6uWQPCIQSDotDuiChqdEPeG5tERdgPyZLN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWgv2Nk17HTEGTL6UwlYowvbNv9NeISLuQCROGV2nkq2wwR8Kbp/6xsRcHpPmZ2ADvEWiHxfWCM+IRE+x9vES27CWqjDbuyK1MW/9FSjOfsL7AaVBK09mA4oSQQxTB6zLKbjADI67wdHqEEwyOOXrCR7h3322yN66J0ulOreBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTCxV/sj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37775ed97daso53951311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762181809; x=1762786609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06au7PdCTZBJsIAFhSDifDXIKO9CcQZkNrGbPjdHVdo=;
        b=RTCxV/sjZbRB6Qy84hdcCwfXg8z/VfUxRvB/L7RKfZdAHWj8nM1g1kvNUaal8dt1fB
         /YerzVR3ms2GD6LHhry62PsRvtMhT8tdby5xB32tsEF5RkUYrE8BHwSR/kUtqPRDf8jO
         yLMUKifQzbuE822RemgopvDWBvmM3ts6C1K+xShh4nZ17DZahI1Nhh47tXMTZu9zesn/
         QyCRNswfJ4jeB5poQQXigfSQCx5PIlicH9n6lFtANR5XC47QTri7DKJvfhe7umGO0peH
         /FOYlLo+vPOtv8OhWke1npwzUc1K2mJM+Syq9SH+QewT6M6UsYry/CGkZekz90dnJZGY
         8ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181809; x=1762786609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06au7PdCTZBJsIAFhSDifDXIKO9CcQZkNrGbPjdHVdo=;
        b=CMis7Dc4cSmLnMnp8U5lbORy8YCk7VSIYwoVtZb7L8tInJlQK0JDK3v+6LxijrlEYd
         6/GpEfgSS8ol6tDJli5K2Oyw60KP+ZxudS5DTIvMPBUqsJdRJVPSOua8jxjxD94LG49J
         lmc7B0hdc+BKxSeVWUXNeswJBi5bfS0IM+fqA2J/xHR7Aj29xkuKpnuXBD4f5cGVQsk8
         jY8LBkx8JmmmyxRiZzjV2UBCqAyj//gH9Dx4OIYe8zZDSzrmdKfUWFq2FH8ELLgZOJPZ
         JZ/CfI6AT3qoVSH91wnXU5XdN5A8XnhpL++HPBd7KteOuIE7XvId2X9gfFzeR/uhz2ub
         lUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuBqU/sGITmi2C0ahmcv2Jdo0v0dcpo6ROh7PMVCwP4nycL+NyCL8q/ONEquC7QzS2ISK6Ei5DXpTZSlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrAkr0Nu7mmWe7fBgF5SR4RkF/3WIUz5C4MwXWu4OMHnSeH68
	70KKDxAcEIiOCzISRJ/OhtRC9B6F7bjXWGbzJ1xap7Y9E/HKrix/WHBv
X-Gm-Gg: ASbGncs8WdLYVC1eU1KOUFF7l5DJyNm6QVbVQ6HtEY1PjQP27mxP0OURePUbDcnPCjL
	2EDoBSiDNuH/FLy7R3ZPL5VRaf+ohOFUiTFt0+rH0hXR3NxWwZRYMEnb7d2234u6V5DIKGRPvoZ
	vxUmns+aLLmfSoX1VzLc+Y3PMp0L5YpszlbwWqECOiMj7lcjWyi1E//LwHQkFzkhdvbft7sDzHR
	hzcLnT0RcSRg1HDJMztk09kUyijFq2FOBvkzxi1G7+MeOUBhKeUgQ9abRcVr4DYmJzHDXu9BbRj
	6uvm6j9Oyr2z6/r7rjGkBv9PwbPhkseYNw0lUabtkQK0IuZUx55icUrMrzLwJQni3ZUMHCX4HE9
	TG6drIqU97CRz5phVoO6KDtoIrSefUpQEgMGgs3dS+TyvRb03q1Vfg/u4vtLHeWn7WrJhhaLoNg
	u6
X-Google-Smtp-Source: AGHT+IHdcY0n/ToJFT5WAUX7d8ExLtottZsCrLvv1FwdNHp2aDaonUKZNXv09EdyNfTU3Y8FBBxhGQ==
X-Received: by 2002:a2e:b8ca:0:b0:37a:421c:cc4f with SMTP id 38308e7fff4ca-37a421cdfcdmr491651fa.16.1762181808919;
        Mon, 03 Nov 2025 06:56:48 -0800 (PST)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a414d58b3sm937061fa.18.2025.11.03.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:56:48 -0800 (PST)
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
Subject: [PATCH v4 0/2] media: i2c: add Sony IMX111 CMOS camera sensor driver
Date: Mon,  3 Nov 2025 16:56:27 +0200
Message-ID: <20251103145629.21588-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Changes in v4:
- aligned to 80 symbols per line
- switch > if for V4L2_CID_VBLANK in imx111_set_ctrl
- defined INTEGRATION_TIME_OFFSET
- added check for __v4l2_ctrl_* calls
- removed struct v4l2_subdev *sd from imx111_init_controls
- increased num of controls to 15
- initiated ret values
- added return pointer to most cci operations
---

Svyatoslav Ryhel (2):
  dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
  media: i2c: add Sony IMX111 CMOS camera sensor driver

 .../bindings/media/i2c/sony,imx111.yaml       |  105 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx111.c                    | 1610 +++++++++++++++++
 4 files changed, 1726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
 create mode 100644 drivers/media/i2c/imx111.c

-- 
2.51.0


