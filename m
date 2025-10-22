Return-Path: <linux-kernel+bounces-864266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E149EBFA556
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D700A504238
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30B2F39D1;
	Wed, 22 Oct 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="acozxuFW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E22F2915
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115838; cv=none; b=D+YpdKuHs+TeRQw9iXT4TSqK8KcpmazZ13ZJUsf12wUFMaZAm6mgiU1hV4pQPlGDALj69pUbWq/byjtpDhFaAe3bWedkrknyrHfLbnW8NnLPp3Es4AOJHBs77v+jXEtMJl6OcAMoxvxmq1Br+JJX5QKEBEcY5X499BIhpzlD5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115838; c=relaxed/simple;
	bh=R2uTwpKHPZ20EpsMj68tM8tKyulxK82YeGkwd7bj4Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dv2ljPaMXmtFaq/cnBH0HVytw/p0XOQ8v6VmnqgE+LcQQAa7LtNgAKekMEuthtxCeOcEorXaflUDNg5wYo5rpAiGcFPEMiFaqG8DhnvSO8TTWJmH0a92iDPo6A/9IC8CnM+8vHZUZuNKoDmPZaJCtOu8IfwXozbwTREtG59xIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=acozxuFW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2Lsk6019914
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aqqkie38Io4hu0mb64dIZJD1IDcsSkJekF9bBtAk5ic=; b=acozxuFWNNyrZicH
	stc8JyLtyz6HSKaKUMQ0+36x/4J6OrwZlVc63q5PS7sCATZgF8jc3N5F8qjl6yk1
	SiPNiuWCcSbCNrmyvxaAU8SJb0znn6R5KPX5WgxNAOrY8Jslxhw5V9zF9c4/64L7
	28Ea8XnPbY8najId7WF1G9ZgzmsLdbC5NHLh3qoGgjvWxEHtbh2WeVXmBQ3cVp2R
	v+vjTjV5c+5L81VS2L9p1EYgLBIgBEONtKGeRFnroMu1UH7oO/mGqxjJ4WQeLbyZ
	Pf2lwwLeqHfgnmn9AV9T8Cn6gEAZvW62YZtk75069AjGsTTEf6bCYhDQP4/NxNDT
	SjnStw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469kgn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso5228449a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115835; x=1761720635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqqkie38Io4hu0mb64dIZJD1IDcsSkJekF9bBtAk5ic=;
        b=fT3TqF2MsYh/VjjeHEYkWk3JKHd1ZhNbBJxK9rocWX3jLLuZIUcOUJAtsJGs/isSeC
         kkQQlJxl6WXZ8OgtmpkPlcS28piQEvnhF1RPf7OQ4JcJx6zUR+rPQgBJ3fYz/uaB0jIT
         lA3FMNieB58Cvri5vmi6BGJGDsOTO2zK1A5ZM7foxWYtDJdabkyE3HtRowX9eyqfd2fq
         dpdeOgahPbcbjdbaC2iU9Ed4zC3xlsFizAyikoO0utNnPrIDn5e0NssBrsUtumpc+rZJ
         Qjej1dL+I4rLjZ93J8VyI4eQ/+liJttITGPS7vADeEI1vIA+Ql0viRUbZZ0wokCs1Dfr
         dh0A==
X-Forwarded-Encrypted: i=1; AJvYcCW4SV+i1qIMeKt7hqq8zR/8GPO0Ve7r5vpQ58jOTokdKsVtQUp2P82tjY1CH3Lo/xRIiolpctXb4rAAsSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1ZoLJnU48+nDpnaYICmPLvK3Gq0IEVl6YJo0Z4ive0AczTCN
	YcuBd2nxoPg25ICQm0JDy1QXTJah+8awI2xdVuZizP+o2BZGJ8eNNmPG78NLit6IALPkqGhrK17
	SGqnt1lsLwo9gAECrCD0F400Hj8rLZQJOql++Zl9aaB/T1rZyJqqK7ghoDx9Y/m2gmgA=
X-Gm-Gg: ASbGncuhaa+/XJNDWjl0VuYqwTgVnpzPibzZSIDlRGNtCSxsfwMo27EmfrWjphPnBJy
	fgs9a6gSQbUMttSbWtPp49dPjiOF+OfA4bJKZWJG5606fpf8ro13qJyxpLKCALVyXxWaJHqFQFe
	CZdGQ+L1OPfxeoQy7lR0An4s9kZzmAiHKTCtPGdjGorTCE9eKwUSj1yjJZKDjsb+Uv6XJcoGU4V
	28hkYnQMx/0msZYX0gBYFxDsGhYXwo3Z1XzoUdAWT8XNDIcZYYpyeYwnmyYVJlruU4Mm+G83z5t
	gIAj+99F3HIVQDgaO0vG2hmcxiTrYPgb4CBF1nzccI2BLvBJ7J15iM4zsWK87zKa1wV6hi1Mv40
	u6cLLycUt9HLQpbi+iff9ZOOHOfV/xlCSMNzbvjf/XCLjeX0Diw==
X-Received: by 2002:a17:90b:28c5:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-33bcf8934ffmr22879432a91.14.1761115834825;
        Tue, 21 Oct 2025 23:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1MCPo5x+mW04/fDDzB+zbN3zM7FjsI1S5Bd83h/Ux6zbFYXkZe+R+NWCCsh/3pGGknR+VEA==
X-Received: by 2002:a17:90b:28c5:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-33bcf8934ffmr22879401a91.14.1761115834395;
        Tue, 21 Oct 2025 23:50:34 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e334fsm1560285a91.8.2025.10.21.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:50:34 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:50:29 -0700
Subject: [PATCH v2 3/4] dt-bindings: usb: qcom,snps-dwc3: Add Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-usb-v2-3-a2809fffcfab@oss.qualcomm.com>
References: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
In-Reply-To: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761115829; l=1499;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=UA20oYIe2aKRt+hHDRY08ujyC1lJkXJo8K94H9otar0=;
 b=3AVv0Hfux1vndXJGtkEvrd/sB7HaosEIWlJIlOD3TbcH42qfehFrdp6qrGC0K1hG9Ctaz8zaO
 Q70neP76ZRYCGuBw0YFNtxN4BJd4ySveUfc6Iiw+esY64N3KZlI9G6N
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: l3fsPoWoq7XaaABjgP0sSOOuErlC3_qt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX4rhrPB4aFW6O
 9HpoZS5yt6bo8QV4lN7YO6s9Qp0ddIpK+iknA7ERAnwLiXvjiDT67v2Qp2I32NOuc8WA3Asi/sG
 MttwwG7LBzsPmm5FLx36QvJeg76GTQaksSz44IG82GyyhfNOMk6mc9azevNaRlMlIGkdpp34yZT
 mzmoy2cZtUoHctcbpMgIuQWNrM04xvbDgiRBpyrXNMWeBNDP5aEsTdFrWDFzDicYfnoWBXC2KZK
 BnuT/wzp1CFVQ4DnqHWYCtIb/29q7Ya9ZGoD9oytLzQhxiNeqvPWf6OOhjkQPPg8lu9+GABmITI
 vloMRS4xiQ2i1JSqj3lzSUdqeSR0VqSKbyWwm0/tVxbPnypezkjMhKiW2F1XMraeiBcSd0MlIwu
 3TQ8ehTziiAokFamR/rj64oJLTtg4g==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f87ebb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=cFzXH3D4Jfz4SSrHOhAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: l3fsPoWoq7XaaABjgP0sSOOuErlC3_qt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Kaanapali uses a single-node USB controller architecture with the Synopsys
DWC3 controller. Add this to the compatibles list to utilize the DWC3 QCOM
and DWC3 core framework.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index d49a58d5478f..8d1ef81b3962 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
           - qcom,ipq9574-dwc3
+          - qcom,kaanapali-dwc3
           - qcom,milos-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
@@ -200,6 +201,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq9574-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
@@ -479,6 +481,7 @@ allOf:
             enum:
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs615-dwc3
               - qcom,qcs8300-dwc3

-- 
2.25.1


