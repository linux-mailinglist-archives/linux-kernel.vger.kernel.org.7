Return-Path: <linux-kernel+bounces-831498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF68B9CD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62757AA88C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C018C332;
	Thu, 25 Sep 2025 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fWoTjdib"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFF136E3F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759456; cv=none; b=E/EPsPA++mPI8cL8bI6F+nWsbeNM+dR62XMwXGQlSpZiTjvAJtlc58T9WLRxMS2QL7aKhnYG+w/epozQPc0RGMrAc+B26/1XZYmrtFgOAvpbK9aU+ITwJmGiI5JdLF4+MJTgW7rcAJwHPdWTmBlofu5v/4WiZ5WJjplSr3l3jHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759456; c=relaxed/simple;
	bh=CD+1t7VjadwylddGJH0VCDFEMrl4ppThYBGWLrYy6dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJCHjMAMBi4/JqT8rEEFCGQRfkvsvOj8fTZr0SsxmlkC3J/Ty3/Z2sqpmxHxEGlz0jwGf6HHZCsEh0BZnVcOx48TvUZZyav8ScQtOAXCxTyu9EA8V58Ozz/Gy+2S1YFagmdCGW5DHQQGpDYTcIxXzwKOmStJdzFdnHx/+Bqz8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fWoTjdib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P01Vhu021483
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nU5YioCkodtgHvtkt3RuERPvJ8NSz/k3anxpiiEJffY=; b=fWoTjdibtcx8nd0G
	nXFIZB8M9teVy96vvLxE3Qyqo839FWxJ+ZIt9ndWQFBe5cym9JY09cgEhY5mvAiR
	0fckoVuABf8Frs0bJZVk/FDzYKKXXTE2yOQop1L07D/WIcg5pPL4dfTXIAxBM+AX
	kGcWVG76qwFuQxYtX6GfAChKEoxBQuKly2uzpHNUp4uid8rdHRVHJn0FCUdS8Qn3
	CxJFu8f9oLILq65MY7nE/raPlqrn5mx0TmsPrfKeXNyjU1ToJUgKaa6eZqIGsQFq
	EDAGB7GFsUTYIBnqQzpaWe4tGfPdeyAnovKD1xPkvD3nVgeuod40zvmh6zDtrLQo
	nkVYLA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadpt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77e5a77a25aso538727b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759452; x=1759364252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU5YioCkodtgHvtkt3RuERPvJ8NSz/k3anxpiiEJffY=;
        b=HPo4Lhsaf32iCHoLCxxTkjysIDMH591VGbMu/i6YHOpEQCTcZBfeOijgVJwlOIyz5A
         ClS5n9MmRb2ZzPWcqc+VSpOE1kgqdeOgJ3WKyPe1bP56sUAZrqj8W/r1e0jVZNMuAqvO
         fPL0saZZENaB4rJqOL/JmUIJRMOwzZl6fWsnOo5zmTpKSlaIv0GlfOXnpN3Ca4RlKJXn
         N07D+oRs0ClI0+O2Nf2pjYvCV+yZyHQ0/EqICO1V1ub9FiGRZR+pNK5zMRBMBQdEihu2
         GRjYYtf08YB0aqaxl/g5/ADu8/gfX/I+gT9goZKFxd8NGo6xjCqOwlSJc4nybWXmWHWi
         GPlA==
X-Forwarded-Encrypted: i=1; AJvYcCWM/851PfvZYHwlFm+BRhbxQkCZ/doMs7QsAjoJhfbDyd8ny4aJyrwxo2ou50RTLbB6LKtBHtyAmocfCM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJHkTekyIMyLsc3OIlHHgUd3O5xJPahgJdW/57DAu/lFIS+5A
	ryPRE8DSsJ4vr32u8czolbUIZo2Kg4zGo9UpsLmWv46qQRMiOEVtZWzWqqAa/dziyg7pVLgk1hV
	XO7+N8y2WMdshqjuPp4J0yEjeu+AaGZYp+pXH6MS91VZPlU6ss5ta1wM+nGy+DCtyJjE=
X-Gm-Gg: ASbGnculRC6WCn25JPcdOZFEa7svncLjqV/Tdw/+TJPfaWpSPT3yujnc1DkJ6w8bjaM
	4okKRlDYGIi+FGWJOVejTiXTUqinotazbhy6K+Mb1fksGXbNZGHbqtk0yte3+yDebk4a4gvyFEc
	lC1xYjhytvz6hASGGbJ9rRQQSCscylkwET0Vri1Am6YZo99Kmcb7ZNCf59+0m8iyVlrPbxT1lKl
	JITMbYzbBW//Sl2QdOxEW2HhABoX0vfbRo7uwR57DGvFdHcSFdIaxDXSy8NJcscLHsmO97ozMcd
	zptI0nPVxyM/DFOip1BsyTrkR1qfmOY7qRZUksLlR65S1Juyeke41aSiI3kp21eubv/Ma0PZTNi
	Y87qfK7d2ZKAWK3w=
X-Received: by 2002:a05:6a00:1acf:b0:77e:81fb:709d with SMTP id d2e1a72fcca58-780fce9ed1emr1694438b3a.16.1758759452158;
        Wed, 24 Sep 2025 17:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCmnC6D9ub8La7o73W6rswraBVe5NAYIjSRFJAf8tJOpz+cXdZ3JTyqDPDyYMWBgKksUL+sw==
X-Received: by 2002:a05:6a00:1acf:b0:77e:81fb:709d with SMTP id d2e1a72fcca58-780fce9ed1emr1694403b3a.16.1758759451636;
        Wed, 24 Sep 2025 17:17:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:18 -0700
Subject: [PATCH 01/20] dt-bindings: arm: qcom: Document Kaanapali SoC and
 its reference boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-1-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=903;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=CD+1t7VjadwylddGJH0VCDFEMrl4ppThYBGWLrYy6dw=;
 b=GuSRx/ozZ/Ihssh4Bfgjn1sIS6Uwjt7Wp6oR1Ivkie4ZHTS6QdQbw36+FWA4AYwykUCnZFsdI
 T840aEw1GOsBKkNONJpSELvKTwpf+7idCW9qGGc3dBtU0SxDEd1fCQd
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: _EfnihWWrE6bmTNhil_RzrXUU8rT99W6
X-Proofpoint-ORIG-GUID: _EfnihWWrE6bmTNhil_RzrXUU8rT99W6
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d48a1d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-z8ZePDt8oiYOmukcGMA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX/OJ7/EF5nTLA
 IfzW0Bxap8k5Hu/6c1w0yxhwPa/+g30sL9g8e0JnKaz9KAJswNONcjmJBBLnU30pPHgm75vkMSi
 lkmi22At+xtuPh8hOV9I1IbvojhV2pLfiDkrg5wsKR7hZKKnJeWGGHCUpPkpvejKfbaBaEf2HUE
 PcRdbqPsj93z403sk8GUyQCyw07A/4uxoZyfZNwMW/FIr09V8wUhZcFJoIzoB2EXrPrCH/vE3ZA
 DgP11pwy7iwd79j58u7ljLRNrNmr7YIWSB+n9f4Lbnn+ebCFkmU/kenhSHyIrJBzybv2iX+c/Vy
 evRr7P4o2sCZVDLzDP+NZyYoXIp3NebAdDMZl5zTJB16cZ/Orosrv6HUCRv4qkv+gH3o/OWfdtt
 42ppUyKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

Document the Kaanapali SoC binding and the boards which use it.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 838e3d4bb24a..0e84220e835c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -321,6 +321,12 @@ properties:
               - qcom,ipq9574-ap-al02-c9
           - const: qcom,ipq9574
 
+      - items:
+          - enum:
+              - qcom,kaanapali-mtp
+              - qcom,kaanapali-qrd
+          - const: qcom,kaanapali
+
       - description: Sierra Wireless MangOH Green with WP8548 Module
         items:
           - const: swir,mangoh-green-wp8548

-- 
2.25.1


