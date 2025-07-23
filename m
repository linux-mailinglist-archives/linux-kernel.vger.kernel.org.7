Return-Path: <linux-kernel+bounces-743282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B222B0FCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEAF1CC2EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87ED2820B1;
	Wed, 23 Jul 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBTVc/pY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EB27E04F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309698; cv=none; b=XWYxt35TptozMG56Hw49yCua6x5NPF1D7C6vhBM7zVuG0kALqcscd7cuClHea1l7ibTs3HselxmT3He87vSs+k8ZdmsxGYSvEV2ZudT5aTHyLFoj9AmNkTwtZFopp1iPyByAfSjggHboSznSXmFzC/Y7GDbBy93J9wyGbaHcXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309698; c=relaxed/simple;
	bh=zYF2GQzOX7UoU9RcPjJT84Ey9Vp+O+mZOIRzMyW3cr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inDawJ4RhvR6a+CWCzx2vxVOWPPvL3ndXjCeH/GRXhYRAB1Z0JbwTb3+Li19zaSnbhGDqZPuT4CQOoeJAtdxXSQBgoYcvDlqBzNIp5iUDkY7V5UkqOWmqfUsDKmgvgFXQRUWdmME4u1iLrEjQxdblPXNQWEzwgEDDfzIjcipTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBTVc/pY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHBIt9005191
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XkLhLpw/zbA
	8rKihC+Ls2PIVo2hpg7LCRAqY62Ywf5U=; b=RBTVc/pYQAVNIU28sOIJafv7RVA
	dZUd33X+yYnNyNDoLf5/MqTGXz5EpsSH7Ep7VivvuOLHNRfmGOmWuCTcSnEHCBbz
	fJq0p96UQCbv7COH8uA5SHZNIVvm6aE8MXlZwbOwJ2DkP5uU18vYfUdU5g+r+pho
	toT3exT1WiIdy6o7f43ZcVI01ycTpH+pMCPa/7uqytCH9Yq9XnxBhhUwc0NPENDK
	T1LV4ml9elndit28cGieoNmwRnaGSE7jqL7RXSpWKGusGdJoCfGPdWNo2RqKESru
	/+5qgy2tk0OC8iezFN/ux79cQEvRbDtKJBADNsi7yGdS2CqTSe4jMmcjcyQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w7uvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fabd295d12so7289246d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309694; x=1753914494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkLhLpw/zbA8rKihC+Ls2PIVo2hpg7LCRAqY62Ywf5U=;
        b=J9VJcUeCDpRnb2fkEsjO5XGo1uTBimoIoFj/xqeD3E9p7X3RCTmEqILKm8Uy13Rrvt
         5Bm3df3OCHahaVYOWPawjMLfLfmvjJ3SuyB9DwrmoanD7gUNJGxlWpWGh/Ghi/v0TNqw
         7QjUTW6xODzvTnj99LhnlMb6ODik4Zq8Bk7YX+DJWFQgxLi2vyCDip5av5hL/zG3jQ2f
         buKLyCrL+0OkRpBgqdvb//uhYKw+cZnJQdneRAyz7DHBNgIhf1Ft9RSRVBFC/bh0g34M
         S/S1n3Af4FPd+15FKt0dXpDGmVGp73i/wEcGkmNNy4uQbusKtoEIGT+5adt9BGIauCqA
         zSsA==
X-Forwarded-Encrypted: i=1; AJvYcCVdIr4pEYKxa4ffEkI8JS6bmqrd/NoipGdf62Qrgwz8ER55ckJY+ILMk7zbZ1wy7iSOOBwDY2JASG7E5QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGanZDcHSFmDugRoq4FxQATQ/q26fx3k/BQ0dgYR9YOr6JJSt
	pmCcRHPF4Fi9n+3wNpjmo3Aw1f6i7Wqbk8I4Liz9gf8Exef302fwjTS+TF9Rp4fdSip/B7xUIA4
	kycX5miMG3ZfsaHDIX+ybjsBMRbM9luaA+Lx4Zwxiij4vi2qE6dtJw+0vktlc9bMbBPs=
X-Gm-Gg: ASbGnctszL1USikVCiXz/RBw5bTCI5NXCZrkX+H293tkLwtjfAkz4JcDM8k1zq49hST
	omrvzXZedm1YUp3RAHOOcwAXYwpRopHihFvtpePAxgv9PfjIz1fQ5q6VrCGn0WXzIjrUe2mzFz0
	8rIg2ucZDSoobSy0gIlzncE9oLfo2K2qsg73zceN+BYh0ZWwVP5qk24wP92qU6HYzVFx29EsSC6
	hJccuHWA6KuZCMQCN1MM+U6YyIylLKicBDthxZP8M5Gjym3/ZJlRHR2LA80Crt2QRM5cfm0HIoo
	ASiJ1S4HEK3cRqaZBRqBjgrwY9agQl6iR7TZAUEhjc69Km4XTr7IUg==
X-Received: by 2002:a05:6214:e41:b0:704:f7d8:edf9 with SMTP id 6a1803df08f44-707007104a1mr76741536d6.46.1753309694055;
        Wed, 23 Jul 2025 15:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA+u9kqKlJeKjA99+wEjnn/wxztrEfMRykSn0vSNeVKYrs1jCV1RC5Qvq6ovGlFrpAVJTfdA==
X-Received: by 2002:a05:6214:e41:b0:704:f7d8:edf9 with SMTP id 6a1803df08f44-707007104a1mr76740976d6.46.1753309693475;
        Wed, 23 Jul 2025 15:28:13 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:13 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 21/23] arm64: dts: qcom: sm8550: add sound prefix for wsa2
Date: Wed, 23 Jul 2025 23:27:35 +0100
Message-ID: <20250723222737.35561-22-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=688161ff cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Nfxnn_ge1f9Pje3RmyYA:9 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX5+Mjye0VAQm0
 DS8HS7uF10aJdIn36Swhl3n0u0Q3BeoW4KlYQH4TCv7YWviybJF2EDyTvX4WqYOtj78LpazmMam
 8vuOThvjp0GOzjN6GsKgPXtRDVGL2yVpLQ9e7hGPJNoQCqyoLLrbfiV3fm7GGchTdYVlzDq7suG
 /hyzWMLJ7DHvjuFYtRqSPPTiJ+fulY5SX/AoKXZY6WGvb2u2lq+rImVP3ea0oMszOAekkvZK8Y8
 3b5/NCtHfEdHLI1LgweUnQGTL+jI8ai0qzvsZ2Ddxr7bAPYAArb8qT4Y5dDbLhAgcTlBiNGaRhn
 QFeNaB71Fq2UXXA4dV390Zmkkt5tVbKnwd5/Wg0i59qL9fdMo+CKAagZUKEmDJRBTV4+AYI+u4H
 SN8ybWGd7mxfb1U9R/8o8nKwtiV/9ciaIFjHFsktHjE9GefjM5u6KflRWUuo0lRciHMqd097
X-Proofpoint-ORIG-GUID: tt3lyOvHdXzkeIa3xnSbluXtgaBgemb9
X-Proofpoint-GUID: tt3lyOvHdXzkeIa3xnSbluXtgaBgemb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=797 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

WSA and WSA2 are two instances of WSA codec macro, this can lead
dupicate dapm widgets and mixers resulting in failing to probe
soundcard if both of these instances are part of the dai-link.

Correct way to address this is to add sound-name-prefix to WSA2
instances to avoid such confilcting mixers and dapm widgets.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d35d2b9b438d..5f748f6eb27a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2811,6 +2811,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
 			#sound-dai-cells = <1>;
+			sound-name-prefix = "WSA2";
 		};
 
 		swr3: soundwire@6ab0000 {
-- 
2.50.0


