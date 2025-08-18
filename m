Return-Path: <linux-kernel+bounces-772868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A764B298AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110DC7A1A87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C626A0AD;
	Mon, 18 Aug 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YKomWJQC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E02690C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493098; cv=none; b=PiaJ60Dp21zhePwH+urhi2mESaIIMxydcHIu9kz+KoyZJ03inDzjjMdbIEm8NXcpws9ivHSusJ3B8fKQ3PVYEsRL+HA6YOEkVRTXqTb0Kev6zYa5e++ebhuRQ5JyXicARBUxNwo4mHTscSGDnhkUYPrLdc6lEerDkmLxlMb3zp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493098; c=relaxed/simple;
	bh=uWmg/md3Uur5G0azfupdlm5O0QlvtlmbG7Yvpw9yQX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjXGF51vpt7vcqDNAYgm+nyIYKSdL6cTZoa8CoMyErVBV7ZF1rOI2V+s+o3KHkEcbmKXmtQk21ZuAoSUkZWXkOLVn3GmG4lH600gCNYFFJK7VYLvnW0EGbLq8LQBgjf3Ucnq8nWd89yPchRoSHHTaLo0/0VO7wSP2arvXmLSUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YKomWJQC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244581cc971so44551375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755493096; x=1756097896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=YKomWJQCVQbP2laEtnHM/dTCuEN2DiNZWbLNLN65ci1VpfgltyDkUeEK2Ts0MkNsXJ
         ai5DC2/086zs1qwo91DTxXW49Hzkmm2pqMo/WmORynKGJWw9ojBR1Ba59TYUVrH5SFcv
         A8++dAdrtxccWkOOVDY/m721gVcAz+/pGW2cLUxXKvb3YGv++MMkqn/LygHey68VPXHd
         j2qm7ZpzkOPB/xJSMyNPQIGWQPb9miVlzWD7uLUg2jnEkHkLo52pP2dxGt7a1o1T2+ks
         I34Us8ziBCRPGJYYlATDnph175iMRN37ZByqAyp2NGIZ7ME//JKhu4CchuV4nWXgak8E
         L4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493096; x=1756097896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3V/meoXkl+wsGtPedKQJxOsDVawZ6HAz5fY7bg7lxk=;
        b=eoM5i5A3Sa3ubSx9H/8cWn4V/RmK2O6hTwYZOLtPSb9rc7oxkiMIIVESQJlFHI9ZwX
         4qp+h+pq5827Ey3bXx5C7iKtR47JVV2t7anfG5DTcyo8B+Tgbi2SnbvCI/tgEfcbA6J1
         ispY4Ayw7IiZRgaCdjNBlsw9xjvEIziaDFF1fu3TZkM1HhtwombmVzuSZElkvufd+3IO
         hyigclqFfUHab04OSsv3kPTfvUeXBSf34dD7fRdNA8pmVwEukDOhaJLziDzrIBrZEDwN
         ZJ6RmDETVoyDt4zb43d7CSDWhX19a6A0EHCBwgMGHZOwTHlaNILnMBw8o28pBJoI16Oa
         q39A==
X-Gm-Message-State: AOJu0YyBjQXqn2i5cVjEp2ZVU10U71x9q+B6NjfTMjuvjiRi4QVFT7bz
	gHLSOzzS2SfxxdfpI5/RmZ4DbZxSLuMqh6qv/LgdiCCoT35tUcZ3L4wEJRFLByp7Pu03QNBQlUS
	7K4WId+8=
X-Gm-Gg: ASbGncu3HKoT9LfjFzgVwcjxWT2/h9LWc1GJNzDa9VCmbSGm6YRanI0mzNLFNW8J8aL
	kq+jxewIBMClEOknRFILh1m3OUaUihLmKrQ8bMc99JVRlpJCyGAIiGaQa+cMsAV8P39RqC0dkwV
	bNsbHFd/cDu34WV99w7rbrjfjq4BqIM5UjINJ8KJKxsKBZqNhDikMIzhx80m0KJUhru0ErJJdIQ
	U7WAvxmiahb05kTNFVL5DhiMTeIwD7ThN2ONRk6wGRtppAnmeH9BIfQIE6k9Xsye2N4rmIkvOEb
	RyZiZczYrUOuXTXOwRL0+OLcI5umAf32Ci4g0n6mUMnPIRBowXgqzNI+9h6kvAbUbaM20adppuB
	4HJtKOWwogfEjIo+/IMEgr+azCnSaYw==
X-Google-Smtp-Source: AGHT+IFCk2BSwqNgThH6PEkau6i2nlNB+untLX8ay7e+tXj4jOXYDkG8+9f1odmZ7Mh1rjQjGkHVpw==
X-Received: by 2002:a17:903:b07:b0:243:7cf:9bcf with SMTP id d9443c01a7336-2446d71ab96mr143054605ad.2.1755493095547;
        Sun, 17 Aug 2025 21:58:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c264sm6124047b3a.43.2025.08.17.21.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:58:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 0/3] RISC-V: Add ACPI support for IOMMU
Date: Mon, 18 Aug 2025 10:28:04 +0530
Message-ID: <20250818045807.763922-1-sunilvl@ventanamicro.com>
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

Changes since v5:
	1) Rebased to 6.17-rc2
	2) Fixed incorrect id_out assignment (Reported by Xianliang)

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


