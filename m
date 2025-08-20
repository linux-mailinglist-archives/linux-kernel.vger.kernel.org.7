Return-Path: <linux-kernel+bounces-776726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB35B2D0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3C0583532
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DBC19539F;
	Wed, 20 Aug 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5FdaI3t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FE72625
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651582; cv=none; b=aU78lYDANjbcpvVwcYvfv36819lt9M+lSZ+21rEXV3r951Da0aeHSiQSUF90xvqBKWzHtFeH3kWTjpPFny2zjSK7uafruV8CdcMSRGuIVnU+HrPNUmVSdJEbUsGKuf9UL6GUpEDdQAPKhrbzHyoIQv3zndpWpyy1mD7XZe0T9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651582; c=relaxed/simple;
	bh=CBe3ItNfGcOAy9x2jUFrI3J0W3PPQajYTdJ5BqpwTGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rqJaRTeshOMk+xiB5Px3w+4IhZMKdpEfFFiFiLuVGyr8EPoO2l6iWtkfL6h/ircNEp7BTQz/TOTIKehSCQBbKWj1Vx3LKE8HFSfapMbdYZ8USJ3OLVoQCCALmCz06KI34+V2/GHx622S6N2UpWVYrORv9PrWvS822UGhu1yuiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5FdaI3t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL0vFP011121
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tgqDeb/Wu59YCnXn+qrsSc
	3XFwle/PbP09h/hojDfwc=; b=c5FdaI3tig5aZpOsKzPIRXdUSoffMADGS0I6Jy
	gS52HXa8CuYbg6u1u5WAk4wA1KL6gvVucbLhPy+0uh/bUtM598ZjVIE0s7oLMqA9
	OcYwIcRPVpjSqNaMi4x4X1haOqq+grMRj9Fk0ikqWe3f1jCFaTwhvWv24/PAoq/0
	/Ul5SUBN7wjVUF+bmuxaQ1UWc5hUMCQKND4RuayrtLE9gyw9EUcIQALEzxjXMJSX
	TkpVfXY0/eQfgVTvL9GEl2kV1feLesfcIpoL0U/bmmkJ1FaVlEap4vRj3C0xeSzC
	qXJGQnQwHbFXUYfslhLabm8lPuRjAGFDINCJwrM3B1JgtuoQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0td8era-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:59:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e54a1646aso3326809b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755651579; x=1756256379;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgqDeb/Wu59YCnXn+qrsSc3XFwle/PbP09h/hojDfwc=;
        b=e8puh7S5r6OZ4/iBVY/aNA1XltHzhOFUAojQlPTUCe5QKDGT3s5z40Nh30UWbGhpQh
         qm0RxvmR8iAfdk4K7NWTCX1p4cGGwdoHkWyvbAQa6GW5EMoYWtsgvMWaJjJKSqApLpQ4
         A4enwdsXMnfP0whUn7ONsuIOE/sr/9qW8zBUCcGI0IjXXm9KI4biLdEDkOe3t3AG051k
         fJ15AZDCwMNuzhdr9YHCqNTW2X/yHUJ6NFathOUdQ/3akvMhjkz4/28ssveqxRHmWTH1
         AMR43bq1qn59zWzdgIiK1KEi/0MxO1hY+naRrfDWNAvT0aduu02lw4+t8UD+gD8lz0Ej
         42Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU5nE4Gi2KnTX5tc0e8Dof8TieRZKAalB3GzHWY/ldzODWFkMbc2GLZpWxWeU6/5iUNtKi7dX52gKMeJug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeAJKHQZR9gt9O+gUwQqB8qSjueK8SpKUYafdI5TREYFbF6b3
	qHcRuHVVMRiWoPQNN6Jt3ydD3ZpQEI9IiLyiUIfwHd6Z/63rpJe5LLIMBIHrOJu1gA/e+PHKuhI
	D9HtPCdcbcd6y0KGS+V+efqJBwMAEuvQY2BHBfVNzbuvoYC6AaLgtEXltpYdL/badYHZq1sZe2g
	4=
X-Gm-Gg: ASbGncuqIntfUZl1cpp9M95PaaLaEQuPr9/5Fc10qkQ+JFqRF7q3UkxH8Oyo8lnh1CH
	oD3/VmVUbcwEhb5Axizs5HddMwM2K6s0UlTo3y1gKAJMUXUn37i506rqbbWWQSwFArrm8XU7p8+
	95wTPUwed8FdEc3nbr0hyYDn6gYS8S63F+/vBkiEixP7tRp+PGxnyl7rk/FBoT0EJ4pJKsmDauc
	MdS/cr7tijyVvDDJJH2D9zoinRDSz2MwDP99WzIL53tSyg6Eji2KHdNOiR+3xGW1WB9iamsNg0d
	nx52nHY90yKuTKFwhiNi+oxCFDsNVSn6oeJaF2k8BDE=
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-76e8dc8e43dmr1156675b3a.11.1755651578780;
        Tue, 19 Aug 2025 17:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwzabe7LAJIehOSscjgzyy6m4bK1mT4ViKPJGUPmEHGsbnZsBoCP7RnGxjujuJSMr6FkASjw==
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-76e8dc8e43dmr1156653b3a.11.1755651578242;
        Tue, 19 Aug 2025 17:59:38 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13ebdcsm3672630b3a.47.2025.08.19.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 17:59:37 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Wed, 20 Aug 2025 06:29:34 +0530
Subject: [PATCH v2] mm/numa: Use SZ_1M macro to denote bytes to MB
 conversion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-numa-memblks-refac-v2-1-43bf1af02acd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPUdpWgC/32NQQ6CMBREr0L+2k9aoEJZeQ/Doi1FGinVfiEaw
 t2tHMDNJG+SebMB2egsQZttEO3qyIU5QXHKwIxqvll0fWIoWCFYwyXOi1fordfTnTDaQRmsdaU
 F47UWsoE0fKTavQ/ptUs8OnqF+Dk+Vv5r/+pWjhxledbV0JeCMXYJRPlzUZMJ3ucpoNv3/QswN
 VIFuwAAAA==
X-Change-ID: 20250819-numa-memblks-refac-7b4b5017b598
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755651575; l=3166;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=uwvqx/6wxYcvRMmIDLsR1doIm7asXVLwPd2C3ZczI0c=;
 b=PHXOrHcYNJJO1gn2TEWd5zvXmQtC4s5LF+0wXgcRYMqipgGP/S5XHb9W8hBQxrK5qgw1ZmAsJ
 xuz2jfc62OdCv9yYSX6sG6gv7u49KUzTbNd4VrJJve/HoOW9iiM8ANL
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Authority-Analysis: v=2.4 cv=OfLBzhTY c=1 sm=1 tr=0 ts=68a51dfc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=zDO9BBgFI2vZD2P_t4cA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXxBNvC3X57qO6
 qtX1aTVQNSdmMR2zK/sXvIp3KJRSTRhKlflwW6eT0QJNxn9oAvLggCPzjxm3YazYgnVv78qXVEC
 4tMGqObZLq5DhxA5M6FWqPgXXLyCDJIn+goI1LDPr/UryJKXeP/Ms9a2vBSjuzMaG2jycoMMnC6
 CnlOn+tZrUunlajsnnXOc91/dBRhdelhAIuNBXlwZ1EVZdJzjJEPynPdSXBOUoYWin4lcQHw8qv
 rS2T6wvxxTH3MammuMVggkj6SHx5zBf+RqGmY1RRAAkzsn4Iv9IOVosIwjOBVN+aWwm/ZyTtiDQ
 IkNbSIKLFd4YuZWqUZ1quameByxQ6yA+43mxp2ebn1KbSuWvWWvNzwQPu7akN+Pojwat9iKNB7X
 MlIxesJeKrc8RDZbRuUgEtX4Goi02A==
X-Proofpoint-ORIG-GUID: 0MI78Q00ugspGJcJ_FnRtf2fWswBGRqP
X-Proofpoint-GUID: 0MI78Q00ugspGJcJ_FnRtf2fWswBGRqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace the manual bitwise conversion of bytes to MB with
SZ_1M macro, a standard macro used within the mm subsystem,
to improve readability.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
Changes in v2:
- Replaced the implementations in numa_emulation.c and memblock.c as
  well as per Mike's recommendation.
- Link to v1: https://lore.kernel.org/r/20250819-numa-memblks-refac-v1-1-936b4fd35000@oss.qualcomm.com
---
 mm/memblock.c       | 4 ++--
 mm/numa_emulation.c | 4 ++--
 mm/numa_memblks.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 154f1d73b61f2234efe61c5cce5105be160d0041..8a0ed3074af4b4dacb87e45f3fecaeb6b3222fcf 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -780,9 +780,9 @@ bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_byt
 	}
 
 	if ((nr_pages << PAGE_SHIFT) > threshold_bytes) {
-		mem_size_mb = memblock_phys_mem_size() >> 20;
+		mem_size_mb = memblock_phys_mem_size() / SZ_1M;
 		pr_err("NUMA: no nodes coverage for %luMB of %luMB RAM\n",
-		       (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
+		       (nr_pages << PAGE_SHIFT) / SZ_1M, mem_size_mb);
 		return false;
 	}
 
diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 9d55679d99ceea9807d41840cf097eb449afaf8e..703c8fa05048019317bc2a011d7b928884ddc934 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -73,7 +73,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
 	}
 
 	printk(KERN_INFO "Faking node %d at [mem %#018Lx-%#018Lx] (%LuMB)\n",
-	       nid, eb->start, eb->end - 1, (eb->end - eb->start) >> 20);
+	       nid, eb->start, eb->end - 1, (eb->end - eb->start) / SZ_1M);
 	return 0;
 }
 
@@ -264,7 +264,7 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 	min_size = ALIGN(max(min_size, FAKE_NODE_MIN_SIZE), FAKE_NODE_MIN_SIZE);
 	if (size < min_size) {
 		pr_err("Fake node size %LuMB too small, increasing to %LuMB\n",
-			size >> 20, min_size >> 20);
+			size / SZ_1M, min_size / SZ_1M);
 		size = min_size;
 	}
 	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a67e5b0ef66f4136dee268a880003..a47aa262a33366337c38ccc7c7064da818523dd2 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -427,9 +427,9 @@ static int __init numa_register_meminfo(struct numa_meminfo *mi)
 		unsigned long pfn_align = node_map_pfn_alignment();
 
 		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
-			unsigned long node_align_mb = PFN_PHYS(pfn_align) >> 20;
+			unsigned long node_align_mb = PFN_PHYS(pfn_align) / SZ_1M;
 
-			unsigned long sect_align_mb = PFN_PHYS(PAGES_PER_SECTION) >> 20;
+			unsigned long sect_align_mb = PFN_PHYS(PAGES_PER_SECTION) / SZ_1M;
 
 			pr_warn("Node alignment %luMB < min %luMB, rejecting NUMA config\n",
 				node_align_mb, sect_align_mb);

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-numa-memblks-refac-7b4b5017b598

Best regards,
-- 
Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


