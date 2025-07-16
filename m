Return-Path: <linux-kernel+bounces-733366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A070B073B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DFB3A8D32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D412F3650;
	Wed, 16 Jul 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h1bCVaSc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD02F3634
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662470; cv=none; b=KyBD/60sXAGqi4Gwfgk/4bzPEplIfYytUJ6wQrm4syuaTSsJSNut2CUHdxA5EgDWdb3HhZb3DBsflXfu/1KRzPKw5Axly6SbmR/ph+etEvCQRglb6zEjLv7WzKfFDItgipzQnycaZu7MMCpVs+q0DTV0Qmx+MxiEmgwtf6XOZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662470; c=relaxed/simple;
	bh=eEuw9YtoJmJDZlsM1s2G9AuMfudEACJhCJfjNjUaCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2lwx01tDzac9EAXOsoejmJu/Zm9QUOJNSlnvLMeFW1LEX3nZgUAZivkhh14tVksU166s2w2EQVT+MTpDV8ArHoQH+WsOVmGef7oIABkHokpxVYsNNdegmzw0ThpEOp9pw5G1/1kb5Hcle4OuiK6qrWeLONSEBo4Fyb+AHU+gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h1bCVaSc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b54cead6cso4407288b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662467; x=1753267267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=h1bCVaScdqJkjG5qBPVc0KNZ3S0I8Snt1dF1vhkuF2VUyClX7bMRCKmHKRL6NgOJMm
         kssvtaiziWy9t5w8UGIeM51Vc/9t0TnXivmKeYAZM/MikqsnxtetHkHeyRQG9FKwctP+
         isLQWf/51m7Y3FsVWWy370GLTncgFJ9x9bdCu3tbd9dPaT+iPaP1ffYGopiDIs4b6ZI2
         /U2UN+j2wZmE9FwPaQGQ6n2BKyS4bf0jY7R6al3wJOePhhsfm/x2tLASXovIR1V1G/Lc
         sCnPI5j5ls2bCtjmtE7uUPLfTAAzHwqJI1U5kW9Y7thHuvmF1+KGPk7Ld++RQbkNSBSf
         UiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662467; x=1753267267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4apPAacfnG+LIip3esQe+tr2nBhJ26sQmQ443HLd2x4=;
        b=WZJmDudqpOMe1fnA76uiBlezrTLw/Kvmyo2uVGux+NdQVc4uWkI1La/dICP6IJ7A2V
         YW/SSeS4u45Qa7nnzurv+4c7IbaTfzJPUeLhdSKkYCz/vvfhoDkidJdPLxF99kEpCB2Q
         3K9E8sd6nQ8CZtT111YXFlLkafQ0v2hA0CTbQyMbvPTouPUzKn8DCZIQiKRfVx/v5ixt
         npR0TfEmegk1qJrnh25y3ZqYgEKFjr+hRLCfC8nPrzo6H7zK3VNaIKGGdbqzxsCFbOHc
         sE9NZ6FcEBwbAWFpDjBrxtArhln26DQEyoMGVNI3Ei4VKmFxHX5bSBXlxCaKuRtZHxmD
         Yvvg==
X-Gm-Message-State: AOJu0YwvuZ0WQ3ELQJsqQHZ4C7s/Ceocf9Z9/QCVHp6rmF12mou9VoIF
	ElvOIuf4UaZrm6KljnnWKBR3vQHrvRyItutgGUCz43VwaIOcNzBkr9bxZfJeXqsGqbtsQXkFcZP
	ASNxkiFY=
X-Gm-Gg: ASbGncu17xl3q/W+TNFDnm429jJ3AuGWb4QlpuX987Tb70/mZ3H5LpgXLCrqkKCzPQT
	VU+UxRO2a6/Ua+q2P/4nb39QA7sRKjjKrYIpwLf31Nu5okYyF56Uw3I7+Xy8aqs1WZLhd9xjGi3
	hTDSi9G6/PlcZNkX5fE1oKyz9MkMQV6/MhqkuOW/KiTlDVm4lp3IFkh5iGNGQ4qMxFJHs+gRHQO
	x0ib0djOAR2GEUICrjGoM4+LmlAk0xqGlt7Qh0oc6OQgdEiw/mah+Vx/57OLCz8UVDW8W0hpC+K
	lOfdhYim8m1dKeJMYl4udH6WsV5LWtK3N9a4OZgStzf3n3t2e/skrAvUBfolquqVWjIwTd0X/2L
	vNX8A6qTpkmDzgLryf/wLIp7p+zrhrpjrrmLLzBhImF0=
X-Google-Smtp-Source: AGHT+IE3037YRMGIAaI7C47Ttp1jNsxpPaygBpXftTBTzmjePBr4Bv4yntp0VcQZcAzTwEwQx0RJ2A==
X-Received: by 2002:a05:6a00:2e28:b0:748:e1e4:71e7 with SMTP id d2e1a72fcca58-75724872367mr3013646b3a.23.1752662467352;
        Wed, 16 Jul 2025 03:41:07 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:06 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
Date: Wed, 16 Jul 2025 16:10:56 +0530
Message-ID: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for RISC-V IOMMU on ACPI based platforms.
RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
to communicate IOMMU information to the OS.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf

Changes since v4:
	1) Rebased to 6.16-rc6
	2) Addressed Anup's feedback on formatting.
	3) Added RB tag from Will and Anup.

Changes since v3:
	1) Rebased to 6.16-rc5
	2) Addressed Drew's feedback on v3.
		a) Reordered calling rimt_iommu_configure_id().
		b) Removed unnecessary inline.
		c) Added pr_fmt.
		d) Removed redundant rimt_iommu_configure_id() stub.
	3) Added Drew's RB tag in PATCH 3.

Changes since v2:
	1) Rebased to 6.16-rc4
	2) Removed Anup's SOB and link tags added by mistake in v2.

Changes since v1:
	1) Rebased to v6.16-rc1.
	2) Dropped ACPICA patch since it is already available in 6.16-rc1.
	3) Added Rafael's ACK.
	4) Fixed few issues found by bots.

Sunil V L (3):
  ACPI: RISC-V: Add support for RIMT
  ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
  iommu/riscv: Add ACPI support

 MAINTAINERS                          |   1 +
 arch/riscv/Kconfig                   |   1 +
 drivers/acpi/Kconfig                 |   4 +
 drivers/acpi/riscv/Kconfig           |   7 +
 drivers/acpi/riscv/Makefile          |   1 +
 drivers/acpi/riscv/init.c            |   2 +
 drivers/acpi/riscv/init.h            |   1 +
 drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |   4 +
 drivers/iommu/riscv/iommu-platform.c |  17 +-
 drivers/iommu/riscv/iommu.c          |  10 +
 include/linux/acpi_rimt.h            |  28 ++
 12 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

-- 
2.43.0


