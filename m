Return-Path: <linux-kernel+bounces-751361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E081DB1684B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269651AA3F97
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041422422A;
	Wed, 30 Jul 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NsRS6jUh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93246132103;
	Wed, 30 Jul 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911018; cv=none; b=GTTfw6qeq3DR9XTbWCUa9pSNmHqU5Y6YcDd6gvdLfSM83Q56x3cLKESLH097AS2+aTmJI2/zSYP6+SPToa+toEs6Jq+GizFK2LagvlWkC6Ir5NeAyUvCMmf/OlaflDbjFRbfmbFAVl5oJbty9l4H4B7bEUmuE0CyOIxwFGVfge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911018; c=relaxed/simple;
	bh=4dho+6OHze6sBx+zP3CmURtnlINJKW5lVbCVfuSZ7gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IInFcbtIRCQETEckUCMKRZEler5baEwuVmei366VVc8mTtqB6GqFMFsILKM5o9pCbSeHIlQ1lKik2h4jV/yoibZ17ahVa9tkt6LxaSuuymlzywpNAAC9U5VbqlOukYT+E01l/3xvvtB9qaDMWFufuDkRwg6Ln2a8GAyobdHsHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NsRS6jUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb9jg017617;
	Wed, 30 Jul 2025 21:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fYXmUgtDhZVPhhdm/V2ZjX
	ttfyf75BghnxyqwP+suDQ=; b=NsRS6jUhFm051yVbdy7w3mmb1y6EEx5nX+/KAs
	1EPhO82RBLHvsK7P5phuyrV5Apdfi9wCNErWnLenSK1IhLnET3Ea8rL710Tgr1eC
	1mG9jah2QYqQUjGy8xnPAGVO5roUpbx6ht/aw+kA60sIyEPUlUzUK4Db/EGHnTb1
	NBVNoWtruiRjrZmBvBxg45EbRyYTdMRIv7Nb6yVUp+4/fH9gmNYGVAnsDqYHqSdk
	FliGwjGYMoJcElAeyBEisqE4HYOPTvXldi1MwcrXj1H0gKgQQtKBj0MaFNXk+fek
	OJ/zYE6sPcRb5V+dWIqeDgWB+ZuhcDElH9wWl/DHkxS0oRPg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda59wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 21:30:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ULU5Ot012677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 21:30:05 GMT
Received: from hu-djaggi-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 14:30:05 -0700
From: Deepti Jaggi <quic_djaggi@quicinc.com>
Date: Wed, 30 Jul 2025 14:30:00 -0700
Subject: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANeOimgC/0XMQQ6CMBCF4auQWTukTBksrryHMYaUKYwJoK0aE
 8LdrW7cvS95+VdIElUSHIoVorw06TJnNLsC/NjNg6D22UCG2OzJoSNmTH5SlL5trAQXKmbI/1u
 UoO9f63TODnGZ8DFG6f6Fmqwx7Kgubdta4gYrvD/VX/prNwx6/G6dfemXCbbtAz0rENueAAAA
X-Change-ID: 20250728-8255-scmi-ed963ef8f155
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@oss.qualcomm.com>, Nikunj Kela <quic_nkela@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Deepti Jaggi
	<quic_djaggi@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753911005; l=1844;
 i=quic_djaggi@quicinc.com; s=20250501; h=from:subject:message-id;
 bh=skJf2Bzqhq4yfT++BK+QHTMYMPnwGA25TtvhHHnGmgM=;
 b=AqpY3K5/VxB6qNqTYurcE51SRntRr2/VkV39N0SwP1vw8y0eECIig+GIPAymSBnIXlAcAM8+h
 mw2IwOiRCV2B4dzwtGTCvDGKnD8mvb5LcEBSztXi8kmBRC94XTOAjZv
X-Developer-Key: i=quic_djaggi@quicinc.com; a=ed25519;
 pk=+b3H5UC/u0pUK5+btJ+35nW+6vKwJV1CfjJ1CJWuOZw=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V2YKOJqjBxpcS_EJGfGl9K6MjCaHFu_5
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a8ede cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=9VXx9WMDf_sXN765KV4A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: V2YKOJqjBxpcS_EJGfGl9K6MjCaHFu_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NiBTYWx0ZWRfX3Qg6jr/e3Thz
 w2qMrMedx1SsmReFdB9SYq0yTr9I22TzDTXVr+p1kuCM4NpckQ+j0o5JVxmFhNR7uwRJkZahvDL
 W5xNihLLaig0HndG2JfXjftxDud25uBFFqEO8wZeX/ppTPIhVc3iWkoJQxH89/yc521JnQlPJ9Y
 SfIZjpSkoFpomTj8Uu83ue1raU2jWKpPLMr/JlCgBss0ThKRfbbssY/OHSF0tIUHrehlDgIBXS5
 85zqUuxi/Pd49zBmxlpM18pmS3ihQMjhIrwvZ2uj3hbTn2E46v5mruyu95c1mKvy43KBHviSH8/
 jmNX8s3YdT6XZ87B0insrF6NBY8ZaJiPbCz6fXhVCYqW4h8NINi7nLYEwBAo0O9ln8TbETAiizn
 FdV/n7c1lrKIgG0iO+DbFMB5kiwTeb6Z3+pw4h/vkDn1L7HNavee69rrL16otHL1uAKp1WnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1011 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300156

From: Nikunj Kela <quic_nkela@quicinc.com>

Allow multiple SCMI instances by extending the scmi node name to include
an instance number suffix.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
---
Changes in v6:
        - Dropped 'this change' from description
	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com

Changes in v5:
        - Added Reviewed-by tag
	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com

Changes in v4:
        - Dropped 'virtual' from subject and description
	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com

Changes in v3:
        - Added Reviewed-by tag
        - Removed the patch from original series[1]

Changes in v2:
        - Fixed scmi nodename pattern

[1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -27,7 +27,7 @@ anyOf:
 
 properties:
   $nodename:
-    const: scmi
+    pattern: '^scmi(-[0-9]+)?$'
 
   compatible:
     oneOf:

---
base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
change-id: 20250728-8255-scmi-ed963ef8f155

Best regards,
-- 
Deepti Jaggi <quic_djaggi@quicinc.com>


