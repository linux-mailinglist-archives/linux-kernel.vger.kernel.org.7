Return-Path: <linux-kernel+bounces-845032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B237EBC353E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651DB3C6E76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B32BEC42;
	Wed,  8 Oct 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NR/lVYcG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C42BE7A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898354; cv=none; b=YTCpUHbao9S6G5ghwYEyQpWBmIc75/H9eS2dYuP22tVFDgV6b5NJex1QEmYMz2jKL5a6Gvx457NvpXXyI8CItJ6YmCW8h4uc7aS/s8a7Py6DdPmiZF5mMoCf8LszOxOeE+uGZfGWTeI2+ySSSB4xmPSYFFX4AV/75a7QSgc2X+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898354; c=relaxed/simple;
	bh=hht37/NDv30Oa+aKyOzANv89mcoO4/sEWwQ8//dR9A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hpaoBV/fxj4REj4vJmubkboKOIEv1PPF7NQimDjepm4xRNAqlcpxGyqHibYfdrrbzfAPLMY/dst376oFLm3nJjchHRmFd/QxoVyAL8Obo/+Za9e13iYcT+81mPcJ3iH/8nMYqAuPjHSubrfMovgxFgdTTPbHCL5gNDKroCCOAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NR/lVYcG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803TRs005561
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 04:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AM/05eypT4oTiP4F+74Cml
	XpUKAPm7pgvBzvSyCTRNE=; b=NR/lVYcGCCSSE3MiQ8/j0if27BExIldgNfuBX0
	Pdnr3BtB50ukEbKZXpsF4nXk4Do71AxhRsbO6Dco2tfuox+WYA21V6VYrrUc6mZq
	DCIHKpmW2BdwoZ0Uoy51gqrZCWxNkL/z8BTjtgoggRF2Rw/F+BlMTjs21VPpRcji
	DsD/n5Xx2dzQo+Fugoot2wVDZGn9Wm3clUpiQsbD/hCuQV3F6v9IUfMTgLbI8q/l
	WgHVqX7tsLPwpvwQOatqTFgwKqD7iPPvKsTugH9xf8BgYkOGagNBbxIzRTlzSNrj
	bhXex+QNo46SrCR18HDRLEGehJqTJTDt7/PBlijyfEzH4sMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn9n3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:39:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28c58e009d1so123244055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898350; x=1760503150;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AM/05eypT4oTiP4F+74CmlXpUKAPm7pgvBzvSyCTRNE=;
        b=OYdOqoHJAIZcXNSYBfUhxMRICerMKH3ePOuUy+gB/9UnoPO7fFq7iAQXaqxjLhPXY0
         w1NabTQJWGPFpYy9Rqt8rZklo6E32O02lx+BRvQfTunboJZMdSXTPjI114V/Nm1nCjZt
         mJyK/osY0Z8gn/mfjsqvHBEo1Kss7bPpTYgSIuNEdrhukJ7waIiDscwlkXT06zVkRtRE
         diONqgoOjE6jb8BRwGQb5k6c0S2tbKuQ7t61h72iSEoHVhLysq83CKHE0wHSjmaC2qnh
         EePuCASurxA0DyK7zeBXgdJGya26LlOuhSNQdfTfB6ms3BoYOU3m5kMZmTtouseJRRKk
         fGXA==
X-Forwarded-Encrypted: i=1; AJvYcCWnXP0YYGA0S0/s4guOr8+mW6TIIjqGr0qZqwO3d377R7K92uRQSsnIQ0BsOBlIWipIwZvVICdRn8ocdP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcucVIluBEclZe4AiWZBCdVEg/tpLzSwe4hsEm1fTAWcWgKi7
	DiZbB2O8DDRikOyQ5h4kft5IVgOXf6v0IGlNHrNzlIrh7hxdUvh0gt7w/HzdBcoNnJlUHhMqyab
	CDZY9nDF3rW71tNk2/kCv2XWYKiUPtX7fLUMYPCbNeJfQYsJq8IvcvhtflWs/pleJV8Y=
X-Gm-Gg: ASbGncvTIZOz0fs+3BfFcr3vE2e25HzB1gWySPDiACymdPR44jiidoPOaMtAY3eKhFc
	jhJihTnKXsS2uAFX+tgdh/eyWlrAmwzFF2ECcQfc83WWjmpujvcAlO+863/rw3G50vaSSYWCXkk
	g54ViI8ts59BLB+KF7LgHSCO/7feJ+lZmJqFVlo4cOQXLi7VWDMZntZ/+nWZdQLF22hY1fPkhz+
	ATwJut/dkqRdGpeA7a7/E7wEoYsJO022hqgBy2MzXnXjleZBMud4BBbhJyjczvtq5weYse19p3Q
	MuNcCd1hRrBbyBpO2hcBlCKi8bB7qYFn0DL6YSjwzKX8/vSBmw1hguHne+Tjv45xya1rDnD2YiF
	2C0tZ
X-Received: by 2002:a17:902:f608:b0:263:b8f:77dd with SMTP id d9443c01a7336-2902741d0a7mr29918025ad.57.1759898350200;
        Tue, 07 Oct 2025 21:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/H7uGWT+kHZnZwRSf9zZG0Bfh3PNzBiXQtq0/6X7KXre7pZt7oC0KpTvEVEF/9JoGV3pSKQ==
X-Received: by 2002:a17:902:f608:b0:263:b8f:77dd with SMTP id d9443c01a7336-2902741d0a7mr29917705ad.57.1759898349773;
        Tue, 07 Oct 2025 21:39:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f19ddsm184328635ad.127.2025.10.07.21.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:39:09 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 10:08:55 +0530
Subject: [PATCH] arm64: dts: qcom: sm8750-mtp: move PCIe GPIOs to pcieport0
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN7q5WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwML3eJcC3NTA91kU4MkCxMjw1QLA0MloOKCotS0zAqwQdGxtbUA8c/
 qlFgAAAA=
X-Change-ID: 20251008-sm8750-c50b8421e801
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759898346; l=1500;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=hht37/NDv30Oa+aKyOzANv89mcoO4/sEWwQ8//dR9A4=;
 b=aOafIbRpHXZVyT85h7kCH8/o2BBLZarrtuiAavbeJ+RXNyCVIk7QvE5EG4Wxbk7ySAXrQ3zdm
 C9HgKyvCRKhBIjYyBbD1VmVxixlOID5tzfg7cl4SqGejCfRnTq5zSl4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX+YiWxFowts+U
 7hN6jsK2iAcqFLkR/F8JU+Wk7vqwz2EaPJjqePsx3bAFsONOBRTkeWXUGANd/aMoukvRxJ4h6/H
 9NyU9CwmgVeabu4dj+PHoSsXLE2G6Jm99H1BS5qdhKAKVDrrD/OzBB3SSmzbwJDQA2wZkP8PVFm
 o7CS1rwHLtWmCUXW1lYk1xC2ld4bC4hLu0QPmsoGv+wnc0GgtKRL3jNLkPukHkWok9GZ/ZuDnKA
 FBrQtcUBxijNkNou/t2wb9UfuOWJQ1pxivhMopDsmQI4S+ZlXrH+x3hc/I5pYIRNw9TU7Gor6eo
 TcydOu58dMh6dL9eKsPNZeHp3KGEo2R3uF4RFplVMiFBJQ9lrKFBugrgB+thqxfrNWg7K9SoaHY
 o6F7oH8BRwI00Ep3mKfbAhfEtUu0eg==
X-Proofpoint-GUID: W3hIG4FgCGtWCPwQx0G9QSBLHuJVfifu
X-Proofpoint-ORIG-GUID: W3hIG4FgCGtWCPwQx0G9QSBLHuJVfifu
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e5eaef cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

Relocate the wake-gpios and perst-gpios properties from the pcie0
controller node to the pcieport0 node. These GPIOs are associated with
the PCIe root port and should reside under the pcieport0 node.

Also rename perst-gpios to reset-gpios to match the expected property name
in the PCIe port node.

Fixes: 141714e163bb ("arm64: dts: qcom: sm8750-mtp: Add WiFi and Bluetooth")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f3c03faee02fc282fbe4bba9b0a0f..45b5f758156700bf916c4122c93092c68488c1aa 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -960,9 +960,6 @@ &pon_resin {
 };
 
 &pcie0 {
-	wake-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
-	perst-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
-
 	pinctrl-0 = <&pcie0_default_state>;
 	pinctrl-names = "default";
 
@@ -977,6 +974,9 @@ &pcie0_phy {
 };
 
 &pcieport0 {
+	wake-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
+
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;

---
base-commit: 0b8b9fa6c35e090950da1d2fcf5ab29b74cead1d
change-id: 20251008-sm8750-c50b8421e801

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


