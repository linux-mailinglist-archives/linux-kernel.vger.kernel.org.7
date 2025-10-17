Return-Path: <linux-kernel+bounces-857424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35ABE6C50
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A889B4F5718
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92C30DD0D;
	Fri, 17 Oct 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6juZ8Iw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D843346A8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683725; cv=none; b=audQLhA13+DkOLBNCaaTFnEZh2EqjC2VOWmlb2SjRVax1hJAFprIvVeWolExLuHnv4qb+5ocnsWrduVVzTzTePknZcl9NQdauT2irVnncNuw4bfTCXGG3dw44QfETA6hsmmG5iE4vmSYxDLfeXArsZ91qEHrE0Ffg/srSDStkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683725; c=relaxed/simple;
	bh=eKyEXkav4qU+a7Jh9zfG80q7Tdx+4NNlby7yrIW+JI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CF0eWU2kdV/scHNyzscV61eMBCEvLomIIKxBGNcgCi7SzlMxDk8ifFAI2yWu30CdIPFjbQ1p8ovPjcz2zsRPyrgqs47flfSg81zNplObCI9OjrLMGiiHrV2eKYFd8R3w/WuFV8c2IQFTGscy+OKPMtRCaaLLBOCHZL7zxGFPpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6juZ8Iw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLTM0020341
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b45vcD0RNhdyBBimrVOHx32/MG2SgQ7pep5
	TrbKAkCo=; b=B6juZ8IwqBtekP3afXrB8DmDOcLSuaktWF18+ylupHLZ1JFjf14
	mIyH1zVPuBiPCGFBsv63DUhKercf0PEwCzP/b39Be5hp0Ukj+5MnSpqZ8gsRSGEY
	dW9gQe/VUqYuICyxYWsr3Y+1I0208+yeJnLhfqVGRcIPVfFhnMz0XZ8G5LCStqRw
	/zMmLzEGv5ggN2Wr8X7xkgKs8rnRaMQYG4TvwXsUcSAn/2ciXceFWxX8PwYPm9Ku
	GqcG60KAZXBMBqawVSDJZM0fk/ejPUiPZ78P0o3/E9xOrKWKB/oUWzF0NCnp5z5N
	qopHf9cLDrOxPF7ZDDasJqpGETHhn5D94kw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8sva1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:48:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so368408a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683722; x=1761288522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b45vcD0RNhdyBBimrVOHx32/MG2SgQ7pep5TrbKAkCo=;
        b=mUGpuGB4FwQVLo0yOpb4+Yq8BBT8SYyFB202BQ/6NvYe5KNpE2WErR/UIbalExKndd
         bzNrtIf+nrs9ycwgVa4JFfUSC4OxH08xaEMhpFs3rT3kRxLUTd3xnJfKJcgdfvBS/pit
         aQSmc2s+3+M3uDpb1DFcgiX2Wtg2CwtO5vVWXt0V7zJFSV8HcFgk6tZ384G5Cr7EgYLa
         5Ca0uiAoowmhsAu88t+r6JhAB1i8nTf6C72JLsXeRg5oN1L13pMv4S/b55Cua3Vcrmc7
         F16vigocjmBYMDzPtbdUkQe2mlXwb+paUPZymwZGN0n7rQ0vzg8cJGXyelnEs9fMyBIe
         h1fQ==
X-Gm-Message-State: AOJu0YzzvgFO6fnCSl3MOKSKeDDd7kQ5R22vB8vE9g6kELZm6Teky3OK
	luYDMpVPdj0G0FUlTq6TyYBqvs3+DMBGIdS/0dfGpbF80pTytrHGjxOUGQsY2QSiEprIh3J1Efs
	Cza9Md5ALfFBW6obwZs3y1xK0TYucOGmuv422NXLAjdUIcWCbjdogTvNjK8J7Y9oglw4=
X-Gm-Gg: ASbGncuySvwWAUdIbFNCbBiW6x/1ZcL5hY9sDBjpSUjhWmMCV3aTInusBIQ85/D1KNM
	iVy6Sl2WpEeV3BpNa5mfiP8ji+SZcAGtAX4WRAl7XTil6gRmCzGh1G8b/xlOeM26eFCl9V5JKEW
	y5QGUmKxrw1U9UtNBdcXaF6U5l1LMcC1m98NuA5gdoUTnuDvSZiJxkxZGIizhdflUUYNe9VOM/S
	kZWiWUXVMk6MgcbLXKspO1Gq/vtcxLI9zBBimREfB+CrTzrmb1Aees+5cEJMaQK1WyuIx+s3/H0
	qmLU9rDH9kCv2oE4F+YvYvaCGzSnDDvTeF3Jp+Qa+0JYCKTuFQSz1kaN/TeDHojVyBO6XLE3YiM
	wgmx6Iu+I1mTBEQ5wgRJqACRXogNtzpLYZiE4ecQ0H0PgmMYWZQ==
X-Received: by 2002:a17:90b:5111:b0:33b:c5ce:3cb0 with SMTP id 98e67ed59e1d1-33bcf8e4560mr3348983a91.20.1760683721817;
        Thu, 16 Oct 2025 23:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwIThdK9ZWr13FTpAec3JJm/4DOASnbw4evWs77j00Y0lv0/Fv57JQjbJhk2VxOhsxJNt8vg==
X-Received: by 2002:a17:90b:5111:b0:33b:c5ce:3cb0 with SMTP id 98e67ed59e1d1-33bcf8e4560mr3348962a91.20.1760683721410;
        Thu, 16 Oct 2025 23:48:41 -0700 (PDT)
Received: from hu-yingangl-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3177asm1665151a91.13.2025.10.16.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:48:41 -0700 (PDT)
From: Kassey Li <kassey.li@oss.qualcomm.com>
To: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
        linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kassey.li@oss.qualcomm.com
Subject: [PATCH] slab: add flags in cache_show
Date: Thu, 16 Oct 2025 23:48:39 -0700
Message-Id: <20251017064839.585204-1-kassey.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DFOnkt99-Gty5xFZqJaOFTNtcNcypagw
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f1e6cb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=blH2SsOzjbYzLah_e6kA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX8rMJEuBnyGAm
 gM0J+K9q7OyZ5X4j+VRERHBeeGHvYyfyMrZKR6VxpiflQpVUuUz5Y8xPQNrTqIUnyz8c1U1Hqki
 ipx5p89KY1whHJGdMJRjOP8/ZR9r6SnHwKem7OQKfIxgG4aDrXjq8H9JhQXPJZAMzsAdjEYXe/R
 FRMSe533ok+52rE02HkXqSCv6IRBJ1YVSyr3KJqlcnZBCuCIrxFRon9YRxRU/FYi/jrxKP1X927
 4whBw2zBzTQwnECl/pz0Zc5a0gdVurf2Adq/kr0JTTCWeUr6nUNsIhBQUPUbaFh8cmftuTDb6jb
 DaIP2jLZrU7GbNmHkyXD/gbSpClPD/G9amqeuwjuAItVsE2/RbVSE+9N1eSCtE9tqgUo3vNk0qR
 1vexUQOcF3XCsMa1+9e84VKRsX3E1w==
X-Proofpoint-ORIG-GUID: DFOnkt99-Gty5xFZqJaOFTNtcNcypagw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Flags info is useful to check the slab type.

for example, _SLAB_RECLAIM_ACCOUNT:

    0x50100 _SLAB_PANIC _SLAB_RECLAIM_ACCOUNT _SLAB_CMPXCHG_DOUBLE

Signed-off-by: Kassey Li <kassey.li@oss.qualcomm.com>
---
 mm/slab_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 932d13ada36c..f43239211e69 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1083,7 +1083,7 @@ static void print_slabinfo_header(struct seq_file *m)
 	 * without _too_ many complaints.
 	 */
 	seq_puts(m, "slabinfo - version: 2.1\n");
-	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
+	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> <flags>");
 	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
 	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 	seq_putc(m, '\n');
@@ -1112,9 +1112,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 	memset(&sinfo, 0, sizeof(sinfo));
 	get_slabinfo(s, &sinfo);
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
+	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d 0x%-8x",
 		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
-		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
+		   sinfo.objects_per_slab, (1 << sinfo.cache_order), s->flags);
 
 	seq_printf(m, " : tunables %4u %4u %4u",
 		   sinfo.limit, sinfo.batchcount, sinfo.shared);
-- 
2.34.1


