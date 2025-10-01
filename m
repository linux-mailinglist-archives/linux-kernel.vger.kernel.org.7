Return-Path: <linux-kernel+bounces-839568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C377BB1EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503842A530C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE031283D;
	Wed,  1 Oct 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwPLdRDZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A515311C2D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356344; cv=none; b=CnoLOpAkagCvag1HKUMOimrr5VdNMbDB4QxiYyRteXH9y53mv7/xas6pCrRUwf8E9wj7CCISaqMgGLP0UerWHC/TaeVpEgJv0a69It4EYAm3o0dXpvw9ysEDJiAZYNs1EvDMYq1z13ZV5JscdJP71sdxGOsIMJeOrJEvYk0zx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356344; c=relaxed/simple;
	bh=cfM3s21T8CQ3sOfi9Dc1sx2mJ27UuKxMJmEc0kjDpws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcIpyyOizNk1mdwyae8HrBkJ2YdgABEM24TGBgbpBfqlEEZb2f7wSYWNXMYloYecqmq3ffFawwcxhQ5KC2Msn3BnM3y+n1FXv4Pey9Frr5hfWKz1sYM1wqU0UjW8aV3K7GmS3TzM67M+2WTE0UIjKOyrIjD6DIp+f0U1ZZ6HPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwPLdRDZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibubh018672
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YaQd3cF9DM3
	ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=; b=VwPLdRDZx8FXXZy/LdNwLw7sWso
	nNXohyNnyerO+pbHcfUtgzYc47FUOfVpoQQwyGk+uECmqtttjLCxfaQnfcuiMKy3
	COPDcecXaKKtbiRMxxTaa/NKEJDeeUj7X9rodNSdC09vJFbV18sQWiHgGRmTu4RR
	Y5IeOAYXUy9XZO9qAkUwZzYEQMHnI/DQOTt1aRtQSLurRyeU5HC8OhqfJhybPEbg
	emV7DosVkILOfae0zWqIBZQE8tOfTQqI2Qa0xQ5uZGBLA4bVgYwZvYdoda5haBrW
	tzuMNTj30oAma1cX0li8t2rht8QpPYfu6sz0qZNLTT7Hb679cAqJekVCgmQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1a9we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so4978545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356342; x=1759961142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaQd3cF9DM3ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=;
        b=rJ/GlTEPdmlsvj2TJD9wosj4tfLoVrc+hjSw4Ya8T5btSaky7kDwgjSfd8jcEHcaty
         GZi8jzaCG7JNDFVaKvtRiw8jP4mVdvqr0NFLdqnnLAtHhVysYxkTuObU8sCC3hd1Re7A
         uJ/I46+Osv1nMNgk05lQok/kfXclGFZgLvISIPi7I13A5sBo1B43q6j0PQ4Jyvuvveg5
         6T/eica/m4Mn74whVgeDa/tQZnqDH4ZlOmRaxSw8zvZkqrzX0wnDvETSf2MRVSP87XL1
         YTSl+pcrI96PMrAP0YdV8IueZwi/uEy8GvdRMz4ZWD19lKJlZQr+s2MNsUUVM/59oJGH
         oXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvDzfhjW5Fx0FYnq71W37r7T2MHNd7XGJt9OZbOMOPTVqhM0F+yPGQCB/nuh02gKuWE3RvOJoi1bbu5uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87KiK7RsjujUvldYhsYOaoKVw3hGsf19qTdqLNvAm2kBOvfvj
	TZ1U9nCD59BMDRTMmmjyTJUZ9bLDDNPIcNjv7yugig+zFBEJ1b4LSxpze0aHEkmahUQ5NPt0vwh
	cGwfcuhw6YSAreCTlPm8qXK0Ep/mVLFKyQE81VOVEM1l+kXT0k+L0CcKweFIyzewcFuE=
X-Gm-Gg: ASbGncvbVIszOa6IekVNuJ8h0ufpdblExHRp8CMrKYVhvggcGXOBENWAPGmsGlD2LGT
	ihKtbSEdd40k3sntG15f2QkMXSVXYL6v+wUPzxSl9wtYaayZiQX/JWxQAdvwVQAROtq0lOkC54c
	6RDvqacSsVjcU8Cs6UkQzOByyxQAPAmabmr6QLfr92INcTech+XPDoePZPoOb9LlzA7HvWhNCfl
	0cvqk85qYBkdVBk1BG3RPeIpSlCd74oLvM6+1CinK9PVidlklyq3LPdngdGRF7Z4WMwym77sH7q
	CgXzT9G+TOucZZDmTXyG4HjdN4X7naHdMiqyYsBcNuZw/R+vQKj7ft0AAfiUk5k/oDQHOZUR501
	ZQgcggXdBl6r8LRieFOHfeg==
X-Received: by 2002:a17:903:144e:b0:27d:69de:edd3 with SMTP id d9443c01a7336-28e7f2a2aa3mr55519285ad.20.1759356341904;
        Wed, 01 Oct 2025 15:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfcBhsPzH4uOaOTsLowdy78HnwI16bUIuuSFnXJDMrE5c2ZqQJDOV6y9FJ6jkCyNo9Jw2ddQ==
X-Received: by 2002:a17:903:144e:b0:27d:69de:edd3 with SMTP id d9443c01a7336-28e7f2a2aa3mr55519015ad.20.1759356341468;
        Wed, 01 Oct 2025 15:05:41 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:40 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 03/10] dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
Date: Wed,  1 Oct 2025 15:05:27 -0700
Message-Id: <20251001220534.3166401-4-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68dda5b6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=dJG6SERxbJy7wEyxA2sA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Q8nVr60rbathqnvvD67bAUO03t_WqU0F
X-Proofpoint-GUID: Q8nVr60rbathqnvvD67bAUO03t_WqU0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX+4B4a425inIw
 MwEGbp2jNyQye8TLbhXlFOVYb5jKqdfIn+0x9IGu787nPvWTIXMCeaF1RPVzUpQuULmWQ4bxe61
 AqeR5MHEPZkgUrymtOb5RQlwousB/3Ca2w40LxCZ752TeoT3yvpBttNXKhLWmFMWVy72+yaGs1t
 p9nL6Gcg8xcPWmkKoPOybOX+nDO2kPyz0iUlFLoKkuKFy6Hl+qDuj62kz8LGiYFsf2OKzs33h9L
 QUSJW1k8BEyzcb2so/90bYCX/7VK2eVpgdRS5Hgsx60+FCuD60UArzez4EPtSO+eFEzAUFt6jzZ
 xCzTaj6F2tbCl7YE5ABhKTtBnxwAfdhlnK+kM7ZQL9MRcyOon7UaEywdmQgxEZUb/2vWF6sor7m
 RbpskXGciyTuREvOdFAP9+LZZzlUJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

Add the Glymur compatible to the M31 eUSB2 PHY, and use the SM8750 as
the fallback.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/phy/qcom,m31-eusb2-phy.yaml      | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
index c84c62d0e8cb..0d5db71e0ad8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
@@ -15,9 +15,12 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,sm8750-m31-eusb2-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-m31-eusb2-phy
+          - const: qcom,sm8750-m31-eusb2-phy
+      - const: qcom,sm8750-m31-eusb2-phy
 
   reg:
     maxItems: 1
@@ -53,12 +56,20 @@ required:
   - compatible
   - reg
   - "#phy-cells"
-  - clocks
-  - clock-names
   - resets
   - vdd-supply
   - vdda12-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8750-m31-eusb2-phy
+    then:
+      required:
+        - clocks
+        - clock-names
+
 additionalProperties: false
 
 examples:

