Return-Path: <linux-kernel+bounces-775177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B3B2BC38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A462B62291B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76821315763;
	Tue, 19 Aug 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwXKZ2P/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F0311C07
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593513; cv=none; b=ep3db0t8p2purr6Wo5NsHu1M9lqHO2OJwluII0bF2KEPkvmJf49jvIHvRbP2wr7fupKDe8qHnOgodMtAQKZaOAsSrem9Ub3VZ36KDe9k9j598CfHth7i0fyeBZ9IO/Nl6VSaYFuuVY4qnD5ivxV9uo7ZmsUtym+nh1nv+1ze44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593513; c=relaxed/simple;
	bh=ANiqYqygBuucw6l4Je6RvILHlMLysiymX6SU3Gu1VAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pFV68JsJSplZMF8bTKHzC1X81ae/Gk3z3GedlGgYcTOUKiqShA+lGpK3OKB5848o0nWBDoKdCXZA22s+fbm70Z69ybw1bdSrtXsW5zA0Orla7Ra0wBvbuFQArw8fjzePt/UAMEk7hJ/8k97cyuopeoFXnozmxIWq0yvlwOEes4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwXKZ2P/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8pHCA011662
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UtaQEPA70JUUBbPFESCLHu
	D85Yw6S51mJSYTTPArkpI=; b=XwXKZ2P/CQ8X/woT44z55uo7ncMfCqf2oMNicb
	EIlmgCa5BazWIOtuRQjBP2ybBV6VjXZ2bm4hQj/PliTrp9Eya9SlDUeXvXVViSGa
	4xrJ5b+ATMif8ea6AzUP/p4acmCXpY4hXDZlTKSyjcnZJ+/BKlVE6OBqxGczSx5g
	Th1nvl1EFT5u2eraU8PwDcL5m/d1Ubgq5AQLOw5ZpmRpDYunhqvlCGyULIFcnsfU
	YpdtP3he/SLz2IQPxYhS/PagCtMmZqDLOoxSE8BYvKkZeLJoWc7qZPcSifWEue9a
	fsO3+DYxjnZD1E18GfXO5ZdTWqOOlplU02NHsv9OlAxuBdTg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ufx70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:51:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2445806dc88so128412055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593509; x=1756198309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtaQEPA70JUUBbPFESCLHuD85Yw6S51mJSYTTPArkpI=;
        b=lcU2uIzfAnkaBDZ6irhPpIZzq+pRwHk6nUIa3JE43Z4ZIUdsjdp1dpR7Uo+wdBbOyf
         AeQ41m+Pzd1+GZy4dIzUpL411/8MZ/Z1SnlkldS4uLeZKndda32JZozk4Q7PKevCBeXC
         yS4ic4uGwQStngopLgJ19aHXUNuInZ9zVFR9Q70bE9Mz/tzKiJC1AAcm6CBcAehduVSQ
         1h2bJg6cowegGdviBdKzJwi1EX8oUzB5v44w4DF5U84gl/QNY9Yj//Y8gjEJvz9DLDBQ
         5c9UfQqTEcQlRoJbsGu/T03Kx6RLltC8elEASL+ItEobe6CyPtvGfTmrPl8IGrsovapl
         jUtw==
X-Forwarded-Encrypted: i=1; AJvYcCWlMeWN/BRI1e4fpy+zm6Lf8yqFusYQb/Lm5wgwsSsL8e1NtCcaS9OGejvYXRuumwB06Ow3gwssT3q1mnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDXJsfhQwQT0GURUIXTHsRID12Ggc8eeqoXYAaSmE5JtFJ40M
	a3NtbcSOAGt1LSqPIx415TqPkSg6jcIwfiAV0siqE4h9kuDqkaGcIkvhDatsSX1T8QP8ynSQ+h7
	qP4RtmqBzatQvCgmRHpgiSWXjjYP/hy+cDjjy7+sFIdH6KSsmZPabsWU1pE2TgG4eLcW7fzL8yU
	4=
X-Gm-Gg: ASbGncuPUhhgGs3S9I7GzeoESzO9YYWb3vpL103hDvwL8cLCkjOQ3tIFdVw1J/EXlg6
	5sErs++jNdqbe+x8OROdYrAIF9pDvcokMhrnVcisDN6YtFE5IlKreId32JIV0bQ4gIcByI1pG9f
	eILeB4R00KBp+ta4gZItZyvEF3N/3b4Vk6O++R0gmH/3d7PG7FaulGPgBtrDPpXWDuFbG6kShkX
	W9QhcLiF02zgRJyi6sIXLdi7mR75Gahw27bPtAfTMoqh1KpQWPjVew3H1/K8CQWmFP2fGpo24OU
	V/3zcJV+a4SPGE5eJFuU8A/7T21F655J8ZGb2ndhqlI=
X-Received: by 2002:a17:903:2f8e:b0:240:469d:beb0 with SMTP id d9443c01a7336-245e0494544mr22476155ad.31.1755593509517;
        Tue, 19 Aug 2025 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX8G+XdS44NqcCcHy4azwS1a/5x7lnx2W3dbU327cwfzsZzMnxPMyAw6Lxry5dSu3VZ2nS8Q==
X-Received: by 2002:a17:903:2f8e:b0:240:469d:beb0 with SMTP id d9443c01a7336-245e0494544mr22475855ad.31.1755593509062;
        Tue, 19 Aug 2025 01:51:49 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d56b44fsm102344815ad.146.2025.08.19.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:51:48 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Tue, 19 Aug 2025 14:21:44 +0530
Subject: [PATCH] mm/numa_memblks: Use SZ_1M macro to denote bytes to MB
 conversion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-numa-memblks-refac-v1-1-936b4fd35000@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB87pGgC/x2MQQqAIBAAvxJ7bkEjyfpKdNDaaiktlCKQ/p50n
 IGZBJECU4SuSBDo5siHzyDLAsbV+IWQp8xQiUoJLVv0lzPoyNl9ixhoNiM2trZKyMaqVkMOz6z
 5+af98L4fumtcnmQAAAA=
X-Change-ID: 20250819-numa-memblks-refac-7b4b5017b598
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755593506; l=1272;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=1n/B6T+EBi4imcFDM5sARQMMhhJ8zd0wI5Z3/7GqQeU=;
 b=tqgIYcTpIp0/mL5rik9Uq5MvBl0gulCrHw9T2BhpCZe7GI73Yn8M1gHSiPq5LAVA8DveZexKu
 3QktpIJNyjLB+jX2lpO05uH+A8sb2fDqDSJPSwAMSuY6rWjTVpgr35v
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a43b26 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dRzHXBjQmnXEPONtsPAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: pSxYRHhgVtsVJp8ObyJe-zLn258eiuBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX6tx+0JTbOBBZ
 JvCIqmcXY6s5S8YQMv5Jz17HJCPwHhB3TXNjk0EkRwxm7OD9Vryq+FSdiJbMooQczDeHrr8bUP5
 +SZyo70EDBS6KUnB+GNSYPtEI204BAnPARj4Dv+yUBWNYGUBXwwPG9y8mZn1j4mxZMcWctQZtCr
 nfQBhNuSEfzbj5p787V+oC2uaZSczX12AapFLhuI4YO87LhaGwW2DQwPc1re5/3cLlvccvRE8qD
 fmrvd/IyVJvfDpNB1txXvvW7Lveqd+CkgEKyzVfHn4nXeXkMQVEjoa30SMi0Bfk2XLZEji66Yzx
 aRpmrRo2ObyRJuMNAMoRWC8qu42tSgEjDqG9kLD1w1JMBCFRXVgHAlInI3mSt+x5ywTPHgSEbi5
 9VY1BOOs
X-Proofpoint-GUID: pSxYRHhgVtsVJp8ObyJe-zLn258eiuBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace the manual bitwise conversion of bytes to MB with
SZ_1M macro, a standard macro used within the mm subsystem,
to improve readability.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
 mm/numa_memblks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


