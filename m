Return-Path: <linux-kernel+bounces-873125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F3C132C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54507505F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF82E22A3;
	Tue, 28 Oct 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6vZSQL5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561002E0914
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632919; cv=none; b=Oz8jDl7vldtKvG1NDxUGCK7hAFQiTZOjkyeCPMcljCp7pqpUUT2x5FPpIIe602rKiHmKnn7JrPL0G8heW/kOizY3W2oZBekyio4Fpyb3A57jplNeasuN05eNxUvV404dDjzenqCxCoMzLzQyhAb60BVPPB4X+8i5pbfkmZafYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632919; c=relaxed/simple;
	bh=OMJVWvctaf/jehI7hOKPGAqI0udn0MwJRTHWVdjf3sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hs/Z3Hg2wq/tUE01AiNyhSppqFPluOTZKPnyNkre9i0WHJRqcQmMyNYonRhliCVU+q7UB3ldRUPU3SOEL0ES7/72TkYlV+vq9gkFiG6JwegLLfOYxr0bBJeFUvoHtWlfVPnrZnKaPkAeNqDs1yn/XnHwjONFdHTJZ79ioFhcb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6vZSQL5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S3B3FU2232270
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YaZgNUsoK/Ovbts+heLvAayjgu7szxKqoivYDa4ZRjs=; b=c6vZSQL5GMNiXP6i
	8GYqDbPkj9mIh7oMPS+KJHb2aOmmpKxMAYYxVqOhwIePYyrzqcB3Dsfx1DXhO1t6
	EwlSZ2+tLScZHGPYwbBjVj8oGFd9qwDn+YyL5NxennIGdDCGaW8kxPwpIxZDNMm5
	LpQD87lBgInJs0Dj3Ya9aaqrHpvQKV0ZZ0CcOU+DDXmtTummUhLSLomNd18K1eBe
	8w5PnRe2oQz5ZuhqdQdI1swj/cylVjsr3mP6mBugwae9j/A6nGDn8u9+XbeC96YM
	d8RFY7/gBSt6PUM2a1che0jTNJptkdJ+OqI0opObPij/KWGSPKWLYg8FRqLlbMkz
	WnoXkw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wnbmwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28eb14e3cafso110297005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632914; x=1762237714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaZgNUsoK/Ovbts+heLvAayjgu7szxKqoivYDa4ZRjs=;
        b=eRatVPgGrBdicGHnmBormrivMGFMzavGfZjPFRLkSHFYQItjT3NmvOSMRAjRZrJP3H
         5bmg7WitahfyqF0MjekenRu4Dnr8YHEAUypmpWeKivvFJbqsO5w1Cx48mbK82eLhKMaA
         s6yCt45fBq8ythkkYnMU52eMzJStxN6bWgzbhJiwg79bK+SFgZdi59NB04aYmkEMIz6h
         kOa7rEyL2mR8IXe/wt3Kak/cpLuKAbK7dBkyV0t8p0IUDNtuO1dH0f1iI5WKmXyMwbLy
         uTwiMQRazqknct0H41aco8SUQiyYSRkraNVKaJyW1YG9BPKTJTDjVYYz/WrvF5kGI3OG
         vuUg==
X-Forwarded-Encrypted: i=1; AJvYcCXfWBXIAQ9dEc32ForQiC1SO1AscfAFJBqsnzEA4qrIL9noq2KYKoV6DyoBDLIchNEEzaidg0Mo8wJvFlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaHY4nhTceD8jHeRIqJ3FhRsbGHXZdM3NUMM/0Fx6HNyLXGTr
	GSChoYHYmI0wL2/s8nQ5urJnAcHfonD2oxEiQuvPQe7Rhd2kaxFf0YkQ8kHkDTI5M1BQpH2i4om
	HzTzpXt1NgXR5Yl7pIbuz2yA+6qqDpTA2dshRRWQY84c/6fExd64jr3Ozx84Ku5LeHEJpioDi09
	3wXQ==
X-Gm-Gg: ASbGnctC9It+a0a3KoXewTtYh5+DTfx8gTj0vg29al3uvDq0zRdgCTGzhroleyVl2Ap
	9sP6vcmEUdEV1rPF5Jgo4b9Ab9hduDHvzVoGTOrlty6gNjMwaHvInDDhORECjfGe6poTZ0xOuld
	puX5EeDTWSKqRD3fqA51QfmK0HMp7WDnv2PPpwEZH1Ram0sfIYvd/wFvQTSEE5/AH41QU2aTDUQ
	2TL9nHkBtDt1dPU+FJDiOZWEGBkfeec2hVKiBz0VJRcgZJRR2F7XGixbhKVtNUsvQXetV3DWSiP
	fdCeA308V/f1fP7ONqnfQ0w9lSCPPu8FXyhOQD53nTbEmga67U3M6WrXR905ULfQoG0zBIZAgFA
	kkxfGHF1QHanuS2roJYytORzV0IJT8ufGQ9Yec0CcgfAV8kSgTkpbJmiD
X-Received: by 2002:a17:903:22c1:b0:286:d3c5:4d15 with SMTP id d9443c01a7336-294cb524ebamr30677595ad.36.1761632913880;
        Mon, 27 Oct 2025 23:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeNsRVXIiisXxFlksCrtzl2xo1re/edBVSUCRuEZKVFeHbiKCDyQFxgqpaCmyE4mf3PxGEow==
X-Received: by 2002:a17:903:22c1:b0:286:d3c5:4d15 with SMTP id d9443c01a7336-294cb524ebamr30677135ad.36.1761632913341;
        Mon, 27 Oct 2025 23:28:33 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:32 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:14 -0700
Subject: [PATCH 12/12] arm64: dts: qcom: x1e80100: add Coresight nodes for
 APSS debug block
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-12-31355ac588c2@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=18913;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=OMJVWvctaf/jehI7hOKPGAqI0udn0MwJRTHWVdjf3sE=;
 b=8B2ejYcA2Z4zW++Z36CzupWjsNp/k7HGXk1uaDaWWOdG61j032t/tGxE/IzQdGWu1F9Go8u6X
 jwoUwDxzf/KBW7O6Ca2QZGPzZVOMfsgs1zZJ8VNNXfswGzSRaMbeBkQ
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=69006293 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_9YiIY8xfo59NaDcWFUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: TScCqtxOIkQPTHqJ7EMzBQosTaNxXCpe
X-Proofpoint-ORIG-GUID: TScCqtxOIkQPTHqJ7EMzBQosTaNxXCpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfX/Tj06fvRYvka
 moBVwhDqW9AZrh0jEFtOddLfN9pUuensSShxO8EPhqHJosUivuErQLSnEBI8ApbmCetkMK2ejQP
 oPcelsYZkYCRtFM1AeE9oEVFuoHve8bD1Y6o8P8UvbU/h/drrhw4vV2b7G+4fL8k37+fcz3HW1j
 6CdF1PtHP/XD6Jave1lYeGUSZDk3lMZ33R1rGUcJfQMi5+sosrHdXGd177GlZcS+6NUiPR/rYZ4
 zB7g3bFVt1gworwRXfJ2WfNFTueeDM7QaJQaTo56QXrSS3z/ZcV6zUhVsHnMQVw+Mu6ilA6iWpz
 3woXlf8HPCZg57yvzdGJE4w/+jRfhNbaKc4/gi9Q0MSyfhqW0Vgm6YZRp1V2skgNNLNhE8YO+YY
 ANWLo3qDA3GyiUIrM+f23h++P+IbgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280054

Add below Coresight devices for APSS debug block:
-ETM
-TMC ETF
-Funnel
-Replicator

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 885 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1p42100.dtsi |  12 +
 2 files changed, 897 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a9a7bb676c6f8ac48a2e443d28efdc8c9b5e52c0..9058ea8ce62c706667b931a8f4c2e7c666c6bcc4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -6597,6 +6597,14 @@ funnel1_in2: endpoint {
 					};
 				};
 
+				port@4 {
+					reg = <4>;
+
+					funnel1_in4: endpoint {
+						remote-endpoint = <&apss_funnel_out>;
+					};
+				};
+
 				port@5 {
 					reg = <5>;
 
@@ -7887,6 +7895,883 @@ ddr_funnel1_out: endpoint {
 			};
 		};
 
+		apss_funnel: funnel@12080000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x0 0x12080000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					apss_funnel_in0: endpoint {
+						remote-endpoint = <&ncc0_etf_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					apss_funnel_in1: endpoint {
+						remote-endpoint = <&ncc1_etf_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					apss_funnel_in2: endpoint {
+						remote-endpoint = <&ncc2_etf_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel_out: endpoint {
+						remote-endpoint =
+						<&funnel1_in4>;
+					};
+				};
+			};
+		};
+
+		etm@13021000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&ncc0_0_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13121000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&ncc0_1_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13221000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&ncc0_2_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13321000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&ncc0_3_rep_in>;
+					};
+				};
+			};
+		};
+
+		funnel@13401000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x13401000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					reg = <2>;
+
+					ncc0_2_funnel_in2: endpoint {
+						remote-endpoint = <&ncc0_1_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_2_funnel_out: endpoint {
+						remote-endpoint = <&ncc0_etf_in>;
+					};
+				};
+			};
+		};
+
+		tmc@13409000 {
+			compatible = "arm,coresight-cpu-tmc";
+			reg = <0x0 0x13409000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				port {
+					ncc0_etf_in: endpoint {
+						remote-endpoint = <&ncc0_2_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_etf_out: endpoint {
+						remote-endpoint = <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		replicator@13490000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13490000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				port {
+					ncc0_0_rep_in: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_0_rep_out: endpoint {
+						remote-endpoint = <&ncc0_1_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		replicator@134a0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x134a0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				port {
+					ncc0_1_rep_in: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_1_rep_out: endpoint {
+						remote-endpoint = <&ncc0_1_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		replicator@134b0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x134b0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				port {
+					ncc0_2_rep_in: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_2_rep_out: endpoint {
+						remote-endpoint = <&ncc0_1_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		replicator@134c0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x134c0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				port {
+					ncc0_3_rep_in: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_3_rep_out: endpoint {
+						remote-endpoint = <&ncc0_1_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		funnel@134d0000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x134d0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd0>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ncc0_1_funnel_in0: endpoint {
+						remote-endpoint = <&ncc0_0_rep_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ncc0_1_funnel_in1: endpoint {
+						remote-endpoint = <&ncc0_1_rep_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					ncc0_1_funnel_in2: endpoint {
+						remote-endpoint = <&ncc0_2_rep_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					ncc0_1_funnel_in3: endpoint {
+						remote-endpoint = <&ncc0_3_rep_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc0_1_funnel_out: endpoint {
+						remote-endpoint = <&ncc0_2_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@13521000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&ncc1_0_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13621000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&ncc1_1_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13721000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&ncc1_2_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm@13821000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu7>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&ncc1_3_rep_in>;
+					};
+				};
+			};
+		};
+
+		funnel@13901000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x13901000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					reg = <2>;
+
+					ncc1_2_funnel_in2: endpoint {
+						remote-endpoint = <&ncc1_1_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_2_funnel_out: endpoint {
+						remote-endpoint = <&ncc1_etf_in>;
+					};
+				};
+			};
+		};
+
+		tmc@13909000 {
+			compatible = "arm,coresight-cpu-tmc";
+			reg = <0x0 0x13909000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				port {
+					ncc1_etf_in: endpoint {
+						remote-endpoint = <&ncc1_2_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_etf_out: endpoint {
+						remote-endpoint = <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		replicator@13990000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13990000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				port {
+					ncc1_0_rep_in: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_0_rep_out: endpoint {
+						remote-endpoint = <&ncc1_1_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		replicator@139a0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x139a0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				port {
+					ncc1_1_rep_in: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_1_rep_out: endpoint {
+						remote-endpoint = <&ncc1_1_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		replicator@139b0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x139b0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				port {
+					ncc1_2_rep_in: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_2_rep_out: endpoint {
+						remote-endpoint = <&ncc1_1_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		replicator@139c0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x139c0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				port {
+					ncc1_3_rep_in: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_3_rep_out: endpoint {
+						remote-endpoint = <&ncc1_1_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		funnel@139d0000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x139d0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd1>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ncc1_1_funnel_in0: endpoint {
+						remote-endpoint = <&ncc1_0_rep_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ncc1_1_funnel_in1: endpoint {
+						remote-endpoint = <&ncc1_1_rep_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					ncc1_1_funnel_in2: endpoint {
+						remote-endpoint = <&ncc1_2_rep_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					ncc1_1_funnel_in3: endpoint {
+						remote-endpoint = <&ncc1_3_rep_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc1_1_funnel_out: endpoint {
+						remote-endpoint = <&ncc1_2_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm8: etm@13a21000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu8>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm8_out: endpoint {
+						remote-endpoint = <&ncc2_0_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm9: etm@13b21000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu9>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm9_out: endpoint {
+						remote-endpoint = <&ncc2_1_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm10: etm@13c21000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu10>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm10_out: endpoint {
+						remote-endpoint = <&ncc2_2_rep_in>;
+					};
+				};
+			};
+		};
+
+		etm11: etm@13d21000 {
+			compatible = "arm,coresight-etm4x-sysreg";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu11>;
+			qcom,skip-power-up;
+
+			out-ports {
+				port {
+					etm11_out: endpoint {
+						remote-endpoint = <&ncc2_3_rep_in>;
+					};
+				};
+			};
+		};
+
+		cluster2_funnel_l2: funnel@13e01000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x13e01000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					reg = <2>;
+
+					ncc2_2_funnel_in2: endpoint {
+						remote-endpoint = <&ncc2_1_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_2_funnel_out: endpoint {
+						remote-endpoint = <&ncc2_etf_in>;
+					};
+				};
+			};
+		};
+
+		cluster2_etf: tmc@13e09000 {
+			compatible = "arm,coresight-cpu-tmc";
+			reg = <0x0 0x13e09000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				port {
+					ncc2_etf_in: endpoint {
+						remote-endpoint = <&ncc2_2_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_etf_out: endpoint {
+						remote-endpoint = <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		cluster2_rep_2_0: replicator@13e90000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13e90000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				port {
+					ncc2_0_rep_in: endpoint {
+						remote-endpoint = <&etm8_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_0_rep_out: endpoint {
+						remote-endpoint = <&ncc2_1_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		cluster2_rep_2_1: replicator@13ea0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13ea0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				port {
+					ncc2_1_rep_in: endpoint {
+						remote-endpoint = <&etm9_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_1_rep_out: endpoint {
+						remote-endpoint = <&ncc2_1_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		cluster2_rep_2_2: replicator@13eb0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13eb0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				port {
+					ncc2_2_rep_in: endpoint {
+						remote-endpoint = <&etm10_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_2_rep_out: endpoint {
+						remote-endpoint = <&ncc2_1_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		cluster2_rep_2_3: replicator@13ec0000 {
+			compatible = "arm,coresight-cpu-replicator";
+			reg = <0x0 0x13ec0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				port {
+					ncc2_3_rep_in: endpoint {
+						remote-endpoint = <&etm11_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_3_rep_out: endpoint {
+						remote-endpoint = <&ncc2_1_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		cluster2_funnel_l1: funnel@13ed0000 {
+			compatible = "arm,coresight-cpu-funnel";
+			reg = <0x0 0x13ed0000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			power-domains = <&cluster_pd2>;
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					ncc2_1_funnel_in0: endpoint {
+						remote-endpoint = <&ncc2_0_rep_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					ncc2_1_funnel_in1: endpoint {
+						remote-endpoint = <&ncc2_1_rep_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					ncc2_1_funnel_in2: endpoint {
+						remote-endpoint = <&ncc2_2_rep_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					ncc2_1_funnel_in3: endpoint {
+						remote-endpoint = <&ncc2_3_rep_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ncc2_1_funnel_out: endpoint {
+						remote-endpoint = <&ncc2_2_funnel_in2>;
+					};
+				};
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,x1e80100-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
index 9af9e707f982fe45f62a9420b1e6baa1fef4d2fa..9b5fe04ed05cc33fe6d0a3535648d318f6cc3a80 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
@@ -19,6 +19,18 @@
 /delete-node/ &cpu_pd11;
 /delete-node/ &pcie3_phy;
 /delete-node/ &thermal_zones;
+/delete-node/ &etm8;
+/delete-node/ &etm9;
+/delete-node/ &etm10;
+/delete-node/ &etm11;
+/delete-node/ &cluster2_funnel_l1;
+/delete-node/ &cluster2_funnel_l2;
+/delete-node/ &cluster2_etf;
+/delete-node/ &cluster2_rep_2_0;
+/delete-node/ &cluster2_rep_2_1;
+/delete-node/ &cluster2_rep_2_2;
+/delete-node/ &cluster2_rep_2_3;
+/delete-node/ &apss_funnel_in2;
 
 &gcc {
 	compatible = "qcom,x1p42100-gcc", "qcom,x1e80100-gcc";

-- 
2.34.1


