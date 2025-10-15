Return-Path: <linux-kernel+bounces-853644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B78BDC2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BDD19A11FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072D30CD9F;
	Wed, 15 Oct 2025 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjH63oWy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390730BF76
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496164; cv=none; b=S2blirdqcK9zXxwRbUJcHebgP6ONXgeEqiGmwaDNvm3UiU6wm0mMtqVFZqi50OeUObhFAI9vg1s6RsoEFGVUlj7bXFWDwuEpJFNVB1n/kewGRcL8mUyM58i8G65xc6wOhTAs/9EtSgayma2EIXiPSEQBJZICjPS6S9I3HGh25f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496164; c=relaxed/simple;
	bh=/6TPoOK2H46ODoVR5vH0U3mZt/KkWJx+/Oa6plnyqHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tp8a7ST0Qs25lFy2dTy3563gtxHF+jOQsJhcCrGpDgb6chupBQhmifbnNybzUh8A9CY3ialqy6+DJCdUpc2+84o1mVmnaLfgYlw28GBiznq5/W8u8BiKyX0fX+1I4NlbLnMDQb78Yz/CXHiNF812UB9QdyDTzMIZk2Lz5TDpb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjH63oWy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2dQ4X019021
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dOCcVsAuRxmu1r6muulhHh
	87A+yiQ6uas2Eu9RO3UAg=; b=UjH63oWyXxi0phUyzS4u13zULHUEaOQm7/ETIu
	z6wekMrqatX5BiuVYg2yEF4iF68lKCd6BvJYQh3fjnbxde809CMxKg/zZR8TpsRA
	xFx9IUYsqc4hUPP1PpM+qmm7jU294SI+FUSrnK4oYVLdY7g5Ri27pQnPwN39NGkT
	BWFmfwtuRgWjtFo++HSo0nkv4slxeGESa0V2rBRJHqNkQ9tArDeraaP1EOf3d4zs
	rlC1b/0pH40t1dPuiPw+1BLWl16CBL/8Y+H0QuzZqxKz/XTho0rVguOxg7tg62mA
	gXnNLsGEq0l2a/wlEgDwtq5LFSe4/uzZ8zng3Y+AQNIGHNhA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5jvch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:42:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso7834607a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496159; x=1761100959;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOCcVsAuRxmu1r6muulhHh87A+yiQ6uas2Eu9RO3UAg=;
        b=IgEYQgtbqB6HSVJ5Lj7Fi4VWRGHq2djkBdxiXAnLaH9g+wZCGmaVilymQPtw8kAhcf
         DKRA/6sd0F8PZFotXVDKMjFvJD1zJ0g+ZQ0K5LdFwgteWNNkU1S+4Aerr6+kytd0GImJ
         4g+oW+NxVuoO8DV2W2dnfteTBMxlGkyRvd0vjMkrdfWpNux/j5v/9bCvAXWMobLQblKL
         gXVy2rSKRJaUMzjrOJltlmQs77I/E3eo9d1sxc3IxVqF2kppdN/CzF2uVH0qUiY3f8/y
         0pJIZ/6ZHxNqRxttC/8Z7AQB6wpbg9pZeWP6C8stEZgD8bUoVXSneDagBYd18q5CTNd+
         x7DA==
X-Forwarded-Encrypted: i=1; AJvYcCUltKmDXMbM6BxDlp6efs+AzlHls8Ql3BYAJkF4ZIbzLUdIGNqgxuuiX+1a2uOn1etv5EZFG1MlLQaW+vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lsORkd5dXOUTd1+aE6xJSpEOQzn9FfkQbUos9hxsTG2rFII6
	CK9/W6ir5mTQg/7/CUE//9DN0jwVvuSiKeXuENI+HmvcRZ7uHkzMm/LMX4XTTQFDYRecsDRmJBO
	kNLD3wUggW+Vpklp6bRU0w+uq7qTCmE0CdHB8q1yXwuS7PP5EtaO62f1wk8afC+2WQ2Q=
X-Gm-Gg: ASbGncth+vdwfbbryiv8jN6AuNtQsrR7fowGz/FIDXTQv21WCx/8iAc0N7lgVY7qEne
	XBXdlr+SSSz8fLIKRjV8nxr+uwo2Yaq2khFE0aZsTIPIDMrWIwYqV4XQLsNMpWKejg1TMnrtui7
	0lOVYhciUILmZHuuNn0Kyt8KaN5mk2mPgvdlH1atOfiwtif8vUBabJ56oLJ0fPgJSUf8qbbNiKH
	bwVZCyFs+WnUEWA/hUatTED/rQsdSnXlcKFO84olQMoiWUQDWMZdHaoz3LFndb+M2lCKQLUALXJ
	bEzz9WOqQ8DGQS7Vk6WrgPMbB+wQZ/+CgkhAocuDL2v7ifmKEcM2y282XMMKQ6RRatfyMTPZebb
	1JgXOtMavHkDtGyGrjlk=
X-Received: by 2002:a05:6a21:6d93:b0:2f5:ba02:a2a2 with SMTP id adf61e73a8af0-32da839f958mr39408101637.36.1760496159186;
        Tue, 14 Oct 2025 19:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVDUEuabDTwYSs9PWSrrtbuyqOQI43lG/pFTuKEjT/hk8Y2pr3EkOb62jBuR5TAFgHA/XjeA==
X-Received: by 2002:a05:6a21:6d93:b0:2f5:ba02:a2a2 with SMTP id adf61e73a8af0-32da839f958mr39408069637.36.1760496158707;
        Tue, 14 Oct 2025 19:42:38 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddcc604sm13174412a12.11.2025.10.14.19.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:42:38 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:42:30 -0700
Subject: [PATCH] media: qcom: camss: Use a macro to specify the initial
 buffer count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABUK72gC/y2NSwoCMRBErzL02oYkfvEq4iLJdLQXSbSTiDDM3
 W3UVfGKR9UCjYSpwXlaQOjFjWtRsJsJ4t2XGyHPyuCM21tjHY5GmL3Eir3iTKV2VbJXMYyUSLC
 MHDRioGiONpx22wPo2kMo8fv7dLn+WOg59LD/y3X9AIs1TTmOAAAA
X-Change-ID: 20251012-use-marco-to-denote-image-buffer-number-cbec071b8436
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: MLCUNW1cNteWJQZQ6TvzCgkSVN_wd1IJ
X-Proofpoint-ORIG-GUID: MLCUNW1cNteWJQZQ6TvzCgkSVN_wd1IJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX5mLspvo4WBA0
 QZJG8oS86tHtQQD7kU8JaNopmhMSzg30ZxoK8ckU4IofW5rBlwIx+N4hPijuf8XVg918Yj34Nzi
 Wk6o84TTmRZdHetIVvoXOhD7APs3s7MxANQeEOHvbIO5XfiNsWjCywm3Bz75kuZGK2nwrABA8iL
 RNfD8CbXNZj1bB5LKOoFUpWxJ6as+mt4nTaPe7S3qNhTEZY1TadKj48nziKEWRZ4sOUcsfd8vbf
 vZcar+eFSTfJ8dHlIPkQQ7H9ISyG+dDUTG1OzzMACZOfBV5luAd5ieb67wmX2GUnB0GvVBJ+8hu
 SxhAnaayyZTnsFiPa3pdghsVkIl/au9jY1RHoaS5JlZfv0VcZM87hiOV9rlP9YpvmcwcsAhXAsm
 zBsCKisXk9xEOrAZynDxlycdoWPyCg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef0a20 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=z1bv0FqhIyCrtqLIgW4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

Replace the hardcoded buffer count value with a macro to enable
operating on these buffers elsewhere in the CAMSS driver based on this
count. Some of the hardware architectures require deferring the AUP and
REG update until after the CSID configuration and this macro is expected
to be useful in such scenarios.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
This change use a global macro to specify the initial buffer count. It
meets the requirement that some hardware architectures need to defer the
AUP and REG update to CSID configuration stage.
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 2 +-
 drivers/media/platform/qcom/camss/camss.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 09b29ba383f1..2753c2bb6c04 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -541,7 +541,7 @@ int vfe_enable_output_v2(struct vfe_line *line)
 
 	ops->vfe_wm_start(vfe, output->wm_idx[0], line);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < CAMSS_INIT_BUF_COUNT; i++) {
 		output->buf[i] = vfe_buf_get_pending(output);
 		if (!output->buf[i])
 			break;
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index a70fbc78ccc3..901f84efaf7d 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -41,6 +41,7 @@
 	(to_camss_index(ptr_module, index)->dev)
 
 #define CAMSS_RES_MAX 17
+#define CAMSS_INIT_BUF_COUNT 2
 
 struct camss_subdev_resources {
 	char *regulators[CAMSS_RES_MAX];

---
base-commit: 59a69ef338920ca6a5bca3ec0e13ce32809cea23
change-id: 20251012-use-marco-to-denote-image-buffer-number-cbec071b8436

Best regards,
-- 
Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>


