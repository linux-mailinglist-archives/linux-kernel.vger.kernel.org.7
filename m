Return-Path: <linux-kernel+bounces-844536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E5BC2270
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A119A50B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6802E8B8D;
	Tue,  7 Oct 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GELZehE2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8D2E8B72
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855764; cv=none; b=ueG7aTz2NIto+unv/rL1ZAZtiYw978VrJ5ml3s88nSwPOiNmYRapuJHpbb4R6dON2n0e8bCPFnD1l6BPRt0SbU7E+XJBMKVE8Jzqk1m1b+RRV5it17BtE0zSKBx8M2eUjwsibQT+8mY0LHrJFRTFhf4cQhJXjh6BtE4ozuGiAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855764; c=relaxed/simple;
	bh=yQcmBzzoF9DWalLjee8gEifniSD8YVltfiDi807djjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0n57POKpX4cdghlZyvlabUqYn5SOHxl7xN6EHpdmB5q9Hztqk0veUkuevbzfl/LrccwNgIEUBlKD5BXv1BFFJphhv1RuYrKVCdWe9ocbfJO4ojttpfVMAvvuPQSEqp+xI4Z86PZxir6OLm8unnqHbixRTuUT46zI9oPJL4/EZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GELZehE2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ET4F6000416
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 16:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	64fVTnFFfZEl5jGpLIwHf1DYoSU0yN7CegjL03AoTgI=; b=GELZehE2ShGlnKQv
	C22iyDTQdnd++qArj5K4i/pJNOxfiMc72Funw1edh3X/rboFvFCRmroeZUwe2+y/
	ARfiuKqDiLb7ZaKtRFZPScvf62cov5SZc5hMzuR0blXfJ+HFtNsIL8iYnhzr7nEb
	pYGkycI4v3H2u65ojadcQwnt0ILKyX+HQ7uEnTKs4RrJckIwnmMQZOSu82nKj5Vw
	wNWnDWU1Lpf4e6rUB1fDLxbjkaXvadsP/KNI0vGG7EecblolS1Cndr1FP8eGZ2MI
	UURa5c+PEIbZQUhvbTv4qza+jK0XAjz6tko/b9iGsXlf1mQtFYxXY1+W1FB+zWdH
	EKqCbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgr0j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:49:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269939bfccbso74483735ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855759; x=1760460559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64fVTnFFfZEl5jGpLIwHf1DYoSU0yN7CegjL03AoTgI=;
        b=Esqm65KUk8/3QR1bJTwLUkF2/q9hhgpFAnZ+HqAZCMbi7gcyBwqbewBuK467KHZhQM
         FuRRWyHaG1PZEKNeBZ2rhoEpZ8EKrIrMFx1ltopXVYBvzM4jeMqBhrJ8l5iX4kRSIvUF
         c6KQEEkYjAlYh9voypsG//rrM7pipJasLeR+pQHs6kn3JSvnqX4kHJQoccL7j6wxz3xj
         cJPdo6EpXQd34vGRHGII7z+l1Dlci0XWrMMkU4NpGdFNeFGx09otP7r0b9KX5+E3cfCm
         0peuiv76sTUrrNsnCJS0F19+D9P85bxclKg65qO/kCUoF6lsSIXLdEN3CM1j9bhY57xb
         eLxw==
X-Forwarded-Encrypted: i=1; AJvYcCWwvRbAUzQGI+HJ+7CQCLKDy9A4+BtOvh0ykYzTNbD5yZ5cjL81c4QfjsbSXb/MSvKkVMS4YoL9mkMpEwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wLbEVMQjY6iCinugM0m2rVAGZ/6qDKLZaXJw0z0+YZU+2xBy
	jK6bxgbLPFA2iqPZrXLR+D814HX1pCPDjrBIN/Pp2cTxFzL0v+67op3hVDGvt7r1HDgsyg9/I6m
	4Wo5XOgap8+ApGh08CYRXTHQLUog2Xg6bx6skViC0V0v1gWJainFZV10c1TkuOxPNYts=
X-Gm-Gg: ASbGnctblk84bbShyy4p0/zgTBSXzi+pF0P/lwJ6d4yR8vKEp0iToSWV6R3YKNCg2Hc
	O+X3LNkUr+RHUdBuvE5pSLMI+ImMrpQv6sqCFDcKsoUd3wERZhRfPN3BJ/yeuww9PbPujJbT9o0
	zXfdZZ+YeuXPdDS6ZR4wHtE+L0iPcqJjTkG2LoWQ23mfMRYDXe0rfSjFcbNQuLcFhvorzsMY0Bq
	PZK7UxJR4IvCO8gRwqLD7HDNpzHu8GHT4pH/Lg+9/kh9CjMpkClBjhzqVlB7Ixbk2OwV3fZGqtQ
	e9b4M9Exh54SgS81IZybnXEGFNX/tmhTgjzKF5XKsq/J/0FXg8afECtlJaEjW7V/zxEXiGd5
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr5079025ad.40.1759855759230;
        Tue, 07 Oct 2025 09:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFjslecCe61NM3LsrZB6iTB6HGCtdzDllatkqmlEEptEDY1li5Q+TFUuNY5rlkX2+LZYBPuQ==
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr5078675ad.40.1759855758625;
        Tue, 07 Oct 2025 09:49:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1261e2sm171990825ad.38.2025.10.07.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:49:18 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 07 Oct 2025 22:18:46 +0530
Subject: [PATCH v4 01/12] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-kvm_rprocv4_next-20251007-v4-1-de841623af3c@oss.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759855750; l=1163;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=yQcmBzzoF9DWalLjee8gEifniSD8YVltfiDi807djjI=;
 b=eNgm6wLt3+Ue42wnQTOpuEaYPRaxtNeiY9CgLvnlGlttjle8kCO0E3SwUGk/4jsz5Fiv9CZK7
 VwQO+7gcziBDRo+DfyiJUIH54HwiUkn2h+mLfm2LqOxBPEflbGLup0V
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX70ZpUQCv3Z1r
 E//gmElXVA/wmWCBF/3kd23jlqOKN0T3f6tQyPzb9Yn1Gw4Q3bT2Tuw0LMyP033qZvL47GP8xNT
 9QSUvjhl8XxTRdyXgvxSvoGtBMpDRy+MeKlHTlstlWJ8NXYEk6Q7CLoM79W/d8nbXX0PXZBF9l0
 lcy0DUVZLOv84riTHuYRJe37jspCOwbCK/9FrY+ii45INGSkzUIc9z/jwlrpj7caQqdMBnpWdlL
 u9g1wDK6aP93h3XPSksn1RWEwsCU/cm75Ar+ZhszXY8NPa3TOMWKUh9DQWqrux++cBsy3g7XsNp
 Vy+DNTB6bB2u9xZsPCEqdZ2MWOvNbzaji3bex/U2n9jul1EpKe/WcUHK8nw+fyYIjHouyPtc6vu
 eJwSLSbpwr2IkOdu28CbGHPzMbzvew==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e54490 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=yGyP_gyn_XtU8QVV77EA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jLAsRsqzEwtmQAsO6bZiuqH3JjrmAoLd
X-Proofpoint-ORIG-GUID: jLAsRsqzEwtmQAsO6bZiuqH3JjrmAoLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
configuration for remote processor and when it is not present, the
operating system must perform these configurations instead and for that
firmware stream should be presented to the operating system. Hence, add
iommus property as optional property for PAS supported devices.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 63a82e7a8bf8..8bd7d718be57 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -44,6 +44,9 @@ properties:
       - const: stop-ack
       - const: shutdown-ack
 
+  iommus:
+    minItems: 1
+
   power-domains:
     minItems: 1
     maxItems: 3

-- 
2.50.1


