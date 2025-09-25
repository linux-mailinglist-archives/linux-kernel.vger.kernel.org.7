Return-Path: <linux-kernel+bounces-831541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60502B9CF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C213A2303
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133E2E03FE;
	Thu, 25 Sep 2025 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fH8h3Y8w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2262DF150
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761570; cv=none; b=m/ro0u0/yMwaY0i6TUznz/NCcPpcv6DPcPtz2cbnwpSw8cWxaCatUM1q9KWYtnOJN2XkkLvsC58j7j8vSG8or67K0f+dbEk+CsA+Vqhp1rmWsKHDc+hUxFB2oaR4nuGkkdX6oYiGB2+zqqIc43KvjTarRvkvoCi2sNI7iivTvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761570; c=relaxed/simple;
	bh=JenK+/zJgrkEgu7BAw2m2ucWcDL0lFzE6vWEQjcaBxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6t4Z3sUa17aitKBr6BpI6U+DLQ/CQbyNxbKN0NWDGrWDCu2T1jt3ktUK9nREEq3NvrYzT/D9mDgrjX76tiRS59Y5VId9VxFPqn66APDykX8OyvDei2n39Rvx6yu4WJb2uhPek801OeRvE/UV+a0aKEMCKpWZ1Y6zWUq/lW44G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fH8h3Y8w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCseZr002662
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oQ1clu+8ZKT
	yXqEd3c9pCyX/LD2tCG76qdlEPx0yVao=; b=fH8h3Y8w9C9p0PcQYFv5koeBng2
	PxN8cGE5WWbq9wSiB1d2S50AR6cwRU/kSXUOOjWGxBrK61pf46cXcM8VZqsFRNew
	5/WCNAY8plUHvBJA8Mhh5Z3FE7TWjqrfwj7O3Nnh2yDuhsVCD7rhrq6W5CitSjYg
	ETOHaamsQKeQY/cHC7kYo2OZQnaD5HGLvC9FVxaGZ1aoHBSS72vBXRdHwAI9Bixy
	GBjAWtsOdNAzmPK18lZNg0cTPGxbqdFJI0PLbBwBxsci5HzgCZ1dtXQDUVz3kn/7
	KhVUIAl14CILLJhjPG83yUGLbztQF3UgQEeTy5ZCluxNaazXx7EsJRwQCiA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0ruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27c62320f16so4474605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761567; x=1759366367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ1clu+8ZKTyXqEd3c9pCyX/LD2tCG76qdlEPx0yVao=;
        b=lPFleYh9q4vKR63VSZ/PeH4vvb4UjRKIJMcDIBJCNArgAummQyLmi+qZahqpc8Mhrl
         9M/cfuAEdXfG3UMjMhSdVx5WpTu3ZESQurmyCZkVVa28DOHm3Zr/r/ha563JKGIUMNd4
         gIfftiDRS7B2hTM0tAhGwm3HlYnL7/oaTLm4/u7LYUNWm3LKkx29YALOme7hgezVqF9h
         6KD5D9r8vH7g/Lwn3EhTlEJL1n9x55WFWu8UfxS9Le8gGArE+LAP+oc7SJ5UKiczxckp
         junfit7cZzLILuZ1WA0La/qE4OlLxDNj/5dbtwvFGK940boHb9W6hT76qjIe0AvBMKVe
         jb7w==
X-Forwarded-Encrypted: i=1; AJvYcCUXgkRK9ZUvbAoQBR/feU3r1GJ1aAPVx/Lg82ibmrHmVjhFEWdtAVMIFRdKwqlL6iDB1qSHzzx42dmDTgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdc8/y2VtWuKW+KYbvLELO/gt+qrvQWQ1+PblmSH9bCZUlW08l
	FhrOdrOGkH7zvjxkUfo9DcKxKOLzHKi+IZq3qawEG92ONb1C6IF67cqFoTIeYFplSvb54781tPu
	1y5ja8oT/DSSSk141r0OzW3HK5Kn/gT/q9QhHwxDpm82dylfqS1Cp5oMVZgWobgQaoBk=
X-Gm-Gg: ASbGncvw7RsO/qDGo+Ig+IJFhtxjhMktlrURXHCV0KicViFljY1P6UMP1c/iwPRC0e/
	7c0fwELbp959cUBGrAARrFZVqh21/BNCBbNm1fe/qTza9djWPT6FGJnnDvipVrfRzJ7GknmclLu
	IXm2HfUYJcmYCk+Z7kou9uSiF1lKYriBR1WtpJu8ZrxOK4cawXhyNk5OmhsYSPh8wOxLAIWiMhw
	Pbvd8BGOBbEgZh485BimDujhUeoWGkH6Zoi0VlJCCIHd4mFs9figd7sJtSJtWFSJPC1Z3+OLmkC
	QIj+2OGh2zw7DR4epBi7glp0c6QZR4uiwgpq2vqhtmOiakZALeJyetl+q4XrEmn9x8WBb36TbL6
	LtjxudmHWeufwJ9vm
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr18185205ad.28.1758761567015;
        Wed, 24 Sep 2025 17:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+WVAjn6nkapon6wWWzR245K/fiIlGiNBXHDyjGbThoY6v94l2NAtZ+A3xiLpl9py7sDEIGA==
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr18184925ad.28.1758761566547;
        Wed, 24 Sep 2025 17:52:46 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:45 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 10/10] phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support
Date: Wed, 24 Sep 2025 17:52:28 -0700
Message-Id: <20250925005228.4035927-11-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S8BSuKiQlQ1oeX4cM5DcOi7-XcDTKYY0
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4925f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PEmB9FCP7AcuBCYBmm8A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX8owhQ6sAXGBS
 XyRH+cWtbopMo57wKK7gOfJ1V/dlWsb4z1FW9L5sy4p9bMP3gChQEor6vjSzqGs86N8C09FOAZ5
 xVGP+fqhbWRn4PRV/rx9HpUk9ayTkHme/ioIEX3VS5wTVhNHjtFQX2QOr+oe0ZVU6NnHn6Jo9L3
 JZfP/DcY0IYCvyNTPZrmd8KqDl2DL3PbwODsOOhCuRQr8yCVNtXo7ZbzA9FzuuekWFX+HIxlRF5
 /qidfQfO+hilTHjCYuHkanfU3XwQzagoaM9262/docPCiTi57/eqjrFqqPU+XSPMKDLnFElOlMW
 XXrahRrh/QfBHwKAuOytFA9Lc80Ubi6oFQKU/bCaZ4TEiB/UTxAo6E/umpiS6KXwrvsL2csThwO
 LrIwt4Cl
X-Proofpoint-ORIG-GUID: S8BSuKiQlQ1oeX4cM5DcOi7-XcDTKYY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Introduce support for the SMB2370 based eUSB2 repeater.  Configure the
proper repeater tuning settings, as if this is not done correctly, it
can lead to instability on the USB2 link, which leads to USB2
enumeration failures, or random disconnects.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 651a12b59bc8..441996480a67 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -75,6 +75,13 @@ static const struct eusb2_repeater_init_tbl_reg smb2360_init_tbl[] = {
 	{ EUSB2_TUNE_USB2_PREEM, 0x2 },
 };
 
+static const struct eusb2_repeater_init_tbl_reg smb2370_init_tbl[] = {
+	{ EUSB2_TUNE_IUSB2, 0x4 },
+	{ EUSB2_TUNE_SQUELCH_U, 0x3 },
+	{ EUSB2_TUNE_USB2_SLEW, 0x7 },
+	{ EUSB2_TUNE_USB2_PREEM, 0x0 },
+};
+
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
 	.init_tbl	= pm8550b_init_tbl,
 	.init_tbl_num	= ARRAY_SIZE(pm8550b_init_tbl),
@@ -97,6 +104,13 @@ static const struct eusb2_repeater_cfg smb2360_eusb2_cfg = {
 	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
 };
 
+static const struct eusb2_repeater_cfg smb2370_eusb2_cfg = {
+	.init_tbl	= smb2370_init_tbl,
+	.init_tbl_num	= ARRAY_SIZE(smb2370_init_tbl),
+	.vreg_list	= pm8550b_vreg_l,
+	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
+};
+
 static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 {
 	int num = rptr->cfg->num_vregs;
@@ -278,6 +292,10 @@ static const struct of_device_id eusb2_repeater_of_match_table[] = {
 		.compatible = "qcom,smb2360-eusb2-repeater",
 		.data = &smb2360_eusb2_cfg,
 	},
+	{
+		.compatible = "qcom,smb2370-eusb2-repeater",
+		.data = &smb2370_eusb2_cfg,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, eusb2_repeater_of_match_table);

