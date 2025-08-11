Return-Path: <linux-kernel+bounces-762297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B64B2049D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBE03AE8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AFE2222D7;
	Mon, 11 Aug 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kLeGAywx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562F2264A3;
	Mon, 11 Aug 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906043; cv=none; b=Je+ru2xHt4ZhZu1may8vQhC9F0p4DhNon95VcTuUnobMsRs5c4rIuK9fx0p41kd2UzBaJyCUYVmsz6QnOVaqkmXWv5oT89ovi00eSKgU67LirOXEvr5xSfwaUpdwfGVgxJHg9TFvHAqdyerBB8DO6YQkRO7uQNMsfHzm59tWzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906043; c=relaxed/simple;
	bh=iwzd7e66Z9YSwLHyEDKECZDQ4lbE4ar5MJ8qPN5e9do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVxTHbIfUK5a2rlPQhKI3fJeHkSS8YJIglyIIeRCpPhmF/XB0CBIJdaJaqxO8hvfMSjkoH1wg445Q29Qh+gEUEgG2Ut+XdcU97IE7kkth89ZdK6vLFhCxNiTIftBiOwK7O62pMbDT0iqGuz1wdp494Z92NoDnxdWsgmAz3g7+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kLeGAywx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dG3u029264;
	Mon, 11 Aug 2025 09:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CWHCyxTc03WsGsUCc9DQvI
	omyghM+2r6Mlg+ggnej70=; b=kLeGAywx9djl0+zK4MersFZOnLj5bsyx7BrKLh
	5PaZ1/0dbBCGMaTY4Kk22ykwGec6s9jyaEaxBOdE76LU3PNi+3dvyQOVbvQl1hCc
	AfDIwQfp6L12Q9WK/f6nd9a9gbaKt8llUsHmt3DR4NmCl8bEkwBLhUM29hZIekjt
	Abqvtg3hwZX0kwZCSG9Gjr13ShynniabA8ranx7mdsQIXLhrBeLKhxVEzXL03nXX
	pTv6D10/FzRHmIyS33YR0MOQkdJ1mCzFOyoA7O/skMCZZtgQkL3Uyr7f32K30peX
	UFVjFsgcbOsYULUkaAzGbBJGO1DMM+4EsYddP0r+5FYCoK8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbuwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:53:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57B9rwGo027141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:53:58 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 02:53:56 -0700
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Zhenhua
 Huang" <quic_zhenhuah@quicinc.com>
Subject: [PATCH] of/address: Add error logging for of_match_bus() in address translation path
Date: Mon, 11 Aug 2025 17:53:42 +0800
Message-ID: <20250811095342.2383808-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX6u9L1RLYBI/R
 I9ChOxy2ygD4qeXble7L6Sq7OsFbvu0z5a4aIsI3r8ju4UDHuc+NL1Yux2q76PFQPiUjDNmfupp
 mSc9wX1G/CLrocIdyGwIzK7EooJv9B9N72AB7dJKG2e/0Iz8GYUHX/R1Y14HMWhZQpVd0aktmIw
 azn8dg7UsLKHe2hI8MLpg6+6iDjveASk7S8KmHrUiuDoVHKpnxBopRT9hVuxGyAhy9rHJrVALem
 snSfFojIG3wuPmvo+XpOfgQTHklF9U/+dU2T5gPrGq+mYij8dJ2PeVZgymqgW2Y9twzVGG9Wza0
 UWjoFt0Nl+yR9B3ZXdMX6nOzAAXKhmWoK+jqkqJ1GB/rkwWC7n2eIIKxOi5OzgkkzIHPgvgiN2j
 MHyo2eyG
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899bdb6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=T4CoFiDlfSecjn6-qa8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AzLfHZA7G5geS8Z0KlNvF6cSV0qd0i42
X-Proofpoint-ORIG-GUID: AzLfHZA7G5geS8Z0KlNvF6cSV0qd0i42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

The change introduced in
commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
triggers a warning on the direct ancestor node when translating properties
like "iommu-addresses"/"reg". However, it fails to issue a warning if the
ancestor’s ancestor is missing the required cells.
For instance, if node_c lacks the necessary properties, no warning will be
generated. Potential issues will be trigger further.
node_c {
		//NO WARN
	node_b {
		//WARN on missing of "address-cells" and "size-cells"
		node_a {
			xxx = <memory_reion>  //contains "iommu-addresses"
		}
	}
}

Since of_match_bus() is now expected to succeed in traslation path,
routine __of_translate_address. Print an error message would help in
identifying cases where it fails, making such issues easier to diagnose.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 drivers/of/address.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index f0f8f0dd191c..cd33ab64ccf3 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -515,8 +515,10 @@ static u64 __of_translate_address(struct device_node *node,
 	if (parent == NULL)
 		return OF_BAD_ADDR;
 	bus = of_match_bus(parent);
-	if (!bus)
+	if (!bus) {
+		pr_err("of_match_bus failed for device node(%pOF)\n", parent);
 		return OF_BAD_ADDR;
+	}
 
 	/* Count address cells & copy address locally */
 	bus->count_cells(dev, &na, &ns);
@@ -560,8 +562,10 @@ static u64 __of_translate_address(struct device_node *node,
 
 		/* Get new parent bus and counts */
 		pbus = of_match_bus(parent);
-		if (!pbus)
+		if (!pbus) {
+			pr_err("of_match_bus failed for device node(%pOF)\n", parent);
 			return OF_BAD_ADDR;
+		}
 		pbus->count_cells(dev, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
 			pr_err("Bad cell count for %pOF\n", dev);
-- 
2.34.1


