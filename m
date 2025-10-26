Return-Path: <linux-kernel+bounces-870300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2082C0A69F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2826B4E3A65
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85040272816;
	Sun, 26 Oct 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuFGb4wn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4C2701CE
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477514; cv=none; b=B2WEay6vFqlp+b1AECWw/iopAsgfecQ0gV8GjhLa2SyuTIPmCXjiNPYXYU1Y+Qhvv7utZfj5Rl9C8zSIKkQVS5vJb+1/OujZR+gHKQpC1lAa/TeJTo7UR8jThra1uFZC3rwERgSim52T1h6tJR925Vbmr/kTdgfTzU2PATV/AhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477514; c=relaxed/simple;
	bh=/5tkY59HXh8B8aDdyVmmItvuIc+g3lCV6AksjjSsun0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbpRtcSn0+hKRyqqn62zTQm5W1k+u2pIb29cHr/NFEjdy3g9uk+Vkzrj0FKurHHiqWK7e/0lkazv1qqAfBmPb5TSfOohUM4dW9maU53zRk9zr30SgyowbMEmzCcxRTNI5FhXLPT3banMHm9CBUNtGmGxO6gZz1YTw/axvk+k2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iuFGb4wn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q8SQ3L3572961
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=orf99F9rIUd
	Vj3nTu8FkMX0cNvOcZ2dsYnrafF4Soko=; b=iuFGb4wnZRTxfqpFu4ioIOxnmfC
	EJ9UgF3cuqo/M3qL2v/CrxQ3PlrUWRhVTtu2Zan4fUfVprPX6jpaOvQUnQQD4wuN
	Ru+MCNNGiIfYSE4Thjmb7aeQyK+5m/0yNbP8dkMTftbJoRhlFRu8+scXO9aObiKI
	ENlK2okkRbqg5rk8F9qFYZ+SN1W/+SFP7xUsJKDUV0jlEhs2J8YgRCP4sWhrhlII
	kyGuiCvlVRlr/mhnbNa/rD5FW88+Z6+faphAa+B1Bu8EtZlMCtyQtpWhgodiO67M
	37g2smx4NIud51ZPme/qafh0mHeYsd3xXgu1LzTi34VeN2S+IcIajo3GKNg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnxt0sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ed9e38bccso940013a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477511; x=1762082311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orf99F9rIUdVj3nTu8FkMX0cNvOcZ2dsYnrafF4Soko=;
        b=TnzYHg76ueE8+KZuTX0LinB05vB7g4mY9ofCKfg7IWTfw+hs8ZuslTWsbx2td1k89T
         CF4y1U3OOzcWtflm4Ws9IEVoZyvwQkWCZXQlXbMTKg7jntdM5h1S8nrIiWAR028iTpMm
         jtVtKESoP0IszBJBK295wKK+J7AF0DsYHAWH+S6CEQQ7XyEHLDeggNadS+IBNv8Rpu82
         PAwZtQCCQnb54sNBRT2ZJBNRVvotyt6Qstnr0PZuQhGMyTUzwppvv/l6BKU3KwQDjoaP
         tyEuRXOVxDJ+iNYP0eCkyY0cJHPc4HTQny9r3f+jdlTbSRvh5jtA3snQ4f69DbCWVwi/
         66cA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDX5T9Zd3ZE5lmlXTKDIhoJ4ZstNXnotoUfxlPMs16J4AbJGVaEaxWwQNQHYXVGlK6SNJ+YkxastOMbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSAnOL9LKvCVMZrBZuIBA9QEo3EpD2iEVNUt8OBQBn2243beo
	i3s6rccgkPTpam6nEPzG7j1eJ6cxwPy2SjSrFtsBmOht3EOziChupYsyqCfxVwXglVbbtol7bET
	lfpZjBjQKGbclR9Uw73i2zFyInl0jSEQoxSJqKXxlPspppFq94vscBIWrmo9aqrfDlA==
X-Gm-Gg: ASbGncsmTRrl9vdEbfJWlfQS7ho6R0SjB88EjsPs4r1RzwT2QZXHNUpvu3aRjoPiSXR
	rmzSRLd9dxMHizzKseipBXSpbHLFoaaUZl1qhLW11+9Ioq6oZU7bNl5Gt4OaIFi3nMmJ9GRzuwQ
	sAeMhJa5BSBzIJhq2Kub1SXQ1D076tuvwss+brNN/9fTeA2kgeE0Edm9uI1WT2pXBZRS1170MDT
	Tq5QRvZDMt7FEFDKZVNU61IpjzIymkBA3jDW7BRhFAmYpqmnDapCfXFrv96UE1tRE6C7VO0tvyz
	EDplIy985awkpVntVmLBnZY+MoyXAcGQ9TUEszuLUbwoswxs0f2GbKWjHyp1MM7ZWbBVSuRs4lB
	Iwja50gPdO/HN7fQOFLEQuja3rxN3iw==
X-Received: by 2002:a17:90b:1e07:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-33dfab84b06mr12871770a91.3.1761477511151;
        Sun, 26 Oct 2025 04:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0zlO8ZyzF/mK+UtlqGE2zq64/vgrPf3aWsH3pYbKg+KXxudz8b5pvQbKCX53QRCjaE86Ukg==
X-Received: by 2002:a17:90b:1e07:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-33dfab84b06mr12871745a91.3.1761477510670;
        Sun, 26 Oct 2025 04:18:30 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:30 -0700 (PDT)
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
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH V3 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board
Date: Sun, 26 Oct 2025 16:47:46 +0530
Message-Id: <20251026111746.3195861-5-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xc+EDY55 c=1 sm=1 tr=0 ts=68fe0388 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Fl7qsps3WXD_dGGssnYA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EG7eXIF6rXP1zI-O2Hw5V_I5-J5-fviD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfX2b5uyhs3HwSZ
 qzIYlHLo3n6TldYTtw2aQVWbJXgmTJbQHMJrVTVRzY8lRNZZWI9zFK0tY8lOCL96bR1pjz7aED3
 S60Ziq+8ijOLtUxkRAJE71CGtqjueoCozOHO4J2ooMWDndZbC5xuirgdHNSqsaEWyIo+02e66oc
 HORoo+AS1cvHMKWLpqSktaVO8gTcECSIFjoy/RoE2kvWQvrLPDtfWOaiQMF+bVH7Z6ekVCMhVaj
 Axc9SZoortQlxVw8VT9B3s4wleP5gsNQh3G6yXhpEWf6ubWHN0nvhPbcgusb7sAjI9BKr5MamRV
 FvQMKlEV6FBunhXxWQjDFSk0Fgg9dwriIxMM0z2wscLM/wkCvdT/nW25QKGV8DpiJ9C3ORDnnXW
 scBYpbNfozruebfq2OuxD71pOjQfJg==
X-Proofpoint-ORIG-GUID: EG7eXIF6rXP1zI-O2Hw5V_I5-J5-fviD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

Enable SD Card host controller for sm8750 qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..c2ab39744a0c 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -1031,6 +1031,29 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
 };
 
 &uart7 {
-- 
2.34.1


