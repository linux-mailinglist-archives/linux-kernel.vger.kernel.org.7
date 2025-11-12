Return-Path: <linux-kernel+bounces-897698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E534C53A65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C51A85493BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02534E763;
	Wed, 12 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TM25zDic"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8D34DB6B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963486; cv=none; b=gpZjJNVpW0aAt9rKjYZzk4QWaOGO5Zum7qbOhz8EdqIoCCu5t2Ip//PPnAByD4EKcjy7LJwbFc/5BDMBs3pWCH6h4XRRdhg0Op+KX3J90vRppJyGTdN7r/onBRo0796b73ARdAEzUhYwlPFRlMyfz2rGtuRqsGTMvz3HNuhAe4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963486; c=relaxed/simple;
	bh=MJuS5aI6TBpNEWLOH7jEJKhRGwaG4j0xhrR0PIheg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHTaKYUiEd8E9fiyW7Td1t54sEgaU12Yf/4aplcWjrCqh7VznbOQ03F/s+nBeyl4Yop83ifLttb5J+uULYHofR/DDNFfNMnOSZo76W1LRzpzOkIbFdKDo2ERsjslYSOxVdsshbj8dG3AxwjNrIHfIuti4rUA/1FzEzeTk6wV3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TM25zDic; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFVv05012507;
	Wed, 12 Nov 2025 16:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4kujL
	WXKftYa98GKfPFWNDHJWBntxAXJo2f1Yvze3I0=; b=TM25zDicCVbyqN3IIQlNl
	YNDoMHIqTLqythFym1PmynHFUZiPe7lxSq4n8casd79k3jJpsRJSYggaePZYZnqA
	0vgHcv+KmpzQJpW2Z8oLKT4x9qLw9LpP2eJ4daqlzasp4PVHF9bGOUQ/CN1a33QP
	DglFCAQcrBVj1iGjYL9IGLNdP12iATQ865x8kfi/92J4CD4ntsuqsy90aTHuuDFZ
	HWPTsfL0swgH+rgIse+ZocqWtM1TkoEAQrl1BiktW3mWyhXiP2pALcSBUkKLwOMc
	vH4Q8lpElRRkTe5gcTiKbBNqXjhnvz+DSPuAPVnde737aTVYjenNLAOWX7Ghm/nf
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acv97r6ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG2sZ018577;
	Wed, 12 Nov 2025 16:04:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavqtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw4C004655;
	Wed, 12 Nov 2025 16:04:37 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-29;
	Wed, 12 Nov 2025 16:04:37 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 28/28] objtool: Print single line for alternatives with one instruction
Date: Wed, 12 Nov 2025 17:03:15 +0100
Message-ID: <20251112160315.2207947-29-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
References: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120130
X-Authority-Analysis: v=2.4 cv=Cseys34D c=1 sm=1 tr=0 ts=6914b017 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=C75Ug1cDibOJfFcMQNQA:9
X-Proofpoint-ORIG-GUID: Zh4pv0rpcI8yH77xF_BnZqVJqsustsyM
X-Proofpoint-GUID: Zh4pv0rpcI8yH77xF_BnZqVJqsustsyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfX+wYLuxfVqCFy
 3h0ncKvao1PqbggGXvtRS3/s7NzdR3WLanVj9tDgfBy/daPTeqXUP0hfiMdr1dGAGepQ7Ge8b63
 flO6uqsp4G26g9iFKRxkbDWsx9nPR+RR0ldmNr6U8csramzsIx2cvzEkajzc3fd10s/G92QG8MN
 riCd12kYqYmW5wgtYoNnEkCwg3gszlgqMqfNexG6rGRU++khQSx2XmmHewqRHiciZ3s6Ep04W4D
 TiQm5K/RtSC+GF3mmAB/nLQzdD34CPKTa+CQcimnUm1XvbxRkARB4vL10AUA6PPCt8nqLegur0D
 7bKumcPLRo0/LEOXVv7abyPT1AetTdAcNJlRbcCOGTK9QlTtRC0ZpV9WkSqofnjyqwJ6MqP5Ooc
 eYHC4dEEYYhTxhqWm1IY0CPtxBSOBQ==

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


