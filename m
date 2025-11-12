Return-Path: <linux-kernel+bounces-896654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3CC50E66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08473BB1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB229BDB6;
	Wed, 12 Nov 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P32Hgkbv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+3sBROF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C642C026D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931585; cv=none; b=V8MGqKnGgwiMHKKfkfvwSJh5WmFrwfD7VA4hg2DwpCayP8Rj0npCiuyzue+TBnCum8bPGVXo3Qyg0aVI895Oz+EXYTe2riQ/rkQpwdrJRHZL/xkC6/YrHEhEONttcnivI4NtqZwGKMMSrH1S/uoq6ZDj0FqmWyaeJ+KEe/nec6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931585; c=relaxed/simple;
	bh=4aYdDZnJbmsoU2HiJYC8F1DbRX207Eq/Kr3uzGSvN8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2cAClFKcQY8LiwOak10cSav7WZ33YfscbZS9e2PkGI2jbNdRS0mTHaME/tqEcSW6HoyZZOeWGwCyoNfiVTEdWP0nl7EAIAARWnjHiQBl8UNwTP3v4naeaTHlLqNmAe1V7Fy9UEIBwsLaKTEFuIhld3raJm05GQBFo+owlwG2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P32Hgkbv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+3sBROF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3o5or3060214
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eOYDtZaBwRZ
	Q9DetBBK0MKWCVmuGLVfh18056m/6hxU=; b=P32HgkbvBcc/LAkX/pDh0qx01Od
	918muVsKq5W1VqdOn9w4BvIRPSjuP32V5yNULs0+1Dk2By5WcMMnPGz3CevIGm5e
	YW8Wh7J4rOsVG/wZ9DFZIxVevRCeOuISODXNp1wKHvrKdqD1mESrgc09KD1Vg++g
	JU9/rxVoGwuc8+1Rp9w5NUA3pgre7M2CWYZfcXCz4Zp223Jtmn192qCYogRuoW6p
	dlOTxi274SPmKG86V7SRLxWf1IwVUK0ksiYTRf0vzz3lwDlN6M9WWuqdtxXflmZc
	HKtwlZqKvia+ClQXl1DgmVy55/LuoOrQAHRNmF7Xc5/fB5z0u9lvt0QjXfw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988j1rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:13:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aed9ebcd67so164996b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931581; x=1763536381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOYDtZaBwRZQ9DetBBK0MKWCVmuGLVfh18056m/6hxU=;
        b=C+3sBROF8Z116Zmc1d/U+/FsGErWkFdbFvU0Hx9pCkoXQ44iORsL1kTo9u4prH2Nqx
         vddjqYZSC8lm6ZjJDfGyYtiJ+ror57wuvWybaITPooaQsq0XYnRh0TJzPvq/er1JFBcs
         sm+GNjbUjt05yk/aVfZvuDOz1AEAFv6TV8QosmPOOtQXUSQp17eNAbLnqTl+OBK0hWai
         qBEO8oVtG6LibHdNsMXJ60szTt28L5QdyFOlD5uJx7+rB3B7RAwLB2QdetMNhreqs7TD
         8QHn2eFYNvuRcV0QTCUD6mDo4F1BdZvBA1XPfCLW7JiLgs7S7YM+cUTviO6nB/339l4K
         zt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931581; x=1763536381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOYDtZaBwRZQ9DetBBK0MKWCVmuGLVfh18056m/6hxU=;
        b=Ts7OJMmPO1w6S/G4Cggvk/7EPOEvdWb67PmmGRZng1ePA3LEtWqlmp4vBjnjfov/Sx
         1nKIm0A7GSGoxmwwKgvWIt4H2RmuaGXsFyCXYr6NeFsjJAoNnQFkKrdOxclA9NqjG1q7
         g9+p1wGUABRhA6L48gGqElssWZD+EQ244pducsq2rEFZ9uzb72fFdSnMb/b4APMIZgtH
         2DvgDo1kLcyD1y2Jd1UkIVSjXQ7Cjz3rvCLgFZcTC7/jHlM9hmcbxcMX1+ehBg7hVIc8
         aErRvAe+j+lr5HeUpf5QVIJTj3rJG1cOl1VoP7hU8u6hdXv0aQDJL3NNR4C7qR4xiFiR
         RLdw==
X-Forwarded-Encrypted: i=1; AJvYcCWhEyvpiGfDgruHAYYxiNd5cICzdpYACDIJi2j4+jj4jfvYTtDzpOIgJtlbt1WXzRtEIUaOeVhELPdotV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7py7IT/7C0HzqyU4aADvdzKWzLEhvvVZiEUJo0AtX6dGsf28U
	28bpkulfiGKWqnotsTPCDrzX5uyKbB73KX7TgGi81rytWGwEzmYIQjQJoy3+F4Ltpw8Fq3RfkHr
	gSAcfK+7IIkOYZyY0kHmVnclUAxhr3DVAaAeG5e8Z7SbhfHnn7B/MXPicSOgAGZrd7Q==
X-Gm-Gg: ASbGncu8DCQ9FiXpeviYV1XnnT7kHUjOoTqX82GbXlygzI8jcjnBvTG/pRHBo8dxWDL
	nPD+5YgEPVKlbNpsSYFXB9aJpZXTJaqDu1ow0tVhsZJK61tGGWkaLOQN8DXXgn2+G83kkQ26/QD
	gws64+MUc9UGo1ya9EAJLmZSik9g2onILQhURXfusBK8Vjc45BOML21oQwIMj4zsP0hG6/6RWx6
	MxTgcdimRKWXQ38mJY1Y0t1D68+4Ba0uGbvfFFTp1lfN3/Fgss0wn2fQx/56a96bvsy+Kr9WYDk
	lbqy61/tkLSpCX6q/A9PlFg9zORBHjizkQCTGSyyqWO9NDPe4ujthqZ0Vej9Gj5TEkiuEE4tsQH
	KIUDcbGUQpOoTQX/A5kJftdZG32YD+Q==
X-Received: by 2002:aa7:888e:0:b0:7ab:8c7b:b6ec with SMTP id d2e1a72fcca58-7b7a4fd90f3mr1068465b3a.5.1762931581125;
        Tue, 11 Nov 2025 23:13:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGm1EfQnyHmeFSWOow73JVFByzZLix55It94bORz/gjlPFJ1ZrPYyFozMf2jGzU59fA9HgQw==
X-Received: by 2002:aa7:888e:0:b0:7ab:8c7b:b6ec with SMTP id d2e1a72fcca58-7b7a4fd90f3mr1068449b3a.5.1762931580634;
        Tue, 11 Nov 2025 23:13:00 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm17949037b3a.8.2025.11.11.23.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:13:00 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH V5 3/3] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board
Date: Wed, 12 Nov 2025 12:42:34 +0530
Message-Id: <20251112071234.2570251-4-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
References: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GUYIjTIw31hUsJzGGr5AHN2f7UyGDydY
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=6914337e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=CuSXmbl0-BlP8Dydlo4A:9
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfX987I0oRJaKLo
 CMq8Gl7Uw8HE+YqaeXcTXj9O9dionJ1m8ejQSu78LINRRtVHIFPk4HmA3wBpip/V8LGkcxW1tj/
 Dp0xM2T7isK4igJ8KQ53a3oMIzNGoQyInf1aynT6rhmVA3LAhlYrOGrhtqA9YtC8zL7s1yA6n+u
 BpAy9q65IAEe5YUlFlo54H9weFyqi3sHLgM3sujQW4AucS025z+YJCKRxfEju7cgqpzOtXiKm9H
 S2ZrunSOeni3EP5ptvQ1kFNdpUlpk0v4h5bDuIrZO1WdtOOnRKlovudFHSgf7Ah0DwnczmTICbb
 n6jZm3TI13Yy48urDs4vjqjnwFBZev/JdFpTHPTxxFSW09JpIEZyS+W7pbU61iNCBvW5ZsCfzng
 Sy9ToOE0liUbDmqnheMTNmaIzuOTkQ==
X-Proofpoint-ORIG-GUID: GUYIjTIw31hUsJzGGr5AHN2f7UyGDydY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120056

Enable SD Card host controller for sm8750 qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index b0cb61c5a603..439ffb202599 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -961,6 +961,22 @@ &remoteproc_mpss {
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
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
@@ -1053,6 +1069,13 @@ &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;
 
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	spkr_0_sd_n_active: spkr-0-sd-n-active-state {
 		pins = "gpio76";
 		function = "gpio";
-- 
2.34.1


