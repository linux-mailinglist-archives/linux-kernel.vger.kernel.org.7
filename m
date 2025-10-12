Return-Path: <linux-kernel+bounces-849597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D3BD0753
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB0E1896A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09C2ECD2D;
	Sun, 12 Oct 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cee6ndNl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0342ED854
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286235; cv=none; b=PYATVUgMQbzmn2aGjhN+5kW+bkiao6MFAE7RehfvydIOLQ5Ou/+sfJwI4NKF3sk+W6XQvf1qbaTyN+IEtcHfplfGG06Z8a6B0SvB+6YDM3P5YjKnyTymNAyrTbUIl2re1bq1YEoRmdmu1Skaa95+Iv1J/A9wibJi9RRzNt7GxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286235; c=relaxed/simple;
	bh=/XlkIw+30ImRJ1vZ+oZYrGWc5+GeaSVpL8dMGuZakzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W+W3fTHM+JmWjeBnoxsrP7QfYsw5v5RNx37w8ZD9/6hfZmiKNbmE5IsajtmiFcE92NLvE1uwMw/RO7QW6nUoqdGuIhab+zBhP/4o3vi7BsRSVSk+LAI3xMwUDKYXbMlPwWig7hUUC0Z1jYlVV0loJ8eDuPLHIkgA2+YTc89sBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cee6ndNl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CFvPcO019337
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUM+cJTKntoj0TSOmVPixlbOh3sBmLzYWf/L9aPHlHQ=; b=Cee6ndNlbE46aEUx
	COuCekN0tGIOIJlxm2t81ICnn5phyZOWfuYbh3sXi/lssTFF27qEjbWBXJQVZoqi
	kJrz37IQqGhFqv6XjBIARjE0ZQdWRc7Il6H9g9vSUN0I2GvQoMhZxyNsyiadmzT4
	Th2BfmHQH4CiJZLaruThBkturxxCZ7DgjEY4YzZAUeNsVKCVgckf7apXLre2z9GM
	ys2xjUuKUJa2mJJJLpMIfm8JroFC0x8/PvpQyrGuxcJVFVtTAMobwIYkOr213mhi
	0qrX+5Nz/rDMhoUavCLrZsWBlCUw9mZs91U/cc/ZUy7zqZogs3Y4gzT+sH2zybd7
	ge4Gwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk28ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-87ae13cc97cso2272301685a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760286222; x=1760891022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUM+cJTKntoj0TSOmVPixlbOh3sBmLzYWf/L9aPHlHQ=;
        b=NMU2nrTxD68hPvqiCwgmckJLRswhEY/9aYrA5awLcSNfdFyCwP0J9q0fpUtiixfspu
         BV8pp5yR+v/WyeogfZr6u5BX1EECa+IuP3WfiCkKLKgNqrENoM0aSuaTE9oQZk0vlhoW
         1HaCnGzy1d2IxWOm6D9kwNbN1J/CXvkBBgOruDeffCLTEDJ7tUYcfHTmFuPuHXXjospa
         HLg3RGuGVejTGAaQIJ0OW6Mqaav0lcko49xntlCzrBM6FQ/cUwc7e4kqMpuLqsHFEuds
         WUZy9leAHg3ek9P1vNrrL88pw0gOkIAWqqn6glhJbbYODdUpCrnStpF5tOiSj8WTy6hE
         ZvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF+XQPot4zG0yFEXnWV8F1J4TEW4JsKGK31/WEVXyrUx4Ho6hrHLyQ9TjcQ0J2j2/LIFa6khOTPHAR8dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVlXX3d4XuP1uuZR2rilfsGd3O6uoUebiNmBIsMJSd29vvEMe
	8Tii13RZbea13Uz1kuSO1lyMzoPoV0WzKvmkDcKRPew8CV/62fnLGzsv0u69FLWOoFodZGRO8Ms
	fxqUKje9RBCuwW9AbbxwkaUlF9koDTuUmUkNZKb+57ExVjew2DjD6YDGS1gdvsIy3lk4=
X-Gm-Gg: ASbGncvtSdn4yFdPzm31BCprsLkSCe6FuGJaNK3A9GVcoJlHO3IlBgdCwR/WDlfRf1i
	FQBOyRKmPe+xXDvQm+RKxzAb09Zw6jkTtkXlwXI5whRL0mVYBy2t63qiYFVx2QiFrUKErFKbBpD
	s/1zvtfxTBOiw/QSgwHdwxwZUQ0s9Eh1nVR/fH2P4ji2aSyyZ+y73ctHtuo2rqw5wPf9yMkNOxg
	BUX7Kp2DIgxx3CT6yQ01vXms1uWAGGVwp8TriAwZmOTEFjNNcyzODlrv9i8nw6+phMATR9ldJYH
	ewyFC/YUmNDK4woFS3HpGhESKa+1VC1PO+iV0I+42rQdLz0yyEaYxP6D+zcciWKwmBfkZreFXYg
	JyAaFim4MYKNN3AHj04Xw7m3E1Y3j3PGRhzr1b3JAjdj0Q9+8gnSU
X-Received: by 2002:a05:620a:1aaa:b0:85a:1020:63d7 with SMTP id af79cd13be357-883521dbb61mr2434433185a.47.1760286222233;
        Sun, 12 Oct 2025 09:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHBYXOzwONO9kVZyil/dw34TySyD+6pIngj6wc/pdezQPpAFjhCWme3kHRKMbraemUDA5eIQ==
X-Received: by 2002:a05:620a:1aaa:b0:85a:1020:63d7 with SMTP id af79cd13be357-883521dbb61mr2434430785a.47.1760286221813;
        Sun, 12 Oct 2025 09:23:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm3112637e87.50.2025.10.12.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 09:23:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Oct 2025 19:23:31 +0300
Subject: [PATCH v2 4/8] media: iris: stop encoding PIPE value into fw_caps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251012-iris-sc7280-v2-4-d53a1a4056c3@oss.qualcomm.com>
References: <20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com>
In-Reply-To: <20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3598;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/XlkIw+30ImRJ1vZ+oZYrGWc5+GeaSVpL8dMGuZakzQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo69YE9WP9zEatolepYmFytvcnCgF8zYPcW5KSj
 l/0l/KKoamJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOvWBAAKCRCLPIo+Aiko
 1RvCB/4oz2P50mg+GiHwrflyGtjswsPxBbXfZD+fvueM28prVD6xZPRaxCsYYscI8cW2XFH5Fp8
 Qk4TD08z8gUQkbKE0BOv2L9L+9wV2oN9cRg7kuUBK0Sn2W76IDsxahpwLQnLHmbNA6xv2/l7uOt
 UOFllxnKSNEuHqpnDiFMNkQnrNuz68/W6j7GFW7dgDM0YXdmjw658QH77eH7xLKuLAmFZxdLB6o
 L/IrIgT9S58k3K8UsZvdAvp6yveeMXp7QGaAhFobR7Btvastt/f3g+pfIT9uxsX03GPEmeDuQ7y
 YFiWxQ4atVHD91uHaonWqye0IDQNbvsOrE4Ws2JqDJBRa3bl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: W63UlV3RDu7kcCAmV1vjVzXHAeuXxi6d
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ebd60f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Fn2TP4Vc3OsuT4lKjqUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: W63UlV3RDu7kcCAmV1vjVzXHAeuXxi6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5jLeyLj5bWWf
 CCdntKN2/9XlLsNB/STUpZNZVhCebCKtz7qbq/Fvdq9sSU4JM4BcVO65xIHJ4StvltPUSBhgkXd
 V2mmGQnepGJXv/AAOzUzu6NukgKMi7KBDyLRgwvN7Vk1tvRf6yzmLrL9a11EOLknoa/H+18O2sS
 gojfeNx/Y4oc07e3iyWRv9vyGZNyISDLMAy3XS8YEy5xrjZ9VuNQrddNR3pF+R9A4n9t2bSVYDI
 n4uS+ai+RHCtqbtVZuou8xB63+hk9OnIgI9XNxZ+Z1+QKqM4w/yd1SGWYpgJgF7S6rqwJtZ1sTv
 60RktBHU8Bq9OKCQyGXVTUDIMdVDbV+6L0qoquJIuTbIUY2WdoMn97qd3X9P9gOzhDJvB4PWUnr
 OXASQrTt7SC7y/QrdW38ITaNIS+H7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

The value of the PIPE property depends on the number of pipes available
on the platform and is frequently the only difference between several
fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
iris_platform_data rather than hardcoding the value into the fw_cap.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c            | 6 +++++-
 drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 0e9adb3982a49cfd7cbe5110cfd5f573f0f7bb38..8db3fa222bdb92a7ffff3dfe62d33f16c0550757 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -318,7 +318,11 @@ void iris_session_init_caps(struct iris_core *core)
 			continue;
 
 		core->inst_fw_caps_dec[cap_id].idx = i;
-		core->inst_fw_caps_dec[cap_id].value = caps[i].value;
+		if (cap_id == PIPE)
+			core->inst_fw_caps_dec[cap_id].value =
+				core->iris_platform_data->num_vpp_pipe;
+		else
+			core->inst_fw_caps_dec[cap_id].value = caps[i].value;
 	}
 
 	caps = core->iris_platform_data->inst_fw_caps_enc;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index b444e816355624bca8248cce9da7adcd7caf6c5b..7ad03a800356ae9fb73bdbd6d09928d0b500cb3c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -161,9 +161,9 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_4,
+		/* .max is set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_4,
+		/* .value is set via platform data */
 		.hfi_id = HFI_PROP_PIPE,
 		.set = iris_set_pipe,
 	},
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 87517361a1cf4b6fe53b8a1483188670df52c7e7..612526a938eed0554fc0da99e12c26d22e04bb6e 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -147,9 +147,9 @@ static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_2,
+		/* .max is set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_2,
+		/* .value is set via platform data */
 		.hfi_id = HFI_PROP_PIPE,
 		.set = iris_set_pipe,
 	},
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 66a5bdd24d8a0e98b0554a019438bf4caa1dc43c..2b3b8bd00a6096acaae928318d9231847ec89855 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -21,9 +21,9 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_4,
+		/* .max is set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_4,
+		/* .value is set via platform data */
 		.hfi_id = HFI_PROPERTY_PARAM_WORK_ROUTE,
 		.set = iris_set_pipe,
 	},

-- 
2.47.3


