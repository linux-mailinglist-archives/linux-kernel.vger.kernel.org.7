Return-Path: <linux-kernel+bounces-829311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6856B96C49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7064116DC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2B2FA0C4;
	Tue, 23 Sep 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItMpgK5E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5082550AD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643878; cv=none; b=nWQtB5cn+UdzmtXGTDbQhQtBWLJRQY5x9Vc3H4CIj/pkN3kbvmIssWoVbUUdN1M1wPOYJyRkTbdixhN76BaO13e09W5rw2EDYMD5lmC2vbUgVHel3roPskUTu/dOMn2m3zu6QVzGfs7Hm+O1QaFiJDkW7REI03ay8ooppu+V7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643878; c=relaxed/simple;
	bh=S4DCabmUgx7wjr90gBdV2xwMP4UhxJhIHvHJUN0oTwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkpO+Bv/x7ZYjgCA7uxDXIfcZ9rFTR/fdKVH/8vP8Y6IzuOgnngmBnZWjp7KbJAtsr6YLNYaVWFpwZR84ydl+e0XxibKwyXsM2p3w6u18oJb047sbsal/T6RF6/AWR/Y98UaUSb8cMESEOgtRXV6K6dZJsdRlnX36h8Ek2MYeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ItMpgK5E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NF2Oul020604
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gXXsKXWMrsrDa77n53dShpXPwdnJeODNX87
	cwfB/X0E=; b=ItMpgK5ElJA1rzXHuvX92lzLJX1qYK58moE+OG+55xJtEIdNsXh
	79TLrAVXpNC4aEsW0AudBc8nJ53ORbf5U6gOqKRLr0Xn7xSptnCx5dsOpsw+m+UX
	SZ7coVyOHeo4yP3ku2TpwRX8zB6E3ABkLPNEi9thJ0gbEgT5+ttODNBRV/NV2E8l
	BUoddyml667eDVr8cAC98GHSk3h/hJTCHwpjsp4sJKR5SzZXgC9j0jOAWbBDJK+c
	q9BUjHR8KMNm0SgKJV9UBC0doC+5PH4u6dhidxKWCGXwhvxcYFL/6NFP1mwbjkmL
	2OrrtmFbQmG+6W+efq4p46U7Tvd96ZnOr4A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjtk30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:11:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-272ed8c106eso18846955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643875; x=1759248675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXXsKXWMrsrDa77n53dShpXPwdnJeODNX87cwfB/X0E=;
        b=Vxma+twaAWZ99Pd9/vBPp/MS5+KQ7k7OAZDZb3k0433O6qu+pbQnG2P2TIe7G/V+TJ
         SPHZUjwH0iSopQlGADOmSJO+Q/0mf6t1Kz4tge+f7ISyCJEk/OwGs+MsD2RtFe5Lu5R1
         RS5+u8FAL7utbbALPJr0pgUSe8mM3c+Bv8iO7Uzwblm0ySrJZ4mqmVnWhOI5YvHi41S/
         RbSdgTE9/GvOw793RbYh/HEvHhina3OM6R8m/dhoHhyZq8AgNT9ZXTRqNfHrvUTWCq/O
         QIwNj9UgM7vVuKw/DP78DCYYdDmT2NSNtqmi1VHSU5BVD6dMv2gcT1aYRJMS6/NWc/5k
         URAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4yJggdPMr9exvgq4U3D/JGsR1myh8SCd5pog3RJH6yHYvxivz5iYQacT1VTC2EZHxdHO09M4U54kBU40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4eFa8pYcA8svvJE5kUxuUdrIp/ewNHVAqwSFZSHxeyzn31F/
	YmdT0CwPO6WS4i0jQ2uN6FfeqNx1ZzSQ9eWJZ2A+KNmznCz12fDo14GqVTQ6gQwjm1smb8ZxYVK
	K77hkqRJjJzqsXFEWf8X1qXSjFES4/RwbUXapFxElBL5KCRhbhDmN6YaoKWeR9nAgx9A=
X-Gm-Gg: ASbGncvUMbYH9UsNnlTD2N73LTg/NSYJzI90lVQGKcxPBlpM+HeiQKtD9BtPw/Gaw+g
	Co1g8AhdReOYKv+EuHAYSl7oM31gnTYxlRYX/5PeUH+TvaLigPxtJtD2l7+kFo6Xp9cNESZkrvm
	AdIo3Yupt2grEE8IIkGay1eG6BDVI//IDO1hTRHEox7nZmus9SACLeEjJxiyNp99MZl6gOpT5UN
	234I1Hg7xiF2DFqnwguuSyKBm3+pFegtgGlgeVkzNoSNIp6tUYVf06x807Q2vZKl49/80qTDO82
	+qM6Y4/5eoHzupku9BEPPS1cuFHS8LGcpD7W6buWnoRJlpFS7cN5R+O/GxBsAifPcHk8qh8ccPC
	B
X-Received: by 2002:a17:902:ea05:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-27ccaae76b4mr38001895ad.59.1758643874820;
        Tue, 23 Sep 2025 09:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgDc1k1R7cpq+knm9wZ1c7VQL4r/SXF4203S/1vo1F+pemSrTnIlVN5YxWckIRKZQ3VmD4Q==
X-Received: by 2002:a17:902:ea05:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-27ccaae76b4mr38000965ad.59.1758643873541;
        Tue, 23 Sep 2025 09:11:13 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d2a7sm162680525ad.132.2025.09.23.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:11:13 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Add firmware-name to QUPv3 nodes
Date: Tue, 23 Sep 2025 21:41:07 +0530
Message-Id: <20250923161107.3541698-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xXXxULqo6AyQ7taoExsE9RAg-11TTaJY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX9F3fy9l8NRT+
 cP24KsSL4VLnTVAXrXnnaaMd8pU0WkI6ROJojtMF8hZXYCbRMoIMjreif4FqxaAToO6diLz1Ab8
 g7/nbA+fCtLq7lq1wqIVN8ppYRVzrvlJ88krbrL4kqR6o/wX5X5fptrdaaxhGQtqzbDkAlzVjXW
 1BpcTLXbLLtAiLmBF0y31YNZvUiuClcZnIT8ca2i9VLkMc5yFAZG7NkbwjNA0wDrtYZjOiXSS8x
 UrGjbQe7Yv5JT0H1hxaqL74/3X0P0HtTun7dUdbrocjEseBr6wwZ1oHNxjoDTIFoIrJg9yIxhU4
 CM3sBNESvJ9gTD1CizwUyGCJTfaw+/650renXNoDbD8VdHzOX6kl5DpYzxqPgZo7/byoWyH4A0u
 TKh9UKIn
X-Proofpoint-GUID: xXXxULqo6AyQ7taoExsE9RAg-11TTaJY
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d2c6a3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8rlZebuS5uYMG-XfLoEA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

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
v1 -> v2:

- Updated the commit log.

v1 Link: https://lore.kernel.org/all/20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com/
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001..4e361580ddf1 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1009,10 +1009,12 @@ &qup_uart7_tx {
 };
 
 &qupv3_id_0 {
+	firmware-name = "qcom/qcs6490/qupv3fw.elf";
 	status = "okay";
 };
 
 &qupv3_id_1 {
+	firmware-name = "qcom/qcs6490/qupv3fw.elf";
 	status = "okay";
 };
 
-- 
2.34.1


