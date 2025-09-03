Return-Path: <linux-kernel+bounces-797854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C40B41649
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16C11BA1A08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1E22DA771;
	Wed,  3 Sep 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k1CvYymg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097C2D9EF4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884040; cv=none; b=NYcXUI6ORfL/9C/IuTyLJh2uKkBGkPmKqy+ggC6EhJKOWmX1Fv6bFdGGj9OVK1q2C7xpCdwMEerbYJQ0CtVxYNz8iGHR+jU0FripgUReqgvqhH3K76ofXshTH6CyzgqF3pwNBz34fNUjhZWU2A1TdpWEOoU47oNedOtfK1WIWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884040; c=relaxed/simple;
	bh=fFP3LqhWTuVccKncTpXmtlgNDY+GqNHMRYAffl99C/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/38mZ6bKUrinMFBk+9MjHsdHQF6oGrGnU+drtJevYj7j7+kDOcQ4rMUP3VVhwFkA/DWPW3dhhu7CRRgUbXKwvCgbDNsnXw3+YBl9qLdd/aKlwE49LFkO/d/WiLzTNsCho3N7k31jYANPTDXyuDGxsrkHV1g7tqjG52Gn+jWqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k1CvYymg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832cEvT012679
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	783y78yXmBJY5xRlP2M6Gp15FylMnhfNQmsntisnv7g=; b=k1CvYymgnAKcb2Mt
	qjO95wf0KQz6bNKOVJ/pPT6zeeRQ6XWYgfVEHCZ2B7cbyVQL9pmMhusZ1XVDG0JI
	gyO4pYx6rKXwmTSlunTcauykFhNQPOTwNYJQ5OxNJCBSQmz3mKKEPvbDh89HPrh7
	2ZXowxKtmqUfP3EVBTSY+lGOP9jLBuOyyUetOtKYUqvxiIHe8h+LimS6NWA217Rc
	B1C+q0TYkm93BTs++ULYi9B3MLCafMHdFqHFWRWQulPhVWwPWp/M3XK7C7ngleKE
	unsB7WBRWwt4L9sBuepUtWIF+qXnmkxZmZRiSUP+kJ3Y7AtKcpYhETs0Al7fdaZV
	Ac2yjg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk92cvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:20:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4e63a34f3fso2912267a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884037; x=1757488837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=783y78yXmBJY5xRlP2M6Gp15FylMnhfNQmsntisnv7g=;
        b=KtVvQe2xaODW1rySw3xhRMVI4mtS2bS1wD2HChj5eFGOUAj0zEVl9xIb5BehgO3gBE
         MdJHqVujuy+td6J1DZ+06zlNYvYnrNbTSlP2B+d4X2USL+6vjztGZI5s5y0hLym0nCMB
         n0zKhHuqt+wTGCRMEApUF173SilwTlKrd/zPXEKxaPkAO6Ko3iY1sdCvFYWsHwncMhmO
         hERg2Nd/9VfKjuRW5UBpGBHHzCbJCTGlCjaa+2Lxeeg8aJwJU8loxxAAAdeV1Tl1RJx5
         LTcrSfS3i7FEUiqKAnZoJQNIzhywBHjKEE6mk0p3kPyBbuZxk40qAVlepewSp1fQMElu
         HmLA==
X-Forwarded-Encrypted: i=1; AJvYcCXnk9kryDTIaSJ/Arg6YF+7upkor89F/nedpCtuwrElOWfqnD8EiwY05AFIZN7GzuCGZU3+9ra905aZA3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8+Iwi9ZZIOMWE9A7O09VKJZsUPDVYil9J8xyNOZwZLlN4A/T
	7DlupBAn+cdY8AfEpY238jtLjNSo2reJo/sgPHi7hYIHsX3XgJU2O4qQWKBeiLch3pgJ/qWdrVm
	15agIiyALHulh7lWhanarJuVCMVaFrc7uZ0GnDYnX9uIY8kL0R/kMKV6QQfj2yz4BBlM=
X-Gm-Gg: ASbGncvI14hIOvcpZYE2qB7GIRVlwa7ZFqNGyZih8C1KllRCjP+zji0kXItJELmHRsR
	cphr+bZP/yrK7Go9dHpWdSE/el10x5wZDynz8DaR/B42kyvw+uws4NI3JaksYTfArzryE2a0a3/
	ozwm0Mt+2Tz/VYxCfKBi/f4iWlXhTPC3FNmL38g7BjqmdsASBjrNmZedYwOMUE2xQnRx7iIam0G
	vzGLZrQxj8hMqwn7x2H2mO1DRNnmc2nX1XustYByyPwfmnvlQJIPTNz3le7qQpfRNzjs0Q+S0L6
	kG5DmoqlSRzEFUQkSsG2JkblGxB6XGhVl3pUPHzBySXDLAwpcCtGvlLeYPMkuo4+
X-Received: by 2002:a05:6a20:918f:b0:246:d43a:3856 with SMTP id adf61e73a8af0-246d449839amr2736674637.22.1756884037352;
        Wed, 03 Sep 2025 00:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ffvTpbw9jwjShL+IZyl85/Z8YDW9Xu3u0FzQcQbXXtMwKarzlqKyNTe2+dQNLNFvdlmQaQ==
X-Received: by 2002:a05:6a20:918f:b0:246:d43a:3856 with SMTP id adf61e73a8af0-246d449839amr2736633637.22.1756884036835;
        Wed, 03 Sep 2025 00:20:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm15816191b3a.30.2025.09.03.00.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:20:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 12:49:55 +0530
Subject: [PATCH v5 4/5] arm64: dts: qcom: qcs8300: Add GPU cooling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-a623-gpu-support-v5-4-5398585e2981@oss.qualcomm.com>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
In-Reply-To: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756884002; l=2002;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=UGkqh+jUsBw9mlPVt984D/vluR2NHRDxt6PvxoK841A=;
 b=NDEzUe2YZLbW04zC7rx7sOBjGheYbp3vZkta1FEKZ4HGbqBSid2Hgn6oXufkMZhSIhcl0n6wu
 IcawBTpY5wAANJYwEG1Iqja1oZ25m7RDZbr3a7ucqz1yPUkHx7KBJg0
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 00ENFRiIAez3UfGKDlvLqar7I21VgipI
X-Proofpoint-ORIG-GUID: 00ENFRiIAez3UfGKDlvLqar7I21VgipI
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b7ec46 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=deFBR-s-QiaC76FCe2MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXyzginGgKJw+/
 Y+2rZ0dqZZXsWJ6OSGcxibFfrspGZhwh8ZLGM1y2BspHTPrqhizmPwJf68z/+tmLUvwVsXfq10e
 cECxv1d1cV+mceEnmZ7DDqqbtdNPjPO3doqT4keJ3gJCOomuEO8YpOjiq72naNtA3jIT7QldnaW
 vwt0NOHxrseYbRJoa9gvlnMXrsMtrJmewAYwr1O7dvcAfACdOa6+syhrNMJJjDZ3Qa7G9KVs48U
 LOfaAFXTzvSsMjsPKjVAYn/vNlWcPFL7fj2SZ25hD7+Dyos67+dgDHxb/yGY6WspOMtLqhbXqPz
 OHkYoAXsx1dr/VPWLF8zMW58ty+6/IweiTaEFcU9ATZWfd7hP1baDKX4dECPPmUKQm6shyM/9H+
 KEWRxVwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Gaurav Kohli <quic_gkohli@quicinc.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 115°C.

Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 00e6131e6b24def4ff9566c14398aaa86efe557c..57b8bd6a089ce8b9a1a63be3fa778a633b4025a6 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -5846,12 +5847,25 @@ gpuss-0-thermal {
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
+				gpuss0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss0-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		audio-thermal {
@@ -5966,12 +5980,25 @@ gpuss-1-thermal {
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
+				gpuss1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss1-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		video-thermal {

-- 
2.50.1


