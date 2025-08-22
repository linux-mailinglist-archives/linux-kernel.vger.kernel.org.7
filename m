Return-Path: <linux-kernel+bounces-781685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2FB3157A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC6F5A1E71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8422F3C09;
	Fri, 22 Aug 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxZXdlU3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08371991D4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858635; cv=none; b=ZUpGsymApCF/jnlgaezRJdJySlDPpzmu3LOs+7PRRXteQoLquU7PhcBTTDK008nB5sMh7nIBtLQQzlml2MSYN/xB31DNesQ5BaPoQXqBh4SjBtobQVI/uLLUl6yOCACutBlBYyU0ZhhOJldPCXRcbcQJV3LnX08/Oj6KjynQc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858635; c=relaxed/simple;
	bh=qiYYWeXGyneC1KjiHAMmCpDYJ9k3K0y9ORAAb4EGCAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obTHq/MPF/R0KHcBjNWvMXlZqzImE+Ddga3XBatq6yE1j4i/h/63sdDDMNmZGhypjKxn5BmAEMiEiv+A6pDqwUc/ALfk5NbfGguGZziJu2mQKmX2vlCr4FyzQKfEHIbVTUwsMsqM9k+KhO3WzoBkV7LoDE+J88LW4Ny4AyGMMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxZXdlU3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UjbT019037
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=k13K1y4W7bk
	1dVHjpu6PSFA3QeSZb1Ld64NLLZxH3z4=; b=fxZXdlU398nJoHhnBD+wib2T1JM
	+xDw6l/rmrEY/qH5C0NBvJ3mYED0mjVRYXIC+QAq+1YavoNkWfvp0rnsRkf4BQWH
	DROM7bT6kiFZ1ALKbDktAD8EZUw9eP/1nkiM6aWa6amMtsPs8MER/sB3reDVH8li
	HbmMbgzbDGdMoVFUQ84pWn9baxNiYHYC34SSiz27cKugRZIkhKzc7x8RwSTntmUE
	WBv9tNOnOkI7OFgPebc3u5RAoCq8QrKVXhKfFr0lerGWihL3C9T3LZjTMN3Jt5SY
	nUo93SAp6J7OXcqNbrQwJvkmtKR5v5Sbj8KABjyTlQebbl2KBMgEANNY+Fw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52b0rda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49c1c130caso528000a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858630; x=1756463430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k13K1y4W7bk1dVHjpu6PSFA3QeSZb1Ld64NLLZxH3z4=;
        b=bHpA1XcDOwU+QMAoxnbciLCfQkY6tScMGRWn5u4uM9QnGByaF2zGr0uFkoGLam4Hk3
         N+55fgYF7xmI/z9FWKlXS9Az2qgM1aLwK7Ku0mJmKxFwMNvImBBBPkCS2z6GI/AHCUcE
         FPef7WorwT9UFH64w5pKmiSaOQdE3a5dHUbZOXG9fMC2OLt38JVwOz/8Tnxip4/TqaQg
         D9reH4p7Hc7HyQlVkRBFp2Y/eCqcODgpNy9Jx04X7IBMIPxHmTviBS5EGYqS2SNf68Lp
         leQMKptD5tM2DVXV1PGBTEEKMTI/07GHKHE4+IV1pl81mbz21E+QAcYmCqE5AY3cgEhe
         cv8g==
X-Forwarded-Encrypted: i=1; AJvYcCUYUPWFpXr9z1/AMiPMP6cAgRfNT3Z7F8CoZljTPM+vhJ5zL6/fDbmucwghUg1a4GGnp7pfmPcEADO0ork=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuJfbzKeSsSJkIVYNF7/Mo4OIc2R2b3ojzr0AUypKijItFeOj
	IsJob1c2KmGI+EEMhp5BX22vJc3YIzyBw7c1DkCxybzGv1S0JjeaIXIzQLR2PG0g2KWMhm+KuTd
	lG6Hk4C41XHLPQMEM+3U1Y2zXC03rEY7buu+kbz2h6ndt9hk/bGKzgHos5sFlX51NhnM=
X-Gm-Gg: ASbGncuEDufqMg1/U+ADgXq7X3YH3zBbh5uydHC2cn8K4LdI3KD1Mn0GJ364NsXwV39
	fd6QZRkK3oTmUM2HyW1DlGQvddYyumPAE9fxsFq1PNCwgP0LvW+9ZBVYyA682DlXZRQlCaDtbzp
	2W8abJAm/h8B8gYdv23ICf3cwzuaDELNiOm8k9oB7y23l7/Xcbaz7dJs7yKwFeV+etLdd7RcS/z
	NzDgpLLzCNbOmbSvybbfAk08/2ieVmt1H+niv9ConK4+IlRD+1qZLouEEoXLyE2C4AcPBE8Yhem
	/yjMtKUJGBKWlnLC5M3CTsZ8UkOcz7lh+pwTSq4XmeaXevb4rS53yCsoam7lASqscZvmOeouIA8
	3pUtpzkKg2c8Na5paVl5y
X-Received: by 2002:a05:6a20:1594:b0:238:3f54:78ec with SMTP id adf61e73a8af0-24340def5fbmr3825810637.46.1755858630401;
        Fri, 22 Aug 2025 03:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVlMDlU6sV9lQpDsihzPt7GlkamAV4d2zA9RgA04+j3Ibuouglgjezu/LoQBnFhZnLmMuvHg==
X-Received: by 2002:a05:6a20:1594:b0:238:3f54:78ec with SMTP id adf61e73a8af0-24340def5fbmr3825768637.46.1755858629955;
        Fri, 22 Aug 2025 03:30:29 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fec0e9sm6825196a12.24.2025.08.22.03.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:30:29 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: dts: qcom: lemans: enable static TPDM
Date: Fri, 22 Aug 2025 18:30:08 +0800
Message-Id: <20250822103008.1029-4-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7wuc2QW3oqUO
 NQcXcuDLUW8K4hGLEgoMy8biKNnnodVgaY2/YuFO2ecpCds4NRuznMn7fTnJshwrU1LpLqcc5DQ
 lmUgH2Qpi5YBH8LWEk/T5cdhUfQKnsHISmdSLE8PoWqpAabA/JcGLDvjsOiURNVWrhJGxHw1iKp
 uWvDxsjdNdpD45UWO88MFklgw03nf7Sm1PDYQvuTUjl9R8Ewlmo8vF48/OnRs35RciIIRRF7D90
 AxhRWRrrsvOeFCJfsFAEsetQ001pukoc9O9I+bdNW5BknctUfncDElUSRxKu8OykESk30uYBAfJ
 qw7yhTeU5azjZd6CQp2c/GJUXzetHthmYOGscztyZtDYIJFUC+3pnnYbVmkOlMoo5cfjZNTlTtL
 uTCbQmgDzB3iw2WEIss4q3mxRlh1eg==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a846c7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8Krfq1_MhNCW99YIMDUA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: z0lZY9QfJa6e1sFeLWaqwG0pX0rnGDtP
X-Proofpoint-GUID: z0lZY9QfJa6e1sFeLWaqwG0pX0rnGDtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Enable static TPDM device for lemans.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 64f5378c6a47..077e22b28279 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -2959,6 +2959,14 @@ funnel1_in4: endpoint {
 						<&apss_funnel1_out>;
 					};
 				};
+
+				port@5 {
+					reg = <5>;
+
+					funnel1_in5: endpoint {
+						remote-endpoint = <&dlct0_funnel_out>;
+					};
+				};
 			};
 		};
 
@@ -3116,6 +3124,60 @@ etr1_out: endpoint {
 			};
 		};
 
+		tpda@4ad3000 {
+			compatible = "qcom,coresight-tpda", "arm,primecell";
+			reg = <0x0 0x4ad3000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@10 {
+					reg = <16>;
+					dlct0_tpda_in16: endpoint {
+						remote-endpoint = <&turing0_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					dlct0_tpda_out: endpoint {
+						remote-endpoint =
+						<&dlct0_funnel_in0>;
+					};
+				};
+			};
+
+		};
+
+		funnel@4ad4000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x4ad4000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					dlct0_funnel_in0: endpoint {
+						remote-endpoint = <&dlct0_tpda_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					dlct0_funnel_out: endpoint {
+						remote-endpoint = <&funnel1_in5>;
+					};
+				};
+			};
+		};
+
 		funnel@4b04000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x0 0x4b04000 0x0 0x1000>;
@@ -3388,6 +3450,35 @@ aoss_cti: cti@4b13000 {
 			clock-names = "apb_pclk";
 		};
 
+		funnel@4b83000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x4b83000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+
+					turing0_funnel_in1: endpoint {
+						remote-endpoint = <&turing_llm_tpdm_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					turing0_funnel_out: endpoint {
+						remote-endpoint = <&dlct0_tpda_in16>;
+					};
+				};
+			};
+		};
+
 		etm@6040000 {
 			compatible = "arm,primecell";
 			reg = <0x0 0x6040000 0x0 0x1000>;
@@ -7578,6 +7669,20 @@ arch_timer: timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	turing-llm-tpdm {
+		compatible = "qcom,coresight-static-tpdm";
+
+		qcom,cmb-element-bits = <32>;
+
+		out-ports {
+			port {
+				turing_llm_tpdm_out: endpoint {
+					remote-endpoint = <&turing0_funnel_in1>;
+				};
+			};
+		};
+	};
+
 	pcie0: pcie@1c00000 {
 		compatible = "qcom,pcie-sa8775p";
 		reg = <0x0 0x01c00000 0x0 0x3000>,
-- 
2.34.1


