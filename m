Return-Path: <linux-kernel+bounces-831831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11AB9DA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1704C16D6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAE2EACEF;
	Thu, 25 Sep 2025 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S30mFOZ5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE772E9EBE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782007; cv=none; b=QyvDIff3z2MO20ap7QcLnQCmNNSh9f1XCENjSYV4ARpeDeYiO0Z2XlsnleRhEcKOREKe6N5T+o0CCKS+QRjsD9NtGLkNdZ9gKCsW5Gpva4e5PXK01kVFKje6fnMiHNLA+7ua819zpIigAdokmYWW5NSQGpSZCbLbZEFOaqqDS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782007; c=relaxed/simple;
	bh=PmOpw/EYlFkARbCMNbiM/N6wPtAmStKVwZu0bN0uBRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7dDoeCiB/r6gMqFouAkn5GcV/5vrnba3KbbpwV04hhkRVCev5BxUz6XyizFi5ea227T9/wJAVrPWJjJSKHji17IElK9CVMyNO3a7ROdE/CQMe5xzzQtreyEcYeoytGy7YM19cVUHA2tnmLuwOHAvdvSp1WQqRk9L558OU0KBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S30mFOZ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aNuY027602
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	syumanWrZUjcI1O0TLXpaU3G8S6LULiW8Zo6+Nj/zZI=; b=S30mFOZ5lBppECRy
	+o52cfbcpC0Benzf0gaJwshuBiIWMbCxEsipRn0fqfV+iYcw4IquAiQ32I4RnXrG
	2mYfjjKIvOGAzF9T3KSOepHicvtuv6B7rdohC4KlpIkjSwNNcSrAzKuJsJrYr9bh
	0TI5ovuUF7n3UCUom2HebnPxnKCI6c6o3kfVnl8ts6JRl4K4IE59LyCYdZpi6UXY
	NjM8ZDqHSHF6jpDN5VE15RHtxYylNbY69LJac/iKzBEz63+TeB5J3VqoBYx4TVhL
	76OTyaGdluNrmbs7rANrIdD7RojB/1N0pspjZ5kkw3JTw0O1D9U+E3mfG/YQ2Gzq
	cMUYgw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697c4e7354so16546275ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782004; x=1759386804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syumanWrZUjcI1O0TLXpaU3G8S6LULiW8Zo6+Nj/zZI=;
        b=jsa4RgLo+i2S1kCXiVJEfGnz6X4mZeY46SSOUt8iWPt99e2b+aDcU4j+J/koGovcB6
         d88QK2zEloSkMN1U0L3OVT2d1IpHpA7VsRduJW+ksH5qq9eXnEvk4peAuTgSi/7yOBFb
         HWFyrhU9q3M2BNjLu2rkc6oN8A6AaCfGhhMEKGNiVp62Pf65ikmiJpTJRfNY3JS6zY6h
         WcCONx0olS7oSC7f/VqRY2cnJinjcxwrUR7azkED0LLBKl+7OzMzqqfJuXvUt6AFrGfc
         ogA+np3RQ98F0MCakS7J1bUEqSNEI7WDlafkDfDpHbLREflayC7ln2tA/7QVW8vXtA3I
         zLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUzuCvpwDcMa3V1ouKz9FqtovE5KxIerhmQNyWNhXHH/lBJKY8wqXProMVgiADorczReiFrMVjowL18V08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHf1WrJJlYhTJTfQez6KUwau3ZJLdjo4DdBYp3H6Oykk8paHSZ
	Ul8n+Pvp6De3To84aS2qfT/0owxXpt+rz5dV8lBLv54yCzi1OvCXGn7LU1UIuAE/c6/vl0qtgVU
	yldrvYXsF7oHAej3vlBQKbjrr9lzIzkS6880omt6lhb4Kxf+JPBYWkM3FNZIJE4PeaSg=
X-Gm-Gg: ASbGnctZRiwK9cGdiXETeRmGrc742q1IrELtz8NzlOfPhc1iZez/KMBvgVTmXfPqx5S
	Aine8aTqhtNrg54FFXkeJPS6GI5kIysB8fUPznjnIs3aUktRMRsNnCkFFz+P6xs4eT4bMbs8X5M
	/pVTYwnIo2/s3AjDmIx4YK46F9H0mxVPVBf+YRNG5/ZH9YKWE+uVwvBiAxVY9L2TIZY+cnrRw78
	FV7ox95xFKDELODXw5zteYJuvxXBcYbmi6snCxZlPVplyRXIdA2TfxchQoBC1UFT+KxKYI557Ht
	l9T4J8v/Z1V9ypGa2keTCc8DLJuhpcRdzPP/dmta6q4f8UZio0Xp6H8PyRYaoeooepC1BNxRzEl
	d9pbrMZv+JTMU+jZGzxyuM0meP8zc0zGB3UBgaSfMN84Sr/T8WBr6EmTRajaD
X-Received: by 2002:a17:902:e84b:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-27ed7222952mr15709855ad.29.1758782003811;
        Wed, 24 Sep 2025 23:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIQG96ISdWLineuWqjcbxSqimjfGHXyA1YGV7BUW7KJQWHMJ8Xs+AZ3XZSf3v4NHZOWmZ2zg==
X-Received: by 2002:a17:902:e84b:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-27ed7222952mr15709655ad.29.1758782003388;
        Wed, 24 Sep 2025 23:33:23 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:23 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:09 +0530
Subject: [PATCH 01/24] dt-bindings: arm: qcom: Document Glymur SoC and
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-1-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e235 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KVNckf8Hb-gWPUCTgC0A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfXy+IkSHYXzQ4o
 c2bMXGX2Nuzb/G6+8maG7fQ9Du3Ifs49EEPGmMq7WgMTn9icy5odt0rydVg//pfeII3RAUj268N
 9KS3ifwSRfcWvBzSueEzANUAkHgwTCIa7RHIONAOyKiOey43Ql4Ysq9/Icw3EU1Q6EsLL/cciZd
 JSBfE7uuCyW/KH5clBdFWpy/JgEfQOx2agn3oH6i/f7BlaEjMBCidTQRtjWa0jw4JyZFXRI5BHd
 rrOOEtiJP9xcb8swkbL2fuAIwN1a2R0RCnGVaP4tvZrXDz93VnRXdEuywzcYQiBDiFJ74z1Q9Jm
 Jvy4LSI4B9kE3tI71ewI36s5Wl1cpE02hkgl8ZTsMqMFX2s/ZMEZAAkAEjgswmcrHpLgVNbM7YK
 KOxZ61G0
X-Proofpoint-GUID: X2YskWPHeV4OjQhhQD4xiVxFnrjiJjWu
X-Proofpoint-ORIG-GUID: X2YskWPHeV4OjQhhQD4xiVxFnrjiJjWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

Document Glymur SoC bindings and Compute Reference Device
(CRD) board id

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 18b5ed044f9fcc4d12f4e3baa001099b6e154af7..b529a8e097a35c10e0008124467d8f6038071308 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -61,6 +61,11 @@ properties:
               - qcom,apq8084-sbc
           - const: qcom,apq8084
 
+      - items:
+          - enum:
+              - qcom,glymur-crd
+          - const: qcom,glymur
+
       - items:
           - enum:
               - microsoft,dempsey

-- 
2.34.1


