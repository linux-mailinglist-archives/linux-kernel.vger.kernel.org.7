Return-Path: <linux-kernel+bounces-859705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5FBEE5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FBE3A5E68
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11FD2E9735;
	Sun, 19 Oct 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndGk4N3M"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDB2DFF04
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760879133; cv=none; b=dovVW8kZEcuI4Bk7Z9GVCCXQMVan3K6vBKGUHIH2KXHgDur9XY+NG5woYKCepmCLNFn4VGaeakDG7pu2yVft+wuPhRX69a8SATpewm4US4uCOU6lTHZypDGtEHtFyUbM5EOAtcskuAnxGZCnxpWBqzd4QBNjYw2R7AoTqXDhbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760879133; c=relaxed/simple;
	bh=XeiX41298GHe1VGBLl245vB0i8bT1WGg++sJ7ssT2f0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VbmBnr93eHhYNdzcwO0O53GSlya0HXWj5oBuxY5HV8I0HhRN22+Ds0e7WgeC4kO6YQuPSnXpOg8sEijAabscrkG2FWMmrj4HNJsGRugjkafzcf46AJXdY6aQqhh7pgVacPDskGo4WV+OFnZ7zIfsLHLd9+1FE0zonPWEXajWzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndGk4N3M; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b550a522a49so2857078a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760879130; x=1761483930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eco81BCPWW5IMb7bDbdtrmACgQPc8H8S6TsCnyrvFo=;
        b=ndGk4N3MxpSwvVrzeDuw7GXOZcPH22K7lG4UWaTGsJgSv/A49SVXqUmKQv5Nu1NqOJ
         gIe5IUhPgFsRP3KFQF3V+LmHbrpyt465ckeEqtxT61E2Kxb/EUiyhxlhXN8u2G/XP4SQ
         fqiqppfFpJfmgTThb66vxMu5PuvHDJMfV2whRxfZDRKNN4Rl89k724JfxAx3a03+TeDK
         thij7AzUOat+j+WHJhOACnZIXOtJpLXyYeKGzvd1hgu2ANsgNzKP2Rtfo2kb8wRPXmTv
         cK3BJhTW9AWkuOLNAwqTA/GV84quIhF8mOi5TxIyRVpx7iSjFQPKXN2H2HkLMPhBNLID
         8E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760879130; x=1761483930;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eco81BCPWW5IMb7bDbdtrmACgQPc8H8S6TsCnyrvFo=;
        b=wFLtlih5LPQX6ENFrbH3dCCnq8s7Fg0yZDLQ6r9wsUX1tXrC0SCarY/ZMU+JUP//UQ
         I3gODkpoxizlh0GATrhWyQ2InU6v1jkfKDyEhimybQwKWaBGLkxTZ9q9bbp1y0JtMSE0
         v+SGeZ+HOBro5w5j+F9RK4/WExa7Da23LJaG+yWigTBIPaYjKHQtDdPeKxlteioEIZ21
         rYgdzuvA/A4I0W1TRrDaZQ4fIFP/73e5dngfvGgpxbqsfaH8P3aYAMQkTAa3KWiM7EY/
         +GmthUWUiUGDOL5K7Tl/Hc4z8XzyLIHKbu0qYlIhbHrsyTdqsgP9mY52ewUVdONC9Ynl
         9l5A==
X-Forwarded-Encrypted: i=1; AJvYcCWWrPIzxlfnrvsMfAQL0WUjWAfsShx2eQxbFzAHUQUL2YpgZlsmQAG+d38086s15oykqAE3ebTNbY+q0xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg340LLGCfj/VkA5JCBEATbfRl+E/WNhsk4IFZgTtK0CWZ6YlB
	C8JJrbCdTNPdHdwr4F/hYGFmvXCt+rk4C2B5irrMALmQYoEQpRMeMifW
X-Gm-Gg: ASbGncuXZ9M0W2e9tcnCYePjGoVEDrSuA/1PzJ1Ot1QvOVWsESQMwEb9zGwyCih/WQ0
	ZQDYnuOqwWnGYtj5Xap/hE27RjJTABHdaGazuB8fIfaYkgHBoIHNSI0Aa8MJbRlBtJgGEbV53kM
	yVwo7rogLKlXUOOrzl70R2miQ/xFduk+8Y+Bt67YnahjtNM4Jorq5LYjpKqkS48+++EYMgxQgb6
	BBVCZsrPqR86J59ElWjx/+Mp10aOAEcID7Th7lhWMOuS836V/unIP477LPOe9sPDEO3jgYBSy1n
	v5fZiCpPnZatb0giQlV/6mXFaL5CdqLUH8rgXD6Uj4AFQTR3qkULv4CKsBD2w6ogTF6VXR1IZU+
	c2WrLFqDCrmx00jIQ7fti6itx8ljPUz3TaC/4UByr27ozZQyCi5AdL/bd/ES4vzx2LCGQoPMHTj
	BTrIAd/rVsdP8e2t7Y8GQi3vnxvWTzlYf+JJHIO1ig0SzU1A==
X-Google-Smtp-Source: AGHT+IE/NeeSqi4ivYvwA/AtfAx8j3c+jGg0ZuqE8hIvxZZL3v91DQ4eRBI2Fd2i+xXD/lVzrMfA0g==
X-Received: by 2002:a17:903:1a4c:b0:27e:f201:ec90 with SMTP id d9443c01a7336-290c9ce63b3mr115807545ad.25.1760879129895;
        Sun, 19 Oct 2025 06:05:29 -0700 (PDT)
Received: from Black-Pearl.localdomain ([223.181.116.113])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5c33sm52842425ad.73.2025.10.19.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 06:05:29 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v4 0/2] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Date: Sun, 19 Oct 2025 13:04:36 +0000
Message-Id: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTh9GgC/13M0QqCMBTG8VeJXXdiOzq3ddV7RBcyz/RApjiRQ
 nz3pkSFl98Hv/8sIg1MUZwPsxho4sjdI438eBC+KR81AVdpC5SopVYORoZYNZ6ha8senDTB5iY
 YnUmRTD9Q4OfWu97SbjiO3fDa8pNa308Js11pUqCgcNoXRKU3xl7qtuT7yXetWEsT/rSTdq8RJ
 Bh0aKyTucWw19lXK6nUXmdJu9waCliR1u5fL8vyBu9zwqYmAQAA
X-Change-ID: 20250519-ti-sdhci-omap-907f847f7530
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
property typo for a DTS file.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
      disrupt the compilation for other compatibles as the node &mmc is used for all
      compatibles for some DTS files.

Changes in v4:
- Removed type for the property pinctrl-names.
- Link to v3: https://lore.kernel.org/r/20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com

Changes in v3:
- Reverted the changes on removing ti,needs-special-reset, ti,needs-special-hs-handling
  cap-mmc-dual-data-rate from the DTS.
- Fixed a typo to resolve the errors identified by dtb_check.
- Changed commit message to justify the modified changes.
- Defined if-then statements for compatibles to add required properties.
- Removed "ti-hwmods" property from the YAML.
- Link to v2: https://lore.kernel.org/r/20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com

Changes in v2:
- Changed MAINTAINERS to "Kishon Vijay Abraham".
- Renamed the YAML file name to "ti,omap2430-sdhci.yaml" from
  "sdhci-omap.yaml".
- Dropped unnecessary or unused properties from DTS and made these
  changes as a seperate commit as there is no user of it.
- Removed previously defined properties like ti,needs-special-reset,
  ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the YAML.
- Changed the commit message to elaborate the reasons for modifications.
- Removed the pattern property for pinctrl and redefined it in a regular format.
- Modified the description of the property "clock-frequency".
- Changed the subject line for the binding patch.
- Link to v1: https://lore.kernel.org/r/20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com

---
Charan Pedumuru (2):
      arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 -----
 .../devicetree/bindings/mmc/ti,omap2430-sdhci.yaml | 201 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts        |   2 +-
 3 files changed, 202 insertions(+), 44 deletions(-)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250519-ti-sdhci-omap-907f847f7530

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>


