Return-Path: <linux-kernel+bounces-882356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1077C2A403
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0254EEB8E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F929BD90;
	Mon,  3 Nov 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FynWYY6f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T9dpvIR5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5129B8E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153616; cv=none; b=qHdLW//DR8LQ2UzXlL+bKs5IS+kmYQp2zmWrUrZqMe0r5pEOt0b1tzbn5uuzcxnr7UcZX+8UAAskTNEpnIwFAvN4K4xLoVGW5EKLymvpqcNcSgfHQKu7I06nqTGpnagNfQOp1xGxE8TUWXf75ElD3d60JMHgxgM1NzaWXkmYLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153616; c=relaxed/simple;
	bh=jPRvo8AxN6ZXO7cz0KQaS/sv2ld0a4D/+sFPdm3cEx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3ow55rpHB5opCo44gYP7GG4YJyqrPaqZdFRHHS5BYM7S1Mmjnm9V14D9Zt4NAGLkvI2Yf24OLPSwT24dvNQYJxWb5LNh0puJzcy3KpK3wAisvJhK+j7eoDGiY7ZLIb4TILmrxggZ4BescwkGIDwb+08PeY277zboJJXw1CvPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FynWYY6f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T9dpvIR5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2He23r925731
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 07:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11c3KbrjHPgiU5BclHH5SfdYsQYYwt21sbw+FWikq08=; b=FynWYY6fgsE7lM1b
	1yx33gZKolSlLLfQF5/ByEl61T8AoYvPWEKL68uJuu4X4yN+Os/0m0qWfEXNFQLx
	IGzJfIfCy2w6QLBFIHkRbSTf69bbzlXbblRIApme3HchxPUZoESre0SjTNPGJZcd
	78C+7YXwpc3A2K4Ie1CeBNTeOiqJ6v6asekgn2D0WrEu37P2i6nAUn2PaYGMGuhS
	CgzyfoL/Pgbir5yEBiURL2/RBFbxLZDEljUUxeizU96GV6z1/eKQtBJ4pyv8R0aj
	DdbS4KJ6nkcl8vhMINq2j5JCvqGnTAy34KAQrG0jopy99w8GUUI68+IiH6rNdp/Y
	0DzwCg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977bqp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:06:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3408d2c733cso3319311a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762153612; x=1762758412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11c3KbrjHPgiU5BclHH5SfdYsQYYwt21sbw+FWikq08=;
        b=T9dpvIR5aTS9rDeqpBVpcgyAh+sz1o2MqolX5jIMvBNP/715iehDLQWy3FWWAVetoM
         wSd9Z6dWy3/8/q7f7xWRWz27aWIBgTQd311ST/aYHkTrr8tJZLvVJri1B68bVuunxzYv
         GpMMrY9ugMGLuQGRxZQ4+0PomrA6hl2zUvsuNTHL1qyOt5BrpqiDLytAiolBGdHEdpUa
         VbbtUWO+j1ScYnbgPN1jx9k0+F/tN8WwuncSLCw8/pywx5lJGJDQ8nLBNbR/XpeVPmXt
         0Yl91ZmyAu6GO4q2uVNrllC3QhGAJNOLxOAAYZ3CCkn3tgpjY3Ba+4qryYzciMLfFa4X
         b6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153612; x=1762758412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11c3KbrjHPgiU5BclHH5SfdYsQYYwt21sbw+FWikq08=;
        b=Sfz5NGZLzl54p+x4Pw1EHJXbxT+WiJx4kyAfxk735UF3/2ye9+IjRnk2qYo0rDwbS9
         vRJolUspQAsjzzl/WqQrahKa30oVHbE/PL00w19m452+izQTh/ohoS0LCq/QKywdOJt5
         OMrZuAaIqN7YtdrMS9wHVx/ppXjr6GZ5JRqJ/ABq2W5NoUA/qm8G1PJofQ4Wbvc9ah7w
         FkpKw53aVkgnrcHp9s1r959cmZCqo6qW7hwZhLFlpbjTCsn9eSiV36SnQ7NvSjNCgNGO
         O3HApWmbR7KVQGnk6cgepkuWt8pTGz0X5lmpUJceilQHo77t6eZpWr5/LyZ00Jk25PYN
         YJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo+2WZqRv+zTo4UJ0IRYXEkZSNuSe4vGfzh8AGtRUIq5xHj5ktf3dNEjZ6e7Pgq5PvVDqye6G9JziPoCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QkRtYms2kcA2z4vqUjbk3EJx6e0OiSyc4zDH9RtThGbDqHrE
	+EjohPO1tvBT0t0hYR2LwSav1GJFATUy4N43QplAmMxKThBCX79ya/of9krsXlrIKJ1AG9uwh3E
	h7ckrkyRWC1eooFhzKzuMJ71FiYy/KU5BAnOGs11L7YVyRf282qdFW1Jpgdb4V8WbJgc=
X-Gm-Gg: ASbGncuiiXT9p7goU5l2aDlEyujZRauvfV28ZV8tNYsTd82005K5Dv3gIAqGy3DcR4z
	X/XWBuq7Jcz9BD7IQ1xg03EB3IWc6PO/0tmDJIl1zgU63FpDg384h2yFkokb4MeSXG8Y8y94bUS
	aqKeOyU8X2prc4WKurIikvTXaqjzYdunwLal7pTP0NnQd/wOMfl/yS9u6B8x7RpJV51Vyd5UamQ
	FXjURMUr4x18z1eZXjcuyp6Fq5I5K6QkCSYBuRLgxN8Xd4qlol6zM06YegCV60Ix82LpVFkAbzQ
	U97/dtBIXuV/lMN6RMeBGgRjsiZhXqvOIKU782MM9eCMl3RMP+6o3UNuNsErmySWUJiqnLFSLkh
	rS85LuAIO++jeZqO+LL2Gm2S3V6Rmahoi8dZvfEVZIkKEPU+x+tszhN8/cV+OeA==
X-Received: by 2002:a17:90b:3512:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-340ec6f5cfcmr4480126a91.2.1762153612388;
        Sun, 02 Nov 2025 23:06:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0l22Dq0T/IasETveP/YFptHxCxmhpbzcfOxByTl+bEQYHpqub71iYiBm4TLNep6pPcUNFKw==
X-Received: by 2002:a17:90b:3512:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-340ec6f5cfcmr4480094a91.2.1762153611843;
        Sun, 02 Nov 2025 23:06:51 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef49da8sm5808704a91.1.2025.11.02.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:06:51 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 15:06:22 +0800
Subject: [PATCH v4 2/2] arm64: dts: qcom: monaco: Add CTCU and ETR nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-enable-ctcu-for-monaco-v4-2-92ff83201584@oss.qualcomm.com>
References: <20251103-enable-ctcu-for-monaco-v4-0-92ff83201584@oss.qualcomm.com>
In-Reply-To: <20251103-enable-ctcu-for-monaco-v4-0-92ff83201584@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762153595; l=3931;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=jPRvo8AxN6ZXO7cz0KQaS/sv2ld0a4D/+sFPdm3cEx0=;
 b=UiqqFcnAt021/IodBx0c94um0OoWrMu9IazVSkrxBTI7ECq2bmxESxKNtPy2HBGxA2THKlqzD
 jgtTLzuRmbqB+xdzThilAsdrQR8916cbhK6E8e9YDFn3spYBbQw7eMA
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: lA6taMKmr6nWgoNtqTQDbLm4eRMb47FV
X-Proofpoint-ORIG-GUID: lA6taMKmr6nWgoNtqTQDbLm4eRMb47FV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA2NSBTYWx0ZWRfX7OEeF1u/nyy0
 ByEFSc3UBsCQlveOJ9P3Rr+ibOz+XaYnl6mQNdFE7sIT6o+Pj5W/DYB+to87R1a/a6OXEDXgBOW
 8vr6B+OYKiA2YEtrfr8d26lQBSb/QsUaoNqMS3z+uHweWkZOqCoFNV0AUXvcuE/PvP3RZHJ3lmo
 wymj2r/9uO3HcCdLe5u8a845dcunmUl/+uDS08f8OMtKPr1NZirVK4dqJofGFHM8yfPOQSa0pPJ
 S861qK41fnP/VFR341fMNAX6Kyf6/hhlb+3BER5Wa3CGcmfOQa9ZtxygIUbL64o8Jis6mxi5oAA
 isImFJL39SLOe+QRtiukA3SgfeT32gDN0pHaZzKkzCpuIgWZ0gQy5BRTq6ZnaswDYuCktbi043T
 zqiRUlQZ2VPdrJ/l4D8bRcRNgBARzw==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=6908548d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=xJyy5nzPNu-aANFJA0oA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030065

Add CTCU and ETR nodes in DT to enable expected functionalities.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a..1966dfad2dcc 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2483,6 +2483,35 @@ lpass_ag_noc: interconnect@3c40000 {
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
@@ -2677,6 +2706,122 @@ qdss_funnel_out: endpoint {
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
@@ -3106,6 +3251,14 @@ out-ports {
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


