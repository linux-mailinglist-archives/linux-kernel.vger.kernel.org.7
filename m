Return-Path: <linux-kernel+bounces-643688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B4AB3058
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 09:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0EE7A72A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0325256C62;
	Mon, 12 May 2025 07:15:01 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C0248F59
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747034101; cv=none; b=YplY0AW8uwasnCxOYnHFayRrnS3MVuKot3rywgCpdA+TjOg5vsXmNtZSGOf4sa+OqCsFdKqwIkh3l/wCHMesxAjN9VS2+LCeHg2XFlg/qYJxJGErkhdDkWytxkCNueQ/z2Nkn8LqIAnCRWnKKol5MBV5QWPuNv5yud9wMy9z0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747034101; c=relaxed/simple;
	bh=Cbw+2lbNzTl44Wt8GRwA6T8D6WhEeQvbiA9InX1p4+I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZvC6Aq/yZtpuougaHovUlHBPTdU/LjjO/uvy3/foDjBfZWXDxj67uU7prtNJ0gR0WgbCjiU4+joR1E9F4jyX0ECX+MbWZdqFMJvuSHJNLpSJR0U7vroI4F0zzU51MR8CG6AMyKjnIlVu38xD8e49IYlvHdWtRh214dXwM67Acbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 09:14:50 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Mon, 12 May 2025 09:14:50 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2] xen: swiotlb: Wire up map_resource callback
Thread-Topic: [PATCH v2] xen: swiotlb: Wire up map_resource callback
Thread-Index: AQHbww2MQ91Fme3GEU6/lmK+Crf+Dw==
Date: Mon, 12 May 2025 07:14:50 +0000
Message-ID: <20250512071440.3726697-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453617466
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

When running Xen on iMX8QXP, an Arm SoC without IOMMU, DMA performed via
its eDMA v3 DMA engine fail with a mapping error.

The eDMA performs DMA between RAM and MMIO space, and it's the MMIO side
that cannot be mapped.

MMIO->RAM DMA access cannot be bounce buffered if it would straddle a page
boundary and on Xen the MMIO space is 1:1 mapped for Arm, and x86 PV Dom0.
Cases where MMIO space is not 1:1 mapped, such as x86 PVH Dom0, requires an
IOMMU present to deal with the mapping.

Considering the above the map_resource callback can just be wired to the
existing dma_direct_map_resource() function.

There is nothing to do for unmap so the unmap callback is not needed.

Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

v2:
 - Just use dma_direct_map_resource() directly (Stefano Stabellini)
 - Incorporate some of the discussion and explanations from v1 into the
    commit message (Stefano, Christoph)
 - General English improvements in the commit message.
 - Just this patch now, 1/2 in the previous set was applied

v1: (series) https://lore.kernel.org/xen-devel/20250502114043.1968976-1-joh=
n.ernberg@actia.se/
---
 drivers/xen/swiotlb-xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ef56a2500ed6..da1a7d3d377c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -426,4 +426,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops =3D {
 	.alloc_pages_op =3D dma_common_alloc_pages,
 	.free_pages =3D dma_common_free_pages,
 	.max_mapping_size =3D swiotlb_max_mapping_size,
+	.map_resource =3D dma_direct_map_resource,
 };
--=20
2.49.0

