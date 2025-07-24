Return-Path: <linux-kernel+bounces-743777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A3B1032D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFBA542B05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D3274B25;
	Thu, 24 Jul 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AJsp9JNO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81B274B23
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344965; cv=none; b=Iw1VOhXzVO/RIUp/K0btOc/EgOI8SfIGOv2GkepkQkv04v8PZ34PaepEbBiFaP5pH5ENMueD6WVRf60xVIca6Br43V+VxDxGoa9UXVQsRYr0EVOSjV1GMqMNbdV2xawp2k1PA9nDbH8CsdBunxAa0EQTRI41ixSRGjaNVEm47Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344965; c=relaxed/simple;
	bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8CYB/wW6aI8dQeVOGZ1aKCB2VQ9BIsb8gtYZNY9jrjDKCzq2YGoS7k54G3jKUZA6h/G2KyWGww4j76CJ3Y23oFe5NRdldnHWl6+mjXpKyicRNFlX9vw5FPhBi65Ta6Uz8ryVrm1SVi8oDjsY3v0HtzgMKCVqjAiUtYB7LGUGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AJsp9JNO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXN3C001453
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=; b=AJsp9JNOghXwSaYH
	uiwHwJ1hy14x98G2UyGqqhgdhBXYglreHOk1qrXs/5ihnGUcunI5DlFWuHip/+48
	MPewf5csXW4R9pUZJie+Ig7VODNpXvPmH179TEwdCb2V5Hoicwh/O3WHqTNddVUe
	SRbuV50IzOQi6h5z2uOeOLenAkdnbXL2xTJu64yAY+mkDtDREIkSS0fwWKMhloKF
	reigUOloGt1ZVLadAHt0DBQPM90JfW0ye4hnjSmVj/y9hbdRTzpwVJPNLht+4bEH
	fKlm2M1pu5dvt1IPDJz1lmBcsfLI45xz0BlB9FbMalwdIXG+oQwigFRlvHcxKFXC
	6gLcJA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uehuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369dd58602so8195425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344962; x=1753949762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=;
        b=uwpeE/W1NXeFgnSEHY/SeQzT2q9w//gCaj0YVRUTgA/tuBH0UIt59C2r4HDFfSNpMh
         nIhdTNdnS/++q2J98x6kM+885nSQIDYlvfDim9WotTG0PABPWpEQchyFMq5kbap1vwWN
         uIRiQVGyMxqpAYQvi8qNYFfrHIsnI2N3Mx5ZsbA/cA6rMKXPx/YxGOwXeM0xlE3h9o1t
         EFvCCSN5brG9TW8sghkDtIc3ze5Isywx2kQ9W6qkxRIUTAISwS5acThbsGkfulMWJziL
         qvJLgwSQIENL/Ue7er7ytS1oRXQ+owofWBH2BAgHbwoRkAue9nEUpwlrH/XQm70hswgJ
         RArQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT8LkIGW4ut0IZlJa/1Zo8sjHZTbHZiKDbTqPYqFLjTqOXbIyB9ZoXMNtvLh8en0joie10JnKF2gFYWdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2KSItzeKdhKAxyzMHb0rE36DNJSA9ra0DwVzk3ZEkTIdZBAu
	KcppveERzU12yqFEDzR9c/LPNQdKPpxGobtng4wMH4WZ5O7qSqV1/WLjieGpghOOy1rN7XLkQiu
	AVDOewiKvmW1Rzd10yGgfenVJb13d23puwntuFc482ZgQQZd6fren20yDdSFBbkK6zYo=
X-Gm-Gg: ASbGnctuT46dIojD7fYH3W4kNEfaHy+GbmfD3cwyLNHzPhNl/eX/HY38TB6BzKQWr3+
	iZOfpsaqzXtu/2H2TgJ8siAuNfuFYYqjSkBonojqVrxEmqDgTxBV5EGpRM7n4pHCkuYhTD+13sz
	jHLeZ+XlEv/IfUzNd3PKtmuDsSDD7+jOvtdLi4gIQvz63A7YgSz5xn8T5fgljgFmijJx5pXPrMb
	1hd0lf2MreDDD2RK+8LXZp4ePMM/SCAJq1tVw2liNcT5kZPArHc/k6Vo7KwEyTtn3E/IL+nw3so
	1Il7TYtRrDMXK7B31WPisJK5hNJD8bpijGH0p4/SwwyWLS+1YSjBo3kHrstTnSXbE2V5Z8nLXtZ
	ugMn2aQ3iP9SVLopC6Ct818NKAtunNrqQjA==
X-Received: by 2002:a17:903:2444:b0:23f:8d6a:8e45 with SMTP id d9443c01a7336-23f98140a01mr95820395ad.4.1753344962227;
        Thu, 24 Jul 2025 01:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkr91/pw4vNNaIUOBKuk9Uuu5PH41arn7hoJ9vxyrcC/rkoCGcnGUaqdCIG0nlSwdowIBEpg==
X-Received: by 2002:a17:903:2444:b0:23f:8d6a:8e45 with SMTP id d9443c01a7336-23f98140a01mr95819995ad.4.1753344961803;
        Thu, 24 Jul 2025 01:16:01 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476eb07sm9770595ad.65.2025.07.24.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:16:01 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 16:15:24 +0800
Subject: [PATCH v2 2/4] firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-hamoa_initial-v2-2-91b00c882d11@oss.qualcomm.com>
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
In-Reply-To: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753344953; l=902;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
 b=+I3p08M5AzxBFw1WlgrLsUDXm3vOpWV5Qoo9a4Jpf4d6ErbbLKiNBW3hdCzKo5eyxU67bTfk9
 6F4CKEtqLhRAx4DQqxEDhcXx7+pWzfFHbhxIEEzar7mHBYs8IngrpLt
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6881ebc3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=h7II6S6JRGbW-U2bcKQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OSBTYWx0ZWRfXwCGyM3WQ0U9c
 LRRSVIDVajQq8cvU/kvvyWpg5p6v7hjPJmn4Zn6LD1jxc1eqyC5gi7zb2UDkLCdp8RLgFsFVIJs
 zRHK07KSUjtzTjAn2nXpj3jsZEVdpDgPhXTjkCUvxkayW1+FYcTBqJ/oZ63ZEQpgWUskl6NZr5y
 0CGBqaqgQhdQz8bPRhQrMdTS3Ooan6J+8R78a61xTJvDO48cNu+FYXxhHrp+ILOFKiQbf68EE7G
 BivJxAliPyuA13Wwrx0o7XOLKFRXYxcJNls7c0M64JFn0N4ESs0s29czz8hVeqvxsU+1hkmTvkg
 iQY8F39z/scdgvS3yhK3CWolVBX41ADaOOVCc9Y8CWto2UL5DjLCKDxtlwR+vU3rlI5iJ+AE420
 b1PRqy7yAFgC5NRPPK4GaGGBRaLof9uB58iW4XX7w1flwEKD5bR9dHr/0AwaWY6GTlfizTcF
X-Proofpoint-ORIG-GUID: uj53kybK4wA5jhBqRjlmT4tBkZk6SjfL
X-Proofpoint-GUID: uj53kybK4wA5jhBqRjlmT4tBkZk6SjfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240059

Add the Hamoa-IoT-EVK board to the list to enable access to EFI variables.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26cd0458aacd67dcd36f065675e969cea97eb465..27c9d4a0912646415efac2df089ddedaf971fcb1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2006,6 +2006,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,blackrock" },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
+	{ .compatible = "qcom,hamoa-iot-evk" },
 	{ .compatible = "qcom,sc8180x-primus" },
 	{ .compatible = "qcom,x1e001de-devkit" },
 	{ .compatible = "qcom,x1e80100-crd" },

-- 
2.34.1


