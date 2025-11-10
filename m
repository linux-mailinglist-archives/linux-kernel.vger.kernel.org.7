Return-Path: <linux-kernel+bounces-892420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C60C450D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13C44E7ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6952E973D;
	Mon, 10 Nov 2025 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnBzXyBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dO0VyXV4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91D2765F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762754245; cv=none; b=eF+tkBV4CnSxOuaWaERvGAXGFG1CELjdekTmP3+N1AkysyygqjEUxuMVMl2YnqcasRdZTrVd56jm/rniHcRoDBrKZUwTe906vVJ3B9RTHkqkTxArpeytH+At9HhxOwkkdaPbh3Zk4P04xGRIN5VpqjbTDGe3+VaaCs5xectv3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762754245; c=relaxed/simple;
	bh=QzmDOJKkFKSKQC0iazd75tmvhu41zincARzHlNr7Hzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnfakX3mhnRjVc15WBu7toOZ9xcglwP4cUH7vbc3iZyJ65cIHygmgOhez3H22zIW9YgPp9sud0LZOEKk3pVXb1yBlTtGpuIYY3BG/R5GCgiERCrkiVNZSIkn+O2kOcXguT/IO0SedxPvqtFDS93uLhDaS9osGdqRrTXDSQn2aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnBzXyBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dO0VyXV4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LP7DR1572828
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9
	IbeP6+Yo=; b=GnBzXyBbipZRI33Et88pryS7N5B28j3qxC6yUxUCMfQwNkBJkcj
	XlBfNHjwJxhUN54RPSOAz4rqf91/aFV4Aq9iR0yQlmg82Qbs2QXs9J95JCZlS6tn
	Fgyk9wLUQsCb6UZwmngQL4tNKPbID40UOVmlLZpWw9zQpC+dqwmRKEDl1Yf9xeZK
	N42K/oYMwZ4cbnqbEpfAKVIhAp7Hd0elYXwAzqWX/Ba4HPngNNqAoruvVMBqtzD0
	mT4JCDNorv/1uSvMKFPcx4E/hkH6btZDvvwwqVtutMBywRvRBETWqJUMqw/wSw1l
	T00NCPNewm2qE2RF2dBHoRES0BEzcmkBjqQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a2c27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:57:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297d46768a0so7704975ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762754240; x=1763359040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9IbeP6+Yo=;
        b=dO0VyXV4uelFtQJj4gpwmsvOv3VNsuRMnvnfFtHr33n4FwUy1z9VTnRGRKCgEFVNV0
         4ZKYv9FGkNF6JJGq5Z5rB5mHErXNBJ1Z67GoSaY0CFhHIkbXnwK8J5ilhfk92ssKRWS6
         fWUJLQADuPjX5eywVhCtKijEYxldnpbQT9/dIjwdo1pRLtB5/gFenE2tLEYUJeeinAU3
         AqzNTjLLCPbXp28tI0vFvyY6Zlh7i5AFLb30/kMQhBhExH2zJTucYbk46YbG/Q605E2n
         E5G1pepHBDaeoejtCNgLjUAN+dhdPdBS0W6pXUWo+8HXc+5+7Im19H1JkLOcfi7kgSBK
         mjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762754240; x=1763359040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9IbeP6+Yo=;
        b=DWmOVDow4jMsQA9Wulk7igWIzDO3l29QS5BPZTriCegk671DS7xFfJ/yY2fkELJHEe
         CFxpra4MailIemvvhw3fIk56WTuP19c5/0UcxK4m2wuZe27xn1fAWh4o0BmhP80OJwE7
         ICu1zNA94Ii1OCwjsLKhwiMwPTnnzABL41UhNK6H2+qX7F+fRuDZLWu5x7SM+a3xIWt1
         LsoVDnSoAtpbkJbVCUBtZ1fsiJxc7wZVn5NtvHQo+qNi/eT50BCKX+HwXyUYM7wbWYpr
         qVseeEfl+dxYJHbHvDP/BFepxZavzjjS8/80G+MshSFkGvS7jlP7pJKA17VHTkdEmqdj
         MLRA==
X-Forwarded-Encrypted: i=1; AJvYcCWIG95mS0cua1gWkJZbw5Vc0x60ur1r3LApgOcfgMtcAcOA1tJTjS1b0m1LS4sPcJSm+uxxhWAeesil9tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLk4uwME2FfHjjBOz0PZOq2YrV6p7Yms/lgywvw6ZkduoTKlr7
	CkBZr8NJo22s0AqPMEblDpr+fFT8wimaAMdJgTMJcdxep0J2nAlL6nb6X6rWImVdtqbpOaIeImg
	U2JWBRF4R09qO48zEqpaJXJTd8+ux8JxqaHUek4nYAs4P8bLoDUTt0etm5V5VQvoh1lk=
X-Gm-Gg: ASbGncvnIfk7z8SGe+VPlxwzXvuahE5d5orqlDbWU8Ixw8p8tay5NcCdr3aEEZF66Lt
	LMY6P2EIO6p2oX7bETn7MU5EdklCGhYUQ4MHz3cvcqjvalSYoIJrybPu6KWKiEw3LtjfVASvKRq
	Qd2LcK8ELRvbDeY2d7R5M94VYL5NglcA+zjbfARpDja59XeCQayATjqpRb0Keg5HU7ldgMUHjzT
	fJsR+mi3/UFJhY3C/KWG40K9eipfRfZKeBkLzDSartthXBjlWRN0D9/6zcodJOD5gGjXIbP3Bwh
	bBoFSiUbxC0q6IPwId9VJtlamF97SfkO8Cq6fPh5ASZXH93izbyOpzrDBRuy4gb2yl/2QMYGfQ3
	FGNAnjPIqL46+HBY9a0QBSQ==
X-Received: by 2002:a05:6a20:3943:b0:334:a531:a51a with SMTP id adf61e73a8af0-353a2908c00mr4784516637.4.1762754240368;
        Sun, 09 Nov 2025 21:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/4tfvH+MRQiVSi6nbedH8c4nEAywNsbUsJHnIDQs6p/nXqjlrt4RAFVGtaO/i8XjzbKH5sg==
X-Received: by 2002:a05:6a20:3943:b0:334:a531:a51a with SMTP id adf61e73a8af0-353a2908c00mr4784501637.4.1762754239794;
        Sun, 09 Nov 2025 21:57:19 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bb57baf9905sm2156589a12.17.2025.11.09.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:57:19 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com, Wei Deng <wei.deng@oss.qualcomm.com>
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Date: Mon, 10 Nov 2025 11:27:09 +0530
Message-Id: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=69117ec1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2pNZeJXcaPdVUEHXAskA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1MCBTYWx0ZWRfX/nqfUSa5425V
 iko2VJxLurQKqdKDpCZhzM9Voa92n1WBGPYPxfK491DOTxjsX3qHLT+Vk0nIRIWe44LQq1L5tjX
 jMMYEX7jWu2m3p+1Pu7f4AB0V9kYjmKr/ZdCxM+R6ZWzSh2hpA5dvfRQazPpXbQY07vI1679otJ
 FsPg5yBvAy33qZ/LSjpK1ne8MY91D+VAWv0aOClr+Uc17awVfIhTIAnqaCV9j2uREIxtwrW/IlK
 517lsI2L+SWuSu05gB/g4R6ahAbJYXt2+N/K+R11uVDxsU+eXdvDBIdoF5VEhg2xDU5fOQ2HewW
 c+MB+GHtKqIuo/CpVU0aDs43z3rmabeQg/fnxt+lFI6C35cQJXi82XztQwsjCXcBhrA/LsE5T5z
 nJa1mgeso6MzivlSrvH0UsgC/iW1Eg==
X-Proofpoint-ORIG-GUID: GtEyir88RPeLeZdS7d666F6CxaZRf5Jr
X-Proofpoint-GUID: GtEyir88RPeLeZdS7d666F6CxaZRf5Jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100050

There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
Bluetooth work, we need to define the necessary device tree nodes,
including UART configuration and power supplies.

Since there is no standard M.2 binding in the device tree at present,
the PMU is described using dedicated PMU nodes to represent the
internal regulators required by the module.

The 3.3V supply for the module is assumed to come directly from the
main board supply, which is 12V. To model this in the device tree, we
add a fixed 12V regulator node as the DC-IN source and connect it to
the 3.3V regulator node.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b40fa203e4a2..c87291e3c6ac 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -21,6 +21,7 @@ aliases {
 		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
+		serial1 = &uart17;
 	};
 
 	dmic: audio-codec-0 {
@@ -110,6 +111,17 @@ vmmc_sdc: regulator-vmmc-sdc {
 		regulator-max-microvolt = <2950000>;
 	};
 
+	vreg_dcin_12v: regulator-dcin-12v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_DCIN_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vreg_sdc: regulator-vreg-sdc {
 		compatible = "regulator-gpio";
 
@@ -123,6 +135,75 @@ vreg_sdc: regulator-vreg-sdc {
 
 		startup-delay-us = <100>;
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vreg_dcin_12v>;
+
+		regulator-boot-on;
+	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		vddio-supply = <&vreg_wcn_3p3>;
+		vddaon-supply = <&vreg_wcn_3p3>;
+		vddpmu-supply = <&vreg_wcn_3p3>;
+		vddpmumx-supply = <&vreg_wcn_3p3>;
+		vddpmucx-supply = <&vreg_wcn_3p3>;
+		vddrfa0p95-supply = <&vreg_wcn_3p3>;
+		vddrfa1p3-supply = <&vreg_wcn_3p3>;
+		vddrfa1p9-supply = <&vreg_wcn_3p3>;
+		vddpcielp3-supply = <&vreg_wcn_3p3>;
+		vddpcielp9-supply = <&vreg_wcn_3p3>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -627,6 +708,22 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&qup_uart17_cts {
+	bias-disable;
+};
+
+&qup_uart17_rts {
+	bias-pull-down;
+};
+
+&qup_uart17_tx {
+	bias-pull-up;
+};
+
+&qup_uart17_rx {
+	bias-pull-down;
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sa8775p/adsp.mbn";
 
@@ -761,6 +858,24 @@ &uart10 {
 	status = "okay";
 };
 
+&uart17 {
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l8a>;
-- 
2.25.1


