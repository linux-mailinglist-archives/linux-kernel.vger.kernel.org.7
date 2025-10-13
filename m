Return-Path: <linux-kernel+bounces-850009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25048BD19D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43C83C07B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70C2E5430;
	Mon, 13 Oct 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pWimpRKN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295232E2657
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335916; cv=none; b=KeOKIqAJ3S+flXVrkleEAcpOvP9g+aSz8OOJ+ejKpGfvy64kWnhhk73iW0uCDUq2zybRFTwbvud/6Pj9t8GI7ORMPogMK3EeTQN4Gqt9pceCygQCZzEJhxo0Dt4p8EWPamBocUGErEQyMznQaZaPY+uak02ZvgR5vYVri3trNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335916; c=relaxed/simple;
	bh=cM+KsUjm1CT8Q4hIp2dfJ8uGxYpJWqBu6GWePVipu+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI1uvLg6b3pIvnMy69XCZUa63c8g1wat3FG1TgFn87zdTQOO0Y0Y0I/C1DJzs/AwB+OWG/TIYRSaspWLkc3ED3FAz5oJgLI7p3LXvaymz+8aJRUBvUqA1NUMdroncEPCrJknecCfFikUguc08WOcsq6JXRs4fV4pYKZ8SS0LNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pWimpRKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nLja005394
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7oBQudR/weydsEbe0yzzrN3yEVj8ux7cDJxdvM4KdKg=; b=pWimpRKNPYoaq5Ki
	rCJvjWA8Az/60IAUzdV1kM68e/ogOMfoTaEXBtoYctFFl3z6hoW53KF/8k6nvl0B
	cgwC99TASopYeJN+9C/OYIMYNmVV2evvUy6qNCPtcsFLVfZpXeZQ7zKXXqvoHYE8
	l3HEqIn03LBK+HsgKpAJ88Nsm+IXgFilV9pnlG+oV3QWexLLNQ4VmL0CSHwtaFBG
	0ikkeHqeS3Mhkkgw1aNODZHwFL+A2Nep3ebGP+oALwBrl7lKOqGKI1C41826Uwy3
	BLHoTk5vOtb066geC7dbY+dlijMLvPuCaW3ocRlZ+wrEAJ8DVyhkaoKIdRQ1rRk9
	1JS9rA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbs3e8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eeb9730d9so84187355ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335914; x=1760940714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oBQudR/weydsEbe0yzzrN3yEVj8ux7cDJxdvM4KdKg=;
        b=iqlF3io3XvwwygCleMUbhNqEV4Ad4eDhLTNoL+9iwTisMvWGQvgp155M0LgX7zW3j7
         Wmsx/poUR8vixm8erz/i5C9ewOJhGYrtyzw178nAE5r31i/GkcnL3IVUaKWe50WFId9V
         bUXY2r3orimdG9cq9VNqsetgHAw4ZlmKQ1etGtseSwVO6qkPwv/8Im+YOubptAI1ly0D
         kfv4EsGjdl5wnaDfUh2Lx4ZjadgLuFxLLI4AU8Fbl/w2dNLjOUZ2cpjGGerD5t8a9L9Y
         QIqLciNG4r0n6/j5BX/rDFzv8QBxqWYSeQ8WEM5CxCHqBP7iJsNG8SCuPFpdcc0QsqgI
         0mNw==
X-Forwarded-Encrypted: i=1; AJvYcCWJPrPvMnXG0UCizZ8Rxy5bmaMV2PhEB8Fah4Xw08G96MuwMPYu2T5Ir2drpXCSovuuwEgzNrBRhCT2YHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIeV5B7LYbsdgvbq0SiCmvQ1UQLOjKlgYZYQePzKIaf2nhrxJc
	0F9nktkIgzE2mVEafI8PZ26rxzTCkCeKeE19KUWAEbX72fdiDJMk/0NiNl2mszoqRFMGOErIbqN
	GLmfPvp6oeLMKTqmbiMG8KMQpehi2KX9Jv+ojhsCmt8riMlyBj8GtAamdgYguStBJj1k=
X-Gm-Gg: ASbGncsNHjUIkbk+mmUwArJggU2q0zNkckCBq/zt02LktgzaYCNSj590JQVc45yzMzh
	C5WlBtcAKeHSHOZH+S5bS1d/Qw4hPu6mfhtWnxm1+PYD0OdDABvnUQjWghEW3aIx00YLSLLnsqi
	JRcBl6WdwG5qLnUuWuwpcc3zYhTe72JiBRxnXJNxeayO2ZuUL2Nj9tmKT75Z1bT+J4uoEj0hs5t
	ZudFoMqO3DdMKCIk5zbRD5MLLaSv/OkFfyq63kHkrZRpJuCvIJkA3vRE4/rocXvEkzb8EUuTEkO
	06AAI8sor4m02emiCWyE/bsxTb/0vn1a1HKaEGr9IScFaPcA5HNUznZQdAxg7lONbx+2tGBX9ww
	v/zB4NWU+tENNICRSUPDnU7tttRE=
X-Received: by 2002:a17:902:d483:b0:28e:78b9:5780 with SMTP id d9443c01a7336-29027402cfbmr279748605ad.47.1760335913649;
        Sun, 12 Oct 2025 23:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/7dHhAvuvDyMFASfG1nV7vjlwqk+Xg+aNfMfNBr1eV+CjzlR0oXaxFgm2QBXq9baxEEAPCw==
X-Received: by 2002:a17:902:d483:b0:28e:78b9:5780 with SMTP id d9443c01a7336-29027402cfbmr279748195ad.47.1760335913112;
        Sun, 12 Oct 2025 23:11:53 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2904f61a1desm64388675ad.82.2025.10.12.23.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 23:11:52 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 14:11:18 +0800
Subject: [PATCH v3 3/3] arm64: dts: qcom: lemans: enable static TPDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-add-static-tpdm-support-v3-3-a720b73e83db@oss.qualcomm.com>
References: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
In-Reply-To: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760335892; l=3216;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=cM+KsUjm1CT8Q4hIp2dfJ8uGxYpJWqBu6GWePVipu+s=;
 b=niUZtQK2sHWXXqAzI24xd1rCBjQ0KFEZ2P9GaHcYMlWkrf7WJmHFusVPyMcgZ2lb6bdsDJ6JF
 AnEHO6sh9GRCNJov/G9xDJJ8KLy+DDPZ/lqDpjSwep6tO4oqFqjL7d2
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1qnvIQ1FpmdG
 LWM0Pu+S/PL+5rzfVD2xf8Cb3VidpRPPHOYDVYI5QjQPUXv7Umcft3/ts1slfbFcZG6LFdrushz
 0N8Q2vIowqoW/HDQqts58uzJOVbuFvdI8Mbyrdn7DiniKzw2gf5MhG/xtdIgA8geSQvz9OQ5aoC
 xF/JGJrK48xxD6ggZgtddVzEwmnRPAKJp0BRZ19d0DsawAwAoKEqjNeldwp234aDKqgMGD/cjOj
 mKcrwEPJBe2b8XHTmE1l0gllYENZEkTfH59eU/4tokozomCENgFb5HYZ+L56/ebMk8msQPI7pzW
 FTsaJTDc3VKqO0VmrzeFGgEWoQoa33ITFbJiHmroJ0SPtmS4ohUq7/ikERkGcoV75KL7CZkrtFE
 k9HW9ELdR1NwR0Tm9JC7SZps3XrCGw==
X-Proofpoint-ORIG-GUID: j_UaS6twjYYcVH1xYdr6WC6KOF2jKcki
X-Proofpoint-GUID: j_UaS6twjYYcVH1xYdr6WC6KOF2jKcki
X-Authority-Analysis: v=2.4 cv=U7SfzOru c=1 sm=1 tr=0 ts=68ec982a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_1kJojZ1I3LL_-Zbm_IA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Enable static TPDM device for lemans.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index cf685cb186ed..3646e2347068 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -2961,6 +2961,14 @@ funnel1_in4: endpoint {
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
 
@@ -3118,6 +3126,60 @@ etr1_out: endpoint {
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
@@ -3390,6 +3452,35 @@ aoss_cti: cti@4b13000 {
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
@@ -8256,6 +8347,20 @@ arch_timer: timer {
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


