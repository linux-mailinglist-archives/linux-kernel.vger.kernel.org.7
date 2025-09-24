Return-Path: <linux-kernel+bounces-831392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B82B9C8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1491BC0289
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDA2BE7D1;
	Wed, 24 Sep 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJrX8zTo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD39298CA7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756304; cv=none; b=ho37MKfZ40XtOu3vPWx1E6b0yPTmdLw22Gu8c+dwbZinzwxeDEtPgWm9i3DxoSljXEfxjrmt+DvnQGoFxO3p1FEpMFZg02FufsMmnjiSFFzYT3mxVzWh7Dti3z/VjVTt9b5kgPOkCyvBVkBYaRQTEfY6TxuIHOrchad1WqZU9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756304; c=relaxed/simple;
	bh=1jSNN7nG1Jx/FaYwu3aqqljrHb7gvNyiukhR06RJUMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArrJiSllqpG6aaqApJhhj3H0a+O4F+EvEhg4K2XZ/ZhS4up6i0qNk2MfhDQYU2pfoFN+0BudtUc4bdz2yRVBmbRMH+jrwaoqXpBfHLa8Fv/Y53GQt9qSAqn4r8Aub4Lm4rl/g4GCjr7zISqL/LN2xNY5xRcBdPpQgHFLzUUZUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJrX8zTo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCl57Q016458
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nuP8d2NZYxMa/1aXrVOCmz2l5Nad9HOjeULbPqe/3U4=; b=aJrX8zToOl8EEmTa
	nM0b9iH/mbaTQHR8SxACJAtyXwWiUAY97ZOLdgyEMJYBs2dzszIF1s3f9+fK4Ukj
	jWDJkvTJcS+a4aAztwi4aN0i+7Ohq+QR/EWADwAQI8KwCUYfs/dPLkm/NiXw9sh8
	meIAei/x87/u3rCOMAD1PXJGl0uK6yX1FlvUDUOQG+GFpJWPYDexylvXuKYasDlY
	T0E4/uzrdi2cb6PpJvkw2vXxLhF5kAaId+QWs7KOdzFRcjxXv0hs8NieCG5t0Z5q
	aXtTuQgeb/CFpxQg+jsQ9cfPhJRzSZTVvWiAuBJSS4YPOK3pK3JiMv9eQOue3ONe
	71Syww==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhudf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso6190145ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756301; x=1759361101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuP8d2NZYxMa/1aXrVOCmz2l5Nad9HOjeULbPqe/3U4=;
        b=xSuyfcpndE/LgCpwfzeXedILdRyXCBgnClcpqnOfwAkz90cPe566wrjDDcUg5pmdoM
         68Cx0drcgVTx32KrCx+5Koz1fBicWgTuFjP5iArAmWNfBhbiQUUBrNkVH4cAel1oqDEh
         aHLVvDpUxzf+JkcMOZunjq7GZ2ZLoz1jaxJJA4hrN6x5KNOIs2E+w0NLEIZxrbBirkBx
         9Faf9jxRD6Glk13eMT0r8ODRj3BS+RXV08WuuVqaXthz9mD1NwyAXDc6Yp9/7FfH8opt
         qxa+Y1waHbtYaSVbVFAcqoJMIxRpZvQ52XMbTpze3uNO7mGKheP+nP7cur3x20HKYyrd
         /WYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcSUKfVRfseXWEjrws4OpBghbkL9/NBBnAsiaPhkorPgXcWAGpagoaYGlwHWocvGTRqb/PeThb1ll1O2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2TByKTuLnUfZG8cunNIlpDnwkD1xd5h3GgCW47MDuISutQsB
	8FVRWhI/L9wUIOORzpJf+97PyTKY9fcq1lbHRrvxVjwJnxwBg8mSWvPOFDVCZ2D3Do3QZthXj+P
	kTUKHX3u4Bbwq8vMpj6qsFmRoQNd11SrWGVa3g1jlbfm4utdYhR4jB7nUNOMMiYvr7wo=
X-Gm-Gg: ASbGncuY1y7ktQ8O1Gr2Dv2w/iPRHeNTbVEkAg8HEiUtc97WYFFHWUIgOMfxNrRvlj9
	BMrfDLmXpWr0eVt2GYnWq0dOeCDTvmqWBkPoSCfy1K6bZtlDRyriL3Weu2Ka78m68QVjf5df+k/
	3urnXJsi7pZxLzXpJQ5YoCEiYCzbmeVAZY2m0sDU6jk99ogrMt8L/RM0/bmzddGWqAJn/CprqSq
	8Ez7ZEXdvQ8DmPHTvCuaS5pQfmgcKip7zkYWdbOeLOg2l/qKeoIIh0xaqX0+XQ7j/9kyyWyxg37
	GWQnuYzcsmb5GjBeahNH0fF63b4l1x4X7MfjBFVEzy5WD5exOmxJl8xfZ13cm6bjT29WO3G48Zd
	IqgQJsx5Bh5ginnU=
X-Received: by 2002:a17:902:f707:b0:267:9e3d:9b6e with SMTP id d9443c01a7336-27ed4a653cbmr12739365ad.51.1758756301543;
        Wed, 24 Sep 2025 16:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKd5YW7RIAyNymwkxq9WJ11sgacuX1IvLBuMSes+opRF6AMzkG9E2A93BBbxb6gc7otKLwag==
X-Received: by 2002:a17:902:f707:b0:267:9e3d:9b6e with SMTP id d9443c01a7336-27ed4a653cbmr12739205ad.51.1758756301157;
        Wed, 24 Sep 2025 16:25:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm3981745ad.84.2025.09.24.16.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:25:00 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:24:54 -0700
Subject: [PATCH 1/2] dt-bindings: cache: qcom,llcc: Document the Kaanapali
 LLCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-llcc-v1-1-ae6a016e5138@oss.qualcomm.com>
References: <20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com>
In-Reply-To: <20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756298; l=972;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=1jSNN7nG1Jx/FaYwu3aqqljrHb7gvNyiukhR06RJUMY=;
 b=R1wSI/Rc251P5StZYdCEIKzxhN06cYkYBagmtA1sgGuXNAEl0/noeivlX0HJ4uTDWxAG3ft7S
 4h/YzTHSBbvBknpsH+vBY1dWTX4tbNF3W03lFu9DcCOfBBTN+0Jd7Sl
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47dce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sCV_76e64iQtlowYmxsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: jv7k4aXuMiA5ghB8GfVVO2t0mppbclAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX/jdEA1EBFJPV
 7872EPf2QRtnd6JyH+CGDZC2jpWeh1OLftteBs1cu5IV6enZM+Ce/C2T3oTXQddtL5TZKU7gcDn
 Wq+p+mbERf+ldQvWy9xBc13DoBtcJ188QMe06EDbiDrvIWYxNTf275/eDhzy0EgjCP5gtu9OAsv
 Ah+8cONq+q94lKQdhmffQapRsp7S856sUG5c53KuVc0wx++R0fd9WJTPiUs4jqkd+BSmeN3pdun
 MVcOyr+tpvcmKOP1+1sj9eyUiT8eGDOvflKdWrHS7HDj4cYjcAiNoDBgwK0XtnZYiKvR4a2I36a
 UUS6Es4kzaKYKjh5dgupDBKuTvgVaSfPu+7D0QCT0ZvKM8zDyO0xj8IO1X4y4GY0dgiIGMfSG5Z
 LQr5rK0u
X-Proofpoint-ORIG-GUID: jv7k4aXuMiA5ghB8GfVVO2t0mppbclAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Document the Last Level Cache Controller on Kaanapali platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 37e3ebd55487..a620a2ff5c56 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq5424-llcc
+      - qcom,kaanapali-llcc
       - qcom,qcs615-llcc
       - qcom,qcs8300-llcc
       - qcom,qdu1000-llcc
@@ -272,6 +273,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-llcc
               - qcom,sm8450-llcc
               - qcom,sm8550-llcc
               - qcom,sm8650-llcc

-- 
2.25.1


