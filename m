Return-Path: <linux-kernel+bounces-866587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B228C002AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D01889626
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B22FE585;
	Thu, 23 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGS8CuAo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958B2FBDFD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210890; cv=none; b=syJ2rRppRa1A6+lPaPkWPQEe77HxrR0XOmEA9JNTZDUzngNepBe2a7IITC+DzyTw8QNIjOFBT/YYdQvcxwqFMAfkP8ob4HJQ+6a1mXbPxb8cdCZbU8ajuQmQ+FklS3eR6UagEcBpyGGk3PcuGpChn6ytenyaD+Hh979FfmlMf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210890; c=relaxed/simple;
	bh=p8ySBPeMhhgOjthdspe7wrGny1MNgnBjciz9CWlWZqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRyDjxDw2KCoXwoBwr54JziyYsiWQzibyVFEYjfz/y2l27pl5ytgls8Famq6A/SijRTyMvGi6Y2UWdioeGOEcYn2vmwX0yza9YdJPt9HkgDpf5REUg4gz+asYfPQVCjsJaplt5eSKdep46C7XgKtcjKcrCSzQfh9ye45DF1SOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGS8CuAo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N87Fgo020803
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rGA6jyIhggMQN7nzJCboVgsPOrhbc0c0lh6rLgR6WNM=; b=hGS8CuAo7fLi9wKK
	SXrMos5CUSsVLapIEvG1Rwe5kH7FNnE48OiBk6lR0gj0qD4ykwpHc5SZm0nPMUOC
	Ce4SxL097iIdKlo7ZpKNT0LswUIfsApTIkru5wc/ChwkqqudISz2WongRXNu8IkZ
	zib+oYjDRH188ysY2S+Okx3WD/qLlQXjtDWeedJOU4/aXxCaJ4btvmtvaPd2+7Zo
	X9M8Z+TZ0Ya/5z3E6XCdqXaGXUnQ9E93NwOPwgvCfKztYroo9LUe75jFtRoJ7Pdi
	8+JKD+x4zMQa4Lhz6zVGlSiMFh/BiVqSIkHOxGqBj7z5rmGZKaoYfmUEpn1Y2QxW
	DXI6HA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qhrj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so535909a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210886; x=1761815686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGA6jyIhggMQN7nzJCboVgsPOrhbc0c0lh6rLgR6WNM=;
        b=mCXeqX8FobkTIvDqsk5RSGHT9XhIgwznCy9e0fBQl9TOAl0AMTiP/Q0WQY1KSI6dNA
         OKplemSSXPfKAqSk0OxUzk3BiorwL2I89jIrXnkhPneoA4sCv4ovNBXX+5weOyCuhcwY
         6MFceSxNW2K2Kf9SL283Bnx46S8caJANYy420DOQ33DcwPRZJVt0MwHTUOK8T5PVvdbg
         0Y92Dd0OZqkILK/zdAMLUBF9lIEMP58oObWwWA2Vaxu8CKo/3RdgxzbLvTqmElsQn1ks
         WhtMi57sBWSAPaMC/7LIZb08P6gnka0oglhZA/qvibg6SDPMocuVzKXLiTLs79CBdmor
         CWTA==
X-Forwarded-Encrypted: i=1; AJvYcCWzV4UO7MAZyxqcTBqXXV0Gnay1DwKtJlpuaK8AqcjBXT1DL2S9h7C/n/hIP/HjfqC4WSoBUSozEL603HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlAWx/9xxsRCQ49fnNU6pYANSZrsyqgSWSAJCMj/RbuznaLur
	Kp4u4r9xEh61O23W9XYvP62g8EPcex+tN+vnGBxNDWwEQPxZnsno/8IYHZNOlLWasZ5PQM8IPgb
	+cSLWOjWONUO5QzlWS659BN0Y318h16CCZK4zH/GqTOxQgJ8h6ZuB7ChZYkbvzDots3c=
X-Gm-Gg: ASbGncvphrgn6lqDh7y+TcUM2T0akvA+Id/Wt2aeOxOH+Tt9wOJVWEICYKteP9MfnLi
	P0+qXNk7y9eYgN2fhru026PEKZ5e+t5//YrPgqKcQ26qLmJE7c9YPQvvKSfMa5yRErUdC1eTdKC
	+sQifqSmWEpx/EL0s23AQnCsdHCDT0QZS8iPSk4pRBymJ8LSlBBBG14gQZGl/+3lSqEBmYFgNwO
	JvN/LF5ehD3rvWiNge0ktvnmVUcw1+wHmrSb2F8mWQodPpKbbP0hol5vvEkSkmMUF+LgliDlxnh
	D4gklNoy40cYyB8nVNOdMpxBFUerAjynPLDHe0+mQftY6XauB2MP/zZcWK+RdfHvgbHFc5M3KNO
	6ipjTHKHTLsb9D1oQQiuZPdJtoKc3f87Hk+HOsiE57Yp+UuzaSRYpnA==
X-Received: by 2002:a17:903:2348:b0:290:c0d7:237d with SMTP id d9443c01a7336-2946e0ec1bamr20297315ad.36.1761210886114;
        Thu, 23 Oct 2025 02:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYmSv4dzjKvhhMBl2sFcfxbzFtb5/wLQ0uyVcJuavpj67hpqEsvJuFLylB5+oHXs3MbJxkBw==
X-Received: by 2002:a17:903:2348:b0:290:c0d7:237d with SMTP id d9443c01a7336-2946e0ec1bamr20296985ad.36.1761210885654;
        Thu, 23 Oct 2025 02:14:45 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e318a2sm1490081a12.33.2025.10.23.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:14:45 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 02:14:35 -0700
Subject: [PATCH v3 3/6] media: qcom: camss: Add Kaanapali compatible camss
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-add-support-for-camss-on-kaanapali-v3-3-02abc9a107bf@oss.qualcomm.com>
References: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
In-Reply-To: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
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
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX1I57PqmmhliQ
 nt4E+m2LqrP0H4BJKS08SYQGyUutAYTucV6B0ZmMkGoWAYlRLPXULjemB/V1dxFu2C8RCgqDmZK
 u+pyz+o1loF0R97qFOz0eGNE3eYlF8Y4Fa8itBiSklq7uY5c5Y5RiDmjDnTOkNO0oid//fq7/0c
 34eoK6SE9DcWaBqynArplK3C51bOUATgOwuNEaG0MSHMGyG6tNlAe86r7MUvVC/WmwVOnBhYZLr
 olgkyzildgYANvzv9or5LEZ57ZbeWTJ1w/Ob333WVmPAW41uL6F3t9ZnkjfTFQ4KxDtt5Wijy1z
 BM3fzMy0sBkRG4rhwzNVE2WO5VFjc4qCKtjx25M26X2x4/6gvUrVQz9NCchWOzSpQ5XeKrzMhY7
 NVwnHPZOazaZgtLcre30tfxyR4cN1w==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68f9f207 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Eph36bqoL6-XvbZcx_wA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: QUQ73UV6oFw-jO6nmGK9z3BTWsCW41AH
X-Proofpoint-ORIG-GUID: QUQ73UV6oFw-jO6nmGK9z3BTWsCW41AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Add support for kaanapali in the camss driver. Add high level resource
information along with the bus bandwidth votes. Module level detailed
resource information will be enumerated in the following patches of the
series.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2fbcd0e343aa..658d9c9183d4 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -34,6 +34,20 @@
 
 static const struct parent_dev_ops vfe_parent_dev_ops;
 
+static const struct resources_icc icc_res_kaanapali[] = {
+	{
+		.name = "ahb",
+		.icc_bw_tbl.avg = 150000,
+		.icc_bw_tbl.peak = 300000,
+	},
+	/* Based on 4096 x 3072 30 FPS 2496 Mbps mode */
+	{
+		.name = "hf_mnoc",
+		.icc_bw_tbl.avg = 471860,
+		.icc_bw_tbl.peak = 925857,
+	},
+};
+
 static const struct camss_subdev_resources csiphy_res_8x16[] = {
 	/* CSIPHY0 */
 	{
@@ -4291,6 +4305,13 @@ static void camss_remove(struct platform_device *pdev)
 	camss_genpd_cleanup(camss);
 }
 
+static const struct camss_resources kaanapali_resources = {
+	.version = CAMSS_KAANAPALI,
+	.pd_name = "top",
+	.icc_res = icc_res_kaanapali,
+	.icc_path_num = ARRAY_SIZE(icc_res_kaanapali),
+};
+
 static const struct camss_resources msm8916_resources = {
 	.version = CAMSS_8x16,
 	.csiphy_res = csiphy_res_8x16,
@@ -4467,6 +4488,7 @@ static const struct camss_resources x1e80100_resources = {
 };
 
 static const struct of_device_id camss_dt_match[] = {
+	{ .compatible = "qcom,kaanapali-camss", .data = &kaanapali_resources },
 	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
 	{ .compatible = "qcom,msm8953-camss", .data = &msm8953_resources },
 	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 901f84efaf7d..876cd2a64cbe 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -90,6 +90,7 @@ enum camss_version {
 	CAMSS_845,
 	CAMSS_8550,
 	CAMSS_8775P,
+	CAMSS_KAANAPALI,
 	CAMSS_X1E80100,
 };
 

-- 
2.34.1


