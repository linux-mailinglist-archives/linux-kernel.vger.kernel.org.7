Return-Path: <linux-kernel+bounces-849600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220CBD07A3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EB064EFBB5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB972ED15C;
	Sun, 12 Oct 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzr6W/RF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F922ED15F
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286238; cv=none; b=lgzhF+2wtzCh/kXGqUSEuB4la6+kEoRAjq9epRyiqhvkbiNIGHJcI16Snce1WBR0I0iaWJ2sEdQYn3JA/ZirL1amLXPvvWBuMmPIuavYWnQ2rZQtNAWUWYK/1VvZ1it07lLphFxfDRy4ZBtkjyOpyi8QECT0qv9Vk+7z7t004mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286238; c=relaxed/simple;
	bh=H/YOmdSqf4JIP4Cbg+JvuClkdIEqdkFL49DX9PNELTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj1Rh3A3VIB5wHdn2gfVyDpNlJ38fSRCRW8YzrrCeT380/qrZsrpXV7KPSp30c15PqdUFX2sak8rdjjiTJc4L/tdolHxGVxn+HHTZRUKm4BYAIHjLwv1ApEfhOo3YyiWcAgCYEbaYZAFztGF4UN1HffFqjIcscy+NllKYfvtZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzr6W/RF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59C8tlMX017958
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d+GsqBZNv4YoSJsUViBcXog6s0e/JdFXU7mZ+Ya8PEM=; b=pzr6W/RFCbfwLAFR
	Nfz4MLuWSWXWYdr5aEvGF72KHe3IOO7+QUopvQq7oBb9CWdfpgfNKXQkZCoIxdv7
	GSiQiJp8fS7cq363wLmF98coOTn0WBimuGp9P9EXiDZCjH8brPnqRJ340trPsBU1
	2StAndudBJrNMB8GyJshDo2/Jwk1ARKK8n76xZQ9wu4P5BzYMhlU5B8b5tCHgejw
	+NJ1aTHrCAuKQx0M2vPB6NJ/8wIxWWsqDf8512HsRUhwKzxtyWU+O3Vt/hNL5xGH
	SLbPMzGq7QwbXTGWyZHZfL+2PJ8DTRhbjYja1sJiChkYNJ5gZBHfnz9K1NUkJUhV
	ZaB4aQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8299w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-871614ad3efso1891583485a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760286216; x=1760891016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+GsqBZNv4YoSJsUViBcXog6s0e/JdFXU7mZ+Ya8PEM=;
        b=bt6SrQNaCNL8S/UWU0kvflstu+FZO6q+0moSE4qkV9NdxdzpEsmmSwyg3cy6hRp62O
         MgN4j1nKfrsYiXubLqPyx81BUYXDvq1zArv45x1vPIRtiwb+4sbvfA8NJKlb95G3j8PY
         /N1jr8CIm3A0w7yNesIVcMYX3zpndF6fX6bhBqR1JnLj/0W08OIBXCm1pBEd/z3GQ8Wi
         cYv7I0mblsfERjUuudNVMwjvyyObmGIzJcGqOlIzisuxVFkuMWpgQPfMILABCK11/tHB
         KRSueb8RuyHeNVFSlD03s/6W5bF3VkhwxhmZrPrslGUc0iS5VZ97KNPNKNvkU7GaLyTb
         H/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWlW93848rdLho8iCtv5AQ1OKrMopXP2LRJt69Jhv4cBimNrUnF7Jr8H53HUh3lYve4EiCduRPmX9ERVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBFYtMRTkOyGoIMrsiprJNsuXhKcYbljtpNqI6d7AFGNwRjQ6
	S3uiZOjXszMMq1ex3zPjfq7mGRHjyTe4WJwY6+QaHEZHKPS5d2Bu6StkBKfws82EFT5uqmWbMpL
	57n0hvUcEUf5wT8btH7eC2RFS3C+o0wr97H9oowun1sTqbkWjtUcGBuGHqFNELgbLKVg=
X-Gm-Gg: ASbGnctRBVXYPYD5PJA56nvsm0BSDPtf2YPW16shSpxXdcuUrCGsxPEaoFKGKnNHBEy
	FtSSQgy+4OGRwil7IOTSYXgLMxC+OJ4U9VJ1H5/3ZwyOUopIbezUr3FWGK8s4fa5BggqfEq94a5
	uYxfFWnObnOvXMMLl2t+JeZwXA5l2pDNUzoLPiFLYFB1wspfaRXEMKmWJacZu1BcObvqmuKqMkg
	E28XGAHZCFE5W0H9etTopTDslfbEk1b+owR52xCo+YfJTS+QIx+XaXFg2E787xazdtMEovR+XB8
	oSTGmc2UW3ss+glqBVsXk0taHuP4XoxE1aJSoeujbbadBqr7muyfTa0FNze65bb9xuRIjCeXUzU
	IcueyZV0hEmCCpDgXdqithQ9IqTCgHs/Mf8VhjSZPNhntdWyISX+f
X-Received: by 2002:a05:620a:4492:b0:82f:6b85:73f8 with SMTP id af79cd13be357-8834fe9988amr2032709685a.5.1760286216525;
        Sun, 12 Oct 2025 09:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZzIK660VRivJl+L8V8xBNzZiGjpj6iqRVflDvMd1ltU2WxrufRd26sSCpytlTdt/eutMDjg==
X-Received: by 2002:a05:620a:4492:b0:82f:6b85:73f8 with SMTP id af79cd13be357-8834fe9988amr2032707085a.5.1760286215918;
        Sun, 12 Oct 2025 09:23:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm3112637e87.50.2025.10.12.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 09:23:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Oct 2025 19:23:28 +0300
Subject: [PATCH v2 1/8] media: iris: turn platform caps into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251012-iris-sc7280-v2-1-d53a1a4056c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4960;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=H/YOmdSqf4JIP4Cbg+JvuClkdIEqdkFL49DX9PNELTw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo69YD0bmP7HA0ZV2aD+koYyognzHJGtlvTDHoC
 tV/FoESiDuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOvWAwAKCRCLPIo+Aiko
 1WVbB/9pVdzoBHDyCNGLOwGtKDIx8k8eX5JXHicpqYiIT6rR9YzoUtRQ6N8Ztmw2sUIG5nArl7q
 nkYllH7XvXhMsEFo2aJ348JTJpnyh5LZhEIEYsd6H0T9ZLKvKoa7mQYUyLJP7JkJjUY+60ckZ0f
 so5enh50GITF1junbwGwyjoNex57WdbgqKDBU53MtT+ADqGLWrdMpPZbVum2mWz6RXtBmzJTx/h
 oufr4XeyU9zIgSFpHGTkyvimsyyDk4DOf+lI6nZe4o7xofVPVP2sIDbDB0tPqlLEK9yGsTQl7fV
 Z6frkejYNpE5hGIHWT8FfM3typuMJKEigcyJ4+q26je7zqB1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: dbIHAsJCObZ1iYIEZNVaWVWV1Yt1k3Tm
X-Proofpoint-ORIG-GUID: dbIHAsJCObZ1iYIEZNVaWVWV1Yt1k3Tm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXxvNW28+U3I81
 BifMckbcnwfAWKlwZvtoZtQ2mg63UChNNkk0gjILSqLbODNsl7UWbp94Vs0BU7OhQS7DPnTcRMD
 nibzN17MpPfYMiLLTIi2NlE5pF+cOFN6p6rDZPBTdCIWCB9gkfhybOxClzaYG5P8HsIsK8DuDSJ
 lUbkiHrYZsZmTLSCYjarrjKv8bqpgV1nNMCw1jZ7fH5FK32tvWau4xkC2cKLJDHkUUGEqx6u6Eo
 izYhooNpbybZvKUvZZINbhbdMSnPCMxFX2LryACSIPCtTR+DyRjJqEm28qrOb7jJ9N71x3NOu80
 919c6Hx66X8R7bSseGTWi3IWegP0EFSCPDsQmr/qphNvDx8C0FHYsNPZOCdfDVx5/Y9LUc6TYy4
 5fE3+3R5390HYAu7lgMuq+zLOmPPNw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ebd609 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4lT8O_Qwe5KXetiC_XUA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

Make all struct platform_inst_fw_cap instances constant, they are not
modified at runtime.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
 drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 754a5ad718bc37630bb861012301df7a2e7342a1..9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -301,7 +301,7 @@ int iris_ctrls_init(struct iris_inst *inst)
 
 void iris_session_init_caps(struct iris_core *core)
 {
-	struct platform_inst_fw_cap *caps;
+	const struct platform_inst_fw_cap *caps;
 	u32 i, num_cap, cap_id;
 
 	caps = core->iris_platform_data->inst_fw_caps_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..17ed86bf78bb3b0bc3f0862253fba6505ac3d164 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -215,9 +215,9 @@ struct iris_platform_data {
 	const char *fwname;
 	u32 pas_id;
 	struct platform_inst_caps *inst_caps;
-	struct platform_inst_fw_cap *inst_fw_caps_dec;
+	const struct platform_inst_fw_cap *inst_fw_caps_dec;
 	u32 inst_fw_caps_dec_size;
-	struct platform_inst_fw_cap *inst_fw_caps_enc;
+	const struct platform_inst_fw_cap *inst_fw_caps_enc;
 	u32 inst_fw_caps_enc_size;
 	struct tz_cp_config *tz_cp_config_data;
 	u32 core_arch;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..cbf38e13f89e5c4c46e759fbb86777854d751552 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -19,7 +19,7 @@
 #define VIDEO_ARCH_LX 1
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -203,7 +203,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 35ea0efade73caa687d300779c5b1dc3b17a0128..87517361a1cf4b6fe53b8a1483188670df52c7e7 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -5,7 +5,7 @@
 
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -189,7 +189,7 @@ static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..e29cba993fde922b579eb7e5a59ae34bb46f9f0f 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -17,7 +17,7 @@
 #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
 #define BITRATE_STEP		100
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
@@ -38,7 +38,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 	{
 		.cap_id = STAGE,
 		.min = STAGE_1,

-- 
2.47.3


