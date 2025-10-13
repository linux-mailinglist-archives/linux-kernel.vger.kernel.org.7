Return-Path: <linux-kernel+bounces-850375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D7BD2A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B34B3A56FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E330597E;
	Mon, 13 Oct 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lnq47aeg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F33043CC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352842; cv=none; b=MoB+ptdVIHQYFMOdIgO6GqLZ68Wt0/1yU4T98q5KygBu8Ns3hlpArxiEHS4ZzPaalMqtZj5RhlCOIFH6t7SfHVCAo+i85uN4tzcWnlYJTpbgqf0PDkuauPrUIZ0obJFOsvMpgCaH8NqK5a8ns8rbIUCSbIa8FfioVV+3q68KxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352842; c=relaxed/simple;
	bh=DMfL92AdXlzenYd0/1DcFtxFL7fShJdaftub5B4NfLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf8YX4e3vwZDHdHUJZ+ZFnWevR5eDr2MOyICbl3E0w5p8fjQeEO3BNrglG4qXUvrOCDy/RhBknV4yoqb3PCR4c/BID3dF4HzW5cOs+D0glxHIXFA9Yqu8zoDVKuOrwmSBCZSgnDPg4lHGnGGA+DuAj2WUPejpZdCsfeV3OarE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lnq47aeg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAYqWQ000534
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u08lX6E4lF1MxSnTgYczMeE3BdQjrxXWCXSB/fw3rAw=; b=Lnq47aegwaYYDEHt
	eySFkWY8N+U6pkF3ky0z3Kv4UaVoCuLIIIfnGKgFctHJk6CW45eRtAnGjrm3bLyS
	n3jW1AVE/W+gvnYAczZsExW+cWrlE9qjFHep/WO1seHJ1FzPK6XRqsyv4TocMF1f
	EtSGcuPimDgSHm4jgJbwUaRFupz+M8tg2zMggxac1uUOo0Eknt19GMh1ZFfc23Y+
	6rH/NOsb3/PqRpNmNyGqS0pSNtpqad/JUlpHRsM1jyMY/UkueSsbAEtgKy3HJ1z2
	OG7U5jAFokEAOxGVR1yzhgJ3qMnqfNTQbYlwlztF4purLMBikbCWAZAnbgQjAbWz
	BfxsZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8vafk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:53:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2699ed6d43dso81313335ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352836; x=1760957636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u08lX6E4lF1MxSnTgYczMeE3BdQjrxXWCXSB/fw3rAw=;
        b=T/oCDFETOKKeN1UeZ9F7oZOgyC2q1KtbF75UAte99qlWC8ooPfbxCKZuBsUDgmuUlm
         DWAHj5uu9d3ezEr2LOcaSRPLgCSTigip0L4qFTlxgQmm4Q9VBBem2bhugn1ZFwdj297i
         KuEs87eSMFyDh+561VpyS7xYwnNl4Ow876XUYSPMFP17e57bG9+D5a/Nvgrbc0oAgGeL
         UY4gc2BMksRAvbpthEo6N5AvbUImtAIr8AGcCo2ZxbTNrX3kKZydAlP22iOFGS+WhyFj
         TcWmsG+qtWkiUuO5VJXM0iSmk+wVxCD+3SONDEhUm+BzXCoJ3K/DPhVfSwUQWhtvIgeV
         mmRA==
X-Forwarded-Encrypted: i=1; AJvYcCVgROS6RAfWkrG+KipJz1xtpzInQRie7ZjplxTqGe0xSuF0jYu9yMUhCFtoqsDqtjbkpwPJFH/3iwpTg54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25BXjgkKrHo0mFb9HVxG/sYynYd6v9BEh3yzXXeVgARejLc8Y
	xpjS6+h465GZucJuXCEUSnE/sT41cVEBthWWQNDYU3x1HJgC4NYXeZZLSwpISV0PULkn+hZD1Vy
	/tDpwwRgiI+XeP3Leezm+TWLMeg4hf0SuD4mpSq7NsvkmX7pngATQLdFMHZYQ3H+K9CE2LZUzlp
	M=
X-Gm-Gg: ASbGnctbQrBwbz+u+uzhH1Tv1Oci5ZlPor0tcguo/xskDMGVgTygkmz6uNwnykB6RRF
	R7YKvnTI5tBsm2HgxeSzBjBIYXTEa52YD6rLyhLtv1gQ0eqLubK8rmXBcez8yG/g9m18sKYCdP2
	+UGAsfyMgRWDAKtYGWL3x5mmp4us89DzF0t7wvCEYA77ufp647UnqjdDMC2rhTRasg+CE82npg6
	D4wGB/WUz4as3rizaZ+vV2+xYSUMGbL5sJHiOPl6V0Tvv79TlJ8wSB2qpReHtFJEEunCD83hcAV
	wMw7AwRUY+98eGaB8isxZAdKaBXtjnAEOQZykzSkMqrC8Ky7WlqMWbE/00lUxc8fpQugyGTq8u8
	=
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr268570595ad.48.1760352836323;
        Mon, 13 Oct 2025 03:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4gao4pvLHEPOQz//QIqS/9Zz9d9DOggsWC7wOSF/QEy30BK1Aeknp4p0FhJCVT0WVN54eJQ==
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr268570175ad.48.1760352835823;
        Mon, 13 Oct 2025 03:53:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:53:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:28 +0530
Subject: [PATCH v5 1/5] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-1-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=4058;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=DMfL92AdXlzenYd0/1DcFtxFL7fShJdaftub5B4NfLA=;
 b=31xcT0QdpgR7G2WSAuRQQywywT1N0r3T7iCT13jrZ565TkRMr/wHsbX0Yy5s26RjTQdCMMMbE
 deYLgUXgn3bBSAAHsg/USnh5L4PFJPRiixnZCAR2KC8LOeDhv732Fpw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: KQwLg_ecjr0NctEXLxNTS9jmbG6YWBHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX+xIWaHzzvA2V
 NzkkC4chieGl5bKKiKF1/PlAhIWzmsBnzDW9PIN2n3ILIsVleHUHiV5k2HBVO8Nuyo55cB8JCW5
 ssZZGq1b+FHOnVHnDD44H0Vx3R2+d3fDHFHJMZ6N0/uCvAOqTCsB5eWg9rWz+ChA7d9Ii7RaM1X
 QxJ3yKmnL3x2LtKBoMRd3q23Mk3R7QjxUTtsSPaocAbqfZ+uLbaCPmHWIAETPdJrqMUBs5gT7er
 XKmRsYO5d+dwRo18gBvXxnVfA24C6FKjZ2mooDHXeq93uo0/+tbJXEftpg6SrDS3e1vj1MNNp1w
 FOf2yMsiVe7S2dl8RHv0isS9nPGr9vgoNHMq/KlqUfbUju1Vy5IAyTDAMan5fKuSaff9NOlesBw
 t1j/S9Ghh6tTihXNqiXkoSlcIt0DGg==
X-Proofpoint-GUID: KQwLg_ecjr0NctEXLxNTS9jmbG6YWBHg
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ecda45 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 55 ++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 23420e6924728cb80fc9e44fb4d7e01fbffae21f..2ae56c39f2e6d8a11a2ef0f77bffcf05a6fd637e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2047,25 +2047,28 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie0_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
+				/* 2.5 GT/s x1 */
 				opp-2500000 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x1 */
+				/* 5 GT/s x1 */
 				opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
+				/* 8 GT/s x1 */
 				opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2209,46 +2212,68 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
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
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
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


