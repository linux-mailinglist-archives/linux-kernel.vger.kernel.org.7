Return-Path: <linux-kernel+bounces-870297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A5FC0A67A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61064349A43
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DFA1DA60F;
	Sun, 26 Oct 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKi4clLe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504926ED43
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477494; cv=none; b=Dqe4N2tsY2zpCb82ckISViElFcxv/2OMlAkcapn+T4+WWpLKbonYiaTtyT8SoBWIcLjBro43v9SbG8jnGrJTVv6+kbdOEqlahc2ZPeuCpnicGezHUsyx5HESgbi4h+WtjO1gBmSDnjJMnAynYRW+lYwajAoZHGaClsPsjjchvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477494; c=relaxed/simple;
	bh=O7f0ov9vTfLRbLjUh2RSJGZyEQmlwikWpzB+7BwXE+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGFVkT5QwfQpfjygwJKDaixao9BL0vmH6IpyGNqdo92HMCih2wXB6X6P4CrOHHlDp/uYmXynSUS+mwkue/ReSGTXfzAcsoTawUId6Uf4GGG1hkXXyy8tZ4cO4XHG4ZGovBoS/F4UWFNbQaMYjWl2W/1nrtZUpjG1lAtBYuT48tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKi4clLe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QAfeO23734905
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P8mfvs0DoXJ
	oaXO7wXqvtVIblGXbDsNop1/adqmTvLc=; b=DKi4clLeZbGVVdYeKpTPwJILIqt
	xLkAk834FJrryVerh7Mrl6cAvai+/JKisHDxLO0fsZWJGN6WKGwc+HP8wlz7kAkB
	bM6kkwgQ2uL4CH6c2wms8dngs/lV+uKZWFlNh0R6iVQFNvKeYr6EHhnhyvds37Ni
	xqgqnZnmx6maHmFuHdn1qr/M0YryCq7ZwndSGaWt7EHuZcRn4CIKA0C51qcwOLRV
	2DrNq1ayIAvMKTEXQciW6IY9r4GVxlFuBAtsicApE6vE0KrB+dYZOpIgetKkWKx1
	MaD90haXUfCfiskvUhIEjqMSaqu7nZEIhwqKUTeadvuxOPS7fIjpNVC5lgg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4w9yd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290baa27f53so14536595ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477490; x=1762082290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8mfvs0DoXJoaXO7wXqvtVIblGXbDsNop1/adqmTvLc=;
        b=JgEZD11+Ds+lH6t8tGg4Rqa9nLquKxdgsF6UGAaXRPrJPYDLOv7RFABeXbotyb/d6q
         YxhjmtO+40DCULIJhp7J7qcRDZxSV5bC0imuTROkKAizROj79Z06i/bziy9eha0PnuGv
         nvhsLcwXf9e3hYUNyW5nuPbJB8Ik2UIpp+u3xRKR9Kpr5eTDXnr0yq2z/zeVB6AvpGl9
         GGchWwDqLPkwNJTvdIY5cL5t6YT+P/NIZ2XC1YCck/+xxAuWOUZTA4UsxMU/XA7LG00I
         5S1bEqfYhBVANbA5Qjc81CCboFc/amxjlIGFJ6RlGbYXLb75KB5ue4OVpHmFx7hyyFZ6
         c2mA==
X-Forwarded-Encrypted: i=1; AJvYcCXJj4hGtA6/7yCBx9qw88/KG/60KnsewLneYhHt/BqPgzWnhe0bCmKbioEbW6S0aWS+pJ6XigrzJ7i8RhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7T1xMRLKVO/TYHbQD3OC+xUZL4cvuO2ZiYiXykQah1yqpVuzN
	650ykd3IJb5+No4hnM88CTk64KJSRDCafNy0dqVlHNXUB3uGH69x+V66v4b4F9z/id8jb41tBpC
	rDADJy8dHkWeFclgwm+3lLC6b/5ZhpEk7K36n3rVtHm0mqxQFMuRxdNbzy8AyvEjbWQ==
X-Gm-Gg: ASbGnctSyuT68+WvnqPmDiSN82dOg0r5FUVnIOMMCnvXk22+CLxMBvLsX8k7E3X7Y2g
	sQA0X7KClw6qo2eksmsjtrtFm/ujXg45/ilg+4HYMXgHk10qw1/vvXQ/anF5wDRLP9/oIsnH7/n
	agtw6VHT4H/Png7RUhYGwy7iQhwCrJIp1lxkRy1wrDGrfDaVRAOAF0LtORgR+UM0pEcFpUCgPRm
	hqWLx2ZPc+fEx6ZyVXs01wPrIY6EFp2hvanPKKtIv2Ofdt2xzLcNrcj+7DNhwEBLfCf/lHQBbcl
	wfzUOUN8FitawGXwyPFCgZJeQ7xRjtrNwyBOod2KMQX1D6iJTQiqX+innXsIGFpOP0pKpMFmwcQ
	hnZEnbCcPzIpxSxDLLxsQaA7k/8xf1w==
X-Received: by 2002:a05:6a00:2395:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a220aaf4d1mr21273888b3a.6.1761477490498;
        Sun, 26 Oct 2025 04:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNQ6EVFYhzFH0yOaaPaFygjEcZd5WgQfQ13uWqgn/4cx6r/RKDbAVe0Xx5/gvvysn+ksiu/Q==
X-Received: by 2002:a05:6a00:2395:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a220aaf4d1mr21273880b3a.6.1761477490059;
        Sun, 26 Oct 2025 04:18:10 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:09 -0700 (PDT)
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
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V3 1/4] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Sun, 26 Oct 2025 16:47:43 +0530
Message-Id: <20251026111746.3195861-2-sarthak.garg@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: PAfyZFxK0L37S0QKF3BmcrTXhewQSef-
X-Proofpoint-GUID: PAfyZFxK0L37S0QKF3BmcrTXhewQSef-
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68fe0373 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=yU21l3sC3bVkzOeoNhsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfX+3kD6/ZA1qX8
 DnJgm07JZu2f7m17e/VkMQ52UZ7ZdK2V955g/YG1ktWn32xmwftHLlEHU1GbCd1n+s94oOksWTh
 uuTwZfj+2u1EXaOyIEhUEe9NF8AH6apfooSx58nQD/mivR5FHmuukW/xhEtQAgmu9ol/3vGXW/Y
 QkUmfwBcMEW72XZ+xrD11h0/16gesNT/GAsJuJqi5T4WrZCrE+rWEffq/TAqk+3CClurtrEAp5l
 9+d6dcLrUTbmfBOzVLmLf/69/pRS6grMl+Bm9Uo6CmA0o61TH3PfNVAtrnOd4trFOXlrJyZJK/W
 s/srugtuZIC7byPK30uz2ymgb8XdvJGLEo601trA3AjaAdtg5Pt+iP87RIGeQrbZNQoKI0VTjaP
 oB0P+ikCfaxMTTcGU13LtklR+sSiBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

Document the compatible string for the SDHCI controller on the
sm8750 platform.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff21..027011223368 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -70,6 +70,7 @@ properties:
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
               - qcom,sm8650-sdhci
+              - qcom,sm8750-sdhci
               - qcom,x1e80100-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
-- 
2.34.1


