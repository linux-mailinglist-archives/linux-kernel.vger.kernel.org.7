Return-Path: <linux-kernel+bounces-863715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D94BF8E87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1015003A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783F28A1CC;
	Tue, 21 Oct 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hh+G2pAE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9B288531
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080957; cv=none; b=f5KiSCOxgLIYaHjHFYriuHn2hDAkzmvmu/Ny1tFzmFDjIDCTumnVnBrm7hIfia0rG5JYcI+d9RMb6E+BrggPV1EWYjcuUSE06TFOxN4mSjohW/d4k5sI5FXRs5s0lkUGYuOzIbKcEl+Pi/zqDLFlDy4Knuwv2JC8QG8v9QLynXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080957; c=relaxed/simple;
	bh=QNvlniIPRRmC+7hzmYy/77uxWdyoOFIOrKIrPOzfp44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkJBOpQqGyjXgJG2FdE8kGubfNIEG6cFeP8TS8XmFCklvlUh42FOs1U+HZ9H/nVirYQ88Ai7y97DDMAfudvkq0tz0iiWY/DAgTfBrcEPhllxJi6Pu3B4UORZfLbVwFGSZUPK0BFPULP8SsxBH5YuDmTU5eWQWGbcBbmde6jiNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hh+G2pAE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFBRiW027492
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CAALojfa9D3YOG9vqJaxSjRtqnXPbgz0Npkm+sxU7tY=; b=Hh+G2pAEmJ3AR9Cu
	8BgjjVnlB4kFt/846t7FI3dL8WwgOi+z19kkrww5nwl/Cv9bFPNoJefnt7W2xC4A
	RtSA8MubZwtcpUMzRDfmaUq2hE3cklZK9NytC9le1wCp4kI2+0WNMri/8sBCLsSO
	EfGHHQ+AriyiIRXbEeGF1VUmmyG0AHROwMIhFWErffa+dRa1ojzroMxGayPKba8m
	xQDuldSdIDvUVMQppilR0X7IErGcR05QmvwvX05ZQYOwWgdQ+tT0m8PErKznPVJV
	wx5uUmur9vJryRX5EKuCh1mMgfE1a7z15amNBKIMIhpRb2Yoiy+RsLyZ0hByVoXr
	NSGKjg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j28fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so10036559a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080953; x=1761685753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAALojfa9D3YOG9vqJaxSjRtqnXPbgz0Npkm+sxU7tY=;
        b=IZIh/XGzoWKPvZ5WxpOwkPUL2p5ua5/g7NTi4Z6qU/OReOIEDiSsxxIJZSJVX8Ykgg
         kXblgBusqptTUyfTFGEKpGJssKXUkwjXmc1fQT4b1pU5ctgE4klhADk6BMNHsL0VoHiW
         4rzVnP2smxtNGczK1w+ajt14Bid6b/HdIfiBOIaRZOOVE+3x+nOhm0q9XqGVEGNnhlrh
         OgbPLQKkW6lKtFiOwNhT7hTBwysYCKXW5LA1vhliFnzBp2zyI1OKjBembKGbnMc62W/e
         KDCtyC5MJ9nhafZ+38dMKmiTTRXVKv9xufaCJnSICSIru3rirwIczyy178b19FG6cQ9e
         X+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWPFtsRIC2ZjROo83g2h12spk+3BWgo/F1d3MqLbrHzc5haSUCSLfuCtCjDISzhBEiJAlYLkHRjbs6faLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4dp5doVn0yDOeVGt0rjmFfEaTRraai3QnBwDUsmSB0CuLBXx
	Nb+VcfkLe+8TFPWykwAONlDRuccLmZWPEbHJLfH+gHLYdK1P9JYAoiB2oazPL9ntcx7n/pTKNFh
	qC5Ef79hI2EiOmo5vJgsM5DMYcT9eNheqJHoCYhqv2l2IYo1XCLRZQQh9KpIgx3mlG2Y=
X-Gm-Gg: ASbGncujxd3iFotxFGwRetRsAPkyUxuXVDI2E46i3bWglvEqE9gXfioIxBHcNek879I
	SZnSgUYPSrdF99ueeaKAYGF8Bq1M3PxvLByh5vpWh8/vvK2TNXoPtv4GWoOWXUQOrwT0eOtVelO
	4VN5wbMoATS8crZh95nW8chsINTcnBwakoZJnVnc1h0aTONsPAST1763oWt2ON5QV0uw7QU0GJR
	HHxRdR1eXNM4i7UIzJ9bQJRLtqxYifG6DzkDijNLg1YCGOrUxXqpH9JE9EpcSjkJTDj+BElCuW2
	heHms2cOgnO3SHQx8Uw+ZNGcOxf/o7KvOGJ/Isj7o4UjeqKdYRhRccEopFT2V/5syXjVqd7YX1s
	Kxhs/LaDKxE2q6CNcyToH5YwYHppdC/p0GZSaByEY8ZX4m7kaHANViX4CGQXG
X-Received: by 2002:a17:90b:35ce:b0:32e:32e4:9789 with SMTP id 98e67ed59e1d1-33bcf84e176mr21316827a91.3.1761080953167;
        Tue, 21 Oct 2025 14:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMpbS44IxkY7rp0ciZyWybKD9zdWqN+g8eCr9evFoO6q8WEg17R5Ttb5DQ0qQyfb8I4IpyEA==
X-Received: by 2002:a17:90b:35ce:b0:32e:32e4:9789 with SMTP id 98e67ed59e1d1-33bcf84e176mr21316799a91.3.1761080952712;
        Tue, 21 Oct 2025 14:09:12 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c813fsm489833a91.4.2025.10.21.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:09:12 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 02:38:56 +0530
Subject: [PATCH v2 4/4] regulators: qcom-rpmh-regulator: Fix coding style
 issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-add-rpmh-read-support-v2-4-5c7a8e4df601@oss.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
In-Reply-To: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761080935; l=1302;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=QNvlniIPRRmC+7hzmYy/77uxWdyoOFIOrKIrPOzfp44=;
 b=5UlbwWUZKgBli2eyjUgKM7AA8obLevlo8qUFii1yVNx/DPePcuttzmnMHl5bzY3kc+H7FcJwN
 mkbLakw8LMcCnumNA9UMb7LPP/eEF2cE3ygIqkuW62C0kO8ECmfzyXa
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX8/kA1xDSpGKF
 u4sy57Q0Y3Ndz10xcv+zGQ8jyHkQEgjDJo/K9loAfb03g9Zvhn9A/MxIpEcVo24k4TqyWMAecSI
 I2pkJ0paVuIJuD8jkPtnH4MWOr+d/mSgUzwHJLCxEUYyY/YCe7UuXPYTBXMx2iqVsRFrr5gXDkH
 SW015d8JTJJJ6U5gfIpfb6e2lHwPXWtXBGvgxyohYRoJfG0cYI8IHIiSScjako0+K9Y3JNoTVfp
 CP6OzreGKYDEebHo29wZucUCBE1dpIHbHPu3Gvx6c6bHXET6gscBE9b6R/BFemf4xN/0sCCM+67
 T8hrHdXJ1+xqhQOnR3hUymLJ/bH2BsGsnMmtXi1ECy2W/AFKYfgweUu224T8+GNpdlZzsvBp/Cp
 t1+5+1JIFCqlPbArZ7blvbJtK6KYqw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f7f67a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TeyyAU4cBfKQF1pE9E4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: kINHMvT26GlxbAlDiV4lxjUtAiWOn9Et
X-Proofpoint-ORIG-GUID: kINHMvT26GlxbAlDiV4lxjUtAiWOn9Et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

Fix the code style/format issues reported by checkpatch.pl
script.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 9f693043cb87aa77a7a529b5b973323450db80be..6a36ef967d5d9e32c005e79a12099ebef824842f 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -109,7 +109,7 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
  *				regulator
  * @ops:			Pointer to regulator ops callback structure
  * @voltage_ranges:		The possible ranges of voltages supported by this
- * 				PMIC regulator type
+ *				PMIC regulator type
  * @n_linear_ranges:		Number of entries in voltage_ranges
  * @n_voltages:			The number of unique voltage set points defined
  *				by voltage_ranges
@@ -387,7 +387,7 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
 		return pmic_mode;
 
 	if (bypassed) {
-		if(!vreg->hw_data->bypass_supported)
+		if (!vreg->hw_data->bypass_supported)
 			return -EINVAL;
 		cmd.data = vreg->hw_data->pmic_bypass_mode;
 	} else {

-- 
2.25.1


