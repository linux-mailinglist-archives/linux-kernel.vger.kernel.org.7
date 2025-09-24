Return-Path: <linux-kernel+bounces-831442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64EB9CACC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EB23A34CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A0286D55;
	Wed, 24 Sep 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4m4foyo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20B28E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757393; cv=none; b=EfRvIJFJQHHlsOapuV4342l+sXHcshQq05kFpAyNg6LoHiaWBUGhy7/rZQJvvSJhC79Pkznrq1b8bljgnjpLEG8FoGdsxuP27d0fHts9RODtgwnoKvCrNgWL60AXHLPr25Pf1NTCiy143a36RENtVPZ4Cgrl7WmoNj/TS+MDpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757393; c=relaxed/simple;
	bh=F2qzhll4rnV6qp4p+iiemJejeTwjSJOcKtQj7uM8PY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ssik47e/40Se+qlxeZYrDLw6YnqT3+rKZBSgml+k5WO5O2jWOTSG6Swy/T+H63CuFC1zKYmWZc5vlSQsSIquUOhVdeXkoOxuOqzit3EKf2BIOougo7tXQkrRHF8Mkw7+nno7CPthjg4gU4K1mMhJjMcoYTeD7La6I++ploOzGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4m4foyo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONKY7O002710
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OE90dQO3EfHsg8dQTQQGWw
	3g8iNVOW0A6GZ45GxtMpI=; b=f4m4foyoqc+G0fXpjRNgXvG8a0vFSVAwIiZgGu
	L4jgAWGFVxJ/iN1ANyv7hK6DmiVrLC6TJ/1qcI//ehARIVqgrbb+Ayq8Em8wxpL7
	6Ttm9AMGrMom7w7zNidCiYd0ifAopujmEHPPz/0F8AR49/76gwcqDnHs60/Khft2
	KeNXA//jSQQLGBRYRjIdcVMPM2cQ3Xxvi6DoskZrEsKK6crr72MWBep9bHyuF1ZF
	mmY7lmUfpQU/gnutlyYNMpQxsGu7AqKzHENbFT/VDUf8qsdBCcLDaQb8v0UXo4M1
	cUGejLpDhPdiZboLFUwpZUpm3PUk37fitU8Gu4PNREFDjyQg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0mbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:43:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so199608a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757391; x=1759362191;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE90dQO3EfHsg8dQTQQGWw3g8iNVOW0A6GZ45GxtMpI=;
        b=uUMXhRce44PhBcmBFHQgA7BbCjuB3qalNrxZT1rB+p+KUWM0Dwl5Ues3ohTLLoTgJc
         QWxgQqureOwe2wONVgKuqXptDt2FbY7aKvUjpllq50zpx8v0gHwgF80ZqTEIvThfpK0b
         VVPSRXL1wLUjfASkqVJg4M4gC0Qi/wVdH/HK96oPBV+9pG+WzznYKjMEJnCqwQVc4GBH
         I8LmSh1suKtZOe8Awb2S1BPdkprB5ETNpiX4t1EdkwGB+SfShOw6y71bbci4942OIQ31
         X4CnmE2jTn3n2QWOwYdcbEyLS/hvjPzI9xsvPH72ESocJmz0z/l1wLFrWYHLdzZzlBIj
         eMew==
X-Forwarded-Encrypted: i=1; AJvYcCXKL5QR4ycKS72Z2uXMxqSRkQB4sqMLZRSz/alxEhnJUIcvVqdlfknbOGRjkzn4OtL9h709d5MxXZKSnFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScORipsAVS3uCakCw5yXTNITaGJJ4qF+ZTwcn0d8oP/G4/6x3
	89w6aK3cOWp/bjiQKbS9uazw4w6NHYXMyz61qABiHNQJ8TUDv8huDuyhTsHJaEvoHOLtbVRDjoI
	+Y85y6LWA9SH7qIDBxsk+kEqRKJy6N1Y87vpHDK2Hn40k6uBrUIQRgJuKeIrawywecRI=
X-Gm-Gg: ASbGncslrWMKV075YVws7loW249MUBSMOWLmpa5I/P6a5UUSWLDJnvHIaEcEBIxU/c7
	PLiB/iBgLc+SCdu7zCSHUR9PZtk2SuNF6TdvhIY6KNx4utFLuOws0MykBpahgtkEPsrq0yFnSts
	hza3QtKLW0YApTDZ0YJ2mV3XBg16duJJtnjW56FUENUgSy+xEykIj1U3PIyYUZA7IBJWoGwwxZv
	zn2lFloMktppWTSeVl9uCAbOuIVm14htlFA/HTBJDIKEQ1HaFnm6AbnvU1jlTvLgC23GkdUpFtl
	j76JFEnqFXZO+XDPf+c6kLYzZHCHrLlw+MNN1UrJe9xC6Vc5XD9D4mfi1gvq+o0RltxCay1y5x4
	1aEaxasb8QxCzp58=
X-Received: by 2002:a05:6a20:12c5:b0:2c2:f61b:5ffd with SMTP id adf61e73a8af0-2e9a3aac3damr690802637.10.1758757390967;
        Wed, 24 Sep 2025 16:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdM4ijDgDGRv0rYQ1+JtfSlIAWMcIT/CoFmlBklSjquUqoOjfg/bMsMSIQAlO9tyRIZe25IA==
X-Received: by 2002:a05:6a20:12c5:b0:2c2:f61b:5ffd with SMTP id adf61e73a8af0-2e9a3aac3damr690775637.10.1758757390530;
        Wed, 24 Sep 2025 16:43:10 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2733fsm183430b3a.94.2025.09.24.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:43:10 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:43:06 -0700
Subject: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Document PMICs present
 on Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAmC1GgC/x3MwQrCMAyA4VcZORuYLRvEVxEPbZdtQRZLIiKMv
 bt1x+/w/zs4m7DDrdvB+CMuL224Xjooa9KFUaZmCH0YegoRn1qxblIwi06iC9JYKMaBaGaGllX
 jWb7n8v5ozskZsyUt63+0JX+zwXH8ALob7q97AAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757389; l=1296;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=veyw1AffRHwKPZqeOLxkvoQHic8p84t5kQzNdVCN5bg=;
 b=pqB9lAf+wUUmxxd20vqrwB/ZnE0I7HxGq5hp/VrP2fLjSw04F5rzW+wbuau5E0nOG2rApbvIm
 IbrLWuCbZYdCHSJdwHRhT/G2j915pwIbZ78vPVHARa7sJxPVj64MWBr
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: PYb8Q8zN5MyYokIkOboQNRbmHHNSXA0B
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d48210 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=s4ALIw3xRCdf1ZLDqIgA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXzkbYtJj3b1fK
 Fd0Sa1+1OuAt+Nm1aq1VHNMurShMf7zpCBIPht97z0B7D9cNn4hmt1IVMFTvnJ8372nGixaXsIK
 KsgYW3+hRhdjru5zW9vbmHEzBOFwSs/kLuqfFKD+rhjyro7ZWRMcIkZAPbCPMfVbY/Ot0xDS7eu
 H2hQvm4cfdcHIQfAbodZbMrVBQQ6CRyMThsrgL/SthXcl2p5z+xIscNmQculzHcFmC9qd7CJQJ4
 ksdS154olhznKa7Wpwv1SJyIGIDb6EXNrGIP4kzvF5euySuzbs17empkTedVrX4ewDM4YUeCWln
 xz5Dh7cWHO/Iy1CV3FyoLsQ/imlCSBWUmUuNr83hXQF1EcKok5tRoOpFk6xRe2sjWWuvHD0RWoC
 6JIM5LJt
X-Proofpoint-ORIG-GUID: PYb8Q8zN5MyYokIkOboQNRbmHHNSXA0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Document compatibles for the pmh0101, pmh0104, pmh0110 and pmk8850
SPMI PMICs.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..427023cb11c5 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -78,6 +78,9 @@ properties:
           - qcom,pmc8380
           - qcom,pmd8028
           - qcom,pmd9635
+          - qcom,pmh0101
+          - qcom,pmh0104
+          - qcom,pmh0110
           - qcom,pmi632
           - qcom,pmi8950
           - qcom,pmi8962
@@ -87,6 +90,7 @@ properties:
           - qcom,pmk8002
           - qcom,pmk8350
           - qcom,pmk8550
+          - qcom,pmk8850
           - qcom,pmm8155au
           - qcom,pmm8654au
           - qcom,pmp8074

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250923-knp-pmic-binding-96c933599fee

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


