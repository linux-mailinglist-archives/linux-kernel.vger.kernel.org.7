Return-Path: <linux-kernel+bounces-732513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B74B067F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFE4E6412
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE819E83C;
	Tue, 15 Jul 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L75PKYqN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614B1A76DA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612482; cv=none; b=rOW5F7JpTaTkI/5omm0RuAOBMsoBVAL+rTmvJue/AQG5Ugv08tkRdWdUjcjzc8nveHC9GBT1B8ONBKQi7aE26zyESbTmCAed1DCJVpnjytUOogZcOSU3YNdUNgkd6dhPDzA1CTN8+skR63N0qIrTOoXLZG3vT6jZIKEHgfKD1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612482; c=relaxed/simple;
	bh=KM3x/3Pbcpku4hi+Q2J5twTHiiakqH43ags6fQQ9T8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sATo7WEhKvHdXO4RVRr/z2JIfSMziYG9yaxJLsIf2Y6Z8lO1sRntD3ECEUVKJhXT7c2tXp/R+233bZNnVXHDBvzmEMz9aamT8awNhNlHAVl2U0Mj3Sui+H6NPH8JN3woqSdHO0VQIVTi+2S2QYqoNcrHWKLWEwwrmqv/uUdpn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L75PKYqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDK37024943
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YGHUolC1rCw
	c8hxbfX9G9XRUGGS2ug574YwaNTuSfSw=; b=L75PKYqN4yHjGCHgJAo/iwQb4w/
	azE+n6M4KAokRKz4R2IiF5BgcKhxM5cPLlJVLp3t61/KqoyoWA7zo0QA9aa1eSiC
	j4sZ/CqTTiufO3+i4zo0QxFr/KyIetsSeP2wspUCpq3ICqqiYRf32ScWOmFvMOQ6
	WmyE4JHPWpTEK2jK6mtw0xdhQ3IIB3I6Qnrz/jy9YDd0FdqwpDC1OuCwkQLptvYn
	mFBfHwpC+U1u6LlQMEAXECPx4dTkA1CCgEQqcQi/g7SR4/6Nhd3K9ONiDHubpS7H
	wVn9aGpksGuHq8bB7AWxuixPzqRnLc8w1hedkB7qRO5bYBrmfYeSYKAZakQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ymdyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:47:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e1b84c9a3dso435098285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612478; x=1753217278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGHUolC1rCwc8hxbfX9G9XRUGGS2ug574YwaNTuSfSw=;
        b=S6ZX1tTVZ/dyyD6M+i9rfpH/tXH6EEpY1BbJ2luarZTfvczgQ9iJoPTxPz0QczBVV/
         aQe39oJieUwRICeQ05xxRal3IO/VyyZ82mGnd2mTABC8TVCSIxsrAHKgra7QnztDKwdj
         F3v9G5C8cE56h/tcd0qALvx0kVpxG++7IAzrI1pACLdTQFvacv95p7U8QLEn4UIBcClm
         Ru+/v0ScATO782XBuGh61Kkfhcmqz72c7Qjq8tuNCzT+gObg7526PAgP7ahdWlrS0YgA
         vzcwxN2zDAg1fHTkfwtKVrFQHG9/Tq0f+3spo90DxDFee4Vws1Xlfu8EF2DMh5N6nAYi
         G08w==
X-Forwarded-Encrypted: i=1; AJvYcCXlFMC6V49FiazqxEzpt+fQYz/Tlsh4kLlIFpc7qfqThRQaKw46vy74sl3tV/spLnTHEbKJWEofRwQMLuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIy++0e4mQI4Q0LOm706wSJFWu5mUreyurlAYIhY7O0ztTc2At
	0AXBwL8VKXJuVKQ7iZQ0SX1dJ4Cfff5ncw3awhVzeRXfVBVEIRUv2mZzMzMdE4A7W6eCxDk5vYn
	kcLrkvZCsUpFPGAbBy/lzxE/IbjC/WOIvHFPG3OexYpEmaxaAUXtWakOHmqphf5AeToA=
X-Gm-Gg: ASbGnctgf0aCMmk027zOw0XYWuT11CTgWVSHk3U9BuABcuzzc3d3f2aZFRyl2SVSYBv
	Ic+QD0DUFV3sJEsJScKZ2Z/k9BS+2P3HfqhilJfPoffIfuYHE5OT32P6/sfopo6rGSVwalkkGMJ
	y5fPZlEXhEyg9CMUs2zruRBwezYrVMRYcivqZ1W1qOsLe1Z+8eMGtG3ihJBjCMDmjv+IKiPxcmA
	sxLTbghn2wEdm+z46dav353NDx1Eo2zLkMTWELezQ9oeoPWryq1M5UJjiCNiQCC17b09U4+8d71
	bmW8RfqNFyji6SiF5GgjWrxFss8xRYmbWr15/6HIxcSDjVZzBqo8w9ZaFRVQ5i43E+547Fv5xH0
	wP7g0shBgobK+NjkCRQ==
X-Received: by 2002:a05:620a:4088:b0:7e0:52bd:1c8e with SMTP id af79cd13be357-7e34355efdbmr44763285a.23.1752612477866;
        Tue, 15 Jul 2025 13:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqr/md1c+7NfOSUJbYC+tuOFYHioqdEZ2PgcXNIoLvDdWe57k70a8J84cehq5nZn/HSQ23zg==
X-Received: by 2002:a05:620a:4088:b0:7e0:52bd:1c8e with SMTP id af79cd13be357-7e34355efdbmr44759085a.23.1752612477385;
        Tue, 15 Jul 2025 13:47:57 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:47:57 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/7] media: dt-bindings: venus: Add qcm2290 dt schema
Date: Tue, 15 Jul 2025 22:47:43 +0200
Message-Id: <20250715204749.2189875-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX1ZWtdMjPHBih
 nEVw1++Sppxgk3Ux4FtwjUwG+dG/zuoPmdgCp+C/QCWBuoQOd3o5SWPF//MTII/LkUPKd3WuXpx
 GMD+pJaDvWfZhjFhIjtEfMfx85x4wPHLJSR2s7S5GuEQ3dk+avyzm1Sj/MCUkcvHF3VtIF/y3nU
 ybCOMDWY9PkbuF28q0KqXIkGAvHYJcAOMM7p006oO1OfYFO+KN0U7jbBGOrvip4lojfhmHH9qoI
 rEe7eN5DIGH4lTYqg2RllyC1io18Bpahhrv2vAYL1OhzHC/d34N7dJuf+7+5iCaL33FRuK7cwkP
 ZwkFKHcxXvh6Y8+HExRFIIE+Z0K6nS+R5NYCgp1ykjpKJ0S4Mr0+Qzpu6hdhQbbQbzt5yIL45QC
 z+cc6A65CI48wlczyMAIrYjE0gbgUVgibns4ViFF+5JvRTR+bUmc0Q14dkpDeoZEUiSjIN65
X-Proofpoint-GUID: _Z4Qi5DilXlThj0dMwmjs_aScpqAUjGh
X-Proofpoint-ORIG-GUID: _Z4Qi5DilXlThj0dMwmjs_aScpqAUjGh
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876be7e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=1mX_ai67dwKzVtmm1w4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150191

Add a schema for the venus video encoder/decoder on the qcm2290.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/qcom,qcm2290-venus.yaml    | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
new file mode 100644
index 000000000000..0371f8dd91a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,qcm2290-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCM2290 Venus video encode and decode accelerators
+
+maintainers:
+  - Vikash Garodia <quic_vgarodia@quicinc.com>
+
+description:
+  The Venus AR50_LITE IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,qcm2290-venus
+
+  power-domains:
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: cx
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+      - const: bus
+      - const: throttle
+      - const: vcodec0_core
+      - const: vcodec0_bus
+
+  iommus:
+    minItems: 1
+    maxItems: 5
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: video-mem
+      - const: cpu-cfg
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+required:
+  - compatible
+  - power-domain-names
+  - iommus
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@5a00000 {
+        compatible = "qcom,qcm2290-venus";
+        reg = <0x5a00000 0xf0000>;
+        interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+
+        power-domains = <&gcc GCC_VENUS_GDSC>,
+                        <&gcc GCC_VCODEC0_GDSC>,
+                        <&rpmpd QCM2290_VDDCX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "cx";
+        operating-points-v2 = <&venus_opp_table>;
+
+        clocks = <&gcc GCC_VIDEO_VENUS_CTL_CLK>,
+                 <&gcc GCC_VIDEO_AHB_CLK>,
+                 <&gcc GCC_VENUS_CTL_AXI_CLK>,
+                 <&gcc GCC_VIDEO_THROTTLE_CORE_CLK>,
+                 <&gcc GCC_VIDEO_VCODEC0_SYS_CLK>,
+                 <&gcc GCC_VCODEC0_AXI_CLK>;
+        clock-names = "core",
+                       "iface",
+                       "bus",
+                       "throttle",
+                       "vcodec0_core",
+                       "vcodec0_bus";
+
+        memory-region = <&pil_video_mem>;
+        iommus = <&apps_smmu 0x860 0x0>,
+                 <&apps_smmu 0x880 0x0>,
+                 <&apps_smmu 0x861 0x04>,
+                 <&apps_smmu 0x863 0x0>,
+                 <&apps_smmu 0x804 0xe0>;
+
+        interconnects = <&mmnrt_virt MASTER_VIDEO_P0 RPM_ALWAYS_TAG
+                         &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+                        <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+                         &config_noc SLAVE_VENUS_CFG RPM_ACTIVE_TAG>;
+        interconnect-names = "video-mem",
+                             "cpu-cfg";
+
+        venus_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-133333333 {
+                opp-hz = /bits/ 64 <133333333>;
+                required-opps = <&rpmpd_opp_low_svs>;
+            };
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000>;
+                required-opps = <&rpmpd_opp_svs>;
+            };
+        };
+    };
-- 
2.34.1


