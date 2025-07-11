Return-Path: <linux-kernel+bounces-727862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A45B020C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869FBB44EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196D2ED858;
	Fri, 11 Jul 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PEzoyv8+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156B2ED167
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248643; cv=none; b=O3ykWNaWFAyy2XtyA7uIhRJ1iYvFvtr9bVxI/YdQtEpt8u6bUJYyfoGSClJSZ8G+xhsFjmYLQBoyd5zzmaldynMj/0rQekUjr+OKY1zQMe3+YojJnTKPj4kzDMCI9zn5hja04CmzhVI9FhnXVuFj+wWFJM7hrQxkkc9M2/ooZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248643; c=relaxed/simple;
	bh=PEXn5nInKyDmUxIss2FQVUYDJOTahK9n1p8TmcddTHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DZ62pDDKXKVrStHjCtWgrQh1BmlWums44EIdV/xi+aXrKeOjawERAb2sSdIakD4FJ3K/LKTkWODTNBbMb4rTLGWLd/JMKAo3tF+8DMurRIYL5iK7iRZ/MYNgeMbuiotvN2NDO7hoJhKvelW9539KzQ8UKj9P7zf13AvDYmyl9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PEzoyv8+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAxcM2016803
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=emkhpJE6YHBFUt3US4D3Nq
	wBsCFQqng0EqAEghIvVSo=; b=PEzoyv8+/AyhqRsWIydZoJ7P6gbZIOuGVfD0Kg
	1eQWdztX+zzooJLf7cJhmIbZrxIZtX4KN9p2ZCKlv0SGDhihd/fMhIfKaDjvVAGs
	6bJW5E3VOt6EL58wIicvLPkGTXv2BxBIH/M2Rp4M4n7okberNW6OuvPEdbdexeTh
	TrhDTIbg0TdmdGh5SsATGRscngDXLTrD5YG5FkoyfQJ7pyl/C5G55euytaDrqSQz
	zpKfYJWKXaMfiKQKOD4ZLJPgnPtaH2PuMZhFd2WdXgd6nqlZt4LW9zY/lr0koMt5
	A9pNc1Cxk8QYnjXiORwUX0q12/vTVy8o92i3aTbGbQjy6tkA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap948e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:43:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748e1e474f8so3512083b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248638; x=1752853438;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emkhpJE6YHBFUt3US4D3NqwBsCFQqng0EqAEghIvVSo=;
        b=Gq/c+oTriLrmg3aJAHK56pkRPNmsyuoWcYpWrPsmi5PWF5Uky3Pz2/PRIid45gVnlg
         twHR+G5SAtAcxKEa2hYOdL/K0dJ5u2z6x/S7Kf1keZAKWuRYpFPiBlxytQlkXzEkhP9I
         j10nTENdwLigBjW/KlJQU0Xsa2mFfjtJe982UPtpSfPfCboH4ZclcRrlqu7gPB2GKqpz
         Nm6K4n3ucnWNCCnWbYlXvjtI2dGO2h7Pwl42datFuOCtiYXz7bIuXZoruv8QQ1K7j7fJ
         t6suuxSXlrxNzzhHDghE3Yz3vL34PFVoW6WAI6cDNf0io9uDTEQX+J4vdvZ6ptxyd5t3
         V4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXxQmDUu6D/4ANiN6tb6PBqRvJBfXgn/RmEAvLpQRh7/TpOhTFUlJHsBvajq5QINjzUVVtE+AKM1mxKUXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3WHMIW+8cV24uzjzZpAmGCWSX10jkSXmJBzzoWf4bgp5T4sm
	Blo9+VvEZbEwfY9whgihd66hbozbpe5WlIRMISDqx/GpAGXgz8EJ9nG/KCFIn2TQzS3VQyruH/9
	EA6DwlG2J3wA+UIBqCFbfudr1c5MsBzR2tqqy2TeHZlt7OO+GS2OXt683d0KlxcoXQmg=
X-Gm-Gg: ASbGncuVGLg5+OnuNTYD9FNbaUzo/ULjJciCv9lecebIA6ECrLAG9y6goZ14RNQIExr
	Xe64zWQBzWTH+L2yhvBGt33O5ypgCZU8/Fb/AHL2vz20CQyAYNhLbxUgLBAY8ajV17FYb5taVL7
	5OJALtRgBbC00RVw1qkU/v++TO9GjYdP/CJkaWeknJ/199sCrv0mEanMzFp4eYhHtdnyA5zwH0u
	ULhO10aAuZgAQgNE+5f0k9gm586/fYW44eBBGRyOZWXtZ6+aTwLdrRRyo3rNuh2kZ6Y5sMl6fzM
	kCNk34FWAd3aiuLB+07aqcSCuaSMplTH7hPF/OHXLYGrJ0qGFTpR5lxdBkUmITOQz9JV7D2h0U6
	O
X-Received: by 2002:a05:6a20:9c99:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-2311fa06643mr7190494637.40.1752248638332;
        Fri, 11 Jul 2025 08:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZFA8pi0ySFhkHZI7IhUQan0B4zMZWd3ZAl91cAZ5DjbvXrfYe+D7WAOQzynEuRM2o1cvnnQ==
X-Received: by 2002:a05:6a20:9c99:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-2311fa06643mr7190463637.40.1752248637941;
        Fri, 11 Jul 2025 08:43:57 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52c4fasm5447532a12.5.2025.07.11.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:43:57 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 21:13:47 +0530
Subject: [PATCH] arm64: dts: qcom: qcs9075-iq-9075-evk: Enable Display Port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADIxcWgC/yWM2wqDMBAFf0X2uRE3NUpESv+jSEmTbbtQoya9g
 fjvTfXtzIGZGSIFpghNNkOgN0cefALcZWDvxt9IsEsMspCqqBEFeXN5pHfSwo3COGe1rVErqyE
 5Y6Arf9feqds40PRK2ed2Qk8xmjXbZO1arVCiUuW+zrGstFQCRTLs+WMi9/743+xtbof+AN2y/
 AC3q9GnswAAAA==
X-Change-ID: 20250711-enable-iq9-dp-addc9c7195c9
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shashank Maurya <quic_ssmaurya@quicinc.com>,
        Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752248634; l=2394;
 i=venkata.valluru@oss.qualcomm.com; s=20250711; h=from:subject:message-id;
 bh=xNxTHWh4Dha0pCFM09zKxyHkpUC/Tls6RXg/hqBBInY=;
 b=ZEkKX8apqTvSjExfh440dF1QD0AuQ9hoQlqJD6LyDyiKZJYu35ezAvnQdBniM2Wt/xudp05lK
 nw1OJv1Xrb7B2DdsqEZROce0TH0vIzjISszlbrMUPGH1LwW5kRPWa6i
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=f/CAPG1ZGl5SP8S1GuC97WMhUEV87h0JheHkNMt1nhM=
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=6871313f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=SV12H1ROeRvGGX9EcCkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: w7dtoyEisEOFpKNuzkIaklGFfsaAWT7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMyBTYWx0ZWRfX1uN/+4Y84X67
 9mZE11a7LybYWPgd/dJvdEveCyXCoUhK+d222qEd9A3w/k04bTnPQXOl9KwPxFtjByDKBougfYw
 OZSjEG1+GaXxnfPBHX6dw4SC43SftiVhJbddOaTQX4N6WQ+nb396KtLX88ZtjgzAeZ7O4ZGvkcS
 LplKYPm/mfRlgHJNT/FyyVp+/QuDSrrok6lbxam2wyF7aPgQMj9zVa/wABrx3uWmdRR2eySwIJE
 yeuA5BdHGgBVAFCqi955vPhqsv15qA4co2zKiBbjA6CFyCrdvbTKkCmZXlmuABZ3WEKcSjTNTr/
 Gwod3i8RR7baI0NbRRnwCTi1T4bNoiI87JpPw4L02HiFhco/9FyN/PnPjqxUUtk/+cTh8JBR4bh
 CbZ76i1NvN/i7I7QZIrzU2iIzVGYlBEDFb6F9h1h7GeYwA0Z1R6kZmIC6iNqCc/IpYKuB625
X-Proofpoint-GUID: w7dtoyEisEOFpKNuzkIaklGFfsaAWT7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110113

From: Shashank Maurya <quic_ssmaurya@quicinc.com>

Enable DPTX0 and DPTX1 along with their corresponding PHYs for
qcs9075-iq-9075-evk platform.

Signed-off-by: Shashank Maurya <quic_ssmaurya@quicinc.com>
Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
index ab161180d1d5a670a68c0903e85f24a91faa2b71..110e08db3ad82e3aa88aa4c4ed4b2beb607385ad 100644
--- a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
+++ b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
@@ -252,6 +252,44 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp0 {
+	status = "okay";
+	pinctrl-0 = <&dp0_hot_plug_det>;
+	pinctrl-names = "default";
+};
+
+&mdss0_dp0_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
+&mdss0_dp0_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+};
+
+&mdss0_dp1 {
+	status = "okay";
+	pinctrl-0 = <&dp1_hot_plug_det>;
+	pinctrl-names = "default";
+};
+
+&mdss0_dp1_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
+&mdss0_dp1_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -260,6 +298,20 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	dp0_hot_plug_det: dp0-hot-plug-det-state {
+		pins = "gpio101";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
+	dp1_hot_plug_det: dp1-hot-plug-det-state {
+		pins = "gpio102";
+		function = "edp1_hot";
+		bias-disable;
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

---
base-commit: 7f3a635117b377cb90b67757cb46de12ce8aa24e
change-id: 20250711-enable-iq9-dp-addc9c7195c9
prerequisite-message-id: <20250612155437.146925-1-quic_wasimn@quicinc.com>
prerequisite-patch-id: 22eee78c5507c3105e0c74d1128b3db803879d7a
prerequisite-patch-id: cf52fc82e606ab87458339f71596ca31253e91ee
prerequisite-patch-id: 3617ce3b1790bc5b8e50dca6c3ae482759dcc684

Best regards,
-- 
Prahlad Valluru <venkata.valluru@oss.qualcomm.com>


