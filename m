Return-Path: <linux-kernel+bounces-897677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 847BFC535A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A715358F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED03446A2;
	Wed, 12 Nov 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YYmxw8iq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C89337BB1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963453; cv=none; b=MKWCew0UcYQzaIAgkjt+jk6Ah0x0CIRXQZ35twP272rItm1eSWskVNwk0Usf4cPQhDTbY2IVglV9dm4p95yQKEPdxjdK2XMgIcVr7VKoEWFsBPH0nM+hr/T42aApgisWucjBNWan+5ExVrIQCk0hdocNkYVxu1IDxlwyO43HwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963453; c=relaxed/simple;
	bh=CVdUBf+Wgi7dxn66PVbR1h3zdfzGRUACq+X+Gsf7sSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ2x6BhIVmmqbxXvF9I2cyEsa9CP0nj27J2qJaLQ6xUXKCsTzaigOB2f8oPsHcn+OlKQBE+AAwkW0uIDiMcFTdrjHUG1YqW4G2RAZc/Mq3oAr6JYaCGGuD5/+84wJIxAzLUQTObc4WOgXDfrftuQhWl6nn2EzS1cU0XF+7u18aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YYmxw8iq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACFRCJA008527;
	Wed, 12 Nov 2025 16:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2Pvki
	wZj0+fyLZUdBNms87y9ptFPtvpYZhWD/2eW3+w=; b=YYmxw8iq7JKtyhukDPNgc
	UfONEx70MQvXfVltIkv6nuaohrLJSHAcpdTRkpmplzD+ESQGs2YRIkl8OqsheaJ5
	ZHiZM3CbSu5EbYS7+1cU2n8WImkbEIvdPa37ShhyeE/836EYx17RWcFCI8YmUUi+
	RSK9bgNlNran7qLaJkhOGLS9eUmPzpgc4G2QxUnNUbDvaHs8JtTTI7oye3MMVPwV
	XZLuRlR8eo8+XQMyMctqs4Yk0+aQZlP9Fd2Z1/+uwL6zTzN0R9zqy0mpMN9/jifb
	07bh8JB7p5pRjz2iqVxFicCxtXQSqCYlN1Ea1vTCGHekrWpdWRPfO76ef2p3G2w7
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvssr4mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACEG2sF018577;
	Wed, 12 Nov 2025 16:04:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaavq5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 16:04:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACFxw3Y004655;
	Wed, 12 Nov 2025 16:04:04 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-173-131.vpn.oracle.com [10.154.173.131])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vaavnq6-10;
	Wed, 12 Nov 2025 16:04:04 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v3 09/28] objtool: Record symbol name max length
Date: Wed, 12 Nov 2025 17:02:56 +0100
Message-ID: <20251112160315.2207947-10-alexandre.chartre@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6914aff5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=xKpiAcmDGk3KfUQPlkUA:9
X-Proofpoint-GUID: 8De_ji-LV9oh_AgFoJaz5XmltULPJMRu
X-Proofpoint-ORIG-GUID: 8De_ji-LV9oh_AgFoJaz5XmltULPJMRu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX7l/KGPmIjPeg
 78UZKjWE95kQVKy0MnIK5cf7+UhlczduPDRQCcAjONxOWwsveq8IDeBPUnSfq0bT2SIRObd2uvd
 8kLHLVxQ4GRD4fPmg45w7nCq4AX6KEhqPAMhMDON0+KxswJtY34oVbfEm1ImGFOk8BzXGvSQLAY
 5S+rSHzva/Xmtr3QBqIrnwmEAuKAPxuIRRpzNpo0ygMeg4mEOHS1ZQS5dKd2Ndj8ZfZ4zdDfPil
 RyrUThDhiOCVBTtpKZQ9t5QJf3VTfTM45mwR3LrVX65bFZaLUaorSMctE1b4KeeNSJdZoeAxA6R
 iNVRgIr0Gr+VRlCapfvFT1HivnqXhpiws4KsLJttjfu7Sndlm3pEurjvuRw721ilpzoDq11ASX4
 UhFfwyeyw35uHByrT+jXeJTWcOHLpQ==

Keep track of the maximum length of symbol names. This will help
formatting the code flow between different functions.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 609994ad6ab41..1fd56e8afbfc6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -35,6 +35,8 @@ static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
 
+static size_t sym_name_max_len;
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
 {
@@ -2463,6 +2465,7 @@ static bool is_profiling_func(const char *name)
 static int classify_symbols(struct objtool_file *file)
 {
 	struct symbol *func;
+	size_t len;
 
 	for_each_sym(file, func) {
 		if (func->type == STT_NOTYPE && strstarts(func->name, ".L"))
@@ -2489,6 +2492,10 @@ static int classify_symbols(struct objtool_file *file)
 
 		if (is_profiling_func(func->name))
 			func->profiling_func = true;
+
+		len = strlen(func->name);
+		if (len > sym_name_max_len)
+			sym_name_max_len = len;
 	}
 
 	return 0;
-- 
2.43.5


