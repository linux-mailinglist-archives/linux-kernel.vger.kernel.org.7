Return-Path: <linux-kernel+bounces-801282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F28B44320
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44F03A6C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FA309DDF;
	Thu,  4 Sep 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKd0cMjd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DE2F3C0C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003970; cv=none; b=pEZIBYf0QYHuRVb8dEalPuQdqdzfckLVa2mLiz1GeMKbs5lh1JeF1Yo8o3huMYnld+zAfe5R4hNBv7HNcm9vOHv6O4rziI7igyUct8fTW6NGAT5q/xC9kE0Y/vCa/VhGKxDv9dQZ9Un69SyKyauTcTz5mjv3Z8iOgV/7z3LNJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003970; c=relaxed/simple;
	bh=3BT/6suhK8eSmSdIpvmvry+itcjPvXCIyXUxFeuJLYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psAT/HrREtgJdqqaHz2WmGoN46ECGylLf0KXmtEbJUHFoVLbuJ74DSQlqqwgVBypl1zTa+QvGFWNkm+Erp8OU08BcD2bqRnYzatTbA+zpy0qiMz7/trL5KW2T1MaR3U5i4iTv+C8wso6nSqvPBCuJU9tK13hkXPKE+F83AUQJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UKd0cMjd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9fu008136
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=; b=UKd0cMjd164/BbZ8
	HNbEVGUdupqCPi+kgq9f5KQ3243KNWrjqAGcZMgH7U7xlTxalBoMek7zG2Wps/8j
	FYZK2LW5PTU6saOXPwYg0Nqfh37cHYr7ya0tFReFTx563LWIN5vu1CWBTKFgho75
	YKEcLWaRPYRNrarwX4Lj5UXKHeRDKUkznQ4C7I8wrOybvQidVUGSkU36Aj3LhQZC
	i0MMlqKmsv8cHxBRMPzoRlDAsOJskmUYH7llehYV6cWW/K9A4yweZmxPIvGsHEWI
	UVVKzDavkZ2uXuh+GQqauG/Mp66oTDal/yXABXWDIC7YsE9yjuX4/Tdjb8YFinNk
	gp4fxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjr5m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:39:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32b51a481feso1186901a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003966; x=1757608766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=;
        b=DTTYhuAmb5iug1tHoEXecz0rzmf10ZyYNV/eAFm8GNHuQmbbHaE/miy7/EbR+I11+U
         VezGJvG1+Bqici9cc/rIL56L09ttjw8M5DLm11CluOtPEkUHY6MWXFa7szzW/rbkerqJ
         UaRkNdJq6eExtkGIRLtTUdm7gIc3kP4f8UzOVLnjCfw66mix1L/0Rz66f3ti/LKwb/W1
         U4tc36h16CpbSRnXEPKJlt8Hc//4BnPAS0XSy9BviHEsTb2u6lK+g+rEIvd7WDQEqPzQ
         ER1chcJZq4xZii3L/0mnIdN6JfBPacnu55MsZSy99H2c2x0NjyEx4IoTAgmEsPvscHl6
         iqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh6P3GynyE2o888pDdeMkBvLqMbPDovP1MvUqq3s1uWqcOyhsBc6I1fUWtW9JzA3k5BROQ1m33l9nkNb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsDocyaAwSBfH9+CW8uscFAcXAhM5UdXRo0qhX2hmFtF/yZxo
	LPBgSkgnWzK6zdVGZDeTFTc34nFJFjG6d96QXoqFfta0LO1DuBQNYQIDf8yCng1HpSu1hvZtgGN
	KRuyrnmQhMt5TpYlA+2j1ybadscnQytopEoCixmoa71jFK4nOwqytj8H1GiwH2VnXVL8=
X-Gm-Gg: ASbGncvG/IcsKO/kULXVUaLG4iCUZpsaOjYgseY4M7NfndL2u7FJ7GOpQwqYYg8N6Oo
	JTZ+119A2CMU56XDmKEvfoqjh6yLO8BIzc24YNeJqWkgrFe/Bx+k+9We+yiEN5XgXqCq2d9qneb
	SX9B/+RLAqU18aVNeUFNvi/Vw0kOi5O10B4JujNKzvlp8pdcR5X327eKI4PS8x16C5uvmv6XuOb
	edAifZfC5ZNXcG11SVdEI2PUlWpBHSUYyXEPAsXSu8MNbY/NdpbxoQK7xkJVhXUMC/zSyLw+xcS
	JFywViFfco7/yPgVio1JVWB7D33eyqeIfmrAv37GQ+vtk1r8wDiPB3+1w3SuEB0vm8/X
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293539a91.2.1757003966002;
        Thu, 04 Sep 2025 09:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDysS+g0JZmVZmToh9tFIcpTJv8ha6RIvIwKxET4j1oDI7WQvl3Edcqg5NJKS5BBiqkUPp4w==
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293495a91.2.1757003965494;
        Thu, 04 Sep 2025 09:39:25 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:08:57 +0530
Subject: [PATCH v3 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-1-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1190;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z9TI86piqLkEr60N8aHlg5lL/hJiHyO8LgOhxGhTRpk=;
 b=0/sdwS0aEk7K/4iQNj2K6mKUxiyzvbZtRvG2f1VMV2jqu9zimljBsho2c4cnPjvLldMuPOcCn
 oEvvjp4y5DfDAvsR59uCDcgwrwr22Cuau1UH1lvAcXiJstwFS893Dct
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9c0bf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZcC2ySWX9GropE528RtT9b8uFpcDVAHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXzPw/D2YZDCG+
 Ic9STKSjpUum41novgQpBu9rld4H8y1s8GDg4GLgrpRidolxPHOkJaxY1Gasx+t395OHvbpeVfn
 4Q3IkqNiXqQQqB1EowBjrs+WOvguglhRVFVNdRapaG6z+u8FjBDOQpZ4sPmH/0ln0O7kSng0nzj
 1CsD2LJ187A78MnuBEL+jcTYFKNdiQ15pZDpPkjjrzJaqJuW7oKFYqZx7Xlm5M95UACPdtqTc7j
 DXzG2+9LR3dOtEc4Y2mpKDEXikiAQd7NsltyDCZP7Z3k4pYO1htiX8oOna4lFJI07O0UBT9Yqn5
 WsOwCOv1hfqh/7eGEBKXftkh1M0lncW3S9kepORoFzx+8COq3tFbxOmNmo6ulaZERnw2gPxOh4H
 xZyldY8C
X-Proofpoint-ORIG-GUID: ZcC2ySWX9GropE528RtT9b8uFpcDVAHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

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


