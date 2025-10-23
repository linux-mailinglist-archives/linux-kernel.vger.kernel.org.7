Return-Path: <linux-kernel+bounces-866521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07EABFFFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08177189077B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C454302161;
	Thu, 23 Oct 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNu+rqYa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B3302776
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209095; cv=none; b=I/5C286U0zv0Z913Nu0mXTEZ8txGZ4r5DTBfxsTTUDW9E6gRF/OMDEDKGSe7nAEuBqNzenXjlGwDdSdesMCD1jJDv9zOmcJQdmfw2PmlQKFqTIpQHlvKg1LoihM3yWHhk4UJ0ZF7m3+zj1kJKM8SVSJggcywjr8oohcbcBYcMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209095; c=relaxed/simple;
	bh=k+PmNoXDAXQJS7OetKj0dkK2qhIoz89vlGf8TIfy+1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBeUtx+t7nNJTsDS0rK3xU5PF2BMxnkIq8hadaxu5k6ltUa82kTXPgt90zH94HhqxGxn0id+zYEoNJM2jo6gqiLILGvRlWgVJp9Bcds1KhuJpylSkCTgQp+cWjWClrXrqdFY77wLocTN1F+59FO9DFaBDnrwnaOyMw4cA7d9f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNu+rqYa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6vx3T018580
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifR645KuUyFxKA//L+5AC3NZ2Xa5Oh1zVhSgn6hJBRs=; b=GNu+rqYaSILiqoC3
	slUnNyXTp1RfFzljugTGF5gqyfoXbblqGXcjubZ3evWaKweK233cLi79zwOnbX9g
	uOBQqUljEBhW/dI0J0RmttlM93jMhxl1A0AtlJ3D/1t+Z6Mk0H6bLGsiEfx4qkYA
	F8YyezBSRqG/sNHsS+5KEnWEifnJK6mUZVRQVcXa1rmn+ohLTwcor0IkEWxnuqo2
	8u3gx7G6El8TaPJkAvPz/Tf689GJrRTQZTK22GS43oyfIvFPpjKrnmDKGxw/pJ6b
	2kwAvsWS6YvsFEkd4YTxcf78JTTW6G45d+inTUJIkzkDETUBDtnUmFdTXl5iyPfi
	lSd2ww==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqwjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so1383338b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209091; x=1761813891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifR645KuUyFxKA//L+5AC3NZ2Xa5Oh1zVhSgn6hJBRs=;
        b=Zh/gue/DQBsyB1p6ZWTX592Ut1WldfKYVesuzjQoNivNdAi91g4u9NXdIFcoEI1x96
         wply4WXDCXeHZ7OdV4YzfI3P/2ih5VaoP4aaFjBOnmJ18xQRtdkiPF/4uP3TeYUUG8JT
         egWbjS5ZmzmMhQruF0aF5l3OmOqaDBCThIwdoVIPnQjekHufTOOUr6tBL/7xqqxuRdFZ
         WfGA8VYE7A7aj/6e/K1z0FayGpC42lFxpmFyQeLKRjiQxmioah09juc1t13tBgBRA17v
         /DuZqJp8XwSRXLWE5wYxFNUiNxhVmwEywSVrsa0JgMaoSRCgqPHAohZlbmR0sEjplhoJ
         QPig==
X-Forwarded-Encrypted: i=1; AJvYcCVjX1XAkKeFff4Xx50BroQ/tgPDle15h4gIuki1l0W5jTbHZoBfzu1I5onxp05eecNwukIRYUC+TAn8M4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktaVBI791Fc05nf1pVqQhJ87ak32cJFasjHCsEWaTLHm8A2N/
	9wudFOdKn45C/L1e3eNdCsOQyroc+XEoleGtJVqUtmkw4X4uHnvp5FwTkmZcsWlJp3WoNTPfcR6
	gIIqMnIlZ7xRuSTSysla45cZgGbU9GcCLSmGtPRJsOQpup/3sHZiXcVas3DIY+h+aWHM=
X-Gm-Gg: ASbGncvdMfD9VM4LtN4JbTPqYGtn7HFobCFh6fOhSzyQXFVxiLdLm9ADB03+QA5X/K0
	G4NKDyqPJsRcxl1MWmZc9hnEHxmtolchKDvhz6A7MaTZTf38dBR7jkQbYSvcNqp5wpglJUZBxaE
	VwryU2TUCIl8H/yReUryqcB4BEP3G298cFvWD5YxvzSNKXEcpxylmGTs0NW6VRZdZbFMrURChFD
	schvZZJMgFaZKavVhKEnK/e5dh5i/qOWU3G4heZw4V1nYUtHhBm/gwSpR4XSZ323J7O0BjUg1Y5
	M3xY6tu+q3dvfn1/1/MhAn68A4NbsFatnnEIYscfD02/RhadHuIcitkLh3uGpy0W3EjjmFZXk5o
	cUWJpwqTp5WUqDnAf/VLag2WjloLbbIincQ==
X-Received: by 2002:a05:6a21:3382:b0:319:1c54:1764 with SMTP id adf61e73a8af0-334a8650741mr33069437637.60.1761209091032;
        Thu, 23 Oct 2025 01:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7/01T06H3cxa6y7Y+3Sz9xWN4jXPTvHSIbK3VQSTfvu1y6FfQKeEEaZm5mzR/UjCiLhd6Q==
X-Received: by 2002:a05:6a21:3382:b0:319:1c54:1764 with SMTP id adf61e73a8af0-334a8650741mr33069410637.60.1761209090638;
        Thu, 23 Oct 2025 01:44:50 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c056fbsm1391414a12.17.2025.10.23.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:44:50 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:14:36 +0530
Subject: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: Add support for
 PMR735D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-pmr735d_regulator-v2-1-452e1b28cd38@oss.qualcomm.com>
References: <20251023-pmr735d_regulator-v2-0-452e1b28cd38@oss.qualcomm.com>
In-Reply-To: <20251023-pmr735d_regulator-v2-0-452e1b28cd38@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        jingyi.wang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761209080; l=1753;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=k+PmNoXDAXQJS7OetKj0dkK2qhIoz89vlGf8TIfy+1I=;
 b=nBl4+q7agGbU116/Y/hJMgAdhOCTqaxJ9umeS7PG+LDZT5GwQmZDDun+u9hc0eZK3tEv0lXf4
 tTdomc0YuolAprxvorr0kbUTx8SNsdwRlzE0gDo5927Sw1weP2FDyV1
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXyXYbpiFP+Qnq
 soAweIrOMGLRSb85qYeWr85Mx3Ej7FF5qOtk08npwx0JVD2WMuRoE4c958rpShRB9Ca4T4+I9g5
 RHM/M/wzeTA0bKAOS6obYNMMKnGKgx7FQP/ACOtv3iqyG0KM2ximLq9c/AWYUeDCMN0qI4H/ygn
 wVBUpzZSZFs8TnwAn+o1MMafuQn04BPuDeN8sfaqWkAxwyzI//H/BJHIHjKJn75NGPSiJ3C30IL
 1uql2puoEzm3auxU57CYo8TkA1w64ooEi1s+VnLJAVI28nIy/jGm4qxGekofIfmlL/nI6HdrBDr
 EIkQVh8BkwndygywoOB63yqL9SRmsA56HFI604QakbWjJjA1mjCX9OYC5g4ltphlB6iBfAO1L78
 DsnzZxp/RId2UlaK6LRPWB4ygXf3HQ==
X-Proofpoint-GUID: loVL-wGEpx_su8lfIL6LyPJFSjgBVhUe
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9eb04 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=S1N0t0yXLE9zJeP-jjEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: loVL-wGEpx_su8lfIL6LyPJFSjgBVhUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add support for PMR735D PMIC used on Kaanapali boards.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 40ddc64577e7..4669095039c8 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -59,6 +59,7 @@ description: |
       For PMCX0102, smps1 - smps10, ldo1 - ldo4
       For PMR735A, smps1 - smps3, ldo1 - ldo7
       For PMR735B, ldo1 - ldo12
+      For PMR735D, ldo1 - ldo7
       For PMX55, smps1 - smps7, ldo1 - ldo16
       For PMX65, smps1 - smps8, ldo1 - ldo21
       For PMX75, smps1 - smps10, ldo1 - ldo21
@@ -99,6 +100,7 @@ properties:
       - qcom,pmm8654au-rpmh-regulators
       - qcom,pmr735a-rpmh-regulators
       - qcom,pmr735b-rpmh-regulators
+      - qcom,pmr735d-rpmh-regulators
       - qcom,pmx55-rpmh-regulators
       - qcom,pmx65-rpmh-regulators
       - qcom,pmx75-rpmh-regulators
@@ -496,6 +498,18 @@ allOf:
       patternProperties:
         "^vdd-l([3-6]|9|1[0-2])-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmr735d-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l2-l5-supply: true
+        vdd-l3-l4-supply: true
+      patternProperties:
+        "^vdd-l[6-7]-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.25.1


