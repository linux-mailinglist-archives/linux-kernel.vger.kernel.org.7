Return-Path: <linux-kernel+bounces-748763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F6B145C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E111AA1D77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A21F4622;
	Tue, 29 Jul 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eo9KS3/z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F941F1317
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752757; cv=none; b=tZD1BJGFfxWbHHcZeQwBCx/hRfiZjaDA1NvjquwGo7Wt2vfjBVtGZluffEcYB+ZifvsdPKMys3bL80Y84GsWSuWpJ5wb0xPR++1TSfphyctlMVq6uhZQsIoJxCyG5PX6tpcTsDElQKbSpeC9oNK4G6hJL9ql7OVLhgyTQwLjiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752757; c=relaxed/simple;
	bh=V/BYua6XV5/Slbr7KyRoyAjVXwrPIJnzOCaS+fPHr/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6ivMYqzruOqJDxsUoC/qBxQ3PMS3rhf5+OnFUkI8RmqqGROGszjIHRbfWTPqt2A6PVAOlflyByPdSmm5qp/s9LMj2cF/QI2U/AGFJc/tSoQLd2qzdl8gwD2hnQG7XvEkrl7prpqf+FSsubU+LbUEe6WD/EKWKyGs1UlWucO3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eo9KS3/z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T02JS8030056
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aiEHcRFSNvC19gKAUGSHHtMUwHZqb4Vo2WDBxZKJZbs=; b=eo9KS3/zDF6fnfMz
	MVCyWDUv60kzcvYBaiQ30Ac4MhSQn730f+PStpnei90FnaPFvWXoAosx/jyeffy+
	GTdSKa2ITeB0tP/Yy11+K+sBB+WN7qL5OGZlFQo2IbX91SLZ2CQX2A9x1rOxHNT8
	13mQfArWvb4mAlyLQapVvudVMTOSFGGnr6jcgMF0QqklBIrih+Xw8IyZY9Qt9u9u
	ASifOrpHI4tvUGtRmQLo9pb9j69RwTSAdHJG6jHTUDiU5nlB2QUyP+bK290LqJG7
	QV1dKmPD1DHBtzgA3UWw464p/eg7ytuhVsyLdEn9d2USptyE+tcVCPkgXxKNYsD9
	SqssrQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkxa5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fe98c50daso17462405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753752753; x=1754357553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiEHcRFSNvC19gKAUGSHHtMUwHZqb4Vo2WDBxZKJZbs=;
        b=lgI4FtA5fljkzBi96JT3g0eHIszhCKsltHpkK1v3XK53+5MkRyFlnIYxpemhuP9etR
         bbvRjSEYJghnmyhwHfymlUNTz4bUzKlKkIxBOQGYLNmsnAn+U/LDOzm0pIWQgCQ8401j
         7nS8/hy8v1vzN8Arxkf2B3EFdAddMRG+qosHEP8QSEYIb+ihfpZRzbFcwpulTDmwzZZT
         Piccs7VKLZuTUXagRO4FRGYCOCbr6pXS4FFoiQUnH8ICEII+5JPjURKlLH2Yl5IUqgJD
         RgJwEzfHy/yR0HUFgrSDNzR7xttC3ZpwRSULxhNksc/h8Wv/HQa5RH2ri2GwLLRukqHA
         VuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr/J+kCQHSTTGwNuz0SpY6+cNsMzzMjXZ7/6DQFYHAN0CpmF/jamjUzocBTjCTeZBj6ppJ3COEbZnW+y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxpkZKbO8RHl7Nmei/cnlGwgqAZ0Kdq+RCYs8783JPob4CGMd
	y9Cdy6ZZ5mZfedJhzh+S+uvejXXjB3JlQKe51jF0nBtHAp6rNR6s4T1sle5+94LBNNku7qKio0p
	AtaJbyB0mYlJ40ZrnMcDZYp9cAEU/noyQ3XDrtLyHCswxLQ2ofvvVrAk6Ehq3kI48OfA=
X-Gm-Gg: ASbGncunvrVZzKesD9WoMcZ1IvNu6F8n4nrVm0HHV7uRQ4Hylotwc0lvvfyVkRAggzQ
	aM7pXaZR5zfGh6mnel4+YKYbXV3w04+ZNsqtw8HlTImu8ZTCt/RmHpUl2uFO0UyRkFSDflp7aqo
	mxatiXMifJK/cF+O1oq5D/+TxQi0CIyJtR+sYH6onQ/++EFMoXHKXHy/Hjz4T7M2hl3UFzlFBon
	Mcx/XbFMjGfzfNMmMejMqDYYSZAdTzHHbDqpdbniCZaS0OqAbKaGv7z9eLQBN72A/0UJvZljwX7
	zfms6ow5hiHaKNL5OwUlYGWydXrA6RMVcqv2B0Px0tULdfzoqX0NaBhMpDKMYoRtui/ljRgAw7e
	PgawK320Qo/cqEpuhhSUM1/nYMsRW8GN1cw==
X-Received: by 2002:a17:903:b07:b0:240:8f4:b35c with SMTP id d9443c01a7336-24008f4ba02mr101013005ad.10.1753752753188;
        Mon, 28 Jul 2025 18:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA0DJQLyo6uFYmcVpFDq4c7tgBIsAVsNRpcx8bgpwkzKnMfZjMLM54SIhP+teyT4i8kz5row==
X-Received: by 2002:a17:903:b07:b0:240:8f4:b35c with SMTP id d9443c01a7336-24008f4ba02mr101012565ad.10.1753752752715;
        Mon, 28 Jul 2025 18:32:32 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2405bca90ebsm11210625ad.6.2025.07.28.18.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 18:32:32 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 09:31:57 +0800
Subject: [PATCH v3 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-hamoa_initial-v3-1-806e092789dc@oss.qualcomm.com>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
In-Reply-To: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753752746; l=1169;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=V/BYua6XV5/Slbr7KyRoyAjVXwrPIJnzOCaS+fPHr/4=;
 b=hbWKGwBk6osvTAY7lNFqYRDcEvcUgSdipvrnJKHUeHpYaSt94QDYhew7WazfpMe0fq8lDipBU
 ZqUfMtrhQrdCAua7qS4rQbuzCRltYqCc/4OnSQQL3uYOzECl+CXTOsJ
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688824b2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Bh1HEMNN3wmc11-eFpoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAwOCBTYWx0ZWRfX/nYzfmOEB5gQ
 xe3Uyd9bA2b6mE2CXhiQr3aiSSOr0BXGWDTHuGBdA4j4xECGHQvcAOt1N2D2n8aHtRCDeTw15wp
 mzl8GZRRUJiKtdNmht05AqoyWB6I8pFKIm5MiXA11CrWAJEnOBvIsWJPsPtocPNqP30DHUcIfUx
 VIvHSt/u9Xf9/aWPcVrDbCvw5YIxipSHRMrVUqdIsO2RYgxeU4dMNHZYABYW+najZZVvADOAP2V
 mvkfUz6bHQM4PYa2dySdIr64fqc8h7DTaJ8XZoHQSOeEFf6tmZyD7A3I+BmIkbOHfi6iHwlzsLK
 8nNjZYwCxE4h9zKBfqjPeT/++KtSl8b/T10oPm1Ge5miJA2UjYD53qCkgfegEpfyeqcH1rhilu/
 6dE3rVcLba3tKeK8BEcp03iWxKdaMyezqjDxidLgURppB4037Yoe+ax5+FxBvuRhOTIbKels
X-Proofpoint-ORIG-GUID: Ab-mtsLXwtbGOHniwD_3_GM_X-M5_R2U
X-Proofpoint-GUID: Ab-mtsLXwtbGOHniwD_3_GM_X-M5_R2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=979 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290008

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 47a7b1cb3cac1150bcde8c2e2e23f2db256ab082..65003e16fe72dd4eec9423030fed6078b4a79959 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1165,6 +1165,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1


