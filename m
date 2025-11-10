Return-Path: <linux-kernel+bounces-892607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB9C4570E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0B3B39FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF572FDC20;
	Mon, 10 Nov 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0qE3gZS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LaFAHx+F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE512FDC22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764630; cv=none; b=jeKkouuwIavCWZLYDbkICqWJr5kkJd+Wt3zn0aakzzLG+fd/oSK1XLjowquLGX3cau/HFGmBrYcqXj5OYTiUeWNsr3Fb3KzVrf/R1wpDA3OniMIJSZK4U0tnLnzpMkt23AmefNBCAcZLFiEj7lzW+HkkrVYbGhoett4F01jPNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764630; c=relaxed/simple;
	bh=YQULvWXIj1x9ufK1mpHrkLVEKt4zYKeDM3h2lSn5UeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/g3qXp3tubX3LBob13UTcQvjVH3Yx1o3BBIBGvaPITNG66Gyh9gphnRZQXmaxKyNkPYnIaIV95odPaQpyfKz4fXLw+l9N8xrvYCv8p6OSu7+Jx7KDO6rAUMy0BAJZRE9Gu2rwYoJzxB0vTL1KxtqF+WUoHC5YvqapRtR0EyF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0qE3gZS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LaFAHx+F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8IZBw1365050
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yKLzu85jaUL
	/+O5SNLEN/HKd5eW9ayVnpB/bCsypyP4=; b=X0qE3gZSkbj9vdGKgAhbvJEN6vP
	IP6m3az/i7vwxb4kBCM9JY76s3iKR1mTsi5+0U05nOPYDl+AsowD++fNAT/ptriy
	bDNm6MvWJaWzjw4eMKsoWKAAZP45hbszlimryfcurF/kJMSSUHheZmpea5FiVXOT
	U4fzPPTkrz0ykzXeGJSan70tZHB97FGEOBN3Mu1A+fcpQ0Ad5wTwU0YGtyGkpSSG
	zcCk1gGcg6Uj5uvAmrcJLOmghb7uKi7vv/SB8HzzafHxdaGFPV1Uc0TrCPbtHc6X
	aunJgDfyu1Vm3SUNGxrVw+hOBpnx6FxZpg61b94j6G3enGG2AZ7sLwt23YA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab2nxhb7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:50:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295ac7012acso15900925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764628; x=1763369428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKLzu85jaUL/+O5SNLEN/HKd5eW9ayVnpB/bCsypyP4=;
        b=LaFAHx+F6BIntdCquf8r+N6asRUwSS27tOhtXrETLumKJNELBingYRqMKiJFrC3Toz
         UPFOySLY3VBBDIjQG60N2vFO5LhT1ycqDo3kOsblD6xkQOa5LajoX1vN+UFoYBzdY+uc
         GwUfqW90vlbNsnkNg4jlssmEzig7OgiGkyiXXc5h9bpHzE4UPmVOyoEdNGBKM9AfkNjF
         HQbssrjFk3huAOfPYonMgWIIApONOyjyMPy9uY7sleXoX0+oc2mqzuriAWV8rnRpgDN4
         rGL6TUc0oVzWWNPZYHwK9OxUtBOz9Rg2eB1Cn0ggN6188USHpkWwnd2MZeB8Mb8DG748
         tIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764628; x=1763369428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKLzu85jaUL/+O5SNLEN/HKd5eW9ayVnpB/bCsypyP4=;
        b=p4CQ+XbxybVVXS+aMyaDbrj2lIhq84sPuf1gMM8Y4Gdnd4uK85gdrUJkCs1BeCoRQU
         SBC67SXHBzUzKV/sDR0h7UYtZoYIXkni1zbxaWrQA78tFMV/KcCyzd4W0td/RT6Chxy3
         jUqgDIKv53jgo4yVjz20fyUc+xIMBD0tuy/x6oqGA/N9SH5uXowY+NF+4BL9zn1i45Qg
         F9/cgdNiFl2ZsJrb9QM12vyKMkYA08aiJ2Bh90r/NMeZ9PDv8B+BRipRG367XR+U439r
         GnP2Q+/c+viB1zzi6RaQpKRgC0YooTi7By2NZgDsyz2497aVP/JRZk9ZeIkXDI+S/6KZ
         TWzg==
X-Forwarded-Encrypted: i=1; AJvYcCURZb/PR6HjkbzhmyKPCQVIpYbxc8HBZy354NWCn8W9h2pmv39aWSHOAor7EJS+bJI/KS1wawIWzNZvx5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrCshyFT+H07xUa2mbZqji6w+NLH06VglmLgwSfeburRv+Q31
	kzycFi2ftmKRvPJC1Q5OJuj9ALGQe9YCm2NujhUCrlC0i7H+GvCSjdv2/ZeRicS9LE3hxE+FmF7
	x2I5MZkP/BEaJ/GFnz9buUDYh6eFxpCBx/hHarmGl6ANzCIyIrAcPY4I1Th1QSUXESQ==
X-Gm-Gg: ASbGnctn/ONRHRChga8uccJY7+u0eveipC1QHI2EbCLxlf8rbaJXki4o2bhQYnMaBs8
	/hQ+qeZ/MxpHLYWYM7jdyr8nDglJyOwxSBcS26xjbq8UHalpdLZEU+/UGi1b5TcHHZLnV1PQ8ND
	Cmv1glc9Wl41mn+Zcm7+C9gxUuCmCDSyc+jdbpNwu7GPHMo+KR9PbCTuHP9g5wwuK5M91+S4FKR
	HNgt9S6GoaRZltVlp/J9EgzcDei9hImFV49dDiYFPivEhMly5XKdzF4nkCPfLcfFHqfBwtYRbv2
	3yaj8QYxWezRVLxdwtlCyselRqgnNdDkykxzdMr0PRey7sZL1CwkFq7oHoldYADuUHByVFDY0BR
	/mps5YdDADgaW/3/OqiXewEgH1tiGUg==
X-Received: by 2002:a17:902:eccc:b0:272:2bf1:6a1f with SMTP id d9443c01a7336-297e5657e71mr54354995ad.4.1762764627957;
        Mon, 10 Nov 2025 00:50:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYiDplfXjD6F3e7OdfDGmoNHYS8BiclFTivQKXe3d64dP2nibKnJ/RUAYYB8os1L7ydoFyuA==
X-Received: by 2002:a17:902:eccc:b0:272:2bf1:6a1f with SMTP id d9443c01a7336-297e5657e71mr54354775ad.4.1762764627483;
        Mon, 10 Nov 2025 00:50:27 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f94fsm138691365ad.40.2025.11.10.00.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:50:26 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V4 1/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
Date: Mon, 10 Nov 2025 14:20:11 +0530
Message-Id: <20251110085013.802976-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110085013.802976-1-sarthak.garg@oss.qualcomm.com>
References: <20251110085013.802976-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KJdLMLRicdtiLJ_rcsPyM11gK-NUYa8j
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=6911a754 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AsSGxY1rZHGoL8xKvT8A:9 a=-28uLqxQgLFJUJnP:21
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: KJdLMLRicdtiLJ_rcsPyM11gK-NUYa8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfX1QTLmKc2X9xZ
 LbUp61V0UDLrqMe2A2WWdh//bbceqsYCDepDQmtz4Ekb4Y78vada96o86tHxoYjmD1kqwf2HdQR
 Kyh0nwbNV2FMDDmvKmVyhCqIcBfyMkFr65NqgUeXmT4T+UzdxbEQhYZI9UpXTxZhuIUci9/N74H
 wBSkjoMivxoWjZaqA3KA98+IggxE6QPzGWN6kWppLwmKOLWoITLwD9RTUSbALYLN3a3E3kECi6c
 jCoNZ3KqboJrs8mGE+94YUqo0dxslFZB/pJSt3yQLn8dL3j+Y8C6QSuU6nEi6meraUgFmGNM5nc
 g2ioVG0xcXb7wO1gI8DfSYU0omFFsaMXkk5YKn+ymT5wPlrqyoegVRrRPJJnKRZHbiBflWUcIpp
 pBtOlWAFftm4cGJDEjiuosV9gAP8vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077

Add SD Card host controller for sm8750 soc.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index a82d9867c7cb..95b210fbfead 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3482,6 +3482,60 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x08804000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			iommus = <&apps_smmu 0x540 0x0>;
+			dma-coherent;
+
+			bus-width = <4>;
+			max-sd-hs-hz = <37500000>;
+
+			resets = <&gcc GCC_SDCC2_BCR>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,sm8750-qmp-ufs-phy";
 			reg = <0x0 0x01d80000 0x0 0x2000>;
-- 
2.34.1


