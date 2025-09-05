Return-Path: <linux-kernel+bounces-803671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893DB46396
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911D87BEFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B62741A6;
	Fri,  5 Sep 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwJCAGjF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D427E066
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100251; cv=none; b=A3Ku5gdbzxW0tpl+LKRe8wSmJ2Y4E/m0V8LHirFqYzICzYgTo2Y+f458BGYor3yXuXjXBp27oxiKS141re4KyL4oeCnX+rqYE5JsJt2/GgbDg5HSKmS3it+rMUP7mqekRvVvCRscvhpIh+/AKlNghMcq9oSfiTlNVK3Ffk3iWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100251; c=relaxed/simple;
	bh=YqiZVY/P4h11n1YmoIH61y5tP5iX1W/rqinOGkDAsXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WALq2WMfh886Ix6GGok/4cv7ST/zPf7trd9sLcW7XT5qTOWHN51hci/gz41OIk3LJh7ipP9ksNgvQ06ZI/xzwzPaA4XcpuGPgpd1fl+xjQMPMDpVZ45ckXzRKTkbsEm1NjFoT2EK3V8+VyFuEAM+TPstWIiboShQnoA7QNveLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwJCAGjF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GVEtp031019
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 19:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=C6tu2IKK9J7
	3Tb0vlq0onDfqNFgl91nLHdqPT79aifw=; b=PwJCAGjFNduF+w1QfuOyuYr/b1Y
	+Hb56TzTTZkSOk93H8JGaYq3qIcxte1cLbEr/iGTl/SFcJd6Dkw6arQnGNfPmb6V
	YNEccW0ANW8jL7byK1AvAL4UcQIk2u9qzLG3U73u0p3d5k0OQ7Wdglo8A2u4X12R
	vEtXMGkaUiA7LIZia6TFBFSrvnP46wyNErCughL8Cw6jgjfR077UQjsPAZ1uhC6z
	MDyfhYQwrNiC1qdZN0pbsMQeV2Hr3K+mbsjt+tBcGOPVIHnaTPHOZYAdGUWVqL+Z
	U83XT4yY2YEmOlCeF88kKfmTK1yjugXNI78zsO7ZbrAD7Vae93UftgNbz3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4903ev0j2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:24:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24aa59e366dso7600505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100246; x=1757705046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6tu2IKK9J73Tb0vlq0onDfqNFgl91nLHdqPT79aifw=;
        b=sdxfofjUWA0Whv+Fyjn1tLm443VMNpPKHkyf/2prf+TeFf+9TaltE95DW7QXz0io0T
         6U2ISj7jTsnd/Ar6KO+qWBFhGFx19VSQrZK2H0x7o5X6N8Bl3dK6k59AKM0NF92NHZdO
         Qjadjmov3ebxdswv13/wQzYOlSGeWDLoG7+VhwUsM7Tn4JODw5YZm6OJ1dsxMEj75bat
         g9LPs9f+GbFz9H7xeq1vOUCegTg6xgJHzwIouL2TiP5eOaLR/VjiyM74S1wJfR9xcEN5
         uGvrD/Adl9mBVQp2gs4oFD1nxJFfEyHdW/7w1gpZj7pXGrgrV6MRtf7SGXQJBtR3LylT
         +0nA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3nJ6JwW9Z8nW5eM5v8HHGI1HS+9HH535wNRY5ptIidkX5syO84IvMmXsVLpCrq2lVl+uf3AJBT6gZt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUX6sKyvi0sO4FAm3aS0ZXdJwtaYfwdnFm+lN6zG/aNXX2gQ9
	dFRCLKka2l8j2rflm2aN8ZGNqYjSxu+M+cWY+5C6P8C26voOjtnLoFpZFVvhSQKid0DWmwqJyWZ
	5BHeHnx2unjhuwXq0titVBxu/zyw11wKethdT1Hpqi6ni/rXowwd/ycj4iAZwRxNDZbs=
X-Gm-Gg: ASbGnctDLdYK6oYH9gRf+S9q2RyJpBUjrpG+3WKBQxgK0j6Ak5R3/AuigVItZ6fuN4y
	ee4Am45XFBIbmm8VaHtUbg5VEtmggLBT+2UZDiTis4tDSmc+P3S9l1hHZYz8BxJWDbn1BugaRcq
	wAEtBeQ3qnTbUpcLV2EqJEHT+zIVvqiWyXYZQHEWoJNv1hwPg8yfqavs7i8x5k1E64oxabn2CdZ
	hYGTIfnNbuS/DedN/QocC9vlxLa74Fp298FAX9HEjKe8Rw/WO2df0uGRveR1BJCB4JRdWlvSD1y
	JoZb010PQi7Co6WGdvc7SSkLzZecxrdE8fYPkKPVz6psjzhL+N2DJoEhj9kAWx+PWTv2CWQ=
X-Received: by 2002:a17:902:f685:b0:24c:cbcc:b7ae with SMTP id d9443c01a7336-24ccbccba1fmr47886225ad.6.1757100245881;
        Fri, 05 Sep 2025 12:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoJx0yV9ecXAM7dTdlqqlzkTwUnZuQQ157sQUdg4pT7k4YQPWllhK9a75O4rc4HuN8GCcwpw==
X-Received: by 2002:a17:902:f685:b0:24c:cbcc:b7ae with SMTP id d9443c01a7336-24ccbccba1fmr47885965ad.6.1757100245298;
        Fri, 05 Sep 2025 12:24:05 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc1a82a34sm52397055ad.151.2025.09.05.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:24:05 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: [PATCH v4 3/4] arm64: dts: qcom: qcs8300: Add gpr node
Date: Sat,  6 Sep 2025 00:53:49 +0530
Message-Id: <20250905192350.1223812-4-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE2MiBTYWx0ZWRfX5KJhOnKAAllk
 9DKSKjiwxoRDy/o4Aa7bVpP3YTdYNcO7z0hFHS1iJY/KOjKHq+3VatQtlStUhtYOIE3oB0yzrMp
 cB70svu6+8s7CkOLgwDToSsVRYcXGQLFPDgZYjFoL2VtHq6sBtLBfhWOSmtwLaYVtCTTeF3r7XG
 g9sXRmOrj3gBXmLV+gtpUBixJct2gSoeRTWgTS8IiGWtvYYv7MUvVi/XhYTGigTjMXyWwTKgt81
 JAv5WmSy9WcfG4cxpSnukQ6YYmzC9byK9BjFkY6qzaVCdNRUSjnCQiVjemGf1L99+9vvydhTWty
 AOG5ySm7OhJTfMVLsb5H7DRRphJoFjuMohSxgvbf7GVURSWKs8mQw4s7Pl7YCsYYdm3FtJiuA8s
 0Mb1fLLN
X-Proofpoint-GUID: 518knxMQ6OfI3vbOX3WVfs12jb39ITMT
X-Proofpoint-ORIG-GUID: 518knxMQ6OfI3vbOX3WVfs12jb39ITMT
X-Authority-Analysis: v=2.4 cv=drbbC0g4 c=1 sm=1 tr=0 ts=68bb38d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YnLsFFvNRNnE3KoHtkEA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050162

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 5edb137d1471..8ae843567ea4 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>

 / {
@@ -2427,6 +2428,45 @@ compute-cb@5 {
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
+							iommus = <&apps_smmu 0x2001 0x0>;
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

--
2.34.1


