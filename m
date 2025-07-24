Return-Path: <linux-kernel+bounces-744621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E091B10F45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95B73B16B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECDD2EAB92;
	Thu, 24 Jul 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rp9vTXhK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED92E041A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372627; cv=none; b=IT5j0ZGbPQvZUpzQu+Q9BzIQm8Os3PNDHxp40R681PLlNBMjnPdDZ/soKyrEa7N6U01u8FSYZYmecIN513QVc3qKisCUF2R8ke7+WxpShqqbcuEtbcnXw6H5Wx1GCn+OEKId25mLVeQm323kSCvrJD4y5gjILk4eNKmZcb202tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372627; c=relaxed/simple;
	bh=7T14pRw0Q8ZjghHfjLjOR1LnpC5mJ0EyzHOg/XJK4FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kmdpwriq2IPDP/0SciinNaQ8A5d82U8qhFp9MrvprIbtV2yEQn2RDbvcTMuL1kqtF5auvz4lxcwVBh5BWKNXoQK/V4RbT9vAyo6EXLiw4QetxVhqHQdeN2HnmDR6ctk/hDpEM0zLg5dPqjS50zlr2Nv6cTzfk1qN/3Z/Iv3DtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rp9vTXhK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9T4mR012697
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/eXGMOuQy5U
	D0xBEyKQmMrAv/q+wo0dMe9aS5o4AHm4=; b=Rp9vTXhKzXzy3b5R2M8brgvLf3G
	pJ3w1/OmpLn6mCZcKhFRMoiUvHAp+308LRXtqa3PqpV8iSBSjWmfsiXdI3j6oe19
	e8ekL00hQ+zy76jQwA+UOcd61HacLEJpw1HoG29Q2u3ABG22b4TcRbRCQMsnxKhd
	G+dhmUpPr7uI6GP3+vy5fjzaCcJ+QCYSn31B52aKzTn23WfoOqsw/7npJkWmK15y
	33vVfhARXOrHGcXEvsq64imos9I1HEg7QqePd1AciYeCxeFT7K4Z4EY25cDM8xXI
	vzJjKemQpDX9gpP794np3QGB5l6O1OukfLkrzOyws6Qb2sowmNc3M//JUgg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hyatt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:57:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748d96b974cso1074193b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372622; x=1753977422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eXGMOuQy5UD0xBEyKQmMrAv/q+wo0dMe9aS5o4AHm4=;
        b=k2ZmcJ6wTy7ais2N7ihKOAEJLhoayMUMfHyKI1qh9stDRLMHsCC/BtxDefM1MLvLzf
         TD2SgzH4kGeHTUi77gypK56OsL8FXEPmoTbHNv9fklOaUEGLYHhhxjeChcvMgQdXhN3D
         cD+Fdmbe0nxw/r3DhgqB1Jqxoeg6l6WG4991UlxVtiTFlJV7s06SeZOHlEjLOkpwpQlg
         HniBUuFftiajWt06HdPSui5U8EcqCve1HOvBxzqgcIBBE0TcJ1KskysiRTO5Tq+r1Sma
         Uhic0XxxSJOFG3N8h5+DkPbkuWTP4Ia4kx4pDAyqPrX/IrtGWRPSCsPLZMbCkC7EZVwm
         v9ew==
X-Forwarded-Encrypted: i=1; AJvYcCUjD1iU7GQI6AvW+RVti5hwwY86Yns44WAobLEzGY1IJe2pMVRqI6AnKAXjAFL7KILvgknTf+DF8jzHXN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykCR2/XujqfQXuF81DCwXVsKmtJaJmmgnNCa1aMfeGosV8IbB
	1c/+UUJmU/HC6LpfNw2PSZCvjNjl78YDjtRCm1cJPQT4qtdDK+3kSAl8HZkI56dbD+HA3aioHpr
	OA1X1J1YiBZmj/M+ZlfKFuPRqot5Pno0X6+QprY8aVP5Oh+S4FvNE6w1vILUjBGZY4Es=
X-Gm-Gg: ASbGncuWKivEobdOWob+wPljBW3GbprWwBZqw/Ouffr888FiKsL9yggxdWpiV+FWzWi
	hySqGaOAKjmVyGX/l4qQoww4i48Qvc+0a0eQa3lDl/ZY0qP5suU1SDpR14Y54WDUBVc1+1dzjNe
	8kNVZtXgrvx138kZ6LuK00TqAfOwz0EYJEd1aZR5rOsR3kygbR0r5wtbOfZkjs8ferhjZ9j2Xpo
	mlEC6eDl3kuncdj475z87m7rvMTkpBOQLjvOEjWsryM7OGRgPdFTAmRaGcV6cjFI0m5D58NuDYP
	1xD9bWnSJx8OGldt2TPJSqnDc5LSwHNM/Cpq+WHtOUl1AKYEgCVWJx19xDm3Z3sul++HeCIRF6q
	0
X-Received: by 2002:a05:6a00:1485:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-76034c0047fmr11693224b3a.4.1753372622177;
        Thu, 24 Jul 2025 08:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQRpVKNYqX8ET8Nc5geOzF3YP+Ip7Ck74EGzan+vHURyt+s/W6A+BS/xt0gTmQP+zPfRHRlA==
X-Received: by 2002:a05:6a00:1485:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-76034c0047fmr11693190b3a.4.1753372621754;
        Thu, 24 Jul 2025 08:57:01 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b05e8498sm1988516b3a.98.2025.07.24.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:57:01 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sa8775p: Add gpr node
Date: Thu, 24 Jul 2025 21:26:31 +0530
Message-Id: <20250724155632.236675-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250724155632.236675-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=688257cf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UhVUwdw8r1UmGneQsTgA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMSBTYWx0ZWRfX++qvsDbWSi+1
 9K/g3RW3Z2d6OObqPHYfKi9G0A1oYF1jrc//fQCtpTlVVWrn2sWywjOuK6ZUsSgcxQMvkfro8GS
 FnwWLpZbS3gkp7J4MfVLB1i8fZCp5uIJ2fHWveoOwo0clEZN/QGtR6aufGJCDc+u7nUwIb8iNFy
 r8eEcoZhlUax5POdg82wMe6/dm64LnDFXBVQakubUzMTDbISOK+9FvwIzcjNvqNDtX8YW+5hMqW
 6xyh6f4mx1z9unqsssdoaPulTc8gDiU0pRPH5yZZK4VNCtHHuupFnUvWtegkOYW/AE2TYCwsoII
 TPnO5CpxGWyCWC9CYeEUSvdxG7exM/3BNBy7HyrH969Fdpz/mR7Dj08hR4vChixUvcO/hu1o38k
 oZ85421QA7GiiQVUsoIxbbxuscny51rKxqqgb3k+Yhu2Hy23t8NxCiI1NE7DJt/4sywc7E0b
X-Proofpoint-GUID: hJKpUksw_V6CdlpOEdzTgHO_0JAKgU4X
X-Proofpoint-ORIG-GUID: hJKpUksw_V6CdlpOEdzTgHO_0JAKgU4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240121

Add GPR(Generic Pack router) node along with
APM(Audio Process Manager) and PRM(Proxy resource
Manager) audio services.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f5..9bbf273ffce1 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -19,6 +19,7 @@
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -6584,6 +6585,45 @@ compute-cb@5 {
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
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x3001 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
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
2.34.1


