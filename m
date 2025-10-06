Return-Path: <linux-kernel+bounces-842558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C36BBD029
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 05:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15EA1893BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A51D7E41;
	Mon,  6 Oct 2025 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="pNF5AX0R"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FDEEDE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759721951; cv=none; b=p/S4VMbKm+wtI2SRA5aSly8So6dsK63MQFy6WjLH23TxJPM8snWCp+FPPdel8VV9Me8Gm9FiQos7FxM5XrW9LwrnkVh2GcZWe9aSgPRaOYPjm0z4/aC+fo/iBFxhV8L6Pi7H+1XGs5bMZmL5aCHtZRfgYVnv9yF4iQeExu9RH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759721951; c=relaxed/simple;
	bh=kJNWRP5DCDkxO0lboqRRirH9my5mx/VItBrU/sSs7Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nvE/SJS4FWiSGexQnMz5wpZeXkhDdzLwihp5Nyba4RuN5REjTkGsd5v+MdGeeTNVM9p/Rkk3+p3JV9SXNIeE1j3DnDrMTYjFAd6sTTIu1a4dR+f4XlNaRo6A3OMOqaNst6nzIJA/5yD2fjBzRXwZWUqNRjZdxI9xbWf//ptFKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=pNF5AX0R; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 595M9nGi3626258
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 20:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=WBCyHfK4o+Q2PR2rOy
	/AoNTp5isJjB5KOObodqWMXLY=; b=pNF5AX0RItKFbpUfS5g8eZ+nxGk9RhmbI5
	2PLvhBNzKT/AFTJz6SlSOUMYj8fuczuHuGsu10WUNQudeAGlbyuADHVCL4kXDD43
	c0pII6YFgJieCTI86+S/5L4YAZ6GVbul8hCLMfA/NQiD741ogZyPIr7wo8cWsg9B
	rYH1VOoaRQ/I/0PrQ3xJRJ18T+OnOyn5Ft7A68USshQpqe40oiJGCFJ4qF3Zd7De
	YbnrwaWjzyCs5kOCZPzWaVVcW+GaQ45L2lVPoGSXNohV4xJRUi5mE7v4fK5x9/Uk
	SyBd93zWmWImiOZ2/gar4CEbnDQ5hiiXIQMtiugAdoTGnoF8sAzA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49m17t12mj-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 20:39:08 -0700 (PDT)
Received: from twshared23637.05.prn5.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 6 Oct 2025 03:39:05 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id D2395BB32B3; Sun,  5 Oct 2025 20:38:51 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Sun, 5 Oct 2025 20:38:42 -0700
Subject: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
X-B4-Tracking: v=1; b=H4sIAME542gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNT3bTMCt3SvNzEAt1k4zTjVAvzlMSktEQloPqColSgJNis6NjaWgD
 8hSoJWwAAAA==
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDAyNyBTYWx0ZWRfX0OjH81Vtyv6A
 Hm0SEwMepsS+70Dl+ZxHAHvoVrw5UDD534UNqo0PhodNyLjICEV/Cww8GJkNpntE4zOyYROmkRn
 PqdG96DW7jXL9T32MZyyAk59ekm79Tsx9mhVRJIifearEgRlO/SFb6HzAh+2+oIawkpk9Vq8D/U
 t/VNwnRE/knQ+pQrpqVoC2/EuD5TvIBVMLZWhd+lgnNLSN36b43J0GWCuGkVg2azUvLOIprh7Su
 sHkJB8+LEyFROaNlh5XufMrW3g/utUQtBYUoYeuwL+cpsHkc30r+k0CWyEAjhDmuQGZB1+h06Ds
 HXiDhQFTDE7hcG/TUak7tt0cZ2i++NE2RGBkr3EWzXZhdIJlZMi07mmrAjHZ/F+/jp9sYyS7wYm
 lYIJQOMBwEYQbsiDn68VooNFoiwP9Q==
X-Authority-Analysis: v=2.4 cv=SZz6t/Ru c=1 sm=1 tr=0 ts=68e339dc cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=FOH2dFAWAAAA:8 a=LPbsZmj_fBgXQ40ABJ4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y1Qck6zmGogmZm4FIE6pwVeYKHwmM_eh
X-Proofpoint-GUID: y1Qck6zmGogmZm4FIE6pwVeYKHwmM_eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_01,2025-10-02_03,2025-03-28_01

vfio_find_dma_first_node is called to find the first dma node to unmap
given an unmap range of [iova..iova+size). The check at the end of the
function intends to test if the dma result lies beyond the end of the
unmap range. The condition is incorrectly satisfied when iova+size
overflows to zero, causing the function to return NULL.

The same issue happens inside vfio_dma_do_unmap's while loop.

Fix by comparing to the inclusive range end, which can be expressed
by u64.

This bug was discovered after querying for vfio_iova_range's via
VFIO_IOMMU_GET_INFO, making a VFIO_IOMMU_MAP_DMA inside the last range,
and then attempting to unmap the entirety of the last range i.e.
VFIO_IOMMU_UNMAP_DMA(iova=r.start, size=r.end-r.start+1).

---
I don't think iommufd is susceptible to the same issue since
iopt_unmap_iova computes the inclusive end using checked addition, and
iopt_unmap_iova_range acts on an inclusive range.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f8d68fe77b41..08242d8ce2ca 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -199,7 +199,7 @@ static struct rb_node *vfio_find_dma_first_node(struct vfio_iommu *iommu,
 			node = node->rb_right;
 		}
 	}
-	if (res && size && dma_res->iova >= start + size)
+	if (res && size && dma_res->iova > start + size - 1)
 		res = NULL;
 	return res;
 }
@@ -1386,7 +1386,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 
 	while (n) {
 		dma = rb_entry(n, struct vfio_dma, node);
-		if (dma->iova >= iova + size)
+		if (dma->iova > iova + size - 1)
 			break;
 
 		if (!iommu->v2 && iova > dma->iova)

---
base-commit: 407aa63018d15c35a34938633868e61174d2ef6e
change-id: 20251005-fix-unmap-c3f3e87dabfa

Best regards,
-- 
Alex Mastro <amastro@fb.com>


