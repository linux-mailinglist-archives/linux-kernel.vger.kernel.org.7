Return-Path: <linux-kernel+bounces-859579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053DBEDFFD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68E7189C8C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6712523B60A;
	Sun, 19 Oct 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YzTlae+i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711E239570
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860627; cv=none; b=O5pNa759HOlQ20q8P2dSUe5E5GQQCDEYs8USYyNgKATtCfrdsU9nnhNezUa3wefF6Kda8Vji2mB8d+9pT/6Snou5IQLjEAHv8HMJWYzZFFufSI2a0FOwTKctii/oJeZtWJAzmXSlO/FWHeFk9KlrCxoEw5+aLpys/rgaJepU4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860627; c=relaxed/simple;
	bh=Atjm+XHNGwWlt44E5yZ6mg80bcKOc+FDvJDQ7swz1Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTeWReHm1PFxy8YR8U8gGZYA8BTmrm5cy81AURd4mDnXpgsjPaCsJZvzNw6RER8nEKibWcsGqGKnv8rqFbbxHFhESYP5vjAbvp5lZH0OkyU/XYQ8h9I77eUr5IZWZ7eLu+VTaRgFhetZUCL47SVQEeIjUIMpYCbycopqxe2Zcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YzTlae+i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J7BlKg004615
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Fu670GvHNT2WXsqNJpnsGu9vVym3c6SzGf47wM07ZY=; b=YzTlae+ieNk6n/nh
	DkTm1QhgWKkoLCtEWlpLJoR5W69/zQIylYjbPoOfTvwNa4xma2JMAipzizQ2/oH2
	J8YurKdOZeEe+sa+RqAnuvsd3WI90E84aNoZV8ksSwEo1LygjdNW+I/joXKczJm6
	yfx/UIGO7EX3YqMl9qdEp/LKHNiYDh/AiQBf5nCVmIW2dXPkPxvCppgTtxIvhbEM
	BPRcEe9vGMcyrzmbGTbURyOGTTWCAsRFXeJSuUyvZZhEjJfKwRP8cBza0CKV0MqT
	H4912tGppT8IEQPsZiD58+mtTSaqRyOnjyjLM4GgTNO6aLeP9UDAFvTeBoxQfdbr
	nuPZ4Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v4699wsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:57:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c6f88fda2so68674826d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860624; x=1761465424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Fu670GvHNT2WXsqNJpnsGu9vVym3c6SzGf47wM07ZY=;
        b=WM9SjilNHgP5TV+VviWTR8816HbOnAQvXhEzN6P2W+X7BpSldtLHtLOVc9Tqorse1S
         VZXrPyCqwRN3/QT0Wr70cpr3To5/IpTqSsXLyDotFofHk63rkES/qmta0WMvoG0ArbBu
         H2dUZHF0FI/pKUJ4m77fkIy26cnTM5X/AN2JuBu6h79XF2qmnPeKGT8RqwFoFeMRaany
         sSp3AldmI6CNYBcS6VUMGsd89m63fQspeezMNu1JJqYWZTzPZ7AwtB3lcWy2OQymBkMc
         EmQpM6P0bMdpkCFI4Mc/G3PyuuBiRfuEgBqHuhT5bE+Rg5cdxIRZ+JcYJVRyrT7jRrkK
         XH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVFZJMAU/jyT+8hS+MJupxbg8AHeDSJah0xnyYEi1orybsAvWSs+/zDqYz83cVJK7XHRq18kw0MWQLuvyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRYMRFVUb27Xye2BmJDIfIjOnJ+t/xNUd7Woz8LA6xwKR+ymx
	QZznUoUjVBpoUh/3fioz7SKYugcIKQDe65/QbfPQ/M4K2YVMx79z3mCsBbLITUwTIAkiFrn8Vib
	sgGkNW7EPDXpabIeq3OE1Dpj+PLOLgZnr6d5Mz0xVbnVbIaTwUYfnBU5lKd3IwrpmB90=
X-Gm-Gg: ASbGncsGXSubmdfna97uCSAcpUOGLBZ/NmiNOxkd4lps54G9HqHXkBC4jk/J3WLUX15
	V9y8ql9XHDz01gwCKhft/Zk3KYbc+TLU8qGyxKsgPX4mtvyuTaZeiBdHIbidi3R1CR1ZXT7XiOj
	veNuOtw9ZsDAuWCghrNHN0jUdcGvsbUUpHYK2dzOxbYyUvOVX3GVJMkwe7eughPs4zdre4kzadI
	qccvX317Ht8UQm8h9sqa9v2n50qa1sdPJAggM/QNIMz5cprDEcjW6ALYaXQQZ9cq5w280g7VWwa
	El1TRMRl2LVJB5ULvilYQ1ngxHiw7WDpJUsK+OjbmBMLkL8CYVMlKvOrh5Tmh+Am7ZtO2UdeR+j
	0YiXPRZ0tzdwI+3gfNlYgcjawa+b8GNXiBPltKJusx53OW5TNPvg+tEv2ejam9ZbERv7vfbJFB8
	vaW426GlXHJ28=
X-Received: by 2002:ac8:570e:0:b0:4b7:aa52:a713 with SMTP id d75a77b69052e-4e89ce272c2mr113568321cf.14.1760860623751;
        Sun, 19 Oct 2025 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIX8HnoNRNsNTUPJy9qliriEOtYSyAWKLSWKH9m6fAORmGFE1IA1RdNxHFemEpqsQIBGOSg==
X-Received: by 2002:ac8:570e:0:b0:4b7:aa52:a713 with SMTP id d75a77b69052e-4e89ce272c2mr113568191cf.14.1760860623303;
        Sun, 19 Oct 2025 00:57:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaf4cesm1357027e87.30.2025.10.19.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:57:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 19 Oct 2025 10:56:50 +0300
Subject: [PATCH v4 3/6] media: iris: stop encoding PIPE value into fw_caps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-iris-sc7280-v4-3-ee6dcee6e741@oss.qualcomm.com>
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
In-Reply-To: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4207;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Atjm+XHNGwWlt44E5yZ6mg80bcKOc+FDvJDQ7swz1Rg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo9JnElNBvi+z68uVL7uf1R/LYeQKwrNjbrEMnl
 pq88uY0Mj2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaPSZxAAKCRCLPIo+Aiko
 1WUnCACxXK3iSU2+JXZTFO2Xmm38cxCeFB0t1R870vTxUQay9M8Y8d4tlHMjj+54INLRcTJwfKD
 Ba9TnxpwmBAZXXShoKJsiWJi4VGrkHT6dxuN0uOWueL60n11ZNrCQzWxt/31vo921nZ02H1TF06
 zvyBwCMphuBw4UUTa9y0/IwStDCzID2QZHTxeSNG+N+2d5v/zMiBn1gy/XbtOHxvUjmQaW+egqj
 vFRBcBndVQJoEN/Z6e7E2IRdNEMiCU/ZEnW8crXYpNbQms+S1aKDoIJuVac1m9wOEIRVZaUSvYu
 kQLMr7UlhdxlYyycJK/vHpkzQS1dJq6EsH5SvBo3w6Jdgbus
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: GJG1P0gPWapPQH7ScPmh92Frm9a4esyQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX0kdgS+rDRYfR
 el9WE1nwyT1nId/4YAh2crXBjwhRTj2sUoazfR/d5c+j1IItT52uiOO3wQWUMQ5JmOFo3lDHnX3
 umAvR/M+5/5p3MVeUr54f+orkn4E3IsBNAY3Hiqmg3Ne1VrW413AMW2WESV01RNnNi0LEwARD1M
 4C8Ykgu4h6Pd3ruGBRE3DMmOb5/TutElE3Lkt4FZ6l6Cve6zeEKz8SGo/DUMuM8NlXcA/+TWn8S
 LbYTaxNtIA6eCOmkii1kvBvmUP6P/4SmZPX0Z3rirABWzs39v3h2LXFm6txjR5Zfi05Bveunb0H
 itpEOnqKNAlsUXQwscPElWLL5Rvg/oo1+9AAEzbsHq8IsKAg/Fq9tOGEVYaEG257ydz7Mg6Z1dk
 ix7yx7xD23USBPBNKkTf6ga2kUW45A==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f499d1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UBAHcYp1M5YLSaqwDvUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: GJG1P0gPWapPQH7ScPmh92Frm9a4esyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

The value of the PIPE property depends on the number of pipes available
on the platform and is frequently the only difference between several
fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
iris_platform_data rather than hardcoding the value into the fw_cap.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c            | 16 +++++++++++++---
 drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  3 +--
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h |  3 +--
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c  |  3 +--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce..c0b3a09ad3e3dfb0a47e3603a8089cf61390fda8 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -313,13 +313,23 @@ void iris_session_init_caps(struct iris_core *core)
 			continue;
 
 		core->inst_fw_caps_dec[cap_id].cap_id = caps[i].cap_id;
-		core->inst_fw_caps_dec[cap_id].min = caps[i].min;
-		core->inst_fw_caps_dec[cap_id].max = caps[i].max;
 		core->inst_fw_caps_dec[cap_id].step_or_mask = caps[i].step_or_mask;
-		core->inst_fw_caps_dec[cap_id].value = caps[i].value;
 		core->inst_fw_caps_dec[cap_id].flags = caps[i].flags;
 		core->inst_fw_caps_dec[cap_id].hfi_id = caps[i].hfi_id;
 		core->inst_fw_caps_dec[cap_id].set = caps[i].set;
+
+		if (cap_id == PIPE) {
+			core->inst_fw_caps_dec[cap_id].value =
+				core->iris_platform_data->num_vpp_pipe;
+			core->inst_fw_caps_dec[cap_id].min =
+				core->iris_platform_data->num_vpp_pipe;
+			core->inst_fw_caps_dec[cap_id].max =
+				core->iris_platform_data->num_vpp_pipe;
+		} else {
+			core->inst_fw_caps_dec[cap_id].min = caps[i].min;
+			core->inst_fw_caps_dec[cap_id].max = caps[i].max;
+			core->inst_fw_caps_dec[cap_id].value = caps[i].value;
+		}
 	}
 
 	caps = core->iris_platform_data->inst_fw_caps_enc;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index b444e816355624bca8248cce9da7adcd7caf6c5b..03ce5c259c8491ae6882128795d18569baea6241 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -161,9 +161,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_4,
+		/* .max, .min and .value are set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_4,
 		.hfi_id = HFI_PROP_PIPE,
 		.set = iris_set_pipe,
 	},
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 87517361a1cf4b6fe53b8a1483188670df52c7e7..310c48958018ae724d01c87e7977096cd86e1bfd 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -147,9 +147,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_2,
+		/* .max, .min and .value are set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_2,
 		.hfi_id = HFI_PROP_PIPE,
 		.set = iris_set_pipe,
 	},
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 66a5bdd24d8a0e98b0554a019438bf4caa1dc43c..9cb9ddc86ad73daf75383b3253e851394235093d 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -21,9 +21,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
-		.max = PIPE_4,
+		/* .max, .min and .value are set via platform data */
 		.step_or_mask = 1,
-		.value = PIPE_4,
 		.hfi_id = HFI_PROPERTY_PARAM_WORK_ROUTE,
 		.set = iris_set_pipe,
 	},

-- 
2.47.3


