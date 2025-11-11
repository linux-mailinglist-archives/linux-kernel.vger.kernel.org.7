Return-Path: <linux-kernel+bounces-895881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A85C4F2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3838B4EC9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A73730F1;
	Tue, 11 Nov 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dq6SLOBZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EdnQn9qo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1232826A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880642; cv=none; b=FOkAAfhxvFZoudhP5t5j43PxmcMnNKsbxaPUKnNVMr/wTW2jWJh0cf3a7HFjZfXObuKP9NxKq+tE/Ay4/2HIdvNZk3A58FA+psdDekFUBQY3nWEn6sfn7WFBcSQ1mTgGqXSMuqCAGlK/EKV650M6QdMzFoc/OHjlUexzY8fyAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880642; c=relaxed/simple;
	bh=oY4T/ttoreMDsko7aua6FQ5sUjs/KwHa2EFAh1PvwqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQ84W9RFSUTXc4c0alBfCLWv853/8Xit/23UVJiD+cKdFM/uAjSIHxFja7uf5uz200V0iK6LbB9tcz3CoS9Jy4VEn4ge6i1l+30N3xK3/48sPcViA1fp/mY2jBryKqf6wSsOldG318jOe94eJt5E7BQAzj/6n6oCJH2IPGLBEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dq6SLOBZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EdnQn9qo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGXvl2027911
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sSqkmTvk/o1zV2BKESv8sOE2j4hMFGCUeKS
	AHs4JkiY=; b=Dq6SLOBZdEdcLxlp778Gm9OsA+XdoTRZlm4LGBRI3ScwkzOWkyj
	llkMN1k7DLNF3nrFkrRHAu/VE+Zkp3PG/aXLl+76QzCap4QKj6AomfuJuzckqnnV
	yk+XsiH9wkCeTUb/G3YjpTFhhAk5l36M0jNiR+5kX2VaXMnGfarfK6QTMHotdgWW
	UTAHlt4zs9ZXliM4dYG0fGVS2UJp6vj8e2+7N8AB9feoJpV1GNq9ds73I72THouP
	zKXLj9b+56E2UAdMrjv+SwiF0SmfGsVP+dSuqHX9+3m0kQDdJRBe2rib9QDmrHZu
	+yKrEVhn5pwczQbU0IoQWfhSe4TdaJUS9eQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxqw223e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:03:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9a72a43e42so4036248a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762880638; x=1763485438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqkmTvk/o1zV2BKESv8sOE2j4hMFGCUeKSAHs4JkiY=;
        b=EdnQn9qoKz5Is1CNcjtAVTWydTAeqLBux3lp7NN/Jg8Rx7K+0jXhvEcj7awjcgwyd/
         +dDf8AlyZliXmNdpWWMkxD1Rwx+Q+HvAfhaF8+Io9Bf13lHZXkZRHRIybxQguYCZEGN5
         61H2DmZ+Y3F/CEqWR6JNhTWD7AwVViPRoCFLmgg+MKPiV2QFSJT4rjO5n1s9D/peoMNM
         vr8zZZl65z3M1MtXcmgv92yxVtavGmHS/mxfQBb5htCsovFhDP3IAqERAgdE0gNjSDRO
         zBMUcX05ezkGpAHibjjh8adOl/B2qe+/PptcQqwNMQdaIyN2ja3dxm9/SyRbzRdStcDL
         VXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880638; x=1763485438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSqkmTvk/o1zV2BKESv8sOE2j4hMFGCUeKSAHs4JkiY=;
        b=j0kZLZbEdL9qVppHESDLHsjb86qYucQIDDhl6eNo8EquZA0mX0JvOeGHHNEGue9tOC
         q2FF9NDl2FZnOObNpqhzgLTzIEEnbgXN9dF6zrSGI6SfVkZTf36iEupWDG9aCIm58BXM
         P+7aPzzFugXJkCENNvv0bpcwl+QwjAQMYvWbFWy2K9xhAoKpAYeqKuFvGHC9YWRHLVdL
         V6xnqJTLP+fjLOcdNVHVQDZWL6u5ARQmErRq9opYTEfsbU9j1OzWhNgsYG2BzeZheJz2
         FgD7LeTUVKLJdnUngvRVY306YfR3CmcKWVJ1es0WPds3I8ASHh/Bt5eH/+H6zWfqMOpt
         EPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjF8/njgfHuQkhB0JIImEKbHGKkL5cR75ejVni9hFnuspy49UFcnEXc2CrZdUXe5v+2T7prMhXSp0KN8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXqbV4k71uTjLlzVEnguRg+jfvpXSCIIzMkTtCHZk1t8k2QHn
	OGOLDAx6AZs0GcDQf3J/8YO5LH2yJ+1UYRhr1xuP+kvPyGR9RvBE0lWFYQxUE2jNGKd+3v6tFcX
	rRD0EpGGvxePiN4ZBDAfiOEpiQsfG3bANcNURdhh8fJ72MQhMXsBkeUsO0MyvcLj43EM=
X-Gm-Gg: ASbGnct+7YCsZzJWFxa6TxyJnjyJlM/gYekPaWainPQlFr1fazF/1nrAkxGA5bbWXYC
	+wv4RJCDSLRJHw3cF89Px3+MnwImafz3nAuPifyh+safJEJDCDxjU6usSvmdRXntha8VPH/wVAT
	4xB2XUAlEygNYhDU+I3hehuxIcvyZhPwuMTHPsjtT3vCsipXmhSTAy2hPDArUVxJauLyowyRGSS
	tI40BMCP97Urt7nV42F7m14XcLi5Wyn7Kbz9AJQ6oHgCjAQRPF8JZ4BW5903Y+x49MiM/tJP5SD
	eSqCC7SokBKS21wiQI4KmNvF0lqUrRfg/nNbz8ewmR7snOv64JDiPqO0vRr1qUA81bXR+vtB35F
	tvfbpOgrVy5uXlzBv7AVQSPCLukG8R6qMkHE=
X-Received: by 2002:a17:902:e78b:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2984ed2b619mr438825ad.12.1762880638457;
        Tue, 11 Nov 2025 09:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWdsUBA6eSuHxYDMbD8ULmG3xXxYMXzsqpX6BMtcUFNBsubisaSrMVPigEbV83zZrnBZT5qA==
X-Received: by 2002:a17:902:e78b:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2984ed2b619mr438335ad.12.1762880637855;
        Tue, 11 Nov 2025 09:03:57 -0800 (PST)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcea690sm2262405ad.99.2025.11.11.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:03:57 -0800 (PST)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, dmitry.baryshkov@linaro.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH 1/1] arm64: dts: qcom: talos: Drop opp-shared from QUP OPP table
Date: Tue, 11 Nov 2025 22:33:50 +0530
Message-Id: <20251111170350.525832-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzOCBTYWx0ZWRfXz9lv5VuEtZ5+
 1iCkCQu24Zk4/zLS74QFMAIAdgZSOFgyGqth8P8fVQfOowXAgUX8lGu3e2t+pHypmiys6dAJAJ7
 jgauoDNY+j3VOD6yqMHNsvnqFva4YTAuCeJ1StNJwe3PlnVu5g2k9JDLEFRX+jBAb4iWO/7y6Wu
 KOnwZHqHDUXVEMgu8+UC1lpGRpglZ8RTnlwQ14aVHLHwQe/F1IjWtC05gUGk3C7TG33wWEu48Vs
 OcfAdvZgZw0dd0iipgNGOXfkfDIHfjqQheoI9c325ejvtrKlv57KBbIWU06Cim7NOicGZ6qljIx
 vrcXRq8Eu8bYjGnEccXg2xoTOoaoResFHYNte1u1fc0G2QeufnT9QEvKEBuXUX+a71KdZDK6RIL
 kXJ9jXrlhtarjATr9ZiyYO3UndGN9g==
X-Proofpoint-GUID: g-YpI_Qyk5oqZb0XYaEidL599XxUBjop
X-Proofpoint-ORIG-GUID: g-YpI_Qyk5oqZb0XYaEidL599XxUBjop
X-Authority-Analysis: v=2.4 cv=CeIFJbrl c=1 sm=1 tr=0 ts=69136c7f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B_wteF72wSsg3gi9yGIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110138

QUP devices are currently marked with opp-shared in their OPP table,
causing the kernel to treat them as part of a shared OPP domain. This
leads to the qcom_geni_serial driver failing to probe with error
-EBUSY (-16).

Remove the opp-shared property to ensure the OPP framework treats the
QUP OPP table as device-specific, allowing the serial driver to probe
successfully

Fixes: f6746dc9e379 ("arm64: dts: qcom: qcs615: Add QUPv3 configuration")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index eb6f69be4a82..ed89d2d509d5 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -536,7 +536,6 @@ cdsp_smp2p_in: slave-kernel {
 
 	qup_opp_table: opp-table-qup {
 		compatible = "operating-points-v2";
-		opp-shared;
 
 		opp-75000000 {
 			opp-hz = /bits/ 64 <75000000>;
-- 
2.34.1


