Return-Path: <linux-kernel+bounces-819090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36686B59B44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F9716359A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043E352FFA;
	Tue, 16 Sep 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kryeaJq+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760433451AF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034809; cv=none; b=WAW8wbwq2CMnx31ox94TOWxYYZAa8ZM04HQ9pASB1D33vMKoOvunYftnZ7gGHb5sZo/bSDQDCfkEE9T/bGrfa2d55CEElc4F/E0aYtKfC8GUGJPlvlxhksVYvZYhMIX6h9Fx/5mIBkBjjhkYO+NW7AzCGfnOolgBuGYUNL5utmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034809; c=relaxed/simple;
	bh=gW0bPo3OkmUFna1ZDaJHjlE8SmA8Fb3vkmArQbP1lQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFGqnQTL7OoPcZynZCLlJfUuNvoznPAwwzH79s2j7B6kNZFaq9oUTfVDPeSQJvvFuU0C5vowAx1pQF3zceutHQBM4m8KetrEujfFDbFpx+khb+gkyb9xj+TM81a35ZK5ZgWGHoydr/QEGEI3DR7bndTE4LYSB1ev6NrT6wWPg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kryeaJq+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAeveb019594
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=; b=kryeaJq+CAVPVeZs
	5Mnk4BSWozSGC/kzOElFYesnzCnpGRIbdLR1drPh2k8Tg9YzhMPIx5/vJaYypNsn
	weaoHcuibn/K7klHYfbPQ8WxtvBWvcvaC40J9GnL1B1Sg7rRx2PbiqaXTlseyQOx
	fDX+KXRd19i3G1SBa5IrK11qK6Vz8GnKCP/NSAilZySEcj/9yQ+EhK6/hSYW/ioX
	PXHlMW8olP2y+NtepNIJPUxVZO8CCnIZOGNk0zMPkOcgI5IRFhooXxHNvW5IXC/8
	Vg1uAfpbe/8krCOSV2d4jRrGaCt955ZEwb9iLcI0HLvJD+kQtpu5X7oOQF53vxmX
	oFphig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma983r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-265b1c650a0so26894295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034805; x=1758639605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfmoJCJYMW/3EkyXGndpmyfnXojx9Z+R8xHTgwqc19U=;
        b=m45wcdqlur+XoJBXWg8cJ2x+Ss/ibaXeO7iv/Cxcijn8BDeCftzruZ+sgpAZW8evvu
         /X7x8ZRIHzclmE+IRhMbY9KlGn0Mt+1aj5CLLpxwXydG6Yx47QSXoMYTz1QjnEiVqdpg
         gkAYpjJiYI2T7cXtUqn1X1oqEtvzOtXn71IJU6VUHHfd1wgdZ6IDhKVdVnBq20elICx3
         pFQEdgamh9SySSIXdiA5j2T/VNsKH5daIP4BehzdMEhaT11/6VTL0HK1ZSGi7nLSNraN
         MGOGIg0iwHLYMJuLK7OyOgqFxkRb0105WeJxR30VeJ/yHQkfeDqe5X/S6UcLHUhPC5Zt
         ABuA==
X-Forwarded-Encrypted: i=1; AJvYcCWzTBex27shOZiG6ExQEQtB6zl4GnoUWN5ANbvPXYOo5GckZFyvR/XTm3Hw4Rl4MfdFKYaGGRjgUTEQ4Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoO78k0hyEPX8+B8gq6FjyzlL+4o7qluUPXB6DVcLw/ENOumq
	rVqo4v1d5WPoJxp8ivWArJWr47kbGHSnX8NyCtCdLQ1Z4fs6coQtqZoZFrmU7fNd+7bWdnFWH+O
	JEawZ7TkqBiJ+V0v60KFnb/8+p7zpF89o4F7okkzBDxuEI7Be8n0Q+cYFoKaMk0XsNRw=
X-Gm-Gg: ASbGncvSj4GMWfYZ9mRH0bwKpD0/kpcGLFlKVC/85dmEhvy8jgddqhJVfVE+VWxyF0b
	6TzDMW1fWcbC78DZrZfTh1e1jeEArqQY3YKkRW2GWR+6XGfNXGIxKR+WCab9qOTxdTXCzMr7008
	FxXTccNSYFqwyoYtm525zKQXBGoBk0QpHpcjJtL2EPABUZfUm68DqKPycWNGgya2Dq+VCIO2tvn
	bm8K1JehKwd2X/aTjDsgz+gU8nZio1Ip416HS22pg+l+Zjw5nR9Cj1hGKozquzUSwdNj559RpiJ
	rqwr6xH/SoLOrMJo9dGKtDIepCYcFQ9RZ3ZDMmNXCAaznLHnrwqUNXI4UlVBPdmkaMkU
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224575ad.10.1758034804858;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5eMZ3RiMQThYk5LoeR9kX3JpRxyHtX+/pIEbsAA7FmX7mepRw7fJ9bUWKCBjk6kV7kbNZUw==
X-Received: by 2002:a17:903:2411:b0:267:d7f8:405d with SMTP id d9443c01a7336-267d7f84855mr29224045ad.10.1758034804410;
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:04 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:27 +0530
Subject: [PATCH v6 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-5-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=2502;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=3WsuSGjjSbB/JTrN1dwDIFLbf/p0GZwKko6k8n3FmiI=;
 b=sUXfC3dIKKDaw9CiY4EJTvMsBLjNH0VUE/wTCuR3uY8De/EzQ3wzGaIcguY3uTR8iU+6KQKIg
 hA7Zcj65CgxCSmnYgSQg5Zy8MEqKbNZGHovLvxIGtEWXeSrnsvFH3ia
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX9g7xIEIVd131
 FJAQf3i1XOnYMYKWuWkqigSKtUDa4tdIZZibJTYkThHpXTyqdjc7YOLTVXOKNA5ixI/qrOP/cql
 ISp7UZHsaI3QNzRF56TpLPY+ZazmQ5ClO3oLDLsyva79vsYNCotdE/NfTibjm8gfeeA5wpjqKEC
 1QTNTynSadXQPhywQ7HEnVg8OwSFNPik1HZM2G9QSAXzIhddxUcg26CBhcPgdL9dNXXbDRQ6C5W
 MlIQmBzd9sQJ0lfr5TB90sZtPxe8PAv0karQM2Pj4sFcq1YFFjMf4EanT4B9Vic9TLhUh5d1EmH
 FQue9ktemqNt44Ybzqdgezh/sehMl90PcSFPWswC5taj3Y85OWSQrsyOc14P1YkzZCwuPY51yt+
 T6Z65UBa
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c97b76 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=y_IpLqVBJp9He2uYrA4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ixFhtO1CuKHNvEtd3E54uen7puBpYp49
X-Proofpoint-GUID: ixFhtO1CuKHNvEtd3E54uen7puBpYp49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>

Enable PCIe0 and PCIe1 along with the respective phy-nodes.

PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
attaches while PCIe1 routes to a standard PCIe x4 expansion slot.

Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 97428d9e3e41..99400ff12cfd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -431,6 +431,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -447,6 +481,54 @@ &sleep_clk {
 	clock-frequency = <32768>;
 };
 
+&tlmm {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		clkreq-pins {
+			pins = "gpio3";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio5";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.51.0


