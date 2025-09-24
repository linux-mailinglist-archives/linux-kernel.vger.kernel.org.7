Return-Path: <linux-kernel+bounces-831388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70467B9C870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2563516A6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88724126C1E;
	Wed, 24 Sep 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpzONz8J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117217B418
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756245; cv=none; b=RQKoEsr4WJWBtoJdwX9W7OtWPwZeRbuF8AmbR6WNAZtXGC3kF0jPD6RFXweLyPqX0dCMAWNO7V46eIV8yFtKHSVK73yuUR33GlK6TL3gib561xhSTqtLWSfQ8PBDelkQb9WaweizGnWOV4HUb9vXRUZ5kSn7aX2J93Hgiw9l5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756245; c=relaxed/simple;
	bh=J/wUZYvsar3Y2h2UCXq2yr3vgsHaJOw0fQtfmhXPwDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UOYaLeIhJVLJ8TtUVIDMVtlWaPajWWzM3hRciqzvb9OkgxLp4MsyKQGgdO3eeHdtUVg7QMktMErki4Lq+w7WsdZ/xCQP3E6HTlxRDuo60YmEdDUL6SEW4Q/YyAW8mB4i0aN0Fh+oKQDQwjRF34SjQNkB2sq/vjulJsQvTS+yLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JpzONz8J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODKWl7024010
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=venGlUBJGXHVgO4PVr+luN
	+jDDTyagN3i/2SVPdTnIw=; b=JpzONz8JYWyMU8LMWOq3nQ0Eaila/kLMXac4cA
	hCjWEe18jj4nRz+BFNDjzobtID99Ubs1bcLbduPDI+Aml3BSC18zEXyAjdbNT/bg
	ojztvGGFOZ27lBEq051UX15i6eQfgS55VvAdTtIEWbx0OmBmHTjPNDLe8pNF3XYo
	Q2eQ8UwTApFFlKUc8bWLJOfQ4KURyRZeH8igCDXeAAXf5OiswYWdzh7qifkAvjUT
	itKGPL7tGwDP+g2Wief9vWQF5GqKbVlvngP9j6wgH0bvKy7030q3yI6QHD6bMX8C
	5tWLYiQb1SZIP1icU7i59nueZg3D3UTj5Fyd9q3nU3sjyEUw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d25u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780f9cc532bso272606b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756242; x=1759361042;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=venGlUBJGXHVgO4PVr+luN+jDDTyagN3i/2SVPdTnIw=;
        b=QmqPU+WW9ro23kCK+XtS6TmqJKjLG2d3FN4bSXJ1BMIfZDX8RglXT0sKqdYbRgztbg
         Rt5SrzO4r2JXeNjL0y7UqTDcvZJwXhRhqhu9aXaClL+NBvvBgfKFq6++XRPa3o7CUYSd
         zhNOO/r3Xz26lahFszHS4i+OAKnvpwXUdWqRsoNNuxd5YfpSzxx8fAoqBeTGzbavXrMO
         MF8ruUu/Po6UzpYx0ox3bLAXokN8uCqrOBAgDRYHDPgadswFfTw9b1pgUlULogzpaW8I
         8uuLnBaYAuTZlD7nHk3nv6DPXcMWz3V0CxWpNibmae4+hADGHR1N+FTTAwq3guPyAQ0X
         gTKw==
X-Forwarded-Encrypted: i=1; AJvYcCWVVSBLRuN+7aAluQjtebzrSlwjnDvGZLgO/Aa3HweyAPCZ6revJALBctDLD7138c1RR6XsKxnGKhUR66U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPz/1ia5kcpw6scdxoZWF6VizpdfGsdFdBbmToySYGSxUoOJE8
	373UgS2K+JCs5EBM5p57IM7K+8hH5pkkIjB3WHa0B48/oP3o0Sx/Zr4WAyxtOa+JB4x9PQTlL+I
	v2gZClPdWt37oL13f76HcxETz9S+hRGv1nEuFXrq5IEGkQr7RLo/lM8QkCI+nxqR9u9E=
X-Gm-Gg: ASbGnctlRJgW+pkOQWPouuCQatcGsYqUwObJmwDG1yiVsrqspEiLGd3lcNKnPh+Fqzx
	uyiDz/E34PAiF9KXQ6SPgmCjqRUl3GN4jzvkSlfVMUrhoybJkw1hs6YWuCv3utZEzCGOypcbkvS
	56HhYdrUAp03m4rhHOdrqKfs/+CLGZHHsyFcGf0PgPm9BhS46F6bVDrKEzDFp3HQdXZ6VASTEld
	KoN/lEsMMudK2ZlnHURRMmQ3USOghSNzzhHoyXJPkQQH/mWvCqwbUGm2HGRtMz1hN45T5Gyh+bb
	GHtjr3KHzZ6klKj44hd6/v6RueLFKqcEIIc08tw0hWgehOUIG0l2ewYVBmBhWTcjWTX2qtihmGy
	rjjdqLxr/YeKhJcw=
X-Received: by 2002:a05:6a00:1a04:b0:77f:3826:3472 with SMTP id d2e1a72fcca58-78100f78564mr551419b3a.6.1758756242239;
        Wed, 24 Sep 2025 16:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrMYAL4mcDsgg3Sh/tiUOQ7NRb3zZGfekd1omIF5BXOfVOq71sZSvHV3cWFQc0HY18frAdXw==
X-Received: by 2002:a05:6a00:1a04:b0:77f:3826:3472 with SMTP id d2e1a72fcca58-78100f78564mr551395b3a.6.1758756241804;
        Wed, 24 Sep 2025 16:24:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c279f8sm156571b3a.98.2025.09.24.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:23:56 -0700
Subject: [PATCH] dt-bindings: mfd: qcom,tcsr: Add compatible for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIt91GgC/x3MywqDQAyF4VeRrBtwrNXaV5Eu5hI1iFNJRITBd
 3fs8oP/nARKwqTwKRII7az8ixnmUYCfbBwJOWRDVVavsjMtznHFZQhYh/D0b0ON6xzkehUa+Pg
 /9d9sZ5XQiY1+uveL1Y0EzvMC28XrRHIAAAA=
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756240; l=997;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=J/wUZYvsar3Y2h2UCXq2yr3vgsHaJOw0fQtfmhXPwDM=;
 b=7mUwTYmWH2cOVn3SIvSc8XbSr6ganRZpjywQnoLF1FSziThRn8e6rF5DGYgh1G8Cfp9sywakk
 Qp/whHZyOdYBS0C4W7H2RsK1SsZjGqcqASh6r/Fr/Mot9GL6yHawfUr
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47d93 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=P9gvD56xMKEh8kHMZp4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: BnwQ5oXB2OV-oebkQC2oHEJ-YPwCqdX_
X-Proofpoint-ORIG-GUID: BnwQ5oXB2OV-oebkQC2oHEJ-YPwCqdX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX/uxKlGzViXYE
 FszytC/UFcEJ7RbkcdAZieylBB38NaUXXykCIx4ml4Yf24KMVvKQeXZxyvcTpRklHQmFGntT+Bm
 IVd/eIGO2AEQqrTtk5D9YE9U5pSLXOlYpBAdRiZ12gS5VfIK8qzLE2qlvBU7OiBmEbrk9W4pBDr
 IsM+rlhaPRWNzaCduldWyV0qwaVGjMiRRhAYd7UFlXlDfnRI5rnLkipPRZL750KAsSKRG2J2Kls
 PAqsm/g8U+XHs6hZ2NsKw0yDx2h3vk+RhkdLxEI0En9b3HvOFCxW+fckt2cQb3G0B/ptM32hZRD
 iZ1KLXtv2yemnb0kUQgeNrnY6QKNVgVyf3DMEM4v7yR0u4dy4yU4Hxj2INWkGR06Han+ijPECvE
 lNOzFBFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Document the qcom,tcsr-kaanapali compatible, tcsr will provide various
control and status functions for their peripherals.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 14ae3f00ef7e..ae55b0a70766 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -48,6 +48,7 @@ properties:
           - qcom,tcsr-ipq8064
           - qcom,tcsr-ipq8074
           - qcom,tcsr-ipq9574
+          - qcom,tcsr-kaanapali
           - qcom,tcsr-mdm9615
           - qcom,tcsr-msm8226
           - qcom,tcsr-msm8660

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-mfd-4dd3c81e6b9b

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


