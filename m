Return-Path: <linux-kernel+bounces-629750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5EAA70FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48581B66AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C724E4BF;
	Fri,  2 May 2025 11:56:10 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2B24676A
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186970; cv=none; b=b3p0oCm1c6GUt4ZKgSaCPJZHnTGNBICOWD5vd8lSMK7ty83qGMkHSrybmrWgQHK7kzWsCgyivFO91Je88YN6wPsXIk2pkuqeRgUjxu6yKlL6yreiuKzOrokwyWrLMWKmKCN0GeJ3ji/aCO8h/XNYYokImyWhH+jfwGTnMgJlA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186970; c=relaxed/simple;
	bh=letA9dsi2lcAXXHIjmfW26gJ0WuEb8Yj17N6ppRV9ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RVT0eAgX2/zOMp9t04j9Tnv8d3iLSxuglXveEwI1t/2LWsQlMiG/pXvmkNtp1+jltnx08uPp9nwGdmsN3HPB1z48gOA5xF0RAV9KWOrVzOb40BZKeEag26XHszv08oz2yDsiK869OHlTLG5aBjuaaTpToskT3PKikZto+FAqtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 13:40:56 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Fri, 2 May 2025 13:40:56 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Topic: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Thread-Index: AQHbu1cR+sKkXAZoXEOAUfrcrER15w==
Date: Fri, 2 May 2025 11:40:56 +0000
Message-ID: <20250502114043.1968976-3-john.ernberg@actia.se>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
In-Reply-To: <20250502114043.1968976-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2955B14453667460
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Needed by the eDMA v3 DMA engine found in iommu-less SoCs such as iMX8QXP
to be able to perform DMA operations as a Xen Hardware Domain, which needs
to be able to do DMA in MMIO space.

The callback implementation is basically the same as the one for direct
mapping of resources, except this also takes into account Xen page
mappings.

There is nothing to do for unmap, just like with direct, so the unmap
callback is not needed.

Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

I originally exported dma_direct_map_resource() and used that which
appeared to work, but it felt like not checking Xen page mappings wasn't
fully correct and I went with this. But if dma_direct_map_resource() is
the correct approach here then I can submit that isntead.
---
 drivers/xen/swiotlb-xen.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ef56a2500ed6..0f02fdd9128d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -285,6 +285,20 @@ static void xen_swiotlb_unmap_page(struct device *hwde=
v, dma_addr_t dev_addr,
 					   attrs, pool);
 }
=20
+static dma_addr_t xen_swiotlb_map_resource(struct device *dev, phys_addr_t=
 phys,
+					   size_t size, enum dma_data_direction dir,
+					   unsigned long attrs)
+{
+	dma_addr_t dev_addr =3D xen_phys_to_dma(dev, phys);
+
+	BUG_ON(dir =3D=3D DMA_NONE);
+
+	if (!dma_capable(dev, dev_addr, size, false))
+		return DMA_MAPPING_ERROR;
+
+	return dev_addr;
+}
+
 static void
 xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir)
@@ -426,4 +440,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops =3D {
 	.alloc_pages_op =3D dma_common_alloc_pages,
 	.free_pages =3D dma_common_free_pages,
 	.max_mapping_size =3D swiotlb_max_mapping_size,
+	.map_resource =3D xen_swiotlb_map_resource,
 };
--=20
2.49.0

