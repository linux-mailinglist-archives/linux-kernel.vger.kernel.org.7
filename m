Return-Path: <linux-kernel+bounces-620870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33449A9D0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 20:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB31B68A92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8D21ABCE;
	Fri, 25 Apr 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrGyRSr5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE3219A97
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606734; cv=none; b=m7mnXfZul1UKueXidLG7JutxwK3ajRR2o5rn6UFYBYiTsdqub/+cZfkBOu7ZejGmGpx5t81iVH0Rs3XwNu+NsxpeIzwuzEWLGueTA2QAVoLYPTkzrbgRK5gaupwNwf8mXwDdDjzfKPsfZVKKa9cwnozNaSs8k+IGO1FTTEOGMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606734; c=relaxed/simple;
	bh=NLvBWaP6miKEKIvfuImkI2x5DMkgnU/KiaqwT5Iec2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMXEtIxCatI73cJSV26GsCVTkzSRvPe5y4ZvvsTvpflvxyfmXdUwg9w2bab45pleOxARUpu0UJKTxsbyq07C0alH47rVuqQzQM45XOForQF7aOk6sG99YPcSscAqXjnen2jhbkgGsCaDxYMMdnefkBNuR6BHkxZVmuCBRQgX8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZrGyRSr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJu0K004046
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JeUsfS/iF6jFVFsCwjfx5hVDX7vk1goNehrk1oCE8nc=; b=ZrGyRSr5ARUe4adw
	qTzFt7taN2S5+4ND0mQeeCN6EQrCx+LMkCfYILe2AYfwKgQ+7oyPbAkVYC8bspb1
	kUGWQAb5ZAqjkQHiY8EoKmXvokVc9cHdnBJb6YUoD905k6AnPBYq67GEuyB8bTcR
	jZSMMk5flTaspTd0W4Rih4IjixgXW+X8qH3EhWYhNYmNPYkSGg8cRTsjOnt1NvMd
	+2P6XuCW7ifQL5q4Jb4D8L5VEodEKBCN7KfKenJFjQyPVnGUSzFrKqPyxURygS7A
	OybUdMmiX7gIdTyvtPAtwaQiyoDyDRK91Tm0nEO9Emwvw0vGAcAIeZs3mdORw4Rk
	+uRkQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2a34q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 18:45:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c53e316734so419355485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 11:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745606731; x=1746211531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeUsfS/iF6jFVFsCwjfx5hVDX7vk1goNehrk1oCE8nc=;
        b=pchU7f1y0PKsP5hmq8X9PaoPqxckeoQTvdJUyC+PodpkUrIi89l6R8qgz6AuAYJke4
         mFSxVR3LU/aGnXrwmmOM8mO0bYVNYTfomQO44/kPdwQ8P5D4JGCkZhhGd48+wTGU1Ay3
         hFNx+Pg+xQNfUQcRFQGDvGAmznNddRGPuPHidRrs1SrosSE4tlqrRLXGc9f2OvnMnI4o
         WL9Ztk4Ind9y3aBmU6KptYAYUZ0JzZqydp0z7qbqrGIjW3HU5pp4E/+Mrz25cTMNbkdv
         yhDcsUfGFfczYo7SJUt8/o6nKyo083AoRYE0MF/N88/wlfSd/6mciqFKX1b7ATG6QeZu
         jkTg==
X-Forwarded-Encrypted: i=1; AJvYcCUFCJHiANcNZoktfsuhRO/gXNP3DUheOZnfIBP9xBqXR19u13XEmhZGUwiwGeC2c0S3osumKM7h0S6NdBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91AeVdtVMkG/ynYo7PlUYnkBQyxVFbSxAuzt2F5gjSNiOySPs
	hEOg6/4xOjFfvhmvBGUyaaIkgaHPtibBUMEMzRkFB4o6hN4lG5W6jGaN4hRQnDp2tU5loYTDe/e
	bKR6rJOvScRtiZXSQzXCOESmpcUW5IyuciSWb5nXkrJlRJaX+AGCeyHapRQgM8EA=
X-Gm-Gg: ASbGncs6b2dgTsGKbcKUBD5OQgf1hiIB0hedAmEq5Of37BKeMBa9s89uft+J+jk93HZ
	aQpw1KyqJnKQamvYvjzcXYFQzYGl9bPpwQv24YZIvqP3FYly2RfzSWYHVrONvicwp0tcQztJlLp
	Zgq7+PRxIBwaDtSUDlwkM7Im/6L0TGmmxAHjwoKCh0OBQndvaJQA2vC4A5fQwDJ5M4eT0/0CDhd
	xKkNwBcgsSaWZRfeJv0cFTEe2G9t6cH0kEYnKCeEwYcca7GctqlIaaMhix7yU47J5zcViIfAWqS
	MpaByUyGei2GmJvGxBKF8osv2WbQHGOli4ZvfG/155uMmeRm2C7axVPD9mkyMALaDNS6ItiBfg1
	/jkEh+nBGRXZhbXoRA3yEvcCn
X-Received: by 2002:a05:620a:4551:b0:7c5:dcaa:d799 with SMTP id af79cd13be357-7c9607a962fmr439519085a.39.1745606731095;
        Fri, 25 Apr 2025 11:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrmLvrDO9QMKCNEVys18DFYwMliBl4UQ+7szFFzUYHGiAGThoioetkEOIIEtNMw1HBFCmY0g==
X-Received: by 2002:a05:620a:4551:b0:7c5:dcaa:d799 with SMTP id af79cd13be357-7c9607a962fmr439515985a.39.1745606730749;
        Fri, 25 Apr 2025 11:45:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7ccb8979sm688984e87.257.2025.04.25.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:45:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 21:45:23 +0300
Subject: [PATCH v5 2/2] arm64: dts: qcom: qrb2210-rb1: add Bluetooth
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-rb1-bt-v5-2-154b35435b4d@oss.qualcomm.com>
References: <20250425-rb1-bt-v5-0-154b35435b4d@oss.qualcomm.com>
In-Reply-To: <20250425-rb1-bt-v5-0-154b35435b4d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6jZu0llZt2ksqY8VjqhehSjofML6pFZOsGwjGgW0Y8o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoC9hEl29MYW+Go/Qm/AFk7PIgABLnm27R7pIdX
 H3XAtvXBv+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAvYRAAKCRCLPIo+Aiko
 1Z5bB/42D1IkPhr6hS5n23n/SCGU9xq6b/jB0FEyg03qT6RSlCcI2J0IJulIkgLy2+GS2emLO4w
 8Wti7Kvp+pNjWNmHvK5pA3qCHzbVf9lwoAtEwISOgqc/jhhwYwgzq5qJ+DY41KA0BUT+gdqrniW
 fNpF4b1BMqFlyGVAPivcYF5bpNxlKvbIDxQoz+6K/yfrpnUyJPF7FQ+33geRwjC/QpXB3iuJVCU
 qRXAw27B2w8UUMHQzWeJqBV/xZUDz3jRB9/a7EDjsJjFVZLsyWHoqkryU6rnYyejE5DE83vtmqo
 DdJzZufmsZKrSo8Sz3u89orF3NPTfvA++Xq4YXQo2Jy3yGE+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680bd84c cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=oEaHH5ybzdHFOArP-YQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r1yhX7eD06VuJ2KLF0JeONYaTF9cJzKK
X-Proofpoint-ORIG-GUID: r1yhX7eD06VuJ2KLF0JeONYaTF9cJzKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMyBTYWx0ZWRfX8nL/+wYZ/0sG juMJJNhcWEuS1c1ZwMN7zhXZIcgLnZic7zNtd2lSxbzSTBcuC44T/wdaQFeTngv4Ki8251uip3v fwb7cOh9RbcEcj+lm2lYfDX3G2mt7thR/cvc2Yz2Nz4T6IOq0LVGhLeYxjpBJ4/MwM7whp/E9hk
 OqJeQbEx32zDGxIGGk6XC5Oe11pnWKgBr9EP75Cpd8noEmORnJCumDczTUtZ1ZEgwq3SJ5Vw3nX hsPRkpcA+Ss4FMMAN3XEuDsLdakSwVodmkU8xx1v2bnRgclUYALtbcjzn3Dhd8c8Z1Tz9fD6WL2 3uqBwM71jh4gY/oILC2VFcbnc6KsHQRZssKSrNZAqw42ncRXVgKi75PR6GDiSIXlFXXpC3TYG4f
 tYOYK8YiRWAkFNwmj/BfSXZJNxUoEclOeXaB1bWA0iY6nykvZNC0AQYDoC8FK0mWV7mybhTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250133

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add support for the onboard WCN3950 BT/WiFi chip. Corresponding firmware
has been merged to linux-firmware and should be available in the next
release.

Bluetooth: hci0: setting up wcn399x
Bluetooth: hci0: QCA Product ID   :0x0000000f
Bluetooth: hci0: QCA SOC Version  :0x40070120
Bluetooth: hci0: QCA ROM Version  :0x00000102
Bluetooth: hci0: QCA Patch Version:0x00000001
Bluetooth: hci0: QCA controller version 0x01200102
Bluetooth: hci0: QCA Downloading qca/cmbtfw12.tlv
Bluetooth: hci0: QCA Downloading qca/cmnv12.bin
Bluetooth: hci0: QCA setup on UART is completed

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 83 ++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index bef1fa782f1260e95e347abd52989d2da490af98..b2e0fc5501c1eefc7e037b2efd939126b483b226 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &uart4;
+		serial1 = &uart3;
 		sdhc1 = &sdhc_1;
 		sdhc2 = &sdhc_2;
 	};
@@ -549,6 +550,66 @@ can@0 {
 };
 
 &tlmm {
+	uart3_default: uart3-default-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	uart3_sleep: uart3-sleep-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio41";
 		function = "gpio";
@@ -584,6 +645,28 @@ key_volp_n: key-volp-n-state {
 	};
 };
 
+&uart3 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+	pinctrl-0 = <&uart3_default>;
+	pinctrl-1 = <&uart3_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3950-bt";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		max-speed = <3200000>;
+	};
+};
+
 /* UART connected to the Micro-USB port via a FTDI chip */
 &uart4 {
 	compatible = "qcom,geni-debug-uart";

-- 
2.39.5


