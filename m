Return-Path: <linux-kernel+bounces-728932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AFB02F2D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D691F165F24
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC121E3DD7;
	Sun, 13 Jul 2025 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3UQf0gR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AA1367;
	Sun, 13 Jul 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391123; cv=none; b=uJaPFtbZ3wwHvpe8FIg5eH1BK8hEoyJke4eOvNNe34DTtxqUb/s7bVsHyJKsjVUjE5NBhiiDS+8LoTUbyvtp+ONl+XQhegIGHnDjv1YxJqki43CthGfyJqQMyBc8HVQyKYK9T5TRom0O7RQ6jeAageBdUHeQZpIWP8nVvBXIrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391123; c=relaxed/simple;
	bh=1Q9A9kg0pX0yC/sSXQOLv1rrq6aBql/zwdnClsL0lMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9WyhfrbdeoSn7DdGV7F1XVENaKttHqazbOw+Jnm2M6hjAq+e0YjrRSoDP8bvUOudKzQYKoA5bmoRDxg+feO4Yal9d8WAz+j0WAihr/EUxmDhgu6iv4S/PTEItbg8+laFQJaboG36XDLq1jOlIrKUijn1DS+nS4ya9txE8Bgxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3UQf0gR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2349f096605so42507165ad.3;
        Sun, 13 Jul 2025 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752391121; x=1752995921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8iEoc2uU7W/q1tX4t5cIJaVpHEPPrz157ftcbSlevc=;
        b=I3UQf0gRsOZ2waQLbATyj5wY0RbdAyzt9lAHbFe81/JxE44Dx2GmERWy+U9gwd1XDF
         MZ/oTk0jYAVdLciAdLnMg5/oGM0jm0LtbtMGtcUwAGgyn9RosuDagtSSavYhId3gAeDU
         HR8y/MXU0TCh1yxTsGuzrzmmysf+HpHNzPVip3HePgZk/apjEwjOr5Ko0/iBg4s0a4/+
         bKlsdQHYBYwREU/tXao+Zmt1dD98TObmbMC8LhgBzAvgkErhdcM8oWJRi006p98x9XUg
         j31NadGvz0KRHeG0bQavM3VLGvzCesarvKe7ha2idzAWwMUlYVFNYPHNxf5que1JKLWd
         2XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752391121; x=1752995921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8iEoc2uU7W/q1tX4t5cIJaVpHEPPrz157ftcbSlevc=;
        b=XBEjLAc9KWvLR2EBPo2IXQkYomtxpYg4dpHwvtOO6JbA0t8r/aEp+f7iVTKrBQ/TEl
         6SNEudtIh8wJ72J/TvxLQ4uFagmFMqMAR2ASHpoIzXMx4T1ljhY13HhIMHfCE5Gt8zLs
         Iugh5FnvOJf+SXaEWZeMdaTKXtu+0OgpC/pirKYABNfXZcnHggTORDXMFGsIbc4/HWUx
         2zaP5f0OLW005K1JhsRFXgcBqNt7QhDqRYnX3UqPP8U1UXvZo/mTaMytlVdv1lhIxvnK
         iWSFFOpsuJ8+XNlCwRDRC2hD1WdNLo8bUfB3aeSlaHZuiNwUUFIEMxJoddD/cwMx53px
         RV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrI+NZ5ZfrrXVkWSL99nxAqF+zcl+weEkgFDyoMHVuAdZz1wUw+my1/4eZ/63/UxNLOAL3iE85swWIag7f@vger.kernel.org, AJvYcCWQXUy7OgbH7JJyHHQcr+JPNhC8M81JW+K6GM3rkaja2/6WdutRx2n02CaL83QegS9FgIe9ey3wCVpo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tb/SsDX/EjFEB4J2J+l6S1UzAvqPmzEU7dee9xKGhUwWK//N
	s5olcgGnT6oUjNO08o2qMzfCdSOrxHcYrmWW+8IG8Phka01W+e4zGX/6
X-Gm-Gg: ASbGncu4Rdsn6wcuxyLJblK3bl2rovHPt6JYrILjWJ6bthUffw9xHT6zQKPv+TJ2yh4
	naWjYs988n8e2OWYGLNRPptlhN+KMucxn7Ib1ttq7vJIqMyP/QpDiZOqkEF93Pnvd1xz8nsUqk8
	kmh7PAD+QbhyBwAb76JCd9YQm+DsgBx2B/4WqZ2BI4Q3LvgUlNovTOiU/4ec8QfnEYLhJ6oyynd
	GcGrD15BAfQcl1FN8IDlGGAvjJBZ8x11KA9ATY2UgmIy4u2q4QIo/kN21N3Pxl0/U7myxmYX4f5
	JuBgWDOnGIxTgZpPh1Hlb2HDYblZHSbtxdyiAKqUsyOtZmNxY3x9wNXUTTUs92F1NdlOCosc09U
	vFYGN1d0dXbw5SP8s9VRgJhhrIQ==
X-Google-Smtp-Source: AGHT+IG0KLd8yfzGyoXZUigbZcNtL8cxyc/w8la5dRaxk509Eh7aNMlNV0ydaIjCmRmAbSPzHPZCJQ==
X-Received: by 2002:a17:902:db0b:b0:234:e655:a632 with SMTP id d9443c01a7336-23dee2859d2mr135779985ad.51.1752391121439;
        Sun, 13 Jul 2025 00:18:41 -0700 (PDT)
Received: from ubu24.. ([2400:2410:dfca:c200:3d5e:f962:c950:134e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322db2sm75239065ad.100.2025.07.13.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 00:18:40 -0700 (PDT)
From: Taishi Shimizu <s.taishi14142@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Taishi Shimizu <s.taishi14142@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] ARM: BCM5301X: Add support for Buffalo WXR-1750DHP
Date: Sun, 13 Jul 2025 16:18:23 +0900
Message-ID: <20250713071826.726682-1-s.taishi14142@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Buffalo WXR-1750DHP router,
based on the Broadcom BCM4708 SoC.

Patch 1 updates the device tree bindings documentation to list
Buffalo WXR-1750DHP as a supported board under BCM4708.

Patch 2 introduces a device tree source file for the router.

Changes since v1:
 - remove `chosen` node and `bootargs` (inherited from bcm4708.dtsi)
 - replace `label` in LEDs with `color` and `function` properties
 - change USB LED to use `LED_FUNCTION_USB` and added `trigger-sources`
 - reorder GPIOs and clean up button node formatting

Taishi Shimizu (2):
  dt-bindings: arm: bcm: Add support for Buffalo WXR-1750DHP
  ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # for patch 1

 .../bindings/arm/bcm/brcm,bcm4708.yaml        |   1 +
 arch/arm/boot/dts/broadcom/Makefile           |   1 +
 .../broadcom/bcm4708-buffalo-wxr-1750dhp.dts  | 138 ++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts


base-commit: 379f604cc3dc2c865dc2b13d81faa166b6df59ec
-- 
2.43.0


