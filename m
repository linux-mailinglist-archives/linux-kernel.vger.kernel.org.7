Return-Path: <linux-kernel+bounces-831816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86958B9D9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F3E1BC37A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD022EC557;
	Thu, 25 Sep 2025 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgReldz6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B482EC09B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781782; cv=none; b=MlfxUPdV/vZ+Av8Yg8GfTIX0cYfTjmg+g96lt7gtM7nC5fs/C7dXbarV8HepBgAQEsEYd6ieplKzodQw4CZZrBPyT3+DNKlhK5LUXdc8XkYwZXrsoTBGqbkkX9QF6wGYzLYzRdYyPJzdKVCWKJOVsddMijOyx0hcCj3708JKSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781782; c=relaxed/simple;
	bh=RDdBDErVPYkb7kQ40hn7vPiyirE4liN5DKCLZ9h9OKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csROPJwPW89OoTsMWkxrVlP5MsV3SrFRJeIYZvkpXIkGqAzDpWMtvdwWcERax17wTrEDq41cBbKLcS1gDQJmIqmuLZLs6YHCFqPww3zLbG5kT15TR8aCf5golcCJ3L+f8UI7OD6aC4am7uEdSbTcLgU99Xhqi+yOO2HepvQhCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgReldz6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1492l003945
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KPvdBTUqrNUETXTQBR3pTDVkd6wGbjn3B7OmL+KStu4=; b=EgReldz6efcWMask
	ym6ijDwS+Ja2+W+m9UBlsdcfQlxv3c91T/9AftNLKmI6eHuT8aAAQGI4rGk17inT
	C37YScNy0bwZUQkqxDZ9uq0y41scW6ei8YPEh9SnrmD42RLEfz0jijgTVanFug8/
	PuYTUkIWzTvHwmDeUTmGC/EAq7BS+4xBU52JUZDrcPUrDr93KvX/yD+5pYKWsc6j
	ieJO5amSXe6rAF5R7NIFP/DF+AKkGzGtV6JY5l7MUPyORqo3rWEuUHPE9NSa8E1h
	nf5JhjgRtdFQu1auPV7PQ9Qd4PRXYfS/PPvSY1tYZ7IG++y/Pt2ynXRdXlBSR0uf
	BAzafg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1j63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso546873b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781779; x=1759386579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPvdBTUqrNUETXTQBR3pTDVkd6wGbjn3B7OmL+KStu4=;
        b=geYSkyIrEuZoDAhDYmVQ80er4yX4oY+VV7CakzeiR7pPN1Mok5l4htoyf/gx5BRLG0
         STaLmdYefX8GDGqW/uiWr1UscXMueH/K1QUdegObnNIBSLWxLG0n2QgXYqJnSNt5yIsE
         aY3ZtP2EKofLOD34Yw0l2lqoVuUCsYbAYLvfeb4H33koGcCKUKlkjRj39afF3QCEpEmQ
         936+7G8Jy1tE1qPky7IBQ15kT8zHzVxTbViLgx8U2ro7PCFD41KP+7fkpHXHdwJI7kDK
         EBkp9E7mFgBzFtqvk6teK5r9cHsneBNtHf2Z+nQMRXfnWYqCotzck4LId54ZuAUANWBi
         njVw==
X-Forwarded-Encrypted: i=1; AJvYcCU/qmmgljIZoC+t47SNRE7fUR8NQ516329Tfyq3XvsEIpTuwDNIRnk3a45NzB9FLdHgfxEkDUafRBv+SNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJzBq0mlsR9+6IKgSIZMIXRbTaYFGTtyrN3V3zn/E499lkZdL
	NIvW50WwRB0X4zUV52PaF0Rwz6t0majEXRdg1PaOIrsSauCw5Kc/ZCrDvaD6na7QhoXYO3OUR8v
	Zi7OQsuqcRITOtkGSScqBvBf4Onm29Zcn8MPhvp4RSOCAa8MbQeWRAGx8HNxSinto4j4=
X-Gm-Gg: ASbGnctF8RB64dY9FjutF27kGEwuU3jp9OsrWujCwKNwnJ37K/ANPnZeq8fQRdyZOBh
	LOREXETXf6FxyVqN2A0/lyjahj8hp3agYmmiO9edrPONyprdGLw2v/b3NZ8MgrJuMyE8SN+FhHk
	+KuBtQaJ6XlXPXJydoWUnXSCMceCLvlgw2soClheANaCKyyptcPKTLjKS7ujxXXh5ZNsTiIIz0C
	kePofH9m+FA3LQDSD096t/fAqIFJD/BtzV+X4uGpIMC8nNC4zQLmw8z8okXtTsIaa+keuYRYxMP
	cDnUFcCw4nDpmYuNKhy6r6N0Zg1pYuAF/TOjZF8B06dfQkLuuJL/7tzPDIb+78FCMV9PRNbR+kv
	mzDDEBPccyYoaoVuv3PA3E+iA6/YseIrOgbkeSiB2JBE9mDai9QR7qzR+VhgK
X-Received: by 2002:a05:6a00:6ca3:b0:77f:1016:d47f with SMTP id d2e1a72fcca58-78100f3fbc6mr1594638b3a.8.1758781779066;
        Wed, 24 Sep 2025 23:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiJcVY8mgUCKJGRQ/chGcdmsCd6koRn194ynJqMHtAe0w2xw7zVi2y6zjFcHPP2JwBNE6LgQ==
X-Received: by 2002:a05:6a00:6ca3:b0:77f:1016:d47f with SMTP id d2e1a72fcca58-78100f3fbc6mr1594603b3a.8.1758781778616;
        Wed, 24 Sep 2025 23:29:38 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:38 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:19 +0530
Subject: [PATCH v2 13/24] arm64: dts: qcom: Update pmh0104 dtsi for Glymur
 CRD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-13-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: z90v_edOi0NJaI503nK76Xen5_-yMRga
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e154 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Bl1eJC4Zh2N44W0__HIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXy1cstSUfcOXf
 HOgnXUYErVrdeCSbOT74wdVu74VWxXx4yXwkQlwAlOfpANOJqslM3xukxGvtdz6CIDLm2uRGLHl
 4jI/OxucMcRDGT7ZGnVIUCJa18oKy+cuhE3DP8LhNW3oPBTLNMgp2lClU4b+nlhu0fhUiJGNSOE
 xmBSOhNpQxWegZdGmgBr3xEnlvq9U4y2knTHzhKhlc9rcRHu+FYPE1FThrHqJhuYOA9FH4jvqvG
 aKFYf+QlkYS4IeSHJNwLURwsIT5MMF8r+Ql/WJxGSB0iy5W9ner3AJz0X3kJeDvSCxsuP/AdTKz
 bRgHCJaNfAMQBmmuB+Emy077p9giKl1S+Wv2VE+gLCIjcV/GZ+s+Ko8Pn6i0xd/aaUaqDT7M79b
 hGnKAaAK
X-Proofpoint-ORIG-GUID: z90v_edOi0NJaI503nK76Xen5_-yMRga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Update the pmh0104.dtsi to include multiple instances of PMH0104
DT nodes, one for each SID assigned to this PMIC on the spmi_bus0
and spmi_bus1 in Glymur CRD board.

Take care to avoid compilation issue with the existing nodes by
gaurding each PMH0104 nodes with `#ifdef` for its corresponding
SID macro. So that only the nodes which have the their SID macro
defined are the only ones picked for compilation.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmh0104.dtsi | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
index f5393fdebe957ea0caf4bbc16117374b4759bda3..d3ea7486d842ec813a79268fc1466e1513426d78 100644
--- a/arch/arm64/boot/dts/qcom/pmh0104.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
@@ -6,7 +6,63 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+&spmi_bus0 {
+#ifdef PMH0104_I_E0_SID
+	pmh0104_i_e0: pmic@PMH0104_I_E0_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_I_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0104_i_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_I_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_i_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_i_e0_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
+
+#ifdef PMH0104_J_E0_SID
+	pmh0104_j_e0: pmic@PMH0104_J_E0_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_J_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmh0104_j_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_J_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_j_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_j_e0_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
+};
+
 &spmi_bus1 {
+#ifdef PMH0104_J_E1_SID
 	pmh0104_j_e1: pmic@PMH0104_J_E1_SID {
 		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
 		reg = <PMH0104_J_E1_SID SPMI_USID>;
@@ -30,4 +86,32 @@ pmh0104_j_e1_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+#endif
+
+#ifdef PMH0104_L_E1_SID
+	pmh0104_l_e1: pmic@PMH0104_L_E1_SID {
+		compatible = "qcom,pmh0104", "qcom,spmi-pmic";
+		reg = <PMH0104_L_E1_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0104_l_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0104_L_E1_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0104_l_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmh0104-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0104_l_e1_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+#endif
 };

-- 
2.34.1


