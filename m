Return-Path: <linux-kernel+bounces-849735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD8BD0C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E5C18909AD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1272356D9;
	Sun, 12 Oct 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+2PfeNE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238F222587
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302751; cv=none; b=jxWN+DEwf+Zf3DMqiAqWPI+PVw6WUUchdGwewIuBYJN18DhGj/9OxC5RmzpWK9Rcz5f3TQj8eg2QozuWkaYAbvZbzaZq9qibS76FMdgcl61Uf1JpHyJKP/F+IJMOvzd8AK2cH0l8x1KOCdXc8puPcakjGgYgK2vYrlCTGH8ID0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302751; c=relaxed/simple;
	bh=38374wR4c1uJvSMVvXDQmPhGU/CBaVy3CSGhgrzIsnU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=McspDKyY+6qWy7jU7iR2A4wlX3T4+vXx6Setr1hL/6jXBNNh6DnG3ltXNytUYiWAb67jmAoqUlQ5uaGsG4h84qSqsSzCOTim5YaLHtnGYWTXilZnnirzmy0ctD8h/u6ekoBwxqiBgA5t/8dYbw9D5tq6W/88sYK+GpVLl4Jnvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+2PfeNE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4060b4b1200so2363966f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302747; x=1760907547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yet0G9q2Nul7wE7O4WOA4//yyR5OUJOrXfjDFK6H1h8=;
        b=I+2PfeNESCDWUCa/bN/jjqKtA0NawJg1vUNerkC0l2WTkHDtKsuaEPc+I37Kg/eq+F
         YBjltuvaL4u69GPQj7KF2JLTZYbhA9Yq7LSVQ8J99Ws0g+1+8khNsOxhp/zWKdEPCVCr
         VPKl8DL0UxHQNF5hi0kHHsx/JFlU/k52Xvr5cofR4NQ0wjb3hTzaukpKxoI8WF8hRQsc
         rCVZLfIxwiyIivm8eUbeYaH9UNwBzH2sBXtQvYIb5M1OWEYQG4OH2ka36Gq9JxKO1Xd3
         5362a6BHlR1MO9M/x8NY+dwRMGA7KOioihs+eitnfsmbAyxOlC4fvy9NRdUpq76bmvKR
         uKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302747; x=1760907547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yet0G9q2Nul7wE7O4WOA4//yyR5OUJOrXfjDFK6H1h8=;
        b=M0V82jRhsilbPfZ106cbYhmmenCkSX8LNwFds9oOPrK0MSpJ0s0YXUBGij3DoNWUfp
         gHgxf4YjVNcaAsezB76mm8Y2pbY41GvzIA/OTlwZh7Dq2aVCgXZoxCbCkTPnClc88MK6
         U5tyzqeCvYphoiAL6giVoSSSxVE1VIfNGfHJcpXVNxqpCj3IKCh+mT2PZDk6xKY88eg6
         duK4JcBIqsF7oF7Eu8K3LicbniFdOIZ9veZjDfyU5fVoGC8Uu8t+wM6fGfzZb8FqQclM
         t0G9HuACF+1/WpV4bApBVvV1+prWrr69XeCE3v/Rs9tS+BO6IJNAERIQICKd85fMSCOG
         ICBw==
X-Forwarded-Encrypted: i=1; AJvYcCVcL7vBj/fxRCxcmP05QNUqB22zS4q88BMXx4gcZ225CICf5O9tC3pCwNGlHLdpla8G9pnQHp4qPmtDoe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnJJWFY+0xfJD5MD+YWtZDvhHMq+AlEXy8GsfBHXE/7cV3g6b
	iVWTvz0wNunhocpLY1IyJh76zgATERuSXERO1V0eRajKeBPvBcvh0leR
X-Gm-Gg: ASbGnctz/0vfM5Iwxfvc0nuAj4f6bNl6qTCj9zi7Qgrwo5qEz1tQVgpIG5HspSbfAZ9
	v3SUD5WbMlL6rNtve2GHnfzqqgj5yE/HwmRK0CeFc9oYMdWq2/iUWRXn8WDhcfk7wuOSGqeEvwx
	e51lPGmDawTU6pR3oHKZz4ckAKk6QkSORkBqTA1U/AV0KeuOc5GQfVqbAlkqX5Hg8HXnIZ7VT5D
	IIgP9ejKu7fAlp/pzNpTABuivOUW1vYZIJQn3RoccdXvpakq6HExDDyq8o6hgmRUoNksvs/m0oP
	waW6OivanYZTl94FfwTgV8Va/Y8Q7GwAMWbcxkW22qfQ+1U72D9JqgNOQqoy1QuQpfsCkYWlHU8
	R40D2ANm4LIpyE515qZ+pCILvwBRt6wQFaQQsz7e60Xcfj96hm0JSWUdocfNlcMKqNXzdhiGTLA
	==
X-Google-Smtp-Source: AGHT+IHM3xVI82jB6xdjQEkijldoJ7njelHhMDYQ3r3ZtWre4CsPi70ME2++am1YX6QlYz5/89FVBg==
X-Received: by 2002:a05:6000:2505:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-42672425b82mr11691189f8f.47.1760302746815;
        Sun, 12 Oct 2025 13:59:06 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 0/5] PCI: mediatek: add support AN7583 + YAML rework
Date: Sun, 12 Oct 2025 22:56:54 +0200
Message-ID: <20251012205900.5948-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little series convert the PCIe GEN2 Documentation to YAML schema
and adds support for Airoha AN7583 GEN2 PCIe Controller.

Changes v5:
- Drop redudant entry from AN7583 patch
- Fix YAML error for AN7583 patch (sorry)
Changes v4:
- Additional fix/improvement for YAML conversion
- Add review tag
- Fix wording on hifsys patch
- Rework PCI driver to flags and improve PBus logic
Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (5):
  ARM: dts: mediatek: drop wrong syscon hifsys compatible for
    MT2701/7623
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: convert bool to single flags entry and bitmap
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ------------
 .../bindings/pci/mediatek-pcie.yaml           | 438 ++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt2701.dtsi        |   2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi        |   3 +-
 drivers/pci/controller/pcie-mediatek.c        | 120 +++--
 6 files changed, 690 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


