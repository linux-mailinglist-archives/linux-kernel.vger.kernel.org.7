Return-Path: <linux-kernel+bounces-879436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940CC231C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BC5424090
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AA19FA93;
	Fri, 31 Oct 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+9/4PUX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMmJqbKF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238A310762
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879618; cv=none; b=kQyZ70nrBGuk1hadzF/Go/117s+YJ3jaV6b1BS0gcocAktQ2CUzhJC7WNxyhio79YtQxeyDuFEflxP6H9S5HONhpPRFuz9Npa0vgagBZimm8kRxYyRdWk4BS1kanbO5d4+KFIgRvJvxWVgSvjaWSi89s5QotkaGagDPQAKvueUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879618; c=relaxed/simple;
	bh=TzCikezoRb8YZPqX4gJvquc17E3NxM8qIn79vKmmi9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/HiIZ10xpQL1Y0wkwb8YJ1dWoFUvZHi3Gza6rM04hE0tsYoY2DCNYZP6vqxpa4wJ6zHZcgTzBmpxgQUPZ9ZG7+7icTTh+/7u8V/gQNPCCsoEZi6PqAyGlu3wZu1DFp5NiBwwZkyIkFC45p4yzZwqdgsaGVckDcbVnNfoeVAaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+9/4PUX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZMmJqbKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1mfEF1571314
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsRPldSlUkMNAs1cF8LcZleWSjUF0Z6b6sQxevYn+vo=; b=V+9/4PUXadBNmWDI
	YQZUPLtSVzLApkaz2Okm0qBlnCR3ogbEtbXNskv2rBAP7XZQrn5olQ6KyBu7Gs+N
	Lj+Vm//Om17cVVn9gGHtM+mu4akLeftRAot462uC3AodO9BQyVkXqhLsA++a76kT
	BYAUz3y/AcmZzMnZ6afa3qxdw4IItBfPpmRSEpulwIKKr3WekxrlKihrBq6yfkZG
	aaUUt8UI1c2BWMhzSMv3smQigOcFf4p+msBQ0zJlnYtFo3AdUBcA2PktMb7Ga7xr
	Ly3YtTSVW8PQokDsXZohL4lATGPztp9TtqLwkNiMKPmK+Oh8BXUNQNBKjiZMe15+
	gwie/Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc0575-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26a53a4faso1381846b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879614; x=1762484414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsRPldSlUkMNAs1cF8LcZleWSjUF0Z6b6sQxevYn+vo=;
        b=ZMmJqbKF/HG+Lu/Aa37hotHxD3YpDwtW2MVFSpCiA/KEi9ySkg/y6BEc/gAm3icp4g
         2n9cLdo6GxUfegAvzXIBvG73DE1i7MzrmHzkKt5n8IFX6+UgXi0OUWajuM0gJwUgdFBO
         SQ9PDpMVHsthUjuz/cuFhP2LCtGd3mhc/q3ESqjWHhsXJcx5SAQQZXyZeKVqJFpPadT9
         BuHjVp+BB8PK4NjpFeDcjeOX0XWO2GHhqqv1tIBWhBKnYq0MLTyYNp/8DQPNescVN1uT
         lEpdvkmrD7AXjmvH9bQ1yxfPVXiD/tuoD9tIKh8G7xNVWJ8PFdNXrQ4P0aq02EDmxRIv
         c/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879614; x=1762484414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsRPldSlUkMNAs1cF8LcZleWSjUF0Z6b6sQxevYn+vo=;
        b=xLCg28R6OQzLXNqS0YKHwUCAS6JJWNAJQhCIYx45wKJRS1EszRH6LIVZq5kN/9AF3y
         TPVK9DiUjE6jyWKP4FdsFBdADLxMKb5Y7c7lT5xbvB7redeX64shmTh4oggl3kfd095t
         O+VL0KWftAE2IHY65HxLiec3tcGhL7VPJLMbqhPzQWdlMz94UlalRcZXk5PPoMuoAe8u
         knFjuqRX+RjkdRXYy6NW7P7kSqvwIRF7o/wfsfa6xIrpFo6W/Ahjn7YkgrPtNjpxZBG9
         CFvD+PUbBpqUokP32zJIbq7pZaxJ0DkVjHQokVUfzjj2cp7X4awvZ7QZvcyzZ3V8/sdg
         0EGg==
X-Forwarded-Encrypted: i=1; AJvYcCUzd+okZbJ0cwDlVzFXoBfqXDddBg82tcPN1pAEFsxAVOpvmJEG4cvEaLUMaGI3I9wHn958fCZaevsazcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BeV+JnCZ5NiIXeE9wmtO/sFYjJ28K2mPlmFsSp4pYkTrpkCL
	LVoX+TzbrBqjlZ/0ro2+dHJdBMkR0AqJVW7Gnr29F5d1BU5tuLh4KOtwojpBhxFQoGJEVfM4wNY
	fylug2NwRyY+jmJKkAyND5iBXjh1DWw+dfz/suEIjNz+25NOeXlQSooDTfo8VTuTTJfk=
X-Gm-Gg: ASbGncsnSKnsjqfRLlh6wfo4MXshXnMrkm+iugOHp+xUT4/POnjO4oruoUPNdsUe7O1
	vHelLwrVnMlmlO7sj9w9U6Rylio5+VXP1byKLHOma/ks1jvQKS8AWZzzY7afgJJLTHJ/u9HEfXK
	LfvY7Lu9c+L9TpLgkprHXu9UQ8jXZAji5PdelmBiSQh3tf8Dl3B0Kd2pco7Of/zVeH/+gVLGzQz
	/2xwNdgVV8gACK8LgCrKGFNX2EwrbCCA571nytGtgtn7SluptF3oJmQ34RXnqXmb7gEyujT6RS3
	XTZ/rO4NNHy4GmUg5B7pxgkDQAtVooTVvCwHvx2rOoH4W2BTmWcbOFP0SgAG462jyGF4Llfp+78
	u8ueRVeqNj0ANvPNj30EwEXw2g678GpGXmDcIJRoqPEOiH0Xm0HRDjw==
X-Received: by 2002:a05:6a00:188e:b0:7a2:6474:f86f with SMTP id d2e1a72fcca58-7a777760bf7mr2388455b3a.6.1761879614001;
        Thu, 30 Oct 2025 20:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+uH8uZfk4iNZ4q9rsi10JrIQrjOPeeZkXMJPeDGql8NO4shm6mtDRRlgVtj3gr8iSqv0H8w==
X-Received: by 2002:a05:6a00:188e:b0:7a2:6474:f86f with SMTP id d2e1a72fcca58-7a777760bf7mr2388345b3a.6.1761879612949;
        Thu, 30 Oct 2025 20:00:12 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cbdfsm352570b3a.49.2025.10.30.20.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:00:12 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 19:59:50 -0700
Subject: [PATCH v5 3/6] media: qcom: camss: Add Kaanapali compatible camss
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-add-support-for-camss-on-kaanapali-v5-3-f8e12bea3d02@oss.qualcomm.com>
References: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
In-Reply-To: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNSBTYWx0ZWRfXyoJj4YuvVvYY
 bPbBARKwlTwkA+Li5LjRVS8eAOzBbIFt+wktNkf7bl7pY9pjz3M6z1XoRZu0fJiZljashQEnUWJ
 tyKH3xnUNmSPEhX28oDrhVKHALG+CaukAkV/FQRJq/J71fZO3SP9PdJVTm7dQZTp2xz4SPtiIVP
 tfYY1RDxMrJjfmo9yBd00QNFY2amJvW/T8iuAxOVPs6AIZC1z/u10NnvxjYTg6BdImlPyOJjAp3
 nlPwm2aQZK8xKI+Hw9Dhejgpam0y7zfG6IZJF+077vn6VfiaBLJwH4eGWNXGlagdY9eEzWL7huy
 ZPhjXKkahsAyMsE7l/zAl9xUXAXXwya7gkrNhG24wenekvwc+zErLoXdObqvYIjdmmXYaxzgkSh
 1HxZ1oq1rbUAzQ5TyiKCC7KAitHB1Q==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=6904263f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Eph36bqoL6-XvbZcx_wA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 52wwlIKcWzYBfjUMSlHptKc-Wc_yWXDx
X-Proofpoint-GUID: 52wwlIKcWzYBfjUMSlHptKc-Wc_yWXDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310025

Add support for Kaanapali in the camss driver. Add high level resource
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


