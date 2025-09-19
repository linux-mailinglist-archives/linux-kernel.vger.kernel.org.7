Return-Path: <linux-kernel+bounces-825170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B35B8B293
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E3F1BC7D80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA826E6EB;
	Fri, 19 Sep 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GDwcBzy/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5747262A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312052; cv=none; b=eFPk66WRzUYC8UfdqOlppt0iPddz8th7mY2eWXX0Ea0S0rn0XQNLd3dppETerdSVplBg/m2+mN1AMmvLDCcIxYZ6dc/Su9eL/Ksp8trgswSm0ODe1ah3ZatA6ZPPEKzCNKcTtblF2Vhvh9/1ngSsMnGVpxGnhJ5184xylud/AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312052; c=relaxed/simple;
	bh=Y76S3H0ehzYEkiTShzQV2y4R/Ceh13K7kF+3QkotxxA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mPfYFt68A5dZnJORKtc5KmPk92lZAOrTxBn+ImlxDzBj/W0QE5XUjacjuUGlXGl3tWfANMOa0JzHt7hyG1Etmb0/mSKW3YRZw8ef94s4CMEGk2GR0DignW0yKNjBua4yuZshkmRstwZZfaqzDa4zQGs3/WgeU+5Iyu1hfZKCUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GDwcBzy/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHVgZu013802
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lrJ12YoUugvWUqmVr6hysi
	rvr/khh90USYulSQ7t+GI=; b=GDwcBzy/8DPyn3GAN+bnfFnJq313KVtz0Vzkpz
	2FBe2MhAeFHXgJRP0nO4srw5AhN3lNg8qCM35ZH0ShtshoZyDPCXGcK1yqZCwK3D
	3Oo3jw59u6Ml0v9I/QFoR4R/in87eRkbTDeSJ5W3Y2WMSD33oIyyvZ2MHfj9Z+5a
	53AwMhDAiJVPw15tpIj9WsI/6HqY1/qUI47C6rXs0M3XZMdkAMnFKPVKiYZ027gF
	XfDFuZwJdfGTx7kwVPC6VURFI+Ov/oBGEeuEDaNZMMIbRYBgvD559W05zPC19vAu
	TEMUEgAuzDXScZqfYJsNoXeQhw3drBzF3La0Qz8rScUoaEIg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499bmy0dsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581953b8so27681745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312048; x=1758916848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrJ12YoUugvWUqmVr6hysirvr/khh90USYulSQ7t+GI=;
        b=vZ+s47J9XJ2vXbNIAMG8HzqJxOXsgzTXPQWhVKRaAddzROLLkmRyu09gvT70uXkRXw
         dXe63ehSGAficHSaEh4xW1UKIWv9NhMO1SDUPnk9zJ5a5AiVLiVxcHdCKfel/J3RBIZS
         eB3zARkWiLyQSP++341WnYlbj7nKHz3EfL1Y4aBL0BEL7RdnWLLMOYyjDLkAxi4UBJsi
         2vll/DbV0x13mNmco2vKF98ZVv1fO/hQH+oK8PF4lvtd8PX6bY8Epu6VlxT6ua7Ysh7C
         Pz304YlRNkOpgJH0BhYJjBt1N0IIT6cngG3OShUjvhiuGCFvSA9rsGFbMRopjOpzFhgP
         O5Jg==
X-Gm-Message-State: AOJu0Yz7XJSpAqRd/QqHKyc5aMJrBiqPKuBA+sy9UrawD/gOzN5ugqYI
	ol6vMHyz2W167fLkdUe57Bntt4v+TP9UKU7M7b6lNa9/D8bTn6sle73CeXcWhLAp1yPmru0ehW0
	Ei/9cqHXaZxNpXkowTCoHGQdllaWvzLlopNuCQobKF99fFtbir5KTmU04ZOlpASUGJz4=
X-Gm-Gg: ASbGncv7RHZgQrf5LFrF7UF55I5VSkVgx+ZIGiy4YzCOeGOQ06BP9Zod7rkgDZAbtR8
	mzPgAhh/wmNrh4B1XHY7NG49IGAByMyWqmhPrxBtrszUN99uZRYgNj7NVmNJ+QtZX8F0KaGhqL7
	sNqDD2Q633Gq22PnW2kEiIWf7eSuugE68PsHohoP8L1dQ6A2TPbQWJuo4HZFkXROcsoNhhu9jn4
	LQU1mJiHuDfLiA4ss9Qr+/L8/YheG2RMwPzMIwQVHOl+CCYipGUsNI9AXtzIqEW3wd110oXuuLn
	Z+QOMacb/x+dbwf3FJ7E4gdYKyKZDeUTMQhjnIWn3QC1SWAYojfoMQW6Pg6ehoxivaRrmsP33cY
	vQ+kHK32I7EVob+xtAd/oTQlrGQ==
X-Received: by 2002:a17:902:d506:b0:262:f626:d516 with SMTP id d9443c01a7336-269ba46b4famr60376065ad.20.1758312048373;
        Fri, 19 Sep 2025 13:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdJEKRDdX/cjLVv1z/Bkn+SWxxdXbX1futxoBqIMDifIWnOaxRgKGgcPzg5IGgznJ3Sen6Iw==
X-Received: by 2002:a17:902:d506:b0:262:f626:d516 with SMTP id d9443c01a7336-269ba46b4famr60375755ad.20.1758312047941;
        Fri, 19 Sep 2025 13:00:47 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm63053905ad.109.2025.09.19.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:00:47 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH 0/3] drivers: spmi/pinctrl: Update SPMI & pinctrl drivers
 to support Glymur
Date: Sat, 20 Sep 2025 01:30:08 +0530
Message-Id: <20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEi2zWgC/x3MSw6DIBAA0KuYWXcSSin9XMV0oTLQSYqSIRIN8
 e6SLt/mVcgkTBneXQWhwpmXueF66WD6DnMgZNcMWum7emmF4bfHVTCnyFieGBIv6IQLCTr9cMq
 PN2usgRYkIc/bP+8/x3ECVSTK2mwAAAA=
X-Change-ID: 20250920-glymur-spmi-v8-gpio-driver-d27d0fb36464
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758312044; l=1348;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=Y76S3H0ehzYEkiTShzQV2y4R/Ceh13K7kF+3QkotxxA=;
 b=saHwtTpFiei/wrhs/SBwfJdkRmxXPq8tLdmHZBnsIQLMStEpt2mkFtvnUUXEOf4SwtcS1FK4Y
 laQviH6uDooCoxJA7Ipk2fRYxYulmkWrUADvpX+mT8FvLPk1rlyP2oN
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: X-1kU4noOV3Gd2L5NtJOUahui7vSV_mF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDE2NCBTYWx0ZWRfX4Ab8iI3ouZm1
 KAZ4gE1xDoPk5ACmK7G3u1TkRDKVUm2cGXnmJPXlcXbUVD3PyIj2AN1KiptjNtNNGJEpz7ZIzbM
 07GLV7Enyk92gNzKCjiuwuShpuRQB0rTqwB8zkUYCw2CHj1z+sKR0GjjMkbXKtWtgfzATzRazNx
 YeFWEMfXniCnqxazq6yRqpB1eLWt8vq6/oVhSEaZlJRwebe1WBqNn7X/3zhm/m+71EK9B9FkqJW
 lunqARbEvUD9SiSNjg+aOZKhxGHDnr+h3lmbtBWDVbrh6/F2GumQRbrf1vRzFsKZWs+1duknm/p
 l2IZTDCL551adfnuvR5/qz/OEDUV/+DcqQPPrthVO5SMpe18uQITOPtDL3rD1GUQmgkkavKpvJs
 X7I4JlYJ
X-Proofpoint-ORIG-GUID: X-1kU4noOV3Gd2L5NtJOUahui7vSV_mF
X-Authority-Analysis: v=2.4 cv=ftncZE4f c=1 sm=1 tr=0 ts=68cdb671 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rjyjYzsXQ0sINxRBlfYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190164

This series contains patches to update SPMI and PINCTRL drivers 
needed for supporting the PMICs present on the boards with
Qualcomm's next gen compute SoC - Glymur.

Device tree changes aren't part of this series and will be posted
separately after the official announcement of the Glymur SoC.

NOTE: Related dt-bindings were posted some time ago can be found in 
below links.

SPMI v8 DT binding:
https://lore.kernel.org/all/20250919141440.1068770-1-pankaj.patil@oss.qualcomm.com/

PINCTRL DT binding
https://lore.kernel.org/all/20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com/

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Anjelique Melendez (1):
      pinctrl: qcom: spmi-gpio: Add PMCX0102, PMK8850 & PMH01XX PMICs support

David Collins (1):
      spmi: spmi-pmic-arb: add support for PMIC arbiter v8

Subbaraman Narayanamurthy (1):
      pinctrl: qcom: spmi-gpio: add support for {LV_VIN2, MV_VIN3}_CLK subtypes

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |   9 +
 drivers/spmi/spmi-pmic-arb.c             | 327 ++++++++++++++++++++++++++++---
 2 files changed, 306 insertions(+), 30 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250920-glymur-spmi-v8-gpio-driver-d27d0fb36464

Best regards,
-- 
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>


