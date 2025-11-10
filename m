Return-Path: <linux-kernel+bounces-892981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F123EC46462
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7001882383
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30D307AE8;
	Mon, 10 Nov 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ixtN1FZQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5ucjBIy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA13090D5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774198; cv=none; b=FipLFgtCpsSa1d5Vp5z30goffx8d2emC8GQ/tBAyQE2anb09sVMAeptxXeGZP2i49a36j1S5qCE1Z0Z/qTyV6hTmsiHq4hHVCVf+vEa9Y71EoHxYgtNIC4gOFTXzb1IUq/9YmsrgoT3mcWG4t/GrcSDKrKRWUOA3lffY3DtO/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774198; c=relaxed/simple;
	bh=8xKXl25wfM0C8tmYM1yA2iBxK4BxYLRIBEfMfi+Dy30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRPErFUXBjKns4zR8f0cvcEMUFzDSPGndHE/8l6AIhwNLSIglje2fJOBJ3sPQyv5uTkTXUHMbQk1R1leiBwBpnxyLOLIzeKDMsHwVvm4sEYdZcooIDyaqDkOi/PrMJA5FqzRlkYJDIiBiB2bI2PUHjPnAZtPWWL+uL6KTU0gLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ixtN1FZQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5ucjBIy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SLRX2407325
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuR
	sMtlyQo4=; b=ixtN1FZQAJHMPwAc01uqs4wXs0H2NPrIvY8jgwBT1IC/MI42zrS
	EySPF4VfV6VvnuppZoDvn8SYj/CLHOQEHdGikP3LILH2YVd+iGwH5jBdi1LNbJa4
	R8qSDGVn2gJGEXIZvHmXl7YEjOhi91C/kLbR07mbURjADZ4oHZE6GJJgGBlb5RAP
	40nEj/HtdFo5eAHLMACGAd2m57BZAX4wL84mOMRWSSPq68NRFJBL0RjC4SM01kAp
	a03rlmhiFwDjjuYesreFBdKMKEmRHIhivLkW7roFtS5Ia2SaDevJbmvjrK+FQwG7
	HPKm/dbu023TDPNthfwZJCeFADyt8Hr0Cdg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8xgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b9d73d57328so2293038a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762774195; x=1763378995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuRsMtlyQo4=;
        b=Q5ucjBIyfj9KTXNZDDKgUS3eYU6eQSG9pRJLHfqr+24K4TgsUXxPbxsXa/xst69zcA
         AuI7QSFOYYpuDixTtA+RCNsCy3U/Cr7M6jl1nIrsSpW2k0btNnS18TsFv2WP99aR4hxV
         uReC/7v5hmRvsFuNulkWbJmQgEuNUsdTJEaejZGqbS4ERe2GpF4IOVBFeWmi30rjk0rV
         q9JCAl9zYsDQmISLn2JatCkjizpvaDMx1OfAwYyIiwA7bPeWifGldOpBQTGkCwOrm0dq
         DmDQQHcj4gRrZ5HmxqNXBpDxPEOdFVhsTfaN0w02T+lBf03Rnyt+n20mCy/UrzH2QaqZ
         iYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774195; x=1763378995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuRsMtlyQo4=;
        b=g6sWEeWZOlK0lQ7x63WppthnaDAOZTEvwQaV3MO8MtTzEL+FknCBOMUiNxBfoQ9QAC
         i5phzJhNNvW8jgdi7RbDEFh6I/lWVZFzTKo0qRBYiHcttWv+eEHzmfYazahGb2mwbq+9
         cgRyRNUZ4GDeYDnOqbfWHb+18+VhcnB/P7NRoNTGxGzyKszJaXsJqBBXLZ5ahOFF6g0H
         BzamIO7Vg5zeyYpHgBzL857Z7kZF8iyQQdaHslsHuRhXxjWiXolmcgDdzlryA2I0QWVP
         HIHlavUDqEsSaHg4aPM5mSKL/t/vdx6K9VbtUf5fsL4lIxS8ENOTYi8TKAK5CWtx+MnM
         Bf5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2BEsiy48CiYnG/NglGqpnGpanjt1ZlVHlORLoC4vldUM6Trdbj0KVEaTWXu7W7DYPaPTGcCUSylTrtsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9wTxMXowN5VEYUF44irWMmsY0wivGxKW+A95KdirhoKsA0js
	mLUWLVJRVoGm8Pdfik0ARdiZA7e27sZBqwi6C+/cNgSo9LzuTk5FXVufd6achZga2LfNEXaAeUA
	r/bOY4vW5Ov2dnLA33pfWiedqwbKt8lb4/6PHfTA/j12175+eoyUVAQOdxmQPKMHms9k=
X-Gm-Gg: ASbGnctkwiOwFY4iO7NWOhtvjgDw/Ax3yolbymApdsL6AmtXbwLdFKSLYMHy5Cw+Qmb
	eEWnqWI3wncD+51donS7cT929qleG86smrsgp6dEpdY63QhF+yi9l5jqvzImYGSJWtiDHp94tSQ
	J6MAvBxocCeXCzekhlY/H/hAVoMUb5GfCpP2GKADkVZrYDqcaAbp2UeDSAz+bYITuzWT1BPkiVn
	0QqkxAnehTXzdo47yujY8TkYlIaONREQcBXdr5oPP6U/fGeHHPSPXRWso3ZgRgkfccq+TkeGaN+
	mbi2RBpl7eyLXcCJpFaUq0dELQlVXLQ0L/Qjm6CIUxQLwVU8wPX2uOYRffFx0O4XyCa5NHoS2sw
	/4B6PpI5wvI9t/jvQfTvBTdJs+wYRQF8vZA==
X-Received: by 2002:a17:903:3d0f:b0:297:e575:cc5d with SMTP id d9443c01a7336-297e575cd10mr97124345ad.35.1762774195068;
        Mon, 10 Nov 2025 03:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMG6ovmdfjX+JC8Me1fTeukl5fm1TgWV8TPUNLWMYD42ZI2p8Y10hF6Q+EdEn8pCXJX3XaOw==
X-Received: by 2002:a17:903:3d0f:b0:297:e575:cc5d with SMTP id d9443c01a7336-297e575cd10mr97124085ad.35.1762774194529;
        Mon, 10 Nov 2025 03:29:54 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0ee9sm144165495ad.112.2025.11.10.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:29:54 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Date: Mon, 10 Nov 2025 16:59:47 +0530
Message-Id: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CHL6w-P_ejfmXRu1ITjomKisIYjEXWue
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911ccb3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5_BQsOELN8wEIR4Ca7QA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: CHL6w-P_ejfmXRu1ITjomKisIYjEXWue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMCBTYWx0ZWRfX+fLHSH1thZai
 T/rwnbyRvxHC3r/AyJB8+H/m20DXE1LwYMoL719og9uzHEDrPzJqk1HDKINf23qXjxbg5et0i7/
 gq5p30Ny1SEuf6oAHXho+CtHyviCY0FyWuMnRPdOb5WkvtKgi79ZD+qNRcL8gOJBYl41RzCGN0N
 CuNkT4KBV2mcG3hoYsOm6MRYYq2kDS2RnA9+GKa8o8Z7JxkxaXsOlPfZ7VOhT/eGX/uhjPF6AS0
 inXTFoXe4g4vnj7HjM3TXWr5G/DBqcFlDxHNZKpJCdfFrzqlbXyfOwNfHQrrhX6cKFVuKReW9OI
 HRONPK1nzo8Fq/geihoYqV4GYBlxWDlux/PWbl9WbCubygltOPCd7rxgIOLoYyv+DYRLfOL+F56
 SAwm8kCyr4tVZFxTjzl1rT/8yA/Nfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100100

From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time(in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON for each Root Port.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v1:
- Updated the commiit text (Mani).
- Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t

 dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index 5257339..bbe5510 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -152,6 +152,15 @@ properties:
       This property is invalid in host bridge nodes.
     maxItems: 1
 
+  t-power-on-us:
+    description:
+      The minimum amount of time that each component must wait in
+      L1.2.Exit after sampling CLKREQ# asserted before actively driving
+      the interface to ensure no device is ever actively driving into an
+      unpowered component. This value is based on the components and AC
+      coupling capacitors used in the connection linking the two
+      components(PCIe r6.0, sec 5.5.4).
+
   supports-clkreq:
     description:
       If present this property specifies that CLKREQ signal routing exists from
-- 
2.34.1


