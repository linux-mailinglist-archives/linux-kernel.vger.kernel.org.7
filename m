Return-Path: <linux-kernel+bounces-890712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B0C40BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0927422F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3FD279DCC;
	Fri,  7 Nov 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8QUOnoT"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A31DA62E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531399; cv=none; b=d+rU9m6ugpSf1OIkKk3ohw1QCKkceW7Ed+hIqfVTrOQoJ9Z4ayqCk1G3advoE8S32/FepcupXy8J9s7Z94Kd1+vPAkSfqVou5iB0CRXw93yVfwqC5gvrTCFzfcTjUEaOqgdIjM4s12UPSqgfHaT47jNr54QQwkmxoo6L7gDt0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531399; c=relaxed/simple;
	bh=qCFwJ//QhW/B5vWuFPp8cHMYPh2YmCgeRVCEaVYhBjU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Pw+eCj6h1nc3ViLYC3KdYlOwuKXv66VkJn/uPFVZrJSIapEiOGzIR2UeohCxFjWpb8k+enUzeFCpVJdG8iwsCT+JymS7XJRmiEqaypYHErjJBQcjCZuwuGG+OAruqxYslbJZG0AYlmpr9mGL90MhQOpLf0X43aJSzeIXOLGcFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8QUOnoT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so716195f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531396; x=1763136196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0mDULtyLau81Hx7l19RN5NkHyi5+qJVHhgWHezFVzM=;
        b=G8QUOnoT+WfrC+0mg3sxXah0Bi8dGewgekCyk/tQ3+xu3RMTYgkIPMDUdDc023EEyj
         kT6bTofIVTSfqFy9J0WS+dPFWYLNtVD68NsfSXQbuoQ7AZWMtB95y/lxtq6V+ru0pwpP
         EIxMkYDTLan405iz0OVjOOOVQOJ/c89FxE59bWkFxxMKXwwtI4tL/CNkcYDelcUhhnkr
         cdSnqhnEcQ5yu+Exe2Ufpsz8PvsmQlmRF7Yii9Gz4RhBZzWtxHsVfg5r7n4ol34V/vEO
         FZfOLgYsubyJ4E5BEItfgsepJKnGVd0fM0qwhCR0CXKIECg3mfvUQI9fYsp9pM/Pfk+X
         aFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531396; x=1763136196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0mDULtyLau81Hx7l19RN5NkHyi5+qJVHhgWHezFVzM=;
        b=wDwvw0vW5d7SKIpnxZpENpKxLBJW5Sg8SCoj5nLVUGJlCOD2zyuOzYHvFnxLYyOAps
         UJLhhA/pJ9FDw5PwodKeRXiWcrc5cm1dW1JHoJRY3o2FRywV2qLXX8+FLGno+8/08Gwp
         qAyv8HzJ++tO0gPaB4p0VCq02SeTgyx0UkFxQ5sxn+H8w3SWxSbjcG1QO8U5/CXh2imC
         maD3OWFlG3KLeLVnlIBLuicJByPdu/P/E/OUoEbAX1fPt4gp3UHUg1KLuVkbvd4dbUPT
         DbzvMPyz3Os9Ahy/HBWPSRKi5vPA/QJra/DgcXUlBG+WlI9h8WF11PK52k3Ker0m2NBo
         ovVw==
X-Forwarded-Encrypted: i=1; AJvYcCXvNK2zyb3gD4MysCMwaY195HQ+5TxusGwarFGoLcjabNJ9n4jxuvPcCReaspVCZTtzKnrUw3MV1PlY3D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSDpmKsyn5mSL1nWVEpQxfLJFvTD2DMwWNjFZDtCIOfODUQ5k
	g8Wwa9mHp4xMoS+yBC4ccpmS2XX0O1FTB0qnd+o2X6HPfv9wWFzHvJzQq6nXXA==
X-Gm-Gg: ASbGncttzXwSDhtHcugVxeUJg9C6eqnyLOAZFSMiMpZm1wEQQHDoYSqXqUShuA1KFr4
	zIEcTS1XV04PaehDd0STRYW7SaNdf5C225rjyYoezZQkP7cGAvPCxQ8WO3B8S2rveAmf9gsbLf/
	ReH9G8Oarc9RifUp+kG9z8ODlJ2eisC17x+9ruMC8IJmTVs64cHIEJLxohItqvxh4ytuSMkNLv7
	PPCISfKJpdEKH9hdIUgmPjo7RTbEo+N7h2TXzKUUgzRGx4YA0Fq+tLqvNl1Zo5SBcepsKePQlvL
	/0qdG2fTpvbuV2WrTE7qMJILxbsak3NC84Ijgqzfd6U84hTzROCtiugzei0KqkrFdBsYjj3SK7C
	QU7WhLpPGWZ+XEWC+hnXndt7N0Pr9PIrJfE63jJ8DPDP/LUKgW8UOAb1y+pPauMDVgcLs4g5601
	GITAikE54nyBe9QOQ9URfVnv15/DIF6Q==
X-Google-Smtp-Source: AGHT+IGWPgmkF6Tn4YlpwmubMBI4eBl1r/OcD+5NjkjCWh9jwtlH3q0sR0Qg5xX/PiNPpj2joJCdKw==
X-Received: by 2002:a05:6000:4409:b0:42b:2ac7:7939 with SMTP id ffacd0b85a97d-42b2ac787fcmr514536f8f.3.1762531395848;
        Fri, 07 Nov 2025 08:03:15 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm6058016f8f.19.2025.11.07.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:03:15 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] airoha: an7581: USB support
Date: Fri,  7 Nov 2025 17:02:42 +0100
Message-ID: <20251107160251.2307088-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a major rework of the old v2 series.

The SoC always support USB 2.0 but for USB 3.0 it needs additional
configuration for the Serdes port. Such port can be either configured
for USB usage or for PCIe lines or HSGMII and these are configured
in the SCU space.

The previous implementation of a dedicated SSR driver was too
complex and fragile for the simple task of configuring a register
hence it was dropped and the handling is entirely in the PHY driver.

Everything was reducted to the dt-bindings to describe the Serdes line.

Also the property for the PHY are renamed to a more suitable name and
everything is now mandatory to simplify the implementation.
(the PHY are always present and active on the SoC)

Also other unrelated patch are dropped from this series.

Changes v4:
- Rename PCIe and USB PHY to AN7581
- Drop airoha,scu (handled directly in driver)
- Drop dt-bindings for monitor clock in favor of raw values
- Better describe the usage of airoha,usb3-serdes
- Simplify values of dt-bindings SSR SERDES

Changes v3:
- Drop clk changes
- Drop SSR driver
- Rename property in Documentation
- Simplify PHY handling
- Move SSR handling inside the PHY driver
  Link: https://lore.kernel.org/all/20251029173713.7670-1-ansuelsmth@gmail.com/

Changes v2:
- Drop changes for simple-mfd
- Rework PHY node structure to single node
- Drop port-id property in favor of serdes-port and
  usb2-monitor-clock-sel
- Make the SSR driver probe from the clock driver

Christian Marangi (4):
  dt-bindings: soc: Add bindings for Airoha SCU Serdes lines
  dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
  phy: move and rename Airoha PCIe PHY driver to dedicated directory
  phy: airoha: Add support for Airoha AN7581 USB PHY

 .../bindings/phy/airoha,an7581-usb-phy.yaml   |   71 +
 MAINTAINERS                                   |   11 +-
 drivers/phy/Kconfig                           |   11 +-
 drivers/phy/Makefile                          |    5 +-
 drivers/phy/airoha/Kconfig                    |   23 +
 drivers/phy/airoha/Makefile                   |    4 +
 drivers/phy/airoha/phy-an7581-pcie-regs.h     |  494 +++++++
 drivers/phy/airoha/phy-an7581-pcie.c          | 1290 +++++++++++++++++
 drivers/phy/airoha/phy-an7581-usb.c           |  614 ++++++++
 include/dt-bindings/soc/airoha,scu-ssr.h      |   11 +
 10 files changed, 2520 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
 create mode 100644 drivers/phy/airoha/Kconfig
 create mode 100644 drivers/phy/airoha/Makefile
 create mode 100644 drivers/phy/airoha/phy-an7581-pcie-regs.h
 create mode 100644 drivers/phy/airoha/phy-an7581-pcie.c
 create mode 100644 drivers/phy/airoha/phy-an7581-usb.c
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h

-- 
2.51.0


