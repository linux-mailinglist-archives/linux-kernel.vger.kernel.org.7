Return-Path: <linux-kernel+bounces-875894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89FC1A0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EA51A61123
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967353375DF;
	Wed, 29 Oct 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gKlqXNf2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7vreGHq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73067336EEF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737422; cv=none; b=nTZ6etq6UfkRngJPe+CX6r9rmFS3M8yQ3iAKTIUBOc7emf9heZ0bMvHKuQaUoXbG6GPcLcretjNJkVFVWK2wUpmMLCl7ay0kDNlRtAfApd5cnSzwK/TFca1Puk6uXa+JK54K57eqv7WRBdZ/dzZ7bao7hLi/A2E1JfScS5RqNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737422; c=relaxed/simple;
	bh=HTP7hwkQqboLVMLasC3ig1AuOdloM19T6/dneNwv2QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sy3QiPZ88d4aXw6QFSNC//cF7NzsXNkoiyW/pNI5bMTOQLeMZW1KNk49zEEmpV3DSKpvFZ0aRpIE27YfeUM2WgUTTxYEGrE7jwdDrKlSbPESPLN+or8qIeywgbL+UZF9XFFcH0UO3HEjgj3+zqzgiM17zBdW/q7lNndAU0SgSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gKlqXNf2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7vreGHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vCee3664309
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+/DNHEe+4Z1utUjpUpHGNxyDDFtPWLU0hZo32AwHpNE=; b=gKlqXNf23iN6rv3J
	DfXd8ubxqExuHilSc+trEufJCGga6aEv1S7wl2TOYEkEHMJuuFcsbjDzfsauDQwc
	9vOAvxjyuRw97GgM6mAPWJgDWcHc5a7WbLKPi7If9wKT2nwoWRHZfKGkyVREwxLg
	QZDQNrFO8+EvsTKgi084pZ3JPAv13QDff3hslBNS0SVm53alNXxxIgvno5VIJSR8
	hb3gmVed3v0SaWwQbf25uS+MQbm0OD9egnHp+1dMrERh76dlOrXNSqo1McTrSnU4
	itZtlfJP/adc12KLmED6HZWOTIKYwZCPZrh6qJ5raGJvntTPmVBRv6naX3XStUZX
	x3Qj9w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ta8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so73802445ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737419; x=1762342219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/DNHEe+4Z1utUjpUpHGNxyDDFtPWLU0hZo32AwHpNE=;
        b=V7vreGHqIHjdvLwYQh22ziqKlvURuoRhhfQfeW3S+EsfQ2OBY+3c4/R0wQwlTg8MeD
         QtwDmOxtNd1p3fGgS7y+BT3AgXLsL1aiX04LpXV5OfjSlvidoelaqSFIbvxDPuUgU4rg
         mODxcsxLjF4cG6FyYZEO8FKsP3jdCAO5zNYLcQlwzchVxNCgYtnIl/OgiEfzeaWVzztT
         At+PwNtA4N0wMfgx0rXXpx3xhgO51W5HjBfIlgvYp1JuE3QA54gJoFjnzbQlD5QfIHy3
         KAfLhwSaOdVEBxpdbX5A47FwIj3JSmczqwKxIKc7oEUQdf1999c/l53mZpnYJ828HNnG
         lYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737419; x=1762342219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/DNHEe+4Z1utUjpUpHGNxyDDFtPWLU0hZo32AwHpNE=;
        b=pt86Y1dSK5lKDXqd9kvsmjpNEuwxvc9JYQ9bY7X0WniDq1/ehVWzwEqvHppEAk/a9M
         h1MHO2ZFHyk7DxpupYZOUTkD1W4O7E1jQdEsh7eVs5qpR4UTm53P+BYkmKiEGJRapar8
         u9T3p3SVjcTe2+SUEeQo+Dqe6RWrvZ9LomPRskmReSzB8RXXoJ+oCBjHXIJpHHLahuJt
         /PVcarqW57eG97vmJ5Z+zJAvvNd5dtFr6QHVGRJpf+xzgNIVdOVOSaQO2MbsC2nO2TEQ
         AOiRvTMBggltJd9eVYcXap179PG3ZtzWwh4fT7cUa8Woo7MPXXgA+KmiJq1AOjThQrMR
         Moug==
X-Forwarded-Encrypted: i=1; AJvYcCXZEOMkdLPJADidMT+BB735Ux3QJjt7TqHNA2StD8QXLjv9kjs27MsQ3p4735Y77BvsKdP8c42ni6bMHkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylwSbyOt3wEbPn1ntgyCPrUXbSy0SMbEN83XviTGwCMa4Al7Eq
	D6QHg8+lxzoXw9C3c6NcoE9C5/pI8QvDxp5F+E3QVnXCJ7osirKQAB1M1HzzY0iMVj4OouR+hYF
	CZcGjXyM+5UIxV63i+6VJ9X4uGuee90+tjr05yTOS2BP6o7wDTEGVhznrWxGnuDO8hds=
X-Gm-Gg: ASbGnctdUBuJE4ji2q0wILAaF5qoi3Y4gR+tjGW3pQ2lyOb3RJnpjP5hJmg6HWsnCbM
	vmvt788kdLqu9qhddwUnNJMi5jd4RBwCjg+t3z/VXfVKi026L9EhqAP0ic10EWHRwvl93eIHuv4
	MgMWck/qZmkpBd9Bs+374zUN7yF1nyia1kWttA7y8NA+MpYMCfoyzXUe6GAdvTqTJy/gJ/LitS/
	DVYn5bpZu92P51fe8hg4JJCL7kf01NfuUsMuQuDqwl1/irQlqSl+zergbW704hH5Pud9NfSDk9/
	ZeYBfa8UN6FbncZstHIHRN33SoqsyPcXkNE/DJnlNEDK9rV4hn1RB2VKlBUOTHsP7lHygHugLXZ
	r8xQPZnf/vnZZ8uCc5TIMXGn6ykWOfqyP/w==
X-Received: by 2002:a17:902:cec7:b0:290:ac36:2ece with SMTP id d9443c01a7336-294dedfb651mr40425565ad.18.1761737418818;
        Wed, 29 Oct 2025 04:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4j3okFkfV91nMkxAanoxMqQ3b60canzISSr6RYrYCKlojn0pZCA+621Wqputq2RMc/sjnAA==
X-Received: by 2002:a17:902:cec7:b0:290:ac36:2ece with SMTP id d9443c01a7336-294dedfb651mr40424835ad.18.1761737418130;
        Wed, 29 Oct 2025 04:30:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:55 +0530
Subject: [PATCH v7 2/8] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-2-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=4927;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=HTP7hwkQqboLVMLasC3ig1AuOdloM19T6/dneNwv2QY=;
 b=9TMq7HUBjr7g+iLM4lYpgTANAk/M3I8+KOC+2Hx5NNMsHIf2bYRwidDpz7x0ncOXOSicHPkfO
 CImySy/oR6gCQturz5Dn6Rk/+5j+Mt/DJhdD/lfMEjtNK2K0iXYBYl4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 8w-_7V74GpWxcK2qZozhVRrJgPyvafkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX12flaN0fYymN
 BNxqysVtsRO+fO3uPm2pahpXk5fA0k6wrbDCyjeYY+uMFzIgAxpKSrTTAkqN5UmVBdzCQPYztxg
 cMykBDCPVAGJUsXJFtoBPsdY2nkQydGiQMKP/+yJvkp8wqorO5cvhoefi60XZg4naZtA3NalxGv
 snKtyeFl8tDGowF8Gxv/+UZOOrp3Ajtc+b1nE+p+YCHmgbL7knxD8ph/BOzppymfa+bXUpb/Drs
 NKL7G8L93lX1H2aW6ZzkVOu7jRVoU1G7jK55112TBFhTGaO6hb0TccVwxXunzmUXITxIkptY7OG
 3VnqpMFQKas1R9dAMOpN4CUJZZ4exzOViw3uLi8hXea+h83/4cWWuX/P1VHt7TpE12sq3RD/+Km
 mn5UbBOAiY3+GkWSC/6b1niBlo19gQ==
X-Proofpoint-ORIG-GUID: 8w-_7V74GpWxcK2qZozhVRrJgPyvafkl
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901facb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=UN7QK-OhvXrGNVVRcS8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Add a node for the TC9563 PCIe switch, which has three downstream ports.
Two embedded Ethernet devices are present on one of the downstream ports.
As all these ports are present in the node represent the downstream
ports and embedded endpoints.

Power to the TC9563 is supplied through two LDO regulators, controlled by
two GPIOs, which are added as fixed regulators. Configure the TC9563
through I2C.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 128 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001421456dc85547c3c711e2c42182a..c8308de1116e07f83f345faca0f29b9da3c4f474 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -262,6 +262,30 @@ vph_pwr: vph-pwr-regulator {
 		regulator-max-microvolt = <3700000>;
 	};
 
+	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_0P9";
+		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <899400>;
+		regulator-max-microvolt = <899400>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_0p9_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <4300>;
+	};
+
+	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_1P8";
+		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_1p8_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <10000>;
+	};
+
 	wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
@@ -843,6 +867,78 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pcie1_port0 {
+	pcie@0,0 {
+		compatible = "pci1179,0623";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		device_type = "pci";
+		ranges;
+		bus-range = <0x2 0xff>;
+
+		vddc-supply = <&vdd_ntn_0p9>;
+		vdd18-supply = <&vdd_ntn_1p8>;
+		vdd09-supply = <&vdd_ntn_0p9>;
+		vddio1-supply = <&vdd_ntn_1p8>;
+		vddio2-supply = <&vdd_ntn_1p8>;
+		vddio18-supply = <&vdd_ntn_1p8>;
+
+		i2c-parent = <&i2c0 0x77>;
+
+		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&tc9563_rsex_n>;
+		pinctrl-names = "default";
+
+		pcie@1,0 {
+			reg = <0x20800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x3 0xff>;
+		};
+
+		pcie@2,0 {
+			reg = <0x21000 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x4 0xff>;
+		};
+
+		pcie@3,0 {
+			reg = <0x21800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges;
+			bus-range = <0x5 0xff>;
+
+			pci@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pci@0,1 {
+				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+		};
+	};
+};
+
 &pm7325_gpios {
 	kypd_vol_up_n: kypd-vol-up-n-state {
 		pins = "gpio6";
@@ -1119,6 +1215,38 @@ right_spkr: speaker@0,2 {
 	};
 };
 
+&pm8350c_gpios {
+	ntn_0p9_en: ntn-0p9-en-state {
+		pins = "gpio2";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	ntn_1p8_en: ntn-1p8-en-state {
+		pins = "gpio3";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	tc9563_rsex_n: tc9563-resx-state {
+		pins = "gpio1";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4b04dea57ec8cc652e37f1d93c410404adaadd5d..23cf2c8c72b0bab67467e4b60cd57a3e658efa68 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2424,7 +2424,7 @@ pcie1: pcie@1c08000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1


