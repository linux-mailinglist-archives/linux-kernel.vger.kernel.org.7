Return-Path: <linux-kernel+bounces-831819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA6B9D9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC97174901
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425152ED148;
	Thu, 25 Sep 2025 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9LeXD90"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C32ECD27
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781788; cv=none; b=REhSZz0/8ZSfU2iY8pGHDbwoXVCy0m7tKcIV0orFiSpu4IbOx0yS9UCqdCj9TlbpLiR96LN/G1fcy11rLMHoQXeA7j57BspJ44yAmebYPH7u767hXYP2vYvfBICadkqk5P91WFsig60O49RUq5s4nwRE5604g3x47H/Ncz9Nf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781788; c=relaxed/simple;
	bh=yedJEEqL4ZUtTo4ypXp6TiEKX/zqnJ9N75AqBUCVR0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+x5QfmN3hHM1i1ZJmniJksn5JTJ38BGPNBAvMOd7/oAxlKpSzFCiyJT4VznrUtxYNV38knU1P7qXxVDqmUexmdNMrEAkyovVTR9/6iMM1owcmBhPyMhrI3QbFHXgEnO+IFxt6HazhjUcAl8NgkxtDioYAdwjhx+8+TMuQf0uYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9LeXD90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1B96q003835
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+AtpvCg1CmpAe9sYGyWQJouaSiovRLjPzDEo50wF9Y=; b=F9LeXD906u/wjUQ8
	eBiHfssonfeEkGphJ5NkU+SnNgnJLb0Yb4vtRMDdsnt50U1FCVn2aEd3WyfF/srQ
	wAQhk7e6UxPKuksf83DaSCw/VkJ+OuWcfd3hRTq9w3mfnbpOf57A7OZnFssETAHk
	M3Lf6xeH6PoTZL4mS+HW4zsLcOdLvQ3V1iDfr6SQ69cqpn9QvKodDyfztq4IcEuB
	SIFeh11L10ldsqsNj1EbYaW08CY/K6QGsccnWYql4ee9qi2VTQuCzAGUp2fNaGii
	1bvfSdG8qSSeAxBf4lm5pGA7M6AXm4uKhBEgW2tMbH9Zll0uUTrQmcF0oqt5V9Zh
	316MaQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1j6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77ec1f25fedso1063058b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781785; x=1759386585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+AtpvCg1CmpAe9sYGyWQJouaSiovRLjPzDEo50wF9Y=;
        b=NagxJcu2H97UHNloD2/qwL7tN6NCKBdfq9Rp3Wgn0K/5fD7ZgXScW8uhrgkA1NVi2x
         9BLP3QeQi+U+ibanGy9uhmCh8Q90lrxMLU43wlfgDJ34dBD+NtWD5pxDEiVoHjIW4ujJ
         xYOxDRJj34lyF18cWs9eX0MGwuitb0WvyWqDO8b7z8ZFseSu47Z5zAum7A4YspIChdyP
         Dfcc+ALisYYBiKRtqVl2rTnmANTeE0ogMv4RK9zR56sjet23x7Hmy7IaudfxiXSirnO0
         fe9XGhb2262RY82sJPFW8Cjpklowewnyetdmx72twMBX18NpNkBu4tLEtqPYBUoTVizL
         2E4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIEXT4p09vPJUXUWjNHxUFjT3Naw4WgTiT9bnk3wmrEOe7Gx7unQZP0UDi/Suldd/sE61pnnFkzq3qvqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hMS7VYzVlyMOKKLjD3Mon9twDp/3RyEarv7r/KqSN4Wo5Llz
	RzmNHcX5xvo0kizgUIxaneARafJxq+T33oDi53C0Q/yzEe382VXwtrg20wkKsgGFEbwO4Ml1fgt
	VmSukvcaO4GA41HvVgqKmpiLHm7VBwMaSg97IU3m2wrnBlpduiP/AxZj4KoCYcC1zWyg=
X-Gm-Gg: ASbGncv2CVVDltQMGbcgRSYlho1Y+SRIxaSr9gl6aTL+1XopUE7riWtSlKBy0UkY4hF
	wb8tLIL03GNPMysoe3qsUk9UeQt+Cr3liE6a69YLiVbAOpp2C5FSwEzfyBkeMLOJRfKRxByyHE8
	UwfVg8xeHiK/bzdwBZv6wbLjY63qpu7pEQ6uTbn3fAvRjeOa2QJCmQ79iV8gtfVzG0Jh00STXrp
	5xKwGZBg9LV3EsKLhxQuInWBNNKXxCsRT1xm3h130/wNquO1Zi3nRs08sxcjQa6gFXweTVET3Ay
	3Ua3dxMkx2BjIh8fojqbIj9QxCzGKrPxbTBPw0FWfxhOI/4A0yrT495t15K4cOUnuuEQCYZ2Tsb
	UvP1yodvw+C/tBXj5lI9FRK3awG36fYntEH/n3OZToZ5BPmqhuxKkmB6HEws1
X-Received: by 2002:a05:6a00:2290:b0:77e:d2f7:f2fb with SMTP id d2e1a72fcca58-780fcee1bc7mr2232460b3a.23.1758781785204;
        Wed, 24 Sep 2025 23:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3OmDcicH/EzzZH4H0pemOdU65gxLkrQqE4Ny7buYCJovyC253xgahgRiTwAHjEjzY0LZoXQ==
X-Received: by 2002:a05:6a00:2290:b0:77e:d2f7:f2fb with SMTP id d2e1a72fcca58-780fcee1bc7mr2232436b3a.23.1758781784763;
        Wed, 24 Sep 2025 23:29:44 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:44 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:21 +0530
Subject: [PATCH v2 15/24] arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-15-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: CZ04nybBQGFdlR0BcZQL_chAFIi3A8OW
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e15a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-PhwRXPgPXS4kyLjRL8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX5Ak2IsXW9P2G
 C1dNqRtVgNVK7O+ouPfImymEzDYPfWacQ/jmAZIGPcswlVIEqBujkZkCB/gj8dKqUh/NAxkeIAF
 mTaAtGLmMBb6471CXRxBcAJ5sCKcOV3JRQf0dIpMRNdMdsKoy21XVyFkAcWNdPFGW1HiATN+R5q
 2Bg9Y2a2HlKsJZaVrJ+kJRkDrklWwHm4iq2jOk+qSmBmIQ+ZFboTDQYqckH9vq/pZiued3aNP57
 XgW2DfWXNjRTb0YUtMiBDYvajokucZSp4IWk/kQlGQ+y9WWR4ObFuM1kZIvZeq9rxSwIV9ESopA
 7GvZUQcdvBk2f2Ebi0aYcZkZmGMWMFBTYtt2YanRpiNoKZatX6pnp76dnTKvR3bGT+KfZFh/1ks
 zRFsDw4z
X-Proofpoint-ORIG-GUID: CZ04nybBQGFdlR0BcZQL_chAFIi3A8OW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Include all the PMICs present on the Glymur board into
the glymur CRD DTS file.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts    |  1 +
 arch/arm64/boot/dts/qcom/glymur-pmics.dtsi | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index e89b81dcb4f47b78307fa3ab6831657cf6491c89..97f6eedd7222368f5cbfdd02e9c4d87261d7f19a 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "glymur.dtsi"
+#include "glymur-pmics.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..59dcfb67a203a7c576406037377fc9fbdce51a97
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define PMH0110_F_E0	0x5
+#define PMH0110_H_E0	0x7
+#define PMH0104_I_E0	0x8
+#define PMH0104_J_E0	0x9
+
+#define PMH0110_F_E1	0x5
+#define PMH0104_L_E1	0xb
+
+#include "pmk8850.dtsi"	/* SPMI0: SID-0*/
+#include "pmh0101.dtsi"	/* SPMI0: SID-1*/
+#include "pmcx0102.dtsi"	/* SPMI0: SID-2/3/4/6	SPMI1: SID-2/3/4 */
+#include "pmh0110.dtsi"	/* SPMI0: SID-5/7	SPMI1: SID-5	*/
+#include "pmh0104.dtsi"	/* SPMI0: SID-8/9	SPMI1: SID-11	*/
+#include "smb2370.dtsi"	/* SPMI2: SID-9/10/11*/

-- 
2.34.1


