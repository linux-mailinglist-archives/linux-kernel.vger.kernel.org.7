Return-Path: <linux-kernel+bounces-758087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEFDB1CAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766F95612FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53329CB4C;
	Wed,  6 Aug 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9x1zqNr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191D25B305
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501100; cv=none; b=c9I48JAp7W7CXQhPBvlQFiwSF1oC8gVox/Mzg82EksZH3bonWXP8aXPMUXxxHIbIwGh23KKAt/M3WzMOQE97L8t6+S43ODMBXxQ23CBelXY5mXs/nC64x072wLoLBxepFb+WkM/DjDr2I9jwcek9p86LcjnVIIhUEOrinaVD8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501100; c=relaxed/simple;
	bh=V6qM3QSLkAmMPWz06UxQ5gAIIM1nPtIIDCX8bZ9AiyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2RmeTWHRQ6Q+8B9BOkBnygtqUbM3BxUtV7Rzf1oYcg8s4fkGHv79pTEzu8RTBdJOQx+uvk2UtGXn0fBF1Qs5kvmPWwrKLfpQda9FQi6j4sTUoWpyFkCqKEvzsCH1dmxEufB9DFPbaFqOEN6ie1xp7UaAC6XPBkKy3T2P+Vg/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9x1zqNr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ETLPQ006525
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2yhdVrPdYJ7313w6RY95BktNYD9XmUlNPwz
	5ARnffxI=; b=i9x1zqNrDaK75xJaiTUL4acdrea+2ki/iSYOkJ1mwQgNIPkHKnx
	/caNZ4oCcS0i4arjiUbnaHzvOAbDtoo42Rzu9S32GHL6MwiuQAf0Ab/uxDKTBHNO
	zJhMhAOtyjglRAikS0Z1phXp8REJHLIFhAdNeNUXaxPtlgoZuQmo2gJ/BWvlEnud
	Bk9VrcRIUT/grn0X2TP/e7+r0bcjZh6OrNJDPHpDOHeIzZ3efc4OBftcYV51JRpp
	9jLUtxuQeO1zrYLtWwyQ5p+Z0b8PXAF79BBpboGa12qti09OQ5NfBKQyzGV3suvY
	2kvt8vTyDqJn9909iapx4K3x2UY990Wi6uA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u20hr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:24:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eb41391f3so180553a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501097; x=1755105897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yhdVrPdYJ7313w6RY95BktNYD9XmUlNPwz5ARnffxI=;
        b=qeVLNrEXKHuQI+suVI6jW9uXQETKLKW9yfLkxqgUUFwMxpep+WoYpD7s6muYszhspF
         thPgdosGJCWvO3xTECi4MHP51Q4A6CdwW9AZh8yVcZGt3Mu/vaefoXM46irSFr+mqCKO
         Ro2irCl8mOB6sDChXiKXLU/HI08AO2cWoN9/ZI9naJy5ctbJ5Qk8lU0i4PHFo4zjT4qs
         Vj7tp5q6P4CqFDSBJhcoy0QQY/M5zernkLHQ1ZCRA2YxWK7XycGtfBLqbToHZiKorrHb
         HBM2Is0ZY/kEfbxjnxntElzXUFNVBS6tH0SrvCSvU0cFBhCrWHcpf4RBNBDxdoiKLBrM
         BHcA==
X-Forwarded-Encrypted: i=1; AJvYcCUPjdqI+M7yMJacVRUGOQq9OZtpVGWejYg8WZID/2YDSmlX1VPynDBfiuEa+wx6Ec0YQWrERl9SV0lganY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwiYXqM2gQWPaVFJpu4dPLEBuJKVBbmhsU2V4F0iqMeZF4d70
	OHKBAOLG3M2guDnnEtrKGq+UFazoXqUw75Ok7MkC+0/jo/whJSLaEySSQHK8WMKFlEYb9KpOEQB
	O5F5KubAcW7bFD8yg5ZuIhFtQbtwG8dJxks9HPjM3tTKS5Z5jBialPM1wghT24eRzKL4=
X-Gm-Gg: ASbGncuLAFcP3bAHOgJj5GvhDZPXD45Ba3PuQ1L+FlZQZMRCLa5nXhjh6nQ8leb7iO1
	IigizcGRRkJfS4QDLtIW48S/CC7OJ/RrROAFUh5oNmnd+WZypFKcrylRYyjsFK4XM7brBWH6VL+
	s5SXy/LRwSiHP98k6tp3Fz7u2KhNMS91Wk4cSY7dT0ex0m2bWYbBjC5D+KMhvTadrqqwfLnartS
	iwwAf49xR6FnsWw+PtCjWnZWAyqbPRVHLvoV+/AMqgV3MOdJpLD7fJleln6v8ugvfgTXge2qsPC
	5yJoQvA3XNnY/9u3piDGQNoXsgpMYshaYhoaKD9MqGfyGkBRaEyMq+RLO+gdl3zKmId29MWzj2L
	zEG8UV9+IHBQAlTopHvae7+USut0=
X-Received: by 2002:a17:90a:e7c2:b0:31c:15d9:8aa with SMTP id 98e67ed59e1d1-32166cd17a9mr4549967a91.34.1754501097285;
        Wed, 06 Aug 2025 10:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvDEwSlHJQyhjgkPGxkKpmWN6y7svvNC43yuKIxbTYzcP5aOBqMSDCeOEpZxX2CjbPjhvrVw==
X-Received: by 2002:a17:90a:e7c2:b0:31c:15d9:8aa with SMTP id 98e67ed59e1d1-32166cd17a9mr4549942a91.34.1754501096842;
        Wed, 06 Aug 2025 10:24:56 -0700 (PDT)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49c7sm19963244a91.21.2025.08.06.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 10:24:56 -0700 (PDT)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [PATCH v4] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
Date: Wed,  6 Aug 2025 10:24:21 -0700
Message-Id: <20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lRMPBb1sy7c87fa1NWisuqS-VgqWww4K
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=68938fea cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Q-fNiiVtAAAA:8 a=rKm_hocPtqpBwuZHp4gA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: lRMPBb1sy7c87fa1NWisuqS-VgqWww4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfXywpEAhyOzqSk
 HECmcmwqZsnJlUAtVMEGzrWP2G+WxO1otPdY8veJSa0z/QqrQrxnqie4S5bEZa0RxPiEvV/TH3L
 7o8NrevAw5DlR5UgOJRSxVACVSLDftUG5iJoycSn0SAN5lE4QGCDliuQYP+UTw+Egq+iycLWupu
 DtLDOUGg/d5hzcfEx0eUq7nTyo8p4pMkLGXfbrnS7GKNVlnEUnOIU52d7iMjI27OqBHJuB3M7OP
 tvuYNfQ9QPbK+C6dSBwrAW4q/+p+4y+Hcq/xUx6PG7P3mecmi3Hw9fx4Opmnc9YPRWFBkQaNDwo
 pbvPkGONNbfxZASZrbJyxehXM1uZsYIdx5oQbGmVDqoKHTt0WhVxyHW4jLd9LBLUKMA5vdTSue/
 lYP1KCkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

Restructure the call site for dma_contiguous_early_fixup() to
where the reserved_mem nodes are being parsed from the DT so that
dma_mmu_remap[] is populated before dma_contiguous_remap() is called.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Tested-by: William Zhang <william.zhang@broadcom.com>
---
v4: Introduce static inline funtion for dma_contiguous_early_fixup() in
    dma-map-ops.h to avoid compilation issues when CONFIG_DMA_CMA is not
    defined. This allows us to drop the #ifdef check introduced in v3.

v3: Wrap the call to dma_contiguous_early_fixup() with a check for
    CONFIG_DMA_CMA to fix compile error seen on x86. The __weak function
    definition introduced in v2 was not sufficient to prevent the issue,
    so remove that as well.
    Also add Tested-by tag from William Zhang.

v2: Add a check for the "reusable" property to narrow things down to
    only cma regions.
    Also add __weak function definition for dma_contiguous_early_fixup()
    to avoid compile errors on architectures that do not define the
    function.

 drivers/of/of_reserved_mem.c | 16 ++++++++++++----
 include/linux/dma-map-ops.h  |  3 +++
 kernel/dma/contiguous.c      |  2 --
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..7350b23cb734 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -175,13 +176,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+			/* Architecture specific contiguous memory fixup. */
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+			    of_get_flat_dt_prop(node, "reusable", NULL))
+				dma_contiguous_early_fixup(base, size);
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-		else
+		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
+		}
 
 		len -= t_len;
 	}
@@ -472,7 +477,10 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+	    of_get_flat_dt_prop(node, "reusable", NULL))
+		dma_contiguous_early_fixup(base, size);
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f48e5fb88bd5..332b80c42b6f 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -153,6 +153,9 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 {
 	__free_pages(page, get_order(size));
 }
+static inline void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
+{
+}
 #endif /* CONFIG_DMA_CMA*/
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 67af8a55185d..d9b9dcba6ff7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -483,8 +483,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
 		dma_contiguous_default_area = cma;
-- 
2.34.1


