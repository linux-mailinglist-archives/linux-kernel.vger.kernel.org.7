Return-Path: <linux-kernel+bounces-772475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DACEB29326
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3791B23BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911D284B5D;
	Sun, 17 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="mfUsreZ8"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17923A9B4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755435967; cv=none; b=Rg4FPDRWPoRcSZ2K+OzTelzzfcnMTOyk4iidCnZZMPyf5MWNkegRtEShBpl+Jd9k2hFCpwIFtMOsRrLKkkJNTGMAZ9U1EF5l0Btf3LpISTe+havpio6fbaxi3E9i3mGrU26oS3X51Vvgg2Vjmd3EDqfokFBiPCGv2tHrWxrTFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755435967; c=relaxed/simple;
	bh=3PVQz1Npck8Dwovy/OX7P/UR/4Jfxuhm/zBlVDMlZZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WCgLpaSleDyvlqhGizgeL8t+89nocLyIjv5evt9DGACI+YljJpDeCBn+uNjJTQRD0MzHI1WnAme0bbeR1vjHhGmiBJbBi2x0QIVDtwn8rtRULRtf3GNFxpshhKnnuDKcObBVIHRGiSOSen4hP/Stc6frt39MbqI3bMiM2yda4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=mfUsreZ8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e4147690so2267330f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755435962; x=1756040762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+00MvInGtT/2ob9Rq8Xm3oOT1gPpF55RwkoNwuBCzSg=;
        b=mfUsreZ8VrW7YFhDwKFrIaVQdi++g2JN4tAf7o3zqt6SOm/CmMxhuc+PlPCXDWjQP8
         RiSP05NKSZTKkfVdLf2Sc8DpxVGNhMuOCBhxMARo/dN4EJDga9oMQale8LYZZtWdH4kV
         Tv+4Ni3UZ+Zt8wm1WaF2TI2WBvGwVkgTGQXztGJEEWbcn6pkRqtgT0lBgC+gMitaGWSN
         cstWN6WLZifJrYLYUflw+Wdq8IyoyesAhdiCRUx5UhakpqWZ/zCqbJ2h05Stolx83Aqg
         p2z5k1j2Gab8I9ZG9gGbKffMfq8Fxe1/ZdrYkXbXIIVtDUCd22vCE/at1FqbL1ruTfEw
         Zc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755435962; x=1756040762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+00MvInGtT/2ob9Rq8Xm3oOT1gPpF55RwkoNwuBCzSg=;
        b=TESNenNI5wUSp0MKEEOH6r0J747MdzygCgmQ+LWcH3C1n1j/8upTWerUtq67OD8utw
         mniCtE1HR/aw4YECdxU2QMyys3c1fP+Rjc6j2clZH1mzWe5q9Ns/bSyKlOv2uvs67CTl
         uvYwJR//DbJBmwF7oe/2HmANyoXEFutNsWos1qsQeKpBzV/kMSTa3hnexDrMvoB/ybRh
         Ee6M8Wtbrv/zzXBVeSyzXnInqIlbGs7eYU7WLs2aHRiKqrpq2zBj71Vm7MzvdQD4bFbY
         7g2K6agcAvEnI6+RG1WET0VqSyO57yeg7AzLqQRuoWx/SwjgY4PncS6sr+oTh5qlHCS4
         64FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv1/0Fmh8Pu4nWQrzVeuA1TynwHVb8dSY8DHbhhTyB8jZKDYCW9e+452RORsyRvzmGq3LImkH9nEvWnwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIXB89mlWGUyM14CYxdFEvxC7Ch1DMmu1vVoDaGXFJbU6GQtu
	2iiZ6wgnK09yEgvCluklW6Se3WZzpfor9dgtmh1J4HOQy+E/31B9SOGzXq+CnI1bgIXTMSZ5lEJ
	87rO3GL6HnQ==
X-Gm-Gg: ASbGncsHZ/dJG3jqrYTeA4uWE+2/q5tB1GNkV+zoBGLUxI2j0BY8d9AcTfUhYDrzH48
	NBBHvfRaURmP04cemyvXvZ7XUVyrMu7m8pRwArD0GLciuq3iAQLoOK4e336nvhGIzV6OUv9ZDPI
	zXV3EDvA9CVM+9w2NsiAD8cWBPFAjqjY8E5bCivY0nFJic1XIdpFuMHow5bdZagoAJhF9u5OtQz
	fBBJ+gpgNScb2p7VaLnjckBhLTDg9ER7Ar1wpy0OGq1sTX2iwWyf1Nm0m2MDv5EmZhbwzmkB8Jc
	sxnqKUnWFzelZTyetCUdLVWDY1d8l8GQuBjJM03xiW5iuCdl+EMIq1VY5ToontoBd++7Iq6DUyy
	xifyBP4GoPvcUAXXcLTCZd/NlGqK6/h4dengy
X-Google-Smtp-Source: AGHT+IEBquoYzqH1BGvf/UZy7kHktiJyWv/AzngI7aknei31lWrO45ZcaBJaFyvTvIKsx0U0NI0g2A==
X-Received: by 2002:a05:6000:4287:b0:3b9:16e5:bd1c with SMTP id ffacd0b85a97d-3bc6a55e8bfmr4038608f8f.31.1755435961484;
        Sun, 17 Aug 2025 06:06:01 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:b4c0:f0fd:db4c:31dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb93862fe7sm9235729f8f.64.2025.08.17.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:06:01 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: [PATCH v3 0/2] Pinefeat cef168 lens control board driver
Date: Sun, 17 Aug 2025 14:05:47 +0100
Message-Id: <20250817130549.7766-1-support@pinefeat.co.uk>
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

Changes in v3:
 - removed vcc-supply property and example
 - fixed incorrect type in assignment
 - fixed cast to restricted
 - removed unreachable code
 - changed comparison to NULL
 - fixed indent in commit message

Link to v2: https://lore.kernel.org/all/20250811213102.15703-1-aliaksandr.smirnou@gmail.com/

Patches:
  dt-bindings: Pinefeat cef168 lens control board
  media: i2c: Pinefeat cef168 lens control board driver

 .../bindings/media/i2c/pinefeat,cef168.yaml   |  48 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |   8 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/cef168.c                    | 335 ++++++++++++++++++
 drivers/media/i2c/cef168.h                    |  51 +++
 7 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
 create mode 100644 drivers/media/i2c/cef168.c
 create mode 100644 drivers/media/i2c/cef168.h


base-commit: 2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2
-- 
2.34.1


