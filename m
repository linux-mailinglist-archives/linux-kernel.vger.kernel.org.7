Return-Path: <linux-kernel+bounces-747787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2EB13840
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D70167AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01425DB0F;
	Mon, 28 Jul 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OQ+xphiu"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F794FBF0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695894; cv=none; b=s5kO+HsOL2FfWZ1QAfEfvjkjqDGICOWg+M8PknfTzjVWRcT9btumHhMvU5wwwlTKMJmUjvuuVBJwsMZY4sfX0VLjAgBZoSpyPq/rMdimC2pxcnJ2kCR94NFk2oICiSHpnW90dPsB9sX1c0s7Qt7JvC1DLWybIBgj72hENxNjxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695894; c=relaxed/simple;
	bh=BkvhWSTnjiIWMOiaDZEJPElgPR0D+BhOKMYO4PPRBxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf4A/x29rkKVLb5ZoB+4VCf6iq5+vFMLdC7rHiY2r7sFOHGO8htNU8WadEUOIwQlslrZKvZ7pjRBf9VzEzj7pd/XaMQXGOtf7tW8mI60kkk4Va5LPCehxilSkuXYE2dHfR6NsLuYmh7dzLePBKB5ej+WJmGhynb3aJMHZi09MHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OQ+xphiu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313910f392dso3085933a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695893; x=1754300693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x549zkWeZBn9yckX51psel8f2gpHv6i7OmNEj/3BvHk=;
        b=OQ+xphiukz8x0QDClcE1KNags9bZfbkyI+HyW8ZfgLHQzcIYmUME3vsKa348RFPem6
         C8qPbFEvmedn1MhHtaaR7e9m0+U1Ss0Axs422nT8j4QIRHXrUcdbymt7m9hVcaZyXM0S
         gyBM4I3yXVNLzif7EtzwnAB2A/HaOj36HIRzmXx0CW+SFvtEX3a2UtktTq5dXAV9k7Ig
         FRgX2PfGzXArxzr4wfBdF7akOpQMx+2YcewmJ0HvmIm8HC8njEJH8NdZPvS9xnO4/Pbl
         bH27VKv6XZsqnH7+im+3U/GFh5N9GoEal67bLpTk9iKLHQR32Tu2cvkUemZbzw0/HuOG
         IwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695893; x=1754300693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x549zkWeZBn9yckX51psel8f2gpHv6i7OmNEj/3BvHk=;
        b=mVJLfNH+rRIoZUNjfOTp+VXC9Qj0pPRpW3ftJmP04NM3mFyjZRQFxAgMI96SbG1O5M
         mlkshIn29KJ335mhl6yfz0i41DGz9r/DnYzTajmFeQ3Iq7zSIBIO8D7vu8h14AZK+bA5
         gdx/WYOghi4h6antWLFqgHIb3hCmCGLPOglSsmc2OSfG9MYkRjKAMp+9Y2C4JMKqQAzE
         7BO5N2N8a68V8VZCTTTYKiQcWkYjw+F7XdXI6Ilj/4mL322EmW8LdidAuN9zAnZf2w0b
         scMvDfA16lPh3LlJTnjUBysiny6kFDvuGIJyfXUekSNkjXLpzniMU9xPFwAF2EfYshYY
         8lXg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6uGmiiBHPAlCrOzU1wO/jMRPldmZiQQQBzY2ce0jm+isQTU9jCGB0IOuuzOOvTf3u13UOFlQrG80Dz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2mFcry+PlHfkWGfExrUBo2NCLOoumoOqho9X00jp4PYu9jVh3
	oLejkvOh5viydwiOi12DtNWnrCdCtPnn0azxhfTxTDUPcxSU3ru+EBd35DiWbUCEEiE=
X-Gm-Gg: ASbGncv/GNazOFG39IjiKwdT9ArpH06mn+tfdoqGHuEZs2L1IuAnzI7u0CLIAODzN7M
	opRQs0F2VoTqdDazy0erblCu4mZp5qdXBUW/2xj3DqwoMgcgtXnGawp9B6o/WIcIgzhzycE5B93
	uIi0ZdB3gHwLhxEnkZkF+XZTq4jdw7fm5CrljUjVII5GN9aiPWq6ayeOh2JjZsrwKOEiEy1Ptkb
	EuSsIFa7f7FXSIAVwL2H6gZyvdPpdJskC2ZjMqCQqtxsy8x2e8haLIj0CFoZNAvxYO3PN1FBswI
	5VYmn9UYjW5a94C57XpRcF5jE8nGaeVY6ZwsLnHIZB2Z08YmeZC83dWq2LTT9ixQXONFT48KZFG
	SInZiuK1TCLiCvSb2smuabl/ZXp4rpkeWui4aLpZvnLr4Fy+w5Bh0XfdbXnNk
X-Google-Smtp-Source: AGHT+IGSbo27hBN363qDwsNMdhMoZk2PtIESdVUuOULrb8b8ZFITrd8ZdG3auXim/8/7RPtqAB6o6g==
X-Received: by 2002:a17:90a:e70b:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-31f1744ea0emr283600a91.31.1753695892281;
        Mon, 28 Jul 2025 02:44:52 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:51 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 24/24] MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
Date: Mon, 28 Jul 2025 15:10:32 +0530
Message-ID: <20250728094032.63545-25-apatel@ventanamicro.com>
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

Add Rahul and myself as maintainers for RISC-V RPMI and MPXY drivers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..ad6404e8292d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21395,6 +21395,21 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V RPMI AND MPXY DRIVERS
+M:	Rahul Pathak <rahul@summations.net>
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
+F:	Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
+F:	Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
+F:	drivers/clk/clk-rpmi.c
+F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
+F:	include/linux/mailbox/riscv-rpmi-message.h
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@gentoo.org>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0


