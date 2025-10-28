Return-Path: <linux-kernel+bounces-873480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4FC14044
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3514E4664
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35714305E32;
	Tue, 28 Oct 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/RUqVnX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF82C3769
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646343; cv=none; b=oEb1fzBdArmqh2o0Sn1OpNe7ymzHCbyNlMWrHRa1+NkeFkxWoaIyB62xGYFNmOvQCn8rforvc+uxX4Ngb6ZlyILBRCMPt/rApmSHUrlevLyt7iWim7jLCaXuAcpQP79TlWLq8cnawvUztaEdCPWhB9Ou4hGKTZHH5R9uuJycCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646343; c=relaxed/simple;
	bh=/rV8b02lFbRn8hnY0VJDTTwq6M9xJWBmQ2RE2hCI1Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9xgdR+NRJtRRXHgXjb8sZtoCcU8L7b6dU5roFbQqRSE7nauNI9YXt/zPGnxSf91ynn2wfkcv9KIcShztNX9lpPfAjPOq9Tb1xfnKUIQJk4pR2TDxEFjvetk/Jkjguf8XHK4azvsOQc04ZgwXmErxu0hiR9R4lV17ga37t5fggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/RUqVnX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4A14N552508
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6AOYj+NGGeRZ7Yqf6v29L00+UqblIskONx8KDUVHi1Q=; b=e/RUqVnX6twUu1R4
	1SL5Y5v3qcICnszJ+UT0irCp/VoYOI/uNdB77jwr1x8hk/C4xNMnXfajzfuQWigr
	GR/Puw7ZXSjPVmMCYY0LWRjNN/s4REYi1Z9gBalYzlbtMkEABjCFWpalDhuenWJX
	SqTm2vS3LaPUv/2Un9ugR0IpIoxG6pWrkTizgHpXSO0DvvKTqnjXBTwI6zMHpQUj
	1OsDxRZZ5P5wTwwUqDU8yD+rq35+NU9I82sHItgLJPMB3KhynBWSNyb9Th5RfN0s
	jjm+8du6e7Jfy5iGZJCVK8TQIhhAkGkpNAkvxpSho0JtLVXGNMwJhx7XQ30WKjDV
	FmDAnw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjf90qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2909daa65f2so77169545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646341; x=1762251141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AOYj+NGGeRZ7Yqf6v29L00+UqblIskONx8KDUVHi1Q=;
        b=rlRwoaZLgHZFYXxGSX3tBdixS1SyrfH4sziO1qIr4Ed7gbHdt9+XceduNFeQl/FpQ+
         wllf2/U2FR/S5lagKu3QP6gU7Qm0OrnKZlKeQprjkxsAPHjewlHH2r14we01afFS1Q5h
         h+Wt9FKILJvFiOAZ0UpCqvpKbMRmHKVdCDkBXVkViQnF4tXk8eTOcFIJl/91eb3TBjqd
         EEzlH45OCMPHv/XW7jXv47q2VZyGh10TmWvwdU3Yno2eYjMcZpzecB/jQeUpmWbcvdvm
         RiD+34XBOxZwGJag/s72dJ66LaiqHHQB1zF4XvZTP0IPDq860HNmr0KwROy+cu5CjR3b
         Ob+A==
X-Forwarded-Encrypted: i=1; AJvYcCXduzcZTBoqFF5jTNeUe+xxobsf5BczeLGNnVXuzFyUyAYdYPmv2S5E9XSxgz3lkZlN12ZQ0f9hlh1mUdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZJi8hLINUA5njRHGABNAdrKvWTIvy91psGZELhPbtJ9Y12aY
	SseF34+lW/i7/joxFa3+LhZfTNyBBEz6hkisCYFeFaO0yTkwBF8DOzHMn2R4skV1rlRZ9f8ubDg
	rwA62Xcpqf91ltJfa4Oaruc/jyH9YeA83FDsZfc3a1Q/H+nveyEUcy0asqBcGNrCtzig=
X-Gm-Gg: ASbGncsAKnPzUyIKAgoAwsG6IKCcwQF3+Vd+kq609QTJ91N2it++wfa2Ek8vBBJM6Lt
	G2Mg/Ejl3IJbbH+2J0kC9cW9Qr9xeaaVfxbfcQYB+k+/bkD7aLc/JKI5hN/XFmdAivMF0A5k9WU
	fSjehUAUKIyr4c91GMJXmM/yk0q+Zv1zmlBXMsx3l2esSRwz+TzyPzYGjxLdQtCNts1GftgP29F
	3qE025eLrgHyiIHFa7yFnzV+p7LhZP7QxG28SocsUq0DrBZEdnPzDvSY96Xu9gzLLQMQstw4GpZ
	b+xWSCYRg6AKubNcyjWDvsw/BRVT/ycescR9FdLA+M+G/kYGkojOdX9H8F+KxaDNwt3o4IgpBCV
	sCV8tjRiZwUppZ95mQMj09hKvfFudiIDWvURCSAP45mWI1HRCClM0tKbiPw9Lfw==
X-Received: by 2002:a17:903:15cc:b0:292:b0d0:2ef1 with SMTP id d9443c01a7336-294cc722b29mr32133095ad.18.1761646340551;
        Tue, 28 Oct 2025 03:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQcK2UoPhoEuKHRrlWuWBy8+oO5uc8TBTCYd9RSa/HN7HmGG2vRuqfaewpomWa5UmuaODLLg==
X-Received: by 2002:a17:903:15cc:b0:292:b0d0:2ef1 with SMTP id d9443c01a7336-294cc722b29mr32132545ad.18.1761646339772;
        Tue, 28 Oct 2025 03:12:19 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf423esm110408755ad.19.2025.10.28.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:12:19 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:11:42 +0800
Subject: [PATCH v4 3/3] arm64: dts: qcom: lemans: enable static TPDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-add_static_tpdm_support-v4-3-84e21b98e727@oss.qualcomm.com>
References: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
In-Reply-To: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761646319; l=3216;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=/rV8b02lFbRn8hnY0VJDTTwq6M9xJWBmQ2RE2hCI1Ho=;
 b=NW8JrTq58ErqSr16wGg0PZvUE6ItBGloVWbTHohKLxaFebf5hWosb78ZE7f0jF4wGUAcuYMie
 pZa9rUTi8emBz2PUihhD7npvKKnpvnBjjSlHcaLEb4CU6TqJMr1/yvC
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=69009705 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_1kJojZ1I3LL_-Zbm_IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4NSBTYWx0ZWRfX65o2f0Fr/MD7
 FploZe6RHTxh1WpWxIvRyNhRGrWqEmLTO/i8Jx5OIT7zRguypB5DYEPAL6TUJOR8sVfchMi4xcv
 8lH6pT4E4ySpMbG/iNtGD1kPtpI1eYRUjl0em2pkpNQ7OcKXDQsmtFtZoEIU0B5GpcxhxN0fqnZ
 TUexo1Ax88qUfD5PHytYwYb9ds8HwL4ybSFeBfxZpSZI+6S8FLsoh33pFokEc6+aHSI4AuYi0rT
 K/cK+xLszESynVASAUQ4uQ2rS+FezLfLyCMV0zfqCnn7hY41WDeM+z/MildOuUpHSqqrhOYQrIE
 dN2fCFsMkh2N1GhxazQf7R17rUt6hrDrvviqZXKDvUvMwQAstU67sBfyB34sbLzLNiPyr3QmYO/
 GZlvKhRwAkZWpfQmMBinjEIXxHseTQ==
X-Proofpoint-GUID: fXJoCUxptjbAd5LIFfjEjcmnVF82Dya0
X-Proofpoint-ORIG-GUID: fXJoCUxptjbAd5LIFfjEjcmnVF82Dya0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280085

Enable static TPDM device for lemans.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24..8a93b353d11c 100644
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
@@ -8269,6 +8360,20 @@ arch_timer: timer {
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


