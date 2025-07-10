Return-Path: <linux-kernel+bounces-725291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775AAFFD03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136597A8826
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BC28FA9F;
	Thu, 10 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="duonGAm8"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104F28F50F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137843; cv=none; b=ol4/PSKNlFX47B/eKESgozT6scbVYUiFqn5XDBBTlNmOyzOfr4AbHPAzwOTka+n7paTmABWO6/RsVPkD21KEEDvv7q3Sy2DzUP2Q+IZwtI6uugnzNtreQCN8YBQ0YpRGRJIrOXhQLoacHoAxY7CQmwW1Q0qBFXXlCfatjWgFWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137843; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPLI4XGHbDmqsb5WwZimUt0OY5cbLLkrV+v0Nkaxept9wZDbTRcFyFnCUaYedh8S4bp+zu1Tb3VjFnePpgHqrDO49GRqlqNWndAFbU+q+6udWs94uz8l8PG1d/+zx5TSVjjyhUoALv+BwwwnQKSK9RBZSuHGpsJK9mHQ37J4sgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=duonGAm8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748feca4a61so491369b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752137841; x=1752742641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=duonGAm84/r2pR4wo0OQvLIJ71obGk9mvlJkF3jIw27umvMyZyZ+7k+t8S8piLiTxk
         yjk84gAt8KNCZFMkbm1uUbPoN2Lbx+va/lwHXxKFMyvOss3wOIPSsx8k0eKLz9SCUWcf
         pL20JBnalGDh6hOM+VVqqIyl1phdytkaiX3g3ByqOLKN0L4kzeBrwYTKGu+vL/4Ao6Lt
         8L7Ms5/KOzZeHkF9JdeBsnFOLApKQgRUG9X+qCZ/5sTuB/f0wCocn+C3A8i7w9JTo03I
         mdsxRBx0oUNXGGexK6iy/jOs5uiPdwnuGK8FOansY3Miq9/N0SfmxOAC+yhPDKtWOUs3
         qsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137841; x=1752742641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=P2Emih8iIpZY51rk7qz0gntIxANlSwbvsRNL11y3f4cDtLOhnpyTvDiVJq5w8YnjSS
         TAPhuPXHF9ojCBWNEQns7Ne8TPRmkzZ36G2XzcAfICW52goDPvnkaVJdDskoXXcEVBbd
         nbAsMmgoFo5N9wcepNFHQ4nWV4i/d1VHGtSRibPiw5DbJOfBscCSa78MOWMGR8eXLIsB
         BuOWWBSXARMLUizmMydjtTr3oJv6uE+Iuk3z7pSVer1eBKzfGwk4k82bg9C+31Gha0W7
         khjNOBbAAGuTZDLC19y70vDeplScpM2/JiUwTve+TxmqKhwpcBj3HuxOl9Dh9Yl/rX/a
         r15g==
X-Gm-Message-State: AOJu0YzGQAgFw2Ql2pc5j+1/r6ryX2ldvRpIQ1qOgAFOEPZ4nKB+HWoZ
	oUY+nTWwXWs6Xoqa1hAk66AZYew+FL2YxdndYDV6XXoz69XsqCDfXlJJnclGejAA+hd0Ikx0RvK
	3TNQT
X-Gm-Gg: ASbGncsFBDvR8NiCr4bT1FZadB//NNiFCx2/ZYsAcZMkAYXoAl05qSDo+p8JxgM+Esv
	Bw8ZKzhGoo7yeHXLbsus4JaWfUPF/5V9+ZWlf5O74OOakRlCeurZnGkAyMmP6nJBNZ8sribLufc
	OHW5xY+Mk0pB1zRBIgdBhR9hF0V2XVX0IADo5PASqpHjEP9M2ruqFlz09ODDB12MvKZtLmKqDPa
	YYL+8ZTLvH1F9IcdRMx/oryQ4Jk4kASmg9j5MF8A+/hETAlUUJr0XLpLEs1gUx2dwjQ4e6F/TV5
	S/jtna5yZQi3cavwwqufL1xlVDJOx5iZsDH+d2swdGCj2ejWV0nBzShSdv/hK5cckGuwC3gsd1y
	vjxNvMQo=
X-Google-Smtp-Source: AGHT+IGTMhySvFIKwSkWciVZb8lELRF3nbSYJnKAx6xboIUomqUcgBH56UpRO0apylqo7r2SLhP6yw==
X-Received: by 2002:a05:6a21:6e4b:b0:226:c204:3c40 with SMTP id adf61e73a8af0-23003af63admr2908259637.5.1752137840711;
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ecdcsm1522323a12.14.2025.07.10.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:57:20 -0700 (PDT)
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
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Thu, 10 Jul 2025 14:26:56 +0530
Message-ID: <20250710085657.2844330-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


