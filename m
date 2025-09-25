Return-Path: <linux-kernel+bounces-831633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E163FB9D303
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535124A19EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AB2EAD0C;
	Thu, 25 Sep 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OCaEVAPv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999922EA728
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767352; cv=none; b=q7Q+QtdSLcpBCOPBgTzQ8ZARF3bOxIxGnAG8O/TxxLWeQefNnTpRepV8OI+isxWso5h23U/bszQmmbukdigfcZjXh8w7mGP5WttMhpr+XIVzO3qTPvcYIgX6Y/IJ++kEpBdgLclRFJj4c9MXQ8RKS2sU7P8v6zqoUJAUy/z3oNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767352; c=relaxed/simple;
	bh=KRfbO68RqNXGYUxEscJ9pAB4g2zVH9KTs2sCuSCOkhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fX41K+4lDIc1nNu7oVtH2giASGuIOknMLB3ZE6cjZnqipl9evsBge6wnusL+o8bfOmXpLFGGyUk3H87pHwoCxs4nXOL3W9qtRdscRCkhrnwD1v1qT0RCOIWBhBTttQvxPHkRykM74YMYjAH4ZnYLctlejsyPJfbvJyFWvejV7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OCaEVAPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1T9kB029974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NVYsIQDhA8R
	ySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=; b=OCaEVAPvjxbkklv9I1axjPJpqwY
	ntg5/hTbvGbrGrrgMTERYh1AwxwWOjdIIG9XYAapcHT+TZsvEpr8cbgRu7bSsf/r
	LCbvSfAfZ0cKUyO42gkdOirH1ppfbnH0POCE6oUL65JGEn1vDNy0O7uD5h/zeLTw
	yPYLroGiKlxamAWZ8Ifvsl81/XaBQTzUHFBiF9fCWZ04RTn8IIkcY6v6iigZwjuV
	VfteZF6PqT80rX2VALY6574YKTmX7ftyu3OHzXbL4w+pulc9Xw1TAvCEF3gFTpIr
	VHqzZNu1whzZ2giqQcMcZrPTWfYOkrCBFumugIGz+g+mbcbjoL3fjnVuG2w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpath-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befc3aso506882a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767349; x=1759372149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVYsIQDhA8RySLuD9P7ecPi4IEalfEg3vxqe/TJrcfQ=;
        b=tEyFMkHgdFaQ9Ah8xXN1KvSUtFyfxydbN/VJWLgRZgxBO+YNUjhHOw6FkRSe6sny1L
         meN2NJQwYKb0+mTRMcvyl4Ayt4L7UJsw7KiDLr0AcDYUkssVTENZAvRR89m+n8x4PeUZ
         oSRWQmv3Ix/NHn1+G9ItuBA5KNsTkEq7KfVbJP28NVHp4srOJXE2WEgbOj0ouftcsXGf
         sc3h9ky75BOXSw5h4Ek4jx2cT+BDfAJ8xl5sVuu4XdGq52ZHTbSWxSmJxestsmuX4FGe
         xp+lSl9ABZYC79bQCVXK/DlcoqxTB3ZJeXOXbZ+T4/MjcKmdbeF8vmcVJFaTnQT0l2Jg
         CncA==
X-Forwarded-Encrypted: i=1; AJvYcCXdLgn0lw2OztI4DafmpAv8gkSg7Iv3e/VEfqSZOsjXLCrh7y87oDNG9PU8osVrFSXJlKneGRoQghc6gdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhzi6XBNu9skiqquiGGg18C8Ch9RdE7PW+fxU+CuT5uJZMeVdR
	SfDLJ0YXi++i2eDw8a8irE7/w5psgvRIt7/CPL1HseunK6Lhzhjqaev24H9IQrM2MXyopZJGLNm
	hiXrVsp3oLISi7AJ9LypwQ/TkbtUUf8qAmF2T03ngmFS0rS4ZKuH3lYy010VftxXdOjc=
X-Gm-Gg: ASbGncusWrTIkHI68WeoQ9UJLydf/Dzmmqu8YypBAXpiTeq9kor8I9E7FcEkVMWKnwe
	asppPDcA/OWQOB0Uq0lL5cW71Ujp1vEdd+uk8tMOFCNf+3XUYXxzwDjDEIn4bkhpAlxtV+IoCou
	2SDNdSAr2uAnQWIsxRD7IbWIBmlQE8k4873FN9Iiw6AySW75v4Fl+BKz8O1LVi9aKIdtUl9f/6R
	7AKoD0E/tNrRMq5LJs/tXdtEKklxoO7SiUasvng8d/8Uyf03/leQYb5QFiGZc/cDcmqTtRTuCFr
	U1XQT56ZsCvobHZNgdbeQwENbdOQx3db/x9BHKrTzMUV1Ej9QfLMVtpXqVMexcy6kQajIPUyjRE
	R1VwYEwV+5aApFNJJ
X-Received: by 2002:a17:90b:4f47:b0:32e:9daa:7347 with SMTP id 98e67ed59e1d1-3342a242c87mr1559898a91.7.1758767349153;
        Wed, 24 Sep 2025 19:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECLCA3QwbkNEpn1Y33npnCoVwb/JYm/tQthSgy9u+tUbbw0LDLNGOOwLt4aOYfh2ilmfQULA==
X-Received: by 2002:a17:90b:4f47:b0:32e:9daa:7347 with SMTP id 98e67ed59e1d1-3342a242c87mr1559869a91.7.1758767348709;
        Wed, 24 Sep 2025 19:29:08 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:29:08 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 10/10] phy: qualcomm: eusb2-repeater: Add SMB2370 eUSB2 repeater support
Date: Wed, 24 Sep 2025 19:28:50 -0700
Message-Id: <20250925022850.4133013-11-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zEaL5fG6K51gDt9wBTQvj-B2_2WGP7cG
X-Proofpoint-GUID: zEaL5fG6K51gDt9wBTQvj-B2_2WGP7cG
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4a8f6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Zq12RZiOzp0PcbRnEbUA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX/k04O/ESeb14
 nGOj1nsRw5kenIZ2AtT2GISDkiv1XtkbcypUcNtMRnxDuIamoWDMXTZwyI4rewDGkizXWt9HTPs
 KqLD1uEQMUdurvhw29qdSsfxkkpuN/K1W4MtmIIih6kF4E7jCQVqWJIVWvGC02kiNXAnnEl/luV
 Y7pf76FLFVvKL8Dfdtu5tVeD3/60cpVf0+NSqWqG4ZRCBTBQ7jGCE7cZHsCxIDCIPRG7tm/7OVn
 GBogiSvYEjvR+Fn5zKmKW/V5gUf+aQa30uLl0zA96DvqxZYtBgpa0HgHP/6+8yuzvdtchFAijpE
 zfgOqN9GQMP9qk39I6SVBiSHRYjhJd7+a3/W5biSwuWS9ZfdOzbIgoxFErbJ2GP0DQjYRgR+TCd
 5otxV345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

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

