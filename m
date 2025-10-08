Return-Path: <linux-kernel+bounces-845025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5BBC34F9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DB1E4F5392
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233A2BE7A3;
	Wed,  8 Oct 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJ4258Mf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BB2BEFEA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897999; cv=none; b=nvVuNhvGwE9r/A5jeZuLoe5hJF1LZFcjMOIsuhYLqzFa55cdl4SXaejfSr7Ti4QesC9B01D8P1gdfP1KUOVSL2/7kwQBqQT+ty2Xq+bIdBEV3qi+EVuisP9zKCcVNY9A31RGca4roQLmP2yi1ikUYw4oKY71fRdsEyuk55jKGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897999; c=relaxed/simple;
	bh=+L0FVb3nT0HZF4UpH+QDTgMj2kgmz3latLiDdbZpIWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quxfTrhQMlnO9agvu3RvABbpTbcCjTDIbMdPoWv4XCqAJZx5rNuCqJc9t7yp8hkC3D7Ydn6L45GckUyZMfectzgbANKvJJm1vAroWQ6hB/Xg9485N7219FrdlFgNZshyZSY/UANeaT6FFhfdZZOxgp+Lj4qP0MOhGGY8VKSg570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJ4258Mf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803V5r028342
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 04:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xMrwU54H/uWjt2xE4gnN6IPwO7bt8G6RCsg6hInUYvY=; b=oJ4258MflyBPSzgC
	/vCBbw0WyPHFT4PmKxaKS3C3kHCfkdkjddkWypDbBxLd2fKNQKZibFwGHKcbIp3X
	9zrvCEqo9xmzgC3k1Q76iKr/+PkYI/9au1vpN8u36t5JGZdRtyB1TN0mlcZn1eKI
	IuF0Rj9lIjDGGkQL0mq4fyr7WUMF1UYwDQSquw4DE7jX/4iTsWFKsXfz4BmBAkcr
	2huLwDO1ZSzh4VVFcJ/xRAvUI+Z+BObFu3lrlP1rzecGnjrM1K0JMXiftxgWC+NU
	0FTbKyP2tCjTyvjLka21L+dGuQZRA+YPvaYl8aZFJFllKu380sj3MSu+sWSDjr0Q
	rQpcnQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hh2f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:33:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de35879e7dso124023381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897996; x=1760502796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMrwU54H/uWjt2xE4gnN6IPwO7bt8G6RCsg6hInUYvY=;
        b=kSICDc2NEFiUIMnisX0qLAS9J/Eduuaqu0ABnmJW4EV3vbZHobiwzp1D4cfh0vSsyq
         rnkIrT0XiYXTKuFMAUOnmzkPIrBtbKCIQZIaOWGeMmCBR5U3hy32mL+IWG2vLMFOmZzX
         64oSGpyg0LcPCXOtxQc/Ty/ixEWUJv2VwS3m+TmyoMGdK8YfOj3Gi+LUmTr30J609uRp
         +e4eP57HKvwlDOh1W5MoH+CRIwKrIBaikJr0cNadx4GvfW+/y07a3mRI6dorhb1Uvvq5
         riMTzKVyOKWa8e9jOvU7cqP6MDz3a9b4ieQHkm37xp5ASk+ETFwHdB6LfouoSuN+Scq6
         ywWA==
X-Forwarded-Encrypted: i=1; AJvYcCXI6pHGKJe6M+MTFj2+AsMuN7iTMH8sO5603proIUUQyZpY9JHmcWSQb1zPt/NWzKF6/bWSZoZ3vsMNPvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRKjiauXyfep98aZi41P41w945uLXyUOLKIuKnMLtjyLCMj7V
	/ANRNFNAysc8hCPGgAmIFuT2fRnGKWaCLvVSBDdJtix+1a0XrW4YIq74mg0lV6uLjWUftOo3Z3z
	uQhX1tvdVTSnHF8MDrEggx1ybnpLk+LxWTCtXYMCKSyqlEWaOH2E7UAY9OkK67mRR0t6ioqqudZ
	8=
X-Gm-Gg: ASbGncvCVBdPrjQBDezZNMwfHoSKAPljHFOOJ5Srtg/uo6Bf/NZ/Rk8e7Ah5tBQfAaE
	3wU/R/Rr7x1zzznP0PLF9E1VeJQHXZJbE0ZYi4cgV+ZJyeh29/4A4fLzsFYtwGPFuqRuy9DDgiw
	aw6sWLWGyBIJI42xsJ9a8q9LBhc/LHC7tyMp8Vv9wxwWolkGPqJQ3c0Nm3HttwaQ0pPSuocZ0ZF
	QX5x/nQCzFD/gG8DlHCxK5I/+Whzgj0oYhm3bSJvuJZtKdIo5u9OkKXkIgoxPqvMbrcLUeFw4qi
	JFY9m6eVcsGXGUkNxTBvzKSIJ+qqCCAxDdm1DT47NpRfyVSsA1NAS2RRPW8OWddUl/FDuo2GJic
	8myF21TGht0n29vmCOQIGjGKfA62oSYcerjOliq45kcT1JhrrWqeJsbxvHQ==
X-Received: by 2002:a05:622a:134e:b0:4d0:e037:6bd2 with SMTP id d75a77b69052e-4e6ead806bcmr27833111cf.83.1759897995640;
        Tue, 07 Oct 2025 21:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt6gLEnOLhGVvjKmr4m5rlABuj5GLAJCqhwtMhGwe4pEq1ln3zmXi6ImTncYOmW8z2J0NI0A==
X-Received: by 2002:a05:622a:134e:b0:4d0:e037:6bd2 with SMTP id d75a77b69052e-4e6ead806bcmr27832871cf.83.1759897995025;
        Tue, 07 Oct 2025 21:33:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119f461sm6751107e87.107.2025.10.07.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:33:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 07:33:00 +0300
Subject: [PATCH 2/8] media: iris: turn platform data into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-iris-sc7280-v1-2-def050ba5e1f@oss.qualcomm.com>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4138;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+L0FVb3nT0HZF4UpH+QDTgMj2kgmz3latLiDdbZpIWU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo5emCc0GzpkeysADwzIdcoCkqGZcJYkX11Ti9S
 LXsSZFA55eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOXpggAKCRCLPIo+Aiko
 1SypB/91KIe0vvc7MesIeeibhDgXrRcrF64yJEgkbBnDOnaFLXISD20vmus96QdxK9zyvN9FSVE
 za4G/q5NshWkBfeVUVHb3KSUT1T5oraYu+L7SQviv24D05aGXmXU+7vRnvPnqy2h++v0AzC4UCE
 CgY6A4rWH3yBK7UEBx42oZu0krIm5pNKKLBfGBL/Yxr+CgZzsG5HvhPbSZrNx5TnsAYEUPJTnX+
 KP8t8IJk6GGpqnXXo41s7xjSSxXgnSEn4a2V9nURQcn4guDMMAwKzb1PxIrv/GofQiTZkNkD6O3
 NXSx5n3e0E6AhLQkWcfx/9JVg3Va5bW5n1++VAYP9r9brSJf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX0/EUkH1/7sGQ
 SfExCWTWAJtDwN0vGGfXnRkZ7jkfAHvu0iDDHBrjzot5rK+xrgQfTNMSsLMzxjUU7qKbVyp3RZn
 qH8NzXYsX8tF23CblmwT18q79JJIlyxkmVdnHZrSOA6WlMebnKV6PFqNMYWGifTBJU3lh9x4plw
 pOexwZkhCGnQN/Ka/M3DTGBWytZq+FXB6OzRh8bV5rC6tm5nEwH6AAs118isBmwfIMae1xYxifM
 HZ41C+ksuk9g0Pjtx/YZEb6ivCDmuhOo/M+AXlTFBVHb7t2yohEY9YmOBQ5c0kv0njoBHGyHTVf
 gkI603ZuICWHAYpb8c21IP8xRx5XNF2uYm/9Ra/8xMHTfnpN1352CrWMn795nbPkSIG9SAcg1IQ
 Rx+sqobEma75tPEwDgg08BX5OnRL1w==
X-Proofpoint-ORIG-GUID: wgf90NlxQiwPbYmj0yOuaDFotGbo8BmU
X-Proofpoint-GUID: wgf90NlxQiwPbYmj0yOuaDFotGbo8BmU
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e5e98d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=vHBkZ3WG4vhFy3QD8MgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

Make all struct iris_platform_data instances constant, they are not
modified at runtime.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_platform_common.h | 10 +++++-----
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   |  8 ++++----
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 17ed86bf78bb3b0bc3f0862253fba6505ac3d164..5ffc1874e8c6362b1c650e912c230e9c4e3bd160 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -41,11 +41,11 @@ enum pipe_type {
 	PIPE_4 = 4,
 };
 
-extern struct iris_platform_data qcs8300_data;
-extern struct iris_platform_data sm8250_data;
-extern struct iris_platform_data sm8550_data;
-extern struct iris_platform_data sm8650_data;
-extern struct iris_platform_data sm8750_data;
+extern const struct iris_platform_data qcs8300_data;
+extern const struct iris_platform_data sm8250_data;
+extern const struct iris_platform_data sm8550_data;
+extern const struct iris_platform_data sm8650_data;
+extern const struct iris_platform_data sm8750_data;
 
 enum platform_clk_type {
 	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index cbf38e13f89e5c4c46e759fbb86777854d751552..b444e816355624bca8248cce9da7adcd7caf6c5b 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -737,7 +737,7 @@ static const u32 sm8550_enc_op_int_buf_tbl[] = {
 	BUF_SCRATCH_2,
 };
 
-struct iris_platform_data sm8550_data = {
+const struct iris_platform_data sm8550_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
@@ -827,7 +827,7 @@ struct iris_platform_data sm8550_data = {
  * - controller_rst_tbl to sm8650_controller_reset_table
  * - fwname to "qcom/vpu/vpu33_p4.mbn"
  */
-struct iris_platform_data sm8650_data = {
+const struct iris_platform_data sm8650_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
@@ -912,7 +912,7 @@ struct iris_platform_data sm8650_data = {
 	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
 };
 
-struct iris_platform_data sm8750_data = {
+const struct iris_platform_data sm8750_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
@@ -998,7 +998,7 @@ struct iris_platform_data sm8750_data = {
  * - inst_caps to platform_inst_cap_qcs8300
  * - inst_fw_caps to inst_fw_cap_qcs8300
  */
-struct iris_platform_data qcs8300_data = {
+const struct iris_platform_data qcs8300_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index e29cba993fde922b579eb7e5a59ae34bb46f9f0f..66a5bdd24d8a0e98b0554a019438bf4caa1dc43c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -314,7 +314,7 @@ static const u32 sm8250_enc_ip_int_buf_tbl[] = {
 	BUF_SCRATCH_2,
 };
 
-struct iris_platform_data sm8250_data = {
+const struct iris_platform_data sm8250_data = {
 	.get_instance = iris_hfi_gen1_get_instance,
 	.init_hfi_command_ops = &iris_hfi_gen1_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen1_response_ops_init,

-- 
2.47.3


