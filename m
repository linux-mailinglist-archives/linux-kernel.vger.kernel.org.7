Return-Path: <linux-kernel+bounces-850377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D92BD2A81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D5A189C334
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C1305E1D;
	Mon, 13 Oct 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6BeEayn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88C305E10
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352846; cv=none; b=daE4rY7+2CrlgW96uII0v8SLEM30F0pxubhXyVLsf7x+aiqQv/eFuw42q9Vh0weG7HrGjbt/4gnhe3tlt1iixsftB0qcIGSDS58w0KCgZJhWJ42YuK15bSjkWqMyXdzSR8eezELE5LNW4FNJpiNuuS5BgtBpz0PhQ4QhaQpj3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352846; c=relaxed/simple;
	bh=y2oEgd+ZoMp2aZIZllFCtM7ZHgenc6dnMUZhPAHCRYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCPwlKRmHXzw4odA4YbXzBirrJ1yVGgowlLgbCPauG+Hmq/s5h//TeRFqOMC2ZVODFp+fkZ5m/Ra7dLq3XdkBaU3aQFcXfstuAI7mB6rGRPpyaMRUPYCcrViI2VMSTHJ6e4fMQi2cUKIjR0yl3lSRl0e3iIFCPLE/dBtsLz3c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6BeEayn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAY2mY016611
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hu12c6U1rd8Z27Ib4V1hOhlGmxZlRxn08YoMKrqBQYI=; b=E6BeEaynWXTi76uP
	C3ZLenxlwqiO95JQAXfcWyKzlScZPq+awm5ki0xpNJkWQ/H9sJHUPtlj0+AUY+Wa
	tQ8H0mBw9DbPaZfs7ItE2URoZK0Z+8ydKyq8pk91I1FX6oUgFJMJoKaCWyqBcysU
	O0zD7bJvGRPlbh1E/u5B76foCpuB2KGboJWF/gV7jw222sGE9q4p7Cqp/n9xmMcX
	ziacHrIkZyOoskr1BzdLYGVXIqvX7ywZyzwmdlj/0VT+B96zYwK6NOwIy+ygEoty
	6LB2Sw0bfnFYo/tlY7ykZ/5464SC6v2UkdzMnjclXnUfbhjAeJWJPUB00kUHbtBO
	Lg8l6w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhva5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:54:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befd39so19179670a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352842; x=1760957642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu12c6U1rd8Z27Ib4V1hOhlGmxZlRxn08YoMKrqBQYI=;
        b=cuLbxggHliPk6BLxDOhG9kGV5GeN7xDuNKy919iK85tx2kG8avKG+klQ7Bbfpl62kU
         VfvNb6v9Pzh1uTts07MUAXx9+gUIjKgkHYwwbcj7kTL7AGtOENtvKfqOBJVzSGOzQGFj
         jrGsbKW5ZQmrFcqKYYUIszFsy2tm8QfXO+IvtUjTWTTJY2D5Y19CS9yvE6+1ehThJ71k
         Z6+NjQwBgaUoEadPXDJB1gAtMRzHNOahoHWvjqk23gfz95hSMPsDrB00N7oxj3ME/wVQ
         Wr3uL/M8gQaOF/UaqIkBvtHD+zlYtWfCOg43U3YSu2vNtFGw2SxbxSuGWxcwpcsNU425
         i87A==
X-Forwarded-Encrypted: i=1; AJvYcCWFeJoU26RZe55rzNAgR11mMNrzk0WZw5r0ikwssWBbnXHYsmjorbJKI487fNfIv+tvM/QH9Nl+n4SSDtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjCU4QpjePDiDyVLqJYEysWWinyl3xjPb8JU+ziKqy7Ml+MbR
	Im1KN5gj6MAQs+M5tt9TdxvVtUUUoTyIDHnb8QepxlWPx9bvoxQiYQrg9daT83alaZp2XbyhzDT
	PjCVnMuoHq4kXV7YFU3OvF+fsNMFI3ggnBDOPVe9ZZ2xrI/7/JJJ+VxTUISgeC3t/JRU=
X-Gm-Gg: ASbGncvoD3bI2sWTKHI50IyM1ckzqrYY7xGpy7Cf9e6ROqgFZBXCYzrxNyDLMtywHBa
	3cwf0+NDPz83qhKsoSoFVh9SPRLFtDmwDVRakl7QtNvpIwNoWQ0ghUpGI989F5X+xllS0ZaRt3c
	ScOXQ0YphzudlE0RelvRS7AFjlbJy9DCgr9uJd58+JWJGp3qyZjRmncU5UaoWW0O7RTjlSgC32u
	kqZPRTZojzJt3R1sKdGy3+lbPyHUDzcJNgD8CJtHVrkO8CkshXADNe0P2tsKREyXyWhBJozxzN9
	upi/WNh4JQVivyakATgvzL/BGrDSLNFXmnn0LgjBMN59Lz59A+ZNkC5o+0J47myyyPWvnfxBsX8
	=
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33b51106a08mr28884079a91.8.1760352841728;
        Mon, 13 Oct 2025 03:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL67rs42FcPE7mXkIbR0fTv7qyOq2w1A0meKupktMXF+eQ28rjAxJADbVfTx018wSYf5I+FQ==
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33b51106a08mr28884036a91.8.1760352841264;
        Mon, 13 Oct 2025 03:54:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:29 +0530
Subject: [PATCH v5 2/5] arm64: dts: qcom: sm8550: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-2-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=4819;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y2oEgd+ZoMp2aZIZllFCtM7ZHgenc6dnMUZhPAHCRYc=;
 b=WXfYwVyiJVYYbOAPvvH+jgZiwIINmOHJrFhYWq18X8sh9yyNtTJf6l5wocZ+Mj9sbcb3xvIPv
 vzTV8kmZCATBS4eVgcdllk2rr50C8OsXR/k9jFBRhfid0PWBw1QhC/K
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwAsxqh1eLFTN
 XKMlWowYwtMs5c4gBYKCMC1FMZiL4HzRAGVhmR9Ir++xNpLf4rPqMkWmP0Vsmj5OYoIyLaOlYb1
 vhQBAH3D2ZrKkdFJd0QflN7A4zjpF4CkKRKrtqkpXpREsLzGjjzMNy7fYfJ/naicWFdr06qNVd7
 C5lmLN0ES0lbNm149ypmCF5u+eP8WXjFqDScJ2sV6781ncZ5YgPG+UMb+TxluKTVmtQgCz8hx2M
 pJ71/Ts1WWqCT00X2BgpC7CL8NtmvwZINtTS4OWzdn3OlsFbFxcsXMMXS4kAdusYKKmFzYB93or
 vvv888/+/Hj05dg8ZFs/evl5jiufdJlsbsn9RT1YjXK8f+FjIBRjKSgFZFEe6/sqjITfCe98tw+
 ZJPVVaRkKuOm6BcSCMwrMFirC8BAgw==
X-Proofpoint-ORIG-GUID: j0D2dDGNrLTcDOsg8kpuly3wjVQz-1g7
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ecda4b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: j0D2dDGNrLTcDOsg8kpuly3wjVQz-1g7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

The existing OPP table for PCIe is shared across different link
configurations such as data rates 8GT/s x2 and 16GT/s x1. These
configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different RPMh votes which cannot be represented accurately when
sharing a single OPP.

To address this, introduce an `opp-level` to indicate the PCIe data
rate and uniquely differentiate OPP entries even when the frequency
is the same.

Although this platform does not currently suffer from this issue, the
change is introduced to support unification across platforms.

Append the opp level to name of the opp node to indicate both frequency
and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 79 ++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7724dba75db79a9e66a2c61e1ea3607bacfdf5bb..9e726f848d3ac1aa6769c5c5e336f53ce7df9046 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2027,39 +2027,52 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie0_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 */
-				opp-16000000 {
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2194,46 +2207,68 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* 16 GT/s x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
+				/* 16 GT/s x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


