Return-Path: <linux-kernel+bounces-737095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B904B0A7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364F25C4B04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78772DECC2;
	Fri, 18 Jul 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7ScUeNy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C72DECAD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852722; cv=none; b=iv70dHMCzAiP+zJID8QgA6BC2qe/jU3fgdmwyWRYJ+YB5f8bKW8jiEBiLlEyKOWd3crg9m1oh/lAOiNFhzRp1ajVLVTVZn9CJZJGojN3VINtRrAAKfkpIyL/PpCrhDFXeqrejKQrqqu+z7WG1xcru/4r84Sa51HttnYv0DMxn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852722; c=relaxed/simple;
	bh=1De67kCy8URfztxKyr/raL7Bg9/P/WLNdrwWTrPtkxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrC1vKI5OLgScfWinz8WfcyGj6D/oyeQqhs9l0vBG5cIywk8VJAVWAFGBoWvaUhsKIfgkJ2yycncregwDQEs3Bbjlrm5D5AG1vSAgQD/3dD+5XxL3pqVK+E+KiwtCd6UA0ZEKQ7RcIBSC6wK0l5NXABHhif0sVPViOafv5XtWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7ScUeNy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFFG8v022251
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uv7G97OIul7rO6dcvJJAbppowFCFlWCEEc9IoZH0x4Q=; b=e7ScUeNyNFLIkoqW
	B7r9tiYVueJs0ANGPThJROuGmDaWWTK2+ZAvHrdTpU2JeFuPqxgiIprH2IfYN2aY
	qerHtnKhPNMUU9hWVJAaogoeoCgUJJIg9ksWmeOB6kWOpjNgEJdKteCC0uIPUAFs
	KLmskZySVg71NNb3UOxsKw+2Xt4azJXR8tnbJZC3yt6JC437fBDaCYnNLXDPLcJD
	k2aUeFlj2GYlvbSG2RD44KwD9PuiQKKFkuhv1+1ZLyGdQCpyg+xiCScjJr8WL//Q
	CQqAiZTGMZufHkTNSBamdrR/3l1HqEdP/q1bXpQs0qInJBSh/qJQwgYsWeSC5uqY
	DFFbCQ==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyc3jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:31:59 +0000 (GMT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-879c399059eso197567339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852719; x=1753457519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv7G97OIul7rO6dcvJJAbppowFCFlWCEEc9IoZH0x4Q=;
        b=FDoTQCeoaFeBTTiJqV5yKSxwlzOa0kKFcOOZ87SE/nBqM0yNn7WgCVGX0H72TGWF7p
         4UOp4Mi8GqXjSpL4Anm9kkLg/M1n+Q7qpzVhLxB4pTz5WjiYl89FZ1SRb+65Yw9Ulmxl
         aDsM3BudJRcfCilEbDOp7vWkq12S1Gj4rQjzA7fn9STKS4mRb5jBpTgxvPV3f7OzbnYe
         n7GGE9+MQDZq3QiSpDM49MQCbDsUVHC+gX8jI7hSCfIKlT/2PWflNMlHB0gFx65S+/wP
         xj1OKA4RpajswIdYt62U/wZlT7casZaCmpHlXzrpvi5MJ5MWxNBsUwli01nTY2hYsM1s
         k6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXcCUmPtV0xfhYt4VJFo4sTHaGhQREZmNf7cB+2GnrcuqQi83YpZCkAL/plclMlokv7ddIFuI2DwWojKG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2u0gp8T+Jo7HsBU9A0EfjSg4DaDAx3KNKDPAlzgKGq5zbv/C
	v9ZPnNnNSpqOFSzFLGN3vYMzvkVQYcA29lthMa/wTFWErR3Jc9duXhwTMDaPzUogERBjBu5zyTp
	lDDcqF1DBGHLENct6/0rijSwoe3sEldxQolwBUHGBpPi5X6TrLahe9oyixoX5vECm2VE=
X-Gm-Gg: ASbGncv3kHcKw/i/1HYfgI1xWg9ZKec+AXGWJh4ehMsLaWZsVTbKiRZsP/hDVzJ7zv1
	cNcsfNySV+ZvnSE//yMNTAoMCuFB/6jNIFVZ4/aRXi1bUw/kRGEu/IzAOlR0FeKCA21EnBMAVOa
	n/dXyXo0QyFNGHfYafGzSUcOnEsupCHR3DIMWa2fg5hgRTN3YL2rOtj1ZJUNNoEYaUBeV/bWmX2
	2/Fzq3Xy9YN36HdpZqMkNgHoW08iCW/sof9i7zI74rMn+Y56RFLNqCCOcmv/j+ErpRyF5FAKiVY
	vZ6aWtiB30WtJhQ/ww6T/XVM+XBSiIL4ACLEULQZR8/J0xOrUod/hPi7cq2DTxxzWIDiJi3+ffU
	/pz11N+6qe6OxmFzv9YjelmfYdwZuN1warHc1203DDCr3HmUuIzKt
X-Received: by 2002:a05:620a:414f:b0:7e2:19bf:4e01 with SMTP id af79cd13be357-7e342b43fb6mr1483106785a.28.1752852342455;
        Fri, 18 Jul 2025 08:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXNJSKWpVZoMoVHi4t6o0RfQNPL9fdUuEDcWxrS63N1vsmlqqt5W3qdsSaF3AqQyjZUNxjyA==
X-Received: by 2002:a05:620a:414f:b0:7e2:19bf:4e01 with SMTP id af79cd13be357-7e342b43fb6mr1483100185a.28.1752852341817;
        Fri, 18 Jul 2025 08:25:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d994csm2466821fa.84.2025.07.18.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:25:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 18:25:38 +0300
Subject: [PATCH v2 1/4] arm64: dts: qcom: sa8775p: fix RPMh power domain
 indices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-fix-rpmhpd-abi-v2-1-0059edb9ddb3@oss.qualcomm.com>
References: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
In-Reply-To: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1De67kCy8URfztxKyr/raL7Bg9/P/WLNdrwWTrPtkxg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0ZVetGFGK5Y1o457J3dDlxHjtW83zHj9ax3Qkn3k3KkV
 GztLeM7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCR65vY/xf5Hw0J/inR+q/a
 LH6166ZzOy8HcMglXT7R7pRi+jF+YVP98WeMW2YF63zaUnqcLffkw40MqaFqn+vTpA1y/8m78r+
 ql658URB9X8mJVS/8af0+0Q31rNqKycyS2uIXGHOvm6g1skeFhfv0nI3emfvMbtH/P9c+9fz8Eu
 qncS+Ee8bPuX7tP88JmUZaz8xyO8BdfaCXzzz584W/9nN2bg16ZSGtnXrj6rGm5/qbjU5P2FUS+
 jAh84y7zLxbGUuXvnnH+i/s8flWrZ/GyxP8Xau/sPhEJzHVncr7snj7XdWuaRvNJ/10sGXOrMju
 fLBgjs+O3OxyXcvqqPeia7nf3uqLrs5NFRdmeuKxxzAOAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyMCBTYWx0ZWRfXwU+dPJ8DNRqd
 f+dh7/5iC3mqDb95GMAZdZnR4NO3VposWg1NJnbH2yQXGtc8hmfMy4IUWHrb+DSlvzwheL6RqLu
 L+zxZqyeMrc6OHqptWpOGXvFOhndfo+oSaxY1Q8DRDtq3ZQ3+uLsAXei7aMgrxfkBwekx1P8cHS
 rogAogetqBUKyFUVhXhImsdJQ8eFJKXbn690da0XcDd9xo7I8Qv4nf8F5eXn5esVA8e8L1GcnU9
 NC0eoHj0Jnmd7XcTpEBqV+R3qFoD/KgFFLQjXmI+PAU6thWFmItoWtSsWwLDDaXs6E8DWY9/4/8
 n/JCfUBG1KljUjZBnAOOcYfmImRKrWV+AsOlX0Sf9rbvADJMz0b0991rD+N9YRUHhJwkYED6m0b
 Zr+s9qGIEaXtcYxNpobuThMYDa4EgmpGGvK/20juMpmQvE/N9J4DHVXN0+OkHJ0Juq9aJCMH
X-Proofpoint-GUID: qplEDztViGK7kUhajcy9t9IW-Z8PbZX3
X-Proofpoint-ORIG-GUID: qplEDztViGK7kUhajcy9t9IW-Z8PbZX3
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a68ef cx=c_pps
 a=7F85Ct0dzgNClt63SJIU8Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=kgFMI072Rb3UDlC8HFgA:9
 a=QEXdDO2ut3YA:10 a=LKR0efx6xuerLj5D82wC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=869 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180120

On SA8775P power domains device doesn't use unufied (RPMHPD_foo) ABI,
but it uses SoC-specific indices (SA8775P_foo). Consequently, all DSP on
that platform are referencing random PDs instead of the expected ones.

Correct indices used for that platform.

Fixes: df54dcb34ff2 ("arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP nodes")
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f57d7894dc1eacb6a809caa427c6c4..214e2c0e74ef53e8bc57acb8ee88901ef1006298 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -17,7 +17,6 @@
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/firmware/qcom,scm.h>
-#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -6055,8 +6054,8 @@ remoteproc_gpdsp0: remoteproc@20c00000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>;
+			power-domains = <&rpmhpd SA8775P_CX>,
+					<&rpmhpd SA8775P_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			interconnects = <&gpdsp_anoc MASTER_DSP0 0
@@ -6098,8 +6097,8 @@ remoteproc_gpdsp1: remoteproc@21c00000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>;
+			power-domains = <&rpmhpd SA8775P_CX>,
+					<&rpmhpd SA8775P_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			interconnects = <&gpdsp_anoc MASTER_DSP1 0
@@ -6239,9 +6238,9 @@ remoteproc_cdsp0: remoteproc@26300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>,
-					<&rpmhpd RPMHPD_NSP0>;
+			power-domains = <&rpmhpd SA8775P_CX>,
+					<&rpmhpd SA8775P_MXC>,
+					<&rpmhpd SA8775P_NSP0>;
 			power-domain-names = "cx", "mxc", "nsp";
 
 			interconnects = <&nspa_noc MASTER_CDSP_PROC 0
@@ -6371,9 +6370,9 @@ remoteproc_cdsp1: remoteproc@2a300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>,
-					<&rpmhpd RPMHPD_NSP1>;
+			power-domains = <&rpmhpd SA8775P_CX>,
+					<&rpmhpd SA8775P_MXC>,
+					<&rpmhpd SA8775P_NSP1>;
 			power-domain-names = "cx", "mxc", "nsp";
 
 			interconnects = <&nspb_noc MASTER_CDSP_PROC_B 0
@@ -6527,8 +6526,8 @@ remoteproc_adsp: remoteproc@30000000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd RPMHPD_LCX>,
-					<&rpmhpd RPMHPD_LMX>;
+			power-domains = <&rpmhpd SA8775P_LCX>,
+					<&rpmhpd SA8775P_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			interconnects = <&lpass_ag_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;

-- 
2.39.5


