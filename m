Return-Path: <linux-kernel+bounces-792919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC1B3CA72
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB263B3255
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8B2676DE;
	Sat, 30 Aug 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="a0ecjl91"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEB30CDBF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552524; cv=none; b=Gzt4z7vt9vADFGmt+D2UNDvEgMCFbsli3TBh1Stccml4dBY/OzJPI5VTtBr6+D2LEJe2WwYNemqrByv3EaDUgIKgLvmyRCM1RF91rYgUjp+SwNdak5ivGnpA2MIYGtW7/H0aamGNw2uSW60vPVumbREkgIMS1aRJnMZcK+D2dA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552524; c=relaxed/simple;
	bh=FcS3lVango2lJ/7H1mnUAZSXYOc30orPYr2Ga4jvAh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atx/ibiaGJKQ1CFO3lXXeneB6o15ZW2wpUiyyxqy/o5gcGMRjWrd59XvIQO/L2o+c3WO4832d/WUDEYx4Z7hulfkDj8xYruRZYDzYY7JfvObReQwSaAaJhoyyxS7xmteGiehSz2QB55/ARl7TK5Qhc64Il5PCd2T7ktVpkSS9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=a0ecjl91; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cf991e8b6aso1077061f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1756552520; x=1757157320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sB8nLNw7OUCAbqYw05qQ79tpzJtdnEdFbZCz5X3kyU=;
        b=a0ecjl91O3ccYBO2BFFvDPwZnsOIdcxSla/MUN8yobkdlazpGcpLPt9o+pTZmPixqB
         kV0Ky5IbWg9TpmLdKXMk5kD01IioJD9DeAETtRxCKVF0QLvHR0NtEq9BNKo96ekosXoe
         yVJMgUeULT889TiYLTy6QYhvJIzt5cQ8j+A3xQPhCqvdvrpoesaMNkV3+RJ0upaK4goe
         DTgtE5VGpzepukBo+VuwDX+urXqNFvJpbpXzxApL+V7+D2cZIBLqtTFwxSA5Tqul/T2S
         QZicjc23z8+r2pUcFGBmlVY/bZLHgC7VD6nBFZMQbpYHkEZ6p9rtisspe9QX2vEBUELj
         +7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552520; x=1757157320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sB8nLNw7OUCAbqYw05qQ79tpzJtdnEdFbZCz5X3kyU=;
        b=colmKoIFmIM+EQ7rfh1cf8tcKQnQUTXH6D13W3uuCo7bo+gae03QnJE35mIrKdw0XL
         OvPzbSB2TskE3vHByKauUMC9U8KpKqFU6kmY1WuU4cNMxSxatTNJ8KbZB6HNfgAJqpsq
         udiUCZon3HkjflVbROdoma6+F2rvKV4EDT6ALasVjUZa5A+qSYX0Bl7sJ2EQXasTHejK
         5gojv7GrN/yf5C4Mtmxr8vAmcMRtef4OCBBFW+mcsNEsm5SaWHKHej8QqDOPct87w2Xt
         I1sumUJDpcnWPE2KXScuv06krRkBzlYPODF1OrXkac9lbm12WjC0/QHHYaOUiGIDpbJN
         04nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+5trRF/WB7DvpQ7OHocp4Glfbnz3IZ5idmaaqdagsIWrcQiOtlfynOML0ash3Mtb5WtgLQeK3zov38Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7Uh/BrjE3nV1LoXHi0J+9wvh1EMlDubuCHFyjBzd1zvAKe9k
	sIES7w9wlhlydYq6RfC5OOI9+/qiBR/ZAX38anMFYMGFxiCRfSqv2iJLqlak80aoAZw=
X-Gm-Gg: ASbGncun26/jANHiVocHH99PamClV6rkrrh6FoHgrDqQW7bFmZiWgPyTqjnLT+c0/tF
	lrxtBwmguokwrimp5vzZueehkblulvu4O35YEluBGAtK8cz67lkTdPos2au2qn+SXmpfi0IYHto
	JAN2tjHELwC6wLQJKMx8Izd6NBUFFahbrgiLg6ZtaWRZkAk+B5RRWL2vK6Y9uu4KnrFHVBuqDEo
	AmIGg+O6Mteb9h+5vUY1hk+PW0K1mPvbrFIFQTc4dDb0OJwfYPruf3CKOZ3ks+sSrkcTA9uN02m
	GGBUX2QL9wF049XQb9ykOjmb6P0H+vN4FaC8I/3XhaChgTDhLtFBvmQM8yjn4gYjhwZHNAStFO1
	xblkgO9Ul24bcGVSlUpqnkR4iilME5fRiui92IjMFdcC0lBb6dv3+
X-Google-Smtp-Source: AGHT+IGx677+6au987cfOlNk+fioFFj5OQLwe6obAylZPfiLfEVfCRdytUkq11pyEGu2h8sIc4QKzQ==
X-Received: by 2002:a05:6000:188e:b0:3c9:fc3c:3a8a with SMTP id ffacd0b85a97d-3d1df53b1bemr1345860f8f.61.1756552519895;
        Sat, 30 Aug 2025 04:15:19 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:8714:ec04:28d3:3897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9c4sm6713630f8f.48.2025.08.30.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:15:19 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
Subject: [PATCH v4 0/2] Pinefeat cef168 lens control board driver
Date: Sat, 30 Aug 2025 12:14:58 +0100
Message-Id: <20250830111500.53169-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Pinefeat adapter, which interfaces
Canon EF and EF-S lenses to non-Canon camera bodies. The cef168 circuit
control board provides an I2C interface for electronic focus and aperture
control. The driver integrates with the V4L2 sub-device API.

For more information about the product, see:
https://github.com/pinefeat/cef168

Changes in v4:
 - removed driver mention from the hardware documentation;
 - added named email in commit signed-off-by;
 - added select CRC8 in Kconfig;
 - removed header file;
 - moved variable declaration at the beginning of the function;
 - removed kerneldoc from structures;
 - removed control id check as the core handles this for us;
 - removed Power Management Runtime (pm_runtime_*) calls as redundant;
 - reserved v4l2 controls in linux header file;

Link to v3: https://lore.kernel.org/all/20250817130549.7766-1-support@pinefeat.co.uk/

Patches:
  dt-bindings: Pinefeat cef168 lens control board
  media: i2c: Pinefeat cef168 lens control board driver

 .../bindings/media/i2c/pinefeat,cef168.yaml   |  47 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/media/i2c/Kconfig                     |   9 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/cef168.c                    | 331 ++++++++++++++++++
 include/uapi/linux/v4l2-controls.h            |   6 +
 7 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
 create mode 100644 drivers/media/i2c/cef168.c


base-commit: 2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2
-- 
2.34.1


