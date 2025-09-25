Return-Path: <linux-kernel+bounces-831506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F6B9CD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355034C0B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79471EBA1E;
	Thu, 25 Sep 2025 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsM+KoOZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5D1D63C2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759465; cv=none; b=WElpvgiTXBx/Aui7atl7sGRCeoGUxt7kx/OHFHKk5e4YbY9N25vycyXwBqGyJCpdFpea3beODFUXWH5rubsUeFy059JHQBbQJg0o6xf19hstFiFhmUYqoAOFck4XLDtoP/x2/0MU/WKGRnvYJ7HPD9PhmXLrdeoggf0TymYgvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759465; c=relaxed/simple;
	bh=cLoxJH74vrqYbtUuBHn8aa3BXqHru2oih7gavqALDBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfUfWJAZYWee2nTDxu2lBY+6Q8qpXr59T7vSMS5PDlNjdJEx83Upzt68qcc8nkrSWa/+SZQ2IW/WYP8xq99tZE7SvuPNBun4SmZNXkZveA4YQM8GAbUgLNqKCXOU7EXtt8LeMuIch/SHx5W8yjhDoodWilzvsWWQMyxaAhTs8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsM+KoOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODM0hR001948
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bO9aMslpCaq9PTnegrcrfDZ0fb+86c2ZH4GOoqSZsBc=; b=XsM+KoOZCiRNk7Co
	P9JtgsK5b0iyAOjI+U6Oez7PlfHYOfrPoRFPutSzabGiTAbmAgMJnG2i5s891hE3
	MDC1LyUkpJUvCBB1aPlt/NOLq+EY9TACP11q+3kENz3qeHvpClficuumaibsyRZh
	Stn/MHlUBsWOy13DCjIsAg84V1uPHvHd+Lmd943R+TnCIMZ9dG+B7TCOPKb5vqp4
	/gqGxvCkcPFLohu/dNnuriEDJIenvVerJp42ON1m0udWztuJ8jLyYXi6r1jE9myd
	dtC7Wo0BMYiSzogo+TswuxlFuDuUhsoIW0IkbPiqOwvQ9tDHxv8U5vI7cKRu+tnM
	WeIgAg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p5et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so311931b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759461; x=1759364261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO9aMslpCaq9PTnegrcrfDZ0fb+86c2ZH4GOoqSZsBc=;
        b=P/VHWdfD911U31TO/MX/vk/oqQLVbVuN3xXsoeMkmKwVYCoxGF/Glj78HYs3jbA2Qm
         z7u98TfoFOaJzWQQ2lsRIROfF3hovZWlk671DqzDHFKOSiCOVzlhG//kXO7jigBEuwrk
         VG7onSvmonsaMOIambaLXgcfl4/MwXFfVCdrZxNRnKH7zARmq9wHA84k6rkJEBQTqz8j
         YOhjSZQiEu5c/vpnJPrFTly1kbsDCOg8SYrzPrDfabT0D3q2ZRnlkZoZsSDC0H1NFNRG
         sIES/POVtb21YPpNz7kjF8cLVjHxdpakIfG5Xt/WnxMB/sveDVn2MmcCCMWFiXCcEh9C
         7pcg==
X-Forwarded-Encrypted: i=1; AJvYcCUqjEccb98H/bDq+ju6loggwJhuIdUOtpbjsFxRHFW9lnrlkp2I1xs9TbXojvzhMuxTUSUf1MPgveFDT74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihkCgGqR6+EZNvtZRCm+dXaSPTZI1hVkPdgRaCob16u3iE+ED
	5z1270rmGu5VwijVC94/+Ks+C3QsdrV26BhQchApWzqPBeGvziR+zSpito92f19uLpokQRaV62G
	xRwJhawPh3g5Q2Z/+bW7vRXX/LOVwGJkeRJMfQtQ8di7K8uSlgZtE7TPUG9wekRIq/cU=
X-Gm-Gg: ASbGncv+1YBpEA8wamAjPuPuaBto+QQuvNGKpZkJipLT76CIx0l/30xFgD7K9dRuZPZ
	fmbbZBGfEglfbuFvCzk3vNNwWvO64qfTrGCn6jEd+b0Ig7EJlPVIfCre4vpFKwfmb8DtynaKIsr
	o6Hqd2LfysF1b8VygfPqHGv1u4eOPS9lRhdNBRAQMDwvL2xK8Cy5oDQXMqIlDC4WS635Jpt5vYP
	SFTw5vyIfHJ3EJPPfe5G5kfWIoH+0nrshXJSCGz7Ve8n0mvQaSieT9wOJtC/Q2aEiatvoJmsZTP
	I4O85dF6iKa8CuLnUpZHdEFmpyFq/Fa/IO4YH1ibu9l5QgsTUt7HRoZtI8HXCdnhfWr/PJKUB4f
	bBIfUu/gGaCN+vkk=
X-Received: by 2002:a05:6a00:10c8:b0:77f:47e3:30f8 with SMTP id d2e1a72fcca58-780fcc8ce0cmr1734701b3a.0.1758759460877;
        Wed, 24 Sep 2025 17:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBqkT4uPZvjcgsbgYzO6/mj109es6acVeBrXjvXQWADEjUCYPSS8GBB20WPMQlxID/RIT+oA==
X-Received: by 2002:a05:6a00:10c8:b0:77f:47e3:30f8 with SMTP id d2e1a72fcca58-780fcc8ce0cmr1734684b3a.0.1758759460468;
        Wed, 24 Sep 2025 17:17:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:40 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:25 -0700
Subject: [PATCH 08/20] arm64: dts: qcom: Add PMK8850 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-8-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=2295;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=so7As9lgNRUEUJsam60cYh6XAabDoOqSLDtAAVrBfS8=;
 b=emM+bp/QcED66qRS/UmJA75ZO8l5cPZ7uIw9srL4w8SWUnWBIoYnfMWB1UbgcZc/GgNm6wIzv
 UuauWsgpvMBDm6FbXLSV5+Ov+8mc6tUfh6+Rl7NxHt17xCRWQV7hQeW
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: p5WybsLzhjdpAsNjH3lnzas5Qib9pmQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX2Bg3o/B6RGHC
 JjNO69PxxuWhvhB/9Re3F0EgScSvr4EEZzj+dTtuN8HaRn/vAiNjjWWfjKz2RptoEW8UxgrCtVv
 C5135f2LakUUZ2yx8CDL1Y05U7owe3LBerFR4G8jQBynfEPDLIuEuCDk0j/fiVsd5h9Xd2Y8+o1
 4ZR7xGwtSc5pzuSlUO8HjJcqkf1YWdYetUua+pi+w3nrF7cZ0ZzkHG21rURqwGdHJpMzGHETX+f
 9VLoqm4axQVvGtWOE/vv/rWvE7maptUNzEOlaqXtz/RSGkEELgF8aivqh21NhexHxPaGqQAKcc5
 8xXxbpjX907Z8etpvRWw8uYzi3sxxfegDJkY1/KLVFeDQ+r49gebcZI6Xwva53kGVWYw7MQOOQ1
 N85dcztd
X-Proofpoint-ORIG-GUID: p5WybsLzhjdpAsNjH3lnzas5Qib9pmQm
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d48a26 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=GUxdZaKfOA20PjBdMv0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add base DTS file for PMK8850 including PON, GPIO, RTC and SDAM nodes.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmk8850.dtsi | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmk8850.dtsi b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
new file mode 100644
index 000000000000..c19a98ca984b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus0 {
+	pmic@0 {
+		compatible = "qcom,pmk8850", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmk8850_pon: pon@1300 {
+			compatible = "qcom,pmk8350-pon";
+			reg = <0x1300>, <0x800>;
+			reg-names = "hlos", "pbs";
+
+			pon_pwrkey: pwrkey {
+				compatible = "qcom,pmk8350-pwrkey";
+				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+			};
+
+			pon_resin: resin {
+				compatible = "qcom,pmk8350-resin";
+				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				status = "disabled";
+			};
+		};
+
+		pmk8850_gpios: gpio@b800 {
+			compatible = "qcom,pmk8850-gpio", "qcom,spmi-gpio";
+			reg = <0xb800>;
+			gpio-controller;
+			gpio-ranges = <&pmk8850_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmk8850_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmk8850_sdam_2: nvram@7100 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7100 0x100>;
+
+			reboot_reason: reboot-reason@48 {
+				reg = <0x48 0x1>;
+				bits = <1 7>;
+			};
+		};
+	};
+};

-- 
2.25.1


