Return-Path: <linux-kernel+bounces-733612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6BEB076F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E8E3AEA89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB01C5F1B;
	Wed, 16 Jul 2025 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mVIGaLUK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94952F88;
	Wed, 16 Jul 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672568; cv=none; b=iwlmPM008PUL42bK9eHwDJqH65YhbOOVL6CSLVFFN0cYXg6OzLj8knZNUpXfISzWyl25axWNZkKp94u0yIdRM771pdXcA6tgtSwfFcmguWHfDZcSl8LFh+IiPsWvLe1Y9yI+qEiFXIyLYR6yMS+b0owxmY2R/cn8MTBdnY3TfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672568; c=relaxed/simple;
	bh=m69eBpowmMuNvTB6Apw+JQZp8W3Cx09oDdHKlO4Ttzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBle4rT+hgT5bYHaDvPXePG0RYoLmM0Kpq6XiLTeQKOazR8LOtVSL2eVcX53KdFUXxqgiwn/kHX3MhaeLi7bi6AV0YIsOFpztuPMQAyFtP+/BxL00FvKQF4+3edyN/pJUzdLGN5oN/BgQYrpcLqVzM8FPIzkSZJUElt4DTaMU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mVIGaLUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GC8VBb019284;
	Wed, 16 Jul 2025 13:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AliyRKzkx1UpYngLzabBdK8VVN1l5cX3s5tZAsft8Y=; b=mVIGaLUK6dYYtF57
	9IwOO3lHnQQ+bb0yR2e1eh1YxWOpbjQl0g8T7kOVTNdeup090w8ArlKFdWZsAnoi
	TRZai9W7GLM8n3Wpvn4klj1t9ARHWSsiGv1MQQMXMX1qVo/hVIi1W2vI0dl0IVjR
	QeZGtHBBj9ghCZa+rtQG+legfI1LUntsNWgronf4YhZUdR+sNHuxgLAVAjV6JE4S
	1vfR5mCALwYX3WK4zR3G9u5z3JtyQ2ZWmuLqnwqKvMcOE4PPgunns5aLdRhkLihK
	HAMBsWPtBe4I5vh3GabxsLZpt2WHhRTJF+6S+dBaN9eBE9QwZa+Ee44OVMco4JdA
	ohaXDQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsq86qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 13:29:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56GDTHoO024491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 13:29:17 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 16 Jul 2025 06:29:13 -0700
From: Ling Xu <quic_lxu5@quicinc.com>
To: <srini@kernel.org>, <amahesh@qti.qualcomm.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC: <quic_kuiw@quicinc.com>, <ekansh.gupta@oss.qualcomm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Ling Xu
	<quic_lxu5@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/5] dt-bindings: misc: qcom,fastrpc: Add GDSP label
Date: Wed, 16 Jul 2025 18:58:32 +0530
Message-ID: <20250716132836.1008119-2-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6877a92e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=y9j2seIhk4up1NT0-iEA:9 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JjZjUvqDw849lQpbEcXzpWG-HyugbS1i
X-Proofpoint-GUID: JjZjUvqDw849lQpbEcXzpWG-HyugbS1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEyMSBTYWx0ZWRfX18evusjWQ4zi
 eVFqgatywuOYR/TNSNJL+/NxtSFtfGxZ5qXz5meSlop+bhtEIS6HTUsslP83zx065BkbyJZ+imb
 ATULH6VLq3cJ9a3g6M849PfABkdhHSFnsEQkRaKZ37v5abgucHJKGcGadzJK9ASAS9yC0/LPEQv
 PJLDEqXF5bPsqMXjkY6/qAvoctJKZ0hdQne3abwgOIaSJ5iPMLDSp44J1btt5Xb53EsOtND+a6A
 qtXtnW/GniBvNALRq9r4gO7opC9DTlvALF1Hm/DsrzRCvnYtVTEC7EIrf9jyKyO0hspaSxUpcF+
 f9qEwiYJACjCsmTDglYa4Nc+dOD5UNgmU0ugeq45fNJkSrqXo0NWd4N9YgUAU+DBG6/24M1ni0h
 f5tnDUR/rEML9p42OVYPusyYgxSnS/ds7kRdfEy9TJFYPr6MEREWhHspCiv4DOxV3EFIwhN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160121

There are some products which support GDSP remoteprocs. GDSP is General
Purpose DSP where tasks can be offloaded. There are 2 GDSPs named gdsp0
and gdsp1. Add "gdsp0" and "gdsp1" as the new supported labels for GDSP
fastrpc domains.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 0840a3d92513..3f6199fc9ae6 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -27,6 +27,8 @@ properties:
       - sdsp
       - cdsp
       - cdsp1
+      - gdsp0
+      - gdsp1
 
   memory-region:
     maxItems: 1
-- 
2.34.1


