Return-Path: <linux-kernel+bounces-875400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C7C18E71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508B61C82673
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E43319857;
	Wed, 29 Oct 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C89gTu6R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OhHDVnkR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43E31691C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725159; cv=none; b=rTj48MsC73MpYzHmSKpHgR5iwbyXfYmQonbCvAViT3a2lqDr//Hd8b/BhiLPXoj9i7GvYD7RAnCq6q1b0nOZnF21+2esgnmMoCmL/mEnihMn5647JfsjWjn8Xoqs6Osce42k7D+a4bNVBPYuy/MrWAp8diLv0tPVEUr7JQYcG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725159; c=relaxed/simple;
	bh=lHEUneC8ZRFILfNpU6bdJg56I1ugvFyyWle4SHV6vRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcBPrchZe7WCWq3Gwm2oqqPT0mY7kqkltPC+sgGMxUQxkmsOL56gJkPwWeB5uC45LTghWyd1DqOclRAms0CLjP+LQeTBrVZx9zSmy4WjlS8V86AE4zVVTJZyOKd/j+SAhJZiO1lGgkQ2Ku29nxh2XyDdjywh6a07BY3Rh/FvEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C89gTu6R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OhHDVnkR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4utGn3692128
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofFGdSp31WO2sezoGGdCs4u+anOTrI9jfL6DeUVdYjk=; b=C89gTu6RsSLWPS77
	0rupFkGUaZID0MJ04Ex9X06Pfbl1DliJyHpXRJWM1+41ymoCEIxvkE36ABhpL22J
	Yuw7PhJg3RTqeki4qddbP40XpAZdmYqXX3lwuscIVJvwAqptpgEiNdCX5XAdHUvM
	Oirg1ARVEklCqvEDiamT/HZkpi2vneP1Qq8sAYagYQ+NaCw0CNbXlM8V6J+isc+n
	+bQzHR+Mz9nJ7fFScB03cPL4HaHBV2N2i5ffXE9hwSHQCKI3+G7QegEdmrqrdFK9
	oRz/hY4Uirhh+Pyb3Y4HD2vJAaDLR/7v+cCLDs2ehpTxWcC8iOI++KlVVTt48+f8
	BkuuQw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2hpxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294a938fa37so83744565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725155; x=1762329955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofFGdSp31WO2sezoGGdCs4u+anOTrI9jfL6DeUVdYjk=;
        b=OhHDVnkRSI3XCryVQxShTKuj8DWKeZmZC6/wY5Azwlg9mahsBZLot4LDFKIvgQx4gP
         P+TdgKpWL+7vyT1l0THDs0GG4XrN5IUKZxOVp/pNN+N9WzEFtPHQ/fE8gCeAX4Be0uM/
         kJ1irPR+Qx7uvF4EoPYM7hVrkCMpfMFml7gdytP0tD5YkxevQighbWgSrq/qNGEMU9o0
         PTe7jmzhryBUBrEZW9lBgGfoK51YkxZ1gXpJva71xhOmlf6K4bPE19IyiVIg5rCku0d0
         f7mW9Tg5p+S4x3StY0o4Zl2KYER9BMS6LgxRMCtbkn7HdalXQhoIqS/HEmClcpdnnWr/
         PMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725155; x=1762329955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofFGdSp31WO2sezoGGdCs4u+anOTrI9jfL6DeUVdYjk=;
        b=G1P1rmKGRCVHocFd9tSv37ON9GMcPY5r6ECPAlDuyh67QeQiYFGmbQAKdXL+TLK1ui
         s+liFWyarXjSpZc98qZijd6n40SQIH8vVhZn8tUDncn/ME658apM82rzlAuZ+K0iPO8i
         uZDef4wKX2mRQkZCjwATLlOFSvWUejZo2tIXRAGHWi7fMoZRSFibhrz1zcnstdQmpjCv
         qtlsK1uHneRji8PCZdIVu9lgMiXctfJk2i16JGtNmMaeQvIUVqZGwCd80cG+wfp8zuEH
         34wQyXtyjCRqc8izJj7Rb89feBKrAGWXUdMtvyB49KovoyzRzpHASdTnWa3FwJVxazOX
         TZAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsgnIXZQfZSXjstBJjDhNmx3uhyO1zOOTOaJAhVt+t/p4S7PGvuu+/C5VoYA90Jgbpmp8giZLziK12IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbkUVofNUGG/K8wuGRiQfL/lrYOOre3A5X2rZFWxx2/13LdH9
	14aoC4qu+NFO7Q+gckqXK3ptnmpRqptl1kqqcv7fYYDKgXHJPKPU61yk4xXLM3wf08Z1E7uOXNY
	8T5Nlyrp/Gbh0WTcvNFrOoYwcqIWGRKVUpJWZ/OfCBNyRkb2oPxwg5S1C10+4q/MGVMI=
X-Gm-Gg: ASbGncsGO9ekL2OrTZNWGr2u+KlnVFRIl5FmkUJhf/MK3so2CRtLpQv+Ctw2BEC3r+v
	D8HB8Mu0E7SyDp4bHxnPmJVYDkWa7KUL92HHQx54jirHs9aEHxXX4FLZ55s18SFNNmlmJdqF/YQ
	UQlnLB/BbfW49W6QIJU16WmGQYSC7PVXNXVAmk8e/ub6ciNmdoJpPtkHu54y5lzoBOKpGeF1p8P
	iozLmnyqbHXUTOHFYar9892g1pEZH66b6xBZpJz9HMBaRhgu/yCDOY4E8aVysxwbFbZNikvgeT6
	DPIViUnr7b4/0U1HqaytdHwhGx0V6nAcTAGRbHkd0zKgA2cNOzi6ZLdt+ARFo59F06uCbWPrjD7
	lifnE0RE+ngORk0faTNiysRoITETMU4SJaNmBGaKpVT/KLT++rA==
X-Received: by 2002:a17:903:f76:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-294def30ed5mr17205235ad.50.1761725154745;
        Wed, 29 Oct 2025 01:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0sQ6XdTFb2LBlKCQ/zHj45O0tHgxtuQUKM32YYiyj+0jGQytHyGDZXzy58NbJ4DNT3kWVWQ==
X-Received: by 2002:a17:903:f76:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-294def30ed5mr17204935ad.50.1761725154150;
        Wed, 29 Oct 2025 01:05:54 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:53 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:05:45 -0700
Subject: [PATCH v2 7/7] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 Glymur CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-remoteproc-v2-7-6c81993b52ea@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=1548;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=eYKPFpa37xMNWR6oEwup8N8ConVWUukUmzw5FoOa2kE=;
 b=AvoX10IlqCOMl7HP84G4AyH1pNYxj9zO1ddYq4rGSLndb0DlsH6L5kcMxVv8CeSO8/DprCGRy
 IZnVfnKBgdKAQ995OIdqn8MPVmj2ZBqsHEggTNOuDQ+NnZB2chDwwAD
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: M5AeeBNZyAlUt5l4g9YFN3xQzkmHSyX1
X-Proofpoint-ORIG-GUID: M5AeeBNZyAlUt5l4g9YFN3xQzkmHSyX1
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901cae3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3YzqomBvCdNxOiMskVAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OCBTYWx0ZWRfX8moKo89DscpH
 Yeo5lfLwAv2YSuIz7zbyWI6zyDqdld7NCLCL+jOIWx4EuM4HPr749EOo4XZRBiqlYMGJilEmJ5E
 W9Pea5oXIcW6+sl2eMyFOwHFIr8gj6Llc4UPCCIos3SMiBTC3hvis0XD2JALXh9QkE3raEXOU2T
 QXBIJwe9dOgF5vRJV+CCFnrazktIjTJzEJDBZ+71XkaGbxrFbN+MShCbFCZP8RwP+An/dj6Yh5f
 x2oBwYB5KPNVAKX1PBesQ8lN036eryE9PhlkVPWVFkjv6MDldmiLm73I0jdpd+ZOOfrsToLIsoh
 YWGYReVsxw/e0ezzlGnTlKqHlY8Q52YDM0qWaa18TTuC6hLc07mk5ZPeL7ntswzw4ncMQQoCSZq
 xru6pJFAn7wgaNsqL8+KzznFj3VMog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290058

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Document compatible for Qualcomm Glymur SoC CDSP which is fully compatible
with Kaanapali CDSP. Also with the Linux Host running on EL2, the
remoteprocs need to be hypervisor independent, the iommu property is
mandatory to ensure proper functionality.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 8cb839ba1058..117150cebffa 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -38,6 +38,7 @@ properties:
           - const: qcom,sm8650-cdsp-pas
       - items:
           - enum:
+              - qcom,glymur-cdsp-pas
               - qcom,kaanapali-cdsp-pas
           - const: qcom,sm8550-cdsp-pas
 
@@ -103,6 +104,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-adsp-pas
+              - qcom,glymur-cdsp-pas
               - qcom,kaanapali-adsp-pas
               - qcom,kaanapali-cdsp-pas
               - qcom,sm8750-adsp-pas
@@ -255,6 +257,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-adsp-pas
+              - qcom,glymur-cdsp-pas
     then:
       properties:
         iommus:

-- 
2.25.1


