Return-Path: <linux-kernel+bounces-838640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D53BAFCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01A47B15BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85E2D97B4;
	Wed,  1 Oct 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBqrnrN/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520412D94BA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309854; cv=none; b=WWQEFiJreTNDI0NgovDuEVLY+R9JYGu8ojeE5her6HwHy5n/l0SfC6Xpg+3ED6SzoiuKJCJBm3FzwuW2oR31zrCuJjTvPiLPHzN70d0oYHwIu7tFK8LF8eQQihk4UgeVl7ZNi9F/1RtlZK+CNYMAHqkJtUlN2ft4sR9gO2EAFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309854; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvIs2CSClBMod4iTuipJVVArsnBw9/Sk8KRh7gADLKITWvvPg4gqo0Qv3bx3EDp5h97AFQznCgI7SqhLTQ3HMaiYAp21nyh13TsJUb4yk/KO7D3Gt6OXYAgvk4f4HRpeNRMhRLRH6ZblwIHsJAoLUlzoILsU9LzTVk9p+nJGlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBqrnrN/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULO9jI018092
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=mBqrnrN/7cpp9QY5SYGITKEOWKj
	xRApfzEUxwU2oApr0HAAGWj6y6VPoep49b3OthJW6Z70cndLpj2t6eQ/7wnsMvSk
	9ntvar4d6AIWcf2A897rp69IhDTNFzjnVLyGh0BsR8rZKc3MOkA7t6Fh2hqeUbgy
	ikBeMOEUTDSWaMUIWZVNSJJsJwrEm+qZQbwIAIJMhxIH8h30sgCwPx9VjsCu4DS0
	m9VO2oEXMfYLYnnHRDmrfUMsfkqRcRd/jyU95ibpKbMXqSx0nOIfa2lbgRU7ZXrK
	7Eh4epIjK6tx3SBzDr8vbPbcVBVXucjQ5a2NIvlMDyII3UCkqQV5FwQmG7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkp80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:10:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26985173d8eso126561625ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309852; x=1759914652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=bansaKv+omucMbgV7asS6HsEo7YLrdJyz0jXMGjKucn7umSE3J+KPNAQ7UG516dh1u
         j2wrw49GLwc7GjDfvlCWcLk/Zpm5jZHY0TrB4ZPxJyRfwttqEZfm3bbrctqnPNfu9lkk
         atgGBHEHoakEW+nnSFeXkV8uUSIihoYzcHeoSspHb7e8sSEc3xE3M/YIEXgBzkLc+Oyb
         TubEANCcM/fi/Nf/n/3iW9bV2lHppOGTO8kPSPptsqwW94byTQzKnMzaeNvA3RR2HZu/
         Y/n2Q2dBAscl/P6lUn0xbAWNrd5dy2zcDgNWzlJh26xE+wFKnM0HFVMrCZIWVgiFNyr4
         PqaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrrOdbh1oxgwirNaWawFK4mQzEx4+vN1KgV8lESYGPrurIkFrWJ9pEkOIXmw1zuVXV4qik5BKrS85RaPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwN60lCCmlQQUyTjtcg9Gst641AuswnX7NW1EkEgeU8QPX7X7P
	GDwVZJ+iZMQPnfVhCx8A4cHU3rfc3ghFqBkFS2r33TefVOHIZEBmjUvMiIhLfrCDZXrgcZ+i62b
	ienN2WjWVPTbzEtHhZuHw6vx8ODSVJnX0urnVl5h5jZjvLNDmDJGvdshn6pekzoc2Z+A=
X-Gm-Gg: ASbGncvraI43uXwQfqytci2f8GzFWmL+B2fzo/gtNlw7AzIZh4fBRT+TzcM6N0uc5JQ
	48ipRWUwQyciFfUGdnPxjgAQFEUXvHEXrqZIJZTJhlJ/eZjkwoNGkNZlLTePS+Qd1VEEX6uHdDv
	1qHeNt/z/LtQkSVSdMEU5yXMDZsrKzc4sihzh2dlzAr/r8lb4JhKprr9vxDZAlw2hGTZvMCkrWX
	MbwZ1V0mEFPVoKmkStiJ5c5KzL4AXkhfna8Sj3A6UvANzuzvhiVxbfXYGeGg/PYTAVrX/E7niSi
	v177VoAFrkBy78oEI/MZPDof6M2gBEH1SvBcxiZQQ+oE7E2COLGTra6PwfrMgP0Lmv+gHrEXTCC
	0zuxAqw==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr34870885ad.47.1759309851682;
        Wed, 01 Oct 2025 02:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKedvdV1/ItaIACYKHnY4KYhs298v4BEWXXcoD9/zsLksqKknUQgVmOswuXLjmaqAn+lkDdw==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr34870505ad.47.1759309851282;
        Wed, 01 Oct 2025 02:10:51 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:50 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Wed,  1 Oct 2025 14:40:06 +0530
Message-Id: <20251001091006.4003841-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXylwMAfmFcaIj
 CnTAYoxJ1cus0NF16xS9TFd54GbRBozCqNen8VLQ/g3NJN4aXWyD5jGXhj/KjrwyZyQP0g66tLQ
 t7ey4Olo/+VL+x313UTJVw3vtSD77NOamlEqkhvMwQkaS7/7/jATucsTrfR5MBIS7JKgiO1ziVk
 1y7IaUos15wy7aqaXxLVxCOQu2SV+9NlyWwNdYf3I1HZJdQfP64utqj51U8fiKXN3CKiRmYSEy5
 qxVc8nckLyj3qtla2yreoIhHJv47Ij2ChreLg+euseGULWMcZG2KcB1lj6wttxuRYVAyytXcUON
 CEv14b6ErAoGTwMENigq+QfK2cQmN44urZIe0noTHiFl/DfDSbMxCtZbF8vPNFkUe7BVbtcoH43
 EmIsd3v59QVZjOOnp3sc7eNuxUcbhA==
X-Proofpoint-GUID: Tjmc_YYCphJPJzVRXuLVuNyort8bI_CI
X-Proofpoint-ORIG-GUID: Tjmc_YYCphJPJzVRXuLVuNyort8bI_CI
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dcf01c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index c155c9c6db39..2d13638ebc6a 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -49,6 +49,11 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 20000000
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
 required:
   - compatible
   - reg
-- 
2.34.1


