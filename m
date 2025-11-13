Return-Path: <linux-kernel+bounces-899903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E59C59173
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321CF50749D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F5393DEF;
	Thu, 13 Nov 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0qHEweb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BC393DD2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052621; cv=none; b=UnZEWWN7a2JFMOF1VSYtiDLr5jISc8IMFIOzQ0K/bdmgToxa3mE0W0e3JpjdpE5Kq+bw2hTSfNv8ttDJGgOW53ldcKVc2pmClRHMXedo+jmdjjBJ71n9WCFhEToLNt42IbGWCkn8xEvNdHcAOBlEg8XskLcy1t1/JlW6SNd0OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052621; c=relaxed/simple;
	bh=MJuS5aI6TBpNEWLOH7jEJKhRGwaG4j0xhrR0PIheg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OugdPp5NW5/mNYtwSl0oXqeeu4o2vM7Y2VjOdrNdg+21OxOtkoY6GK4MOyCz+OXJXEED6tHd/9daZcLK2gOVDSPjAbBQ7Bzv2WwsxEOCoTi74OcTLaqSV6oOh9NAOJ1knR5wFyA3DMYMXg96e1v47ZFJKGHDXO9fohQV398nrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f0qHEweb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9t3Q027934;
	Thu, 13 Nov 2025 16:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4kujL
	WXKftYa98GKfPFWNDHJWBntxAXJo2f1Yvze3I0=; b=f0qHEwebDfDS+GHy6QB/9
	jrlVEYYpuBV7W6ttUn4kuKkyzoz6FdsMtl8jfJZg9R2BDmXwbDhSX9LicC8K/8ZI
	eKm50qrAU7gQmgs4J9CkEMPkQEX7xDusbtL0VWz4LhKTdK6jGrWUN1p0fSvE743h
	7dzafU619EISFN7BOasF8SnFEHyQeA3IZ0AOAn5PXqQxZIKdReMca4shVxv5C499
	O9BeyugRMNtYyxWThUI0zCdNXlDEISzW850oMNt2bbFvKT5nZLLw9ErlpEtItnsV
	+Eys/TKuJYNqPBF8F24xca9M4gp5/BtBXAxR7rE4mhxTy6CxJy9HKsF5/QWyM1nk
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsa7w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG92mv039199;
	Thu, 13 Nov 2025 16:50:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc4m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:50:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKAf008288;
	Thu, 13 Nov 2025 16:50:09 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-29;
	Thu, 13 Nov 2025 16:50:09 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 28/28] objtool: Print single line for alternatives with one instruction
Date: Thu, 13 Nov 2025 17:49:17 +0100
Message-ID: <20251113164917.2563486-29-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
References: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Proofpoint-GUID: UlfALYs35uVa7gB6tU82HMrGxFSrgkH_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX8v0S9kRSHzcg
 IQcM0CgoR67Ho4baMKHfbLzucSbypL5k0T0Um7O7wX6Ku9whG6Av0hXhLSjglqAS/SDJzuDvc55
 bE0pglTtz4AfyFhg7bFrzDBwYTh62fSpPbbHNz4rLsxxFJZCEg7Mojkne5DO8qqO1jar3bsFpP5
 5e9dM8Z1AhqGI5xKfWBbNK8CNHqlf9guVdaOa7dKWmeQjKIPCjilJR6s1Dve9rIUO7ryU6BC1ne
 eOol43UfiwIyCfONczeqnxlgJLW9tyxDKuwPcVjYnRfFBzDkVmggwQgfCWhFfYe8nxdI9Yg1ECE
 k4JmDMekRj6eeHY8NP1FapXZz5sWFO0Mj4FAmMzDGovkkNX4vwVtFVnnXq19T/PrqH4e0b3PgiA
 Iczlm1fFiqR30kC2NxBagvbQIsquag==
X-Proofpoint-ORIG-GUID: UlfALYs35uVa7gB6tU82HMrGxFSrgkH_
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69160c43 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=C75Ug1cDibOJfFcMQNQA:9

When disassembling, if an instruction has alternatives which are all
made of a single instruction then print the original instruction and
alternative instructions on a single line with no header. Alternatives
are described in a comment on the same line, after the different
instructions.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/disas.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 20d64b58182ce..2fc5821acbc3f 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -1012,6 +1012,24 @@ static void *disas_alt(struct disas_context *dctx,
 	}
 	alt_count = i;
 
+	/*
+	 * Print default and non-default alternatives.
+	 *
+	 * If all alternatives have a single instruction then print all
+	 * alternatives on a single line. Otherwise, print alternatives
+	 * side-by-side with an header and a line for each instruction
+	 * of the different alternatives.
+	 */
+
+	if (insn_count == 1) {
+		disas_print(stdout, orig_insn->sec, orig_insn->offset, 0, NULL);
+		printf("%s", alts[0].insn[0].str);
+		for (i = 1; i < alt_count; i++)
+			printf(" | %s  (%s)", alts[i].insn[0].str, alts[i].name);
+		printf("   # <alternative.%x>\n", alt_id);
+		return orig_insn;
+	}
+
 	/*
 	 * Print an header with the name of each alternative.
 	 */
-- 
2.43.5


