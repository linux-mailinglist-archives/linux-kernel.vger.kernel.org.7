Return-Path: <linux-kernel+bounces-789246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68682B392B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223D87AF38A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED3269B01;
	Thu, 28 Aug 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OMb/CLOe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC147266B6C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356623; cv=none; b=t/IL+AiJE/yxaXJRITrkbzOjuQudSmLT26Lo1WdsskxLqcbGRaD0u9IRBXKom2ULlPVJTgSTdBABCvEdHD/QFBn70Lxv7/eSxT8KE5nmfjQo6Uob1QjI3XP2/lNosuPyvzK94C/08F5Dch+orQaa5wGoMQW2f5MBoI9N6sDRtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356623; c=relaxed/simple;
	bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjlLeAkoZy5k6soQdcy7zbzvSPnubjaN8+ifHR+PAXsXaHQuO4FhrZLHLpEDHTvSTL7zOp84M+v8YEGnj0kwYbD6uPyi/2TPlHEPa41O28BU606nCd0SnzohQhYsNgzGmYuydggnL3oD56YLfgKVKR7fjoGcaZKdsgg4Pz56l6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMb/CLOe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RG79u2031479
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=; b=OMb/CLOeXxsCkRQ5
	21C7NeYcs4c4kEs6zDOsBXUZOq8+7HSCHi9Klva7mjSzhGnOLNhX4mwPRk2aRLxh
	8Sj7O/Yba4aHnTdUG/lxISLhflktpexHBJlE2hKJMtFUMUS5QeTe+bA0jS7XyaYv
	2Euw/VV8CzG7eEGscDfrhhqhhdrHnH8weUUYinIvE5DcGhp4C1BLDEf5bvcsWPoM
	QCLeH9rpicPMiYKYkTzaft49cCTtIqW+Pz2W+ezNQ5K5NnK1wAtZPFKzfZaLe+uO
	FNbJBqUJUavcGKE6LDbTljD4qnUi9E0kZpjfk7QeyhCCISnY/ubQvkZb5di/f9Wb
	xcb6xw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpy4ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:50:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7720f231103so599243b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756356619; x=1756961419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=;
        b=XpVJdiGOj5WWaV+n9hzCgyN9ypU+J6NHn0AZNtC2gob1V6WL2ng5+bNDoHPXo4jZOy
         yPV+BL9+3sPDQ7EXczAtcwsR/TMf3gxbFVCC9ZcUFFQLOqd+QMmDigQeWylsXuZspeAp
         FKK28s05wABfx1MyAAMI6NIs8NtZySnIh5EdA7SzBofK9JKvtYdnS06SYSA/Xn8mEzrU
         jfle9fnVfdl2dkpsMecRpqfBxJFEYAkH9kp3Oh7svbtDHsJ5bFuaqeMDZ+zesrjH6U7l
         Y4CydwNlwBgehLqrtGOIe46pDgt1a2b2f55l8qTSUnCz+TRFSGP956at+YPrewXj0EHN
         87Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW+2HugMEkP7nDkfy9YFz8w88RkXEZFcKFD4SZIFQrsTZ8cljlq0sQoBeWnw9Wi/dft5+Xap3VkrjEKBFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOodmc9zmdPOYbq5yfSpDbnnitcfQdl8lKAgR6sXMMYWNTHid
	pajP08bP/4tDWqF7b++UkQOob4i7zX2FGTHEtHAHw4EKqWKbNUVywgIt8CPdQ257Tkmi+Vg5pAy
	K3/DikrzEjECgZK3LkcVORcQZb4fC6ATD0Vs8ApRWmXXY7JdEOA5+zDNZxZiiRwLdTbc=
X-Gm-Gg: ASbGncv8q5L/vEsvrxgdU7z8r1u+/JvOwI3vW1Ov1TqkmW9xYm4Lmxp1Jnd7q7ihEBu
	EEq561sJIoiGT4pwNT+2udjb0+CZAiVUoTKJRZec33uowTz7bA2HXtui5LA079sNyml8Fl6nmXa
	koK/iqehqbMfvfCMbow+3XYP1//qPJwxl6R1z8hzup9F+/hfZAKOO2Yx3wGByosoKyILtQ4ncoe
	WbIsj0bAezKntQkEjZXMw3nSgcbV6oYajkO48M7zcke5aH/H5JydH6fclpdADXxrLos+I+l0BUQ
	JQMCwV8lHpvbiIX7U78Fkfz4cKnvzEv8jX5laPzpoEmKyi4O9tREDDdpdxUl2yJ+CpOuS7jAd0u
	uxNjClkRlN2svVMvrQ1YfpsTUq06O3xU/pw==
X-Received: by 2002:a05:6a20:2450:b0:243:b38b:eb8e with SMTP id adf61e73a8af0-243b38beeaemr153784637.49.1756356619083;
        Wed, 27 Aug 2025 21:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIsIeKy5fSUIi8sXFWz5JGR8nHUoOGJKLNVbVoy+Jb7LDobgGaONdb20TwG/V/hYVHruIpRA==
X-Received: by 2002:a05:6a20:2450:b0:243:b38b:eb8e with SMTP id adf61e73a8af0-243b38beeaemr153756637.49.1756356618599;
        Wed, 27 Aug 2025 21:50:18 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab094f00sm986699a91.6.2025.08.27.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:50:18 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 12:48:45 +0800
Subject: [PATCH v8 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-hamoa_initial-v8-1-c9d173072a5c@oss.qualcomm.com>
References: <20250828-hamoa_initial-v8-0-c9d173072a5c@oss.qualcomm.com>
In-Reply-To: <20250828-hamoa_initial-v8-0-c9d173072a5c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756356611; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
 b=N7c+oevrGdfKj/Zk4E4BbRJHiVXqzyQUlC6CYshevs2QpIjo7sqqV0S75SR3Ts9ysuzC3LExQ
 tdQMrpAcG54BpG1WMgAcZRxhgzWir2GZBurYXOR05McWnD1atz5wrdB
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68afe00c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: o-bjm5QkZ90NVSj2KBaczSteMq4obKfw
X-Proofpoint-ORIG-GUID: o-bjm5QkZ90NVSj2KBaczSteMq4obKfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2IQdDSfdxmRV
 P2tWJ2VljYHXe8izYsbu4nEVSkbUC0POPW6afiOkZtmHkcIYcCAttPUsjozOGD9koebEoC4/qn9
 22ggAp0u0jjrnQMLgN7i+sTCZWBIsVWQuLRBgrcR1SRBffkqQ/SoChCfAzO/UfPpbFeAdGIeh7G
 n8AiecOpkL2OhZkKFbDbuTfNo5gd7Zx3ePs6g+zysfizZoGKhl3OUt3DMc5W7VYP7B3ouKGoceI
 wzZwx6+op7fwrBlkGlPAv6OoaDeA+fGYgYPR5n2aKS6PRyuk885bO5fLIFPnv/7XyRwzJUdSsF0
 8htMpK5cImUFlrQIKj74F0HrGnnMO9gz2xXUfi2R+gWZo/uzCBaIPlZ4sVpwTuEAD6NzkI3EIC0
 7H0pQh8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af89..6b6503181ad6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1069,6 +1069,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1


