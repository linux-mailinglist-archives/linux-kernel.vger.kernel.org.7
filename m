Return-Path: <linux-kernel+bounces-831427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE6B9CA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E86E3AE62D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C42C0267;
	Wed, 24 Sep 2025 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTsOALnP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E70286D60
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757052; cv=none; b=C+vkJ25o7JROsysmUqM8zIydOL/botFbc2Rmto67ejAetheX6QTcgr8Um29DZljHLNI8u2plJ90XwpqYmH0VfW6L1AbMBcH3OqAFCtGgD+NUglcjmGczHaeuh3ejk2b7owv7chtiUCKhFT1PefphEvON7ydO1HXqI6ABPW4P/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757052; c=relaxed/simple;
	bh=VhAgW/dnywD+u4kxqj28b77/K159FY5Soeolgkg1/Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IShdgKDd436NUlF9vdsBDwSPTVJn0HfFiSSLfiHvlpmXxlY21jw9tCOHHIo7VcYrIXGTineOO16ft9i93pVdBSeNq/lN/VV6WcVTmF01/KnKXoBkoUgxMlLoyezLLG7kwh63bAbY48XDyI3lfPoDqFqqzROa+CEa5XHTkhFZF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTsOALnP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCTQNK017434
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sr3bmZYIkPrHlHUer4SaFc+7DYW/FxpmFC/DXNrVSFU=; b=jTsOALnPBC0oL3Nb
	KL00NmMG3fnK+VT2jz/WTlg2uIWALSHalOy9P0t87pwb1tg+X8aaEsMKdz6L6pJz
	PZ6bXWp/lKHemIoC77ZzdTJ3WrRU2BUdQ90NzSwZo1YtXZ6h0i5fwl8zS/LkaIbb
	LeOHGva3BMpNAXZ5s8jlT5v2xqyadSYDstl1wc0n7pFrLrqZJ0PHnZEA2moswBAx
	aO6kUpvWZGU2lCRoYAqYFEbPW2coIHanDhvnoKz2bbt5y52XqrPclgV7JprkzLzY
	qxC24dLzNm3EJ2HzUu5kN6sqBf/2UVUZNKN+wvWeiM9ElbeOKlIC5BDNzu4l966v
	FZlstQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjycs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc08so630776a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757049; x=1759361849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr3bmZYIkPrHlHUer4SaFc+7DYW/FxpmFC/DXNrVSFU=;
        b=OZhqBsKzrM51xzEfVoUdsjOwhFJy/35o+vLF4SPX9dJO2mZlImk57LDOUoDOImMpi2
         jf145SGMQG9jzWNu2GYIA5x50DZOjf0Ip+u8A62l3RexHVN5zoPxoYnQwYem2Q6fclfI
         c8XYDN3zIHzzkCjB4lUs720qRgm++5SxFXMIZP0suFkm9w5Mo8jFO7XDThLfUXGHR4kZ
         7mm/KtuMhFE1IBY0Wvn9ypBd8kR/1NX4y2sCKEaJXy1fzh6/LzHkjl+SIhXkWvVeFylo
         P+6GUDNiCDtt4tGkiSBf3su3qxL9SReTCapUiZlmo4NK2B7G8Zywl7RyPU1VmuwXdGjb
         ag5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwX052vBn8oByLR3Oz0aHDYrQBnA1vaVejFg8Kdno3RpS7VTLtQIwCvYv8zZ+hzqeSl0HD0E3fYL2UpPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxzCLNnpTODo3TvDCSkuZOn57zfJFBl3qMs/Sbae7wEhUrNpB
	4k5LdOu0VmDZ6d6w72l0gjd/evP3AymrE99epB/SMnOwJCMrzFcV8N0SF/8EuvfC0a7r/D6bSlY
	hzKNuU9jRg2nmex4CBygZko6vVbD7giu2Sdyg/gSadh1DJ3XvNhtGtIyO2yvlFfII9nE=
X-Gm-Gg: ASbGncsYOY6CFWyR+vw6Cu6OwNu13eTqXMu8aQNocJqOvgufp5ZO6Ct7G+w4KGvufsb
	w79ossUuy6g+lewVj4s8UDr+tChDsV7Jl6sYflRta4y/d/XuZo5vHBcflBOka+p1JNMNPsc+YJW
	D2ICWe+8yMMaoWQvqIqkbTmP0Is0YzOGRFqAxQ9N1zTJ0phqeEjr8TIvPyubodKZQ6ULz9EWhlX
	ZWpNFpnt4Xb1vFWC5JGWBbs4SPG0jNzZ0RkCamaoDFBNM/C6dbZT9Yzcpasgug8j5TinErq81oA
	1FQDY48XRw0W6+XGNHhK0wwmvQmDHKMMLxp2dNvX+fGV6ucigvkAGYpXDJRxrGyaAWd0YUoZ9zQ
	QG5rg12/vKmtPFrY=
X-Received: by 2002:a17:90b:4d8a:b0:330:6f16:c4d8 with SMTP id 98e67ed59e1d1-3344ae0aee3mr651561a91.7.1758757049648;
        Wed, 24 Sep 2025 16:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb1d2hwh+kDjpa297ZpIISZ+RbiXSGQA/VaPwnHBRNX4G95Xh4r8MGW01I7uk6O6hT2XCc2w==
X-Received: by 2002:a17:90b:4d8a:b0:330:6f16:c4d8 with SMTP id 98e67ed59e1d1-3344ae0aee3mr651541a91.7.1758757049237;
        Wed, 24 Sep 2025 16:37:29 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d73550sm227187a91.3.2025.09.24.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:37:28 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:37:22 -0700
Subject: [PATCH 1/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
In-Reply-To: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757046; l=1544;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VhAgW/dnywD+u4kxqj28b77/K159FY5Soeolgkg1/Zg=;
 b=SIPKgm1bGvoRtqAyH8aI/di/jCkXLR6jj6oSX+WKhVqi9+qcf/Ea2nRMH7lxKNmTxccmPNQXn
 K/ABy/COHVLC16Buao0XIWaerMxGjMPg6nwaLJGFsCTmdoCdTfcg06s
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: KhW5LoYrw1UwPEmUPNLh3C_kXAVlvNS-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX6MPpmUnrnrBY
 Y0N8AbCOHs4iTSCEK1Ix9+It4sf9BhmFXMTU4PzSyyoR+q8RVI8nYPdSX9GtL9DnJcKXWCflQ5t
 1RqjwwBhXWeX9pwrQoVjwVv33tyDQycUOIvLdTLQ4cNMSMcefe3K8SzFWbwZUsdRQ8got0yVgFe
 RsBsrKWUc1ULhjnzpaanTnjfvdbGAvE/1m7MyvvtMzBl0TJIzlgn4BGjfBTop668+FAQuGFpier
 WHw5kp0YG3MZ4uFsMulcHhm9FtyZPCWGQ4qZ5Oxdk9pK4Qje17qXM4FpEvmFEuWK6zw53n9Ovft
 +G1pRPdXdMRciuV20I3ivuS5IvaLm/tLaFDEaNkMEZTBOSfqz1t3Cihtm+Np4U67H2YiapUEVUX
 l2M1KMo6
X-Proofpoint-GUID: KhW5LoYrw1UwPEmUPNLh3C_kXAVlvNS-
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d480ba cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7zWBZCs1gTFKjwm3VpwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
compatible with SM8750, which can fallback to SM8550 except for one more
interrupt ("shutdown-ack").

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 2dd479cf4821..be9e2a0bc060 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -28,7 +28,9 @@ properties:
           - qcom,x1e80100-adsp-pas
           - qcom,x1e80100-cdsp-pas
       - items:
-          - const: qcom,sm8750-adsp-pas
+          - enum:
+              - qcom,kaanapali-adsp-pas
+              - qcom,sm8750-adsp-pas
           - const: qcom,sm8550-adsp-pas
       - items:
           - const: qcom,sm8750-cdsp-pas
@@ -95,6 +97,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-adsp-pas
               - qcom,sm8750-adsp-pas
     then:
       properties:
@@ -185,6 +188,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-adsp-pas
               - qcom,sm8550-adsp-pas
               - qcom,sm8650-adsp-pas
               - qcom,sm8750-adsp-pas

-- 
2.25.1


