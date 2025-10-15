Return-Path: <linux-kernel+bounces-855362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79317BE101F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D351A20139
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3874420;
	Wed, 15 Oct 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N/ixgdCX"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54542A1BB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760570231; cv=none; b=kreFm35LIIOXbvt983DOsnyGCAXyF//gdM4+EdG1iDohtzJk79wa4MLrVoYaod14fHQE2WYUCr73PyMSFN5o23saPvbzfWx/guVxaZ5QbwFa/bUataRhAdZNUL9GzIKjcsCUJuFphS7Rena6lDaDMvetTSp47b0rZ4afI/vKHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760570231; c=relaxed/simple;
	bh=PHSFwd4j6Fc/XuDajy+FkvvaziSJLow4GyvkfglLEh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFLJQchGkT/1b45vGwwEaJ0uMbFs3nb1iuL5wMYtCDntLBf+QOm2cY+zqDeZP5ao1QFx+dBtjaRl7PMWUHUcN+QL5scB31x7XvwUwcrCf1mkaoIV5LVkhJToGfYIbZADWMwNnGGZL74nJQyCiETn13HVLF0WJD46M4Sz5i9ZEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N/ixgdCX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so62259a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760570229; x=1761175029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IagGahLCJcjv/4tVrKJllQzfU2BC7XPuWL/ZTsGJuPk=;
        b=N/ixgdCXKGScrakO7oN3NNq1MJCEeStKAKftqtYRdnN5CLYlTQ3agTK8dh4FjNRACo
         k/7JwXJaPRxk08HXDOcnzqjlEs6y4FpVqC3Qcbv+OVCv+l5x/WqmAnx4es7nCxmzNbYv
         Ph2KWoC9n6grmuLZhDVyURpts+F6PUDI78yH5OwQgTHm+UsmrRW2dn5pUruCsd/7lXtB
         TefvejwwV8oneV6brLJZ2D/Vsdh42ZlkwFQeHPjACqwYiPve0QbmEx0JruKKp+rQrAtz
         XL6GYmR/cL+MipHhkmYze2nq4vSW8Qvcd1S2HFPYDmclp2RUlrh0BhpRk86E/j/IQXMt
         ggfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760570229; x=1761175029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IagGahLCJcjv/4tVrKJllQzfU2BC7XPuWL/ZTsGJuPk=;
        b=s/n0INHMFhTgAhAbBB5MQCKfYUadGDVQ/Rm194PSUs7cOHzMre6Pq+OoxML2zHWPZi
         YJt8jVVjD0nGtH4CqjEe16wgI2ZwmmtqNN5kLKRX/WaDE+jV3tUXR3UQh3h/lOAHD6rT
         L48HaDjnU3V1Fha0F14yWzRZ7bvmldnJflgnZkOVq77unmqAnuuhr7NH4hueKXwNRE0H
         RjkMXMFKGcBNczww7NEJ9wrUTk0/d4Xnm33AUUJhYSsgPFjJJE0S3TtlEOPVygBgfPEO
         0XEsjpnVttoYSrep4YKqsmKzlLrEgcHJM/JnK3Q9Zl8Pw3pbF/PNJ27B3UGwz5M9Yx7l
         EBqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCNV8Gf4kbXYRrdbGb3IVZupTxZgZO7O+4eDWTjDmTlHeTYCaJIHW7wgDPoD4AcwSNPIw0qk7TkUVK2SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jn4sL+DjoNu6+PHOCM4uRcodn5K3syluQvGpUZkBECE3XnaI
	PNyyx34DOSLMBm58TZXVSKm9QRa+LFUleZLeI2C611jAc7Q11duurKvnpb4sf4Y+QIyiS/5ZITE
	2+Zgr
X-Gm-Gg: ASbGncv3K4ixhvE1YETlf0EIj7+ooevrl/F5Zx3evuyQAht/MEwBC+3dYJafbSFPCBR
	1PNbRQVVzS5qSTg/Bs4CzdYKz+fAuCpNSs22M63y9JG9YACcm2dF4owJ8CnO25DibFPPzHFFt8h
	RorWQJibzY4jSRl8zM50Glw9S9pizbyXRivZdfIkxP628ug19AZktyKQe+N/lLCbeVXW+UucIam
	6yuCWKhnFf/1w2WGlw3ELdchf7YhSjl/Lw8BGNGpWEpBMOlolec+hCzcrwSX9gwU1GwoHXZ2kty
	RrK42sbdfzkSeR/c4ZeeOD4NA7mNqno+uj2qI/pQMZL+quB5EIBeyIkMvLIpEh5yUwxgb73Rngf
	7OgCNJ1EUoo2gOcpivVzsCo9MnIoZUMNHF63j0DMv5SVmj8+6lMwm8qJLFV6W551gDFh+n0fgNI
	OvRPdRCmmTEhmD5okNMkaoTg==
X-Google-Smtp-Source: AGHT+IGMQRAE+iiwLBavCgsEdQ4KXqREat4zWnnUFPo0QgR4/WFRbsZ95tWKdZtPsYo/4SIhqxQhmw==
X-Received: by 2002:a17:903:1ae4:b0:25d:37fc:32df with SMTP id d9443c01a7336-29027402c61mr371847025ad.47.1760570228879;
        Wed, 15 Oct 2025 16:17:08 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288786bsm733067a12.5.2025.10.15.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:17:08 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: Use multiple ATU regions for large bridge windows
Date: Wed, 15 Oct 2025 16:15:01 -0700
Message-ID: <20251015231707.3862179-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs may allocate more address space for a bridge window than can
be covered by a single ATU region. Allow using a larger bridge window
by allocating multiple adjacent ATU regions.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
An example of where this is needed is the ESWIN EIC7700 SoC[1]. The SoC
decodes 128 GiB of address space to the PCIe controller. Without this
change, only 8 GiB is usable; after this change 48 GiB (6 ATU regions)
is usable, which allows using PCIe cards with >8 GiB BARs:

eic7700-pcie 54000000.pcie: host bridge /soc/pcie@54000000 ranges:
eic7700-pcie 54000000.pcie:       IO 0x0040800000..0x0040ffffff -> 0x0040800000
eic7700-pcie 54000000.pcie:      MEM 0x0041000000..0x004fffffff -> 0x0041000000
eic7700-pcie 54000000.pcie:      MEM 0x8000000000..0x89ffffffff -> 0x8000000000
eic7700-pcie 54000000.pcie: iATU: unroll T, 8 ob, 4 ib, align 4K, limit 8G
eic7700-pcie 54000000.pcie: PCIe Gen.2 x1 link up
eic7700-pcie 54000000.pcie: PCI host bridge to bus 0000:00

[1]: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/

 .../pci/controller/dwc/pcie-designware-host.c | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..148076331d7b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -873,30 +873,40 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		u64 total_size;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
-			break;
-
-		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
-			atu.size = resource_size(entry->res) -
+			total_size = resource_size(entry->res) -
 					resource_size(pp->msg_res);
 		else
-			atu.size = resource_size(entry->res);
+			total_size = resource_size(entry->res);
 
-		ret = dw_pcie_prog_outbound_atu(pci, &atu);
-		if (ret) {
-			dev_err(pci->dev, "Failed to set MEM range %pr\n",
-				entry->res);
-			return ret;
-		}
+		do {
+			if (pci->num_ob_windows <= ++i)
+				break;
+
+			atu.index = i;
+			atu.size = min(total_size, pci->region_limit + 1);
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set MEM range %pr\n",
+					entry->res);
+				return ret;
+			}
+
+			atu.parent_bus_addr += atu.size;
+			atu.pci_addr += atu.size;
+			total_size -= atu.size;
+		} while (total_size);
 	}
 
 	if (pp->io_size) {
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/pci-bridge-window

