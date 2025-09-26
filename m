Return-Path: <linux-kernel+bounces-833939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D94BA35F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70A6387C44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC312F4A03;
	Fri, 26 Sep 2025 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jvVZBWId"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE321D3CA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882903; cv=none; b=mdLqEyBHVQW37B5T3T94z2W9zbx8ZUzczrKwTsdnXttca/BmwRDeIf69QfRePX3vLyd9CJNpp1UEPaoM3RpfMUXRVFVEuHiqW31luSr6bks6wTKbFYPKK9ejEOr1f/JJdOUlOkIAP2VLJacJ8g+5Wuja+rcRrS1w5ODTo+Uvwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882903; c=relaxed/simple;
	bh=Dwk1x6ALA59JkmANnsjTKTB4sZ8KV9xP+Am9d6aHFTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxOv1NAVQ5vaOpZz42hwRKwUyQUUR2sqVANXDZCCdSrUadz5mm9TDssPgPkCDclN9JGVmE0Fa6kim/bU31X5w46EkcsPX7jpm9jDHtHDLn+3Bb46xWaNUHWBSFy1nGCgwm/lhIYDzS/07GSYFq7SLLGpCY2oAQMd2dSXVNGj2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jvVZBWId; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8veGn028526
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTK3sm/WCTByH8AIKLDPZJb7elq6pcZttvHY7NDS8Ok=; b=jvVZBWIdi2uklA/2
	Nui3m46bmsA/VRCWndUve2+xIggfzREWuuuBMYuui524mRt2xvUKjvACwh4DEji0
	vqIDfVabvyCR++3OBh1o2xWtwkgHxWOG/tyktmFEGMCPK4mMHiFH6SEQreJUuvG1
	7x1zzPiwDynIy9rNrccvhXsbPbhYwax+2vBM87PP7WHrnbSlyukb1rK8ucQFHgB9
	tg/xq4LT6LHaGEmaZPkBe51pEDSKCzXzrxSwu1l1h0SJ9Otvafnaeoqz+im9L7rB
	pSYpNjkO7oR+fTLUIzVDUqEMSWrpKpW8GkSFJxwKLE2oVTmaDvNY1eSVlu3qhiIX
	kA6e0g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q2gb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:35:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so1487429a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882900; x=1759487700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTK3sm/WCTByH8AIKLDPZJb7elq6pcZttvHY7NDS8Ok=;
        b=dhsOQMSLKUws+RdT/P1jwRmhXtiF/xKQulbjaUZVf8bmgJ4VRppA7MDDRLzTXjhCI6
         oySBsr/jyGYH5NRGbLPQzTUH5FBceIHmII7FBqFq/lEoar6lq55SS4KAlVKKVxFhi1DN
         A5NW5pw9eFhfa94RnFwn0+U7GLU26mp7+rbjIS7CdB0lSnFSESCXtiRxowtuRW0rzDvK
         +au2hh1A0wanAfveWyh3We6yeipLrH4i6m6G0QZdLKyxVyOIM6i21Yr3q7zQStCUhZxS
         KmEuvWSAB39W79jckZsoqxx90Xq0BJQE0JB1f3RWYHdWK+wePGev8lkyJA3PSpXJxPn4
         SKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQKfJRzEz8wwHWfFfeetXBW7GksZ634iT47jT/Ee2x/TRoBpp3hHJRze/7RyZiI+m5yGM1b21Mgsymmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhu34gTTBUOnQNs6nulu1vfAhFhMnvYiEN46Kip2osR7BDwgFD
	+f/GgHk5cmnGMqUCyZwMgmAAA5C3Um/4kn3P2ifhN6iqZcM1652qdd8kP5e4Q9Bbn0xmXwPNAFY
	SURCHrVAI6mphUtU0iHht3YtWjz3x2NiEOd0L/wyK/eEcSRqaEMUUoHac2IutcNxNXUuz2lNaRT
	0=
X-Gm-Gg: ASbGncsLcan6dGPM3e7q1sKna2SSoVfaiy5aDjDzzQcT6Oo2QWCfRi51ULPAw0JB/wd
	U96csH4UNxFtzClbdb+BDQn9Nq6mKJYDgTk5mhuTFTmGZ/k1yRX8y+/wVFkHQ1NBDL/Ua+EzPnv
	ovoEu8BWJ6QvpdmePxAgZe1lBEUfuD9BqaiqbUKGja0V68fmyNwCFPinlFtuzXlh798R4DS0eQ0
	QzhP3ABIyZnsrIEZplI3U+Ac0WuSP5gn4AyPGbCFH7UPv+ffmRx9u/OAMHsq7ZoUiEzzQ/+uaEN
	bQJxFnMmplDcq/4rU50fSG2FQqiDpYnSvBax2VxjjJE=
X-Received: by 2002:a17:903:32d2:b0:265:89c:251b with SMTP id d9443c01a7336-27ed4a5a83amr75493315ad.29.1758882900071;
        Fri, 26 Sep 2025 03:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtkjQ1vZXVrGcSLYgiOCZ+w7RpHML+kVAOdjCbUW2JzzLjV26JdqDt2s1DJCxrP6JlAynBw==
X-Received: by 2002:a17:903:32d2:b0:265:89c:251b with SMTP id d9443c01a7336-27ed4a5a83amr75493035ad.29.1758882899481;
        Fri, 26 Sep 2025 03:34:59 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm48950175ad.138.2025.09.26.03.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:34:58 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Fri, 26 Sep 2025 16:04:50 +0530
Subject: [PATCH 2/2] mm/numa_emulation: Move the size calculation in
 split_nodes_interleave() to a separate function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-numa-emu-v1-2-714f2691bf8b@oss.qualcomm.com>
References: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
In-Reply-To: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758882892; l=2432;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=6Z5kcb9JsfpjcjQdv/MoBuJ6XffluCG6avEx/oaN/HQ=;
 b=WDB4CbmPf9+t07NRSzRna0kA3IFvZQpm86eRe7YQaFBfpUjLYjKGiVQzUNpLCeLKwgiNf6ra9
 wszmIyDEQngAyEYZMmJ40RRkI+UHA/KPUb4i/W+2ruGB4MtlUQjVlIT
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX6mlsEdcWqHws
 colYkS6u5j0WrbAYNcW+MP4TsLi8U/hngUMNN0K9zoqQNDl0eFmWb5qaW27DQ77f36YJw9vAes6
 JA/Eg5ueo+z1aiiTfALiM9VEAbnRWN06/iax80E67PUZN1hFUgcVMrdFkX7QmQBqzfSxSM28864
 mzTEPBxzkbe5xpAKIZedkwPcaJ7+7scUKyiQX0/SglSRHTpd4k0qJy0BBaBOVjVK9DGv6yLmJ2X
 qtFzAxiAgvTqLZB7gSEvAKryqa4m6MjnYKOZRO5angXOy0u5k/KP+oKvhLeFYxqVZ6ED8EBRgld
 FC5A3KK60b8poi2+oYiP94JMsIsFIzXjSjuNWpMVaVGiCjhMTrpB08LDQP4uvYz2jhgHBA0OqU4
 iToMrPTWaEF/nT43AjvRbCrBtHnRsg==
X-Proofpoint-GUID: 6bst2sHAX9woztAPcL7ALNtZ0S18KYtl
X-Proofpoint-ORIG-GUID: 6bst2sHAX9woztAPcL7ALNtZ0S18KYtl
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d66c55 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0kcytrBVAGx62Z4XyuQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

The size calculation in split_nodes_interleave() has several nuances.
Move it to a separate function to improve code modularity and
simplify the readability of split_nodes_interleave().

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
 mm/numa_emulation.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 2a335b3dd46a..882c349c2a0f 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -76,6 +76,34 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
 	return 0;
 }
 
+static void __init __calc_split_params(u64 addr, u64 max_addr,
+		int nr_nodes, u64 *psize, int *pbig)
+{
+	u64 size, usable_size;
+	int big;
+
+	/* total usable memory (skip holes) */
+	usable_size  = max_addr - addr - mem_hole_size(addr, max_addr);
+
+	/*
+	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
+	 * the division in ulong number of pages and convert back.
+	 */
+	size = PFN_PHYS((unsigned long)(usable_size >> PAGE_SHIFT) / nr_nodes);
+
+	/*
+	 * Calculate the number of big nodes that can be allocated as a result
+	 * of consolidating the remainder.
+	 */
+	big = ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) / FAKE_NODE_MIN_SIZE;
+
+	/* Align the base size down to the minimum granularity */
+	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
+
+	*psize = size;
+	*pbig  = big;
+}
+
 /*
  * Sets up nr_nodes fake nodes interleaved over physical nodes ranging from addr
  * to max_addr.
@@ -100,21 +128,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 		nr_nodes = MAX_NUMNODES;
 	}
 
-	/*
-	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
-	 * the division in ulong number of pages and convert back.
-	 */
-	size = max_addr - addr - mem_hole_size(addr, max_addr);
-	size = PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_nodes);
-
-	/*
-	 * Calculate the number of big nodes that can be allocated as a result
-	 * of consolidating the remainder.
-	 */
-	big = ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) /
-		FAKE_NODE_MIN_SIZE;
-
-	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
+	__calc_split_params(addr, max_addr, nr_nodes, &size, &big);
 	if (!size) {
 		pr_err("Not enough memory for each node.  "
 			"NUMA emulation disabled.\n");

-- 
2.34.1


