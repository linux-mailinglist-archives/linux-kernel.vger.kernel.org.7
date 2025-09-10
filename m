Return-Path: <linux-kernel+bounces-809384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E044B50CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EF9465308
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C15464E;
	Wed, 10 Sep 2025 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h7P9mXOa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF061239E63
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479537; cv=none; b=VKEMvfMWdmZyceLs4zwS7w7GFe4Ror0CelNhE2/DXsxa1pPU0NHpRJyGaTls2XvGjEiGeyitk5zliAGRXHPh129HwwsvvDpxH8PU12bS+3yrozDI0b2gs29x7HkhjbD9GgF6jHbx0hrsj83vGN0E9S0WlWCj9S4wE4mK2aCeg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479537; c=relaxed/simple;
	bh=ZuJD7JdUTwyqcePUK3u6tcyt+3y92CC37Zydf2zrHaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ReUkOl4eE3Vq45JgR36Dj+yoQplLFZRW9MKAbZb/Iol1w8CMphWwe5z6/PW+wh5AEiEB0pSfXIbA4CtB2x2tiEvaVmj98+6HMDdV/j5L3fBVb1NkdsJ6txF7BnXroTEQhGm8pF5gxYUCw2Fn64hlDVSYqQwM3xO1iY8c7ROCukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h7P9mXOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HUPmw029178
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=phs99IEbTxzLUUK84wJmfAYFpG6+OD7+fCp
	Ut6KGbd0=; b=h7P9mXOaj6tCI5bROrO0QSMsrHEUWXTfg8BRs9Lps21vq92tnBu
	gcJC5uW2k18AWQzyP8XHyn9FDzLHvMhP9GQgJJ8hfPo9a4E+UmHoBnE4OPPpYCoN
	PwGiv2hcgKOPOHb+rFXMh+yKhUP54y2RDe2WTO6Ano1eHdKMTFLGQLhnkL4Y4cDc
	O266Z9cqMzs87T04up5xxD/VfQgqtxzwtGvI6t7OiQhGrv0OLS4z6mhmPaznQdJ3
	dnBKUNMMUZ16b1O22wejkLfsmKFNjmBRjD1kXeRS3mVHNVUdjMZROuCfD8rnqVU1
	TJvgI+OeiNYLE7WO2GbOw341wrj1F0O8Bug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8jmmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:45:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f86568434so5265579a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 21:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757479533; x=1758084333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phs99IEbTxzLUUK84wJmfAYFpG6+OD7+fCpUt6KGbd0=;
        b=n4U78sg/mY0IsUEfW7liL8uV8UGkgR0aEIkoCTOjSeI+yp5+WLd+HNEiX4YQ6RN75s
         7e5tCtpGZ9XaKutqlVmSMDRWFHJgE8+Zgid13sFK9mVkoYrfSQIrccVLDu8evPInf9zK
         EWQFrz/QhYZUQ2l/Ks8m+ki92vibiSzwikyA3/yOni3aEujKv5js1HYlHQSdCVAO/+dF
         /yfsHqUIgzXEQaIQ5TFNkJFAaTNRt4TV/IjTrnQgVJsa5YhOje2ZsnO3lnn3D/3QAjlV
         qpXRaoPRJmRBJbvmkr3W30GTS6MKS/RjXkt+xwYTB/DoHmcY14ph12f0vT8nj30F9IV0
         IMCA==
X-Forwarded-Encrypted: i=1; AJvYcCXUl5/3IX7u2szocFes8STIweVyZc4hJ98OmsD8bTk/gqL/Xjmb6EoQgzC4XKMvy3o9uec6+ItMKHVoyoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaLFrbrvL8BS9YIT4rC8BgdyIkHkQ7ngQVKOyKlMVt35fZshP
	wgVPBsxv7ncTgF/RKKZrphWF4h56zTHyjKTT+uUAi+4GdsZEb91/y4drn2ADDGfzmvNJVQNf2rl
	50K3xOCPL1mr4AjGV8fFtUCYPSxh9/62pYTiIHlS0/Sj02U+gdZECvvx2Ekk1cqKE3Jc=
X-Gm-Gg: ASbGncsvpKYqnU7ahdae4dXm2xF4SyYQhcHfUBLEw5PwWhvpVkf+0hdk6b7kzpyxb9Y
	MeiDQXnisxUjukFqcC72jv7on4JxGSThW28kGE694ocL+BmDuLUqumOpe9pxOveV8d/fMGu6NbW
	pT7OhF/22PhrMbTdAt567wKPapyxTh+wtYBhZC8WgkAlG6eWvVTbn8b1ehpBf1zzNYWIgaucNDt
	7NQ3zL/wNraewog9QGcpDWLGoFrWEiVizxBmNWpPyGppRTfWw4z1iJMCKNHNY3YDoPwANgO/s+N
	uMSTny7PUDBfEem/suyG3ASWeUe11IYp3xxyg0rZ9QI3Ug5e4rwKezzp1aV1DTaha/gzqyrTl3u
	V
X-Received: by 2002:a05:6a21:3282:b0:251:a106:d96c with SMTP id adf61e73a8af0-2533e5725bcmr21049847637.10.1757479533191;
        Tue, 09 Sep 2025 21:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1S+sjKgyN1lKxHVmFMTXNNAC58Alg7A+2ktpMH7cl+9ZuEPxHZYkd5o0sUtN8NWcXLqsGzw==
X-Received: by 2002:a05:6a21:3282:b0:251:a106:d96c with SMTP id adf61e73a8af0-2533e5725bcmr21049815637.10.1757479532703;
        Tue, 09 Sep 2025 21:45:32 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a3f3facsm1308056a12.7.2025.09.09.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 21:45:32 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v1] arm64: dts: qcom: monaco-evk: Use correct sound card compatible to match SoC
Date: Wed, 10 Sep 2025 10:15:12 +0530
Message-Id: <20250910044512.1369640-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX+rUD9W3fi8OI
 GtX/T/XF7zDEkKKg/nl7QBd0xTk6IYxDUUXSjfc2zdW2GfWRmXBrMMD39Wa0fjmsK5DIQi/D0r4
 p36WaEvwwGm00P18dKzluCWvBYGqDluS2v8dqbaJpUtYQMK4bEJoJdrV9w+9i28ma6YOCKiuzWP
 uyaqhxJ18TWRnoRezB1kKkJ+CCS2TDelSIFJE6jp+PmJldvdu6SbrZGGrCxsXc618RG9uvuRsFX
 VaQKpW3HDX35fCuQ124ARePpxMzhq9fcB6cdLDfo8Kq3EB0Z3VwCyS8WZgdkvni6JkbrslYE+Vp
 ZPn9I6F7OYyxYx6+BImuA6fIgStgMzdVgIWWLighIic/RNApEkk1uTXt1t+QdL4NzC1Coar3i02
 q7AUKO47
X-Proofpoint-ORIG-GUID: XZgDXUUOidsaipneyKScIjvTelathXgX
X-Proofpoint-GUID: XZgDXUUOidsaipneyKScIjvTelathXgX
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c1026e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yYq7zTALbQGsISW0NoIA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

The Monaco-EVK board is based on Qualcomm's QCS8300 SoC. The DTS
previously reused the sound card compatible as "qcom,qcs8275-sndcard",
which is based on existing coverage. To maintain clarity and consistency,
the naming conventions for the compatible should reflect actual SoC
rather than the board. Therefore, update the sound card compatible as
"qcom,qcs8300-sndcard" to avoid potential confusion.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
This patch series depends on patch series:
https://lore.kernel.org/linux-sound/20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com/
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index f3c5d363921e..7187c1760ef5 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -38,7 +38,7 @@ max98357a: audio-codec-1 {
 	};
 
 	sound {
-		compatible = "qcom,qcs8275-sndcard";
+		compatible = "qcom,qcs8300-sndcard";
 		model = "MONACO-EVK";
 
 		pinctrl-0 = <&hs0_mi2s_active>, <&mi2s1_active>;
-- 
2.34.1


