Return-Path: <linux-kernel+bounces-829611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85216B97749
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D302E15A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A830ACF5;
	Tue, 23 Sep 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzkQmfUk"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422920FAA4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658376; cv=none; b=nkxYc4DZj3aYU1iifNVkfyOwMbcDlAnVys6LfYKMEJWr6gyOXoe37cIPlJQkoMjEi5pM47zOAC5IGxDF6nH1bBCroGVbAQaKxOVsAK32dZww6bRyzce9YuBU13tWmQvuWki9Vbik2iBpixnPAdxOvMAObs7a5j/Jujs3/sATP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658376; c=relaxed/simple;
	bh=jVddi4NuKKwdCHNaUyrNV2CwAkuZZSN+ouVB+z9jMuI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dWTS1/xbiSa6+w8XkoUCsoZCSE4DGGTNlAY1y3nVCoYqXKKytV/6RsSTmlROZyZdtTzm1kvTz1QJ9Fu3+gSKgvyfJxJjIK08GW6sbVV2q+PI0eJtLyDKBTm75DUrK/W1MPh2Jo5qz2yIbbITOhUt9MBgAz4bdhBNNMm8IwMwmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzkQmfUk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6805103f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658372; x=1759263172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASptksIfZB8nhWx3+GWc5qI39yAJwjp71gTOqcHHO80=;
        b=WzkQmfUkRVtH3rrdaQqgfMbfNiaMJpPVRDuk2mSe0OEpn9pCaNkG2UhxI623wbdYly
         fE2I42oQZfO7tEBiNen+EI9Uyxe+M9YNIbT19ROjxvAvRghiy6Aov3EQSct8kau/4cFk
         LCEDXdQ483p4O69B2AMObQ3sCtW/4qo1N6S8abUBJlaZ1vzEZTrAtYzHx8M5Fq+OOAb6
         fjJIu0mCXwiAhzn7KQh8FO500NZWv92HCdha2BZk3kd2+mDOouGaZQyT5ghvSBEXKBJF
         dUv1QD1ZFOuQxpD2EGo//SmArHie0M4DArpKVzQafmPVWxTmwjp9bAFAayDagq6wIC5U
         8owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658372; x=1759263172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASptksIfZB8nhWx3+GWc5qI39yAJwjp71gTOqcHHO80=;
        b=Edfnwq5XBYGCfDXobkXSdQrrFTLEG1i1/1IOqxsLQhiHO1YEM5cXQzqsGZUhLCaSy0
         56Ic96djDyOrhciekWrKQSbPLXDWUG9JwJ6vWM1g7bIacgzKeZY9BKS1jNrbPHhqKFnu
         SJmUAvAEsDFTnErCZpsdl7eIKMKJpFV3l/9MLCNmTKNAxOFbk91iStC5Zne4OBWJcQLD
         6w9BNIgzOB/cjlbiEwvjQTIOPAev4glHm0PtPOPtS1/lrk+HnZU4LxyscSzBH9BTwusU
         lUwWvA916UfzrM8jTNKZkR/oJ076QGWng3pcOF7dFkzcwV9gKIRNv1h7kLXjSOF3m4Th
         fOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsZDxJCE8Gl1sil/It+c6TzE1cyfCD7q2ye0rfnb0rOCAXgATmesxv9wvaZv6y6f4i3W/RTH/QeEB82Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rCR/CPVExQq7X0FwDI754QrUIFwdGe8InFD+22Qnlc8sov+J
	bJjeYA3IM8OzdnBJUKLhMUXy0ZkHDZZcxrmfY8yc7pgzYk6LLwBh4UJN
X-Gm-Gg: ASbGnctVJHcnTEvq/iMo8RKZFC+axezDmcbBhCrUDezH70VMrdcYZdHetmYgMI/TOJM
	jiOJXwiI9PiiE0U6KJZtqa77k0S2+s+61x0UId533RV+ftcF3ptgTNWVPAgn8CumHekjFKA7eqE
	HUvhnk76wzEfyfaBqAVX0tngV49ne4/Vh4OnkicIwRG3SfS/rRri+SHEOqAtF7Z0qa6dosTVyIS
	0iaODktA0MbH/Wi6RnunWS/t6qPnsw5C4159PWU+D+z1scV03jdO2qT9dAwI2ht9S8z+6FB4/Qf
	k2hQ8Jz3cc7wwFieEj7pudj8AYdqFUlmuFd5jt3d0b9EAQTIQwD6vJSdNnCfswcr5Kz7wzh++ZC
	0LNwj6DG26qFha4gcKJYTydawi4r57Pm2MKkV2QL1zrz3QdjjpEV2H5IpjGNueSCfTOC3AvI=
X-Google-Smtp-Source: AGHT+IF016uYkkKzgv+AucFeGyavBjbQS4X5yFh1cvwLL0BVsVqxRwdjObESQ21BrceSWNy2CAZxPg==
X-Received: by 2002:a05:6000:21c8:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-405c6d11630mr2007870f8f.20.1758658371435;
        Tue, 23 Sep 2025 13:12:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm24889690f8f.12.2025.09.23.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:12:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 0/4] PCI: mediatek: add support AN7583 + YAML rework
Date: Tue, 23 Sep 2025 22:12:28 +0200
Message-ID: <20250923201244.952-1-ansuelsmth@gmail.com>
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

Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (4):
  dt-bindings: clock: mediatek: Fix wrong compatible list for hifsys
    YAML
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../clock/mediatek,mt2701-hifsys.yaml         |   8 +-
 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ----------
 .../bindings/pci/mediatek-pcie.yaml           | 514 ++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c        |  85 ++-
 5 files changed, 755 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


