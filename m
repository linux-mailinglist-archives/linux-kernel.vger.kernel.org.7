Return-Path: <linux-kernel+bounces-731698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0FB05869
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9C564B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD8258CF2;
	Tue, 15 Jul 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkXW37NZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBB2D837D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577495; cv=none; b=KSi+jdxeDaC5JQo1jCAPOv8pUhvVAF103iI39nMyu97DiXUVCfWY0hXmyCG9rSycjy2WRwYExWJw/ZdddItpsuPoAKiDoPgWL/KRwcankT+lwxWLRxrn/Gr0GAkW2/4LS2WdDwszEAtGUbxvesAp2vPHM3hestUnx227lSlZhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577495; c=relaxed/simple;
	bh=p3QGp6MibxuVev5xgCfzB8TWg8YFWN6DNRGpzchTuBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTgIp+8wyAGAEaHjXnNkjaqmFa7XcVRqrHzNgM5w1QYD9x2ZMTgAfCCgyY9vJ86YCP9tbla0GXx9DR4vlfB4vWe4XV8fN6eARAzHHTQp3NwgvwnmUukIOu3+fNvFGLkCFObUiav79xyFTFdWw9XcmVj2cjIEGc5UBPcFPcNFCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkXW37NZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752577492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VWMAjYtNhkJh5mbP6XrZahkgyK59U5VmPrOphqHUics=;
	b=RkXW37NZlEj8kRdqqx7h8e93L1ZUa4fGx3SvHzcWL2QNcReB0y8x3UdFb3NLnBVm+bSQR2
	cmUIHtccic8IO1jHUKmDSOLzqcQdJpj7Ugm/iO6ZxZW4h4LEqTopl2kOupKFok6FWRFx7h
	+k7uKJw9ZRcMrncc4rFnTL6dxtQljNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-V4pNkSlXOlSBAyl63-BIDw-1; Tue, 15 Jul 2025 07:04:51 -0400
X-MC-Unique: V4pNkSlXOlSBAyl63-BIDw-1
X-Mimecast-MFC-AGG-ID: V4pNkSlXOlSBAyl63-BIDw_1752577491
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2622408f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577490; x=1753182290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWMAjYtNhkJh5mbP6XrZahkgyK59U5VmPrOphqHUics=;
        b=VogNeC/OmsQ2m1Qor164W/idXvTao+OKs8qURB0rZVHqmx1vW/g9HzGnGjLfJZXZFy
         Ta3UefS0OqLlkZOiS4uBj1rHLWcEzHM56NWobpp3zGZRaFCQjdDVV1tO3z6/IOkMb0DJ
         vQQxR/w6SowNE2TgrL2xHprOI8nTaSaMWkQ5RI0Bwzp6tf6chgSMkjLrPwRV4WG4eiL6
         uAPISqqrPIJOlrd0P67JIJyNoKh1yySFTbQ4/iaFyIscNszbf36uMq2vIz1dNV6RxTzs
         lJEM/X+i8qSaS0O/SqlIBpZTAsos80ZcbB2RoPGbhpdA4JzzwY5bxxywv5Vc0B9ux6pF
         lFew==
X-Gm-Message-State: AOJu0Yz4it+9cZbdgSQVNt3PLkJ5yCDW33eMNGerBniuNwIYo163jtvo
	OzU4FlxOy/ayBUAcH3sfqD3uZM2Zx/n7tq7hxb8YpGFl/x+68fmXqzdbjMBTZPs5rR5W03YsORm
	1B0r6FKu+OW/M7lNICMd7S1SEX1c7LMsST+c4S9G6NoQtQ72PfofPgegI4/yP/t34Rzuzgpzr7o
	hEpVOmJjff37lCwaF7H+Cku8qHgVtyeWrSx993PkJwSExGBxF/
X-Gm-Gg: ASbGncvUIjLejU7+8dB1HD9k18Gyni2hJSh2zu9yF3zBxeJfZeo2PAPECzEoErCXi84
	PJ+yAtazpl3+d2tdxltocfU+XZHMKPGVbpMqaKEOEqwnhv+xbecQaotgLsEFsBwS+0Ks2FMbLCJ
	8XUMF581aITcaiLnlhuIMcg3OYgBmER+r8hgb6CypBvPJeAb+2gCkEc+Vr9p65lNubWnBAmXK5S
	lbq1I/lkl7ceL2c+yYCag+SdnnvfWgNVQBf3Jos1ixVxLw47oK7YgJJvIbV06MR6oZMEly5b+q6
	adA/Cnw0rDVyoDB6cWpZ52IP0mi2wC+8
X-Received: by 2002:a05:6000:2003:b0:3a4:fc07:f453 with SMTP id ffacd0b85a97d-3b5f2db184cmr10464904f8f.8.1752577489701;
        Tue, 15 Jul 2025 04:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl07y9vuHH7yDtGi3ONbzAtFfjZ48gg7A4ezv99KtO+nnd+7i/98kznjmeFhZWjFWsfGpUhA==
X-Received: by 2002:a05:6000:2003:b0:3a4:fc07:f453 with SMTP id ffacd0b85a97d-3b5f2db184cmr10464856f8f.8.1752577489121;
        Tue, 15 Jul 2025 04:04:49 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d732sm15109798f8f.52.2025.07.15.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/5] drm/sitronix/st7571-i2c: Add support for the ST7567 Controller
Date: Tue, 15 Jul 2025 13:03:49 +0200
Message-ID: <20250715110411.448343-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-series adds support for the Sitronix ST7567 Controller, which is a
monochrome Dot Matrix LCD Controller that has SPI, I2C and parallel interfaces.

The st7571-i2c driver only has support for I2C so displays using other transport
interfaces are currently not supported.

The DRM_FORMAT_R1 pixel format and data commands are the same than what is used
by the ST7571 controller, so only is needed a different callback that implements
the expected initialization sequence for the ST7567 chip and a different callback
to parse the sub-set of DT properties needed by the ST7567.

Patches #1 and #2 are some trivial cleanups for the driver.

Patch #3 is a preparatory change that adds the level of indirection for the DT
parsing logic.

Patch #4 adds a Device Tree binding schema for the ST7567 Controller.

Patch #5 finally extends the st7571-i2c driver to also support the ST7567 device.

Changes in v3:
- Fix reset typo in commit message (Marcus Folkesson).
- Explicitly set ST7571_SET_REVERSE(0) instead of relying on defaults.

Changes in v2:
- Use a different parse DT function (Thomas Zimmermann).

Javier Martinez Canillas (5):
  drm/sitronix/st7571-i2c: Fix encoder callbacks function names
  drm/sitronix/st7571-i2c: Log probe deferral cause for GPIO get failure
  drm/sitronix/st7571-i2c: Add an indirection level to parse DT
  dt-bindings: display: Add Sitronix ST7567 LCD Controller
  drm/sitronix/st7571-i2c: Add support for the ST7567 Controller

 .../bindings/display/sitronix,st7567.yaml     | 63 ++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/sitronix/st7571-i2c.c         | 95 +++++++++++++++++--
 3 files changed, 151 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7567.yaml

-- 
2.49.0

base-commit: d5ca45b508916144d1e8be1102bedab405c1f6fb
branch: drm-st7567-v3


