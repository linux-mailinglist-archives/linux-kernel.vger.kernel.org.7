Return-Path: <linux-kernel+bounces-881465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBCC2841C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EBD189ED51
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415A2FC003;
	Sat,  1 Nov 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBYN2kAR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WhBaWPJT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5C2FB633
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019099; cv=none; b=Veq+SMTbFtLViYJaVfklNEka/dM8Z4A1ISPtJ+7Iq3/dgwJuLfmwE25MDCuqz+2iSd8laBbz0CNb2lgKdLD2naIbxmk1VnnobvOS1pXOC8USYKcmp9tbh9mFgJN4PZsJsscg+5KcdLO9pPeU8x6+1Gkgy7u6Lb0jTAAFbyOAoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019099; c=relaxed/simple;
	bh=jSI75LVlTR5NIuFWKjV4cutObj92tH8PAwHy4R3OkTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trCsnH7lRdz91Xzu7KZyRtUZzbDzVtZaCQ7afIt7YrmBoNi6YDPFe4QZzpb/Cu6ZOgxVFildUkrnR8rL6WC1IMiauNuAEBRSDZDi6+EaSJTDBEd/vb8liNi57ieNuB734nzFasyGbEnVLjgW6uHy2E+oMMLIo4ltjOYm9UV+fN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBYN2kAR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WhBaWPJT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A1G02jP1937255
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 17:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HXBFazNdQcM
	aRyXkcXCOV3jbONPk1UQq3Gx3Lpy3RUU=; b=BBYN2kARu42Eyk/0oXeTww67ErB
	7wZrN2Sch9luk8Qly9p9fN81jzyL8qsE3kQcM8OQ+2gmdkETdj7EtoE4nPLS1zG5
	3R0K4Jxo7fYmidmEeNOPzAETR/Csuse5gA9JP42wdfIxtGsE1n2o8m/uIB5frHUF
	+Z6XhTFLijSuq2FbEPgvHZfhnPG5rN1xEbHflBfQ6xqqJoetfaEYysz7EdBkFigz
	Wsr1OWo6XIxCzrZToQDedjIbcRp6Bpv2SXjgSyzLKybRW8wWs/fWRCjopX2SyotF
	Mabklvx6tMNbsyARXDa3UUJFuOxl2MmImCeCpYiRyFzF8PD073RY+CtguKQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57we964t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 17:44:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so2566250a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762019097; x=1762623897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXBFazNdQcMaRyXkcXCOV3jbONPk1UQq3Gx3Lpy3RUU=;
        b=WhBaWPJTkBfu79Tl9Iyam2HzXYBY9yOBgcBA5nPrq6QtfOV4D1a4ZHgqqsRJjEklpX
         ahlkPGLYiYA8k1FCRhCRkbsZ8WFvFWGgcTzVtUe2E1pgOBhAJ0pHfxztBLW87h83ovGc
         ao+I9d72OOGQKePn7+aJWDJWSCgBzCwAS92yzKkAhmhjxpAbG+Dc6V80G497JMURSEi4
         xKXjNJa1LFG9ClynLXbo0Chxzqbr2F9Us3D8rC4zJ3I/EOYoHHFHPIrBajG6LN9LNUDg
         D51+Vxah3EM/+XbmuanHKGd1ZGIQ9zq6rHsvW1FpjTVTpDFZQLyLjKDq8x0BLU4FQ0BD
         4ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762019097; x=1762623897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXBFazNdQcMaRyXkcXCOV3jbONPk1UQq3Gx3Lpy3RUU=;
        b=N2ZT+PdCnfYyjA/DnW3Rba1+gOaEhvcY8HxlNOv2Qqua774BmSQLDArP9OlowrQy6c
         /gLH3liYdycC/K5nIeBu/lKvaZu7iXy+X3QXay/TD3uTyFS540r1yM6ah8u62u4lwR+c
         is8PQ0UNAQBdmJrQ/heqFiOppNltVsOnRXc6Zi79z0MeMn7ezhpj/QSLTW1VLP1sPvee
         eXuba5P5RJf1jiseZsRfjsKburAQ2BBSUJBxEvnuabmH7q2yAU1wUhWvhImH8w98F77R
         wXNN37J0rH3NXGi2Vw8q66q80ShIeQuH547ENDTooApH3VsY4PMRngepZINhj6tr1fl2
         5uwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKwWCIEMjFU2vIosh3YgHmkZe8pI6Lp8/qWY1bds5hUv7qVod+oFN+8nEkjLPvNxyb3l6Y9zHxdgbjCpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaRSMCkeZCHD3QkysqYE4hrxmKizTRcFVt19KAZNnt5KbsmfR
	WzEIZrwVRXE0VGzpzrA5dun2wyw4d1/nGRMxi67f/OoIpnWKzvSsoHYmqOKXQ0n2G84fa4CspbU
	lkKJdo5ZSnDFzRR9ZV07fwsbWFRM/V/Qu47PmwCSsTIaDRvCaAH/8T19gzk0res7kT6U=
X-Gm-Gg: ASbGncuMkz9I6bNkbV8c1hxAGHN40BdTRsbyH+mj5Gtx9oHXdXibg0yw+z5N49sOeKe
	4mDBYZKgQiVSuYftaqXZTca693V9qUtd+Ycf7hogkcc4NFuQpiYUsTXXrOYafwRGSK4V7LeuUEP
	156vEMaPmlEbcT0w5tqzwVyJhGxEZhNH+u3ifW627IFfkf4X6MQrK6/fRzCEyFlWyHZQd269Iph
	DksupzuHPvKa8FAUUJ+mHEzIHG++w380RxvJI6z8Am4JBQ/u7vaxPlBFzwXSsWA6oIRkxZDevvV
	1bNyGltjecEMMr6Nz2qvb0delhY4u+ik2CMhsVCf74hatw6yt1W8WmHEUMPpMRufzZ2rbnENP8A
	KW2/tKyUvgYUXNR9r2aXsHN57FWLbqDcUvMKx
X-Received: by 2002:a17:90b:4b08:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-340a1a8ee0amr6566845a91.35.1762019097000;
        Sat, 01 Nov 2025 10:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQkJFr4PcROEqsuTI02n906BjLMyYV2ZSHuFfEm7g4K+opK0+bl2sspe1ltfZMxrwubxg02w==
X-Received: by 2002:a17:90b:4b08:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-340a1a8ee0amr6566816a91.35.1762019096496;
        Sat, 01 Nov 2025 10:44:56 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f24ee93sm2793393a91.9.2025.11.01.10.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 10:44:56 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v11 2/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Sat,  1 Nov 2025 23:14:36 +0530
Message-Id: <20251101174437.1267998-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
References: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69064719 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JjTwLu2Kam44ScBvYj0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: jrTL-1s0VNPX8emsZiwD_a732YX26MzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1MiBTYWx0ZWRfXx8mnzFcYgLHu
 usRbHaqh6kN7KoTCpcOcN7SVkApzyTkYFfdI62k9F55u3H/a0T+4Dnx533b0kWd1nElBAH8296O
 pTGd7ibbJdi9oTS8BvN6gc6jS16eku/aKRBTyRpgRswV2qkhl1qDjD9mPZtSiTyQqEqnya4LdMP
 1WdqlmdpEpaGtDWoszdUx3DJQhy3PtHpAGlhtxZ1C/4U3kXq9ZEsgyHbLGdHkK6X5ClbIZykVrC
 qkuOuB8bPOyfJS+CBEVN6V9rxKP8bSpnLHpAnjL07FzgibwEg50CKQ9Af9CuMIZ4IYnvMauxWLe
 Y/yyzqvxuO4fthRzaw+vGxUSLp+Vkpasm0Db0J0v4VDHazhVIdiuZXp8wMJehpV/lbkb18s6HaM
 k2uNDWiOSVWGrRcWCC1JvdASsmk8BQ==
X-Proofpoint-GUID: jrTL-1s0VNPX8emsZiwD_a732YX26MzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010152

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 MTP variant. Add the PMIC glink node with
connector to enable role switch support.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Konrad: Provided diff to flatten USB node on MTP]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 45b5f7581567..c8cb521b4c26 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -191,6 +191,51 @@ platform {
 		};
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8750-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -1200,3 +1245,31 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3g_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p88>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_hsphy {
+	vdd-supply = <&vreg_l2d_0p88>;
+	vdda12-supply = <&vreg_l3g_1p2>;
+
+	phys = <&pmih0108_eusb2_repeater>;
+
+	status = "okay";
+};
-- 
2.34.1


