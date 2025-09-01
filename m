Return-Path: <linux-kernel+bounces-793936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29657B3DA72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D9E7A2319
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE52676E6;
	Mon,  1 Sep 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeEv75nd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF8225E448
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709906; cv=none; b=DhxqcS3SoSKcEwaqZSAEYr0AYPlVzT/YJxYnUN3zMC/SFrfHbV5w+Xdw1jAeA54beCjdUu56ExLSESMli1EX+Pr3ZDZ5gp2HiszN1P4LhuZVP8ZjLYFhx2MNBwB8JQBKD1OsP3nLO6uonxpBtM/DPw/F9qsUb4hbKWUGuLpYiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709906; c=relaxed/simple;
	bh=ZRqDRcqJUID9wiPQfpPR1WcEMamloLO0sgtrKILAjZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0i5tYa247YpNehVvFK2UX82lID5wVYqnrgU4GFmnqTc8pQAbZpx60G1vGnuDy4zscGIqx7eySXSeHvvKRo899yQcPjoA8aKrPUB7wiEEcDna94enWgvuQ83KNhdZYE6KyrzGHNpp6cVnTH9GbFea6i2Ut/4Si8+sFf5Pqvi3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeEv75nd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VLcN8S011349
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 06:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dLb5zfab531NYNRygT00FTgQk+urSL3aIgF+0s6ontE=; b=ZeEv75ndWYIPIdcP
	E/agYXZZYbvSkBnqiy3jcU84FG7VMCBsQKJFYt8MNzQwwpihzNg9H6xY7BR4iw0u
	T4Z5SUqoNwWOe29K5lY1aAl+Q6m47dIj5rxBe7zalIKdMDbkyNwYuG7rw3MWkx43
	/zFSQOB85IUlDL/4y0In1YFKTHkb3quSrOLZY6z3NhIWzVxKA5Kg3cyOF9PAgu53
	X51Rh5bIuX6cIBcJSIDMj0mGI+k8EyXgSL+U3r0jkwTX4Rj0Bd8hjym64mqlPUyb
	Qow1Gyb91VuNGM42Q3jKeXmzpyvipTJjCF58qfo/qQBV+bECK10ZAeDZRWbVUuy0
	y3lgrA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjbmk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:58:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471757d82fso3124029a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756709902; x=1757314702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLb5zfab531NYNRygT00FTgQk+urSL3aIgF+0s6ontE=;
        b=RvUwt8km4rsXGsZ0ajQt7+dq3gm/sNTo9oXbe7L4JU7zgiLRLwqxthYFke8W/lgZQI
         2ijwwRD7ZaMyUvL52SJHQjMtEYzTjuYC+HulZRvBEP/eNOK6LBP5OixNORER3TFRBd35
         lkCluUVFDXSEDOMqtYpOkIRv9Jwqsthu2zt+mbq0BzHBz5J2KyQ/2Xb9DLrzcWrjZB/D
         i1x8NbDE9ZFVOMMGa0hZtICYupqTuyUNehnUtwjcXmgsNQZ9DOBrInww+f8SFJacGBVn
         0wJHnLk3rbMSR/HyGZ2fwBt7mMixvuvZ9JDdx7EtgQGZxaPdi0PKUMif6kkbO97GNqSn
         b7KA==
X-Forwarded-Encrypted: i=1; AJvYcCUyK6FLTU5kWsKGFAMq4O3Hnd/pmKaVrpoeapfVmBGSalWa1tfdd5BITDqohyi4zr9XauuSdnTmKKtzWdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBoknfWLTWVJ0Sk7fZC+ZG1I8HhS2QyCFvxUXVuJEHGhXV75w
	knsWgpNSHsWvs6F9tDZIpkcdggdk8JeVZtBQVt08vj5fvGp2Z3ps1KHuK6swEsUJSX718+xncSf
	ybbvtO0Zz1rJpsryyrk3d5wpTeDOA7uAAb38G6fcsFKR3cSIfm8hMJQQginDoSw+XsBc=
X-Gm-Gg: ASbGnctNfCge9T6EHkbgRGXKdPnEVwIOU6oeImj5b4quWojo5CBLIjV0bnMEL3P9iX9
	RVLgUOocALCHcuJQzgBklNZ44V57r5T1/G1Pts+JUe/j+PYhu/a1Zi5Bq+1babJanmsAZ+RHO8X
	G69vU25s7hz0+gabMfvufN85wilYHEQa4cDgbZ940SHjINNOOeuB0JniNUaAcp9/l6z5y89QrJO
	idaz4MLgxGfnR4+JmJJQ0e19DtNtHAE+dyzXC79BWtWZTHsYop1qxlDEwg0MwaQkFUbnHKFR4vH
	n1YGSDy8H7YcgrXD1XBB6+YgtUoscGOCjg5hBeJeEul81qsZJRrspc02q74cMEPy9xU4BP1j0a9
	va+h93udKEhITqAFWhMQ2uA==
X-Received: by 2002:a05:6a20:42a3:b0:243:755:58b0 with SMTP id adf61e73a8af0-243d6f3b622mr9331539637.49.1756709902485;
        Sun, 31 Aug 2025 23:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHanZiPxSU1v9cAUvVnD8utRjYhNL8IT8UfQ2s9CDwfXiE+kciYJzMhomhFdanaIJbCuctfPA==
X-Received: by 2002:a05:6a20:42a3:b0:243:755:58b0 with SMTP id adf61e73a8af0-243d6f3b622mr9331519637.49.1756709902058;
        Sun, 31 Aug 2025 23:58:22 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd366f95asm8559358a12.51.2025.08.31.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:58:21 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Sun, 31 Aug 2025 23:58:15 -0700
Subject: [PATCH v4 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-itnoc-v4-3-f0fb0ef822a5@oss.qualcomm.com>
References: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
In-Reply-To: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756709897; l=1698;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=ZRqDRcqJUID9wiPQfpPR1WcEMamloLO0sgtrKILAjZ4=;
 b=RoLU+Iza7O5TpoVvMZwc23uQWSolFpj4SfzRxppOcKkPY6mZ4URDE1xbKH8DIs3/Ssnphy84n
 Npq7139DM2lCGohtCNFwcX+JVdamp1E/bBCAR9t71gZwSWk7If4/s7j
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b5440f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qearADheJa7ujHrKWl4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: lYnSev6SQ_PJO_NVTrVLUtSV3IuLJUCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX7Ow8Vb178XZJ
 8DP4F/bSE/yrfPl5ZW6yEO6R066WQX2l7BWeBUsSGtvj0k8/GNJnX01Y/rUTRMCXNgsprbQzDEE
 +3CswWoxUZio8hHUYMUYrggGKfV++HSQxX0hxfmHSCqF/csYDO4Tl6kBNmipb+j4UZal0HjXEo5
 nETQwhJvJzmGTL1leT2V+aCEjjnyMn4z59IkiALold4cn3R3fZG6sExN58a5YKs+9aYpCXZG3dz
 CBtOnIdIjYpHqfq4FdYfievopIOW4acoi6oMZT7qL/KT4tfD82i4La+h17lxCwfFp1SOkJBlkTb
 Xayby+y1+hduBpd+HoPOkU8SRwPyvH2HtbdSN8iK1GJhYMKgwdJuYHv9sM5f4JDLcjdTIrShvkr
 FfuvbbdC
X-Proofpoint-ORIG-GUID: lYnSev6SQ_PJO_NVTrVLUtSV3IuLJUCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

This patch adds runtime power management support for platform-based
CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
resume callbacks to manage the APB clock (`pclk`) during device runtime
transitions.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 5be882300d79bc0173aa6a19d7da1d48c4aaca9c..2c5370497076536bfa868f0d80db775ef242968b 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -301,6 +301,28 @@ static void itnoc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+#ifdef CONFIG_PM
+static int itnoc_runtime_suspend(struct device *dev)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(drvdata->pclk);
+
+	return 0;
+}
+
+static int itnoc_runtime_resume(struct device *dev)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(drvdata->pclk);
+}
+#endif
+
+static const struct dev_pm_ops itnoc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(itnoc_runtime_suspend, itnoc_runtime_resume, NULL)
+};
+
 static const struct of_device_id itnoc_of_match[] = {
 	{ .compatible = "qcom,coresight-itnoc" },
 	{}
@@ -314,6 +336,7 @@ static struct platform_driver itnoc_driver = {
 		.name = "coresight-itnoc",
 		.of_match_table = itnoc_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &itnoc_dev_pm_ops,
 	},
 };
 

-- 
2.34.1


