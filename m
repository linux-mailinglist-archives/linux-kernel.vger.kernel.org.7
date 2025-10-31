Return-Path: <linux-kernel+bounces-879911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C5C24627
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0418B1A603DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB2337119;
	Fri, 31 Oct 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="a2J2cfjn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102132F773
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905436; cv=none; b=dQSA7KcbnvSEcqyp8ZSmw3vQmj3F65vThl3sETgGb83n9ny4beP72rq23RqQcYTt+Q2TyDzjWG4ck+mV0jrGtSdVkijlb2+os+zznczGQAuPBmAxttfwcDNfBqRrv1GdIDnINsDj6YjBSy23vAZ0r20yCbdBIlv+AlzNgz9nRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905436; c=relaxed/simple;
	bh=rbSsCcpdfOQMl/imm+AJcUjwxWBfACxcRCYWxMrFHNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT11BmbmHiC7M/jqQiTMmqnCRTBzdaIWqiejQboB4nK6vRv5kAAXwlsPZAwwM/HcOHrb6HNHDwsYFn5aQfcI9utITMTDP3jbWLHRdrd+rlg8RqjFUyzaGfMJWm+8a5Iq5LCq5R4yulrk0bZINzo3LCtO94aYC0aUPCtxX5GGARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=a2J2cfjn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a27f2469b8so164560b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761905426; x=1762510226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmq+bAz1UkNsQtohwkVTzYtE5dGD+y13agWhpu9mVtU=;
        b=a2J2cfjnZuI5VOVVkeApPsb9t15WgODmbXroqXozQLpNk5zfJdTSNMS/ttvJ4hYhDZ
         p37Nai6pl3IS1XPuz7GEXARycMVt5OAOE6O//Q8AW4OjVqMNts5RBuEjC0M5Teq3BG49
         CbUstNkCDPf3Xq1KGQnRhY2lxnvKX10TEhqBvTbdwuNtlcbI/IreHGqkMJ6Im88+gg3a
         z/D1Fa3zcx678eyL6xrkrcm4CwgM1jQGJBHmE+4tKHDXvlKxYzZ6ajdVL0ZLgJJQ1+oW
         TOC1bKEPasUqJdXvet7hSuB1HcdM0nLPDUeT15fsIagRaFmc+ey0c0tiT6OsUNYOPfna
         gExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905426; x=1762510226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmq+bAz1UkNsQtohwkVTzYtE5dGD+y13agWhpu9mVtU=;
        b=b3Fy19fGvCq0zoKvt0xi1S3S5WhrJVFwbQs+DPCYDtU4e1LggYpflpN6DpbROA5CFA
         DYQQMf1Se5q3Jpca+NKNZbQSakMm+P3R/uFl0a2GyFgV8ASHS+jpHHzHgWvapjApA9vc
         k2r2HLx/UgrjEogAmlv/GGdVrj2n8nuZWpvfa+Uu7ro1Q0NpKBL2dU8MrBmtxKDkwBAR
         Y0WBI0pPQe8kQFvvaC2dOeD8gMopy2GTNOHjlHxXIrKFuOe+YK+PDTNM41at9z8cjsUn
         gYKWYwyPnBzOeBG3vsvn/VxHhhyxzGeEdWnM1BOi+alykMxKPFMAKhCU4+eZrI+jPiOa
         dxeg==
X-Forwarded-Encrypted: i=1; AJvYcCXAwxNvDI8q46kKBJUPayQoX0dvSg4QmMLq62joVzUm1rWC424HpQt6UMCQCNowZcxtLZCZDWugmt0Irvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeDl2AxfDmG1dNLhxADPJnhK7BMzE1Yc2wVNk42Y06sQkDqeg
	QNPeHCSbQeZJ6ENkm5+NlpRlNMmu4In3drfjni8QEiQzsGdhzB2zACZQ58CENKX8+Q==
X-Gm-Gg: ASbGnctZ20tVNqtU/vR9bk1BH/elP1FoYKkYS7pI2kd6cVlJLXg74zKhE8g9D8h5n4Z
	2cB/qH2r0zXc0gfPUrR3/3g05tePA5AmhcDXzlw5C9aXLa+LBhMwDiGm3KkpKr2T/4/IVL9QcSm
	ru8YEqEdKYyBJVwswyH0BNR7OFymHDE5iudS7sSNlzfPmreKY9lNuujJyWP386LGjTVMVQid2li
	fk/8jp9y4TjCDINAYucs+RvsGdFN0ge9AaLUnDqr8R6+kzbkdHKiqZ9MwL5CKjhLJer7AVnAfES
	e8dJPLrHBK4v7JfGmGKojmImCxvDSp7gLxX3zLHakYCKDFB6+ECvVngRHi70znLqMFYoYsbrlM0
	Wb/L2MUZMaXj9EgqskTSWnqU/anodBL9TPhSREXYJfLOrhe7PemEiWIahu9/VpHmiRnie+TVdQ0
	+XEcl6n5vb1xjFdL79wf2H+EnUtQTiEEDajw9LMxOi/aN4lWI=
X-Google-Smtp-Source: AGHT+IHP0KcJILf7X9uuGPb4TLUcbh/zJGOXAc0JvgPUtH5JkTiBAWLIYK309sM/jCBKRYZpJQMPaA==
X-Received: by 2002:a17:902:c94d:b0:27e:e96a:4bf with SMTP id d9443c01a7336-2951a37bb0dmr23125135ad.2.1761905425939;
        Fri, 31 Oct 2025 03:10:25 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17458545ad.99.2025.10.31.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:10:25 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	adriana <adriana@arista.com>
Subject: [PATCH v4 0/2] DMI: Scan for DMI table from DTS info
Date: Fri, 31 Oct 2025 03:10:07 -0700
Message-ID: <20251031101009.704759-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031084101.701159-1-adriana@arista.com>
References: <20251031084101.701159-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

This series adds support for the kernel to find these tables by
reading the associated property from the Device Tree /chosen node. The
bootloader can specify the physical addresses using the property
"linux,smbios3-entrypoint".

The first patch introduces the device tree binding documentation for this
new ABI, and the second patch implements the driver logic in dmi_scan.c.

Changes in v4:
  - Renamed linux,smbios3-table.yaml file, removed mention of ARM/ARM64
    (Patch 1/2).
  - Drop the second definition of dmi_scan_from_dt() and fold checking
    for CONFIG_OF (Patch 2/2).
  - Drop unnecessary goto on the success case (Patch 2/2).
  - Replace magic number for entrypoint size with SMBIOS3_ENTRY_POINT_SIZE
    definition (Patch 2/2).

Changes in v3:
  - Removed linux,smbios-table property, only keep the SMBIOSv3 property
    (Patch 1/2).
  - Search DT for linux,smbios3-table only, removed the code searching
    for the previous property (Patch 2/2).

Changes in v2:
  - Add missing Device Tree binding documentation (Patch 1/2).
  - Split the original patch into a 2-part series (binding + driver).
  - (No functional changes to the driver code in patch 2/2).

adriana (2):
  dt-bindings: firmware: Add binding for SMBIOS /chosen properties
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++
 drivers/firmware/dmi_scan.c                   | 54 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml

-- 
2.51.0


