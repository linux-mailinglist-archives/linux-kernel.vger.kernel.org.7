Return-Path: <linux-kernel+bounces-887637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4193C38C44
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239253B18CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D15224B12;
	Thu,  6 Nov 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTo1IeJf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUJMA4o1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3D24169F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394272; cv=none; b=lO9RwsFBXJqFxDdmKzLVqYAmBq7ze7K5qMDV6u0z53RqUCJrxdOiTqLMAK3pTFKGjf3CtLiW/LPE8JhRSgsoSDKPKbG5GsCvtc0F1HZEHYVKZvXiW8NwCjz4yoGqJnvY2Rd0gSEFBJ55NJp40XvaNh2MUiXAR8sNMleaCGWM5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394272; c=relaxed/simple;
	bh=RRDIkxdP3/Y5/4hhAVkauK6PkEknJbU5v3IcJnyja+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8yCItX1jAKOnt0tlla4+4Gdp1vnSxj8p6t6V4Oq8o2F9UfcjL3wy4LAJwa9Q5YJnnbQmb9+HnZozgar6l2vRT34m8AZRa4CV0iderjKZloalcmkKu3QSjeF3owpo+aOfK6PCgf5TS4YdnuPmn1AeRTKzwQc9gmbfpDJMkP0lvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CTo1IeJf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eUJMA4o1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFDYf1689574
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 01:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=; b=CTo1IeJfVWfYL/3e
	pQ1GLDiqqxubSa1baNWssJp4AULUJazOfJerod6znB9qI/iY3JuqU2MO1dpGTptK
	cWySK03ho5LecERfy7ibBR1P/I4ZLcMrSEf1awGY2Hv8fLYUSclI4j3dMFyzIdnw
	A43Z8YIOIDaMUbGT8oHLTlMlxD6YMB9LZMc5AMp2IMJvEerdgh5JHvbVqjBz/czI
	7aIgj9MzY2nzdO4zZHSpuZtUItc49S4I+pa7u6PtgYPDx2E+onUDEaZ+4Ep2RjnQ
	+akylud4ARpw6STTy6dkIaSxQ/u5UYvVzYWeW9aSoT/xEJIzrNaaiIhJjKsIZFi7
	ehNz0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pj9urk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:57:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2953deecdaeso14589305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762394269; x=1762999069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=;
        b=eUJMA4o1R2RTuQDzDu2OKqhd6m3rWyZWez+GoTVYlCFyPn5f9bkcjwM4mlSdUVgI+E
         pScvlAu+2IoDxpLBRMhRyqw2jbQaRT5eBkviq1MUiRqCdPT8n6IDOULJH/cNILS/CNq6
         oVgS63rojyOevYfmsZ3tdjuPKThsrQI2JJlFYjf+Yh8WDhfaL3w/WbzXhYeifCRPg/i0
         DQT5NMA/YzivIb6hGXF+diuXL36E7fKnn4ApLMZwOuoLYQ+74eoYYAZoOGD6TW3hPpsF
         PCpZlVt33Ze7BSiEU8MHnLZ2cXIYAuv6SzDUzBzok82HFOnUk0USb2LFFJJcwwW92lei
         mAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762394269; x=1762999069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=;
        b=DCeRQl6VyKb2mPvpyR2M4wD/BAHsl0fuELIv8YC+VefOYD0mzF69PEvmzDWfy6D4rT
         nTDRnR0pFBPp549KXfZGOa9up8X4NdWQmy9LH0l6Ep6ZuiYB34RU+C+t8HQpyeXPv4a9
         eMbXBUZNqvJUMh0habkAviA6zuMiwI7SeE/maky5qGnLXpItJiSnvXgUbqBfpjbiS82h
         RtVFRByX/NmZ5U+YQJD57TlAYgjC/EKmx6DYiJ3+J7tIJBd4mggCS/yARS04XTq3PBM5
         inmQSWLglKvUl8fXoGaWXJt/lCD32W0WQLK66OuPj9J+FL1x8+5DFLB+oByysRcflca7
         kVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWFV+O9gYw5r5ALyBbBnu1K0csG0jlnGtX+VP63NVrnIwtMakuExYRm8y+Lzv9vG82JRNCcE/WdvJJQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLU7ZIoywW/ZzXYC4nsotirksMBX+forKmEBaHz0KYEcxpGvv+
	jhfea6DDJeaPdRplrHzTNBTd7uZxNQNvssLHtNBNHUJXGUo+7ACUI+kSVRzblX13ZML0M9408UI
	LQFZ3rsE1Ie4YI0Ec24R0sT/IBQdyVbYoEQISq0wHpsjC6vh+T28ORW45sIneNS2dOxj6UNPjlH
	aLGA==
X-Gm-Gg: ASbGncsfpA6HW+p5Xw1etrouKrE+ySEIldKVmsgEvKjVZ4PfLWTWQ9R9k4yZK9UbZkJ
	DaxaC146EnnR607p9fJ7ODraFd4TsRk1/mDYKOXIMaWg5CfXULIMhU68XBih1z5r51JMrnm9qF5
	S9XlMusz4SYco8hNUlhG3CEpBVfPTWb5TiT0nf93k2LTgPGQ2c6k3Fscd9WWOP/srvk5r+euXiq
	GrD1HAEvD2aVuJl3PjmC4LillW/tcnim+oEmT/mKFs7z7fVDMmcBbv8edzL3qiTCCB6clKluXOp
	HSyOyWchCqSy/CSuCyyZ8yeA+0oYxz4OuP9KNZSVmjW2Pf+1iHsYely8Yv1axik+P1y34yR3pDp
	b1iVj+8+JYJpaDSFaDxowHGYKguw607Y/0fYWypJfIjQ70DxB/yXkqdB0t/cpKQ==
X-Received: by 2002:a17:903:2ecd:b0:294:9813:4512 with SMTP id d9443c01a7336-2962ad0c69cmr84799215ad.3.1762394269446;
        Wed, 05 Nov 2025 17:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEad9eTk1wDBEBRbA/9d4rvxsP6hrAqaaoyQaLkrSKmxzgcL8VlZOUxv0noG5mAp+OzbSzGEA==
X-Received: by 2002:a17:903:2ecd:b0:294:9813:4512 with SMTP id d9443c01a7336-2962ad0c69cmr84798795ad.3.1762394268826;
        Wed, 05 Nov 2025 17:57:48 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93e5dsm9115725ad.81.2025.11.05.17.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:57:48 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 09:57:25 +0800
Subject: [PATCH v2 1/2] dt-binding: arm: add CTCU device for hamoa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-enable-etr-and-ctcu-for-hamoa-v2-1-cdb3a18753aa@oss.qualcomm.com>
References: <20251106-enable-etr-and-ctcu-for-hamoa-v2-0-cdb3a18753aa@oss.qualcomm.com>
In-Reply-To: <20251106-enable-etr-and-ctcu-for-hamoa-v2-0-cdb3a18753aa@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762394259; l=810;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=RRDIkxdP3/Y5/4hhAVkauK6PkEknJbU5v3IcJnyja+Y=;
 b=b+jg9yIcubqqfZIx2HeucxfIf5o1xDhfJ8DsBfAWnF0jp5PejL45b8VoS5Mmixa19l5Sd7XL9
 uK3HnQX0Oa6C/oZv5ahpyUKZqxrSoK8KfjPkguP+asQtpvxdNWl6nS+
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: zWiuH_LZYjjyGv8nTUed9F_WVfrUD08G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNSBTYWx0ZWRfX08QobFvP2ovH
 zANJFS0faoxjd7y3utXmkJYY3pWV8BpKQzfu+2TVq4vfr4Y9dkWBDSvdrd+FTeSDHn9w9WlYgzy
 M3+l0W8ygtC5Hzj6VB+xJQZdd7+oz8AMMC893Gt5fMpTuth6VRGZ4QhwNqhfgb5g6LDqq3fe/qO
 MtF6Ip1bpuhfIKzJ0lz6k/eirv98KOLaBBuy1MBCJeWD3+P+kIb/kz//FRouZUujbaby2m09rcO
 kZUm1+eGNtqPWy7Voh6dw9NS3f1F5nnv9AYwcWdx+rd3n5Y7iLeJwRNJ7KxJ0njEfjXyrg2EctD
 8Yc+04BalriFbd2y/pRn6emVIjVb/bll/0lBP4Lb4yIhiVl3wZ7mhV5KcnWoz98r4SN5fkKM8CP
 zT3gO6rSkXPyhora2euTcxeEoRhUCw==
X-Proofpoint-ORIG-GUID: zWiuH_LZYjjyGv8nTUed9F_WVfrUD08G
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690c009e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AruyFUP6G_q06T9m-PEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060015

Document the CTCU compatible for Hamoa, enabling support for the
CTCU device on the Hamoa platform.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index 460f38ddbd73..57dede7a90e9 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -29,6 +29,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,hamoa-ctcu
               - qcom,qcs8300-ctcu
           - const: qcom,sa8775p-ctcu
       - enum:

-- 
2.34.1


