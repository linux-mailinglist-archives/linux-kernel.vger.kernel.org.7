Return-Path: <linux-kernel+bounces-843537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F3BBFADA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714EE189E0E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DC2E0410;
	Mon,  6 Oct 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEZcXWu8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5ED2DF153
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789226; cv=none; b=YvfaMhoXoUVEPWvflKD+vxnyv/Bk1qUrJcEpY6TC5owVzE1i4ix3bukjqRLNvsr1v4REQBS0KRTW1fnCPU1V/S/zJtOV4OWbZ65TsazT8yodsUekbyfkXcMoI/z+PuGp3QepiEPsq210c19UzyoWnhMaMk4od6co5T3XjAgA4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789226; c=relaxed/simple;
	bh=KRfbO68RqNXGYUxEscJ9pAB4g2zVH9KTs2sCuSCOkhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppYTzqIvaYw2YI9xqzE63Mj9kkIFfgcmgpBZ5e5k+4AhpK0kFU0aoXXH0SgtIzsjfoHjJjSC/ZDn3v2bnEHpjVLfcJj1Ps7PVLuMTX57vSNcPltJf/p8FIiRzYXzk7EznSJz2nrySvVV8eRRfUHufmaPOYW1thohnXDEikcyf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEZcXWu8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FChxp007705
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NVYsIQDhA8R
	ySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=; b=bEZcXWu8NYn46iYEKSdylzHMVZy
	gooOnhtZQeHCkoXjGF/y0SKEH7q34nM08Ra7APR3HaFpGpUfSRnymRLhRyRsd5HS
	utkBW1Wvn10t51JG9uRC7wrN66j9X7nRK3RRlf7CB5GDWH9hLW0wdDKRqu2Iv1Ap
	zSSVk3Cpom/EAnpcJWyMYo6XNTHm454L4Ab93HbU7OagYHNByUwYFypcu+/6Mfpy
	EEl8724bZapd/NQKFvUMpcfEfZaBTT02iuaxcKfnACJsEg1DxtQoLZh3C6wi4tu1
	enmxOhzdg7rtPBqZWcDR+P7FiUizwnSLDgrL2rVCfZKZdaIX+84nShcPcNw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1n9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780f82484faso3734948b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789221; x=1760394021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVYsIQDhA8RySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=;
        b=Gc0tyIvZ7Jo8HZRclqjM63464mACDfIJMX3g9VkvpMn9r5ZnL2w/3IAWPgqEbwNOwy
         C7MRYppS9Yl3spq2yV8Df6mSGtO0tnsgimJgUVIiPBEbOf3qA79V7mM8Uqbp8PcOTmv1
         tThZ51hmhQ8rCi0d9W5B83rIS1AlgUAU6iRJNywGNh1XEoFZTJMEGJt4O2Y8r0iEqucR
         wrcP3Gdn9x3E8APwnrjY1MbcXxCcHGT8nQfksrGPttG7s/h87Jsc6bfxKduRwjSy5RZb
         XObD1QbG74HwPA0xTMon2/kL/BXInyYHTfotEDx9xLQds0ltu8ZQ3PEVfOiE5TlaJbR5
         aXAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGXVpCAMgHYrKHrEfPO1NVtRviYYWvuuAvGVdKYGn3kr0o9XAz9oyfjy001ip2Fjk7RJZ2uOHKIAcr8PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik1UOjXg/ZvNl3T/2bnT+2gyOrQRhmvj1MSiCASbJpvc4EKHT
	fendgNqwc7DZBQKVGMcO9BYbPirWLFMGznEuNg2qDXP9h4RyJVsxPJgmHlDRQPsCJhUevABD3uI
	9BLG6uocD8KeLg73Q7PTn6c3DUDvUnLSLpyFJ7RDoTq/Godjeaisp+RYBdJ8BY0GIuD4=
X-Gm-Gg: ASbGncti1f2vEcmJ9neh41+1Qj366nx4YKBrDoDpTxNJH+fsoHE5+WmvO07XE70s0yF
	PEHwQFcv5qLughk3mCNjt5rcVcbUWme8XfQvgXtjGkdHkDsRu0skY0l50AnnI7CFlop7CNm2OGg
	tDiBg4NBrYRc804Z8+15uUF88J6eALWCVVWXcHgE5s0UVwxr4JUgmY59fEHfjxnbrjrF0baKunN
	+z6g6Uu8+yB3z+1uISHxaGQ3ttJqvMCxVDutOFOtLZu7vOYXNQ4QwA32pbz2o9eUR1JCxDJKaev
	KYEtctbYJ+bfKaulcHHSow8fFRtEZQIf25WyblPaFbTsfh47pYNlcsqm0iy5P+C+yuvXV/Y9ieK
	i6MdYwsQCzVTA2OCIDieXOg==
X-Received: by 2002:a05:6a00:2ea7:b0:781:24ec:c8f4 with SMTP id d2e1a72fcca58-78c98d3303amr13937022b3a.3.1759789221386;
        Mon, 06 Oct 2025 15:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmbjvu8YGs2epcEfo1RGDSZj+PsWdieVwkMJHJiW2v7Dd75B2hyrpkavb8BTk22/5l9Ds/9Q==
X-Received: by 2002:a05:6a00:2ea7:b0:781:24ec:c8f4 with SMTP id d2e1a72fcca58-78c98d3303amr13936990b3a.3.1759789220852;
        Mon, 06 Oct 2025 15:20:20 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:20 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 10/10] phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support
Date: Mon,  6 Oct 2025 15:20:02 -0700
Message-Id: <20251006222002.2182777-11-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VRXYLBnbPsQSmiXfdMFNv5h-vFhGjGZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX8dYpLKIErjwD
 I9feGQmxSDbiD5z78Vv967nVoPQot2x2Wzh41915tbe6b4ClnIr3g8Fs6ZrEklGGDfPUuoVGKbG
 3ieY9ez6Fq5HocuIWYp/dIUiOhLIeXKLUJjWE4h4+kYxmrrUD3pqc87moFv9J2sAG2NeD43dj88
 96xa0xIeNGkSVR72Q97FQ8VykxcWZW4XFoDasL5me1IKqRkE3bIVdYyiAtD8yav3mKfSrfQhohQ
 2HLBWxD64S5MopaOGSRt/E3TUTqtfb0jLVJ1w6nMdKQ+BtSfkR/7FFCaTS6jnpMlEr6lEKwOvnz
 t0eQnfNP7X0HZBY/R43fpNXmr3T1RZSHGlRtD5lyMJ/22+38h3fjRHEuGc9iIhSsyj4fRqwrzHk
 Q/ggZzgg7TF3Vgp4xP0zkV85AbZFHg==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e440a6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Zq12RZiOzp0PcbRnEbUA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: VRXYLBnbPsQSmiXfdMFNv5h-vFhGjGZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

Introduce support for the SMB2370 based eUSB2 repeater.  Configure the
proper repeater tuning settings, as if this is not done correctly, it
can lead to instability on the USB2 link, which leads to USB2
enumeration failures, or random disconnects.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

