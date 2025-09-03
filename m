Return-Path: <linux-kernel+bounces-798927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1707B424C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AF31883535
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951A33CEB9;
	Wed,  3 Sep 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjA8V13Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAE33CEB7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912473; cv=none; b=Ip0EGbA57YXpzYJV8rOrwtbfTtwj6dx8eYa42WVBJi09EzsNL12Qr2J8KbtvtOCxfH1LWci5qsvYfc/f4dKZxNl5zk7luHJ2LD9cgSKxzJv8p3pnLmtnfH8UwfhXR783U08YBy4iOxjx0feVi2rtRkov+tYnS25Tl8K61PfzqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912473; c=relaxed/simple;
	bh=iX/8nH2+phql33OmK8rxQAwyd1PZKL40bJzOK2j7R8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsonL+kdrxzxwAI3ySoTQ/uYdLPlzxyFIUs7/RnugDZsy4VYZKO4NR/FbDba4UBCxk6X1P5wlc7NC3j9Cb7DGHiZSkF6lEnfi26qe6j6DZ9nypqB5dfKxDq4G3PvyUU7wQUssRtYo+UhiIDDoZaOw3iXpwcIodF/kk+EiGLqI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjA8V13Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqvo021567
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YA0iWazYOEd
	Fsu+gH/YyEO2WmFSs2I4hQo9Rzdo3sIk=; b=IjA8V13QKtWQDf5GI0VrLQxGNqa
	bKV40VNP2uhi8vRC3/PyoBcqY87SCrReBJcdKKX0CioB7DvMt0FKpPyXglgars6A
	Vf787uo/hYlJcid3tN11IZq/QdOcXfWIQv4kqKP51+CK12zlqsDeknfOZAIMET40
	0sXrruYu2fb7P9PxXg2gHKwxZcbtU/TNVqvgrgtiRMe9QBvHN7Nr++M2tJDEXsZU
	HC+MV7oRxyphLniotxmU/jcaduZyPL7bH6lDBfn2H+bpXPSFwbxtMQD+yjUNdaKb
	vKk8G4Ef7xF/mDZCyXzQRWTAKv9JuQHO0GHGENKQIfMF7NeVwTRJrnKs0AA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0emab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c9304b7bcso379145ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912470; x=1757517270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA0iWazYOEdFsu+gH/YyEO2WmFSs2I4hQo9Rzdo3sIk=;
        b=LjvRGVga9iIw/Wuj3GGXLWHVv4gNLlvGXuUIlh4+koxjnSSe0dRyReJD2I/XPabO4r
         XHhC+4vOY+hqV7F93Gk0MYCk3XL0g0n0Bl24/iQNd6KO0x/h6C1duoDeQtkoi0DvMToh
         9Sp3sqqxOLODOijE1H4bf74zMteCfpbYvlAvTaS1E4Te6nDuXu1fz0kDJz3S1EirLWkr
         T66tnKjR9XJaDT1dp+TZdYS0aZQOYtp/al3nDVSn61wa4tQY4SPi3Qk3HSqnEXx2rlbD
         RECPgdvQdOmLDeT8wQLphTwS9T76TN42SRXvEePSnq9XyyXsWcr5jtuoFrOsuBoxfILe
         ttKw==
X-Forwarded-Encrypted: i=1; AJvYcCULuo7ufHl2HDKWFbLbgxFmigzKX81ICrVzFtl9bFsw9dHhWmGqyufyJw0/PMFmFl1dmnzRp7Owo4Oern8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+2i/Te7feuWwwVleci1bAy3xt3eQbDVklNAdX77m/VreIMKK
	B2pz086i66rLzHs9x501iC4cyoc2ldXAYOlI1Vk48QC5lDYAploBWl/UczKqleeUpZ7v7UB0lxP
	mT/Ou1z15UJxoAVaumm38ZD7EAml8NQMR4gGHe/ldXroX4eos90eTAiHYK8R24jpQuA4=
X-Gm-Gg: ASbGncs/+hODXubJZ4Km1gUt5RW8IhT9k0owRHv9WV6Uu3NrfR6QYGu5Obg/g6Nz/a7
	mhjOhHWVA+hX+nKcoAyLGml6P/oI7sl0euiThRtd7QTjbljuGWNgRMROZJT1dvobnQtHU/N20LL
	TY5r025S1W+Ks0V42A/E2SyEz5T+WjvS92CFiaLmI5/pYYRSph2DxDRM4lyFxjswAuAx+6a2O3+
	qq/kfIfWQ+5ifJlbEKrn0FfaD5Y9idyKARhNhQ08F1oiDrk1AubLwr7mIWFqeHffkpMgBC5teDe
	C07AOjliDmAozHzRW0Qqz8dbnqnLmmtdC3mwWDnCjR+s7xeQrqbEGpu8N8EpICKZjQrl2bLXmtc
	0
X-Received: by 2002:a17:903:4b46:b0:240:48f4:40f7 with SMTP id d9443c01a7336-24944b29c03mr224481095ad.39.1756912470201;
        Wed, 03 Sep 2025 08:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgae0ZL8A9n72ma4VtWgGtsaJLgxhws/tThvtuBdoJhXaqJXZb3luw+0f7PjFMgQeOhhQvHg==
X-Received: by 2002:a17:903:4b46:b0:240:48f4:40f7 with SMTP id d9443c01a7336-24944b29c03mr224480785ad.39.1756912469761;
        Wed, 03 Sep 2025 08:14:29 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:29 -0700 (PDT)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 8/8] arm64: dts: qcom: qcm6490-idp: Add sound card
Date: Wed,  3 Sep 2025 20:43:37 +0530
Message-Id: <20250903151337.1037246-9-mohammad.rafi.shaik@oss.qualcomm.com>
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
X-Proofpoint-GUID: _91YLM0YcQTDZSvkBtI1WnX2iosoMiuf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX36fne4YzQMN6
 JVng4T0PgANu0faz7ewdmZC7i0qvOTr/TkAPuW0BjrJfiSbh5B9WgVRGTX1cx8plybCrQqv4PKt
 7EbDsaLClIOZd6/9aAFPggCoUcDO1UI5isrHt51+oQwGin0hoQTT7vc7QlegEflQJeOfpz5QEt/
 mN+81inagGZWJmr6ttcB4U99OJvUmYC+c8OKrxuQuMgR2bUJy0nTk3PKwhQwTXvo5Op8+AZ6Ff2
 mWraKc/b7BLxDVZnd1Razc49NosVSLLXeUWZ59uxn0X3ovnXHgOn/ix7T33IujzOQwkZCVDVL17
 J/PxOhyxK31fmkXRhsOp5HTaSgLZXQdlhgc897WsDxy9y369dX3STmpWpDGZ7goUdAuty+GmZpY
 x4psUtBK
X-Proofpoint-ORIG-GUID: _91YLM0YcQTDZSvkBtI1WnX2iosoMiuf
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b85b57 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=h_l79siUWkRGThfnGhIA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Add the sound card node with tested playback over WSA8835 speakers,
digital on-board mics along with wcd9370 headset playabck and record.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 379ee346a33a..73fce639370c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -757,6 +757,90 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
 };
 
+&sound {
+	compatible = "qcom,qcm6490-idp-sndcard";
+	model = "QCM6490-IDP";
+
+	audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+			"SpkrRight IN", "WSA_SPK2 OUT",
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC2", "MIC BIAS2",
+			"TX DMIC0", "MIC BIAS1",
+			"TX DMIC1", "MIC BIAS2",
+			"TX DMIC2", "MIC BIAS3",
+			"TX SWR_ADC1", "ADC2_OUTPUT",
+			"VA DMIC0", "VA MIC BIAS3",
+			"VA DMIC1", "VA MIC BIAS3",
+			"VA DMIC2", "VA MIC BIAS1",
+			"VA DMIC3", "VA MIC BIAS1";
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
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+
+		codec {
+			sound-dai = <&wcd9370 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wcd-capture-dai-link {
+		link-name = "WCD Capture";
+
+		codec {
+			sound-dai = <&wcd9370 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
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
 &swr0 {
 	status = "okay";
 
-- 
2.34.1


