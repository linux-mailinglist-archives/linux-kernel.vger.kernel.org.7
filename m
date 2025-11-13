Return-Path: <linux-kernel+bounces-898721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3663C55DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5297F3B0615
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C7301006;
	Thu, 13 Nov 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PoNs5FtU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jpHL+7bi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6332F5463
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013129; cv=none; b=LzBhU+M6BY3ifDTuxfnjhYK2AnhM+atFOFrvntryPgXX19qkd70uAAYmvXQzn1wknDUc5VQpIwUa95mTRXWQjTbhLKIbU5T8BoLfZCOJIrUdrLtVN5/+aJ9uEJ0ypbGghONdIL7bbeyP/33asf0PfBnb2K6VwIVDIBjwGCNw3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013129; c=relaxed/simple;
	bh=TTrQnSOjky/digu/151EgsUvRH0eS2vtmhdHfbpi5Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocm49Q2kabAu+dC0M58QHEPd8bykE+dQSMGjxqrVTwOg3RrXHimvgEeKzUgaykTzLt7zgvbjxaQIVZDSCBsz3z1+sPJrD6npHf/4Gzonspr4ZgkOXAF7NhvrLvDUDeP9CRqJ8kktvyGgUTNRQTOgYY7oHNc+2JMOeM/6dC1wIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PoNs5FtU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jpHL+7bi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11GjY3113350
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jicTo8oqMyMLCYWTfHkrZvCNBxNfkvXktsT
	UhgUgBLE=; b=PoNs5FtUy4IB5p1MsQIbxhNUsaJuB5m5fiA75pEklgnd4rWAzY4
	d6wVzhvRuIg7Us5/Fs2kSdNRvrXOe5E7abZNU2xnHDMvMBIdQp7+7vqO7pu0SlWR
	WCQZhBccSYmHIqQ1kjdCkc/+fOExpvsyovjfOgo7feH86ELl5u1JbJHsOWYltHqq
	eohXopSU1NH7YV3iokDwQiEnNp21Z3vpcpNIpylSzBF6IkbrU4uqcWGk4S2PX8go
	QkRiGnfHaeVyBYHIL1fTOKhZl7obBrwkV9KMb28Avx90rt0xUHLvwggGdzWHQBzx
	3vkt7Iiaal7rQAYTmegrkNMz9HUu1yFY2tQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw4amar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:52:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297d50cd8c4so13194345ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763013126; x=1763617926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jicTo8oqMyMLCYWTfHkrZvCNBxNfkvXktsTUhgUgBLE=;
        b=jpHL+7bi3bgit36ncxBhOhk/yxNyM/pcmCOUWqRr/jDl/duLSqSAJgrJ0BUFgf+DGe
         K/fF/laEADrcNhE3oDClWnidZkziMsKze8MbRiDoEG58qQgD5Of9ixZDH0koTSPvVJhd
         QUJoS1yGA9/8hPB+sal2zVAWwoVRNbANP5rbybPll3d5vknv6DFJ5GXEGcq1SA/SkP0N
         yCwbtVT+04GEWOz6pf/esfMm6jUwEGhhMGvndcV1qPJsHtHXRppoc7Ac/StEKYQ9Yq+V
         wIDChmtWcNPyncl55XD4H+xBW2/Ml1nQdxno77+2x6UN+Hds8rcFAp9qdrE7HsaMuniX
         FGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013126; x=1763617926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jicTo8oqMyMLCYWTfHkrZvCNBxNfkvXktsTUhgUgBLE=;
        b=Pyhy147feJkfLc88NwUZZHb4Shch0QekUF5viAgyK8vO2UfAxFx7Bn90z8nY2aCyYR
         6f9PDl0reXU3zuF/munmpVvnv3QTnqktBrbfutsKweG9l5v6r+5Gi5lpv6wG6qZVnpcb
         HyuAuDSHZhLhQWYOoejYT/pnrgNqvAyZi+qR4bx3UhmYbMKh9fPCJN+6mBWS7pKwRui7
         bF5tZV+AtcH/pdh6HQ7xY3BsAA1gz/Mqm34MFrVAyHFulg8Jjr4junTRo/qy+LX+jIVg
         1gzuKN1/0i6FT+KEltkx7lR3t0rIEeHHAQSMFyrU3iaNejY85DVaOZ000y8BJv4ONuwZ
         /f9g==
X-Forwarded-Encrypted: i=1; AJvYcCVrWmssgiDcBnsfqSQe4QInz4Z6HAt3OL1VT0L7+7B3FmAaYw03uKcWEacAYwQyEC1ckaIZsjnDLZaPMH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqrhDIwGjJqw8ODl3kfaIuHhPwufkc/R+NbelHYv1e0aw/VFv
	EJh6y3LW/Ox0GbfxL5vISDJGZPkNDFWGQf8WJAwi6/rBGZaOd3pwcEavoqf0PkXlhcSKQp4air5
	fHqYJM4WX82xVV1ejfAhlpKuwYZv6Z/mtOQpnRhBhXlcahxYPvUKcaNjOl14TXb4tdTI=
X-Gm-Gg: ASbGnctICFEGqi3jzmnvgxSqLfT9MczQH7ewiA73aLvHfbshDY0TRt11Pg4tEhdnKJw
	AFqLh7tl35W3tEBzLE9k1Xl+TbdAeO6X4oonNN3JiNGw6fC4m9PoAXkYataSTml2wFXWfxEwukY
	WyzIqotvZ/HTPaSosDtil/ySWNEw+eh8ELSfx3kkGvsG3+SthrbOt7OINRR0AYDMuyCic+s2yru
	kGd6PAjBx7tH6SjqLCfYK06OWW/6Qwbj1zLmhg/LQk2ZJaj1NPIvBab9wQlgNg5SzZ11EuLbl38
	OSLLo2tXGwFs67Nhp8dGAEkjqZlHjtZW/f2CESVsQin1fkj5IIczWFC1XQz2VNOQL0sWbyDliD4
	aX9Ni7BZAPfWnhxL5OKw6Ru8TOs3r/DlHc6Kn1UPy9iPQ9deb9XGaw1Y=
X-Received: by 2002:a17:903:32c4:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2984ee0a933mr67128685ad.58.1763013126292;
        Wed, 12 Nov 2025 21:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR/MJkYAywS3TLHAJKmRqNbPUYvhJT9OqN0Mx+apk2yX08m4uG2jap26XLLi+1NgscVt+YGA==
X-Received: by 2002:a17:903:32c4:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2984ee0a933mr67128435ad.58.1763013125773;
        Wed, 12 Nov 2025 21:52:05 -0800 (PST)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d76sm11076355ad.68.2025.11.12.21.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:52:05 -0800 (PST)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_miaoqing@quicinc.com,
        quic_zhichen@quicinc.com, Wei Zhang <wei.zhang@oss.qualcomm.com>
Subject: [PATCH v5] arm64: dts: qcom: qcs8300-ride: enable WLAN on qcs8300-ride
Date: Wed, 12 Nov 2025 21:51:47 -0800
Message-ID: <20251113055148.2729943-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E6OQvQuPLEKsZfrIEax4qRE6SNdO6NXW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAzOCBTYWx0ZWRfX5UCzjCSgdLzX
 B9NMLFdTrug905gOISV3vmPli2ZnrJGhmjOXh88XgjwzVaBnsis2rRcc9/VmELhBK7FPVwSkDuK
 X6fGnIIjPS4Qt76R6bdbA7GJQLk8ScmiqrOTdGuO5E6CllZTqe4jrMes4PL9SRhLnBXejxNS/dT
 GmOyJbj66sPP0MkxgLGBqe8dr3lkV9gebNZYR1/dQuh+qzBpHF4/kaGApHDe1pCBhiBywvKKzOS
 usT8oTbSPUvlkkXnkRGcXjFjZFJSDorgWld2eyDpwRhOWEvSdKHkpcmjGGzrJMDCEny3ISPOkRm
 ioCdAYskD0mofamZgAs7+NmK6dqDBvO7NSryx5OI8stjQefVjIUFUTRSZG/htsldvGI2X6vxtCO
 oUkexmrZHf1vmL0fUTJljmyRoPGAJg==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=69157207 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=vM19rjaGBDlTF_Dnh2IA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: E6OQvQuPLEKsZfrIEax4qRE6SNdO6NXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130038

Enable WLAN on qcs8300-ride by adding a node for the PMU module
of the WCN6855 and assigning its LDO power outputs to the existing
WiFi module.

On the qcs8300-ride platform, the corresponding firmware and BDF
are QCA6698AQ instead of WCN6855, which have been added in the
20250211 release.

Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
This patch depends on:
- PCIe
https://lore.kernel.org/all/20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com/

Changes in v5:
- rebase patches
- Flip the order of property-n and property-names (Konrad)
- flip the order of bias and output property (Konrad)
- Link to v4: https://lore.kernel.org/all/20250325075331.1662306-1-quic_stonez@quicinc.com/

Changes in v4:
- Rename the symbol pcieport0 to pcie0_port0 (Konrad)
- Adjust the property order in node pcie0_port0 (Konrad)
- Add to the commit message mentioning FW and BDF used by QCS8300 (Dmitry)
- Specify the calibration data using the correct variant (Dmitry)
- Link to v3: https://lore.kernel.org/all/20250318093350.2682132-1-quic_stonez@quicinc.com/

Changes in v3:
- Complete the nodes property definitions according to DTS binding requirements (Bjorn)
- Link to v2: https://lore.kernel.org/all/20250227065439.1407230-1-quic_stonez@quicinc.com/

Changes in v2:
- Rename the nodes name according to DTS coding style (Konrad & Krzysztof)
- Provide regulator-min/max-microvolt to the regulators (Konrad)
- Link to v1: https://lore.kernel.org/all/20250210062910.3618336-1-quic_stonez@quicinc.com/
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 108 ++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 1215f21e67f1..cd8800a59700 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -33,6 +33,88 @@ regulator-usb2-vbus {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	vreg_conn_1p8: vreg-conn-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_conn_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <4000>;
+		enable-active-high;
+		gpio = <&pmm8650au_1_gpios 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_conn_pa: vreg-conn-pa {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_conn_pa";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <4000>;
+		enable-active-high;
+		gpio = <&pmm8650au_1_gpios 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&wlan_en_state>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_conn_pa>;
+		vddaon-supply = <&vreg_conn_1p8>;
+		vddpmu-supply = <&vreg_conn_pa>;
+		vddpmumx-supply = <&vreg_conn_1p8>;
+		vddpmucx-supply = <&vreg_conn_pa>;
+		vddrfa0p95-supply = <&vreg_conn_1p8>;
+		vddrfa1p3-supply = <&vreg_conn_pa>;
+		vddrfa1p9-supply = <&vreg_conn_1p8>;
+		vddpcie1p3-supply = <&vreg_conn_pa>;
+		vddpcie1p9-supply = <&vreg_conn_1p8>;
+
+		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
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
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
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
@@ -355,6 +437,25 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+
+		qcom,calibration-variant = "QC_QCS8300_Ride";
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -461,6 +562,13 @@ perst-pins {
 			bias-pull-down;
 		};
 	};
+
+	wlan_en_state: wlan-en-state {
+		pins = "gpio54";
+		function = "gpio";
+		bias-pull-up;
+		output-low;
+	};
 };
 
 &uart7 {

base-commit: 6fa9041b7177f6771817b95e83f6df17b147c8c6
prerequisite-patch-id: 0c5a6e979d4ceb5b8c4a81e398dca96b8932441e
prerequisite-patch-id: babbcf9dd8722e19d91b01eb45756f58e58ba6ac
prerequisite-patch-id: e641f09d4139ac77c34757bd08af2db746de3963
prerequisite-patch-id: f5dd3ee9979e2a049badfb51cfab184da4501870
prerequisite-patch-id: 40187dae2c9518a10866104b9fcd5a481ac67d51
-- 
2.34.1


