Return-Path: <linux-kernel+bounces-831811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC84B9D9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B223B1BC3335
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8772E975A;
	Thu, 25 Sep 2025 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hr/zeZSq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359C2E9743
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781769; cv=none; b=juP8egAJkuEDqwNloGsrC5KeipQc/53C/of1ww3wRdyK/KUEjIpNTvWzc2CEhaV13bLRF1edAdU9jGiWShpjou/bxnQEczGLk1PIMB8kMp6zzRTvzwHzGRMVsKMAedFKRBWQcQRINVJWmQhYzoVWs6Zy6XiUBeKc0Eb5eStvBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781769; c=relaxed/simple;
	bh=gQJ2ZTluSPl0btbHY5JBZLmKAc79qMYc1ayPNK0oRzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJ6+ASO5+/RUhCXtHG0cRG2mSWX9GpwljAzVb1jxyOUaOclT6YPNIADjSMRJ2GemKT3hGsi43B+S52tQ8ftnMVeOZGt4pwNBBAuH57NP58v/SI/wvitjic90Hap7sVCv3tna2AhrSRqlWJ+LovM0JdcLm7c0UbERgYlZoN8ldf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hr/zeZSq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONqWH1023856
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yYpcbaYMx/nDHjUz0/6uYp++ThN6Ho8R/IOjzK2L/PI=; b=Hr/zeZSqSDgxV8AF
	TeO4UHX28Wz9bGgU2fajNjP1rjMphkYgPzay7OvlYgrBgqaQm3RNRC1TNuPIcxji
	K5ti4X1u39wG00TRmGNn+Ptnk2dwiEHMRIKDSuT6g79Fgw/qPwVjPIGdfcyCoems
	52P6RlQE72GmPmuFAq0lHtOX16D0CLgP5CvyJVxQ6QkVbM+5UDqwlKSQUjRv+M5T
	EKbWc1NEPGwwmG5pmbNSCGuZXhZal8QaASa0N/QS8OWqYZOZyHiUuG4THEQTR6PI
	NTMKh8q8Tj5+y5IwCl+yH+Q5C7r6JC3DVegYJgLEW4W1Swo6l+OSke+hJkLC+Jj9
	UZgzSw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0e1uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78106e63bc9so200700b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781763; x=1759386563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYpcbaYMx/nDHjUz0/6uYp++ThN6Ho8R/IOjzK2L/PI=;
        b=melUgkc+p1GDE3741PGyWb0f1koVCFEC7mwTIfhEfZK57kWrpHAmD6XsH6jR8qxcfB
         iBv+nueNIfYW1Xucb6ahamLrusLRX3RV+AbqRF4aHZXjsBujt++IvlE8TXs9JYMd+HMY
         S965h2ZzKe9MjHd73ihoxxiob4exfkPIBrBPLaR1NtKVnyNq8MT7Y9fYtFQD/XhEOy9G
         4xs6jNHL+yr5IfaCdRZxc9GEgiNSPaWwwQw2iEtdUBIA5yxSiek427zORYf7qwjUn3j9
         vRc4N9tA4if3jgnWSj1gVo3BDRCka3rzR29XBJdluYPFdxQZQ/s0qldl09epicsqS6a7
         5BwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMFfx2dGL4M0VfcvrK/BxmHWZyOllcHNP+O3RQ2lx+IIIoYoPYbyWb0s/ZHE8aEH4JV2QOwsl7nvJBmlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASO8AwKlDpY5jkFGJGwWabLwy5+GBpXBwDu1lBcdeTyQai5OE
	/crgL9j24LM9WDqrrwh4kUo+QrwxlfUShXXeV/GpDlh9wk8Rrimk1djdqeCs1k6sRqEFgAwMT0V
	o3HTrhUZ+1ee8ciDDeaAg6dyduu2bpi98LM64CmYzEKWguCz7KS4a/ZfN0z/zJo3SexE=
X-Gm-Gg: ASbGncvq4uLZwtqdVu0J5qlKEYhyKMnnMes8D9DZLCeFyo1h28a+zk3J2sWSr1TPcQC
	zkPaqLVG94UkhsFegcFhlIkJPTuF+bgajUAuau7Lyi529mdUcLaJ/CvJ3VXIZc47pjysOplkhw/
	ugqym6RcWcnmD9DB2Q3FkKMrB4m1YKneZ1xS0lFc3ha7L0oj3KcR3ksG68PNTkeRFkGlf0uHlAY
	5rLFzjBAHn9Xns+UlTWLkm1cCBTJ1udsUEVv9WVMpy3N0OSNdRnsHjuyl2YGgy0txoc/rKRU5/P
	vToEWW5D5oiF9C3e0Ai1rqtkHwhVQrrFJgPbvt6aomwLTwaiRQG4M+pPvVFvAVDHVriYrzrNTeE
	d1BV2OaFvzdA+8Lus0I9AW2WpWzI/CIwW4qxI9xEIdA8ksg5d60LyBA+fY8sD
X-Received: by 2002:a05:6a20:3d19:b0:262:22ff:f018 with SMTP id adf61e73a8af0-2e7c593529cmr2766518637.26.1758781763476;
        Wed, 24 Sep 2025 23:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxo5LeMeioyJuwiummPZdVoPbqv4zt6qWSmdXrcD9wR88cYa2xcnvU+gin0rC3c2sEIb+1Og==
X-Received: by 2002:a05:6a20:3d19:b0:262:22ff:f018 with SMTP id adf61e73a8af0-2e7c593529cmr2766480637.26.1758781763073;
        Wed, 24 Sep 2025 23:29:23 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:22 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:14 +0530
Subject: [PATCH v2 08/24] arm64: dts: qcom: glymur: Enable ipcc and aoss
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-8-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4e144 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=f5wZDNqicMbGYsbpI58A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: LZQyNWfMmT1soW3Ll_BGi0hm5mNM941X
X-Proofpoint-ORIG-GUID: LZQyNWfMmT1soW3Ll_BGi0hm5mNM941X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXy9R4HKJ3D6y+
 PhDPKMryNu6u1BX4bC+imI3+504uAmoFCcVAfcVo6SSo07Xr0w1eE/ieFvJgMKn0UG7s2U0uVyy
 JH15TUV1V6wy8DPwxQF8aflyZIAZvoXsrpdSdT9HdCo/xbyF8+UEe6daegofsTAOHyk8KjcORAP
 /4f26Ta8WWH876R47UKX3NgNSVWOe6vjm5ax/utYdUIv1JOgAQVKoZyLcpM3NDjubW4k1oHtva8
 sK+A/M+816JkVTLMYhZbNkaiDvcdyPUclIRxeb8OEp/mIkZX3frYl8FRKysqEwlLYPez+suI7Qf
 fQNg/4Gi4mKYIKKog6kNaSmkUPWkgABeo5mgnUt2sfKeUb/VWfIaeOf+40uiNZ7uI1M8eN2QNKb
 IZHJE5qJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Enable ipcc and aoss nodes on Glmyur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index d924b4778fd37af8fe7b0bceca466dee73269481..2632ef381687c2392f8fad0294901e33887ac4d3 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -2536,6 +2537,17 @@ hsc_noc: interconnect@2000000 {
 			#interconnect-cells = <2>;
 		};
 
+		ipcc: mailbox@3e04000{
+			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
+			reg = <0 0x03e04000 0 0x1000>;
+
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			#mbox-cells = <2>;
+		};
+
 		lpass_lpiaon_noc: interconnect@7400000 {
 			compatible = "qcom,glymur-lpass-lpiaon-noc";
 			reg = <0x0 0x07400000 0x0 0x19080>;
@@ -2572,6 +2584,17 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,glymur-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c300000 0 0x400>;
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc GLYMUR_MPROC_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc GLYMUR_MPROC_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
 		sram@c30f000 {
 			compatible = "qcom,rpmh-stats";
 			reg = <0x0 0x0c30f000 0x0 0x400>;

-- 
2.34.1


