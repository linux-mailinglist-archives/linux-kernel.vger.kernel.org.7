Return-Path: <linux-kernel+bounces-831421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEDB9C9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89FC421427
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4E2C11FE;
	Wed, 24 Sep 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZF5Jd/xX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D02C0289
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756919; cv=none; b=YvHrG4Uag79DnPv6dUq8W8P6pyyIzjIrHoNIoI0yQsuyeZbaUIRG90ZKyvE2QczMh88H9iyMzbJzBLNWcw0RpDuWRQ5ft8sUzciyXnyz6lXV/8QzOpd1wwEmk7kZ6+uNThV9Y3FUkqPFDdp1x8tdK7jyJ7AfDaAPw6wJKCpsyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756919; c=relaxed/simple;
	bh=1bXx4X8K3luI0CC7vMBOPOroIotF0KmdCwUlUnOIjlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTPxNkEuZ+sypZu/QGMtOhTH23KKbP/PZ3ScJP/VAg5neRJdj7jCOAZcZlUwX0z43W3EzYP0iTv60cRm1scYe4tDLjDxsr4nppoowjvha8YrnA+4SQjcN+E+ViVUskzwGkWnx1Sr1Qy+4Vclxd2UYpNzgx+qehWP23yqecEeB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZF5Jd/xX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD4cQS027915
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qsRs8ls5zJtoYnaDklfCGZl0u7nCPvApwl5lvQLG0Yw=; b=ZF5Jd/xX/VX0t8CS
	2PWhZuR/oVUw3EI2nBhXUvDrxzJaDI61R6w5++96N0pk8hpuy/lT+HHB2WAa1cKx
	ScXsbitD5SsGqcHNfKnd7/Hpr/ydo3GUcOLWoZQTHhQTefJcjxzxffDs0fEgHxBO
	4rmDbOJd6jEnsLRf3r9ZXn674S2sUQqeNYB2efXT818iEj29/sFG+fil20dD7skL
	8C9HTnFsoLWhybuM3PVSlIdkTvqdgYKyyoY5PEmySTS37oyBL8O7Gp74MVHqVnMc
	V9WlBQ+QRfro1du33zmH0yi4dDfUuwu5DjNNYOEAqEXB1DfqZ4vyAs8lDuW/H0Sd
	n68w7w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxd48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso192500a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756912; x=1759361712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsRs8ls5zJtoYnaDklfCGZl0u7nCPvApwl5lvQLG0Yw=;
        b=cZ020a8ru15yBO0SgVvMAnCIO45y7ppDCtcROigwq25UgYvfRmb81qrQPZz1uyfFjI
         j5S52IoFImE3oBKC5vPA8g4ieXULtcphOifQK8bnHKfpsEThJAAPv8h8kyBmEkaprS/I
         7DTX+4gc2JYmQkkBJ6VHbCHnMdaAgclxpd5LQY3yihc8aUkoZl94Ow91yJGncoMSHmvk
         Oa1SupfLjSOx7iTvYlw2v16I66YSoi/cWPLrJI6W+y6I3EztRXu68/yuXwpcAszOEODs
         c2NMKLAN+TvJcoi9mDdGI0qsYrFymeJyAzeVDs8V090EsLKXtTe7Wttck8pxa6Z61p5y
         lUpg==
X-Forwarded-Encrypted: i=1; AJvYcCVg+TMs0dnXsAofchxSk4ibBrGIOmjsMXqsEQwJf3OmR1fqb9km3xH211AipGmE7tZcqeaLYqRZNC3kqo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRm8+yz9mVgPUhD1a8xh27b+bmi7mS9lp9kFsFIyrfndbWwAcJ
	tV0NTt+kPffkGA128i/dY+A070STMlrtoOG+B44gYHzfEGcM49viSwNdQJEv8DTESx5lgE00jsY
	tMmQARdCybaKvWiQAxic54ZaHXBObXq7xo0ieFl50eH5hmnqujYwVRvnw1KhQYs+GF8YgeG/myH
	AH4Q==
X-Gm-Gg: ASbGncvhd8vSpvD5/6cJnw5o8pyZB+1hoCzekMClThNq28ZkDtHTT7I+h/QS9TGfSN5
	bXKEDZztq5fGt80Jet6vyEBSdcziF6zohbdSnLnrtLNBXY506CLVO33RWpVoH+ebKmqA2b2pij6
	NPIqFwE61M2S005wzCuUUpem1nMf4BG8uFGZBFre7r0QABEjGAhJZw/o567ru/YjauK+Nic7iTj
	zAeCicQyy4MNwKl5JfZDKh195XTC1P6QTU4whc6ND55eh23iNPVIoUhMlOhWjbudHueRUzBMHDQ
	xbR1FkWAjB8xogqD8yOLv67zv9Vv6btESZn0Tzv8MHoTgJ60ut/XZUhAiggAzwU1etJzBuff8QP
	DxoPNXV5h13a5Cbo=
X-Received: by 2002:a05:6a20:549d:b0:2df:37cb:6b6e with SMTP id adf61e73a8af0-2e7c131dc55mr1576807637.21.1758756912069;
        Wed, 24 Sep 2025 16:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGpAEuz61cvT2XhW4ukIQOiLZa0lY4y1zPa4PxH5HTxcEkQBKtmoEjAu6kkyiQl93f/pSVRg==
X-Received: by 2002:a05:6a20:549d:b0:2df:37cb:6b6e with SMTP id adf61e73a8af0-2e7c131dc55mr1576776637.21.1758756911641;
        Wed, 24 Sep 2025 16:35:11 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e9a9sm212379b3a.15.2025.09.24.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:35:11 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:34:56 -0700
Subject: [PATCH 3/4] dt-bindings: usb: qcom,snps-dwc3: Add Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-usb-v1-3-48bf9fbcc546@oss.qualcomm.com>
References: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
In-Reply-To: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756905; l=1499;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=dp2q1UnWq2Lp4eoHzNa7ZpgQgVJ3NSAs/37jv9/dDmU=;
 b=ZSbenoW+opMmdOZe+iejbQ9oTpdwsntbX+yvALQI42r6ic0SoOqHbqvzWDNjnLh57Jf+Ltcp0
 S9QFXqsfwFzDnFaokXqdCkDODuQH0rbhL0P7RXaNQxN/BdSnF4F9IlA
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d48034 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=c8SvkZ6Bq0hLoSk93noA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: F_yvw1_koGF-dtC6v-KK0Fr-EEq-maHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX6gYegRh4omud
 OnMRIZ72iMeCIEllioelQNYCJvG/b5Zy8CI9CxYPWR2mCmDAE5qdWrVF2vEbDp6vGK9y4v1YECa
 jA7ojrvo9llIg0dIwYzm3Q1DZmCM7aTvkU5aQfAiWa/jRFSjs8d6dquLC+O/7oSjucttf/G0QQu
 rN7ZJL0Z4he4q0bIdBIw/d8QYpdlUfdTJfLxSo0S2tWxC7XlOLr1XVh2sTpoP6kpc5dsXIAzYtQ
 zaFgeoUEg9j+WrkuGP3q/5O517AJor3XNAJg2G3+A7MYnP/42chWLsTvU/HkVSzIEZMTeVI9lYV
 CnaG2ZJIIfTf++o7J0jOMKBQbtkJ2GuKzbZjPELEK1/u/LQxPVJs9yP8TDUhEF+NYT0po0ulwGk
 Mg4fUH2k
X-Proofpoint-GUID: F_yvw1_koGF-dtC6v-KK0Fr-EEq-maHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Kaanapali uses a single-node USB controller architecture with the Synopsys
DWC3 controller. Add this to the compatibles list to utilize the DWC3 QCOM
and DWC3 core framework.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..88124149142d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
           - qcom,ipq9574-dwc3
+          - qcom,kaanapali-dwc3
           - qcom,milos-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
@@ -199,6 +200,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq9574-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
@@ -476,6 +478,7 @@ allOf:
             enum:
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs615-dwc3
               - qcom,qcs8300-dwc3

-- 
2.25.1


