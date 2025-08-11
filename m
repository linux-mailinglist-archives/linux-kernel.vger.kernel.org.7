Return-Path: <linux-kernel+bounces-762519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BBB207EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3888169735
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A62D3A90;
	Mon, 11 Aug 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Lk0puRLj"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2D2D3226
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911745; cv=none; b=WCmM34i6+ebD+CFnXE4Hmf+y2Ili5jM2jVZf5aISq5qQ+BelVc5rLNtsagDp6xlE9CA5L+z14/V6gKIysJ+jnCgVtVnO3Z/Xx04A191wJadAI5zMT2HakDFjICaUFHioyFA84/WQZrW7yVL+FbM+PsACCmDJ1UaJbGDITjMPF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911745; c=relaxed/simple;
	bh=/KUdXEnT6GngOsUr1f61zrBzbdJM9jVpR+K4iy8BCgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iaKtNGzJN/3AI8RjCjlG2ljNfn4V48CrQEjWn2pv3IVXc2f1cUKwKHzstr4yOsM2Hovg5dC39+Z+p0O8/Qm15o8tESodhl70ynwUEVIREdCNL0eWJ5OHSzht4idyoZCVSKH932cOwbAlutRHmQOCfovUcqrLuTEWYiyvABxfBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Lk0puRLj; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BA0nP7016844;
	Mon, 11 Aug 2025 12:40:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=8HWQrCacvIqefoTFpmFUNE
	ixtH7VaSDKX6i02UeuwdU=; b=Lk0puRLj0Ns3EzaKG0iFMFPnpfVV08bF9W7otb
	YKDsWgnRFTWvY8oSKcFhfXacwD3AtG08eXRf+AyWqUSuGem3qxjbmmz+n6uBpfBR
	CDfuVrkjmsQryuVk0yZ0rPIcjr55hXXRRhXtctTbEuZFLdSGqhPBSpciUobfY/5v
	86ndyG+Oh41ry1ZC/uxFZ/jR3vsr0Yzdi8uMZS5jD9xmt5/t4y9BDd6fuB+8BMjc
	D90tofH6z6MnJLU73wz/IaFpVi3hHxxz2TCSaB1HOb1L2apCGvGI8hk/wZIs5ny+
	+By9VS6hknhIe5aGCVvAM/kmG6mnUF+FJPtjxXVm0izsQHMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48dwp1p0vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 12:40:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5ACE740049;
	Mon, 11 Aug 2025 12:40:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B02772C6E0;
	Mon, 11 Aug 2025 12:39:50 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 12:39:49 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <maz@kernel.org>, <tglx@linutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>, <mani@kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH v1] irqchip: gic-v2m: Handle Multiple MSI base IRQ Alignment
Date: Mon, 11 Aug 2025 12:39:42 +0200
Message-ID: <20250811103942.4144-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01

The PCI Local Bus Specification (section 6.8.3.4 in Rev 3) permits
modifying the low-order bits of the DATA register to encode the interrupt
number. These bits must be reserved, but the base SPI may not be aligned to
the requested number of SPIs.

For example, with an initial MSI_TYPER base SPI of 0x16A and allocating a
multiple MSI of size 8, the offset returned is 8, resulting in an MSI DATA
base of 0x172.
This causes the endpoint device to send interrupt 3 wrong interrupt number:

1st MSI = 0x172 | 0x0 = 0x172
2nd MSI = 0x172 | 0x1 = 0x173
3rd MSI = 0x172 | 0x2 = 0x172 wrongly triggers the 1st MSI
...

To fix this, use bitmap_find_next_zero_area_off() instead of
bitmap_find_free_region() applying an initial offset of
base_spi - rounded(base_spi, nr_irqs) to accommodate the required alignment
for the first MSI.

With the above case, the returned bitmap offset is 6 which results in the
correct interrupts number encoding:

1st MSI = 0x170 | 0x0 = 0x170
2nd MSI = 0x170 | 0x1 = 0x171
3rd MSI = 0x170 | 0x2 = 0x172
...

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Changes in v1:
   (Marc Zyngier)
 - Replace the incorrect usage of msi_attrib.multiple with nr_irqs
 - Reworked changelog
---
 drivers/irqchip/irq-gic-v2m.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 24ef5af569fe..2d5cf36340b1 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -153,14 +153,18 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	msi_alloc_info_t *info = args;
 	struct v2m_data *v2m = NULL, *tmp;
-	int hwirq, offset, i, err = 0;
+	int hwirq, i, err = 0;
+	unsigned long align_off, offset;
+	unsigned long align_mask = nr_irqs - 1;
 
 	spin_lock(&v2m_lock);
 	list_for_each_entry(tmp, &v2m_nodes, entry) {
-		offset = bitmap_find_free_region(tmp->bm, tmp->nr_spis,
-						 get_count_order(nr_irqs));
-		if (offset >= 0) {
+		align_off = tmp->spi_start - (tmp->spi_start & ~align_mask);
+		offset = bitmap_find_next_zero_area_off(tmp->bm, tmp->nr_spis, 0,
+							nr_irqs, align_mask, align_off);
+		if (offset < tmp->nr_spis) {
 			v2m = tmp;
+			bitmap_set(v2m->bm, offset, nr_irqs);
 			break;
 		}
 	}
-- 
2.34.1


