Return-Path: <linux-kernel+bounces-743267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4EB0FCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E85F3B36A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D3273D9A;
	Wed, 23 Jul 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/OG39x5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAF273D9F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309681; cv=none; b=q11T8RK+Rs2+T/J0tHWjKBHrfI6lrXTVwGUqXSFsX/I8Zu1nece7hs/M55WVxQL5HnA+uc3Vw4KpZU9KFnJfo8FqldpxP+XyaS69xlKsENYlClsA8dB+3HCbfpdCbhEhUJ7YmgTpzYkdkAniLF1b8T1c+gidKVD/2biIvz2/wX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309681; c=relaxed/simple;
	bh=8sJ2i/TalucOlRVRq59ieDmM0h01/bZurJGh4IDevg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnVlcUa5QBndRqoKJkBsuMxwuUMcECBOeKW0AvNWsCp3ET7CYQ1UFrBdmY2WWbiPGNbnLyf2Sa5DgsKcQj5iLzxXnXWva8CSiLY/hR79hZ957aoXg4FEhu62RBJCevESxVQxm7NrXMQowHLsvhhYwsC2SS2f6zDSIhDY1wpHPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/OG39x5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHBuN9009270
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oV7AIIt1QyA
	o8wPjxuzZpCSCbMZcDPvWD/2IfvRI0Z8=; b=n/OG39x5A+gfLLtVc8AWV5IZyD3
	1v8dc5s3z+0JFWF+5nRq2uEyeZ2+l63vSVji6DBEkx+T9hG7/Ftn1qGiy5AmAC2f
	JmnEc6te/1F7V/qixBXEV1Y029XfK1aM730diud/IAZnzQCHtj5e8eu/cs9DBxAn
	+4A7f6tN6hQjagvxmIzzDYBBuz5J9R2SLiYtVSG8/Ycw7RI3h90nAxF5ungLkS35
	xGny8HZxTPxdFYTHcYlBDVKqi9j+2Q5wQd5fV1EYdIcjnOr8JRyOZ1YNfc3WsNuv
	Ttd0Owi/6fmRdAP0t5erp85U2hgdAkXrYK1T5n+377aC/j+iLOWsopgkm+g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na5533-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so124881785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309677; x=1753914477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV7AIIt1QyAo8wPjxuzZpCSCbMZcDPvWD/2IfvRI0Z8=;
        b=UeFwQNwqglLCyzzvYcwZwsvRRBS45mxMQRSuS8bIjsRUNUR296rdMSr/0935Hh4+Fx
         6A85l748pSdoB8DGHJ1pTA+NfnnmySJoPawv8g13g1YKGZp6WVcbPFvU/g5gsYRmDPpE
         bhyExyi2lVHBQW1WgxnwUHUA71l+MwiIzf4K3jg0NSuOcjjTvbg5loivKtq8q8JRwl8y
         5MbMLfoey7BCSbcUmIuU8+Sa4Gcxl4FBKUoyZPs1DlNcWhxhgiYNP1txtMgfLPZg9FTP
         rC+OdwGgeQ9dUjeRdDAiyyit5tNLFzmki9wyViw5SlSVmkqEu5aIJyoTJ/IAcvbKxhub
         9Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCU5W8Ca4t21TEkPkEXKN6+YX4mc/+DkW+FvwLEUHNrYhOdt/V7frPENUeAjnh59nix1iGTv5gpw8GxfHXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN/FBOIE0tvL1yQwWYZ3HHYXL2GsZPcF9+/ol/+Npx2WTxp1m
	c39PsugWwn1GxFIDQrRXqi5YIJqp+Ds6UPALZJau3V/tpLfX+NoHrdKma/p5+CB1f+YdOFCoVwG
	6A1t+es9nd3Q47AzrpvWDQypVg2BivV/i9vtTWPEb9DWMYzNbpL1AKHzV8smg1UVnDcY=
X-Gm-Gg: ASbGncsg9vB5sSamyTr2TaPjS522SzOuqYaSxPBWAL4aR/id/SYWyiSsswApZAhb2z6
	t/8fCiUD1OgufnwgVL8EaSZsw14n/TDNSHZ1ttlaRmnLEAYYyqAP9E9kCaac4bjpv469AXmNycM
	5eu7a9AG+eq+Sm1P7WMKiQOnAUi0LIaQggRFZYPk4dxkw0ntZy1GKgh4OvIavn1N+Xb9cqjq7+5
	DYz6jzct1ermf3wN7KS/gvdaht/Tcf9+kpTVAHj1h5ApZDjWkXSG4j/MOUNKOcGnXk8HP7XWeyA
	FKd3HQulRyIlQcW5Hl22I/IDddrg3fDVmcGaloqOQJjfeGCV+OSCnw==
X-Received: by 2002:a05:620a:1792:b0:7e3:4416:1032 with SMTP id af79cd13be357-7e62a19b95dmr520874685a.59.1753309677304;
        Wed, 23 Jul 2025 15:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEztatUjuAJg5viKWoocKG4lic29O+zmUfZlMzk9L/lrtIJeODRaPJGCnGZme9YcIro3nirAA==
X-Received: by 2002:a05:620a:1792:b0:7e3:4416:1032 with SMTP id af79cd13be357-7e62a19b95dmr520872685a.59.1753309676900;
        Wed, 23 Jul 2025 15:27:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:56 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 05/23] arm64: dts: qcom: sm8450: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:19 +0100
Message-ID: <20250723222737.35561-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xotsYgZlRl5MF47VUXjapyV9H2DxUVyq
X-Proofpoint-ORIG-GUID: xotsYgZlRl5MF47VUXjapyV9H2DxUVyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfXxQG1B1gV46Ug
 ALEwd58xGsWE19O0uqIRLMJ8SbrwmP7KoyuH+8CBekEVjvhBdnOjwVeQVzokmgPqaKkdMZ5itdP
 RXRxo2PTNRSYuh8csb0Yr+isMT9+75kXqFOUiUZMV4ohBBstCoH88gwQShq6WDQChoWFpUdalv9
 MmiamV70BZAsPCm3ErORFFr+TYMo0kydYCnqTC0zWQ8NCnVY5QnKWuOgeExv1t24SHEisIEEyly
 p022Z0zvXaUx6Z1B5nnGtI0zv0z60PtPVy0lAxA/5zEzg/t2fpnVe+fo94mwGOzH7Tig88X8eiR
 lAkDf3Yc+HbNJcB42XJgPa7N6SIFTkFwfsnERq+L17/EDHi0rHKe0sQO1fWq4F+BTsM/UsQjGO9
 WoFIlIvKv0vucmR6WPwhZgShbWXRNYX0GAa0SOqgNRnMLQE4rQV1KpNRqpTxebSzLqNazX8j
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=688161ee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=aONcyR_MLncd44ar4gMA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=713
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450-audio.dtsi    |  5 +++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts       |  1 +
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 39 +------------------
 5 files changed, 9 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm8450-audio.dtsi b/arch/arm64/boot/dts/qcom/sm8450-audio.dtsi
new file mode 100644
index 000000000000..1478326594ca
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-audio.dtsi
@@ -0,0 +1,5 @@
+#include "audioreach-audio.dtsi"
+
+&q6apmdai{
+	iommus = <&apps_smmu 0x1801 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 2ff40a120aad..d528df226eea 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sm8450.dtsi"
+#include "sm8450-audio.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
 #include "pm8350c.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 8c39fbcaad80..8b13b09d3b08 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
+#include "sm8450-audio.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
 #include "pm8350c.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index cc1335a07a35..fbb2d6292163 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
+#include "sm8450-audio.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
 #include "pm8350c.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b9..fa0822c37854 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -21,7 +21,6 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/reset/qcom,sm8450-gpucc.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -2783,43 +2782,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
-				gpr {
-					compatible = "qcom,gpr";
-					qcom,glink-channels = "adsp_apps";
-					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-					qcom,intents = <512 20>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					q6apm: service@1 {
-						compatible = "qcom,q6apm";
-						reg = <GPR_APM_MODULE_IID>;
-						#sound-dai-cells = <0>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x1801 0x0>;
-						};
-
-						q6apmbedai: bedais {
-							compatible = "qcom,q6apm-lpass-dais";
-							#sound-dai-cells = <1>;
-						};
-					};
-
-					q6prm: service@2 {
-						compatible = "qcom,q6prm";
-						reg = <GPR_PRM_MODULE_IID>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6prmcc: clock-controller {
-							compatible = "qcom,q6prm-lpass-clocks";
-							#clock-cells = <2>;
-						};
-					};
+				gpr: gpr {
 				};
 
 				fastrpc {
-- 
2.50.0


