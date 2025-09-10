Return-Path: <linux-kernel+bounces-809789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C4B51212
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D581C8134D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEF311C32;
	Wed, 10 Sep 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/8wN+Ag"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352731329B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494991; cv=none; b=u0Ajjmd8D0S6G+cPPI9YC7ytV7MRdYIiax/+kL9mIQxH4soOCsjjhh85gz0ZiqsNXqFEtCW59M9JHrlvNA/jYXytkyLfu3mQVlWrBDwtGd7qFXcgkaNiRSqKKObYgh/HDzv6KVTJikd0FBkYkGgnJrK19lrUWzJYhDAF4fgv7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494991; c=relaxed/simple;
	bh=cdjypD0GQ90BYFaF0mM79sUabNOmmrylx+82LPmHlbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ro0PgAtJRki5QhNtiKLucSYSqZSNjPshhTHJXSPWkGlAE+ow3FxeORmPVoD1u6IoD2qYBZan+ZXWrt6TAo+dCJjcy+ORx1r0e476XFA9QFhTqAtwDHJuvE8WkWipu5IenCYVX/VgO4wwLYo4YfKZV8mtRgFoMJFU1tj7FdD8duk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/8wN+Ag; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7coo4006868
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bBjRZ4BA1fnNosNt1HhSCCjSq1RjNLTHOzKBYD39Oqs=; b=N/8wN+Ag8MzP+ue1
	tdYkPp5XW4And8438l/UZRf8+SDp7smUdJfh3SJQdGWavmFeroJxpPNr8J5Ztl+L
	I6S0jywWp5ZI+pUnnKZH8TM2HlV+mwfGh4QH7PogoYeSzdqqkJWaoCVlwkHO2xVS
	gbvuiigV7lLFZ3x7j7RNRxBosSlwR2jMp3fsv9vNZj3JM63ir7TSXk+x5TfjuqX/
	G3Z4PiSAcQGpCMuPAXxAqEa8hgQe9YNR5yWqzjEUdEaCkObAj2fpbFOoDKvMPIKq
	91689QeIBSO27KRFmFPH8olFqesgsHT2je7QWYSWi/Sk+6iWtUWzkOcVie8N9Sy4
	pepqCw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc27ad7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c99f6521dso81595005ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494987; x=1758099787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBjRZ4BA1fnNosNt1HhSCCjSq1RjNLTHOzKBYD39Oqs=;
        b=RN9vz+M/HzlY6YE5joydw7Y2Iq7V4Qt41rTofe77atWMRFxbxg2WWW+z/7xhuvoLF4
         lKYkHUCoMagM+pVa525t5PqDwkV98jlDrSEaZQHPc8rZc+fqGDFtVa9O0vTp2uYeKTXb
         stmKyIniGA7ijep13nz2GocXw1BQHs06jWTbzdvOEjQZM5lafGcP46U9zgWGQ2NKcMpw
         Yguw7fijb2pqJsHDXvz/2rEvkft1XrMcmtTY7GRK4VYIXGah7dAWLnWsEyfa7LRlxiiF
         KryjnLNG5T8ZE13Fqq02q/wbBMtvJTELxrnfZ2M2VJ4doA+S5HK+2MSOj6F99jWsEYcy
         N4sg==
X-Forwarded-Encrypted: i=1; AJvYcCW8cgudXADZ6dh74WfPTZdmmUgwFmECjY6Ga1VYbua5ixzGTV+HTUlfOQsSCNYFiPSIaLByDKA8X2BGxmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIq3Gzs7bMPgPxVXZTO1KzIHQ+SfBCx0AcfiuPia5q7SZEO7H
	RLz8jBXUeFJZll/bx1or9VbrwvYnkXV1b12w3ktIkFsEd9sCjjFYG5Vu7P6y3Z39u3dlg1cJDRS
	dzNdITrEfEremY/10eMsMtKuyvg5jYCgZPV/WvVygtG9YYyICuS+2o/1p+tAnpB5nTJs=
X-Gm-Gg: ASbGncsm0Yb5bGoVXD07sJ7GJrpjZvHaxPBlQk09Rfic+K4naJcE3i5AQr1bq0c3xfZ
	gttaH+qYTuD2DqT3RZrfriBZmOcS9RjOlAEFRq9VLSut7FufwdahfXgWZU+V4TqG5kIbE0l6Swx
	uAYRds0oOsNEimmKYiPzlD163E5OmO91HJ7uq53YEK7THYNBxvRO2KlRXMM2JAIYWJCgZ6wXkDs
	a1rn8Mu3BS+P6BXUVx9tA7XLuXZqHId94sRIbu2FCJGI+fS+pmMEgCE1iq5yEDtjd3qtILf2hhN
	bzsmDa14/hk5/velaSCBOZnskv3X5XFuZQKZZyt0TzHURABKJu+9s0THmApBjrzNZqU5F72KId4
	g6pipLMs2VElnACrJnesiM88pXOJjnf1kGw==
X-Received: by 2002:a17:903:3d06:b0:246:9e32:e83a with SMTP id d9443c01a7336-25174c1d145mr186318555ad.47.1757494986935;
        Wed, 10 Sep 2025 02:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtdchrKI9eiNyMpIN3Q4+JIjYTsadT8/Vlk99S+Goudc9T3vGe4DnozzmY6zySEDEZUrknqg==
X-Received: by 2002:a17:903:3d06:b0:246:9e32:e83a with SMTP id d9443c01a7336-25174c1d145mr186318265ad.47.1757494986487;
        Wed, 10 Sep 2025 02:03:06 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27c029ccsm21089155ad.41.2025.09.10.02.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:03:06 -0700 (PDT)
From: YijieYang <yijie.yang@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 17:02:10 +0800
Subject: [PATCH v11 2/4] arm64: dts: qcom: x1e80100: add video node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-hamoa_initial-v11-2-38ed7f2015f7@oss.qualcomm.com>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
In-Reply-To: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Wangao Wang <quic_wangaow@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757494975; l=3021;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=sQQeMMHQQyZ+jOLzJfuQdFmPZbcfAe1LjwQ0p3k3Wr8=;
 b=LO90ADqRlRBqzjkvNrIHvspLPTQZ97aU+cfcsNuHrt6sepy5sfi4A9l2oIfHluXaf819BOcQK
 tLNLPBzmfmOC80118/3xYqhyZ+YpaYRexKCl6onuXvUJhcMxTOXIpJ4
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c13ecc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=tEm64AmstYfONosBKmoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5QXwcaMtIqlIhr-5ZYn4hrSyMurPLmdN
X-Proofpoint-GUID: 5QXwcaMtIqlIhr-5ZYn4hrSyMurPLmdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX5Z5mJ7WP454v
 KwJk4V7UFACCDXtB4Ux9Jz9GwYn195At0mDxHUzQu8v965BwyawX86dWxD+/FejYMzTOJpk15/z
 u43DWwVqcOH5GQ85JUjBiV+11rd9mzRO2/VqPhuXD1YJ/c+20PlUpAKbZzq2C2/LcJ2L5Jsrojq
 8cl177tbNaFNEgB5e694+KV3C6B34icTcAuPwLRsO65vUO2MNYaUOFMFM7hxx3DR5Pd2DcyHKvP
 N2OLNWOWLXD99JPRnsCcI4HvcrtWBYmb1Qgabme+5Jxr+9xAnd/HyI2qRPwi4I1CvV33azx6gcu
 +rcFZHcfEqsQ3b+aEBlwvfe0ylekV5SBryXEf+NJG4YqOtm759WQVU001k1f56wFOJDQXxnR7Ps
 ZpptALGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

From: Wangao Wang <quic_wangaow@quicinc.com>

Add the IRIS video-codec node on X1E80100 platform to support video
functionality.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wangao Wang <quic_wangaow@quicinc.com>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 737c5dbd1c80..4a450738b695 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5186,6 +5186,88 @@ usb_1_ss1_dwc3_ss: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,x1e80100-iris", "qcom,sm8550-iris";
+
+			reg = <0x0 0x0aa00000 0x0 0xf0000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+			operating-points-v2 = <&iris_opp_table>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			memory-region = <&video_mem>;
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+			reset-names = "bus";
+
+			iommus = <&apps_smmu 0x1940 0x0>,
+				 <&apps_smmu 0x1947 0x0>;
+			dma-coherent;
+
+			status = "disabled";
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-481000000 {
+					opp-hz = /bits/ 64 <481000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,x1e80100-videocc";
 			reg = <0 0x0aaf0000 0 0x10000>;

-- 
2.34.1


