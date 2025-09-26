Return-Path: <linux-kernel+bounces-833704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E6BA2C48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432CA1893B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A428B4FD;
	Fri, 26 Sep 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K60Oi0or"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72228B415
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871758; cv=none; b=RFz6FbFnrJjpuAx1czja4MO2rInMgJxcLxwtBCsgVpUZkeEDztpi8WILYxujSYjT7G+HwEeTFMPOxEAiY1HG9+3OswUNdoFrPRxyxkNthgmnWvNi9cU+VO2r/6/ViGXgRkL8kNR80Mw2O5btgUf1eMR9rcXUuAdeNXrADEjwKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871758; c=relaxed/simple;
	bh=KKeLdXdxMAxZlR0cCMx0pVd79S7jNFLhBZQcQpx/FbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3Sub4RqvKWohBlkY+nlzrRu1EPcT2dlxX15ludgTGyYtB0m7dJ+gs58ESa94NJXKxQB4DujJi1Ba5CDG2ySpaBwCNOTZ9k49DlIRKAoR7VjBbGU+rdEO7HnKnhhA9jDIP4SVTiF+l6DwaVf+Mf7qWPFx8/cThcEhX3IyG9F/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K60Oi0or; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso1764474a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871755; x=1759476555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYEa9oczgUXfiwew8zKgW7hYIrVnSKo3dCzTihagGEA=;
        b=K60Oi0or+zeuFSRcfSW8SlDcSOy8uPXFPwzMAf5qQoPB80pri9tfrIDwjbgkh8SYeq
         2BQTdXCSBywy8aZ3361KKcxu7n8NFqmhUahbEh77zDC526ZLO8h6UxOJonN7tgKOYjwy
         7r053WIPNTbitgzAgHW8cXp6ERniOzs0vKtitG8pnEnEB5MKyp4BSQ4m1jdZY1upwSUH
         yI6Oy5CfZ93IS8ADUnvKJTq6o1KyszSvB20/bBttcj12RVMAZ/whBZXBuwJADmpiV+j8
         Ud9vcH/uDaDBG2DQ+5YhxyuXXciYBiQPVX4L+TdeQ6UjZcPaglgF9sYysJL9JeO+DS/i
         lNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871755; x=1759476555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYEa9oczgUXfiwew8zKgW7hYIrVnSKo3dCzTihagGEA=;
        b=uqB/efjRANA6vyu6ZaUDEjLvzqJk9uOvmkn6VvpKhPnsaIZy8KySq5v/OODNcQ+S3D
         sWwmzvLHTh7z3WptDrpNHYHeZyiC68vRTeK9Bm9lKMHKI3MkTBpy8K7o949IU1DJ1Wlm
         nm90/tEtHNLByAOjS/6ziUqIS5kA12EYehflkaikjE3QhkcBvDHlDjQkjPJXrx4G3U1K
         tBwyvUdLXnQmBGwkmDIEi8JfcImlNaSa2rJX4ZAWNw9jMYpesjx4jcLltSz2K9b1vmPc
         AHWuetarBQrzfkV3q6VSqoUFrV/T+11JNWvvneQq7ty+3RTTqhvlS7JVQyZ5zBGhEaVX
         Pkrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Iq7rRTE7QPI2EBWq3iSssU1k80HwwE4XIwb/PTuTgy7ygrphDSHFPikMvBwMbD7zlkIj98uYoucbK5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywu1JicxG1xzv2IlwFH6B5pHS9waWg/Vn09JZW40asbWykIFMh
	R7qwZydzAi8Kj4mMO/Fz2sxEET7+I+LIfa/QxTfZ5fbJBs+Ary3k2thO
X-Gm-Gg: ASbGnctXp2RhyZ9wr8tM5bCKBhYubo7pba+rTUbk+peh8D8lg0G+GOTWTDTRn8+1Uiy
	1dnQwlOQijgdT1B6Ri1Qbs9hYqCyZftZx/noVMsqj1vq12l35yOkB9fyiwW2Io1vPDF/uT/X1X9
	eQDRAHc0e97eP+hufnsChyf1KFODtXSLwF6ZZI7lt57ftOk1SIZ9pLcslPh9a0dlKoYmdO5GzJm
	0JR0AqpGk5PBo1BLM9yn0kUrYG0i6b1CmunqnWhmJWkpJEAPrjc/dmJy1tfbKKXVxaPj4VDtv3k
	J/DomewTWM/ER2YU9KivW0CoWbasRkhvcmKIyzIF+pysRX9OdDyF882OJEdow3xm4U6MgdGcXeu
	9i4CLH8MdcQHcsucm3n1i
X-Google-Smtp-Source: AGHT+IFnyJDdAuSLIa/C8964VsLcbnuC5hHMVE2YI+68PeLlsmcnEA8Npkepb0UD0ObLZTs0q3j5XQ==
X-Received: by 2002:a17:903:22c7:b0:26b:3aab:f6b8 with SMTP id d9443c01a7336-27ed4a603dcmr74120275ad.58.1758871754907;
        Fri, 26 Sep 2025 00:29:14 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a98b9sm44083065ad.111.2025.09.26.00.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:29:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 0/5] PCI: tegra: A couple of cleanups
Date: Fri, 26 Sep 2025 12:57:41 +0530
Message-ID: <20250926072905.126737-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This small series provides two cleanup patches for the Tegra PCIe driver.
The overall goal is to replace custom, open-coded logic with standard
kernel helper functions.

These changes improve the driver's readability and maintainability by
everaging modern, well-tested APIs for clock management and register
polling.

v1 Added new devicetree binding nvidia,tegra-pcie.yaml file.
   Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() api.
   Fixed checkpatch warnings.

Tested on Jetson Nano 4 GB ram.

RFC : https://lore.kernel.org/linux-tegra/20250831190055.7952-2-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (5):
  dt-bindings: PCI: Convert the existing nvidia,tegra-pcie.txt bindings
    documentation into a YAML schema
  PCI: tegra: Simplify clock handling by using clk_bulk*() functions
  PCI: tegra: Use readl_poll_timeout() for link status polling
  PCI: tegra: Use BIT() and GENMASK() macros for register definitions
  PCI: tegra: Document map_lock and mask_lock usage

 .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 +++++++++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
 drivers/pci/controller/pci-tegra.c            | 268 ++++---
 3 files changed, 777 insertions(+), 812 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt


base-commit: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
-- 
2.50.1


