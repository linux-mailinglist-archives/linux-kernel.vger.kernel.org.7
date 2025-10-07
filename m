Return-Path: <linux-kernel+bounces-843773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20EBC037C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AFB3B29EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423E5221FD2;
	Tue,  7 Oct 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6E67+pb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788C21FF48
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815923; cv=none; b=h8BdUaLnRc1jrH4nCG7fylt6t7u2VJDkLZW5ax3nX7qDwssZuRSteFXy9bwRLYzpgiJdY+ja1B5M/BeCa+d13tfpL3vppt9SrBd1FbgtBXpYLiGDM9R9//XSrpW19zctOBL9/bmrWo5wAcg4lEBrQhaaKYK4LpXCP5COnQqcsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815923; c=relaxed/simple;
	bh=0EKqpiOX2W6t2od4FIJHfHdUgAzp0BhzNOL2IivIrD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSlxy04OegYn+Ie309k0h/Yc82kmPtqWcTn+nhwRcbDMTzvpxkvMGtCuy6j0C0OQkM6c1ECq/tf5aXp4lp61eaWdObzf3EvhC3Jjanpn4h0a+gzEa1lyJHpYFSgTQlhzD2r47VxJJrHX+Ga+4hRE6bOGaNRMru/N2wpi5GNwlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6E67+pb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596LL0Fv018135
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9+2/mAql7qM
	E7oKEfw/drCG/IAJJAuQWzrKVBwLb+QU=; b=B6E67+pbDyCouZ9jM/Qa3uY3WxO
	uCMt3ikvIFS+yUXHnMLi4lZ3wW4yckNGmZInNInB93KC2uh4mB2VUFN30MzrzEii
	bnkMCKOyAcDL8PaWu/vcNsSsut9Tmx+Z99I8tnnH2pEAVrwCnONxDTT7FTqaaUvt
	lvPh/4vJ65EzufI+Lfuofkq4Z/y24AD/f3t5SlodmDhDwYa4lF7tEYjyTZqvM4VF
	ojIxCz+akdg2UVTvdbnaFD9/True7EWMcRdDfrB+wEeYO1xkTuva3b89iYdz1iIP
	Ch03K/jGbDWiAKW6YnbsmF9GiJrf3YVJnM6nTja+2QYtnGlir/6rvbFElKw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkprxv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:45:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb3736080so1515223a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815920; x=1760420720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+2/mAql7qME7oKEfw/drCG/IAJJAuQWzrKVBwLb+QU=;
        b=vx8UlVr9iPEjPEIYkI0oCSjk3o77aMooY/UgpjdGBorsDeihbyAZrGtftxlECxp84A
         MjmDRYl+jXcrr6goYuLHsJB2i7SPPtYYsdd6eoB0bKtQV5m6pWp4teoVmTqY3YnvmLt/
         6POJR+PAC0p6/lvY1XtkYNrvYxz3E2gzqy2vFe28LirFalhXofXZopNiDZbMh8uaqpJH
         RLl5kar51ufVLSiWTvBUCN9hZ3O8Fw8qie9YYu8ZJU8v/kNJGYNg8B1dqnyVNRLb0YZk
         xTnk/iHf/sxEiwAPSdsrCybyywlWFV3bE6GTtzimpuuIiSZtQsyj89SqxjA0JszijT/9
         2Hew==
X-Forwarded-Encrypted: i=1; AJvYcCW+d+D+z9p84iRZ+Mw5KZ6vHlNdetIzSuEjtdoH0dI/fY3iNzo0OsnFxlDkAE9MR2HjlxRuSaAhEtORhII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHe6rtrc1IWiF4zsXXtsU4sRDTRR/B1PysxFb4jZKqs7jkanO5
	2jwWKpfhV3orosC1S5uNEvqpdkJR85BbmyCcmXam8u+5rUgY24mHqEqA8B/ttI857rl09m1fmQx
	0Sa/kTgHYM9nYAEJI3prrH2zBMO8SSRTd9ioMWJHuU9Do8E/xYcjPSyi+AfqIFJQLGg==
X-Gm-Gg: ASbGncs6huIzSIr4J6OkdnVtXyJXxtF/J0/q6QDOOBmAQEOYP38A1dq3kT27twH8bpt
	yPOjXk7/UAlW/xsYAoU/7HNR5m9Wp43x97deaNZuPa8MBsL3n062K35IXb0z7ZxmN3lWa5fOhq2
	kjcQb0T50fV1ul6ecPH1/bvNee0OsfvJgGLvwXHgaEJmezUfhbvBkTXwyWWQpikJz5jQd9hfgp+
	neaj4H/AmyTuHCTUX4HunJVWdpUCbajnxY7cAaEh7PpXLJV++zWMct2JVsvH8lSo5S0vfLaRNaN
	2YumRqdgQuALEmZb4NPp+fxnh4zqDkxFRLPea2L6vqwfqJI+4UlyTvt8+wk4tssT5fXLLKTxTdL
	z
X-Received: by 2002:a17:90b:180a:b0:330:3fb7:d874 with SMTP id 98e67ed59e1d1-339c27e2dc9mr10875374a91.8.1759815920175;
        Mon, 06 Oct 2025 22:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpTJcfZZfCFrzDxUSpYGZieF1ZbCv44oGSarVlu+9sfLvIJsOg1g2Arn6saahohiElBO/B6A==
X-Received: by 2002:a17:90b:180a:b0:330:3fb7:d874 with SMTP id 98e67ed59e1d1-339c27e2dc9mr10875345a91.8.1759815919699;
        Mon, 06 Oct 2025 22:45:19 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:45:19 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1 3/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 mtp and qrd board
Date: Tue,  7 Oct 2025 11:14:45 +0530
Message-Id: <20251007054445.4096630-4-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v9Cy4L_srsf72xWmgYTNvYWGtt5lXCae
X-Proofpoint-ORIG-GUID: v9Cy4L_srsf72xWmgYTNvYWGtt5lXCae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX1vtaSJkLZugE
 Zx6dYlT7QTOFxcATredbWFvBegnClKZfBfDXyJIJ5JKpm/20xl1UQgjSCDwOMmKUBb1ivdRP2KD
 ncskaejEnPtemG6QDaED6u340Dp7dOvn3qxf1Kb59JSiw56QUKZj9CL8KT0xBeP5QefXcXFI9y+
 nKkmEecpS1+PbQBIHmMKo0ZBJPecZdDGv4bvmEhpAKsOoZ6hoxFbLC/+Q2QaJm4mWnG3Y1fjZbs
 wHCsnUWx+kUPAU8FNuFy2NvyWCXKjmhXC6mOkUFmLfm0wIAMmItp9EpzMmxqYRItkvYPgTE+wbS
 E0ZNoMeIFmuNtCcMipGifwZB4r+kqD90C4EwfVtP5ifsaLacs7wetA1ZRiyM+yG8q3zKA6ZWBwD
 14Mrykq7j8PeirpbKJWOTgqOUsTn+w==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e4a8f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=byWEWhS8dMihj_ejDHYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

Enable SD Card host controller for sm8750 mtp and qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..26548191d95d 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1030,6 +1030,21 @@ &remoteproc_mpss {
 	status = "fail";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..8d018eef44da 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -916,6 +916,22 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
-- 
2.34.1


