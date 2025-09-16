Return-Path: <linux-kernel+bounces-818532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C8B592EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254F13BC761
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79A2F39C8;
	Tue, 16 Sep 2025 10:05:22 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225082EF654
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017118; cv=none; b=qAQ/x6n+26m/G/3M3WpRBjKa9j01eVgT4fMHTiZjH1BUtkhrQbdDiGQfSESwjioeEfz+R8Z6V5stWueDBGvO62ZHakeKQtWKy30mxu9XUWxJCMffFaI95L/fFNAKCQnV7zjoRwJ4MgasOmab3TE4paWTLJlkxJj00vW6bmF4sVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017118; c=relaxed/simple;
	bh=5b4qRo0dPkp4NLHemiLT6cf5xcdm+OtsNLS9Wwf0q4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COp5XXqNGwnYawvHkEfqrun4Zuum/M1oBcVvRGX83v229jjhxugy/6iTJx0ZIzUiFUBWiS2KARmvq8s6ZPEqe81WGvtX+xgkm7DOQ9Se1vGfUtq6kIgXN/lpk17D4/jkm5VRuWLajJPYuKlZ5Ubqmy9HwTdfLU8I10WVpKfNOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=unknown smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58GA4SR4067802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 18:04:28 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Sep 2025
 18:04:28 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Add maintainers for Andes QiLai PCIe driver
Date: Tue, 16 Sep 2025 18:04:17 +0800
Message-ID: <20250916100417.3036847-6-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916100417.3036847-1-randolph@andestech.com>
References: <20250916100417.3036847-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58GA4SR4067802

Here add maintainer information for Andes QiLai PCIe driver.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6206963efbf..056fecb50c5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19254,6 +19254,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
 F:	drivers/pci/controller/pcie-altera.c
 
+PCI DRIVER FOR ANDES QILAI PCIE
+M:	Randolph Lin <randolph@andestech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-andes-qilai.c
+
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-- 
2.34.1


