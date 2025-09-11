Return-Path: <linux-kernel+bounces-812070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3973B53298
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39BE581A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97B322A0E;
	Thu, 11 Sep 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC20Iulj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CF322549
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594632; cv=none; b=MAAqDOhoyOD+4zbQlL+NOHvVjNZ0l8vbuTrfq4Zz8mLwD2Pd5G9poS1zaugXbqsrPLPZWt1yp4KzjCNgbdFjRXi9FxPKga0knjEIDf9dT/GZQcpB/4XcHqU59GXj3Y6UKAFOeS0waLxa4KAD6Kb+U83kpcC8v5QXZ/eCa/r7ySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594632; c=relaxed/simple;
	bh=yBCaFmppglJhLccQJZKQZw4xpkp6mRE3c++kCJrg1T4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T31usS9sYQ9vIzDeYRdqHVLBiZnqPVo432u7FIv+RMjXftlXtpi0BvsPQdI5bJj5hRyImU+Met0d0rW1iJTWEucFBeknk8mWWGv8Sxx6wcukP8sgS+fcnmvlepygtdHNdIJ8V3mwHoH6kuwnY4XYrzfxM5HjXt36XelhOLPe2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC20Iulj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so502626f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757594628; x=1758199428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cxhDISSO7o9GdiN7Tbrubbnu3jZsi+4r/rV2Buvoow=;
        b=cC20IuljYqQV2E1OVFiHD/bavQVqW6fQtfzSVnsXI0do4A2lh5Y/dRd9N66jo6njWg
         ehE2cQm6UqVDG5U2puyU+DE5eVQVLtPu8609OQ31oGlxyLxyZ1Hw8CrgxE0tGZps/Rmx
         FTvMGnxjiFnCFsBGG7DpR60TGUcvceIbxzcGeZIEikHJ62huB9aX0xye+ommjVoVIM52
         RLflMkphUWMpgbXW4TMLQJUnSKkKkUAzkeO4b3TSafPJy49AwLqhzTk6Wg/Pd6Kvkcfg
         k/4kjVSmtM1SwNmoR1Wej6x7Mk1V48lV1xPSk0wI2BbylnOfSzHQ0kPiaCe+emJOXL9C
         n5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594628; x=1758199428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cxhDISSO7o9GdiN7Tbrubbnu3jZsi+4r/rV2Buvoow=;
        b=pSy/DPvQGRYPYGsnosGgHIsPrBXgB7qql1VzAcS8ITrkZ5FopTLwjWezUeM7Y3GSPW
         5oQ5BQ3WDnOQyZDyAJZHtXLQ0j2jeLIU24X/hhovwX17zVkbjsnK+XuJIQXKzfkEQypV
         yFBmvirQWnzLhWIKiegVGZERCift4aEwYMJv8D8+/24vU+o7UfFTqfxQwQJlJtCzipah
         2VXHY1ZM6wGdk6b/GU3LPFroSj9CDH02g+/C3LlKUWORJ3ZDvNwNFtJChFvPgBT7zzhK
         wlyV7wuOkdJxBv3+4J7o8giey8G7N38Ab419vU2DRmW/SSyiAM0k/AfgOiIQ5iJkMO7Q
         Nmjw==
X-Forwarded-Encrypted: i=1; AJvYcCW2l+h/OsT3Yjmm/63bSUJe3008bnoU8T0gCqDeq9nAkCk0lYp4E4kp5g5Lwc6GMx0KsQ413ERrDso2RBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypn5tmebcemikeXEgEJ857I6LAE8HhrC8zMBJyMoLIyXD7OZGp
	py0Nc+bYUclnhATAAl2OimlqT2pLj69bEvvl/zxvvL4erxYhgykRUPom
X-Gm-Gg: ASbGncttnMVtH9/xERvtVxtSNf1a4y9XplMbl111AMWh0hgzZr6lFD7hHI6jUQ4Ny53
	TsKTp46YAEX3jIMh1OD+J4BjuUryt3jzLegbA2YGvuCGnrXuSUXieLDc9JwWovl9yfG2ZYZALI1
	Z8zHznLD2siz5onJXBgT4sybd0+OGYKkXO3s/uvYMyPuddD81rifdaNmQjMbuSx8syHYqqsvSi0
	6D9Y1PG9dpTBl6HxMOpsbGQ9amYE8brgaKS2GJiHjpdIz+ZTbXAzPa7jx4u4vDDIMBVTb1JTEmB
	vRZ/QoRZiDsDqurgfSpT4W6bDfWZDfRcB+D3Ow/8GrtUFnfbxL+2/FO+FAh0VQMI5UvajSFBUMW
	0m46bj/L0PfkwxqRa/syZP5P8ts11WJeWYoEkQk+LsiJSJMJcrNz3t/GnaSqlGEZO3yolAJIDfe
	hR
X-Google-Smtp-Source: AGHT+IEoGaMrYGkJ4T3Yd0bCD2iHWWdU1nSheZhOJ5yRImg85hMTre/1891fZpRuN44sRaZK3S19rQ==
X-Received: by 2002:a5d:5f56:0:b0:3e7:5f26:f1ec with SMTP id ffacd0b85a97d-3e75f26f712mr2058592f8f.19.1757594627953;
        Thu, 11 Sep 2025 05:43:47 -0700 (PDT)
Received: from Radijator.localdomain (93-143-13-188.adsl.net.t-com.hr. [93.143.13.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03729c76sm22591495e9.6.2025.09.11.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:43:47 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Subject: [PATCH v4 0/3] Marvell 88PM886 PMIC GPADC driver
Date: Thu, 11 Sep 2025 14:43:43 +0200
Message-Id: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP/DwmgC/3XOTQrCMBCG4atI1kYy0yZNXHkPcRGTqUboD60Gt
 fTupgVRii7fD+ZhBtZTF6hn29XAOoqhD02dIl+vmDvb+kQ8+NQMBUqhseBat5XWip9a6x3XQOg
 seImOWLppOyrDffb2h9Tn0F+b7jHzEab1LZmFFIELXiqBClGpkuzO3y5UhfREE4Pb3B9PNokRv
 5QMlgompZDGAUHujSz/KdlHMUIulSwpuRJgvXHuKOGXMo7jC9fpjug+AQAA
X-Change-ID: 20250827-88pm886-gpadc-81e2ca1d52ce
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=yBCaFmppglJhLccQJZKQZw4xpkp6mRE3c++kCJrg1T4=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmHjjCqvGOawPdf5Hv8CzUbgakLgj+5m3bfW3vGZ/37D
 /5uZn/rO0pZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAiMk6MDNO2z/WpnZXS6OI6
 4+xRlrel6kIeGn3+h8vSrRaHGZsoLWH4p7O7UW1O5cPzGy8cP8hnLLFkvVXW2k1nF0uGZYrVX4u
 wZgYA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

This series adds a driver for the GPADC found on the Marvell 88PM886
PMIC. The GPADC monitors various system voltages and is a prerequisite
for battery monitoring on boards using the PMIC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v4:
- More refactoring
- Update trailers
- Rebase on v6.17-rc5
- Link to v3: https://lore.kernel.org/r/20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz

Changes in v3:
- Refactor driver according to comments
- Update trailers
- Rebase on v6.17-rc4
- Link to v2: https://lore.kernel.org/r/20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz

Changes in v2:
- Refactor driver according to comments
- Add binding patch
- Link to v1: https://lore.kernel.org/r/20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz

---
Duje Mihanović (3):
      dt-bindings: mfd: 88pm886: Add #io-channel-cells
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC
      mfd: 88pm886: Add GPADC cell

 .../bindings/mfd/marvell,88pm886-a1.yaml           |   4 +
 MAINTAINERS                                        |   5 +
 drivers/iio/adc/88pm886-gpadc.c                    | 393 +++++++++++++++++++++
 drivers/iio/adc/Kconfig                            |  13 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/mfd/88pm886.c                              |   1 +
 include/linux/mfd/88pm886.h                        |  58 +++
 7 files changed, 475 insertions(+)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250827-88pm886-gpadc-81e2ca1d52ce

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


