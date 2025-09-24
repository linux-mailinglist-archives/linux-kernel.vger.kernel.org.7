Return-Path: <linux-kernel+bounces-831449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F52B9CB35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF4F1B22C96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A62273D6F;
	Wed, 24 Sep 2025 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR+MTacN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0B27991E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757483; cv=none; b=dTDS+vrD2TcaDNe3yAdAP8weTG6lYQa/7m1jaF0n3EIXg7TLFy3aWDkEwFavKRsym5qpTv60XMum+K03t5lyuB0K/A7a2kLUvAA3lUJHqU9yJzwF5IeUzCnD9k3nUN85oJxb2HVetxfKEm63pTct3QmJvCQhXKszj3CXIPDVf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757483; c=relaxed/simple;
	bh=+vfSzZt3jkmxZ01JyNHaIM5Mu98blH6EPZ4R49GXXak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pDUqTyp3WPaxkNyDuDzw7Uqb4IoQRK8t1P7Z3i53RMn7aF02/PDXtEY3UUcVCilWll44lOTPpK7BxZsrTL9BQ0ntJAcU3m6XxgXTdm54ArJrzNS0Pb5EHPcuYte5qiNW/6p9gQisnvZdfccuhgW9d+4XLvQL5Z2hL/vEX4QMXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WR+MTacN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCl58w016458
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X2impUdlHgs08G5cM438Hc
	r93z30loujiAfWpv10igQ=; b=WR+MTacNCAwIG5u2ElFkkGcwFRIq9QzY83z2pw
	8R+bDxAbmqHH42uBnS2GufXahMaqwRincUrSi8aEgbsTDOs8vjkE9ysmuUuOOZzd
	1IatvjytQF4zTaFhI8XTajGOyal8N972wbyy3r1WUTsfFDMdWwdToALYB9ss/DB2
	t6AIqhFWY4nlKdc4pwRZIdTZfnWQPQjZC7YaTdxOnR4rMPHjmN3DFZVRw5IVlt10
	53DVP2jqScTfUTli6/ANyhJqL5J0MIbnbd23twjuEKk1KqupXwVu2g3OrZ2qehqf
	eJ+ufaHBvmSFfjvJVPh7TWp37VZuJ+aLakc/6jR9M8a8lpHw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhvx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso3466425ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757481; x=1759362281;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2impUdlHgs08G5cM438Hcr93z30loujiAfWpv10igQ=;
        b=Iv/G6esH9BKQb1SJ/VLwsa1xGiT9Dh21ZcdsicxUpJ3fQmRlY9xuSQxWBGJJpx3MCO
         G+Nhkzka23oCrMAvYULWqpTJWYKkjuXXdxDs7fkUQdLIbjyGFc2uw7GMQHN6fVJRxL8z
         bgFrZp+ZqaXLd4SqUIW3aBjmyEBaTvbzcwXIPrBsLt/VKzMb/VFz2RwVUWX4AKBhrM6I
         eaD9CuofbTYXAfyDrJvLxbwgFfLIREsyH1LiCuRuXqUkDpBcVaztwGDp5X5kxWRD39x9
         U9k5lTBv7sTv6LFl0CDTePx1GAsW1s7pwOaltzkJT7GhQ6X7wI3NtfcYaZ49v+xkCMs9
         yeqg==
X-Forwarded-Encrypted: i=1; AJvYcCX5g9HkIumJmT4uj3Xzq9HMT9zKcRMlVqRPYM5IaEGR9iHWHf3byULndVCSFI8EO9hzd1kUaR173OCCP5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbC29fmm2casDJ2LhbClzB6UTlmGOFGOulFjROGrdhM/UTLww
	JiCMtSejCgoH8slcq7EkS7+qRrg/dLcVEV8GkRXQwlzo28ImzenDjvF4OYFBrU/XRTCYz5AcL32
	M0HTPvIqGqLpE7L22awvDdQ+CKfxYhYaNyMzZR0yN8OHRct2oz7jqifolI6A4WxwkiMo=
X-Gm-Gg: ASbGncvZMIc2hBrQY0w9ptTXcBYi+VZ3iZ5x3hGYWXajt0D9zuLSCDAllkPRvdYThJD
	2xDZR74JLi0iF/Jci9wXDKw9xsnY2I2ElfNqgWYjpOYp0+PZwUdd/TBOGP1i60JrvVig/+ORIwY
	wg4aHdtZ1WgmLaSHHlxX0aBn+xrF8D2cdUIuRp6ktGME2vdgJzMvQZkOmw5ZVgLkJgqRry9icaV
	7qrd98JJ69QBsN3DKUfzOpPDp+xlxdOFf8py+iLNLR5DaqJUnFgl1gMMQdFqFjN0qwYYLUH9S5b
	rA8VusJ9LigJFo0ZhGJKazmE+jR+HhuAVY/4Jc237RmbjRlJewdYcPaRmHK5lXN/j3uJKydrPi1
	KotpCnytriPXnRcY=
X-Received: by 2002:a17:903:138c:b0:24c:af27:b71 with SMTP id d9443c01a7336-27ed724ab01mr3625205ad.20.1758757480731;
        Wed, 24 Sep 2025 16:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe3osHo06ryw9DSt8Ew/7EWK+5zKQOxMidrxm+DGQQ0iuOMv1YJGJtPULrq73FkfXh0KaDjA==
X-Received: by 2002:a17:903:138c:b0:24c:af27:b71 with SMTP id d9443c01a7336-27ed724ab01mr3625005ad.20.1758757480276;
        Wed, 24 Sep 2025 16:44:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad21e9sm4257705ad.144.2025.09.24.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:44:39 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:44:36 -0700
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the Kaanapali GPI DMA
 engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGOC1GgC/x3MUQqDMBCE4avIPnchCtraq0gfEjPWpZjKri2Ce
 Hejjx/8MxsZVGD0LDZS/MXkmzLKW0H96NMbLDGbKlfVri3v/Ekzh58xakQ0TXzAgXI9KwZZr6f
 ulR28gYP61I/nfvK2QGnfD2qdSg5yAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757479; l=995;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=/TajRCKXELmb0GbPNJOnw3zeHwTzpoeuNk1uSE9IkJY=;
 b=3d+GD3HxBx6rRCdZvn2GG3Tne/gAiuEKRNcopvHMA+d0sf54VDRHBlQ2loOOCTHddgGDOcjBZ
 iIS+XxM5+HGCYhgWBofrA3+48ejMlTl9ax7LYssn4yJBd8RPub1s5SS
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d48269 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jIbp_Hnnr6_5fXc8a4MA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: rkb7JQN6N6BRACK8Zum26VJ4s4RExah7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX+iFH8aO6PFxZ
 rdN+BRp5q5o7xTMda55XzIOvx3f5kzKtPBF2rksJx9JqmXLGmf4IJTyyf/lviGq/AWnU0vLuH/v
 wZLFxpt/myfqR6hAxVJ1qN3Vbsbyd6gV0bfdNKcuuFKYXbdnJr6ZJmljiI0syY56EqDj5ZZx4Oo
 s4mP8g1ezvv+0HRxmJ0cxfyYbgmShtmzqkXvgNjY+2Qakx7vWb5lda+Dcm/8u0n6QbjIVljnYfe
 liCgex1RujTVFv8unoalfl0qy7vqvQIW/ClyD9DwWjIA+5FgfGCojYpw3RwoaNVqT0IiDdbDfji
 mRtZz5pFWaOlrHf6tYldHRkRgRmNNPMgbADT2QzUy0kZyManY1KU6eQImq3L1e4rPz7gLr/6kE9
 aVT/Sxtm
X-Proofpoint-ORIG-GUID: rkb7JQN6N6BRACK8Zum26VJ4s4RExah7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Kaanapali platform.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..e7b8f59a5264 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-bus-e5ede66d8e0e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


