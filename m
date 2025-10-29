Return-Path: <linux-kernel+bounces-876734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC1EC1C277
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2871888F90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D10347FF9;
	Wed, 29 Oct 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsPkz5A0"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B73469F7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755631; cv=none; b=h9GlHBj1km7yUeQ5QVgHUwA+QDyZijcO0C7QN6YNWU7G/gUjEzaGONse1LqRQ7ux5vkNmd+WFR0+y3/X34s0dvJNnZwXfm7cugE4WRDE9/JwFLqjQaMsDm5V2ZzVzjGW3omNLR+bXs/nnQuSPt1p4BPSxu1zOx3MxNaf5eJvcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755631; c=relaxed/simple;
	bh=nyc2pqrGN622czbqL752mZIP4IX12KOgaXiQ7fJqL2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTFw8KkYwwGe5TLLRfxy9dyHZDbndArZeQae45LItGt9l2psdDsykgPHavlSkQ3w3afLS0tAZ3eX4LmdVjkvM5XOLqFZUBlBFrlcQvGnqzvFG46YiCCXDG16zf9JO9zoO6fFtt8lTuBLzaxPNjoqnjHwG845oLRYUg/b1OkvgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsPkz5A0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4f323cf89bso14622766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755628; x=1762360428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOtQpkg6YutdjljN7zgxOA0UqmJOiKsRIM6+iFOdM9w=;
        b=TsPkz5A0bpVSK3bFDodOhIgj/wYyMO0MoglQcGiMbEmlELok9GrfGJC/MX19dAtDWd
         PV9aqbzS7n9GKCMH9JbfEGzdsocDYidHLBXXUEqkzN24nFiRchS3bnV7lHvy0Zwe8PgE
         hYQNEP/ddtu+iQaTE2BL4+Dlj+1OBFEBuxAuKmwZUMfnCM0oAB26z0Mg6s9/FZaVLstL
         i0j1Ec6H6QqIp9QpyvJmECPGbGZV3UzFH+TyrwRdPZwMBIXlQCh0xfHmR5cX/sRfAFAE
         EiZ2Tc/IZpFGW3E/Hj0RWDZ2a39mH/qR7F0eqIV20xPkUwc+vdeSQS2opAAH39LXK2Vn
         24xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755628; x=1762360428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOtQpkg6YutdjljN7zgxOA0UqmJOiKsRIM6+iFOdM9w=;
        b=JPC1yWORsBuB/cYQk60WT8Z5Vz7Il7yrZbcaHVXBlUWXPEYnu+c5daccI0silmPb15
         wGIuIFaF4DkccFEPCghm6B2XYQoeR/Mak3vOYF9FkJWffy49zP5esTOdDid0Wv0i40I3
         +hQciE7B8/IhRLCQvKfo3/QMRLwCU/i6lgYRKfX4CpqZJggQ0dqwkw2aU5kM/pJPMxA/
         zxUjRQ/AHgsiL44Y4xDczwBNQ/0XSzo9IU/zEaLJdkbDemdYhDUvek+SYNmqO4J/GwFE
         U4Pnbhe8poRipu2GpXua2GewfieqceZ7QAhlNxKBb+rdO8P3xbxsjplg6UNG+4NfKDya
         fZWw==
X-Forwarded-Encrypted: i=1; AJvYcCXpsuDO/ss4EaAnoK3vttlSbgNTA6giBauTXRfJUdH1Qq+tWRJG5gjheQnOHHqCC2mZhVZ+qr6c8w03eeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1DvCGluQ9cdMv42Rrfi9PqohEEYOHHV44kYli0/p6ammKwL7
	vqyRK3Sq/FQbALVYFgrb93SdIGCOAgQ6GbObdomsszsW4BGqiLgZQfPa
X-Gm-Gg: ASbGncsZntQ5L1VqX1F9jf5/7NhWcM61QvOuSqkJG7cU4o3W8PUYJzM55mWjDOqGmWC
	i7FEPlTaWJXXyfZ9QvqpIvPJPrcOMuu7jgL50OCNh+0NQSI8AM8I4p5sj8B7TWTp1Kz3mf2RgOC
	r7fBLx5vNpzP57GCjP4iDFSKmmilyRdTAqvs2viRLGorA01wYWN4kGG3Y0WVZdQFYk2cMDMjfCQ
	fRvtWklNC1UnDLQpYZI/krv64I95ZsbgtxJe5A4BXpvlYjBFuWs2X6do3m8RVJQlRrP1njG1zX4
	m3sLuLD+izk4d+vPHPILHPzd4HRq8oN8fPnQ8cjGTyKP3ID9W+u2Jgex7pPbWH2GK65mTeW2muN
	KnsAw683gTSUNe96hfN0DUON0sybBNE9659XrrrrJHbpDi4Y6HY/xqg2N9VmKvJJHoAYVCcJXJB
	I5ykKmQYsM7OtFrrjqkFHcgpu+++nx6Wm2Ne9dueBr2Qgs9ElR+6XHGQ==
X-Google-Smtp-Source: AGHT+IFucoSpcC/sMHQ4BHPU2Sj/4WR5SsWuPVRxpOY+Rb83Lsjw7eIU5fItk/Z3WAxH0T7dO6D6kQ==
X-Received: by 2002:a17:906:ee81:b0:b6d:7e01:cbc5 with SMTP id a640c23a62f3a-b703d55289bmr367879066b.53.1761755627345;
        Wed, 29 Oct 2025 09:33:47 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853e5138sm1485764866b.44.2025.10.29.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:46 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] MIPS: PCI: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:31 +0100
Message-ID: <20251029163336.2785270-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

Changes in v2:
- remove unused global variable

 arch/mips/pci/pci-alchemy.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 6bfee0f71803..f73bf60bd069 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -33,6 +33,7 @@
 
 struct alchemy_pci_context {
 	struct pci_controller alchemy_pci_ctrl; /* leave as first member! */
+	struct syscore syscore;
 	void __iomem *regs;			/* ctrl base */
 	/* tools for wired entry for config space access */
 	unsigned long last_elo0;
@@ -46,12 +47,6 @@ struct alchemy_pci_context {
 	int (*board_pci_idsel)(unsigned int devsel, int assert);
 };
 
-/* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
- * should suffice for now.
- */
-static struct alchemy_pci_context *__alchemy_pci_ctx;
-
-
 /* IO/MEM resources for PCI. Keep the memres in sync with fixup_bigphys_addr
  * in arch/mips/alchemy/common/setup.c
  */
@@ -306,9 +301,7 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
 /* save PCI controller register contents. */
 static int alchemy_pci_suspend(void *data)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return 0;
+	struct alchemy_pci_context *ctx = data;
 
 	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
 	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
@@ -328,9 +321,7 @@ static int alchemy_pci_suspend(void *data)
 
 static void alchemy_pci_resume(void *data)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return;
+	struct alchemy_pci_context *ctx = data;
 
 	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
 	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
@@ -359,10 +350,6 @@ static const struct syscore_ops alchemy_pci_syscore_ops = {
 	.resume = alchemy_pci_resume,
 };
 
-static struct syscore alchemy_pci_syscore = {
-	.ops = &alchemy_pci_syscore_ops,
-};
-
 static int alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
@@ -480,9 +467,10 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 	__raw_writel(val, ctx->regs + PCI_REG_CONFIG);
 	wmb();
 
-	__alchemy_pci_ctx = ctx;
 	platform_set_drvdata(pdev, ctx);
-	register_syscore(&alchemy_pci_syscore);
+	ctx->syscore.ops = &alchemy_pci_syscore_ops;
+	ctx->syscore.data = ctx;
+	register_syscore(&ctx->syscore);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
 	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
-- 
2.51.0


