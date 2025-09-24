Return-Path: <linux-kernel+bounces-831386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBAB9C85E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761181BC1E07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E328488A;
	Wed, 24 Sep 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amDcCKiW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C628CF5D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756058; cv=none; b=OzVC/3nr+QJEaXRelBdN3V1CAR8bIR2BioMlLlcOnb8Na2nw3PcN+sCzWnIAT0tVA5c9IFprTxFD0pCQz2BcTe0gTYNd+glyLp2MQb7il4M4YeSnPcNwZZTTmgDu2XtjKweDRj/+RF1McYggNz0zMgg3jDfykZFuM5/Y2bVzYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756058; c=relaxed/simple;
	bh=JQS+dRPb44MuhTEHQV3reczj3jSZa2Vg5ixi+Cc9Gd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XjV12Stvdq+k5ZaKoY3S9+ZFDU1AYGkJRpy7uhGnMW8PHUna4xsZ67lyMyzWCcZFQjnVRYRug1sEegDl9k2QrVx+yiOarwTxLt6g4xLPmhazK4MHoCOv6h/LCIlHzqKJdDIQa1oxt/LKU8VDC6zbtfagWPCqe0UEdah0W9YwpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amDcCKiW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCqxFP025092
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RjRBZCuI5DbmcoTG+ZKVHV
	1RlO3aWsPq6ZEeBIERzFk=; b=amDcCKiWTcDGoDh1j753c/Odbaojd6qIdRUfUx
	Ida29KHeoV5PNPd1YK3K8TjE0vEiEN/LFyRb39Y3ACMyxpKmmHN6YeVT/RB0lnJo
	xD1d44gfZeHRHQhu/Ss2jFzN7Jmn+Y8OBEOGtplLvHPbyAMW3+ScyRRZD31zY4B6
	bfjDq0a6S6aWVHXaYqK9BZlxZfXCWBihzuEcb40UOlZhwARx9mjgkW0y4OVHgY1J
	a6dWLh8l+fWlYuF9p9I6A2plVtUWZHVGIEMyC+sU82Dx6a8LpoNm4oCdsaG2bCVx
	LUT5wkwaXToSSLRhhP5br8q0PcezJ3yyFbhRUoBnXdj4cOvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexb4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:20:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so5063195ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756055; x=1759360855;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjRBZCuI5DbmcoTG+ZKVHV1RlO3aWsPq6ZEeBIERzFk=;
        b=IcpySUdhKFAV6TnLao/EoH1fQGwU1wtD6+LOgqD4pPRbR+NoVoumFyU0dePAGl96i8
         /Sote+Ps99wbWZD4uy3WEoC1OmawbpXsrHQ4U+PZmK5wvXGGKnNRg2/CoGDtRv4k2qZS
         3F01bmuf/16A59nkMBs3YwpaekQ2i5faa3RY0lgL2db5kJj0DQt52mq7FtfMpUVLv2yI
         R8+KrmiqDSX3MqpjnI4x/xUGhWtrxRM/IxKBwvg/QYoLodUyNmJSw/YgbIb9s2FtDR1M
         ul62VEmTviARxHOhRDKj3UmVKxwaZ8Ryzub9SPoM5xvddLP/5dUr1rP5A6bgMZORqYUy
         bENw==
X-Forwarded-Encrypted: i=1; AJvYcCVwuvtPqMqJfh3Pw01ZD+IHdYos/xQAn6yTnrwdEnnpygyFZtP7kAVgWSJgakS+1DhWxBfRNF6PY1JDMNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBWXYW7c50hdrCZaAniwpJCD2nvIOgYp6xJ445LS2nliBg0kv
	Hxp4r+QztWWjbld69q4BY8pzuaawZQJrgQT4JzzcvqmclCj8KreH4d9zyviWc6he/yRq+IZztwI
	l0BVAnbZszl5F5i3uhhEJygDzN+NpyAvEKP3cAOVTqRtOrHjtA5ERwMG55NWf4Yc4Sl4=
X-Gm-Gg: ASbGncspZJxrrxJcvxZHLgBAUytR6cRcJIFx83ecq96hZQSMBxQC8eHR5BWWiuyD08Z
	xS5UGqGePwDfIrEgrrK7vfk5SirbE/Za7nTrGpQOFDjzYZwEOC6gxCnham7FNr8yC5oxAsfinsf
	NAtMPMJE+/KEoVC8O0aIaX/N6grlGZWRV4cM/X4m5Z4Mnky1I+zHW9n66sOaddJp8gHhj5RWUQB
	dCPuD/CZy+0Nnqa6wNfH9cJrJBWMeiYtD/FkoK2BLDsVoisGNvCRxv9PGL2YkH8QPTOze+mVecn
	bZChDFsSMWFx1bM3i2WrE+NCqboGFDUrNJu9AheCrxVB/Kgnt2ThkAgyFJXaFrZdvRl7rM+qDh2
	yNqkFmPWE1yd0A9U=
X-Received: by 2002:a17:903:1a85:b0:273:31fb:a86d with SMTP id d9443c01a7336-27ed4a4929amr15431375ad.48.1758756054932;
        Wed, 24 Sep 2025 16:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeM0hbdUN67OpHo4zaljw+tsYzuUtNU90hvs10zQXPj5sC9Lv5GGlOakF9Lou98EdqTsjUqQ==
X-Received: by 2002:a17:903:1a85:b0:273:31fb:a86d with SMTP id d9443c01a7336-27ed4a4929amr15431115ad.48.1758756054541;
        Wed, 24 Sep 2025 16:20:54 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69ab0aesm3894295ad.113.2025.09.24.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:20:54 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:20:51 -0700
Subject: [PATCH] dt-bindings: qcom,pdc: document Kaanapali Power Domain
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pdc-v1-1-1aec7ecd2027@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANJ81GgC/x3M0QrCMAyF4VcZuTbQZQysryJeZG3mglhLImMw9
 u7WXX7wn7ODi6k43LodTFZ1/ZSG/tJBWrg8BTU3AwUaQyTCV6lYc8IhR44hxSvNPbS6msy6nU/
 3R/PELjgZl7T892/2rxgcxw/QcXkScgAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756053; l=970;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=JQS+dRPb44MuhTEHQV3reczj3jSZa2Vg5ixi+Cc9Gd8=;
 b=9uDL8T2mcER+RlLW37ghYixBiR6KWWl6mrX+pI+XYphSuRT9NL8XLGMy8VmHlZ5nj4Nx9aTqC
 GNuuKW1qPGoBUz/yy77Bu4YcC+knNOPS91W5ukLeRYO8o8erH+qokCl
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: sGxprGiUB8Vxaq7UzZbfBl5_0IxERx4d
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d47cd7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=p7asoEvZpU7-M9pbgqQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX3L4AmL9kw/75
 9BHvXBByQPLll+6G/vZXLKV7DJ1nRCamw8qlUUo7gpPaowwUMGVS/oyJSDH+8vj7Ad/OKj80JXD
 KZKoXnVgPKHzhZmMwplhJHsQO3hyjk1xxGUXKfwSBiZjmWZy/I5Rzazw/DDjE0uO2ZKNx98ohhv
 jOHDJNvsxNyuaheK0bfncV38Lw0DpBIFhPyo/uyFksur/Ks64GjcNczSCPYDSbAOYq7aUlRpO9W
 j822s5nCdRaK0f8VLj60i2UmstMRLYP9Cmn8bjWPyAKl9j39VlUWVlEhOE7P/j8E38HU6wAThkc
 +JUe0EpUK0svL9IYhsGXIJtejl2hJXuBOSz5QkiL513Wh57Nv6+nEa9KFZQeSsqIwSS3+QLC8XE
 J7tLh07c
X-Proofpoint-ORIG-GUID: sGxprGiUB8Vxaq7UzZbfBl5_0IxERx4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add a compatible for the Power Domain Controller on Kaanapali platforms.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778..535699de96e8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-pdc-3d9a90c982f1

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


