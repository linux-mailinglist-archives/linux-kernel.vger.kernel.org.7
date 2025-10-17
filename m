Return-Path: <linux-kernel+bounces-857535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD075BE70EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FA4F3220
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC0F26C39E;
	Fri, 17 Oct 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiVptCSg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03351269AEE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688441; cv=none; b=kJQsDa20EHuJLKF4j7hBOLVPbRYmhJobS54SQSxzN8/8uTrkCrx1VdyzbeDFJMW2El7z9ocJg8tTmyrlTOSRgUHXrYAeBrkDngsWxdGj5EaGoxmtIztBJ9o8fBPIsoDu1eMUPDlH9BAdcK18St/4A1nU3mjNsAS9pL4PXhsuy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688441; c=relaxed/simple;
	bh=MwtE5OhcY+XRVcD5CunNobuCvBq3rntMOCnaYglJxSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y+NbHAnJ8HRn2Zb0VqC2CcJ3zcbFWC5sqI8Hiido489gX8XbXh89mkLp74gX9YM+qfBq0mh2QtEYyLi69S3ecCYx1O3DkPAQLY/cVYD3DOoZedZXfH8yt8dOUFZwfY/XJggU3DhKMDgpENnpXlZb9cC/tabShTrRl9wukCLv0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiVptCSg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7h7Ym025233
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eqisdpW2ay/zMVI4Nuk53R
	ksQ9jjAr1yeLHAqtlIyFw=; b=ZiVptCSgd6oS14RgADwjuVLZ7kWKh8o0V+zMIv
	+9lmHVnpirak1BOLOrAxCi9FwomKwkNl4rlqMq/iqgtFH2tYkaHu6/m9PmSisFAJ
	zwTDNkUozJvBlHZNOBIQ+VY4V+rgJzCa+HHHmV5uJhBNQm8TUfuO8Cru4TlnoayI
	tOrRuTE3LrUrNUGgK8ysmzbpySeIfgNyZDsFdYwkIjQ2sGorp0RG4j6sYWXfql99
	6S1eNF/TfPexIJS7WbDXd00vST/tvpKXO0g0+1lLgeH4uQuu5PSt/nJYd4mqvn+X
	KvMvYAP0KL7uCCeP1xAu4p84WCb5rhWpZZ0XGakOtCPtpewA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkkd9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:07:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b650a3e0efcso1540743a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688437; x=1761293237;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqisdpW2ay/zMVI4Nuk53RksQ9jjAr1yeLHAqtlIyFw=;
        b=OB0qjw+XHzoXm2mM1DwWHVxy9Fx285YmVuNoY/57BEf0/oYzjhca3ZwRrm/uJJmOw5
         ejapJ3g5fmb573X1PTWMkXF0U562YacE7KQt/SiySdcB1755wE5MqO2aRrY61nHk4kng
         DOT44vZu14C7Mg6QDIQhM76iklTYKJ9NPDVxMXxayjpcKeRNnOkmhC6rQXSJ9wBXeV53
         1orEQa9IDcyhQIqRUcLAT+70PdOKGhOQcMJO2Eczs4KfdkS2P+Uu8/AZyVpxV3F06ysc
         mQw3GDwDQn2tcfC+OVoi0j5OFFBpTDKuekvjS1dnrzXzBpOU3I4Uq6AZlIbgOULAHJ8L
         gYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLQWbjOODFz5XKEYh55VaXeGJs23rpMviB589uRoyqcqu4yshPNS1i2f0O8Pk4Wo83gujNudgDwTArCSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxP9PFmavL9Ha70lDL3Y9rSWvOF1G08amSy4esQSuOR5pqLv6
	/xUMnLrjSzi+qmTMq/ysLJFUaiq0jJhkmHLLO6o9tWI4bbK6Co3nbbrDg0hxbWU1FVfvwfSqKP0
	1Rjxkdi+cpt7tjRdxg7gJpKfO3Y/iSie/HDCqAaC6SIMCyio/Ig+5XQr85r+QJh9JBxU=
X-Gm-Gg: ASbGncsoJz1J7KDgY/gyiFt+6dqzwCPQgFtmFm3De20beez4GQCNkFvpMRzziRVtjPR
	nzPr65hlIY5DFCAaLbKDzuNwBF7/xrkjSr0i5Ha3IsfV0GRlWOodwEah08khg9a42JCFlprCGo5
	aQyOpVys06AAvbuSSm5DXUcz3omdfGpA38HLyZVALH6MsWDLUV3UnnoT/S+7lNtZM6hl2aacznE
	5JEMQERDYfYbpUyhKX+lHoxOxKG6eO0Mir6dhdNTYTz1gbpnca0MuEPBr9fyzLEbFCR92bESJHX
	QoEZtfd0V1Y1cuyEuxz0abJZLSHjK1fPvIGHDbq4s0f0yQ/9XMKgkqCa2f0JfUmxcp9uM7mS5Oq
	/hyrJ79H9GNnRSQanpLnHFp+ke50WCey0
X-Received: by 2002:a05:6a20:244f:b0:2f0:91c0:1886 with SMTP id adf61e73a8af0-334a86444bbmr3749208637.59.1760688437251;
        Fri, 17 Oct 2025 01:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESiDW+VmUsc+tWkm6q2EUnLZFk9iWKP0hEG9qJkRKh/EsJJ7DiL8XFcq1oa/TlOr8g1PcyRg==
X-Received: by 2002:a05:6a20:244f:b0:2f0:91c0:1886 with SMTP id adf61e73a8af0-334a86444bbmr3749128637.59.1760688436744;
        Fri, 17 Oct 2025 01:07:16 -0700 (PDT)
Received: from cbsp-sz01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0607e3sm25380073b3a.11.2025.10.17.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:07:16 -0700 (PDT)
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 16:06:39 +0800
Subject: [PATCH] arm64: dts: qcom: hamoa-iot-evk: enable pwm rgb leds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add-rgb-led-for-hamoa-iot-evk-v1-1-6df8c109da57@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAA/58WgC/y2NQQqDMBAAvxL23AWjVcGvFA+rWXVpk7RJFEH8e
 0PtceYwc0DkIByhUwcE3iSKdxn0TcG4kJsZxWSGsihrXegWyRgM84AvNjj5gAtZTyg+IW9PvFd
 smsFQW1ENufEOPMn+6z/6iwN/1rxJl4SBIuPorZXUKcd7wv+qgf48v5RFYHGgAAAA
X-Change-ID: 20251017-add-rgb-led-for-hamoa-iot-evk-43ed6bda73a5
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760688432; l=1466;
 i=tingguo.cheng@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=MwtE5OhcY+XRVcD5CunNobuCvBq3rntMOCnaYglJxSg=;
 b=3CAHN5nGnGmGNpQP+INGP5T2oPXBkPBGcZ4GNUSjpLkfQ1mZAJ00v+vRLrED/9uQQPn9NO1o2
 y707DKgjLbdAyL37yXnqGz2Op7HbqPNv/l4wRlD5HgzN2cirlofzxY8
X-Developer-Key: i=tingguo.cheng@oss.qualcomm.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-Proofpoint-ORIG-GUID: Qccb9Qvb37TgKR9PqwHic6F7NXTePYP_
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f1f936 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Ehhsx6O6cmvpowC7fCYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Qccb9Qvb37TgKR9PqwHic6F7NXTePYP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXw/6IMkab7duS
 t6FkBBZ4ft/CdAUTfeofrcvnLOgc9ohSuUoXXi6jTJfEbQVNcx+hwtsSIx3klrSBQRNNApeXyS9
 Bbm9XW1DCd6IP85auiHFfeOs529U5DNG0tMqcNL1u26zsWRcxjiLj7HlUybNZmQbW0FkNSwJ0nQ
 8iUdHd2qkOklHQvFAMV3HqsvOmgjAOvbOgnm5rTng2ik3i/GNvuXWa8GHkRE1iL3AeapxdxJfDT
 yZDY/c7QuolsWLx5u+f4XyXLOBOFppJhqV/ds53O2MATXKxqET7HrnuAcm7LkBVYPB3MZj7cMRL
 cmm4q2WzdbTyW5EsJQ6yF5JVdWezYXReVfmEzci7JUfzyOhM2ZmOGEFNTkocZwwZE024QmwPiZQ
 KHqb3X1ya60fr+L8MhubBR1WYnt7QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add red, green and blue LED channels for the RGB device connected to
PMC8380C PWM-LED pins.

Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index df8d6e5c1f45e04a9f225b1df2ac6d4c4930e83f..a0b392984f43b6f525d6e82c6f31416b93795b9b 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include "hamoa-iot-som.dtsi"
 
 / {
@@ -867,6 +868,33 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
 	};
 };
 
+&pm8550_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pmc8380_5_gpios {
 	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
 		pins = "gpio8";

---
base-commit: 18ffc9eacb541fa128e9e529f8fd6c6e795624f0
change-id: 20251017-add-rgb-led-for-hamoa-iot-evk-43ed6bda73a5

Best regards,
-- 
Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>


