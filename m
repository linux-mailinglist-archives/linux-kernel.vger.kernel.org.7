Return-Path: <linux-kernel+bounces-832855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34801BA0943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8B9387B40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD33054CE;
	Thu, 25 Sep 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRgbaoiE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE93054CB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817428; cv=none; b=PFQbxgZIiD8d/atBMzp6cNWpVuINEHJ8aI85A6URjf55PgdclZuIwpYUtyJJFVAg6lXC5A4ODGetge0beOi1J4Qh8+i4zyu5N+27XO/t6OM11SWLncuqiDL4JltciOLvTnc4Yz023DZ4HDNUOXqu9pS5DMyqgp3s2aFBGS2RGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817428; c=relaxed/simple;
	bh=gOo1rVsZR6VdqU5z395vlT+SO32oa08uQ/tUj6wgFd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TDi1O7/DWy7ExtzZF2075kPs7VYdJ+YyMHn0Eq+s3uaJvA5+NkMYU6LYSGrgznsoiY1/QqMMoilVWqchGxGLKT/KGD3U/OIS+m8M4HfA7SFoROCsWDNGLni+KEP16Tr1SHQS95Uy05UJgap+2NLsyEIFZlmSNKOiWd9quZM3Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRgbaoiE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1041870f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817425; x=1759422225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTyvmotOb0/PgMOHsXh4gvDuOiENNfX5B0XL/LoNWUk=;
        b=QRgbaoiEXx7xp7ZNWhKTDtac8hbujoKZUQ2SfmHyvK19p/gId2x095Eyjh9baRHkWR
         44Xli413yV5yhmVER/RqnMGDb4RQ8EwxqUGrVq1sIWQ0WMFYAVDonhrCKenFS97Wq5k8
         lwH2Ss46HmdcdxmTooGgvJVZYMH8XO2nFmFRr8V6DozhaD2po4XhWGPvFGpK0gFYaHNN
         BrMhdXO88rRbnbEXOfKLzB5snUpUER38cQr4Q0zeyA81+uAsCBr35wIL0MUAoBserXlA
         c/TutBxD3gNAMvj1Uq7FeZEwc6eJ2N1i51DNY5nIcy7POL2uxAhOekqGf11V6yBeaSPv
         g3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817425; x=1759422225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTyvmotOb0/PgMOHsXh4gvDuOiENNfX5B0XL/LoNWUk=;
        b=gEd3e/5RoCvakwkzwD0w8wBPovid6YYRtc6KMChr69rT5+3qmb9SmompJ3AeptVigT
         sbo3e571ZL9xXon+wl+yGiCyddY5get/WQ/2BZkrxsTlyxm9g/HzH+AcgC0V7TQJm99z
         oWzwd+tM1Vo7EILmWCUHhivMpTGkQRlyPyPld5N0Kc8YqhtzDpcjsSY0s3PBPV1GP7xe
         wUXn1DlwAqkrFm1eSdLaDxRBS9JcKIBSH5BPOfyhFj3og2+JDNj+nQGJ+ctjGyyLrZ15
         yv+meIhd6YCmvDx1HIbINb7vnFLKd0QPDdAK3dmrmRzJFgun43FhmlYY635x4Pm3nkYL
         MOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcPsoIPMZEXd27UtkLkW3Vwe+sxQ5wigSX51mjuq1sd0+ifpBT3zGXTmJJ9PFFejK3kiV5sDUcsdqq4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfMCmPZs6PkKpdr0uXu0Cqx2yIPsFDrIM4rWOh4NHEWnQj7nV
	Mj0HK8+8HmQE7tLvlfQ1FnItzW6TOrHagS1hZmEq9lIAa15ixLisj1Q1qykZ/Q==
X-Gm-Gg: ASbGncv+ejatYJPfPqWKKsF+LA8npJAKKXCDe0ARcBJCp1ir8hdWgwopUMZB5Fi6f5h
	bfD5xPhyjNWGtNA3DJvL2dKapK6rHEQ/W2MWI0AlFfZh+qBT4S8X179ryruBmWu0lob9zhaMZpl
	larXecOsbVntrnI3AW7GUSfctt1WgBpMOXvKNGDAfIJDGAD4JuSIu/XhMqsFldjsWCtZpEHBlx0
	KpmeqDrH/wl5n+jwuuIwuuB3v+9z07QrRYhjFM9Ds/ib4EQinTjbjtCspQ5LZxa2K2wDXhfS12P
	j0eQkrhxm8swYUV069WJxAiY8Wk5rHdkMr+wN1vjiZTkSunsx8cX2DorRraU1/wfxg5UHdaRyFN
	sa707ssd+hoXIYC5pWq/K0ZGnXpipuA2XO5LsZZ6GICW8ZX3fyxP0D3Ow+hu7OAxuKr/mo9U=
X-Google-Smtp-Source: AGHT+IG8wt7D2RVybhrtsXF08OvAI7r2C+qCPryu+R0Ya0aCRRAJKGzbWS2JdRSo8S3uobYjXYxcdw==
X-Received: by 2002:a05:6000:655:b0:40f:288e:996f with SMTP id ffacd0b85a97d-40f288e9f05mr2728379f8f.63.1758817425041;
        Thu, 25 Sep 2025 09:23:45 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm3534819f8f.24.2025.09.25.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:23:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v3 0/4] PCI: mediatek: add support AN7583 + YAML rework
Date: Thu, 25 Sep 2025 18:23:14 +0200
Message-ID: <20250925162332.9794-1-ansuelsmth@gmail.com>
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

Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (4):
  ARM: dts: mediatek: drop wrong syscon hifsys compatible for
    MT2701/7623
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ----------
 .../bindings/pci/mediatek-pcie.yaml           | 514 ++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt2701.dtsi        |   2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi        |   3 +-
 drivers/pci/controller/pcie-mediatek.c        |  85 ++-
 6 files changed, 752 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


