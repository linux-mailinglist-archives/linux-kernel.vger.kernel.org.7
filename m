Return-Path: <linux-kernel+bounces-729358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269BB03564
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86A3189B0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E66223716;
	Mon, 14 Jul 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEACTr4p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779E2063F3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468811; cv=none; b=jD8QDDkYnC+BY0iH0n5S3LMRvHGVHO+3QI7EoPqASWZXRhDKeo/ZTgTBN1yVuL1xjy7bIR8BMLvTdwLg0DdfnPzEFB1F8g360UwDEobrOLluT27WFxR7YdysBZ586ji4qvpnlF0aacttkqG7Yt0OHUGGaxzkwN65l0NSNsBxN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468811; c=relaxed/simple;
	bh=vxDpJpKIIYMZdJyPGc60w0X3XM/jxcMfw4gnKyJa4fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwTmQEXyblch7HO4rgCbqlyTRRPezXFvLu5BWkqdf+HCAYCRcetz5XnRmwIZpdAiqPtTcvTzKdAFEtEX0hBbI+EcBsHQoPlK+FhZyU8a8h6ny6rXob444m4dYNKFhvbjq7EnZsDOLwpSdBRU6Z0CGJXSLl6GzAdgZWGRowMS+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEACTr4p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E1EDNo022513
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/dyS6lm2huG
	v1iQEO4KkSzy92fn0Qo8/r5nwum9cLug=; b=aEACTr4pWVffU44F0YrZdNC+gPf
	YHQ1LXOfNjCz6FvGojb92aac4LkUmDmyGiZlVlNKsnnM6uiXGhmYO4U0v+JvDfpZ
	Z4XyimXC7Q9MAgLdmGKVkAAGTjewp2dLG1EcGXldQY1yg709sTr2NvZZszW5zlzM
	YEAt8S6endA/MfuJBIecLfPpdPd5eDdWHNTGXKgfK1zeE/VEZheXaR2JVsKYO1Hb
	IE4N/EylEapVdo5kCCEaFTXKpjoUv6ym3vzj+hv0X9C3hDDrCgS8b1Lhs+6nQsEP
	GijU3f/bi0OvgXleMf+Q2k+5lui1zmfZfSz5/+r0vgZZeNjttZxSm3uw3sg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxau9ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso4985272a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468807; x=1753073607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dyS6lm2huGv1iQEO4KkSzy92fn0Qo8/r5nwum9cLug=;
        b=QoXFzd7qwJOCCGx7gOHbSPNVLHhB3d1D/2DnNXEsUuXbtAb9v/ushvctDNdhbZvxtQ
         UvR/qiHqcZsw7JnKt05hBmb2DfyrJk2DwVb0r1v+/kD7rK81k2yrtDafnCBradQgxtLZ
         TdF/XoTXTmB2i1gzK5QjB9kyjLm3EXfjeAv6bTXxfjG1o8WQIVazKgsqa3oueqjn+v3k
         fXpU76v3R1yTLwr9GZJg5REf+ol3JUZPeG3uHxWeCaez2wFM9tcxZLnUExVvkbgFEnJZ
         weBnCHQqjg3s0kiP9X7lWU5NisbMdw6/L9HAFue3xkZtBsv2zp/iv/o1Of+C5Wo+owYr
         5bog==
X-Gm-Message-State: AOJu0YxODpraeLoL+RgzrNu2Wci2N4+Yn0HVWqF2DuH77Dk3o5HjmMNE
	y7qSEPKcav6HrK/Vjdv9eG4MUkL+Q7PDSBYKq70uX4sYKZdkYbKLINaw4GfkgzA+8jr53kg+byp
	QBjZoONOfSlkJRAeK01PFpCFq3G0Iuj7m28uLW1O//xvXDecZbVG+AqrafYEHOFnhnFg=
X-Gm-Gg: ASbGncvwIrxjpVjc9cDR6m12cIKVpMh2tjveDjxHcGoRqoiKFpWULu2O85qj8GcOscl
	LR4ATb4scG+hG5p6k/emXnK2Xmht2DTEgx2VSC/RRCxsMOyqGP4DL2U2wJjWIHYAW4wY4bLxYc/
	4NlIRqagM8PWJ0DCUityGNr0jzkfUPYWoIIHAaky0ocyRKM9KIksX++A8p+fL4eCy0G5h2cUzHO
	zDJgjAUphBLODG84qP9FGQnClLzb1NF8IgYqsqWmtHhQXYupOvhn03hDs+JAoYiT0Xt3mAs1hrq
	RYzuqk4nxBBIT1jqRK7FcvysPu9+1w9hqVwkjsYoS6TMnVzErlpOlOPJ6ehqP4btjiM0KcYMlRD
	dXQ==
X-Received: by 2002:a17:902:cecd:b0:235:1b91:9079 with SMTP id d9443c01a7336-23dee238341mr236151025ad.32.1752468806930;
        Sun, 13 Jul 2025 21:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+rDCunYHTkDmhlfHGHnNzzoXPu6ht8XZBiBrXWddujytUCEQsw7LWiUufuT8EKxDa15qWgw==
X-Received: by 2002:a17:902:cecd:b0:235:1b91:9079 with SMTP id d9443c01a7336-23dee238341mr236150695ad.32.1752468806550;
        Sun, 13 Jul 2025 21:53:26 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864a8sm85664325ad.42.2025.07.13.21.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:53:26 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8450-qrd: add pmic glink node
Date: Mon, 14 Jul 2025 10:23:09 +0530
Message-Id: <20250714045310.2092385-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
References: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TbdxfUO-GVUf7CuNJkScgF-fqsrA8rf7
X-Proofpoint-ORIG-GUID: TbdxfUO-GVUf7CuNJkScgF-fqsrA8rf7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNiBTYWx0ZWRfXz1zPKWJAc+EH
 ZzCMLscXr4WnPOmoM6jOBBrihBTsf7shui41fvoezijhbdVbs5gQChlD6JL/0ORC25Quoh6U4QX
 NEnhyRf1D3IxQsVQ+v2SeIwwqoU6s5NmuseeVBhEtJLXN/AE4qVOsnRJuAUUJms0MsEo3k41naw
 o1smJxB9DacnnU6/WHf9LjMMFZ5vHze5nW0xC2PprydskmIv9Xaq28UalPXmhMJl04PjUMWkMdX
 kxhL4QsydpZ6l6nWQsD2rnM+S4F2NxN/HeGFDlk4XjdHiNssiidrGZ5p6uRZgP6q09c+YaSZ/3U
 Ot6dbgo7N9YvbprklqMpac/qGHRch2nyJNg9FImA7dWMPCzP7AevcMnNkFV79aTnEh7HZv3VT1s
 usd6CjSXJm7oF4clnpoxdCWv3D3ZopcRkGvQkEipMNkua0duToym96A2hp9DnjlLfNW5rBCp
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68748d48 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=jfJnQzvz6-r5myQHi-gA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140026

Add the pmic glink node linked with the DWC3 USB controller
switched to OTG mode and tagged with usb-role-switch.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 51 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 8c39fbcaad80..a5093eee3dea 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -37,6 +37,49 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	pmic-glink {
+		compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
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
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+					};
+				};
+
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -461,8 +504,8 @@ &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
 &usb_1_hsphy {
@@ -487,3 +530,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p91>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
-- 
2.34.1


