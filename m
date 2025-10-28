Return-Path: <linux-kernel+bounces-873687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED18C14714
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2375807B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D830CD84;
	Tue, 28 Oct 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pLeANK9m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002030C615
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651993; cv=none; b=Uj/3kGY8i0/u+3fFPsRM/bE6WzA7Lxb4IC2w7TNGdKUh3I7nBqsIqywwkstJT1mt30ZbIO77zlUigPq+0fbMU0KuBW/EaMzzOnl4R6IaW/u2bZK4bXwT3cWu97THss96G5zXfpZo0X3xRBDPvsxOxLJ0JFEJ1umOBl0Nnkmab6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651993; c=relaxed/simple;
	bh=QlGdzJciH1h4gz5Q1SzqSd8IKkSpeYMEZtL7i2pFW/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Daf6XcTHpRhxkoh7p8z7KlWB89Skshh2hI6WSYzngKD+gn7X7wkAyvMSwzZWtz3/1YcC4kevuPDTgD2fIYRM+2G4rqjKzYk6nqVhWYuvbnJBlqfFvAHT8hdY+yfraH676gobInpCh/tbWLlmsMVgOVo+Qn4CBx899v7hTmdYonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pLeANK9m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7lOVn2752228
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p9c7rVUQ+8XQDwfJNgLXJyZIItXH+75/qbByZsGVfLU=; b=pLeANK9m+SiN0/cw
	zpNiU1kEnrYBsEXPTLsftK8CZEeAoDg2vdFqCkNCOi35qNmMW0uwX3GUxGgDuaji
	ShgpiR3rS7B8EXrqZ84MT1AFKOmibsXeEr8shyuojdWk88CsV6s+DCY0n35pDZQZ
	H7wIpnhzT2/oDWq4fkiy4SfRHOLKJ3BBD2ZKFm1/MU3XBVUM3eY5wOI3jJSJ5CGB
	+gd7lQOlYjLxBO6zZkiel+cJWGS5MD6JVtTNcShMxDX6hmYikFIJJZAI0zj1tRg+
	M3vy+mnTNflkVx9xf1aM8NKWU+lcWJO/89XvU6KJL56bSLwIFg9atGF+VfzoSMqK
	sjFRwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swkv8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so158115911cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651990; x=1762256790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9c7rVUQ+8XQDwfJNgLXJyZIItXH+75/qbByZsGVfLU=;
        b=F4Gh+HXpyEkLY7ce0pmCMN+uY+UIaHiLcrHz9JDJTPWqCAXPgHCVUqSNLbJg++Kqsl
         SNue/fonHSNO2rBzaiKTL8r11mrxsEWbRInzxQ2RzYOUbOs1h/DLdLlDW2CyH8GiKpm5
         6+jJWjolLZgsLwxyIpiJpbCjccCZ+0khucZR9d7UuL4bgzzq5mFl6e3FVd4N9Y+AVTLE
         4aoqmlTKmLfiN7yTYyejJ/yQZTt2H3l/v29MDvX77Cxgq4bi0mDhe52GyIA5IxPwKw1t
         rT7rdumXXX03OKzjEU9HhzIeDGIglRnljh7KJRZgfOVjA187SH1SIEiITlo74hD6T6q+
         /N5A==
X-Forwarded-Encrypted: i=1; AJvYcCX0XGl4VFCRFsmWEhyp1Ujtbu5tqDgjNxCjI6AzbA0jSe71L1YcETlWN61rK3iWQCNOUWO3CO2uq3DB/KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVws7eOfaJjbcv1T6snUQPQ1l52sY7a0WfsyTOb9QOfCatHP8x
	aKZNAbdleiT7hXd3f+ltKeqcPU6MfgBC+6zZ+uUqQW3pg72rNC6eFlLsyDCdf317I+O6X/GOHJY
	kyI4CHnm7zcN5L0YgHlIjWyZ0McB53/krwiD67DatrOYazlyECQvk31jQYfJQ45zLU8w=
X-Gm-Gg: ASbGnctAeZ/5TKuUnhTz75SE2d28FovnghL6/7qamoTsVayTFNefoG9ljSOkp5zl0B3
	j9VlpITRDvf378zhHn9jtC8wVUdYyR8aozdbArifS7q09d2+pH3jdH3ociS2hro4lFY5co3suVM
	12MprjwTHEC4SoCxQaMUc14Z9JkUEclzAFbBNe4mKqhdilbNQbl6S6dRFIa4CgQdN7dE+g+nX7U
	3bLjcfQYC46FgPZk1OUUBB7gVFfHkd7WvdM9pf0RsVsOeCOuY2cRXm+FEMeb6UfD+JNtGsLnhiA
	2BvhTUOdKn8to5sdxgxMI4JNSXPfa43nnKw9bJcTskGFmkRUn9cmI7qpSstleT7oUs5IBE0jZlv
	QSq8m9mW8OyvtfU8d2J7srcwhvUjyNFFmkARDvfssk+OVh2waWW9vtikAGonEOGx27JIDRrRppX
	f3hPaALm5Q3LJX
X-Received: by 2002:ac8:7d15:0:b0:4e8:acc0:1e8f with SMTP id d75a77b69052e-4ed075be057mr45500441cf.47.1761651989964;
        Tue, 28 Oct 2025 04:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Ecb2Qp+hq2U5FiqWdK6HvKabgSqWNavXCz9Gkg4IboGUsrt0FsZKBeUOQgiTiiyIF0Npaw==
X-Received: by 2002:ac8:7d15:0:b0:4e8:acc0:1e8f with SMTP id d75a77b69052e-4ed075be057mr45500001cf.47.1761651989440;
        Tue, 28 Oct 2025 04:46:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm3096564e87.6.2025.10.28.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:46:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:46:21 +0200
Subject: [PATCH v6 2/6] media: iris: turn platform data into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-iris-sc7280-v6-2-48b1ea9169f6@oss.qualcomm.com>
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4328;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QlGdzJciH1h4gz5Q1SzqSd8IKkSpeYMEZtL7i2pFW/A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAK0RtoydYarBLClwNT7bGfnqxxyYGWps5K8YC
 yvBOmQTMjuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQCtEQAKCRCLPIo+Aiko
 1QOuB/9nGiy5kH/neKk/uzz+gVGA5k0aigNMTkWmKZcRP9u8Gby6DZ5jsbjV9PZaAHy3kFZ+6Kl
 9xXgcEQG0YplYqZ7Ti+q6us6jzFZVG9Jn8ruMHax4L6fJPsyGdHy2RC+nVyNzM8Fa228A9yBQPw
 SWmRO5CtX0Ckbb0GGyvwUjfht7+DtD070BqQ8ViGmi/kM1cMpXbG02hgkOJgK/04efPFrErExlh
 zP7yNAo5cV38ekvsNZzhqggWhp8iwc3ygfZ5QjJUKfZ9chpTPuwQgHmafbu9wp7gZmi85tX5rBT
 6fEx5XxXm/rJqfZws2psFab79OPQMzatStNUCfSX3iwXiKs4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: YH4LwAEadgTQU9-tRIw-dS-7aJvvJQIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5OSBTYWx0ZWRfX5co5BkzD8mYj
 tneYQRUYD7/Kqf7AofrMqv6YAdi831Nmmu2YGyRDamNfDwYVp8TrVreSimfPGu/Nd20oPO64Ysu
 cQBg9roE3xWyoz0ff6XQ2lO1VXjzoOT6X3J028NmS4wZmQDOW79B3esy0ERczlNKnpf+bdKql2G
 7hlYlA7KT8zq7To8J6n+HpPaMx/47AICzQy5lzp1IesKOxN9KzyP609mUADmOh43f58ZO16qDMY
 UG6SRYe5IIjIWSth+c4ukYYhpvelZXF9z5f8PixVeiMSa36y9b53//OMO2b3cpR9WvRAYGbYsmL
 9a6VRFEE0JAfB2Te6y1AF0wbX5Rs67Kwk+u00LIks2px7WHAjnGeIx697590rffbJ2YSZoggqoV
 8BQqOentVJpSRNKsJSueH8jnCjm5uA==
X-Proofpoint-GUID: YH4LwAEadgTQU9-tRIw-dS-7aJvvJQIe
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=6900ad16 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vHBkZ3WG4vhFy3QD8MgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280099

Make all struct iris_platform_data instances constant, they are not
modified at runtime.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
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


