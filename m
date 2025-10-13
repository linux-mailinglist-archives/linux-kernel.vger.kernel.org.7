Return-Path: <linux-kernel+bounces-850154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697EBD216E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BAF3C2A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF632F9985;
	Mon, 13 Oct 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDBV1CE7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1E2F99AA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344510; cv=none; b=NqUwGDiPUzqRMjAvd8ytaI2qtK2uU1Peoiund5uCH7F3YGaSJ9ft8uGUdzrSQRlfbOaw5GzTu9Izr3qhmSXyxtxMufPTi1RNC5U4TCsunC3V3IkFp4uuuOBbu+Di5Ygbo8Bi936Bg7j2AtBNJLB4SOcoc3Fs19okzxHeVFnhBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344510; c=relaxed/simple;
	bh=Z4+oQgS3Jbl9cg4D0kgGb6/AOBj9sZjjizm/su2bu80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfJtyTaioVFvznNR0tsT/vOScg0tH5SBj1p0RVl+701sLVblkDSHs+hB+MxhIpe67NpgWZLUhzt8CRtEEbVT42TIK6n3pmojCSadcUB3OV7VuESMY+Yx0bgKC2eYA/M7QcDpEIEkn9kw66HYiVz4WYtFuq769VPp6LmAOEOiDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SDBV1CE7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n4qH028910
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UY4Hh6glklh6ZR+c8fzW6JMMCANxpzh2RiegBxLS/MQ=; b=SDBV1CE7A9mZ1ygo
	LVD1BbWDUKFIosn7lBq+FFqkQ4N9QBIka9Ztlw/Vydq158SGuXzTsk8OiMn1mO/Q
	78+YbSFQwX9T2xWG2qQCPtc7x9vrG/WjCtTkdgzF5PLWtPlmvG4xD0Cikbvyoivy
	SZIbI5P6JPg5W34h132SDQ1iM4+o5p3aEiqJWEaofib1TNelWo1TxDAicbvbXLRd
	WlHgVBiIcnuU3h62KaidIu7V2pRIFzJS41LejDFKH4gmB3k4yhC5HWrzQpa/AP60
	AwVOCAoqS75QzUPPWATyV3+oYS8H2vO7eSKfXoAziNoI+EdNnQ3HgWh36cNXNv6w
	Pd+XQA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5bw6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781253de15aso14303959b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344505; x=1760949305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY4Hh6glklh6ZR+c8fzW6JMMCANxpzh2RiegBxLS/MQ=;
        b=VoTwnIFlOBN/nZOdtesPdmxZxd+5Z0rM4QwMFzoh046HBCVEAgj5bw4uAUUiq9sHrk
         Q6NcrlUVA0yRtu+0NVhiIMbsv1sWfVb/Uf/0+eaJWH4XP6lDE0pT857QrPwsVixTl9NM
         sOI+t1kATF4uoaLu70R9gKgyEpAatMii2PctbG6ryc/BQNoueRNQx7Xm2QECruavM/H9
         cd1tx7NtithciXp+H/Vi/Gp0X+JEYU71W/ok7Dbo0S/l0SPkSCjS9ysfxF7CzOCmVtPM
         6swCvP2cNy5l/UPCLztwC5Th9vEKxkNgmMNns/+j806AK04JeQOnMr6zomcWN67AfL1B
         a35w==
X-Forwarded-Encrypted: i=1; AJvYcCUphCT08kIO5L6x0cSwGxrTBvue58Ae8lYsHQ1pK89YUvLPrx31LE3j3jnc8NzR/wrpCZEDk87OmV0btAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdPnCLMvecGbhOohUAWkY9Z6NFSURaseurgjq5r6rNQ0wG820
	Xf4LsIr/igKxKgbT/tepOTBY1OWCxow/CRxCN8i+G3Sje0uBusrPqaOtm562IhPg71wQla0DV5O
	RjJYVvM8Ae/rh0xDbkqRI3tLhthaulEA99uPG4EwYXKzemBovCrlijbi3h21EYyXBH5c=
X-Gm-Gg: ASbGncsA6bUzv4+ZSuYhkqLIz9lZRtsF0KOZxGtL4n7GXDaTK/YETd0w2H79UQde5th
	caf0NCoPRaVe4dPfwBO7KtS70v9Bsld4Rf0AL9wZPR0Nh2xbw9ezuLKZuk/TPKCfPU6nDYoJ84D
	d7c+8jyXj25JjmUsenMj6U61NmJiY/n/oXd4r/szrc/abUpFK+ySDij8G1KKtkcpHcXRGqRghJ1
	uyDDF/nc5v9cYfu9fk4W2HPfpFRkM8QWPfHefHVgmTkCkipZ5iZQFIqmuzkHlYm+CCvwrUq+4J3
	1vfy7t917uMZh6T8gHecPhrXHBUtRrMnvJXRBQQ6Ta0PY5kHVrD3wUvBLQeIVGDMx0gjrAMzX7V
	6bVhyLCscetQxRK6k3BH5tjFTUV4=
X-Received: by 2002:a05:6a00:2d28:b0:78c:995b:4e9d with SMTP id d2e1a72fcca58-793858fb69amr23378804b3a.10.1760344504923;
        Mon, 13 Oct 2025 01:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6IE+z6Ub8yJL9ZLSqcTG59UK+YvYS9gtt6RTA329tg9HSehVJOP/AHPsZrMLp0ZgesAV2A==
X-Received: by 2002:a05:6a00:2d28:b0:78c:995b:4e9d with SMTP id d2e1a72fcca58-793858fb69amr23378768b3a.10.1760344504459;
        Mon, 13 Oct 2025 01:35:04 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09a87asm10773251b3a.46.2025.10.13.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:35:04 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:34:38 +0800
Subject: [PATCH v3 2/2] arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-ctcu-for-qcs8300-v3-2-611e6e0d3085@oss.qualcomm.com>
References: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
In-Reply-To: <20251013-enable-ctcu-for-qcs8300-v3-0-611e6e0d3085@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760344488; l=3935;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=Z4+oQgS3Jbl9cg4D0kgGb6/AOBj9sZjjizm/su2bu80=;
 b=+tHHXYONYDyeaQOL4Oq0D+PjKS9t/mdKnreAlUlLeIDMJ77IIj+8e3wWWK2/T3DxYKV/aR8nM
 KosnCPeugclDke6uOYU1reFxkMEaiBOnpFJ6anQoUVs0vc7wOkG0XdZ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: dMy6ZXXWN-fPpM6jY24klsFGib_3OMq9
X-Proofpoint-ORIG-GUID: dMy6ZXXWN-fPpM6jY24klsFGib_3OMq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX00S1daHDQ6l0
 dgtDVWmiAQpQLkbg1CNVAuudxMqZuV0iW/9sDbSZUnTgo/nLQr9V/ZglGPIAi9xWFSl+KimGDUe
 AnVq4s1WU7vVOxAa8h+SX1nVkvWLERDHrcrgyh0I2/rQ0Sxraq8pmw5j2A9gMYjiMFu4DfCZ4MW
 I/Ct0S2EnGscEQZVj9084lfwRxf2g6PaaQM5crjufbJxEAiE4bXabS3BG4+WqjqiCzJBsOO5TKj
 UTRxNlj/5aVflYvboAqvk6lll27OpGRud/DNGD3v/eu4+WoIGAqAivHoAyuP+E2tAx9S+gFtNnd
 kBqfc4wITXY4Mq/vqgBwl69Ceg9cwrFxQGBYfIeuJDC7RWnnXJGg59MNc11EaV8Dd8iVvUReJLP
 hWYE3Cy6BS7b0MjLbhpcJr7wLqcjEw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ecb9ba cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xJyy5nzPNu-aANFJA0oA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

Add CTCU and ETR nodes in DT to enable expected functionalities.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 153 ++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 8d78ccac411e..74ae32bfec93 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -2482,6 +2482,35 @@ lpass_ag_noc: interconnect@3c40000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ctcu@4001000 {
+			compatible = "qcom,qcs8300-ctcu", "qcom,sa8775p-ctcu";
+			reg = <0x0 0x04001000 0x0 0x1000>;
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
 		stm@4002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x04002000 0x0 0x1000>,
@@ -2676,6 +2705,122 @@ qdss_funnel_out: endpoint {
 			};
 		};
 
+		replicator@4046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x04046000 0x0 0x1000>;
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
+		tmc@4048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x04048000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04c0 0x00>;
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
+		replicator@404e000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x0404e000 0x0 0x1000>;
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
+		tmc@404f000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x0404f000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04a0 0x40>;
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
 		tpdm@4841000 {
 			compatible = "qcom,coresight-tpdm", "arm,primecell";
 			reg = <0x0 0x04841000 0x0 0x1000>;
@@ -3105,6 +3250,14 @@ out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				port@0 {
+					reg = <0>;
+
+					swao_rep_out0: endpoint {
+						remote-endpoint = <&qdss_rep_in>;
+					};
+				};
+
 				port@1 {
 					reg = <1>;
 

-- 
2.34.1


