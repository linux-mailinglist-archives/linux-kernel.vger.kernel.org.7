Return-Path: <linux-kernel+bounces-787157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E359B3722A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14DD4E23B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26F371E95;
	Tue, 26 Aug 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDtwhsfl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74E371EBC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232507; cv=none; b=Ds5kr+IB1FBYhFfvVXltRekFcbyj5jGxJqMVcxwuwccFCgImgVs8N+mZmYf1Jx/MELgDt5BhyPwefiSc0Gzm0JH3xd89xHb5ZuXPfnMlsOR9xCLkMkIS7jQ7wMHWMbqUJFzrpgTppGzXioMRDrrq8uyITilfoTyI7tTkRjJoIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232507; c=relaxed/simple;
	bh=bIBcAYpVmFWgxOVMtIDqpSvu09YY+NiCzJTZkWhGL/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrFhX1hsD2261MZVLDNPHVzKsSogxDTOkSopPKRGs7WdRVLx0s+HYiw4Bu02Tj2vs+4bpFJUeAMueAY3yTBHC3PkBliBeR3FOk7eMbRoNMZNT4z4/1OydNU1KERv1OI2MEPPL2gnCgUV05ZHl0U4WINYaIpIXrYHr11AtvLNqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDtwhsfl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QEpI3N024698
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=; b=bDtwhsflUNbP/o1x
	AcazB4a+GFs2pD7dD1h643kybLc7UWML5+gP/pqDzrZJkHT/NT39fg7Txeo4Gmrd
	5Y6NCTSYnmiN2/j08mr3GzApkHBH1X2C5RYcSEPka/QWfI+4wOzaBX+irOdKpI7T
	L8hSmKTBmlHaZeVS+fl+iU6mfh+eDj0NORRBziAkCj34ta5fK7AyiHNmuTqHSBpz
	PLuT8u+9aNDOOKZwL9dC/Uq6NYE4h8Yaf0rUoIJ98GM9q6w2lXn8ofOVXRJMpJum
	UGu9QRGpdCAAeIs6I9p+jLlVp9sB8rWFVyTbuAIDxVwsAeJbmBNYCRst4ggNLLNV
	xZCYQw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfhy5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:21:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7705115a2a5so2396829b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232504; x=1756837304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqG1x0C2Vi/fvgd89OKAZucnUy94PXEwuDfboAV8Cbo=;
        b=npTKFv6SXWndQ+RWvPXJDBnh+4cFKwLvBdPkpRVva7ci9v26osX3hCI5OtCJ2rx/kA
         MnxZw4Jt0Phn/LoYvyrfdIk0P4SxhOBT0X3cZgM3pPneMbuZ/6FVgto6TXOVKMQUR9rR
         OuYdMh/bbyBdOvGTQjGujFpoKKboZJ9l8s4t0Cfml4aUI35zamUAc93rssYnLpODcabH
         /6AnRysS7MexkvK1Sko4QUmyTK5bqLaS4Jyz3gGRxxA5PiQeN4ljqkwQ3uR2BcvIrFJS
         tlU/MOAaGGuiM6k/PkPLmN0RxzVPGe3bz3yR6GFtQcvgEwTWQQoEdXLtc+AcHM3n37nx
         GFDA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8p86r2MM3fJvXKb+rpQMA8PdJsFeeDn8tYb1Czo53GSutncs5t3TwiPiQhcLNI/rcD4CdNV6W6SdtSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsr3zUONoUQkyu6m2wVRy4JVDmouLXSspOgiZMaoiuTmb7H113
	3FTm6/cgNUub1bPTNX1VEqnOMpZxVGq7aMaPpa2mj78ZVn1XodLb0RRUT4Ta2MC0qINrCHbay7z
	Oe2yMboRONDM0Tg40BydoYVi7aW4+WzUgrYg8Mj14MFU/CFFBohguw+p0Q6Q7z6UMxeM=
X-Gm-Gg: ASbGncsnAWCKEVIR1y1OQe1tHEUd/mqJLRqBiFxv0CD/K0f3G3LPWTL8Z1NS+YUxFCr
	CurpTbwT8w+C6WNk1AmyOoKN0Ly95EdTIwRDswXqjVarNjXuP/NrWpaHyh6vQ1NmJEMZzDMF0Rg
	6nMTxE9OeLsJ++lF/AkpCWfCAEthkj6cj/j5yNrMeTpG0+lKc7U0TzzOgwU6WeqoAEYAY8j8HaQ
	eQ+JezzsltYGc+1aPA9dy9agJ4hz8EQgYP4gvoQv5IQN9vBxrL5xl5q2OQlDz1UGMqD6JR+BFw6
	Qsv8Re7LJnofK+8szh/UJh7pjUzJ/1TcTyYxWi9rqRsXSfM6LN44LTmk6Kc61QAXPk4Y
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779264637.48.1756232504003;
        Tue, 26 Aug 2025 11:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi/T/3A+ZcqC2AyUm9So880Y60J/r0weCuRK5mB8bTebqwx94ASLUPJmyFLFQGaQpDcSY+eg==
X-Received: by 2002:a05:6a20:7495:b0:243:78a:826a with SMTP id adf61e73a8af0-24340dca336mr25779228637.48.1756232503505;
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:43 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:03 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: lemans: Add gpr node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-4-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=2037;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=40OWUv9iedJbCp6fZ7M8XF7kvnUUAqEsRqjGx3RvYOU=;
 b=y6s8OZMnYzKwwtVKaCt6Eoe6yyzw+1yqHwQFGnEHHe+s9/+8MtfFNQGbYa/ABeAkLkDe5ZYZp
 WUnLen66DySA+GDKrVSluY8ZYNI9Fzmrgkbx8xGWSauNgfqCD6xGISL
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/Jy7tSWL36HT
 3vuuY/hHLaR7fNOJn4VKL7Q54hC8q3IValdfDpkuYTFXdn0AU2Gu7Vu5ttrvge96FYdzPljgiVr
 cnWRyv/NoAHXZsAvmeaXtHD5Iv6RyvxKWbvI4XQvHt9cz+hLwQBw44R66FWxA5sdZmh0JGzHFRZ
 8Vjsv/oNRLUdENtVpGZClrumbYO2A22GleI2mgx2kgDRHMpM/4bhDIv15NyHCBJ2kj85VFKyO/b
 oKAMFfKM5Ja09gN712/GihBP4kBo9KvDl9EQewFKp4xV0sFQixV3sNRG8k65NbHdFc6aidsv2NH
 BVa2LqCCRZx2ZISYF8So3IqK03xGYj8fkUuLwA0s1FpOWjOYKKnpSzVSqy5C34D34EZS+OkL/RD
 +A86gFam
X-Proofpoint-GUID: _xW_ujF51YM9wcTwSXDRkGUKSWsw0KGx
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68adfb39 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vHYnVJDjh8PKMNTngWAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _xW_ujF51YM9wcTwSXDRkGUKSWsw0KGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

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
index a5a3cdba47f3..28f0976ab526 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6679,6 +6680,45 @@ compute-cb@5 {
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


