Return-Path: <linux-kernel+bounces-897473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2ACC5321B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F48504F17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1034B18E;
	Wed, 12 Nov 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzFHZh/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Whe+yvmb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8034A78C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958914; cv=none; b=nWVLrji+LR7TNGw0hWE9kYE0vZte0SU8OFfzhg/jl9OWxpih+oo0q68+Xr/37iKTrDk4OlLTU1PnPT7Hnt2NIrOt48hcbAnspmqxPo/3MUrZmnxom9XJXA6V/ZogtQ/iZrSGziXencKE2cnPL/TjndrdVL950okqMe/yD5DWXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958914; c=relaxed/simple;
	bh=DyoaA+sChPIv23chjFgTleQ1h6QpQxmkBY1evOLH4X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/0FUyGR8Ax/7sFFH6gJ+edDYWuNbU16sFp7ZbEj5A7uw9G55mXhXJ03e/dbuOghxjVlnElAoE6h1iwXzIpUUbAMq39LPB7nxOvFYmMKDYg1Svu5IjSrUjvOa5uknsgKu8DFkBeNky4S4UVNaBCE31dLpNi5v0O9k9j28xmUvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EzFHZh/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Whe+yvmb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9fUmn721987
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TeckgBCqYzzJWW3WF7l2yuaurdQXFJrxiMzuEqHoRqU=; b=EzFHZh/5e7IoOFWG
	+bqmheangMNJWdfAtHShvJoEfl+v4zq/oxNE/T1GAyS6w62hJzQjT8XbJeSXr7sC
	Y3SHpF6tkimv8mvVlGy7ct4gp4BpWNn7cpcQIzhKuTMUenJDQ1REFM+LkaqV//Nm
	iAwk1f0kGFBmyhovrYyLInTrMpM5lK6etLZKCMIXdEGyYWQ6ITU582ZLKy6yKv96
	PgHS3oywIGumxXWHy4onSRR7XtsSAi38dJUbIdYxrSCDpG87C/5PTWhXOGYYzQ0p
	LAYV7hCbBH33PZ216dHcA/ppGLYY7Fb0oybGR9rcMuzNWOByTrgesZHfZzeyCEyC
	xGgeUQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1rxa3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso760883a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762958911; x=1763563711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeckgBCqYzzJWW3WF7l2yuaurdQXFJrxiMzuEqHoRqU=;
        b=Whe+yvmbB9UhcYrIiUB9E29zKguXLSFH31o4JsKl801r6cyr18vdbk9vCWgGdbT7Qc
         qtFEhNfYZBJDwd9ptOCSmTtP5vm897tV1qgd4YeRWDgFxCpfyCYhy5O8cFqiVsyE78Tu
         4TQ+Yt7A1u0NePipMPunwm87cdZCLNDOTT/Rrbio+k1dS2PCR3h2fbY7ymD5TjrG/Bet
         KPJ5q5WqLI2UlHGtUj6htAKg1e/rtr3Dm+kli9X4s+XQS9hYhHV+CGEl987ktm/oZKRI
         WPDvTATfHsjkCnUseJqn5xOPIs0bT7nyBfXTYfxXxEmKIW7YRZZHaSDnxvoj8WjVxdSs
         CVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958911; x=1763563711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TeckgBCqYzzJWW3WF7l2yuaurdQXFJrxiMzuEqHoRqU=;
        b=JL3tVayCHoKndegvMzXDcqNYUN+2DjN/1OQpPe5q4IspoqMhwbTLobcPTHOp6uBEVm
         tBEQSmllCkWatg8jSFNYISrxdv7i5j2zilhsjU/ekRW1/ccGzFpk6lXFR/OtgRIzfQ2o
         BA11bT19XwEJHpx1oXYu37dTApx7Ev6uSassp/4kIk0syy+zeRbywHJMrU8g7c3iDXKy
         gadbWVKWQqUJWY6q6LMsEx0L2rl39JytWS8vPR9fLWhDB90YQ4RK8LdoNwRWlXQ623Oj
         /84PZ/8p597vpYYqX5VIyk8lvvrNbcxWbr7GxdZSaO3ZzdkC1J8kX2pZ4p+/w3zIW2Gy
         Mclw==
X-Forwarded-Encrypted: i=1; AJvYcCU+nBZmtHc2Z2zmHPanCXgXjaoN0d0vR9i5UBgOlC6gwvCR6p1lCisWjeFMxUI55YYdP/DgQcZ6/InS9Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bB3EI+xGoBNN6khyw5OpyamzAewH5tulkLm0U1/caareNkn3
	QloCa5lb20E7FkoWtK50tWGxENFnf3YNHFexsvBBQS+XMZejGBuBHt4aRwoGKt9usWCfWp0d2D0
	t+GCG0+a2CYjc7x/IX4FED5hbAP3zpJ2GocpSt+jCP2U6kG6upF3P1vzwZJem0GsZhqo=
X-Gm-Gg: ASbGncujy2A0MERN4ow1O3waEE5U0RSCH3lNYaHqBrL8icZHa+WdR4Hac5q0PDbC5lT
	z29M877gpfcvNyo51HQNlUrUcd+Tr4zW3nEaH+KjBEiKZnqGDjKRXyK4VuKHicuZl9Rsishnptg
	WXU8wCLw8KVW9eKAEM/XGI+vXRdwdpKD3iI9gamOdRZ9m5kJTTtIJtY1/uyEARt2YCxNS6QK8lK
	v1EkIaRhO9Z5ao1EEruK45Zb8GldhOTQCh3Ksd3veLQz/i5eLQU/rB6DaK62xAmiYbBWo+LrZot
	6fLvmDVy6PCpWAweud3VtwKsWN6lsl9B27VrHiX01r6aFfqp9jJNnJmJWXheILhuD60lCvJzycq
	nH5ya55kvzjZbQC7Dx1bMOJAaLQNlLuYTwqQjNcg=
X-Received: by 2002:a05:6a21:999c:b0:2fb:62bb:e0e with SMTP id adf61e73a8af0-3590b513a62mr4416285637.32.1762958911138;
        Wed, 12 Nov 2025 06:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCO/GuLnsi4Po4tG8EuVF09ugrKq9j6jmQRvi3hAcSlVONOB+JU2dQFIy9GLH9AcBX5W+z3Q==
X-Received: by 2002:a05:6a21:999c:b0:2fb:62bb:e0e with SMTP id adf61e73a8af0-3590b513a62mr4416237637.32.1762958910625;
        Wed, 12 Nov 2025 06:48:30 -0800 (PST)
Received: from hu-botlagun-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm19098234b3a.48.2025.11.12.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:48:30 -0800 (PST)
From: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 20:18:11 +0530
Subject: [PATCH 1/2] arm64: dts: qcom: Enable lvds panel-DV215FHM-R01 for
 rb3gen2 industrial mezzanine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-1-6eab844ec3ac@oss.qualcomm.com>
References: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
In-Reply-To: <20251112-add-lt9211c-bridge-for-rb3gen2-industrial-mezzanine-v1-0-6eab844ec3ac@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762958903; l=2971;
 i=venkata.botlagunta@oss.qualcomm.com; s=20251110; h=from:subject:message-id;
 bh=DyoaA+sChPIv23chjFgTleQ1h6QpQxmkBY1evOLH4X4=;
 b=QAscv/Z2HDIyvVtJL3hME2M2GNIRDWiJZg7bpK0KfStsqvBQo+Cqjj/EBNFT3/gfPnhE7/xYh
 HCB5VI3rQvkBwqLZIQcNiMMeQLOwbagSZ0nXiYbv7H0mZpbbvaDPSgs
X-Developer-Key: i=venkata.botlagunta@oss.qualcomm.com; a=ed25519;
 pk=/SnYBwlkTzDCLnHFgEY0qFwPgKIV+aQWRbc3naiLzrk=
X-Proofpoint-ORIG-GUID: fQufplxni1eiXyp7eFoyFeH8MzD1V6QW
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=69149e3f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zQPtESjVaFao4fvCMtoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: fQufplxni1eiXyp7eFoyFeH8MzD1V6QW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOSBTYWx0ZWRfXy6IlwA4jZMPu
 zjp0Ba6Sz4gdYzz447uPABTU45EJGCXurez0JMqt3yXdHLiPBcj6hEf4jo0BlT26xYjDcIsLOCK
 MLwUsBATZUI1H4K4LR30g4gidywajH0naVkzo9huEEfsKBgN10iFwuDusMA5OSrwGyBALLIH+0t
 npqkGl/WamlASF1fJILTquXRkIi65vtazOUsd/mXKndKxIGsPKq2Ye+PfB7ezFQCLy+HnzbnBk9
 sL0wsHFFw430cAf9XBBSKtiWrhA4XvjQFhmRjSzzGMiMPMfTBY+hCVpdtdvEZtgWNXYIqEfF6IA
 Tb+PvvHSNdFc5eO/gKniPs1EWnub9s9xUFFr8YnqHP2ALvdjRBo4U9t9bZdEtVE+CkAfGWgI/g6
 /PfboTMDnyMp3XftP2VXqm+F3a4Acw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120119

Below is the routing diagram of dsi lanes from qcs6490 soc to
mezzanine.

DSI0 --> SW1403.4 --> LT9611uxc --> hdmi port
                 |
                  --> SW2700.1 --> dsi connector
                              |
                               --> LT9211c --> LVDS connector

Disable hdmi connector for industrial mezzanine and enable
LT9211c bridge and lvds panel node.
LT9211c is powered by default with reset gpio connected to 117.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
---
 .../qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso
index 619a42b5ef48..cc8ee1643167 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso
@@ -8,6 +8,112 @@
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
+/ {
+
+	hdmi-connector {
+		status = "disabled";
+	};
+
+	panel_lvds: panel-lvds@0 {
+		compatible = "panel-lvds";
+		data-mapping = "vesa-24";
+		width-mm = <476>;
+		height-mm = <268>;
+
+		status = "okay";
+
+		panel-timing {
+			clock-frequency = <148500000>;
+			hactive = <1920>;
+			vactive = <1080>;
+			hfront-porch = <88>;
+			hback-porch = <148>;
+			hsync-len = <44>;
+			vfront-porch = <4>;
+			vback-porch = <36>;
+			vsync-len = <5>;
+			de-active = <1>;
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dual-lvds-odd-pixels;
+				panel_in_lvds_odd: endpoint {
+					remote-endpoint = <&lt9211c_out_odd>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				dual-lvds-even-pixels;
+				panel_in_lvds_even: endpoint {
+					remote-endpoint = <&lt9211c_out_even>;
+				};
+
+			};
+		};
+	};
+
+};
+
+&i2c1 {
+	status = "okay";
+
+	lvds_bridge: lvds-bridge@29 {
+		compatible = "lontium,lt9211c";
+		reg = <0x29>;
+		reset-gpios = <&tlmm 117 1>;
+
+		status = "okay";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9211c_in: endpoint {
+					data-lanes = <0 1 2 3>;
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9211c_out_odd: endpoint {
+					remote-endpoint = <&panel_in_lvds_odd>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+
+				lt9211c_out_even: endpoint {
+					remote-endpoint = <&panel_in_lvds_even>;
+				};
+			};
+		};
+	};
+
+
+};
+
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9211c_in>;
+};
+
 &spi11 {
 	#address-cells = <1>;
 	#size-cells = <0>;

-- 
2.34.1


