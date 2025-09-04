Return-Path: <linux-kernel+bounces-801294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F86B44367
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874F43B71B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C525340D81;
	Thu,  4 Sep 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmGHQiqe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB033EAF3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004032; cv=none; b=N864xzhxdreiTmwe/FlP7btOH3ik/iUgo2kvU/b173WZyyDKiU42XCxGBwhW5CdJyN9sKsWwEvxz5AIDYeb9uDF3hzsVKHhBRe7StKUDBZMIgQ3Toq+9c4Y7qaLmuly1xLQ5YmXJT6Kvb4YxbPVkzyW+EfnLSub5nm/4AXkoy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004032; c=relaxed/simple;
	bh=Zi8P4IJsrN5PCQK4xo00ZPvmwVI9z+jIt40lmIFld5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9UKT+54Hnf1EU5xg2L10w3fIpBTqblEqQoe3AZ7lPcF42oWXmPpZCMK7ZDOHmaDf6aLAm/RW7r+S+jSQ6vjYYwSkOT1dGaJYQTV5BODsnRKUdGMurGgz+UexphHXfl4UjbHhE1aV23ZltY6IJrwECf1U0Pwcx/43KEY1RRa/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmGHQiqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X91S032214
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=; b=nmGHQiqeJh+8d2I4
	rUfuN7OdmN51/mU2AUJXaA5wRKSY8ZqtGwfYW7k4Mc8xvpnB8IB46mfbB857E8c9
	PXPd0w/tYitw/hGdNS/e6mFWHHGkHCGZmrOrlkMxpBFeElu0ffcD1Dc5ZrltydT9
	jyD3H3sNsH6e57lGnqHlm53VpRvMmD1xfX3xqf92EDYqOeLwbA11TTrB02FEJAFW
	I0oi9PX1SrQuvmiM5ZSy6DVE9ZkdL/aIoDYRvgLckbmbeZCgAioAmBgF9SXEA4ec
	b2ALCUjyhvCOU3wne6vvJaAqJp1/OHQPDqVlmE7FOPAM3989DE8uiumgcSlM0ul2
	o8tUFA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpgc20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:40:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77250c660d3so1393681b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004029; x=1757608829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0MlJyi6xlGQ4JiQQxsUH2044SHYqkJNDG1W6ew662Q=;
        b=rGkdrGcOgxZKD7Bx9H9A8AJLIeyV5/OXI7JXjnW7bkbrv4J1cUBjPHZbwyMZmxVBrt
         dp8gb+PqDBIh02mxuJtbL3J89MJ5mtp0NtfmaRTHDxjdnfxRxLSBVkkJ9T9s9EUcEKF3
         4tKkCohptw8J3vdxlFsbQwtQSzrW6RV1J0Ysa/c0MjSS3CQI7t44B/hN+zytEAOh39K3
         UZv0wB4wfoCeqCu8FJCz0e10T7tH9VutP8XpTp9n7izw+gEWti75BH/i8xb9gDTMJyhX
         UzUiVliSmXRT+PkHo7LY2VNE+U1Rx7jCyMfNdQWwLkgGaxeMDUceXtM++xF2ax18izQq
         7YWw==
X-Forwarded-Encrypted: i=1; AJvYcCV6LLwYu4RLXrH7YZO7ANsn3R4Gn5Jcoq6IXzPC+77gpN0JSUL3T/1JY+NUVUdZK/miQ8OeeiYToV+6wug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKV2aCe/o8AyKmANZd99Xryx6cVu7+PqW5POib7uqcLo4xUQN
	RSvJIwEmim1Mqutk1v6Wn8hKIBv6cvqbZHxsCCptGkPsokg5/hq3I+gf09bf+QhK8ZXqFxyg5FX
	Bkp+hZpTSyX4VybC6XoWx8koaOTGym/cuG/N7yvcMDrA8PJXFxq+hOXclZiDAgjyr+gs=
X-Gm-Gg: ASbGncu+l254cOwPG6aamQ/cD0OwB7j7TGMYXFbFEtVTQVOY8sdMflItLeDzwyC69Za
	3Mu12+EL/h95MMpteki7zPgmLadJWjpBI0fnSTL1awb99XUPcHryYZQTX7NDh8ftNeKX9Pf6h82
	TWZVaGXcCxOqfOtTKC/xQ9GJ9dnT8mefHXCFiVTkY6m+Lf9uv2IZUawtlRp0n28zH3V89a/pVfR
	89gUNuSVBvYqnqLlYh4omV0qZjdoKdZIrEAdywCS9TwT6wba+Rv5WbIKgMa9k8UC15oFhuJlKyJ
	2EH0SmRazXyW47QuBiG870A0/k1DAVoQwT9+7XNP93CiyEV91AWHqXqt/PuhVZs3Ir4O
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306951637.25.1757004028723;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0hqSjTV8JZGJkiN6dTs6Zedyh6YiLXgXgSj90NXrTKN9ydub2uoKmDCtf+fOgPDEeOaq5Vw==
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-243f5bae8acmr20306896637.25.1757004028089;
        Thu, 04 Sep 2025 09:40:28 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:27 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:09 +0530
Subject: [PATCH v3 13/14] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-13-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=ODJ8lQ3jakhcv7zggi3511Zu7KexUOIuDZjyNJiIUUk=;
 b=nRG6nxDgky9xmJhMRuGpBCnQWH6z2PchN2hWiGAyg9tyGCXJGzJzyqrhHLgHOcwFQdYBB1N/C
 zmuk+DtUnsfARS350Cl2HFKFYWs/15YaQKmRaELoQsOgXSow1uQke53
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: J-rFNs8aFY0fvIp_vKwAF7kq8XvGKDPY
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b9c0fe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Rye9TsTwPMDKiC_iSCMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: J-rFNs8aFY0fvIp_vKwAF7kq8XvGKDPY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX4O7cYxFRoj0s
 w5NLGB7LxZfyz7j4p5nkyaUHwOsF0nE40kPJjQLve+/i4DEz5WL+VpjDfDE9VLUqWg0VKRfZmcA
 dzj9w+pPB+uFuQDTTmUd83jtDCMhomdfAFcyc3ERkzWHA1iD6zljr6hmzhaPq8sg/n5pdbSF6/0
 okLlUt1kwvm7kMLGitz2RXS0NkYzHdPmmOJieLhwMWbvCv2CyIPKDEklYAh91vsC0EP6/kkcpBQ
 EMui+hATorUaucTpVNYn6TjIdF6pnG272U02lfO8PqMbaVPUn7oaUI65JmRob8eoWkiPp3Iz1l2
 AZFXyntX4j7tAcabjyPKLGnvZmvT+i/vF4EBwa37cQZkRO8eGA2KhhbrwCkELNImJOZV2SemjEl
 25qoXbEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index a34f902c1358..f3a4deee383d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6760,6 +6761,45 @@ compute-cb@5 {
 						dma-coherent;
 					};
 				};
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x3001 0x0>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 	};

-- 
2.51.0


