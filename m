Return-Path: <linux-kernel+bounces-747778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD56B13802
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D3A17CEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32742253950;
	Mon, 28 Jul 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cWzB7nAn"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8E256C8A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695818; cv=none; b=tMkxjlGVY836i/J5WiHdfaaIJDWF5T8QVmRvxE28PpXpB2Do6Ec+3DKFd4KeUh1YfGZJ9Lf9LNvb35k6dcECCy1TFZ/Sc88lC9BlVBva///oe/1uepl/o/myBjaoa11SvInFc61cN6j6kM0s+cztnTdWTHfsYZ2dAh7AMv1uh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695818; c=relaxed/simple;
	bh=kOJ0GefeAd9UEbFEyV014zsaaRwCNdDHSJBAudKVMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM0mcTtCS2OVd0pQXRFIzIegFm2iIILxugptyj6v3EZ6YTfVEPj+TNv4bSSwVQ/MB8AiwxwfGh0obCJL88eny3OnZnzSC3KmVOprlUfJtu5/jpbCRowijTLF6dTqaMvyCoKUyfygT2cN4I03KkG8P+1Sl4Z0iohDLDqc/q8922Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cWzB7nAn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so3740048a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695815; x=1754300615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=cWzB7nAne7WaBgumQDLegBZ4RXLzfBSG/L294xG/VxC/UnUVMFt17qjq3E/JmIfoUj
         QWA5olhy3v+z50MJnYBbBCgxTrBVC4I5wYMDbBgSLm9ZwDCHlFLlbNAN2PpcDSgPG1hA
         wZSmRCXrU1VvgR7/7ibyd/R+cPWy3ygDBcPL+FrDzNQqJBa9PVSjSAs+tvNtkvpAXKg/
         OMzWtuy5Nh9hHK5Qgd/7l+KfooZuDye7YDvdAqCNGb/uLLgRJcVn6TO9FkZLenJ6VxKa
         X2febJTHe7WCB3D+PEtgYPzQRbItyWOYEqo/OpftRm6UAgaQ4trgn7YaqXk2ji+lSTIc
         jHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695815; x=1754300615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=HX9HdZEQdGhbL6pZPJlocwQNNC2ZAa+es0oNBZfeffaycmwWVQMI5WtDvd09WAVa8h
         jLOtV0IYfeIHdrhpb1AGNNAQBl6eCrIu5PkB1tQlLn64Rt3Lt5L3MXP+K5XFQUrivn+E
         m1W3fKiRXHEQh2UmuK2ZAiSSAFTROH8CakidQFEPl5npAqe1YOtu9khm7HuZSF3z8nY8
         BJIfp94cq/tGe0FyswQ24SZbjC+WPa3slCTBxpiR+mexSqcdjtJVk7ISIEKEKcUwE6bm
         leHMi+jEJ4ZP6RDNmdf65gLjLpPN2m/oyHutvUHF355nL4RcSgpePuLfCKJXD5cWdGBV
         LcEw==
X-Forwarded-Encrypted: i=1; AJvYcCUqp67vLEm859ZLfZTkPkjugIujrOZbXd1oFSdKLSl4mn3yVN0mHWq7RfPGW6f+ZGxshaztV6ws1GfOwRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsyyzYi1ELivpbFVup/ugdJHtGQcLOxt6Dwq9NN6FoqPucGGj
	KP+f3JzzkZZErqt8xDidSfX2vTzF8rEGTc2FhuzphLtSt/UCzViehMQ63UAEsqPO9Mk=
X-Gm-Gg: ASbGncuzRvPf9AIZfWhCyUduXEyK+3QtcPj2uD3MmN/bAaSYUwAQTo+q3NBcL5PLjkv
	5m419DgSUH28pWUKzRV1WDXJZ1rkbG4J+DL8n+PBS5ICqe/8FXW6z8vgfKDDAKVEcfDYD1I/Ifl
	bsj1Wqw5NO8YUhY/g349/CpMck6wj/AHDiT7p3qXZmdorn5II+aSnaiHxhWrwOuD+czSJ5EWWLU
	1QEf1D6RHrZIVkUe0dpliw2dOCloc/9QbMPKPlW7hzTGP9cmsUfy3xkUhaDw2cdh8fPrIVvQVN0
	8M42eZbpLLAFyTW71VLa6YPCqohWRfPggVywvhrkjDpIdj0qrd5AKT0RV5tH9EFKjwYjdSN+qc/
	YtYMdaDEDjl/T1GNa+2iD9FbtZByFq3aZIdy0PZBkpgyxO3AsqfnlgbJf/tSO
X-Google-Smtp-Source: AGHT+IFdcj9UyigKt6rPUnP9ob7R5oKYx3exa18ogG0RTJ8u+ssoeGzkdetp2bS/IhUP8p/ILwtVag==
X-Received: by 2002:a17:90b:584b:b0:311:e305:4e97 with SMTP id 98e67ed59e1d1-31e77a01261mr16532165a91.19.1753695815287;
        Mon, 28 Jul 2025 02:43:35 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:43:34 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 16/24] ACPI: scan: Update honor list for RPMI System MSI
Date: Mon, 28 Jul 2025 15:10:24 +0530
Message-ID: <20250728094032.63545-17-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

The RPMI System MSI interrupt controller (just like PLIC and APLIC)
needs to probed prior to devices like GED which use interrupts provided
by it. Also, it has dependency on the SBI MPXY mailbox device.

Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
list so that those dependencies are handled.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..54181b03b345 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -858,6 +858,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"RSCV0005", /* RISC-V SBI MPXY MBOX */
+	"RSCV0006", /* RISC-V RPMI SYSMSI */
 	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
-- 
2.43.0


