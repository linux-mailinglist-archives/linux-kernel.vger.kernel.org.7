Return-Path: <linux-kernel+bounces-859578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B9BEE006
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 843004E7F20
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866122A7E0;
	Sun, 19 Oct 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYD1yL3y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854E23371B
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860624; cv=none; b=cqb/FYGdimbo8v+at2ddbYPPBoi5kREgqkHOPTwQVMGsUud29EQU3fqJHSLdz8X2fZHV8gG52Rgt7MnF88cisOHTUyOktz1JOHY9RQ6eUfupfqYc/UkJd3njqo5NKrXE8sYny9bh5DoCNjB6SRJMIO3B+Q5Y47+LgqCi9qb0s0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860624; c=relaxed/simple;
	bh=QlGdzJciH1h4gz5Q1SzqSd8IKkSpeYMEZtL7i2pFW/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dP1Z/rOX+NVSivtBEfKIj2tbonsd7SmYrXhuPOsFGl+fqXIVL52xqfkQ9ZE+FYFlmiGPC09dCGBnzd5k6VX/EYTdteQCLI7hiUGvQYb1hsO7hTVnf2d2Jb6a1NRopZLmtLep3H8km38qxal1Et7LM+WJKZRslbmlyMMFolqgmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYD1yL3y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J3NVR3003367
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p9c7rVUQ+8XQDwfJNgLXJyZIItXH+75/qbByZsGVfLU=; b=eYD1yL3yeg0p1FPL
	QHVsiuOImEeGI2T+ihBXdOEdMWtNNlVDg6iS+DDbp18wBQQUtbrbtUTHf5x5+LJY
	MxKa0meoG2iu+WrfXVF0rmOFZZpTsTeI/EF6UrsM7MKrZXsAA82XOBAq1QcrMS9s
	t0OZwu0DJ3L+CMU8u/tb4WJA/pPShu6MpbTQs5MyyxLBpyjZ9rsPqXbKazYUHvSc
	Qs9K43gN3JQEQi5/ux1yY3mzwfKOykjJnzbK6X6AFR9A0m18u34LcVpFg5dNZKN4
	fQPk1+kQyHbNjudmZdDB0nqYN6VKOYE7bpwPJigv94ZW8++jlKC046qhVajkjfwV
	xJuRWA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nf9xdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c1558a74aso168733506d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860620; x=1761465420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9c7rVUQ+8XQDwfJNgLXJyZIItXH+75/qbByZsGVfLU=;
        b=h7l9zuCaP2JCzFvQjnUhJLLBMW2iggyDm9noHc9Bm5NTqb7Pchl/UUprkvBSAZnXBJ
         AmXUGSB/0wzUYNP+tqkLWjxbp3QTShOtH6+JSQuvA45ZevC24oQs6JJw2y+qrau3W7ey
         AqeIB09hg8nCAo9wvGc1qSluaYeeL+NAnWypvVLy3ixnIP407kaB8w4A31lVrRR0R7wY
         ii9PEqOyxTVFuuupl9MRuLkJTmBT09qOpB1X8xbzDf7QjXlLYmULWbOiS8JFyah38vk2
         qBowtzWBysJYmccLoVnjmYJWfiQcaZUIr8a67k8GqJTuuqy2+aG5JU96AntezUuzCx2Q
         PKCw==
X-Forwarded-Encrypted: i=1; AJvYcCVgKTvhPNjGxjprEOH75Drj158C7cHClTJrv0+dVbn7X46LE1OK6AWT+2QgDgoUzbvOiHd60FGiYAQFQhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7LXAGUbQGdfbXYPAQih3VBkaY39gNdDX+3pttBnEx9VazaTL
	cDmrAgIQcFh8eh5ZtCehITiWZA2tUrEYpIpvCs2axY5VLTk6dtdXYRv1V+HF1adQaWigz/rF2TG
	sjlmafM2LPpMv6oNWRT0mIapzRQVd/7rgCZKttI04QdF5O5DER+7yTpvYcXABUapKG1pm8JeQha
	0=
X-Gm-Gg: ASbGncuTSSkZDfaO2mSTSRSa9cO2Qr7SgGsUO/1Zk/JuY8a34m8Inh3tvUySwu2jKD6
	XlpFT6maOMXRuzjRjEXKwS45pvLS6TYWTg8ZKEcqQpafLjTfYtT375mfZ7lduIAOsKaWqenXMjd
	GBA5D1F3ZxCacZYKgVTbbDiLBEULFl7gN8jKNXv7EjgCcpswGEylvH4x+LpmIxlDvMeNWnsKH3P
	bzw7Cpur9sMJLb3hrtwncM+0F/JyT93AreVI6N4B1SWaMMJyYMk2qjtDchUbJA1rnLczgEifXyn
	3lYFUZKxNmElmz1ABK1qTc0+zOKBkbDxAhwn/qdk7XSoG8/DNiXh+ufFTe5Lh6AVxMOiXm33D7K
	rCNk/ybHHzquKwCcM6V7kOXBDKZYThbySZmfoVwMgiXCnl/mg+7wNYjObDJ8gDFifWGVuzRT3qM
	iEdUCykTSWD58=
X-Received: by 2002:a05:622a:11c6:b0:4e8:9c58:3283 with SMTP id d75a77b69052e-4e89d2976d2mr149921651cf.33.1760860620471;
        Sun, 19 Oct 2025 00:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBT/JGLHhnA0pOKRiG1vcO25nwlo8WWyYXAEig0c5KOlC4TxFjLNtH3p4yEXMlLHugw2n/WQ==
X-Received: by 2002:a05:622a:11c6:b0:4e8:9c58:3283 with SMTP id d75a77b69052e-4e89d2976d2mr149921491cf.33.1760860620046;
        Sun, 19 Oct 2025 00:57:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf4cesm1357027e87.30.2025.10.19.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:56:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 19 Oct 2025 10:56:49 +0300
Subject: [PATCH v4 2/6] media: iris: turn platform data into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-iris-sc7280-v4-2-ee6dcee6e741@oss.qualcomm.com>
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
In-Reply-To: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo9JnDFE1Kbou+2TUTGrtA4wh8atM7aEdFOLKXd
 UaBUgXEBi+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaPSZwwAKCRCLPIo+Aiko
 1YBPB/4rCALg7iHH73KsSaCsSpsxPyN3NVo105FoTcDHiHe41tCxf+mTxb9yBZdC7BM1lu+xFxF
 1t2leMeL8woyXZJCccmKfWf342dinXfqBYzqVazjz7zHWzWB49FcuZkZRZR19pettzSEamWIiH9
 8a21yS3fVkrhVXQPf+3cpurKai832ATFs83Fi8MHqi7eFhkE4QG+4HV+jpLjri4wJR1/FQgajeq
 T1MYNWT34zP6LN+wH7Pof2yuNmR4fssTRaNhMepScYlO5K0f64gUMupVTldg+C6lHHuwfCwrxqP
 g1JonHNwl/VyLFSpiMwWj3na8NHWAJXt1zRBMsIJVyl9E+1p
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 8xw1tBiC0hcDlCbXNP5syByY0b-Ue_zz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX7L6xV2zZNIH+
 aJvSBplbvAvDVGTehWeZbUR9FDgVJebDBQggHfwrrPaDf6j/Sp2ibhnMqDTjRuFkXv1AyoTICVL
 yWrho7btBz/SHIS12U0bsybcgQ88C3w5o8wZCNrP95MHBpgWLwgJxu7zHiXqhqhNmmqCBy2y0Mp
 aY8506v9Hx+7i8I3kGhj/GjZRvdHkHGlhK1Xpci72hLweaGoUqHfdoseeHoh4tAjUz4Q2EOVXsn
 MFWoTN6DvIBpX1JRhIOkwmZVJHTVvdtw5sFS/NxHjjz7kP4bUa7xqNrQc7hu3MVipEryK7MJ5jK
 cdANo+1W7oMGRyGZtbxQn+BKSwlrmMkHK74LTOw88Yj+KnedMWzGe3F6J325V0AV+UVAINrYWce
 00GE8TdSzeFPNDEXdJDQ2oxtW0TtrA==
X-Proofpoint-GUID: 8xw1tBiC0hcDlCbXNP5syByY0b-Ue_zz
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f499ce cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vHBkZ3WG4vhFy3QD8MgA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

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


