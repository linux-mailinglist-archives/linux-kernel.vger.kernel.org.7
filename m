Return-Path: <linux-kernel+bounces-722048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45363AFD3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41471188EB36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09C2E5B09;
	Tue,  8 Jul 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwiVprnC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD52E5B08
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993821; cv=none; b=vETiUBaEq+Wp37iCsfI2ywqnU/fJYfQUBi3Ux3JSUIiZ4naS3gNHDbyMR9c8crgHPuf23kJaUeeXiiP4WqTHJkLI/e9o+UMnc6rNUelMMI5BsUsrU2zNVG6X+y9yD9s6l31JutGyQVb5aKAiVu9beQ9be14kjS97dzrapg6XvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993821; c=relaxed/simple;
	bh=Jg6cutNa4wTuOT/R/PBaYwp8fpjwjRddjQ2/p/+s89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7vSIBdzOsgSXpEZ+zNZnboFBOR7TVpHsAQZ0xBOvrWGWvH2ihSAC8PsWa0dO1vb6AN+/3o6fwpyd7jzYrWhrAjP3/DTU/bnMy01q2r2mcLxNrdJVvbFfbxBxze+EYD+ewbVsqye+ZRqT2WNUEkazhPIQxHOPlDwkY47ByCTsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwiVprnC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbEu017096
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 16:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WUhkVAeGLeKaNSN8AVmxhb1CINCnyT16ePT
	Qp8qzBLo=; b=iwiVprnCBim/pwSuMC2ak0jO/SCNNEk1dfljlHQhWFV+RgIOSF4
	8x3VNb2cq8DoWzS89s3B6KkAcAl1ipKr3WKRXAIkHdGQpcQj3/jXijAW5hH5tWpG
	uBiRHMEW295kD/8BKmBk07afQsRghZbajQtd7fzdBoZwmUJpLqutx8nzlPtHxDPr
	bHOPEHbnJ25GctFoOxrFMhv1D1M/GunAJaav3VOwcTzCZyGe+sZ/JHjihnISRCEF
	l2ceBzAgFKx9WwXAr9gC+lpEzinunNt8OYtFgdfVfvzrLWEd0gVxB5eaEeXBLu05
	/k/Ek5M0xtlTYTnYlQMkttVxBHsyUcmIaqg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkqrp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:56:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b0e0c573531so3114933a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993818; x=1752598618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUhkVAeGLeKaNSN8AVmxhb1CINCnyT16ePTQp8qzBLo=;
        b=sptme2aeKEJUxQXfBDoG3r0nx1aQjo9wh3Hiia3ian1EC1h9OqqgaUqaYAC5qc6N4U
         rMcLfpA1pVpvOyN43TBmHq/1+12s37o7E6X3hmwPBgfDY0UKylCeJwYvuC7cTZH8m+AW
         iCh729JLJON6Yn9TCRWigdeyt06PjiHVFm92/xehCWV5ilf7Svc3mrAAnjOl/GQpm79W
         anwEzi1JQXDTAXUIaPOn7w3PBr3cJl/H5BIU5dZ+snhB97ObYDmg0SOFZOWDGh/Z5cif
         9TELG9xe12Oc3lhrS0fYr4eO1CttDmxsDdvtvPSMwMXRkbD439qSNkMJTiGH/Crv1Zmf
         ZUZg==
X-Forwarded-Encrypted: i=1; AJvYcCUzrtJ2GbCLtPVmcITRHQKMP7NN/46i8YEXel8m1ocK6M+gWV4QN9O5geBtjiAepKBst8iZN7Of1Nw5Yfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTLy3e/Ir7FH24803994cAai7l6hhqHZUfVIMT/nCqDgss0VU
	XnpzBASmAWT36/Y5hUvGlXY29v4s/I0a0GPIz4S6oZYBRGWWofhm5jjUiy86iNI2j4PcKOYax8e
	xsSxa/D/IYHGeOnGgMUAoD8cmY47ZB2Eu5tCoamOY6kFijCOSPeKCh1Q4wxag8W3A8fc=
X-Gm-Gg: ASbGncta0AZ2dHJgpdPZrD33mf2pgq7qxvDntIbeyO4is8AyfyiFEdD1TZ7mUw29rRW
	QKsG235YYdqoqxQXcexgn0+gHrcbtHbrgSErsSSqpqr2BxpwdVaAjQ8hKD2UMEe4nrAgT8W4LFn
	Np7PTnNfNCzjCO8kCOWiXQaeMTFwEAGb78uNXaTdnZwEfA5N5p2/4bm9n3B5RfqatNB6HSgHnXH
	X/grSiFcFZXJHicIxcGYZkg0vk7Y08tfxJViEVXT/7mWgfFfUnOncM2mslcppb1guGfvfGGHsBI
	j9pUuZ7ub3yOFPsLCaJ+pImrWxlspa23GWMkwdt1SyUDM6FfZ8UozqslWgFCb7J/HaIFQ1OdfUj
	4DF49UEgf2A==
X-Received: by 2002:a17:903:2352:b0:234:bca7:292e with SMTP id d9443c01a7336-23dd982c7a1mr3703815ad.14.1751993818312;
        Tue, 08 Jul 2025 09:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcNw1wDJD3D+XT0Ei373cW7Pc2/gf94PN0YMqeTOB1MGWQEUOYM3VpYyc41cGoWyfIaY6gg==
X-Received: by 2002:a17:903:2352:b0:234:bca7:292e with SMTP id d9443c01a7336-23dd982c7a1mr3703505ad.14.1751993817865;
        Tue, 08 Jul 2025 09:56:57 -0700 (PDT)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e4dasm124569365ad.30.2025.07.08.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:57 -0700 (PDT)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com
Cc: saravanak@google.com, robin.murphy@arm.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [PATCH] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
Date: Tue,  8 Jul 2025 09:56:27 -0700
Message-Id: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MyBTYWx0ZWRfX37TqBD11TlWw
 kCRwCZBJGElU7BjXeiEy0txKtVyzJhOFc8nxUdPGJ9H3jAAPBDN7uF8H72YJv94a5bzciUxivj2
 MY1c+PDCTvd/OLSX0aWW0GDxsJfmRd0xBdcK+aH59CdCgxRDLN79/mN9A4m41pJiIGOcmXc9MY6
 oFCxQRxDslw7yhTSDu71orGAPt9wmu4QhHVM6zP/6zpapi3wL7uTZqPYvYq0AdhhbPLmpIQmD+4
 T7nIkXbBEW799KaquZ7KC611m29y9XxmNbvt5pAuq0PAO8UHS80UgNAbn0D0SRnlZwx8bVEu4KW
 RQ64i29ju+/MQd8EVUXj6Okq5sx5s0yNeSPCvZ7Bau1iMmvniS0QC1lplEScFVoal/xf5H8Bc30
 jOp7QT75qwmS80pVhnoSnra3ddW+LwVU89rXm+yUhZ3UWhccyxDRHOWy2FiU+quA+mtG6WGM
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686d4ddb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xFDPACk5BDkwkGjAhYwA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: zTbr7z7sLFMD56p5qhNvJx4YHPd1DJtr
X-Proofpoint-GUID: zTbr7z7sLFMD56p5qhNvJx4YHPd1DJtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 mlxlogscore=709 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080143

Restructure the call site for dma_contiguous_early_fixup() to
where the reserved_mem nodes are being parsed from the DT so that
dma_mmu_remap[] is populated before dma_contiguous_remap() is called.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
---
 drivers/of/of_reserved_mem.c | 14 +++++++++++---
 kernel/dma/contiguous.c      |  2 --
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..132d2c66cafc 100644
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
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
+				dma_contiguous_early_fixup(base, size);
+
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-		else
+		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
+		}
 
 		len -= t_len;
 	}
@@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
+		dma_contiguous_early_fixup(base, size);
 
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..9e5d63efe7c5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
 		dma_contiguous_default_area = cma;
-- 
2.34.1


