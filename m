Return-Path: <linux-kernel+bounces-774959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D1B2B9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A41D16C5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192B26C398;
	Tue, 19 Aug 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+JMjzgE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331A2773D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585417; cv=none; b=ljnBIIlr14gtWslZmn2e37PtRWXLA0J7ctXXPfaMUi2FpTOwGCoHIZfxiwYnjOi0OV1VC+JC2pVuvdoJvxSWOUnqxCsh5l9u+tEMTIVHanbyUeKHC96zGd99vg+BN/eoqFK6VsKVDo/uvmXXiZ0fdtuzp4AzykjEJWxBl3kJ7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585417; c=relaxed/simple;
	bh=ooP0tmuQEvh+EyQR6KnOEmMXb3H4OJjm1CP4dfl/QSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMD5I5diM1rZLbNqCHKVDjseITVeqJkrsNMiEZHOcCaKJQ/YR6PfFXbAqiW2Y/g0OXkhnFlt/cSW9lQHcA0LmtwGdzMDnY7NDfxCO59U1zaMkHz+N/wdCPXddTpiEvlRSUfNsHQk8Km+Wfoo/R+rmMWXWw2Dl55f4Bo/+vzF5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+JMjzgE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J0EL3N001947
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NsIfrvTLDxKj7MQKwmdBE+vbOboHExWTllcv4P/M3bA=; b=c+JMjzgEcVFmcxER
	v3JF67q6FOkC376kvXdUcyupeLy+T1ZB7CInbTGMcmOqLH9pfIQJBW36EzhEpaBq
	DbrcoBs2lK955IEMidOTVzVyfT5r2YUqIRQ7qj6CO6diaagvPNHPsKGyML2HGMEv
	D2gzTc+lJMlCGsx8pbAtcoLHnJZyyTGWfK1a+H63aMZXvVqNOaLQGv64d1Thl/s5
	r//HcGmwGHFurajZqtmQHu4O0bsO/9P9ludM8U95If+lfO5bRdsdwjbVF7nve8cI
	sW7vTww3IVzI5faDIxEYcFwv5e/lDUQaHRioSqn+w4sCntTJn+Ks/YWsYccxhSrs
	pBIyVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vje5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:36:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244582c20e7so56360475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585414; x=1756190214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsIfrvTLDxKj7MQKwmdBE+vbOboHExWTllcv4P/M3bA=;
        b=UHaWDdz5ViDrVs3DHkNX1ou3MsB74wZKqxg+l1SIWc59ZCsuOymqE7SBB258OlqLmL
         Ff9Y4c2fF031NsPBqT4ATp//E2qG94/0Y+BqnojL6z0sHe73xgn6F4oeYs6EgvljmTL9
         9fKpfCJzhLKWeYVC1yOlcGEtim/4+7sjVPEsJu3QxPJujjxW/Kvvl4qRywPHWn6vo/Im
         jQBhjLWLiD5m+tC/X/cAY6n6mxvYGea4LydtUxghtqDazmr9g+9XWKZJlMSSWTP9e6Zb
         TK90r07JnWbC7iYrdHV0UBXH3ncjmvK0ZZ9OKwrZy9SEQ881jz+bGGG7zmBswzcikmTB
         gA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6PsfvVyP65TvyQwnTXt+m3ebsJnqHWwgOUvQSYtSyHWslNDrBQsf0mfzjUttPvqzdblJ/rrgjGYkb5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsSrqKIpaVn+CQVacIbUQx+XFPLHE/UwozVjffjksx+CX2nzx
	wcCTR2pDEcsgC2J456sf/RdpfA8CawMkFZ82K2CHeTBOC+RTqKjzICadZ+hnsSSCSkA1axfKJxi
	T4vEZKopDmraot2qWOgZVTU8uGqFORAlQmNmI8556rf+ZzY8qTNfb9b2PHEI84vORtpk=
X-Gm-Gg: ASbGncvyN7zMkYzf9FiPNqarPhuQb9gmz+DLXTyqjwNE+gJmENZMM8uNtWo2frAsfGw
	q0VA7Dv+dUwfX77f39ESXytYCuhxyBfMLZvkKchCrRanu7kXF7ssAbAaSa8NsO95OHlCD8BHwGM
	PTw0i6doamXJbzxt3xvau1z3wdsbcY/MM4C5IrZez3c5eSXX6l2YSoqT2Ck4Jqr3EXk08w0Rcsn
	StUvLzhiHo1a4jQ1yTVyt8F1CR4QVys7Vz7aUHHZmIMRjYYbxtQUPnRwfRLHUmUWBNFd5YoKepP
	OG/GuY36BwZZLxK0pmi8jnvaOMF82sgPeSqUYhPSx5xHVwTqYcpTi2oXlmI9ZLMiZZRcr6Q9aq4
	Wj0oKEvyA67zCn0s12Ds2osviQ+zoEHDtGg==
X-Received: by 2002:a17:902:fc50:b0:234:a734:4ab1 with SMTP id d9443c01a7336-245e02c1277mr16956175ad.3.1755585413799;
        Mon, 18 Aug 2025 23:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOco999Bi1j/ttDYbCi3adNC02Vim++BGoj+wK9RJiQcjLfwcPNu9Sf7OenyvPy4yfGschLQ==
X-Received: by 2002:a17:902:fc50:b0:234:a734:4ab1 with SMTP id d9443c01a7336-245e02c1277mr16955945ad.3.1755585413364;
        Mon, 18 Aug 2025 23:36:53 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:36:53 -0700 (PDT)
From: YijieYang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:35:58 +0800
Subject: [PATCH v4 3/6] arm64: dts: qcom: qcs615: add ethernet node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-3-5050ed3402cb@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
In-Reply-To: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585388; l=1620;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=esGpkrp578FqjkRZx/3YPPX9onv/FUSUV77hdcvh6nw=;
 b=SUGbTSGQ410eDz8ELdraMbuF+QvX9Z7EjnQVSHXQrih713dfkqJqB0VRBBkKfxTattHHcRdCV
 LC73TCyJ5V5CFuy5wSYE3kML7+6fQj/5Yhsi4kHtiXSyscOKAuX5Nlo
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX2/BufuPomel/
 0jwP0IyKK/p8PS9T7IVblcul+H2SMhvfcHKzLvWQH3TiLT3uvuKA4IEonjw8OTE/o8akNCETorq
 JVforci2TDZ44KeUlNRC+uNtTvjVeY9jitOAz0jNz8hQ+eHIAXuEaWMG2lcPXFq8ftwzQ8gZZ5U
 C38awkpiq5UCR1jS4sUbd0xcPOfPIfTshapBDWB6C2rrJ4g0f95zjqd5neQHXf04PZWWoPQUPFE
 Q8Q3qtMKMcwdJkSl1tPY4rfJhJtaFFwqUk+ibx/DXz/FJqKRd00lrEj9ZKxNF/ByOhQnmUZZwfY
 csPrUUjKSVQx6ivNsSW9BqXOnGawZFN/CVRvkwgC44ZYI0wdg2Cxtr4B3plhXGQ1WpEaaoh3Pnq
 73i699f2
X-Proofpoint-GUID: I9Lh6SGK0YNOqxOAY8TbD7e-h6So1djw
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a41b87 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ufJ1yBTjRq6Z22V5Zn0A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: I9Lh6SGK0YNOqxOAY8TbD7e-h6So1djw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

From: Yijie Yang <quic_yijiyang@quicinc.com>

Add an ethernet controller node for QCS615 SoC to enable ethernet
functionality.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 591fcb740259..8ec97532911c 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -491,6 +491,39 @@ soc: soc@0 {
 		dma-ranges = <0 0 0 0 0x10 0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		ethernet: ethernet@20000 {
+			compatible = "qcom,qcs615-ethqos", "qcom,qcs404-ethqos";
+			reg = <0x0 0x00020000 0x0 0x10000>,
+			      <0x0 0x00036000 0x0 0x100>;
+			reg-names = "stmmaceth",
+				    "rgmii";
+
+			clocks = <&gcc GCC_EMAC_AXI_CLK>,
+				 <&gcc GCC_EMAC_SLV_AHB_CLK>,
+				 <&gcc GCC_EMAC_PTP_CLK>,
+				 <&gcc GCC_EMAC_RGMII_CLK>;
+			clock-names = "stmmaceth",
+				      "pclk",
+				      "ptp_ref",
+				      "rgmii";
+
+			interrupts = <GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "eth_lpi";
+
+			power-domains = <&gcc EMAC_GDSC>;
+			resets = <&gcc GCC_EMAC_BCR>;
+
+			iommus = <&apps_smmu 0x1c0 0x0>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <20480>;
+
+			status = "disabled";
+		};
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,qcs615-gcc";

-- 
2.34.1


