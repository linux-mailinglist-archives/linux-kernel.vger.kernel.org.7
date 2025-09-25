Return-Path: <linux-kernel+bounces-831714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6DB9D615
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34AF4231B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81081280037;
	Thu, 25 Sep 2025 04:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oh7kkAtM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51932157480
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774377; cv=none; b=MS1ccZanp0q0PIztMP+Gy17BTBhNOMpEMvx2B43yiCld65pF/Anyi/V5SYzEjp+F2p18+cIpZb1RChobUOPDylfWE0uGoxA7DrOSXFZm9K2768AsZ23mBhJIb54vMlFWJveG/buC6INySaUXnrYUCkoKO2nhI93ULKMkUDhFIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774377; c=relaxed/simple;
	bh=KwDml+VKamZoZ/8NLyiv7Z5OQFPQYZ/pI7BVR0nIL1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9BIdBIym4ZffDhn7O3R6AsVcYtGBMakQksKKKw+Uioj4RWN9x65kxr5Q5nWcTVRJXr9YwoO49N1o61iacaznaRcF0CKgtbikSx/5MFWK8RXqHWvF9IT9yj49mDYVKIenodN0sHVqzAq9fZzrIcKxuh/x5CO9OX6R0klKXmPCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oh7kkAtM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P03Wjv002152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QzN0PbQqJiRihO18yohAMqtH7hCDuoHFkrT
	iBWkA/eM=; b=Oh7kkAtMuA2p0mtB2ggp8lAeo0Ukgqe8k2OkRT2rgazr1YERwHS
	rRtIIpbDDaxRFMjYBf703u37Mpu9FxFbKy1FjFHjhg2frNlrR4ByIIIV8BDxQe2w
	kZV87qe9YhLs63w3Im4JJPAfSy311E0BD6E9J2LAvR99NhXIKXdXqPxI1E037PJs
	56hZSgmlM754c7bbbhZN/MY5tCeIZhuru3LEYnkUcEy8c4FrToTIz5Q3Lijxx3RF
	21HSDb+4FO/bw0z57/75Rl0veZdHyPmACbeEJhaSW0BAk02W01HYq4GLxBMJRwQM
	JNPhx/hTpKshKurEdt6dZ34wnKC9BhPVPpA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98pqmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:26:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befd39so1033339a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774374; x=1759379174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzN0PbQqJiRihO18yohAMqtH7hCDuoHFkrTiBWkA/eM=;
        b=IbBJB0yq23QMyMcj/+BYuPTlO/ftjDrU0OB5jcRHDCclzbSYM1S6wMVP/js+T2uqOD
         3wcPiO3/fX/aKaFK1oCB8lWLIdJ+zgQXA4doKnl/hnWTIKhigTBJ/xMz0w09+iXKwK9d
         Tt0cEi41WthaYfwuTOJCUiUBO3+nwBusT2I9n151/n1iEApSMu5j0PRVTmcXsQB+l6RC
         AJuqVkSDCrTTdtMS8OSGgQOcmH2PzsgSPn3KrTbdNZ+b00bGcnwsQ7iTji1nNNbBUpD4
         c9/mQQz8CpvHrpyP0PxMf4hQPUDiweVQePc4rluyJlyJFjqrooNmvNyU0gDaiBFe+odz
         2/tA==
X-Forwarded-Encrypted: i=1; AJvYcCUUiCmxGTidwM+cYkLEC1ryF63vapr96ClaXkGDmCh04TG9uIhd5RBQ8fQ9xXH26wlpKzv2IkBZ2LqP4oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9Vxb5bsdkyNe1pT+IBeyi1Lz5eSx3eOAPDJgPf+ivwWnK1bf
	HKYS9ZLUqBXvhFiSmnY1+hHw3pO8HEVF0EtYa0kCsofpmZpnFdyMpPjTawB56qBxtvbjvMVtQV8
	yfpuG7xwJjthuhpNJNv186lR4SVXMkVBq8UaaEK2V+BYrCWf3C3F9Zd0JplfrdsQvj/I=
X-Gm-Gg: ASbGncsCC38ZBQ2crIKQ8hE018yc5sr4Y0joMzBS7LUtV7RhFrANtiExUoJBhB2ZVDc
	aJPb8ZhZ37JsbXdKGla+VFyHivaggAWPiBqczNdrq4ciXE7+Qjts01Dlh/WdLczBCUSxnNfqnaE
	3QZbZuUMLRtGcc3hPLuoigoZ9Xk4YqahcTJDnTZnvw8uyn3CPJa8Fk1z12xuyDUejNyUvWdlx4v
	byV9o5QEugMbhk1C8H3MPfpDoc9oqBna2pQzy1h7MzIGc5BeQoEqKZ4rGsuTQuEj26g+SbgS2Ad
	St7Ty9PL1B4qK3ItT2qgozb7E5hMJL6oRmAPzbrv/M1dV/l+F7tc4rieNzV1fwT1qf2v7pEBFZg
	F
X-Received: by 2002:a17:90b:4a92:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-3342a257491mr2000804a91.7.1758774373693;
        Wed, 24 Sep 2025 21:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZUnSW5Khp9aZB4808Uo4zwgcJwfbzYwCHapgsYczaALl4fGiBeUPgfY1PG8zJwA2k8HfPQ==
X-Received: by 2002:a17:90b:4a92:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-3342a257491mr2000784a91.7.1758774373311;
        Wed, 24 Sep 2025 21:26:13 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474b1f455sm738211a91.24.2025.09.24.21.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:26:12 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1] arm64: dts: qcom: monaco-evk: Add firmware-name to QUPv3 nodes
Date: Thu, 25 Sep 2025 09:56:05 +0530
Message-Id: <20250925042605.1388951-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 804Y8mK8Am-Rnaj-k5hl4se4ZPSl9-1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX0HWiV75pegW2
 Rx27jLxPhLd/IZXll6yXx0t4g0c0LxY6nVewdFxHRSSYY/HcZnfaxL4tc3WoimmyrsQeMWUzZ2z
 Kri42OBKx9BdLfO0aWIPP2XL6Iwk2aFM8nwaQlrAzhM1sMUuQD4XNKk4fG9ciLG1cXRcGa+R9E/
 t/50EBreVQFMRWCJNc51qB60ud0lPZGrNyiXkdn8vgqLu+pUy/2tFVsoKtvo3laXRwREsUbExWS
 j3VS3/Y2B0NmCMhY1hQhbHcR/lprRqfVGT+FUPsC4RF0WdPZLPXQsZaqbho2Nabx5IBusO+KAEo
 ViHmpt4IhToeKOJqRJCj+3WnYcIdfSGzgbX09ve5dKCIPV7FpomPizHE2d66FFxErGIDrE+OyFf
 swtbW4g0
X-Proofpoint-ORIG-GUID: 804Y8mK8Am-Rnaj-k5hl4se4ZPSl9-1A
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4c467 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8rlZebuS5uYMG-XfLoEA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
ensures secure SE assignment and access control, it limits flexibility for
developers who need to enable various protocols on different SEs.

Add the firmware-name property to QUPv3 nodes in the device tree to enable
firmware loading from the Linux environment. Handle SE assignments and
access control permissions directly within Linux, removing the dependency
on TrustZone.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index e72cf6725a52..d566737ee012 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -401,10 +401,12 @@ &iris {
 };
 
 &qupv3_id_0 {
+	firmware-name = "qcom/qcs8300/qupv3fw.elf";
 	status = "okay";
 };
 
 &qupv3_id_1 {
+	firmware-name = "qcom/qcs8300/qupv3fw.elf";
 	status = "okay";
 };
 
-- 
2.34.1


