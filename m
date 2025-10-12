Return-Path: <linux-kernel+bounces-849601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716FBD0783
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333573B4671
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2B2F1FC8;
	Sun, 12 Oct 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5eL70qF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE862ED855
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286239; cv=none; b=IJaW0Ll6IToR10VBPobPbYF3VLEvZODImE52KQ7dHYhjPUCk3DEHPZDC+5xI8S6/hiw+xC3/0xLZIg+JRKAKJpjZW4y9FazfF5bzCG7xWPwOh5661oUSlOwkALQIAomJOBbZ/oeRBKxzHKPlg1Zjy3t1V+eyeik4lA1Ulmu+pyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286239; c=relaxed/simple;
	bh=uoVbn3VVUUigPywid2f2V13SpTXgIyshJR5BshILzqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NyLLDzFDa0slgXZ0BVn/JhyffOVcylr/2DjeigBCRw1hPH29rcRdYRkMBuhNx4On4FopflQtarRCA54krBO+S0fXi2UYz8coJyG3ViPqtDWAHvlyrlfKm/vWyJDUAsnjrQGPdYDalX1WTvSrDahYFxbJHUvDkTZrqkHr+A9l3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5eL70qF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CDvVTX009667
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j7hD3U2/iftBn6nPxqDaD4P+oLTZnUv6Tt0CD8XpPOk=; b=O5eL70qFkIZJJHx2
	LKM8LAHfZ7xBoGhdxxtnrgg+uejcAa2fH3g72YIDv5T7Gv6n8vjs1CK1RKPlo55x
	vlakk6ufvK22DylNEKhPiXD1+1CkBDUd6ekpSAu5L33TbuELn0tWpertDcKNfgAO
	BReeBZrNHTgXQnbi5yiNS8bjiw/y3YFom01eJee+U2zi738oVWGUw+86pN4OMO/Z
	Fw5js+4aOKYhkHqMoAKcQashiCLVnSkla0cLD+ZRx4Znrl3eNY2dn4wCVdw3jxUE
	F0yOv4ESKnE1G6NPWgTNYr20iHNtFa3WNx1dBU0j5l2mdbbrircWY/cnZGlJ7Vms
	1D8qSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfert96v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8645d397860so3329492185a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760286219; x=1760891019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7hD3U2/iftBn6nPxqDaD4P+oLTZnUv6Tt0CD8XpPOk=;
        b=rmDzDIDzXo2ZDBQW6B8PbkDzD06WmtRzV8K0gEo9vZDC+bfna6XjS1ZyvoM/NXAZ2d
         mBLFfOBx5zOKLRm6m+kVNRBwqAIuoid1Aiu5r3SlrwacqSLxO1qTe+FyGdjhE1Ws5CSo
         gmuQgiCDYSl3JcNRyl8kA7hrFeEKaFhYBUDL0HW7tmPZiivC2tpqOHW37v46Qc8r5YzO
         GASFtxrD/wN1L84CnC+nCHHwBUlBBn98EBw4DZlhPxYqYsSDmwaefhzz5pF9bSx81NO3
         lzDlGcIVcfuiSSzIi3mM2fxKqhwwqQWPZwBKnd45jOg601QANai93i4YUzjAxIbzkbkL
         sjUg==
X-Forwarded-Encrypted: i=1; AJvYcCUbSJ7q4kPZjLnix8MulpUKWIEybmKRyvad+65p5tMbOa5ZCED/l69KtMJdU10hCImJlulwsqnDRjNQcYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqscEq4em0vDeXNZ5feNGk+CGRF9cp03fjqUxIS4yrZEshTTUN
	WOKxbBFuhRco1W3Dar93Io2hlOUxRWGx33mPk5QfqU3ECNDxppb1xPdj1JnYvOPNdB0xXks4lU1
	njCLF+2Y/ZIeA2lTG74EDP7op89M8Xef18iam120KjC/HkjDiHlGVzJHooHKgo9KCbGk=
X-Gm-Gg: ASbGncuGrZN7/ifCKria9U+Kfx4tbVT/MnJqWA3jvPxH6aYQlNs9rlKfIaGYMrM9B5l
	6Od1F0Zi4bV0KVMVSHDJkAseuvRkk9MJRR5RB/KezN+z7QFfHkY6c2HFhxtFm4zJyG5Yqs8Npq8
	hMmgVyTOxUs8ZMIfMBYL7eVQeZvrmghPvIeMnmSYTW3Ot3EmKSrFPX94Iwwmb7V0ljEJwqYDN5m
	hffZonqIDU1ezZNiudeyhd8IzMi7ue+jv7+Gn1eqI3tUqIZ2T85o3kzemWS+4btt6/fiPtbmNmv
	5E98JAH2/ofWOxlRe28RYRe6HCVmGyLh7kfEiernYL9BQjpcPguaCB+0gfdFr5oUiL6bQy9Z23p
	KW8f14IEWePd5HqXuyJA8Isbfwb1205FJ1YGqtVHMjYmkpswXhaY0
X-Received: by 2002:a05:620a:40d3:b0:860:f3ab:4456 with SMTP id af79cd13be357-883546e2a79mr2547042485a.86.1760286218703;
        Sun, 12 Oct 2025 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4JwPUtFhk/OK+gKUxoDCRRYqjs5hT7RmTfQr2W2axCdZhIUnAOsYkGsUpxa3h0v3qPQj+qA==
X-Received: by 2002:a05:620a:40d3:b0:860:f3ab:4456 with SMTP id af79cd13be357-883546e2a79mr2547039985a.86.1760286218242;
        Sun, 12 Oct 2025 09:23:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm3112637e87.50.2025.10.12.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 09:23:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Oct 2025 19:23:29 +0300
Subject: [PATCH v2 2/8] media: iris: turn platform data into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251012-iris-sc7280-v2-2-d53a1a4056c3@oss.qualcomm.com>
References: <20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com>
In-Reply-To: <20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4265;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uoVbn3VVUUigPywid2f2V13SpTXgIyshJR5BshILzqU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo69YDgTsZHb567g79+2iwK084AvbAnhqxEjRm9
 9NSmPXpVzCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOvWAwAKCRCLPIo+Aiko
 1buZCACRMQ45/h9HldMZ8AbFLfBfgzhsCceXbmGXXavOhjnpjKg4FrOFRTBU9XXnVsD9BTio0eK
 P83GzPA6fvIdkatxBq2TAh7eo4i8swWVvo/Gc6vowoa0DYpD5cI9iYBmPck+rBJBV6o60VHMer4
 k1RYT5/Xc4HG04rtwCwCspqVyEiBmzB00KkBfSOyKSYNoCUFsM+HGwZYANnE6EQgNEKbooS+pIU
 34oW2hALsgWjXFMLOgUAYyk2QrfIfbk49Y3vBPKEeImLdKBvJ11VWer70Vg11uWnq0wxtaKOriK
 T/vo3zmaejBudwRTzdHBsJqPZcppFYTGM2BL9v5pu2N+pGRY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ebd60b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vHBkZ3WG4vhFy3QD8MgA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OLaFZ30Fl-C2mYoRwwUrz0L61RvKD2EW
X-Proofpoint-ORIG-GUID: OLaFZ30Fl-C2mYoRwwUrz0L61RvKD2EW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXx7lUBlVA3ThD
 6DToGsBEb/jEvg97Y1isJQjPAf+g2qE1yw2dshHNCEXF4PowLuy3iGHkPZguiDm5jbou+kHAkLt
 dHubpudm7SMUjZ9EIFWc9Xi8g2PPzPFJe6tfPHPaShL1i3nIKKQGTsa+d1xrtJNa58HQxuRtD3I
 DMuBFZT1SmxfvwQfiE5EXNSjAsS5WHnLj7aTF5dEe79TEiJ76wKEGJO+Xj2N8JuN/yRjzZLa3rY
 fnXrRCzMFniuVbZ4cCa+Zxoh6uGTCzbDJ8lDK8DcxUsApnmtFryPgfS5ybl9GP2YftbszyAaRA9
 BNJkHg0Q0zngcOFPrsHJK79yzdJ1AwzAN+Yt2s23HPnWnN+iPs/8w3T4L07dihXgybhmFCdl1Nd
 uw5vnTpH7v5FnDr7YmR2ihTsi1J/Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Make all struct iris_platform_data instances constant, they are not
modified at runtime.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
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


