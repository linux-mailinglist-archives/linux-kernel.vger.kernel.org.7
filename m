Return-Path: <linux-kernel+bounces-774958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BAB2B9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69454166E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA526A091;
	Tue, 19 Aug 2025 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxriH++/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81626C398
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585410; cv=none; b=i8Ugd2ZzuFmvKYhnRZTPXXgs59Q/VyWuq+sL/vTNOLy/wPr7hIeCNrSqqnm163olkxeHy8QwqCu/Irl9JUKxG2UDq8SH8gISaMUUbQiZwqsZVrf/c91RaIAg7pSgwLaAcmF3TbG8oHKdyMdlKfd9hlfVdEFPAv26OF/lGWvEGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585410; c=relaxed/simple;
	bh=ag43pockrDVtSatmI1WnRHpBp2uI2rmdqCD6gVEQcbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWEe3aVukXB7ZyokzM3Hn1fJwsFSI+ROnbPFqH0OlusQZ7H0hk4wK2H9MOc0Yp1XoeyQ3szZlZ8vAlLuJyKLlPWP2L7TT3OVb473nb01eZ2lNBmpyav26fCILwSO7qnIqGtTuVmzsLWabUjqZ5X6OenI1hBnsZXg2CVWMtaMbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxriH++/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INMAqH015543
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ld9b/944CjtaKJ4f0GVdMrbvW/5r/vcAN6uf8GN4R0w=; b=SxriH++/O4uXEARY
	InmyMzGsG3soLrLTTxi5nUolDv1QgOL05Falu8ascfpYMwGcrIXNhIN09FazkZW+
	RAZeUFb4rW/0Dvd/u1OWZMjT6a27OcdqsSye2NS3ZKNbxyfRWV3lj7nJBM5U+v5k
	GoZmRDOaFJgLsK5f52TBQEx5oY7gjtlJE4ytHq2kGqpWLamu9p4NMDWnRXZpyRK1
	Ds02flI5hTrxzGLBqi0z+1rhaI+9oFSOZxJ6MKj/FYJWIWidAr7Tu6CfAM/YUTEE
	ucwY0N5MAxumQ+BCjPKeZg1WvOmCGu+u60PSXSdVqXO10KaRF+M891uqucQEqIAQ
	q9Ys4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxtfnpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458264c5aso51890565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585408; x=1756190208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld9b/944CjtaKJ4f0GVdMrbvW/5r/vcAN6uf8GN4R0w=;
        b=mRlUSNBh8tHwE6V/0NIooOH/rxn5pUpzShgxfg1u4qsZZPbH8Qg1dkdGGZMEg0OsK9
         n7017EnHdePd5V7a5FDRkjqk3TGo4sfal7Liqe72QV1QkujNHoB0DyZddTol77zFaqcT
         4SV03zB8CzTzqLhBY3og+tEME9SMNvN9kiJOF/akyXlbt5gRJ4Eu//EIip79yNHaDJ2C
         c8GOovb14bB5qVQKHJNT+MNeK3AZ/GlwyWxBuS/Usaj0pq/Yu36rlHE9So7adXs8HNMg
         NbiyGuT8LE/JFLM/QF4QAXemcoz/679w+HyTAwxyYTsqtjkk0X91fKuDhsf74pOg8eMT
         1sXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZhDO3/fDbZqINvUKR9z8iYtiA35o4lcmq6dh/ifm4mFnRQJB0UGpHDkSCIftHwNcWo66i57D0t++aJjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrAx7ruU9lQ5kLpVgjBmY5vjlfpE1Hcs3irkTtaVKBkqazd3X
	wAHQ1+BXZ2Ttx3U5ZjYZsNKS6J94bQGyVmg3iX/Syw0qKRbexlsQE5jj0lhqdmSLHtJUBbtEwsk
	peVNfm5O4OnzGGNV9eDVGUnv5Zj0HIaFKh76zvV7qAJHkwq7cArniOUmIWLb1pWyL9vw=
X-Gm-Gg: ASbGncveNo2at5FTVl4s8Obs4hsBAPoJE+jJW806Tc4qajJ3qi3bz8rQi9aE/sYm5IB
	pW5NshYoz+FSXHf22d1KlLGgM8Pqc34qq1fHiQA909rGBVJNKj8UgyMTlYwFf++JYfGMJvS7xyD
	2c76psLybR4dDdlYn7oK4EN5TQDdpFU5XQktyGdVu6G94S/RrJXxDoyD4L2T3795pYHK79XNQwU
	QbPyd4ImidmSlAsDWLZywByeKkyPm1hxZybMPjS9wspeYHM7qbfcSKiN5se+8yd5GaJRtZVD69R
	+C36NRi+Fe4FF6PDlaTpi0BJB09UwrSgV4I5xkfcnFImzOnd7qoyJ40ce0yLENujnQZtZSr2X4u
	zvJt2D3w6vVK5Ugpp4cw1p9/lyu1mMtdjOQ==
X-Received: by 2002:a17:902:ec85:b0:242:9bcb:7b92 with SMTP id d9443c01a7336-245e04eadeamr18308425ad.54.1755585407747;
        Mon, 18 Aug 2025 23:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjWML1uqzguCXznXnAu0JqJOKHjx8VTTczeOLxTEHogZ2jjjwiB/QPUxpZhx7gk6jZa+sNw==
X-Received: by 2002:a17:902:ec85:b0:242:9bcb:7b92 with SMTP id d9443c01a7336-245e04eadeamr18308195ad.54.1755585407263;
        Mon, 18 Aug 2025 23:36:47 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:36:47 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:35:57 +0800
Subject: [PATCH v4 2/6] net: stmmac: Inverse the phy-mode definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-2-5050ed3402cb@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
In-Reply-To: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585388; l=2354;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ag43pockrDVtSatmI1WnRHpBp2uI2rmdqCD6gVEQcbQ=;
 b=Fcu73+RjcncqZavOSj+QtxfGgYLFkY5TAdyWRJtMz8D97y7ERiL7+MMw4ItBYEW6ZfIbO3jIv
 G65ah+bKButDKbO2XcT87cRZ+H7HKxJ/fAzmR9/uMZr0AG4GRu1e3tC
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: J5wvPC-2w-oQOO182Ydow3Fgi3ytUOSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXy2Us383tLN4S
 gp78DiJx2vIWQCV5RDR7yy/iqlNkxy8VqlAb7I1zwYGV0GN++7sHT0H19u/h0VB13kuxM9ZZMx4
 AZ598C+P11n1TgAJ3tJTr+pbIIEIvjD7rfBjZdrU2V2b8wY4dXTEl50uLYW6Eq4iispvnSfqVus
 P1E5iHqMMFEYrp6nbSpLv6MXxzY4cECzT9KRbsmuC2fhndLqffIdoiKEQYxei1aigRqMMreLGG7
 jV54tpRlhqLnbDcAztmWSS0Ve7oXfnFRwRHXw4931WZAIDCRUy2JlAsORH2woOVPQnD3YPDweoJ
 f+X6UWIfV9D+vDTwNz7O1Q9VbIwFIr8KoH2FzovfANwxrkfO4RHJobXPngoUbGSxs1YkcgdZlLa
 JjsvSl4v
X-Proofpoint-GUID: J5wvPC-2w-oQOO182Ydow3Fgi3ytUOSL
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a41b80 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-JoBx-Ykr0mbciFiY24A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

In the initial device tree submission, the definitions of rgmii and
rgmii-id in the phy-mode property were inverted compared to the
conventions used by the upstream Linux kernel community.

Only QCS-EVB-400 and SA8155-ADP platforms are affected due to the
incorrect PHY mode configuration: 'rgmii' was used instead of the
correct 'rgmii-id'. This change results in an ABI compatibility break,
but it is acceptable as these platforms are not actively used by any
customers, based on current observations.

Qualcomm expects the MAC, not the PHY, to introduce the timing delay,
and the driver is designed accordingly. This is due to specific SoC
hardware that handles delay and sampling internally.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index a4ea72f86ca8..a3e595e3b1e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -390,14 +390,11 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 {
 	struct device *dev = &ethqos->pdev->dev;
-	int phase_shift;
+	int phase_shift = 0;
 	int loopback;
 
 	/* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
-	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
-	    ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
-		phase_shift = 0;
-	else
+	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
 		phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;
 
 	/* Disable loopback mode */
@@ -803,7 +800,14 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (!ethqos)
 		return -ENOMEM;
 
+	/* Qualcomm configures the MAC to introduce delay; instruct the
+	 * PHY not to add additional delay.
+	 */
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RGMII_ID)
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+
 	ethqos->phy_mode = plat_dat->phy_interface;
+
 	switch (ethqos->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:

-- 
2.34.1


