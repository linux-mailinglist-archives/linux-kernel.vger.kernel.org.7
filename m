Return-Path: <linux-kernel+bounces-868637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F22C05AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542834E5DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDC31354F;
	Fri, 24 Oct 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SuzXCVTo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AF31329C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303041; cv=none; b=uRYjxj+yWrJl0poxGCcSQNAtY37pUmulBlMZG9LzVW3ICi+mEDjyPNYpnSXs5WT39EC12EB1P9ofjw0ZaDq4aVdDx9ASt31rUuyTdZKfvZ50XYvvglxYlIvwFOTnsLR7XjkRRawCr95jhSgNvxUN8l+sgffsrVOdFxwVf5YrDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303041; c=relaxed/simple;
	bh=WPGiDfcWovbn61egHdhHxs84SiuVP8EjCt0AvyxtedE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVAmTc3Ua9TxitVn2zqFq1Qqq0lEJQopI8r4xmqMSNKE56soZOG8X+E+upceq83IJ7BhDQb6CeLwTpPnC/aLIn7+Yqh9XP0fTCdL5hyjMjtq0MCvGmfw23oLX/XNmw3nV8NT3nxbSXPL/Asvxr3m205bkzYWgHC2UwipFuT6zEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SuzXCVTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3MHx4021689
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i9RE9ZFSbYk
	I2uHWWS1BVwm3WmE2jqPOJsoCfsqTrAk=; b=SuzXCVToIetAtNwUmPP2nCww3A9
	Y1TMmnCILe3kQ53ORblD8wbqTDX/2kojvgbM068z89peP9HVeSTNHw0E6KqnY4oc
	heBvno3Ucwy139glDBqX8XcNzkeLfF8RyJntIzGpvPlydL3q7ewWLAcrP44Sm21H
	d1C+xEmaLNJmju1Gn+2KAeBSdlO+5of7jIuyIP+ybnX8aWnmIbQtuqopVjR4dqVv
	fRay1HpBXw1/piFHy9vzDdC9bd49uVNSFmEC0oqwz8757aiV9YbcaVOtE+M1Yp+U
	Gf59J3byAQASucpJB/0qb/Ajnc530AV+6BMqI1FiPPC6KIyLjE0u6LeUkpw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8nxvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-286a252bfbfso48883765ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303038; x=1761907838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9RE9ZFSbYkI2uHWWS1BVwm3WmE2jqPOJsoCfsqTrAk=;
        b=JOp0RXYIvkNvIZ1YiH040FdG1ztAw1BezwV10IPtKfNHsP2DBL3DtCoFIFz+GdrJkB
         RNmjh3AxnIy0pxDvpoI8201ugzE8myjQLTXC31STXbxK69ZpP7B5lK7qEr7ajpxtX6Zh
         UGdcfHMWDTsKTKLnJvslkkwdz1J5Ltq6Kj9a0JWK2FsAU8B/kDag0O7XLmKrJtE1YqQW
         VU9I36MPZEgl1mv+bI8Y6ScrN7Q29ewEVL2zyYzwbtuVNgMQnbgYy+uGmgh1Cob0/zmw
         RoangWozNZjsjTne0eqPjd7rrVmFRKtsmxa5TC1wGejMj883SietSwxnQKfYyJaP1QxN
         DYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0eTGCJngIxFf1VCUXNO8ixPG1TIJ5s2AKAI1yNxzIqJfMQp1VSbjYn3zHbs4xbgJ6a6u2xMUuRDsFMjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3q2vgEYdX9DHwA5dyj2h7SjG2wbsMYQj66m2SiFQmQHVk7kk
	oQC0BX0L2nH0+uxWkoaR8Uj+Nf6Sm1/AU98N2a5a6AWQhi0zaR08ID64CBS1bI26nv4qVU671Fw
	CFkrBzicxA+aPAHKhUpcCJO9ItkKDAxKKGGr0C368MNcgzaRFqZmLLSg+c9bi2GzhMjrRbsuixm
	U=
X-Gm-Gg: ASbGncuJqrr0bKcMn62VphxvmE08qXy8gG3vgU0ULhuY5kMFITcsctP15Stb5pZSnzY
	nhhJNQYcCbVr5zekTq/u/GWSn/X/zuAZafeB++bOK8peyy7ZPEkTiTLLIR/vkRctsFjldFjukXS
	egWpD2ZulFs35nzteOtWSAnLj3SuWmTfJzHNqOUGLknjTeHc5qbQ+oSEzhdBjSHcfNhUeUAr658
	EvvFqtrXIuDBrbZx01MWKXZrC3LpXzDJxYvzde/5/e650XwrNBGfyUSP09GaqreZzq+niStZHRk
	yikQ+DQwcGx7kEkDEbmG5HoocSPFpOLZHenbfWAZJsVWRnsGxmtw9yusODBSB54/NC856xOKs0M
	lkxHsjC/XP9SAgFUKGiYH6tUY75zmbNnSHoDt
X-Received: by 2002:a17:902:fc4b:b0:290:a70e:6261 with SMTP id d9443c01a7336-290c9c93c30mr349390065ad.11.1761303037632;
        Fri, 24 Oct 2025 03:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXw79W9RUWBmxKCdwnYGEXSMksO/yt2QD3Y/MhqjoK4q5FjIhJjYCm5PRw7UriDx5DKmsJKg==
X-Received: by 2002:a17:902:fc4b:b0:290:a70e:6261 with SMTP id d9443c01a7336-290c9c93c30mr349389865ad.11.1761303037233;
        Fri, 24 Oct 2025 03:50:37 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm51236775ad.103.2025.10.24.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:50:36 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH 2/2] arm64: dts: qcom: lemans: Add missing quirk for HS only USB controller
Date: Fri, 24 Oct 2025 16:20:19 +0530
Message-Id: <20251024105019.2220832-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gCE8C0cWgq33P-UQB7QNJgSiq2bqXZMb
X-Proofpoint-GUID: gCE8C0cWgq33P-UQB7QNJgSiq2bqXZMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX85PBzYdFGUAh
 RW01AtIp8zUk13f4di0WdtB3ZZG2dXjwScRUC4cp5twfjPobeXAlPQW7LBVSTxAK7ldGTbVSgQG
 P1UwhQfkq5iKY92Eja4ykIZkk2rj0V+2x94EV7LhlzOHRoVU0K8pLdvbM3bRiTslFVgDpWy4kpy
 e+jlAcB0HUJHNLZMzKsfqgg46gl9+CtgGV74CQkviiz4DyJ0wKn/5d74849pF9/ZYvFt/tbTThC
 ky3xBfEI5Bd4U+GkskUe8bw6GC1fIK25VrlC6dxXm9d1mBh8LRjn6M6Dm34DGt4rVoZ9wOCa8pF
 ko+YYUsrqxd9FIHnbfQ3PRB1hQFwSZ1Q0Q3IbbWM2smoOJuKAD5v4WxWGw8F5FTUCGxWCgp/vv+
 FrxvsxyUnxQ+PJecSItLK+Fl8mPP3w==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fb59ff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=d1616NNI0-D16vPRn74A:9 a=dwazZoRKGdePyhm7:21 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

The PIPE clock is provided by the USB3 PHY, which is predictably not
connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
quirk to  HS only USB controller to disable pipe clock requirement.

Fixes: de1001525c1a ("arm64: dts: qcom: sa8775p: add USB nodes")
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index cf685cb186ed..c2d2200d845b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4106,6 +4106,7 @@ usb_2: usb@a400000 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB2 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			qcom,select-utmi-as-pipe-clk;
 			wakeup-source;
 
 			iommus = <&apps_smmu 0x020 0x0>;
-- 
2.34.1


