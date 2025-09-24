Return-Path: <linux-kernel+bounces-830936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08229B9AF29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146C1173CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001E314A75;
	Wed, 24 Sep 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3elQ7GN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF7313295
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733279; cv=none; b=rSTUWA94wOBwhPpxfoCehkPvEkcDb4503F9ur/C1B5j7FXbiwVPkbKT1ySo3d4WEG5bNw8lKRzknUA0g/nAAjTEgqbwNuOE80HUDa/hqir6Irlx7talNzwqQHr2hzY/TqrXWTGnlgYr2vId1nWVELrzAhYGs32bQlGaFfJvIVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733279; c=relaxed/simple;
	bh=kXDI7MEXFf6z8gjpvhdqltoRlqilkIpnmYKOs1pJ2QY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bvVpfZCtF3SXI6B44yGaUa5sdWOZFo+wamnTgFl1gCfq7/e83iBDs1kcT9T7UTDM8QzxOHofrMhF/3G4dmP/Us1xxcoWaVyOShgUZbi8npFt8Rq4SbOoJ0dCWPN6QPMEL7dG4RC5GATQBe8wCS3WYCvB+Z53y/bazzHm01DKlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3elQ7GN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODFQ4L024258
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N/oDRnmqGat4xmVd4FvGyX
	KUBtNVsnITDdUnNVC6S+A=; b=U3elQ7GND8JRW2U2fpbEX3a4DyuBDwJhxqS9FQ
	x2RmRCwc6ps8b58XiGpPesoGFjhmrLy3kKWL+e8UIaPNlNd1a+OIIPEdNRlwJgts
	iDwzJpBBJamBUX+3z7mIp1i4Yz3nBrAursF726M+8JPwd4Zc86IYliOW4MZRraMy
	chodoQxxJdWnSWnZ9q1J7GwoaxE7Vbrl5pV3uj1QRPleRxBHlMt172lxQ0yoTF89
	9/IaWiD4kaErpgsaFLwUYd5yKH0EJCE5lty1TORdLcAJAHJw4i2mjJeRWDzY378D
	EawItb6wyHVE+7koqphel1I4nJ80tdamhyxrT2Drzuwi9vcg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0c4wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so45172a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733275; x=1759338075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/oDRnmqGat4xmVd4FvGyXKUBtNVsnITDdUnNVC6S+A=;
        b=VKbzFP0rZyzxOda0px/07a2tYCXE4QsYIdcOV3Tl8o19vt3emG+sdD0mclMYh04q4v
         uBS066s2KW5N1pkopo5g8PcSPNwbvi/B9lyAv01kwhoMFo+0iMbndX7m8O7QaXde3Xh3
         9jWSrb/hq9mC6OSBtaumUwbXWglSy/ySKJk9EDmWC/T2jQ/D/N85VVc7tOh2DcurKiur
         eq93KtFRBz6CihVwe5qq2iLS+JzWOD+h+bAIu/Ioz/6EJoPVfqeg4vccvzKkDUusL4Fa
         bYa2chmm7b/FB+umEU65JR3m2JmkAFUGVSRjIgSEJXq7qwMb5h+s2Wmr6qilOzyaAe2n
         CGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJ91SgEEH2fN+2Ka5wL4MSiq595MKqWL2jabin87sY0kOPwqOB+iQNcHpSfCtkRC4zUR/qx5/exmmXvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz553xgARCYL//4CpFCWk/sCe+Jjn1rTBDVpBQRGE7YuZGhenrg
	ifCCYRkXn11NlzOjD+C3E+h4HOgEgB7sHehU5ZDI+YtzYBnFu1aaOQMfd8yyJKKNbvBAzRJKrX9
	0eLb1lH0ibwkCEh7uUvUWJe8REDwc1fHU4jEHMPTmOapXhn/Bi7jFQJtJXy3qXMsCvN4=
X-Gm-Gg: ASbGncvMoHzWqaeQ4TLm4eKTep53uRcWgmusCaiy4IeDwQTH/An1YI5FKCoEkn/OIrk
	U5g8TtaSAgUxfP2Psjv89gakjvzK979Hct66/UfyJJ2MA3AM2aN4reYr7RorxRq5djWfuWdxf5T
	uqSlr6bl4DBnXvYlqqC1B/YN2zEKRxUKRPqIDKddZB8Dq/zOOT/Fa3BCV5x+ycZe6D1hXdcF4fg
	Tf0MCnKE9G7lAPV9lmTdKr5T+TQk2oIAIDFTC01XodbP6RHrgoIc2S3jicug1tiOfflzrHejIU0
	ZRJgb+s54ivz6QGUllVpzecYyx4MTnhge92Mj/cwprLhCzmX5p4fHCCFJFNtUvECfDN9YBhNNmO
	XBBGUWAyJstR+X0muVi/L9mgvxg==
X-Received: by 2002:a17:90b:364d:b0:32b:7d2f:2ee7 with SMTP id 98e67ed59e1d1-3342a22c945mr282053a91.13.1758733273968;
        Wed, 24 Sep 2025 10:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENExJBcnMRSaIHCjd/DduchLrLj47zDfDf7++AjetgzThk/lhpjIGtQg+ChueQ7qA4WR/ppQ==
X-Received: by 2002:a17:90b:364d:b0:32b:7d2f:2ee7 with SMTP id 98e67ed59e1d1-3342a22c945mr281996a91.13.1758733273086;
        Wed, 24 Sep 2025 10:01:13 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda09a0sm2931299a91.9.2025.09.24.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:01:12 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH v2 0/3] pinctrl: Update dt-binding and driver to support
 Glymur PMICs
Date: Wed, 24 Sep 2025 22:31:01 +0530
Message-Id: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0j1GgC/13NwQqDMAzG8VeRnBdwmWXVVxkeShtdQJ1LtWyI7
 74yD4Md/x/klw0iq3CEpthAOUmUx5SDTgX4u5t6Rgm5gUoyZU0V9sN7XBVnmfyiAwaVxIpsPfk
 LOWuCh3w7K3fy+rq39mjl55r55Rh/en72Z8d5FEwWu7Mz166ytaWqSQTtvn8Ap7+jD7AAAAA=
X-Change-ID: 20250924-glymur-pinctrl-driver-e8c2c32a85dc
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758733268; l=1571;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=kXDI7MEXFf6z8gjpvhdqltoRlqilkIpnmYKOs1pJ2QY=;
 b=OfnaSG/Tgae/FcBfTGMWUQfl2So7nVlRvb/7ycVRmbTPHJpFn4oi8IScj3L10z5mQhkuL3h3p
 M1h3HHusEpyDryQzZotWbZ2oOzZFknSriVvhrCrBmPqve0nmG8QaTS5
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d423dc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=xrc4ZGigH1M6lUekqJwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: UGpGOs1JYBrWwVvNaMepfkYwWJ7vICTB
X-Proofpoint-ORIG-GUID: UGpGOs1JYBrWwVvNaMepfkYwWJ7vICTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX8UrU+TpJOe+/
 jtfteXXfE93tdFOeakBZUOANQBC1O5iiQY8eEH4oXkyp+fI0CgskpVEDPnOSOk5ZYUOrRvQ3sTR
 qhLDpbCcMFZY98YbhRHhtaQt7y5tbpAOaLsqVrdBrKocgi08iHDqYCFqfrnuqvf7fQvc1nuKZSL
 eEAzCYcFN3uwC82t1hWsvwUI+uvEjOnZMNdTTUpaocgQXljMgJq59ChrrX8Ytmt1+MmsLvKGZhW
 C+zu/Y/nXAFq8H20gBPpwl9p8jrTNrGBxpvyMSXRVBUWk9OiUcQYQ2I4SRReslIm40g72iGUVCM
 hkb90DDFFNfegRvC10nO3WXEo3RC1MjpsOMzdCVMrLf4CGVG0dj7KtIRHptytl8sqzARs0FleTo
 EE/AFQjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

This series contains patches to update the PINCTRL drivers
and device tree bindings needed to support the new GPIO types
for PMICs present on boards with Qualcomm's next-generation
compute SoC - Glymur.

Device tree changes are not included in this series and will
be posted separately after the official announcement of the
Glymur SoC.

Changes in v2:
- Split into two series: SPMI and PINCTRL(this series)
- Included the DT bindings in this series, previously posted separately.
- Link to v1: https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com/

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Anjelique Melendez (1):
      pinctrl: qcom: spmi-gpio: Add PMCX0102, PMK8850 & PMH01XX PMICs support

Jishnu Prakash (1):
      dt-bindings: pinctrl: qcom,pmic-gpio: Add GPIO bindings for Glymur PMICs

Subbaraman Narayanamurthy (1):
      pinctrl: qcom: spmi-gpio: add support for {LV_VIN2, MV_VIN3}_CLK subtypes

 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml       | 15 +++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                  |  9 +++++++++
 2 files changed, 24 insertions(+)
---
base-commit: dd1059140d0608262a3a39591360fc0101bddf68
change-id: 20250924-glymur-pinctrl-driver-e8c2c32a85dc
prerequisite-change-id: 20250924-glymur-spmi-v8-f1a57f489824:v2
prerequisite-patch-id: a27e60b23189b89c17444ad76fbeaa7687a426d4
prerequisite-patch-id: 6940e73d1975830ceb11b4e8bf1be2303e866e7d

Best regards,
-- 
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>


