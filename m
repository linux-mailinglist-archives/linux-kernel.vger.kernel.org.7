Return-Path: <linux-kernel+bounces-892975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9AC463DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618033A8071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FC30CD8D;
	Mon, 10 Nov 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9QEI04n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaQFylHM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C93093CD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773964; cv=none; b=qdUw/7g5vksLYKhmwflvU1V4Yt1sExN5zCD9jFxLGlLdXalLKhKE2JSWIY5Qphq7/lOTNwEYFlZzcRdXDzPQYWnLWH76Aw3Om1/W31eu/abdOaAcyxXbeLcny3hYm3tJ5s/3+XeFnZYNpWtxgTG/Bp8PY6t9+Tb24NETCDsTXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773964; c=relaxed/simple;
	bh=65t2YV+u7nGpYrt6fCSvmlRZmwzvXuDTZ/2KGVhOeLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABHZaw7yKCq/8O0jO8mJgIGynsvcFT8XA1Y3CX9EHQq0wKQnZX8ABYseoitk7DrMVRZSIzyni+cZ0m2cHMOIonj8D5Ly2aadHMEsh6wN0lFmw89wIIGBQ2QOC3xHdNb6XmcM6ao9bs2TneygWVt2TSDSA10OMSkP8LZD1xCGwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9QEI04n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaQFylHM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA503E44029952
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKND
	PZnxgk60=; b=g9QEI04nMslElKThs5IT5iFCdHXRXmTFi0jIdr+CdUz1zc8fbhm
	4uUu7nLhawiyRTfFpndcYlKiaBRhBZ+G3b2uHFRBwnEe4aLX7FR7q9sc4irqTbEL
	YkMLmnVCpCZsLHpIYQuEqM69avcRvUmaAsIl99aXveBld15/ZR4WZpwlQij1qOJb
	o3yDRVXz2M5m7a7YUA8rSoc0jQnInd0afah6xSapYZhccL3Za7nx03Wpv+4OcIQU
	VAhIZa6sZtUgrjngFyyVmygqP3r4KpQQA6JGjJp2RTcHNNBSnh07Lh18D4KMPiah
	3ojKghYzmD5TAIQyA9lfY9tuCYCPHcyqHuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjchf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:26:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c261fb38so6539413a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762773959; x=1763378759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKNDPZnxgk60=;
        b=RaQFylHMAz9d0lTigmcBfU59WHFQE+0YnV3QtNm15KxnDMQyXlcKBcy5FnohH7UP0K
         CcTYNntwQLNGnv0ZX+0jwIpZ5QSGPXjNXi/yGxyn6uP8a53I7YXm7q4ERF8QhInYw4Hy
         q/fvoFgndFNGSaFFi89E84shWGSBcTDEAWJRhVg7oODPK4QQ5KVZ47qh3IDol4LIV9Y2
         aLDS66l3CL2IbkHpk/YbUZpSrnXZNMJFXspohRvJ1aWvwt4CnaejMbNt8dTdRm1p6Dtl
         484V1tT3QnvwQRyDjBV+Ye+pOizfAs6mvrDnZzvfBEagRJdY3GEvgbDBMn7GR7N0Uo2g
         8q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773959; x=1763378759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKNDPZnxgk60=;
        b=O/FIm+W6jPOXdr3ZiLOBVJ7sDGt+WHnvxh4nARboTErpUxKWXz07BZL9U7N/CMCm7c
         6aVJI8IyzwLn/odyAqr/sj9qqmsE7qE9ArXiGvGvdCgxT3/xYcDRXLo1WmbjqeYFWzMo
         NolyNOWKDiFQknwvqWOjfQvZuvoikKd3NPiyqbP5BSzQ0H2zH5Efcs3Fw8O9Md4SipqQ
         9z/Cxnxf4L24FOONL6X/MEh62XHuyVgMB1D3gZJ12CXndzlswGyNkfx9Q3YvBkJunCeM
         VJvOR8yYq1z/WKnvsg9MCOhyttdAXrUBok6x7mShYm1c1++tCnwC/9lh3AcBbRuT9CVB
         bmxg==
X-Forwarded-Encrypted: i=1; AJvYcCXetjamTUaf5nrX96fSHXQbBUOF6malbgYgMlthenxghufpBmiMZKgKI4LL+anySRUp/UdfcJoCOhm8csE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUxygYh0Sm51P3clA+Hb3qFNaIn8vB/h9NGm5HZMuVYDFKaYJ
	/Hn+6I++oyWH+eEgF5KeU9bTnLbyCkrw04pCio64FxRCkF45OdNuq7C3uWMJCb5ktMQ2KFemtPy
	Cr7PBSPNhWqpgxQ8XpM9EQSklVz+CUxv96FQm3IiCq6oGnR3xyQQ3mv+6Jx1P/rv0Fic=
X-Gm-Gg: ASbGnctgXks4HBWI/BVOjI5ada34p2fKGTm0ZlVCEVF4GCMfzo1Nc9T/AG4+cfM+I0B
	mNeVzpYpZ8FM3o3vhKROZmVZMOdrm95i4smzmJlqE6DI/HXbgXvHWBCxgunjAMFqK71EU9AZkRU
	34XJUd9dsEhfqvxmVtkZEc7UyQ2kO6yGo+tXNFBtT0XnvkHVZI4Uma7zexltQtlm7HS+fTBqHoh
	tHV8Rw/1elRMauLOghz5qbFxa9kdzDxxcazOSq+clCEZmFkotChD1Bntecs+sP0GVukeAA9ugCU
	XXBs/O2qDST9JJyDNTjZ/qDMRVfb+nJNlKQTz4LJ6jdP7kM4X2TArfeAXMXNb+C/JMcr7RUgp9I
	MZjyrzOAVm/95iknZeJ2RZ7SpUzT0bMOacQ==
X-Received: by 2002:a17:90a:ac08:b0:343:7f04:79c1 with SMTP id 98e67ed59e1d1-3437f047a07mr5788233a91.9.1762773959352;
        Mon, 10 Nov 2025 03:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxlrDc8N4hRHSZZ3POhzWZIEuLZPkwIs1KhS+IqqAGFvhrS/Uv1cDfw09eZ649n2HqNb51ZQ==
X-Received: by 2002:a17:90a:ac08:b0:343:7f04:79c1 with SMTP id 98e67ed59e1d1-3437f047a07mr5788208a91.9.1762773958832;
        Mon, 10 Nov 2025 03:25:58 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30bffesm10390114a91.6.2025.11.10.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:25:58 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH] schemas: pci: Document PCIe T_POWER_ON
Date: Mon, 10 Nov 2025 16:55:50 +0530
Message-Id: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911cbc8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5cN519QvuxvD8VeTpmwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3g67rYih9bZOoQx--G8ZNxAsaIZhN3jp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5OSBTYWx0ZWRfX/dMzkU8Tq5Pc
 mwLIj12cn+z5aqU+Jilxi15gG7/iY0dh2Bc7484l8zYfWu47K8TCvYbx7Dv6CRG3+i30tNIENRD
 brTXMlOHrn+BI+eeVx4dO0xSGru9qi26GHlF0jdvvElQJwEkEGFBkwT3cG7bbzeu9T/hOQp0Q3n
 tLBkd+kOXsWbPeZ88cTYiiaoGuXe8Tb/idDSI9SMkSulFLMSi1A/mt8aYaA+kr4hDXi3kjC+1wc
 zeNMS5OS94EvlNlOMUQDGM3tNg+LYuIPh0EhZkg/ZVvt1GF4Ek+Sh0c4JujVOKMcET/eVdP1Bxk
 +TPlQBWl53xRhUUzaEJsB5wE4QuqulmB0pGqg4JOPZb6wqdGb2RKhFimc2awmf5PGSevI5acuVg
 /wGfA1Ur8604xddegmJTsFK1V2GbAw==
X-Proofpoint-GUID: 3g67rYih9bZOoQx--G8ZNxAsaIZhN3jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100099

From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time(in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON for each Root Port.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in V1:
- Updated the commit text (Mani).

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


