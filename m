Return-Path: <linux-kernel+bounces-795953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23691B3F9EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5F162DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935A2EA46E;
	Tue,  2 Sep 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7O8Zs5js"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F120E6E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804341; cv=none; b=RD1tW+P5Q6QODOYUSnalJwoLctrBt6pGGY76ERcxQKfPuAHdEKvlky/ZkXfnALBVRQDR14AkO9kSRw3m2+wYMs1wETNBiiuqKT/wChq60G9S1jHZLxZiertm7W7PLPADAUSxJBsBVJDzxRfe7KEzfWKP7Ldh1P43WgbS1ZgVtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804341; c=relaxed/simple;
	bh=EAYuVJ1vsu8XF0k7emoGyublqi1Lw8s9iXpqg01DB/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpYW6R/6Xth/rWlRSU6Hate/uh+M/jbl7Iex1MJT8hG8dLklaGLo9wJlUAv69kgVLHkZpdYCHfw37YBrvNN629uRPqVXqrwyKSYXExUUBkXePppV/nxy/uoX8hgSQaWqAcbTkytGuASFrESAPRcMcHpspzt7MFVQZ71Dte1pFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7O8Zs5js; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5828lbYo000888;
	Tue, 2 Sep 2025 11:12:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=aaecNdmQjRiKZJguz7vt+C
	PGtlc/Ef3Ox4gaPS8SLbU=; b=7O8Zs5jsQ4za/Y3eJL/shgp64ezbCeXace0Bjp
	3qpJBvSZ3icz8GbrjE7LDkB5LFX5D4kX6cGfPPQIhjDQJzryCo/fGiqY/f53xrnT
	x84GyajQzFPOqzuraMcqoJVQK5VFmN6FETO5Ktdk4QfSkGyQFUyb0Giz7J4Cmy/+
	WL0fYaEVAGDMR47UhRuiNswPNijdiw506g0MtWFuUgf/D3zuUW/6Ih8KvEjzEOKQ
	VzIG0uiyZA2i2bAFl1mLl2ijq4aFHy6KXTizT5rCkY5ZqfZxFbSh4lRQRNGDptpc
	m3puQFOrYDwzT7djbvZ5c28vS1xtHt6KicHpoNrcRm09Oh/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48urmxaum7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 11:12:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 612B54002D;
	Tue,  2 Sep 2025 11:11:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1FBD4025B7;
	Tue,  2 Sep 2025 11:10:53 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 2 Sep
 2025 11:10:53 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <maz@kernel.org>, <tglx@linutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>, <mani@kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH v2] irqchip: gic-v2m: Handle Multiple MSI base IRQ Alignment
Date: Tue, 2 Sep 2025 11:10:45 +0200
Message-ID: <20250902091045.220847-1-christian.bruel@foss.st.com>
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
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01

The PCI Local Bus Specification 3.0 (section 6.8.1.6) allows modifying the
low-order bits of the MSI Message DATA register to encode nr_irqs interrupt
numbers in the log2(nr_irqs) bits for the domain.

The problem arises if the base vector (GICV2m base spi) is not aligned with
nr_irqs; in this case, the low-order log2(nr_irqs) bits from the base
vector conflict with the nr_irqs masking, causing the wrong MSI interrupt
to be identified.

To fix this, use bitmap_find_next_zero_area_off() instead of
bitmap_find_free_region() to align the initial base vector with nr_irqs.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Changes in v2:
   (Marc Zyngier)
 - Move align_off definition inside the loop
 - Reworked Commit Message

Changes in v1:
   (Marc Zyngier)
 - Replace the incorrect usage of msi_attrib.multiple with nr_irqs
 - Reworked changelog
---
 drivers/irqchip/irq-gic-v2m.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 24ef5af569fe..8a3410c2b7b5 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -153,14 +153,19 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	msi_alloc_info_t *info = args;
 	struct v2m_data *v2m = NULL, *tmp;
-	int hwirq, offset, i, err = 0;
+	int hwirq, i, err = 0;
+	unsigned long offset;
+	unsigned long align_mask = nr_irqs - 1;
 
 	spin_lock(&v2m_lock);
 	list_for_each_entry(tmp, &v2m_nodes, entry) {
-		offset = bitmap_find_free_region(tmp->bm, tmp->nr_spis,
-						 get_count_order(nr_irqs));
-		if (offset >= 0) {
+		unsigned long align_off = tmp->spi_start - (tmp->spi_start & ~align_mask);
+
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


