Return-Path: <linux-kernel+bounces-774962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF7B2B9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE731BA6A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BBB262FD1;
	Tue, 19 Aug 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEEiPTOs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07572E229E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585436; cv=none; b=jN6bmoHuliaWgs62xbaA8xmgnyyTi05NUosOicd+WnRjTT4c7von16HXluMm56xEIJQ5+okLcwSHPaZaCWizTUTwbVXDe+JP30g5bhmluQufKgYJ//6ObK86AXzsirsy74f8sap9LvhuQb6FCYNHw++aMRs616B+fnLNO0ufXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585436; c=relaxed/simple;
	bh=UVRoIFA7YXNnu/vJQ5olTkDt4U/pPMeeSryOJu9KTBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPjwvhnf1AFNreIanUWo8pmbuPgVqohBD/ldW8JX1y6TIGsQMQWHK6BRs0txYyXPAsqhQeYe01xtMlZG5Vcb1eUwCuG/BT6XRveWUfEzJXkSfoSi5qLmDo94Gah4BZo1zBXBeFNDOFVKVlZclzc5gO7Kv+T1yLVskVxN4XXPSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FEEiPTOs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J0lUMh002438
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NPgiFAJ7QYLG2oWj/sNVs7ofikmUpmx59tiZmMh5Oas=; b=FEEiPTOsUZeFu/qe
	+jNrfAA1WrSJLADQFgBeTqO8iKt92jHLHJ/BiGhzjA0ceEjv4YwOgLKuL807UJLo
	uGIbkBatZVjtcAkZZiGW1cDnpaCVD7jeVGHZF6/P8u/aoj8R9dKd/LitOHQvGx7V
	BsldcVCDya8C+8C9UcDpM2OWD4vUQtXPEeLdSGtNoWOTUhbiFtQ6mKEBuSlus6at
	cDN3wFXdNyWSSZ5EUqqsinu3JeNjHw8tsbXbI7HQc67vKtwu4A5CLFdnN2Dfb2wp
	JVcOIF4Q8SFRbmNiQL2ZMWCbNipI+VTBWdnPVvmd+DFM4BHSM0i+dh7gyPojtET8
	cuxzbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vje7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:37:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2430c5d4d73so67752675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585432; x=1756190232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPgiFAJ7QYLG2oWj/sNVs7ofikmUpmx59tiZmMh5Oas=;
        b=QgrQR65zVJlFBXtgfDUWdRyTnATBqhhHbfltG1soyAv3LD0bD7E6XcqMRluZwJtBxi
         uTz0FbODBm7+naguyD92vU7XSm8Y+lZO5rmrdv3Wnnx1/Y/zbvtZKHCP19FlU8Wa5tVH
         dxL3HCf4JU+gTHjALhpp3wPfQoKkaVZQqHu/AY7SmmB8l96a6pUYZQpdihC5YtKVPFcn
         XCwKqnzICtbPpe4S0kbEU2+1xvhLgcLSrNneGO92Bn6Z7y44UAf9/p8AUMnb+jzNG48n
         50KvDh66LlmTyt87w8I1ydKA992Ydo2R7LkETfZEUo+L+MrMKr+tne5O8EJNo/T3i4It
         HCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOhQiMxkpV3NE4urfcj6RfclmLD7sM1rTIFBt6muVuULKjfl5Q17gDtz769jnByZdUpb3/xF66Z+jGfr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuG49K/7wiyjN1y+GjV7dHhNdJ3A7TSJHpekk3f5TjcwsxQIE
	ZCAXh366rhRr9+FRv+XGJek0tmZXudVYgnGCOO511YNp31ELVMfz2tBJysI3ORuwPYD+hvrILGV
	QJlIDuEofHdVS5L0Sac47Xo0AsviHukDwI/MRu9pVDItVMmkZU4xN39XqEYJ57dLxppQwUjUNmY
	MQuw==
X-Gm-Gg: ASbGncuJ4quDnsjX2cDAXj+TbiqYa3gLxW3nhoyumNEZ7moqSdX8OU+Fcd+2d8aOcpQ
	KQodxuiCABPt+4oupe2IYsUUzeZUW4JU3DI4KLinvZPXYP53tfbySmrLl2FG7Yt8OB6b8jvgVbC
	BuB6llqSzVyUaFIX1Vv0v5sk1OCr4U09YmKp8jjwrY5poTenwEOGupsHS3ABgLFyF1+kXGpjfVM
	Gse3twVjet0GnzHNDDpDzjSdtQU0KyNIHVTIdtl75uoTqBceGittBGUH8o0xNX3S9DTtMSR8tC1
	9MJ7SK6tficEvjUIf3kZ83erZIwWfNiu73joBHcThG5vkVqJg5RVoQCzdbWmI8WNZHCyUhvEUGP
	y57jo+siy/sMkiA75ymeuMavyL4TXPBrrRQ==
X-Received: by 2002:a17:902:dacf:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245e0ebd338mr17897125ad.15.1755585432106;
        Mon, 18 Aug 2025 23:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs5sSOdxz4RmFjmlJHx9g8dTbVBE1WGeTusAu1XpGUGqae1RKUVGWzRGqVqz2wkAnydBOXQw==
X-Received: by 2002:a17:902:dacf:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245e0ebd338mr17896935ad.15.1755585431668;
        Mon, 18 Aug 2025 23:37:11 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:37:11 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:36:01 +0800
Subject: [PATCH v4 6/6] arm64: dts: qcom: sa8155p-adp: Inverse phy-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-6-5050ed3402cb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585389; l=949;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=UVRoIFA7YXNnu/vJQ5olTkDt4U/pPMeeSryOJu9KTBM=;
 b=tsf+6WvUJKGOAH+FBQ4hmhftcJq+MxJgP5hpWHWfw7nVpRZpaoDF3ljPE8azKnO8ViTgXsSGS
 YPtA30xLy2ODO3YSOHN1nrjjEXlEbtXd3G+JBkkD4/mZWXfZrbYVwV0
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX52VLWU1XYj9b
 ky9tbOcyVoRM6WV4VCfPTC9GQA++ej9J1hdF5sNGn3EsrJzC4smqmiDM526H45YXmpeKDNzCX5f
 sWOUml774V0fNP/2J0ipECY9UrsQxJqagTiDmPpxVfkWaUfiYDsRFjL1/WN3jxz0qX4+258UXx8
 scKkvNuQoDO8hjgJamjg5oo4MEjNwSJjRXaf3ZhjgFcjrLfeVKrixHBuz7KKH1UvAwdDZATtUYW
 8Vfd/mB8ODrwbIiOjU9NCcnEm3oIQI8U9Lsv9nhJvFeo57C+AeEZqIZBDpxusHPisl7LUQZOg5o
 2JGqx7m3ySV7TEaQBynSdr2dXV8IJMcb1OxAgYMckbi6pbxH8pm1xA4i1V0fkY7IRQx0Manz55o
 XDqkAYHg
X-Proofpoint-GUID: WhPeoFcueq9sY6zyGcJcQpOPr_psUejk
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a41b99 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=78Yoz-F5aJHhz6vTWxYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: WhPeoFcueq9sY6zyGcJcQpOPr_psUejk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

This board expects the MAC to add the delay. Set `phy-mode = "rgmii-id"`
in DTS to match upstream definition and work correctly with the updated
driver, which switches the semantic handling of 'rgmii' and 'rgmii-id'.

Breaking ABI compatibility is acceptable for this board, as it has no
known users or interest from any users.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 388d5ecee949..4ac1a5b09e30 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -325,7 +325,7 @@ &ethernet {
 	pinctrl-0 = <&ethernet_defaults>;
 
 	phy-handle = <&rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	mdio {
 		compatible = "snps,dwmac-mdio";

-- 
2.34.1


