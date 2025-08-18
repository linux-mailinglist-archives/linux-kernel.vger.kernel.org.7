Return-Path: <linux-kernel+bounces-772821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08647B297F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5F3BCA64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C626B762;
	Mon, 18 Aug 2025 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gHN/DfWh"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA26656F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490341; cv=none; b=MNW3OX5TAQAi5L0STsMwoWSjdc1BZpJ71lkAB/iUvmAQP8lWyWyfuK6nAH6WAZRdbVYOecdZBW4EoMo9ie/ozbKTEYqd2/e4PjLfgBvOkjh8EU5n/webFTZnF+TOFoyKDC+y+lBTcYbunPU5Nn/lrGgBUspXBAXIWh2QF1w3V/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490341; c=relaxed/simple;
	bh=kOJ0GefeAd9UEbFEyV014zsaaRwCNdDHSJBAudKVMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7vnOw48W+nGIGkj0AxeWwx4bE77+6G5WZzJCvplia3nXvitghvtjt5zjFLOxVVYBPsGZwtuzTJmYBL7U7hQSi8pwGBi/tdADrE70fEEJZQg2hmI8SdJBN681oFaNUxBZODAJ+YeAqMqhIiKlXaBTmFoIAZOAAWIMFkNVCPgG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gHN/DfWh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so4747489a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490339; x=1756095139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=gHN/DfWhvd9pYjqIf7Ywp47g4kPdbsIoTCKr69b6cmVonTL2k5NcKk9wr/FnDXGzTZ
         hmzBsbbuSIGykBo1Nfci9MhpUoPx/LHe+ybwwGQAnE30YaXokLNp5m1qKpWL/raIuWAu
         qA7XcEf/zzjSMbo3Ef2OMqq1ciOqwqEUaz42VjuF6mWYsnnPd61AXdLVZ+EB3md6zMtp
         ag9gkrg1mrgDX07KLdkktD2Py6KmTgaGMrm5dS+LX20R70w0iJdnHhP2kN4FdRmk8yWe
         HTQufxOr5UFc6ZICD+XFKncwOPxeJ5Y/lIILOtahCcCE27gkThhALtp+uMmoUZIBc8Cd
         p6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490339; x=1756095139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQx4DIh4Piuq7HhjaN41eXcQRyGY2O2ucSjN2pwnllI=;
        b=XZDhEFJvJvG96eFhInGfG5pR1DOmVvIJfZtEb8C80X+PugVhbnCaGIAaqPSKOqtLLo
         pW3ifene7PkWKfq/QdwP7G2144s/dp9f/Y9eeChKCtgTv+4W5DtSHtolRqUAaLBYZbnz
         anPe5S83ZxPI4DimtKsmezSDfTmjjimV275m0BWtLs2hbcUamI+U3NUtOTmZk9CpLlKx
         lj93miWo9aCN94+gQsZDeWxAk8BLjOP0I3IeZJU34QgUDPr+6fDDPZ7sTwpPuxCaX0E9
         je8WBjbUZIA36Oa5HgUJFIcoHfLZ86pKpbM12Pyb8QHGtlvd7Aag5RHwQETDlpOpPzMi
         dzEw==
X-Forwarded-Encrypted: i=1; AJvYcCVIlfkcfBGN8QnVO9cMs9nB3MuLsPrTUgIyW/gDp8Wh6qGrP/LLsHIJsAsfXtR9KmP1eQqgzbC5fme2fX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAepw9lqpZ5Qp6D5tPz3vMOB97empOv2WzovFO4Z2xki+/6C3
	5ZmR0ZjqR59V+LtrecgWYdwj9bOFPAe7Lp8X/iQHAtRw5BLHcIJvNfGiSxXliD/J5rk=
X-Gm-Gg: ASbGncv0rjVMZx0TXcXRu3W6DYaUTi6HPeqW4Qhko4hu2aanWaFmcVI4MKeazRkn5qU
	APh++vw84FHuCW2KuGHk3Wp9r2mF7KCJUQR7PdZwrqgQtnQ0OWEb+X2ozr4+chslbkKLDhjEriK
	9qijUpv6RkTxwzuti8qmKLbH52f6KBEo0aCx9GU9bhvpc7p86LGcm49P8ehX+WOOuGdZeJF2Sjc
	IQvXmgqbwfNxODdAlQNN1ziOnR4c3KCkG8i6SVv0C4ww3q7I71FZaxMDqT4ziLlhl6rWoYBcmTO
	U+3dB6/931qmff5tL1MixdI2I1Z/HsLdbq7oRiDrQTKavx/HoRW2AmWoV8IvJVkDf7W0vssphFH
	9fw2G/4Yuv+QHbpUBOZTF/1Ap+8h4T5DqAhQGOBwvfWT/CbHJKEvfu88jCSfBvfhQ
X-Google-Smtp-Source: AGHT+IEPxSb/NsG9Zm6Sde3dy+9vjl78ugsOjUnfoDwFeFFug3ocplCGnN7dY2ngRx9phRfT5mXqyQ==
X-Received: by 2002:a17:90b:268c:b0:321:87fa:e1e4 with SMTP id 98e67ed59e1d1-32341df8cfbmr15719154a91.6.1755490338939;
        Sun, 17 Aug 2025 21:12:18 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:18 -0700 (PDT)
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
Subject: [PATCH v10 16/24] ACPI: scan: Update honor list for RPMI System MSI
Date: Mon, 18 Aug 2025 09:39:12 +0530
Message-ID: <20250818040920.272664-17-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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


