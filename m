Return-Path: <linux-kernel+bounces-798925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66799B424C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C253683768
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C24334399;
	Wed,  3 Sep 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2q96UPF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D231A06A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912465; cv=none; b=XJ+Uh0GrPb5V/YS03RRjUmrjzRS6XgXri6x6+NmYUXipslf1tOLcbWwln8qlmiVEAFH/PX860i3Lfxz7ErJHO21dDTpDn+wxU9JH/WZ8DCY3ItJP/OJvKwSTR5SoOsmT86yM3NuX/woOdlw/+SJFdfIEuyvoRl/RDvmEH9fmAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912465; c=relaxed/simple;
	bh=RabZyP1MYauqdvXLphTShP4sWVBSim1FNftYv5x7w4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yd7cokBnbk8LErR56wA6n1qw42zbA//P04q/T03eB/5noDsYB+rqqAjvTp2G79yWCV4vxacWcz/RdkseJnBUi12q6yoaUtHv8GsNClmoaeoTl1GL+Wl26ee2lxvjHXOgRoH7hvb4XA4daQxkRRrLu2tylkNZ0sM0V9icwX+mcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2q96UPF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqis005254
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zrzVp/Rhi+s
	JKmcSPdWp/qY7dG+tv5mT9DlcBZ2BsY4=; b=P2q96UPFiKiiFh0Rj/IGpgoXzUg
	r4wRG6YFZu2J40tsdgbpx1Geda0qi4s0VsRk48TOCas1TKzHAth4tuwxc7gOkwZV
	bwlpK2MTuFAWsKtJGQNZoYtkFKJXWrJgJxrLxfwKd96lqt2tzqhsUM1/eeEJTcrU
	vYHvo9FgR0aRF/YxpZvl71dce5SoEFSpFDyXhXR6V3UItZJX7ZSlo5NDYeNdLkiD
	T2vyO6cpN6ZyLrnSzfCVe3itKWlpSU32ny+hoVNsB5tlA+ilxzfO1NiKiO039Bby
	HN4B3/aR88JV+SwV2nnhFPIajAWB4mBDnGfbVYk6n1jb4S0c7Rw9EuY78Mg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjm3ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c99bd543aso469385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912461; x=1757517261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrzVp/Rhi+sJKmcSPdWp/qY7dG+tv5mT9DlcBZ2BsY4=;
        b=ea1nMqhtm2h8CyPHCw5hkaFFtB9q070FPzpUOJFCgvBMOtWPy4vYRjJt97Tx/jllz3
         wEAjt+f4j6G/ctexmfqYadWQmBbbZQ7Iy0f+tVoLhXBFhHetOujI13VPpNgzj/tswNDN
         ci3Rwxv/K/GgiLdD7x35GQd/9ejh4ecLnChU0MoIN7ikBKkXN+E2fckfEfj/GgUTb+w5
         7x0OhbJlDXVuHXMjZ8RstcnlAEqcR8uavGchRnG4p5gnRUwjESPhnxF8zggPzMOaLCSz
         +HoWy/0SWnDncRG4trpK4oir4JdNAHAeNHeHsvWuAZ+XuE6HF2w9noTSdqcBkhhoAh+1
         oTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6fKFWTx4ZdfRAnS0kP/RH3Jf/w5quIByJSBGmWZgKzsH1zqWSW8/G7iYaqlAOVauKUF+bc1HsqkWVsZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHCiWbnpdUT62VQVzhT7cGY/98UBt3dggiEZVT8Roi8CADSyM
	htVWGZLJJyF/vT++wFgnZ2j9TgsvZhwqur9EOaq2l8OamzHFQGjmjwqyOV41mJtyGLx1s7xXvRf
	l92UHauxaHZd7OcplLSiYQO26jMSZ3zO8oOi65aBKr6VibIjczzrFozKpZyvXmcB85BM=
X-Gm-Gg: ASbGncvum7mHZ4xSTS5j46jDJT4Zd/xS0iRpasdHL67iab5zXh4gs/qAlDdWp7dGo87
	DXP/GT6cFOdpMgUoeJbreRN/qpOOk6TZTRdKjiOALlm3pdnFhVaQfBJB3jvOYSL23Iz+vYD27Yg
	tSfc5JAiigzeR/yWSOkmdJtqcjfA//Gt/P6aV5qcIwHdIIVfH7hrCEJG36Z92aIpH8aW7pDh7Qs
	oVQ4YmsV6M6gO66VTEk96pnJx/w04qTCMcqmchENw2kX/YORVVydR8X9Ki0TOqHo2DXnNVmNZjC
	R5ZP+0gRx2xjpdzk29XuOBSEUwXV7Ar+Ah1DCz4smkYjqdgrWNuRx/426RqhlMHZgC9qvPJfq8M
	A
X-Received: by 2002:a17:902:e783:b0:242:bba6:fc85 with SMTP id d9443c01a7336-24944b75a04mr220940685ad.56.1756912461170;
        Wed, 03 Sep 2025 08:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7blGezTwsbFKyXJPmJrF/cNsvF5Q4e8jj/x6gSiHAPOyOXA2iCqhiw4fdWaghrOg61aMaTg==
X-Received: by 2002:a17:902:e783:b0:242:bba6:fc85 with SMTP id d9443c01a7336-24944b75a04mr220940305ad.56.1756912460699;
        Wed, 03 Sep 2025 08:14:20 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:20 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v9 6/8] arm64: dts: qcom: qcs6490-rb3gen2: Add sound card
Date: Wed,  3 Sep 2025 20:43:35 +0530
Message-Id: <20250903151337.1037246-7-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b85b4e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5gXoNHtsKICXUCjegB0A:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4qc2gp27OOqtfEQmqkvtdbPgRvZT0cXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX2nTk4NH73msr
 tRV7BvTOxOIrscig5gnkJzFrY3tbQafI4wrM+BZdzntxQkU8UQDAIemM9Nk3D4lzX2sNjGTVvbc
 cBxeyA80HLNn08ATV3GafL3ze4CpZuVQHejgXQDPFbXVrqtX2scsjVcHOIQzTPScKoaKXJQxFfn
 cO1kuXfD7lIA3PhTKsAe/qA7NsB1tF8nq3S6EBp7EYOPd4s7Z2K3xY2ppGx1TvDLXlZHH1EBqn9
 +xncz3Pd9pz77K98mwxf48pstCgxlNOJGGp6srutgFJa2r5R5sboni/xCpDS8IVeBXNRALZ+pkW
 6REYnwKLsnu5MrrhMcrXEmhBIyQ6lMPA9Wxv2nA2jLUWyfHLyGxmOXy2J9GORo8bJkJLy0IL9SD
 rddi4VfQ
X-Proofpoint-ORIG-GUID: 4qc2gp27OOqtfEQmqkvtdbPgRvZT0cXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Add the sound card node with tested playback over WSA8835 speakers
and digital on-board mics.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 09e2cb9053a6..18cea8812001 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1048,6 +1048,51 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sound {
+	compatible = "qcom,qcs6490-rb3gen2-sndcard";
+	model = "QCS6490-RB3Gen2";
+
+	audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+			"SpkrRight IN", "WSA_SPK2 OUT",
+			"VA DMIC0", "vdd-micb",
+			"VA DMIC1", "vdd-micb",
+			"VA DMIC2", "vdd-micb",
+			"VA DMIC3", "vdd-micb";
+
+	wsa-dai-link {
+		link-name = "WSA Playback";
+
+		codec {
+			sound-dai = <&left_spkr>, <&right_spkr>,
+				    <&swr2 0>, <&lpass_wsa_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+
+		codec {
+			sound-dai = <&lpass_va_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+};
+
 &swr2 {
 	status = "okay";
 
-- 
2.34.1


