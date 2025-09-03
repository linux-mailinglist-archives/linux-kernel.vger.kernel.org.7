Return-Path: <linux-kernel+bounces-798400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA4B41D56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3F0545D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5227C17F;
	Wed,  3 Sep 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9zdOmbq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FE2FC008
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900064; cv=none; b=m4weQLY5uTlygGm4Y6Ipsg6YCTTZtLarA0Am/Q8Siqm9IhhK6eSfmwAPAOTtTCVXmnG8PPH2EKlkJ01zxAX4L7nqWWaF8kgbCewHOLcmCHG8rLzGk3mrO4RpefU0lLVdqiK+8WgXVjAMyaYIMLHc7ITyf7NSHWMloyPQWMfVq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900064; c=relaxed/simple;
	bh=3BT/6suhK8eSmSdIpvmvry+itcjPvXCIyXUxFeuJLYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s41oZtws6S5LWn4gwBFVs1sMacp0r0+VtdYmKwKZixgrkJqSRjzI/LfP/1p06vHzIy1c0G7rDBd2RFEz9SIl79QAZ1U6DhFzBecoi+aQCC3bzpezki6CYosvjC8+ypUhOA/eU2KIv702p1ygMZH6Nm9X1m1W7Y57wADr6TRfO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9zdOmbq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEteZ022395
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=; b=O9zdOmbqASzfiGpz
	AMyOn26a4eiZqaB4AR0v39lgZWo7d771P+SoXeTmyyB6a0FaiKTbEJKHOpBvRzVS
	eAA0Cb5/yF9lezfE9rSazH09Kqt4TbH94NEEB4SjcUCNvETgv6NNVK1qCNjw3GOo
	H7cwXLeh2aMFxTSD80MVgXBa2ANEwPREKy2LOx/HKwuqifNCnLR6FcvvDH//dwMN
	kzfHoJU3FfBLIq58Pxa7zyRRcC9qtVkrni43UOvSUYtO36NlcNAOnQAWcEY3c1aJ
	wPBl1BLeYPVfcy8q0vHSM+oV0LWwu1Kp0M+n++UN6YgjS+/DPAROlaVAorXl7avf
	fdy7Pw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fkcsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:47:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329e0a8337bso2521634a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900061; x=1757504861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=;
        b=JB9uC4oCxFfxZrtdYim45X6tIRvIUv4tofByI+haL0874ftQExTy1/AKyPQz/AP1AW
         pHS7d0xV/z4dK5R4C3pbsPKc8f3j3lroC+DQzNif5rO9WV3wN7N6t8FM8/eHZG8rDJjE
         qEfRCOeydcqU6UPIt7LQObZj2owhs2Uu3dSjZCWDbwLm7EOeDo7yt4KzQo8CsThD3XFB
         /SMk7m0WzGklpAM7Yhm83wHneDpay8zXyxWXwg+Tqziib1Lu0jFy/yTgNyyxyFagOKVO
         +OTeWLWXQo0jJ+tmCck/Fu/Hc91eJ8bb7iutgfEzTcKlAbwy8m0arblA/pk4GyLSmlJ6
         KGwg==
X-Forwarded-Encrypted: i=1; AJvYcCURxX/yPqS8ypu5PDmKJ4OPphf7KX3LPt1vjhsKZ4RMYj3i5ajF527fQTX5tQC3HAatToRD2P3NB9fnYtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJlDeg+gEvzSoZWxyD8HUyRyCyHvqw4poZpNPCNOBWjnuDiti
	8JmJtbBHK0tK5vCCe0M0psSXmFCi6kY4iDPdvg7+V0WU9AeggcKEM8QJKkWq33VTkb1QVVyRjc4
	7uYLQps+RqubpaEH4CGw4quTU9E1PnRflfjLVCZvvEo4fXLQrHZDr/jpSER67H+pkR1g=
X-Gm-Gg: ASbGncv0dRWtgPwdSolKBMBR5Iu04X11ikiTCCiyYAUFAoF1A9pRk3dftUfHhJF9+lC
	YDSsNTBtREnASA9RxjVNsYW+CG3lmijSypEq8qAX9f4iPwp26HP9DWAVZ/j20c9IxkyAZEXpmqU
	xywSgIDD+GLRbRDRE9ARmBa0x+OPlLg78y+Kx/I4CPiwVBMzNnKPbXqPqIN6sy+q4waFkEHpHdR
	DWehm+sjt3mJPTBKv+tHbUeBhijdZgkGu+vbaS+rOGYqNqyIGosu/O8g4JeWyMu2bfN4YeDPylO
	UMl35mrdtsQeroil0efOp2dV50iHG1aFf0QzG3wryVvK8SZ8m/a9dKx5fXg7PvCMAViw
X-Received: by 2002:a17:90b:4b90:b0:328:116f:b124 with SMTP id 98e67ed59e1d1-3281543c7admr24063245a91.12.1756900061303;
        Wed, 03 Sep 2025 04:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdDqU9X5UK6KLinIHjoUKetYyHVbEQ+0Pi+FWGf3ED1An7VwpEgDQgjMycPPtkWy/WHMWITg==
X-Received: by 2002:a17:90b:4b90:b0:328:116f:b124 with SMTP id 98e67ed59e1d1-3281543c7admr24063190a91.12.1756900060712;
        Wed, 03 Sep 2025 04:47:40 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:40 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:02 +0530
Subject: [PATCH v2 01/13] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-1-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1190;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z9TI86piqLkEr60N8aHlg5lL/hJiHyO8LgOhxGhTRpk=;
 b=cgmlJmFj8VxDb2ZHrkoLw7AqSt6Sk9vlViwjnBFCzeVcyb73Eld5O+v7fXbHV9TdGIeZgXIvM
 VXVAYDKCAmTCu0I4OBWWaLi1aGiGRX2MOCzTiEr/iFw5PNXjeMdiPx2
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX0UqfAHjUUptD
 2gzG2HWKvlbkBEIdxqpqHPXsgrRXy2WOYNpFoJGA41H4xTp5fw1B3XkVJM4yNL2va7LBtQsGdty
 Tv1lBGpU64sKqYzQcar7A56o8HfWkqRrGmPiPRjve1HHngEYJS+hISz39InoBbxdZ88hwWVfL7F
 6HCkchXsxxUqGJZHykHO7EYAaAZf9qO8xmDAq08kdZbQALIVhuZvVbRF74D5NyFEU0BkM/t9Hyr
 f1pd6MMeWNMBZzdgPZ55YG65WIiMi1aV3HRHIXl/SvH2u+Dv8dqpiotIlLHQ+C1QX+QCWEpwzC3
 6bho49suk3X3iiv8tJvKBU3swautazi1KKXMO+yd5FIQ3PS28jRd5vprSYQ6+7YKnGC7DDHhLKa
 lSlolXi+
X-Proofpoint-ORIG-GUID: m4RV9jDfIPwWA3TuRY-u_t5xmP1QCW0V
X-Proofpoint-GUID: m4RV9jDfIPwWA3TuRY-u_t5xmP1QCW0V
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b82ade cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0


