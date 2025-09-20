Return-Path: <linux-kernel+bounces-825854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC804B8CF49
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D721D179D24
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871D246787;
	Sat, 20 Sep 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxOt2bpX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA8244679
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397312; cv=none; b=dpL44wNVN58HCTQK5BL39K3tW5J+ctBZCf0/3m3NhrMruy9vARaXdgLUa6KLCZlhmVfvDZsTY8cJKt9bHCS+HNapn+qIee7eEy/pZZziRnQpAuc/txUdvrGspVBhCK7pHLATVGIK5KxyCF67X1Uh4ozEJBWBaeeKjBwjwYquev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397312; c=relaxed/simple;
	bh=tSq2SNwEFNwiGMDSa+4QkuaPG2Nrg0N+mFdMy21QWv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IouQqowuWNpxIhurBJjXZFySZAZe6Q3wy8N8YVeMKgy0dlUAX0ab0eyqbcE67B8NX1quFcUVBPGLCIPhJG7Z1gV6JhRPmcS5U2cM21qDtm5L14RL23p6kbnaviL0Msn39nMn8wx1QC2/Mrszua6F+zSuw86Zu8lOyzYlejHK3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxOt2bpX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KBU11S032413
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bj4fuwVE2Q5uRTzWgOejIvsFJ5SHNp/2bx2S5Pz7mM8=; b=QxOt2bpXQ6RHWWSJ
	3xSBE79DN23f8bGWpBeGyy/Pc53AeznxTxA6oJqKchJvMkvTnfuU3PB57MypVB8+
	OZQ8KsSYRRk9pFoRXWGY5KadxNIPR7OeYWCE9hp7COSY4cS1hchLzDALSdz8xf/c
	a1yYrBhTO0HMCtyevbuCIcWU8C0qqtmpviP4j+ELv43uogVIosUBkOK0WQShLf3m
	Il3E9uFBiKo/M/xELi8o2XmVw1KsdvSFLRG0CnWvY7ezEb5IF2okUkm6OPygG8ZK
	8Al4oTySSAn6leKCRocuMTCR0J02dN4e+qD0tQGU9/38o/mP+Vvbqiu21bkYC6LX
	TqAZxQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0s87s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:41:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f29f473a2so115596b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397308; x=1759002108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj4fuwVE2Q5uRTzWgOejIvsFJ5SHNp/2bx2S5Pz7mM8=;
        b=ZB2z/S6m5d7SmzLyxE5Drl0UxNs49KdUQHntiwBURrzZ6RB+/rL0uYvpI2o6DERwVW
         /ZVw9S6azlMfqx3AL+rqV3i1/pW/sUw66NDbIfAb6r564aTSRnCVp0tT0tq0q/z+rV/p
         PP71f7YjreKCJSywVDefwr0H0rUZ8aEz1E74uRPBThUNUt1GEgxRTt1ETq6yRQZfiOlC
         zsR/9V0lMe9uRW4uZ2DVUINY9fbTSzwt+205OWABhvMzImWCq0U9DZsE1y1iQ5v3iquZ
         Q7TnjM5Cz7CbLr0zpEtQqxkh1dFvDHHEln7AlJ+nQNHE/7vzCec7zD8GXSkR3TIAaFQG
         vOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBo1ho8KuyFX5bgg436OqnQG2kf6S5UKkLqssdOroxS1JjHX/U4EGwPaPzngCoMBa5G4syriRMHdJUmFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUSzZpaWff6XTk2djQrr51whHIES/Qtk06QgQVorJkywwEC6r
	jFvbuKpcVQ5hPBduuAxVeozR+rJPptTPwtaEmtNJdCtzy82bwgIoJe5oZVwk7LbfjsqatA+7KbZ
	rFH6ynFVHX4VR2VjgeAkOok+SMmQbweaT7FiTPZP8F7qG2bz/YVNDhR91PlKJhSY2veo=
X-Gm-Gg: ASbGncsGGIclmEb9uLGQIaYUv4cIPiK/ZLhdxVtIh5RjheU5caiZSOZ20I4ew8XOxWY
	HEwOcxM7p2/Ab8Bj51wBB/oGDa4O6qzmApmq5i5b3LqhHlnWPoyGayCtJdUltk9zNGolAhKOMJi
	I1cjgDKbHGfNaV/EVD+lYM4+FkV2NPYetJ4dUxXqR67ziwFNqLZeFtR1KUPXghKiYbUYkmbZzLj
	FE37808c5n9UMGz4t+bBTHFrdVOuO3EWwAsfULgbW5iGUzqtxMx+fvWME0ERQKVb4xmVFP/onSY
	aOVSqFEJ7Sm7VJLc++2YOAbOIVgXYTmN0NYcC7tH1tXHACJybCY/dTZdMRnmPh73kz8=
X-Received: by 2002:a05:6a00:1889:b0:772:8694:1d71 with SMTP id d2e1a72fcca58-77e4a2f389cmr9026002b3a.0.1758397308205;
        Sat, 20 Sep 2025 12:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyHMvCfqQ7DljSEbSnDD9A3ZUWErb4ZcDZOGMOi6jmxDxthhfgBS5u6gNrbW8W2GNgCM7IUA==
X-Received: by 2002:a05:6a00:1889:b0:772:8694:1d71 with SMTP id d2e1a72fcca58-77e4a2f389cmr9025978b3a.0.1758397307749;
        Sat, 20 Sep 2025 12:41:47 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm143767b3a.34.2025.09.20.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:41:47 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 01:10:59 +0530
Subject: [PATCH v3 01/12] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-kvm_rproc_pas-v3-1-458f09647920@oss.qualcomm.com>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
In-Reply-To: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397299; l=1056;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=tSq2SNwEFNwiGMDSa+4QkuaPG2Nrg0N+mFdMy21QWv4=;
 b=+1DbyQpiADAbwBPK3OEENAcWwRw71lHn1Wwyfh45P2QlbbrgzL+dSsY94TCicZQ/YUxE6sc+5
 WVu4Cy0nKYvDaRwaiGDf9NWBZQWEB7kCVM3k2/LBJG0K13N2ua57KYC
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: Djz5Y0yQnpwpSnXHukKjqXHjUwo7l1i8
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68cf037d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yGyP_gyn_XtU8QVV77EA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX2GPSABe2+4C3
 Kb5neCCMLIFkvlakxL6NWQt/GTw7dAcB4PRcFSwCkHvdMUYm9MFm+vhnqHDqiyIkXyFX4Nq5x2+
 uqfsqKSIk0hmY0Os35q656pTta+/jgVC5CA3CjfnmFNCTJ+atYk3CvmnQXpzynjraRJDL8RYNHD
 zgeCSjbrDbfxI0X62wuhkaHQY8czNYUfCfjxh+rbElsueTi8Vq80CKkPBvhMWTajySAK51z7djW
 C8D8pow6+YDktA/fMRhCNIowoDRCct1Eh5BxqLt8CxD++hIqyyqH3Qy8xVIAi2K8JlpYKa4dgzE
 UgonwLRGwOdh/l2WAZ01ZYTYmc/2X05x8/Rk6BZwgCW91E1SHAAcPrcXybX7hpb7ExpnSFsB4NA
 mSX3k93q
X-Proofpoint-ORIG-GUID: Djz5Y0yQnpwpSnXHukKjqXHjUwo7l1i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
configuration for remote processor and when it is not present, the
operating system must perform these configurations instead and for that
firmware stream should be presented to the operating system. Hence, add
iommus property as optional property for PAS supported devices.

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


