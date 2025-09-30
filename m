Return-Path: <linux-kernel+bounces-837143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA162BAB855
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347EF1898089
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ACC272801;
	Tue, 30 Sep 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikP0pt55"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354F279351
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211399; cv=none; b=HydL12BgRg8OokU7l6b6/FcR3g8auuSfZ8vdfvHsqECaFbIri9DJ2POy5TBLw0kI28IiU1jj6hG/jNig12zHy+7ct4hkS0b3+0wZKQSlA87dwV8C7F4Qq9szIKM9JiEDzjq9tPYu1F4STQZaYynxL9MQ0P9bK4SvpYPnc/3uPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211399; c=relaxed/simple;
	bh=rhJzPiPQh5PalUiLaJWP+g6zLitXs96Hl2pwoOg/lyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3xkCFfRMIHzVceQyV0FQDEFEKTnH97v2VXTLE2/fQxJ2ws0gu4tADhItQX8RoAF1jrmHX/Wg135zoMpYxnwVWPvIPLimc7I7dzjhFlNFTcJbdRyTSNH7QJ3aLFcjZT7Dto2cVQeKQMI3CXJcqDXdZ4fIHdHWwZQ5zENORV55OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikP0pt55; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HS4j020349
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThoA6YgpQiOg8S6pzAMpUUDGjl1Y3c4vNGfbI/06aRg=; b=ikP0pt55wblcGL3v
	pJdyHoy3ltPtPgHrg7x5YK6wk3DZnBbZtbTCsNBUpJASn4/yOXv0dSU+AyjANCxU
	nj/aqmoiwRw9ENISV+v+QDdK+bU3eR9KNmDaVc7DD/RdkfShJVCcO9nipftiHsXm
	13INjcakMMRUtBMqP1DgqeI9+kZATrrlKxc9Ra3u45YCrE8nYExt84+ffuE+tLe/
	X7E2eKsBvYJa+KW/BAJc8QYEGkRtHAMSvTSOYNiZUWyW/UTCPlPriDvG5C6JE6/l
	XlbrlmdTY4P2JwqySqHhWcCr9I+vZD20L41kvtGuFP3H6xqCpeva2QCG0BzFBBw2
	wTh+ww==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5quhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:49:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so8787041a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211395; x=1759816195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThoA6YgpQiOg8S6pzAMpUUDGjl1Y3c4vNGfbI/06aRg=;
        b=tJ1XI2uah+W5ioN1K4LxpNHRQS06b328B+0WVRwnzu6ZebKk3QL6pO+vQS2fV0gnMH
         wh47+UD0PQ4axFFR8nLTpOxmXcAytultueV7HvvlRgBmtdtY5YzZi3Ht/1hmfPmFAHxL
         g30ZgP7aBjdWS78GZbCel95nBcIvrYohzZYw06ZWvY6ZywEUA5YX5Sx6NM4pN4VOjnme
         pHPk56KpQST5+lyS097q+u7Br51xmtb/mlXLoiC3Df9K2EZNY9TpE8UnFkM6U+SsH1+a
         GBW8HKKOa2ZkMRa4SERzNUbhculqjJBqyi9opLJDE+Xy5b7k92G41LlfLJhnEEekaGrN
         l6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUiFPINIoNPRzY45t2Uchqt/jaOxNrlbbCcv2nlqfPPWVdzmL96nhWJwCs1zh7/qZMTzD6ymHls10zQO+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NJzT3LdTTHdxgg6QZ8osxMp1qTfN4kWeCY0gSDOnSt0SMbue
	n0dY9cqMEw0Z2vcCr4koojdUyoqs10OG1+RgSDaQZpecAKnMaOdcUDOBUrMsJ8cFxIhm/PbJ6gK
	7AMOZl6/s7rG+oxW7fmTr5ttfy8Ed3iKJTst73Yq2azLH10SifveuExUFNMFW0nwbgXQ=
X-Gm-Gg: ASbGncveUYvb/A5kd0LaufoGjaNsi00miLNkK624XCD6+fgpGCB+0fMPb8M+AdEuNNw
	1xBFs4h5CRjI/iwfx/XqiX4iJ3U3g8hlsniYw+SuFGc6ukT1B71vs5e/HQhGoDEuJiOThybLOq5
	Ng0P4kivMAgyL5kC8LAsapo+W8nLio0u4vq8yHhDPDCev9h9wMGRLf+jxODGL6n2rMG8XHJ7bui
	d53TgaX5n182iejIX0zOMiIgo0G4lbEf7gbYJBCMsJ/gCwi2JryVVMTNt61/osbDm9qKMSnFeHH
	2ajt+UcIHGZGQxWHw3gW0mcDAkb5lbI6HXfJRsCuPoXCp4DJiQ0hppKnsiTpJJWmaRvSeQ==
X-Received: by 2002:a17:90b:1c8b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3383cea6105mr3192212a91.31.1759211395352;
        Mon, 29 Sep 2025 22:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9p/WsjalDYjqqBpbBM4tMRq/jOyQCCf1RPlU4hhSKxmGGZ3ERYmjP7ysuZxVehRilUdsXhA==
X-Received: by 2002:a17:90b:1c8b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3383cea6105mr3192176a91.31.1759211394945;
        Mon, 29 Sep 2025 22:49:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:49:54 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:06 +0530
Subject: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=2182;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rhJzPiPQh5PalUiLaJWP+g6zLitXs96Hl2pwoOg/lyo=;
 b=xbW+/WfyGkVXE9qGR4vL2rV53p7Zg5bR2EqsFaz4PwejCII1l2bWl8VOPhhZuVJqksSfryW49
 6muGlSfGBPvAAZf7W+0AB1ZWW4WLIyqkaz4FRTNyzyZnC7VOG5a7jD3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 1mrzN4Mfy1orRYIbGRBU-gG8vbDHqu_6
X-Proofpoint-ORIG-GUID: 1mrzN4Mfy1orRYIbGRBU-gG8vbDHqu_6
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db6f84 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HBDVfrJ52KAmvMVrQVYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXzkIdPKTe6eYn
 J7c2W5rvBaf/LIhJqolfEMIKUk+PaMIn89Uq6iTsQ7MkNDfNgBey6M49XGISUBdKTI6Owbbj1MO
 FuzRMUtkOSLKUixx43w82oTZ9QlnwU5SA13P2rfxx2DX7T4fIhLLsB0CzQZuSRtrTNCa6eaT4ss
 HFSossauvYHGyZIUB4qYW21VnS2T457TkSIFtfy+rbM2pNdi8Ffrkk1idd9n8II2flyTu1mpGW8
 B/5ivXGcxKqjDStf0XLLWn1Nu0Mafc2noY/cTo8Z3AY6w+6o7D87Opo8O/M3suXvzEhhcIVOPB1
 niE2gZyK1ZFG7QI1wAJR/zdvK3p0tQZKm+dWYDH0i1tcm2UZVwnQdsve4IxDIUYoAtPZMWx8HoZ
 77MCfz3II0Q9uZrStl9GUWeo/YXrBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

Add the ubwc configuration for Kaanapali chipset. This chipset brings
support for UBWC v6 version. The rest of the configurations remains
as usual.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 11 +++++++++++
 include/linux/soc/qcom/ubwc.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 15d373bff231d770e00fe0aee1b5a95c7b8a6305..48dfd76efb34319b3cee29894ee4977f105d890a 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -16,6 +16,16 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 	/* no UBWC, no HBB */
 };
 
+static const struct qcom_ubwc_cfg_data kaanapali_data = {
+	.ubwc_enc_version = UBWC_6_0,
+	.ubwc_dec_version = UBWC_6_0,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
+	.ubwc_bank_spread = true,
+	.highest_bank_bit = 16,
+	.macrotile_mode = true,
+};
+
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_1_0,
@@ -223,6 +233,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8026", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
+	{ .compatible = "qcom,kaanapali", .data = &kaanapali_data, },
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 1ed8b1b16bc90bea2ed54586edfe21beb2db04d4..0a4edfe3d96d4face2ef98622984c66939a68c53 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -52,6 +52,7 @@ struct qcom_ubwc_cfg_data {
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
 #define UBWC_5_0 0x50000000
+#define UBWC_6_0 0x60000000
 
 #if IS_ENABLED(CONFIG_QCOM_UBWC_CONFIG)
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void);

-- 
2.51.0


