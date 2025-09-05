Return-Path: <linux-kernel+bounces-803669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB3B46389
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328A07BD8FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010127AC31;
	Fri,  5 Sep 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq1LpPPP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F322798E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100242; cv=none; b=NsW0n3g7+93ODEhye8lqag4ICS6ggN3NDYC5ptE3xsFsAp4s+btInu1HFswr3yg0jgcy2GqXhi0iUJG3fE2nYypoiUPHtkbZB6aMudjvauTIMa2qbGG6CBKFA2Gc+Y2nM291SHsvSPiOh1dS/Y3HI4xwuNXnMnqQJaMWY03OaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100242; c=relaxed/simple;
	bh=srGN4WhgcsLMS/KlvSz1eAaY77p1cgmpEUU/3SXesow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oI8tDN90IfmvNnzb1UHFlZ0ihqAw+VT9jt6bpMoFx+1pPbIJOELxeke/DjvedoRC5kV1mVC7ShjPQjLVPS2d1sGIdioOxIvEYmhNHh/XYLSd1jp9veAXk+iMZLiad0iUAcPj8DTTBFkTd9FJiu6hWhlbjUi/VFb4yqvwu6UX0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iq1LpPPP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GKmmn007609
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UaZY5Y1LnNR
	AK4qvayKbjf6g+d3GE+1VhtaKAe1H3T4=; b=iq1LpPPPe6ax/mbNRbfl2lJAgrk
	jdRI9PXybAIWuImTFMS8YkDOMzw9Mc/L2If0f7mFYhZNuvsIwXBUZmGOii1ywRJo
	rGK7xxM3oIF4hUdwZQeomcZqjL1VggfCviN/GKyTPoKvrK//Yp9FloFVKdVkFZEK
	gb3o/pnAsEOB+90KP1AXIUbCdAcmg+Mx/BsatB9+bSOiAZxFEbHdGZ9FBOXjHaD1
	QGhkhvkZUU7Ouc+ypnPsqSEezSeRMVXaZcEP7044AnUziZN2h8oE5j/Irzlqrws7
	WwZp/tpkecUF84YDcSHdRn70gPQC4I8YDvfCvmZGsXjYuH3TAZHvP2UWufw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura947xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:24:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b172f65edso5616545ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100239; x=1757705039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaZY5Y1LnNRAK4qvayKbjf6g+d3GE+1VhtaKAe1H3T4=;
        b=PBicls5cs9Bk0zS+NQE9cGmY8m2FaWYy7EcdAZTwkKArOecqGd8Os5ac0KEhOGWzSz
         XGa54BKExGNiE6q/2wIf0dUlZSUHPfXEa/bTddtpAdWztQScjfGntOO5eYKCy2XI73ER
         Jhf5qqpzmF4UyEu6nZiEXQPtM7sPYZzNUL5JbQs+dPNUygVwuT7z8A9wn3LnndQlNFwr
         i0lw+XsmjMSH72CZmhBtujV9gP+J4xNR64R6GIPk5OR+Ss7EadfTxe86wrlR96lpS18z
         nkgAmIFNzqbqJciIud7SKjJhc28bkD6/W+aR060TQxMo5EJ4b+nEthre/Wrcqn4A0sFS
         NsNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJvH6+xBkt5+SkgINkmm7cdcZjMWx/bTVn1CiKwugTwqBoVn0CGapxHr7b8XJRfqlxEuIa6JXb9QSR5Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VG+Q35/Uwq+7AB8QjJ/mbVlOKRkI5ag7Snpi/Nz4g3Nk5Jji
	HnfPhZe5nchBkezQYlmqRQ50pSjn30S3dgjkfUnbhF1OSgWtbhcIs3DJdq6srG8Vrg27mCiq6wm
	4xWhz3mRAAwZ7bGqrPQPrjiglOJSSmUNqeI3+4M05M0g+5puSRTG6kFrp61mOEak84Gw=
X-Gm-Gg: ASbGncv4Rpy4aNkFUuGErDd93ng2T2UeOYiTfdDC4IfY2JAQHfVMB1am3Jz8KKiehnb
	tTooEconb7GbWazEJhPYHJlyP+PwwNAAQR59WzgpAFgFkd8QXcPmesD0eijRo9ntDZDC1WVFhAO
	yWKDNli/tXKZ9UFlRpD+NDhIVdopZoS9L3Kx1YTn5CMTdVfWdjQI5kwxGWpnj+QaZZ+FZt5iE0M
	vlgWVJEBkSOPce/whDhFHEjoCU/GhR5NHv8b3fhNgxHhBjWkdyis5dSNy6y6G53w6o/32vIPhOF
	hem2jAWivQXI8g3Xll6E+d0QNXS4L2Xx7QqiOO5usa6C6XAtknbceNZ7XJ6/HZuWx1Y1JtM=
X-Received: by 2002:a17:902:c40e:b0:246:7702:dfd9 with SMTP id d9443c01a7336-2491f113dc2mr206778965ad.6.1757100239079;
        Fri, 05 Sep 2025 12:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmsSbG7P7sBg6yvvCEFKsVBf+CyWQn38skY3q8PaoBvPhKQ2xHKRloQaIxTAZOeMpXNWnAig==
X-Received: by 2002:a17:902:c40e:b0:246:7702:dfd9 with SMTP id d9443c01a7336-2491f113dc2mr206778865ad.6.1757100238689;
        Fri, 05 Sep 2025 12:23:58 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc1a82a34sm52397055ad.151.2025.09.05.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:23:58 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: qcom: Add Monaco EVK support
Date: Sat,  6 Sep 2025 00:53:47 +0530
Message-Id: <20250905192350.1223812-2-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5-8KKfQVGyvmorhvQpgh0yZvRyXEAWbD
X-Proofpoint-GUID: 5-8KKfQVGyvmorhvQpgh0yZvRyXEAWbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX6R3/rux9hrvz
 P9UiZpiSgTCcNZViwi1t43D5WJfJNFySXiaItS6pdf89W/r9JyxmIsbd2LTNrMyXKNz93bYJl8N
 df6dY11BXDiSnK+KSoxB2aNruCM5dqmzXVKVI4fxHzVknHJnJdGF/BzrpHtumDYIMYJPZfhJtTj
 TMVR3T2PLa6LPmEOqtPt98JKHJPCbc/4p487pbsgKwdgI7afp3z7S31wP/Ctgq5cT48/TwZ3lMU
 cSunBn8GSNalVKK323UbZgmOJTLGeQwYQuLEE/DRC8y9ZF/HI/G1tEDiHLsbAI+txY3AV4izBJ9
 ZTc+hLyljjNU0zNVnRN7r4amQJk5rxIXL6tmValamIMVH92FM0CBWvDv3pZRzQWRpWzY/EaqXqs
 HrtSIwUI
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bb38d0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Zd15BVePnIxtF9Lu70oA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Introduce new bindings for the Monaco Evaluation Kit (EVK),
an IoT board based on the QCS8300 SoC.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0110be27c4f6..7d47d0c04376 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -855,6 +855,7 @@ properties:

       - items:
           - enum:
+              - qcom,monaco-evk
               - qcom,qcs8300-ride
           - const: qcom,qcs8300

--
2.34.1


