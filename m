Return-Path: <linux-kernel+bounces-826033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9DB8D5F0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A70189B785
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D7140E34;
	Sun, 21 Sep 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LmneTwd3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2222097
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438696; cv=none; b=nBrEmeDuz02IZFGfdC4U32XODCA+gaufLjWUCOXBn98uxq86on3zCGY4BeT/N3ySTN6XlLZT74fGMRA/gTy6pKSG7ApbaB6r1UIZw6ieTQU8ojx2vCErVywk1prJ1CeTUnxGHoaFff+46KibBloOO+h+Zal5wRRAUAk4Oe+HAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438696; c=relaxed/simple;
	bh=qCBUZH6H2gcrsKaJFR1+rygBnZPeE1GPMLWvNkY/i+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YtouhdCRIzxTTNq9cD54e6Gh+2LPP8W0+rth3cBDHnSc3bP3S+NoQApKdh+5Shvje6SYBQJHYOhZqBf7a2OzOwESZP1mWHEGdrTytnhzA6hznCO8Caju7bql4aUoT87MZom7d21/Q4EPrzkL9zOACSGOV2sItOYqFHSEYctqjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LmneTwd3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L5FhUq009792
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=675tRa9BLzBeTvCVeI0XOe
	bRmK0iVzgJEs7KBylFXRQ=; b=LmneTwd3M91yPEiCecmzJtBCuFhsKqHM6jDqza
	L+ShO0odPvNOCmb9ErJqR2Vrbs26OjaNWXwAzk42TsA7MU8SbXW/Cz0nvAjC3BDt
	Fcu9tQt9AoMRqXCr6eRA4AFufZvhfoxxMQkWGKMHKgKErmR04lTCP90sRsenDYTy
	BdX+9UH/tA76tNYllEwBOlJUDjWY4CWtzqtCYowR8ATEg9EjmtVZRl0LI4ryqS1k
	rITvqH3EmeSGxHCpHEaFvN/gqTqz7rXfPRCKS/miQD6WRBELTPEoPomHbA55Q5UQ
	q/oPKRtPewlatnd8Mc0L0iW3CeaycIrsH0VS9A3gUgEK40dA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnj46h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e831e5a42so88503896d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438692; x=1759043492;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=675tRa9BLzBeTvCVeI0XOebRmK0iVzgJEs7KBylFXRQ=;
        b=R3tWtsYmu/uUbuMv++C8qRZUJy/EifNcCPhnSxoIPtCENaFb26u1gH7HTakNu9g7sB
         TsQkwXdyvibyh5dnIOeK/0zqk1o4/3xi7IUrfGPn+6ZojkNRUblzWyIVQ+VwwlNafWNp
         Cp7KTzmfW3g94YUv79oYYHqBfXr3hR9+LzjKFV2trrCpPRNUEF0MoAbj6YNZWADlXO8p
         RAcgX3jjgb2mHVEacQt805yAhH45xm4nVi2syZ3OKy7gqFKrEERI9gJmrzlguHI5Q0tb
         Qx8G9YPTp8rbWj5ZcSXJ1jGnjyKylbQiAu3m+SYkdW/+ehhCIrh4iUzoEkvpoQEv4ynB
         azlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfK91Jp1PdHdhq8D60TJ74giWsEUuArQOrTdhMmSGBPuesX6cbj344d5oM5EcLdWYgEmFWzEUWlZe/0kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAqdJuNGUizB0G/TIeJwjUZ4pf+eLn3oB2az2OK+Fo/IEM1R+
	Pl/uUOvtj9D7wQL2amjS11xP9tCGZREfX0LHQq5K5KkIkuXMqRZiQLBMILVWBO+jXTc42Mu/Yau
	fun83Y1AukzNcOlbrSCbrZIxvVZopkzBcb5wdiJu7Ou6SiYlQTcrpTZzi/U/9ycBH/xg=
X-Gm-Gg: ASbGncsNRp+8qjOjiA7bOOFUMv0pWBAY5YgoFfE6Z0LFqkj5lgYeRYNvS2dhimppjO6
	8NXxZ82NGUasHgYRN3uxOvQrWrqHEoCTDbcYUkPC1FSRiYtUCEny25a9obOFj0P/Iz4anuFwJ2x
	i19UaK+yS/3H6tnmjQRFU8vQyZ9sd0Jp2gb1dJBK4XGbcWyyQ5WI3GcRD6mWL0tHcIDretVDWpL
	HQECPypADwZV6wKdwv2OekLuwUJxGU22mEYgZygoyQyTfywONN5DyEfgYkR7eLK6LrKZBVC8k0B
	zpioA4iaaJxfbYNbvM33BpH8ndJkTAv7coClOegSkTrTSoYCPP3bOaGg7HjuDh5CY+0R994fQEa
	lkFk4ITVjxfAJC/IHsUNmo6vSnSSJ7SxOGTityLK+JblEqt8mpv2G
X-Received: by 2002:a05:622a:5c93:b0:4b6:2ca5:2035 with SMTP id d75a77b69052e-4c07416be64mr110892661cf.81.1758438692658;
        Sun, 21 Sep 2025 00:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6a/nr7VJ5660O8pA5uGtxJd95HVUds2QIGHx6/8ri+YcRxb/26sTse9rVPDU8C2VnT/uCww==
X-Received: by 2002:a05:622a:5c93:b0:4b6:2ca5:2035 with SMTP id d75a77b69052e-4c07416be64mr110892471cf.81.1758438692257;
        Sun, 21 Sep 2025 00:11:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/14] arm64: dts: qcom: add refgen regulators where
 applicable
Date: Sun, 21 Sep 2025 10:09:16 +0300
Message-Id: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2kz2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMD3aLUtPTUPF1LC8MUAyPzNJNkc1MloOICoHhmBdig6NjaWgCoDWN
 yWAAAAA==
X-Change-ID: 20250920-refgen-981d027f4c75
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qCBUZH6H2gcrsKaJFR1+rygBnZPeE1GPMLWvNkY/i+M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6Ugg6uQb3dQUMhj7mY9NTbD+ccrO5lCRouqT
 lQkZHHdlNaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIAAKCRCLPIo+Aiko
 1Q0QCACbQOwQac8SR8RN18wAZAPDfujqsWIbvKwhvgsAeAJ4+LDpyZImczUTVHBDTCyovVUVYA3
 yq6gp7lwp7NpTlR+uhUWkLf2P7srIW19/+w7jc112Tl2IhMlerwhX6d+htFu0MHvKhcevsy9Cfs
 JV+/OHUZTHcso0Y2QBsrhFmG73h3o719rdWaYtDceZZB4ZsBdzSgJbpFTQZ9Z3nn9k5ZQL3muf7
 za8uKKnzabY8T1K/7PzB/zEeK2RawLTuDhigmBGMRD4T9UctJE98xjTA+Mlhe/Bf5C8LsEEN0MQ
 sJIIaiWtuvbKIZ59vu/u/DWd2HMpQ0XrTSUrhM4+CHuACH8k
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68cfa525 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qtLNUSdA59iILLCgdDoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Hwpt1gZVjnM3EqrukWqdNA67DjTe_EQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX9ou/uYCGA3M0
 WX1ZqiICnD19xBeNIZao7R0vSUJ9y4iT5pKaHE7+W9uZz0H7JY//savx4Q47tGQU2237guGxRAL
 HEeDTKzu/Am+a1cyQyOzWRwH8zgvyWGdENddo5WX6U28scjFxNHRAre9BTToATFIzErX8gUYPX9
 DAMurUDuKczDfmdaHqd7PfZQmzShMX0SFTUcJVDWmYhWyYiUao5gRFglZ+XcOYznHjJn4/Pp43y
 RDl/SflYlxfHp4bGqpTYEJcMkKzdy6RLFdU3dmtzvAhqwk0LQB0vOqdu/PjdeO6eqlvNp/VbZhM
 F3MfS0LuZ8xgHPlPIKmzznL4kyaeVOL43E6MKvjhmzcGvwX0eeCf/r3HWYWwyswsTli1KfIO0C9
 rdJ4S0P2
X-Proofpoint-GUID: Hwpt1gZVjnM3EqrukWqdNA67DjTe_EQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On several Qualcomm platforms the DSI internally is using the refgen
regulator. Document the regulator for the SDM670, Lemans and QCS8300
platforms. Add corresponding device nodes and link them as a supply to
the DSI node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (14):
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: document more platforms
      arm64: dts: qcom: lemans: move USB PHYs to a proper place
      arm64: dts: qcom: lemans: add refgen regulator and use it for DSI
      arm64: dts: qcom: sc7180: add refgen regulator and use it for DSI
      arm64: dts: qcom: sc7280: add refgen regulator and use it for DSI
      arm64: dts: qcom: sc8180x: add refgen regulator and use it for DSI
      arm64: dts: qcom: sdm670: add refgen regulator and use it for DSI
      arm64: dts: qcom: sdm845: add refgen regulator and use it for DSI
      arm64: dts: qcom: sm6350: add refgen regulator and use it for DSI
      arm64: dts: qcom: sm8150: add refgen regulator and use it for DSI
      arm64: dts: qcom: sm8250: add refgen regulator and use it for DSI
      arm64: dts: qcom: qcs8300: add refgen regulator
      arm64: dts: qcom: sc8280xp: add refgen regulator
      arm64: dts: qcom: sm6375: add refgen regulator

 .../regulator/qcom,sdm845-refgen-regulator.yaml    |   3 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 110 +++++++++++----------
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              |   6 ++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   8 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   8 ++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  10 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   6 ++
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   9 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   8 ++
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |   6 ++
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  10 ++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   9 ++
 13 files changed, 153 insertions(+), 50 deletions(-)
---
base-commit: e5a7b3109c05f8aae05357fdcdaa3cfeaa99d241
change-id: 20250920-refgen-981d027f4c75

Best regards,
-- 
With best wishes
Dmitry


