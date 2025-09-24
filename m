Return-Path: <linux-kernel+bounces-831403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B828DB9C918
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D5A1BC3E64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F52C029F;
	Wed, 24 Sep 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaSp1RQX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6D29E0E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756550; cv=none; b=EbPoQVl5+YMAmysZwcXkvASRH7nEZv5LTxsJeBvA/DwheRIV1QlTZTOxQo7fu/7gQRqDg1lnt+8v7zCV4QbRSYC1Cv+iuQYamD4ThKcCYS8f5D/IULbPI6QygPKEJwTmIwDeTetMadAWeUfHQ+c6Au2Gnt2m0PIoXw0MJ5fMIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756550; c=relaxed/simple;
	bh=1ixz4E1H2pIiXzLXyMSyDlIXCkqJA/x/F+DP+KNf3Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmY4Qj3b7u0WZV0RoYg3+UC3t8aaTsu43CRLK2+QO8QlOgGglp9CFczjXHp1shkzLJtSlYWqhwEgKfQRAa1S+0XUkHkcFgJlqYO9luc2vMQa8lQgN0y7obrJpZhcGCfpLl27X0j0FeWI9Y7yH/fKQIHWfLsxTjKCACscD4yXs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaSp1RQX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD1rvc016435
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoYprIzQpGEht+RtS27992YaizRl4nrFk0NKTW3GFWA=; b=GaSp1RQXuPs/Lo47
	6bjaqR8s8oESCs8ROTbo6wAzzzVWbzxoxET/0GlN9dIHC767HknaQBgeHIsstVTe
	my3uH2C7bTc60NlxnpA9AaDAwxDWXcnYYoRY2mUIlfXZBTldGLXruRKtF8JBzdu3
	nReElghga/YDVLdy+vu1TEI/mN8puiRQk9iiSzniQw0pV/0WivLcLSVmOieKycwV
	g6JR0BPiS7dby2qSK9Yrbkb5ZwYJBLP02RKPaghoqXjjlEWMRVQVOTRNT8jDsuKV
	x9ZoKSY488Q0ovObgwBNXdTSebIyUDvLnljn8IOkBK8Byfp54XFfEoSt1UHdGWPM
	pYNC1A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhun7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso2757745ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756548; x=1759361348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoYprIzQpGEht+RtS27992YaizRl4nrFk0NKTW3GFWA=;
        b=ZzdYIVQvPKYju4MJbw13gxGWvw3RqMkHRwwtNdGlR+yVA/m9CTRFk6m7gkjtwwlfyD
         BTT1AuwrUxfm9kbRSio5PInJltB4MRWhwncAMRZD/8YN7yEeQChBnLZCDiKyFTYw9tjn
         Y1BIC1j6cTZVViJfAy0O1o5xVCsOAOwN8TkwGCIQgiyfYomqkjkICzeg4YFh5nKaCaeq
         UAz1VSXndZWEk9NboOuRF2slHtFifSRS++S3racQwYe8Po9bHgm1/3qR/fXV3xkmHbat
         jH99cfMvGl7LOuh/cgIF4D086bTUgejrdZc8rr+JYR8ikmASRDk6HBrSf91c5zjIESGL
         /rqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboQMPiZq69qTGdMh+Q6zLX9VQfcnKuQF2WgGrtxjggdd3QArLmCLQM+d1AKLLWiRLSh7oIQV+/w2Haww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0g/B8CnJILIJba8OF1iYl9IwpcM7JkMHdQpclukw4m3kVvpEz
	hZ36/33Hs96UTJT02V6IKkZDm5vBaOPqTuxkazfMVKgHo+BmQac3EVaolyiKQTFkWkYxgUvM36T
	gCyTWyhaiBVA79kjLd+Webz14TCVNa8Pee15uj1rB+l3yKFAUDS3XwVWSla4qeSt4ESk=
X-Gm-Gg: ASbGncvb9rnS1B+o3vIKvF8eUq63CuFIlq7O/Tan2+FGJsGvM1i9Dst3MRcj2M9BURP
	OJzCsHnaCY1zCyckOBtPV46J6FHu5Tu6wMWnwEfXps0tYJpxTx6Uqq6bxWCJShbsjqA0IbQulU0
	8cAaRdZbalQ1jpOhOSIg1WRcuhL/2fApmvIZnyXxaCYYpOKRWfR/HCYX1yK7AuyTyw0uTWh223y
	jB9jRwsc8yCXrobjML1KU6EsoYYi+c3mv4SI787irw6ckbIZ8F12e0HftCmvaWdHlQ3i7Ko5WQB
	9zfEfhFT39cP0hU6/mVcYRYaY2vh/tzFwTgWsc4tlPMKA8qFyLMUCg6FKvcT9yRmZmPpprCcT0P
	dh0QB3hYNx/Qpbs0=
X-Received: by 2002:a17:902:e749:b0:27d:6cdc:99e4 with SMTP id d9443c01a7336-27ed49e6cacmr15277835ad.21.1758756547564;
        Wed, 24 Sep 2025 16:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgt7aoTizG+JzBBCRszUgmA8ZQFFFV6kXdzPC21oHMm1YuShUXyP6D9IxHyhwdW2zXjSqSjQ==
X-Received: by 2002:a17:902:e749:b0:27d:6cdc:99e4 with SMTP id d9443c01a7336-27ed49e6cacmr15277545ad.21.1758756547098;
        Wed, 24 Sep 2025 16:29:07 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm4292825ad.30.2025.09.24.16.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:29:06 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:29:01 -0700
Subject: [PATCH 2/2] dt-bindings: phy: Add QMP UFS PHY compatible for
 Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-ufs-v1-2-42e0955a1f7c@oss.qualcomm.com>
References: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-ufs-v1-0-42e0955a1f7c@oss.qualcomm.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756543; l=1139;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=1ixz4E1H2pIiXzLXyMSyDlIXCkqJA/x/F+DP+KNf3Q0=;
 b=e4+RfHwGDQQ69QoAGJgmiuXeCPI6N/wpSRjaFCHERX+3Y9Wd6oeSiZH9OuG6nj1rSJ9ctggJX
 nFb12dXQbf5A+22joIbSiJNqgjR/D9hN/PK5aZ9Cp+UdhKJ5qHcQo4N
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47ec4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CSN1HuAOl2xf59Ui8-YA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: EasubH8WxqcD1BeVBmloLA3vZC19rv6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX2fDUbOAXv5KF
 KWdIOzXJl0ulWuSMnNjqCwLQzPLIN7aUUO7Rs25HJeUbSdO3MX6wrMQuRkVgdvGchyDUEQfNSEs
 zNV0NsVTuJaJRZ7h5Mz3rBkgeSmRwG3o9ZqadqaCMjudUn2yLhlml5IBH+F72sYUQUIpsVNwsle
 gQxVJjXStltak79KulYlTfRV0UR2fBR60RFBWaxL7bL1cgDRMDUWCAflawFELZ3Z9Dx5Nu2lvd6
 tfa4jXHflanytdDDTP4zVqGvw/c50i9sw6ON11tOZsEDzk1mjyGSJIdunQi9QJKPpmQl/fqw0gV
 bSQzq+FYn9On/Th6nnw6Abl6WDvPup5AJwivlJkE+h3Hb8jE+4eOr1HdZTSAqHZKtWisn1cXO46
 sVkhxJ7c
X-Proofpoint-ORIG-GUID: EasubH8WxqcD1BeVBmloLA3vZC19rv6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Document the QMP UFS PHY compatible for Qualcomm Kaanapali to support
physical layer functionality for UFS found on the SoC. Use fallback to
indicate the compatibility of the QMP UFS PHY on the Kaanapali with that
on the SM8750.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index a58370a6a5d3..fba7b2549dde 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -24,6 +24,10 @@ properties:
           - enum:
               - qcom,qcs8300-qmp-ufs-phy
           - const: qcom,sa8775p-qmp-ufs-phy
+      - items:
+          - enum:
+              - qcom,kaanapali-qmp-ufs-phy
+          - const: qcom,sm8750-qmp-ufs-phy
       - enum:
           - qcom,msm8996-qmp-ufs-phy
           - qcom,msm8998-qmp-ufs-phy

-- 
2.25.1


