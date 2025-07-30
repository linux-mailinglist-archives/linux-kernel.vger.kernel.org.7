Return-Path: <linux-kernel+bounces-750049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFBB15683
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537427A980D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A0D53365;
	Wed, 30 Jul 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fk4ALxYj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C1182B7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835453; cv=none; b=XjR5NF+GdleUX6PN3+/1lKi74/u7vi54OljmvZxNb9IoQ9zmf3uR1lWsuPABgTRlPriw40ZVNCLtZIPd0Gzydx9MU/5tKEGj6v4TcBF3WEiKR+afGX2oAuzF3gKSHtACyz9t9UMgFPnPcOTIemhk3uwO9SjKZud189RPpricAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835453; c=relaxed/simple;
	bh=G2SWi+2j2+gVMvPBF4ZfD0nEadXhRsZtY7etyXycOHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgP5Zx3T5UwnuUoT10wuZb1ngb66dvnkNV8VilkVIpcieouYJ9OJNSyaaT0NVQL5pzRP8wJK3OC8HoXt0CMRLG19iuUDqq9UIEVzFQ2w9J2RTP9WSpaIanSSvWL0XuL53yih37JMWzto0KXXR1OPFMTEcZ1ZhJ+BFrQX+/SJv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fk4ALxYj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TIOhBP026749
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X9lUdenJ2kMNxoXUpZ8Aqx81K+8cmzCiCh8
	8gCuJ5+A=; b=Fk4ALxYj/nbPljx+y+1qCfdGb+ilruaLVfFs6ZAgOpxYEZ+Wpkn
	dXgM5LgHlKKriJDJZsAWYZ7AgIUM9pwC6QCaNjWZ4z7RBZ6CEzxMlJG/yqr00Yeu
	0yQfZWlt4xcxelW4PTJTEBt5h175SCTdgi0y12/VS/bsgBbo/R3pF2VnlhhIR8fK
	NTNGVfOSSgiesLOitNo9rBgQlD4/k3LENv4VSNchXkqxKM/MNA0FczQxwe/45X6C
	jiBp7w0edPdmDtlPWclGwuxbzmCA6D78jghPChD+5u6XNE2oYSwLfmgLGZFoa6KS
	j4+WDxxJY9U6bOC+obqSZVzLIL6IrgFgDAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xsuua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:30:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso4523545a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835449; x=1754440249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9lUdenJ2kMNxoXUpZ8Aqx81K+8cmzCiCh88gCuJ5+A=;
        b=WqGLoXwKeoARkLsd9MDKSol7fNTm1GfBoyOynoxl7PIyyXqi8Co1naAqtXDbYVJRvU
         mshwGIbHWdfwKCv+D0DuLOa66D03iLoq2UYYxT06zDdqfYz+kvigeIg/CMrm4Ve3ashO
         P5KoSNSyxpdApYIPGSiUjZWsT1wL8f1oNLbZPxkpQ80AeBoGRbrGo8rj77r6k8sZ7hM1
         xDCQAiB9L49L7vrGBNjvsz/C6zoYkKnICAfC/KNJGRWNN0qu3QUolT+LTtNorvPOIIwp
         9o3zyg1AP7obzAMr8AJrQS6YlP+AC0O63QczvK5EjRS9OloCpcQiM5457JbRuTXEs0Bw
         iy8w==
X-Forwarded-Encrypted: i=1; AJvYcCUt8Irjq+e+7ZtQa8BdOeWN1nmeLoBnP8Y8AsSf1/L8ka/lqF2ELy+YVf7di1SUwbn5aHnb1XwF0vHWX48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Pwn8A++uWnqqGDGz3ubvwc7xh/GeAHCE3IzQvx78yjs/7xpo
	U6ApsPUEySz2cVgs2Z05613/5nzdzd9YYGOrt01jwIlChqgs+fZanxJxL7LL4FI2ep5MR/7GjKx
	0Duz08ADhSMsX4ygX6HO9vgjOLwk1nop6C5ZIOO6IbrxUNtKDf/1xEGSixupIaPtEX0Q=
X-Gm-Gg: ASbGncs4ZGtr17hOItrtnzdie/xDUq/kabDlhcnOzvHqJyz0/2zz0fzh6r0OtLUFGCj
	ih1f0kgltxbAjKZmeASrwVhPhk2hK8LmeUEx5p0P1OSK7eAx3jYcxqJXF3/uh1DxcJkKkhGC3Q3
	xQdJZPLyWAkehoa1lh9zWTBs7rvUOMlkSYMSljgjK5D9rLa9L/sidMSfV7ZLiuuueJ9Q00YI6Td
	zp+GLGh63GZPEESeUR3/4cYYlI+sfEzOww041LOJ0laVgi5nr7YiYA5SJRCZj4GOcvjXX9XCe1X
	tjfVhVVOvNeVDiNNHciSJygw6/iY0c+x1lkx5Bzpm6wmN97SsrsODeTtLYRzB9CBsAU7B9im5A7
	8+Z5/n5R2ZCm0+p39pxQu0eMxMwQ=
X-Received: by 2002:a05:6a21:3287:b0:232:ac34:70ec with SMTP id adf61e73a8af0-23dc0ea7c93mr1921223637.7.1753835448598;
        Tue, 29 Jul 2025 17:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXj7G/TnKXtBi1fe1wzt9F05KCSBAlvRjrlMz0OGXrpqKtnB9Lz6S/vRD0L0OwLPRbTgxAkw==
X-Received: by 2002:a05:6a21:3287:b0:232:ac34:70ec with SMTP id adf61e73a8af0-23dc0ea7c93mr1921185637.7.1753835448137;
        Tue, 29 Jul 2025 17:30:48 -0700 (PDT)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c852fsm8489587b3a.118.2025.07.29.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 17:30:47 -0700 (PDT)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [PATCH v3] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
Date: Tue, 29 Jul 2025 17:29:56 -0700
Message-Id: <20250730002956.1812694-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=688967ba cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Q-fNiiVtAAAA:8 a=v9W1MpMA7iSxILOuClkA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: R1rPzDB685PIeHwadvt7Udf4dJU7dTfC
X-Proofpoint-GUID: R1rPzDB685PIeHwadvt7Udf4dJU7dTfC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAwMiBTYWx0ZWRfXxLZOZUBG8WzR
 K/2ObEp8B7FvFrg3BCSfub8JI4uV2rNL3WxPTuJxETjWtJk7ahwqZyCoj3JICy4bZP/Oeo8dcOR
 yWoC8EBaVmtKp1xlLFu4jPvWi/izJ87bU6ZDAw4Y8/RdGGn8zGVhHuP/BC9dQ8WZhnpQA9YrnG7
 CRLUN7g5UniOB5G4/LjHQtWz9HXQM7hhiMfx6z9N1YdMVwz5ud15B7isA7N4WlNRjiMj4qWz8uu
 Vb9YOiI8GEAv43YqaWwx6s/J7fJLtSTias/SnQ/UGXtnhB5lqYIkdYE0IVknxTHZPXZqxW01aMz
 zaYOXHAxRck1GYKC7Fljv9t2oaXG1qkBpvPdqCM76VKIlHt0wGy9gCDK9NmV5y1J4nBjwybZx33
 og8L5mz0jQubXk34SsCNG8Tw/HbWX7ZtzKrxv2s7nl4BHFSaNCvIEpomif92IvGJAEeXhjTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=538
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300002

Restructure the call site for dma_contiguous_early_fixup() to
where the reserved_mem nodes are being parsed from the DT so that
dma_mmu_remap[] is populated before dma_contiguous_remap() is called.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Tested-by: William Zhang <william.zhang@broadcom.com>
---
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

 drivers/of/of_reserved_mem.c | 20 ++++++++++++++++----
 kernel/dma/contiguous.c      |  2 --
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..cfffecb91c3a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -175,13 +176,19 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+			/* Architecture specific contiguous memory fixup. */
+#ifdef CONFIG_DMA_CMA
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+			    of_get_flat_dt_prop(node, "reusable", NULL))
+				dma_contiguous_early_fixup(base, size);
+#endif
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-		else
+		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
+		}
 
 		len -= t_len;
 	}
@@ -472,7 +479,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
+#ifdef CONFIG_DMA_CMA
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+	    of_get_flat_dt_prop(node, "reusable", NULL))
+		dma_contiguous_early_fixup(base, size);
+#endif
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
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


