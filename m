Return-Path: <linux-kernel+bounces-884266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9746C2FC46
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74591897CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C0311972;
	Tue,  4 Nov 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUFL/NGm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RxS1owv5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00E311952
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243874; cv=none; b=f9oJHXn/5y4Mk85TR+MUEnr0gpwoYvR5L5w8Tg+O83LEDH6YGcvcX+0VisxufhO+IsJlRnNHDHeMrIHxfU/JXWMzymsG1SGhmWw54KRMrQI+WBWIoHgKUV/TtrLbZlq/XA41JepU8mske8YEygDwkBXwsxTnET7TvXHvnBsubec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243874; c=relaxed/simple;
	bh=OHJv8f5AUdCdaBksnNXi7tvGi4OzSaOYQOx0PkiUqxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwYTKIOjg9NwMQcaJGjEFPS/1KiQoBmvfzfUTuVy8MdUGDlbYQ1nk5R9bdVccZU2T2AOKSJjDWGaM2oXhZJj5070r25+R1MFqMndOs/ZEGOMnqAE+OYCrUtgIU+wSTj3EVa9AUJkjBrUe7OtLMmqrA2ZvHaW+qj/Fvti/gZuRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUFL/NGm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RxS1owv5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43aekg3846633
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gAkv7LcxBGkDllNLZTVNnfv6WbtJ7up7wJAyLH80Me8=; b=gUFL/NGmUGX6amoh
	qXatiQlIEcr/LhO2E7XDMzs4BnFTPyjoag6P6bYtatM4g19QDZ7tkH1lNVRIoPn4
	K7ot9/6qvv1naWZcsOEbE5RBn4mgAxguAtbREofuCYT8VaFbOdkVBmjP7QScL5o0
	31OIqpZQmJ7xRB6CGzZaUTPMeWTsZJDcC09YC3KhxFwup54lDIm9Y07rzUVjpVRY
	YVNt7Y/xaaJFXjMD/LV73HdcJac9oCbst/9u6R3qxbTqnwGDppAdB1mPqYTl69Q/
	JIwujgROYkZE2oiNGXuBo/gWILtkMqtTYcOlhM1bEG5FvseuKY3BMDFC5vu1lAFP
	j6ITjA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70f1j6hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:11:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294df925293so55133585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243871; x=1762848671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAkv7LcxBGkDllNLZTVNnfv6WbtJ7up7wJAyLH80Me8=;
        b=RxS1owv5LRAZNpJRtldD+LuCT0ZR0tE3Q2Fn9qpH7pcjiDvypPz+G5210Sj649wNC5
         kFlYVe7wZvpNAL5SuWLzRTl4YtyOcPPbuL9IJCWYV4jok4Q2PYqiSREXA98Dfem/8iJn
         xKCttlCOsutbdn3h0P1Zy8yAfdM02HFGR4vJK0mQQSaUPoqQcCC7Y3feuLdaJVGfXRQp
         rNJkFAhN6XhIIPs+AXMp6utexaDZvx2kUVpUh4ey9KyrmhJWaqz1jws6KwUVv+EOftFL
         bwUDDl5g6sQ/Gd9JXtSdrPJwaH3mVSNplEw3VUicSZIMoemkQ1Dl7ibYw65Z9wyaOwk5
         gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243871; x=1762848671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAkv7LcxBGkDllNLZTVNnfv6WbtJ7up7wJAyLH80Me8=;
        b=gbV/IBtr/49WPMHsCIcExhB85o4vY8P7ih92yAxZivEygeEWPGiGKEIbNo7FRurAwX
         8oa+7N1HbRBiso8m6lnfZR8lOOPW33eUxG4B1X33evmNWA6Cw69vZS6V8RkmITHN7XZr
         LP2+xNVvxOS57uZ8t3W3zH1WIez/Eb4cluD+RO/mBImkWCJcqdhseuDPzx1YrO/bxocp
         JxYk0XMxVFoXDJv+s56sBaZZQUnjLA8iZQMd/pp97FvUjE2Ojg8OkwrXG9tlK4V83cD/
         n0XO1freHHYqeTMjTuDLBMZsKS0V52Fm7MeogKzl2vmOedBoHLSGALmjgmES3ulBIdoL
         lUfA==
X-Forwarded-Encrypted: i=1; AJvYcCXRcjLrZx7YQbFA6ssGUhdpFR4J5EF/QeE46xwok0eqrkAMjqL755osiDlzjJrRu5CBDGaLPwxJNOFJb2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzpYUe/fSbvLtROUJLmoxxVFBAKPjhWxCJtLjtZ0QQoR98tQo
	DXApDwHSTnHocCND50lFofLlFXjPznu44qMX9k0aoVYHG+XoPuF6GTLVpeh+T3y5d2cNW/bEfD2
	bNYwE/tFxee84aiQwkwxSwmsKTCbjKXXOScgFtjFPAJRAVS9y/uruShKJOlhwjVc/NzI=
X-Gm-Gg: ASbGncuwcrKmB8InCkIwymP1LZcxMn0sJ2AyCta4B8bQIZEsg74wGoEasXqGOAWvOEs
	RCZcy9yJceJ5i5VL4J8ml1/r6jyXxtssMTZXSlOU5pnjw8K1KZaalMB3EnKMqlNpkjSaEpUiVFf
	8PpxR6Q664VIL+JQLz4WMPKKZ1QUR6ZosYtrgcj/zWp5MFO4kMnzToaLPj7OUry/1RbFPK1pBzx
	qgQ5KSr2Tz3ygsex5WGaWkhD/xyrkAha9LauPzhkCzjvJq5fZ0271xSwCw5cxgMmbexsa3A1nUH
	6+jAnm3PUuPCEa/VVOCbCeGKIWTvDLm35syZ1Exma/SxY22nVaXI7l74deTiVk2RKpyfEFAKw1c
	nhc3jxxROHhb80eN5L3iQSX5tEUUJshaaa7s04y09Q6fkFGYFTGtmzd1WYtOomA==
X-Received: by 2002:a17:902:da8c:b0:27e:f018:d312 with SMTP id d9443c01a7336-2951a34cc1emr212417445ad.1.1762243870826;
        Tue, 04 Nov 2025 00:11:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXY6zDdyrmbIgczl2U0WQJakaEyR/XD+xu3IwyJv46EHXkuQZDiUvH19PkFadmgv6DKCJ0jQ==
X-Received: by 2002:a17:902:da8c:b0:27e:f018:d312 with SMTP id d9443c01a7336-2951a34cc1emr212416885ad.1.1762243870139;
        Tue, 04 Nov 2025 00:11:10 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7afe3sm16755885ad.110.2025.11.04.00.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:11:09 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 16:10:18 +0800
Subject: [PATCH 2/2] arm64: dts: qcom: hamoa: enable ETR and CTCU devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-enable-etr-and-ctcu-for-hamoa-v1-2-af552cfb902c@oss.qualcomm.com>
References: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
In-Reply-To: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243855; l=4142;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=OHJv8f5AUdCdaBksnNXi7tvGi4OzSaOYQOx0PkiUqxU=;
 b=xuIwb79gX38qzdbP67hlDxW0sL2EBAugZiZ5e0ZvLV/gWvlgeSSnRQ1k2jvP+dKq6T1tfUNKA
 UCR9U9MklacAU5XtIO2fOeDCfwvz78gw0frWdCuya66BdRYuSnmnfjA
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=JLQ2csKb c=1 sm=1 tr=0 ts=6909b520 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IA447Ct8CvcyBBeIGyIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfX7SUG1+Rt0u6e
 QiTgMr8epgXGw4zzQ5D69XQBlklscxuwIlcko6YGaFP12ikd3ajM59VF+6jAdmuT1wWqFur2QiV
 iLYqiQEKowqyNxwWlz+aet9DBphRbmu3kGFLhPYzQOBC/5FtLumBkzv3EXPItLq2EgGb2niV1uL
 LiRrCR5EPjV4h30wPGXDofEKi3VvjBCTs/dejjn47OIKL2XFrIezhYr/uQd3lI7rSMXHOUlQ/cK
 We8HxTiZz8S9YyFAdOcXaBvhbojcjJfv07phL3Vet4uG7msMDNvaAodD+X8bKjctr+Xy4VECd4w
 LAUn1r5Ihx/WyVjw02QimF6vBCSgFmi54w1g8IPPFKE5bESZHyXAveze86m8KahM+icrwphddd/
 a8mMu3/zwiEvEV053Yto2hjD9O5k+w==
X-Proofpoint-ORIG-GUID: lUH7zLdbeQEZFXrdDQzVzjeF5D8VWbaZ
X-Proofpoint-GUID: lUH7zLdbeQEZFXrdDQzVzjeF5D8VWbaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040066

Embedded Trace Router(ETR) is working as a DDR memory sink to collect
tracing data from source device.

The CTCU serves as the control unit for the ETR device, managing its
behavior to determine how trace data is collected.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 160 +++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index a17900eacb20..ca4a473614ee 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -6713,6 +6713,35 @@ data-pins {
 			};
 		};
 
+		ctcu@10001000 {
+			compatible = "qcom,hamoa-ctcu","qcom,sa8775p-ctcu";
+			reg = <0x0 0x10001000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ctcu_in0: endpoint {
+						remote-endpoint = <&etr0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ctcu_in1: endpoint {
+						remote-endpoint = <&etr1_out>;
+					};
+				};
+			};
+		};
+
 		stm@10002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x10002000 0x0 0x1000>,
@@ -6927,6 +6956,122 @@ qdss_funnel_out: endpoint {
 			};
 		};
 
+		replicator@10046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x10046000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					qdss_rep_in: endpoint {
+						remote-endpoint = <&swao_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					qdss_rep_out0: endpoint {
+						remote-endpoint = <&etr_rep_in>;
+					};
+				};
+			};
+		};
+
+		tmc_etr: tmc@10048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x10048000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04e0 0x0>;
+
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr0_in: endpoint {
+						remote-endpoint = <&etr_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etr0_out: endpoint {
+						remote-endpoint = <&ctcu_in0>;
+					};
+				};
+			};
+		};
+
+		replicator@1004e000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x1004e000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etr_rep_in: endpoint {
+						remote-endpoint = <&qdss_rep_out0>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					etr_rep_out0: endpoint {
+						remote-endpoint = <&etr0_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					etr_rep_out1: endpoint {
+						remote-endpoint = <&etr1_in>;
+					};
+				};
+			};
+		};
+
+		tmc_etr1: tmc@1004f000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x1004f000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x0500 0x0>;
+
+			arm,scatter-gather;
+			arm,buffer-size = <0x400000>;
+
+			in-ports {
+				port {
+					etr1_in: endpoint {
+						remote-endpoint = <&etr_rep_out1>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etr1_out: endpoint {
+						remote-endpoint = <&ctcu_in1>;
+					};
+				};
+			};
+		};
+
 		tpdm@10800000 {
 			compatible = "qcom,coresight-tpdm", "arm,primecell";
 			reg = <0x0 0x10800000 0x0 0x1000>;
@@ -7240,7 +7385,20 @@ swao_rep_in: endpoint {
 			};
 
 			out-ports {
-				port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					swao_rep_out0: endpoint {
+						remote-endpoint = <&qdss_rep_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
 					swao_rep_out1: endpoint {
 						remote-endpoint = <&eud_in>;
 					};

-- 
2.34.1


