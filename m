Return-Path: <linux-kernel+bounces-845027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F2BC3511
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 295624F7C11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450C2BEC22;
	Wed,  8 Oct 2025 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T26RBQxi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACA2BEFEA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898006; cv=none; b=u4KV/OrFAdbLozXBQP5D+oeEQUaojWGFkb7+ithhmS5YObtDiHEYC6EOPVMV23ktJDyd5YpCg2gYJse6c+V0Q5p3mMHlfzYWxxN9AoMiStlnyNlVv8yI+D0L335iL52lca2EjfjzVXhNPdK3x5eUnbrxogyZFER32rS4tRE9YdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898006; c=relaxed/simple;
	bh=N+IKqzurGKX75UM4EW+hTzffIcDi+0wYJu9pHIUdLPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hgoi1NrN3v0XBAYf1SHV5q5i3BSVoVf9qOO9lhMHqFan1b58284QmXp0CbY6dZlmBOMEZ7/k3Q3GhtnaXjJ+WuG+ny/vxh5gyh8LMlvQdSfkC4mMLzL6RSBZL/NHPNBYKhH7PQwDBmmAKzM+WDNsaHrrE55TgdNdj4KqMGcFRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T26RBQxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803TwL028270
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 04:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f73pC66UxLFt4BbenYscOe5t9+ujLGSu8ggi9R1XpLQ=; b=T26RBQxiebsO7ixE
	gf1y7VM326ltaiuCZQ9aGgtBhnRJ5JXjanLSbdC3ByYcPpCOGzVs9jaljrTuwf6Z
	M4IcS4J7Qqt0a2uN+GwMVLJhziWVr+0ObTynacmC+ILTWcrr1ZP1MwEfMwM6AS5L
	XHkbXLKMvFTSumI6LIP/8wqhnkbRLMs1xZlUcZ9QZlfT1m96wEcTOIT1IrbWT7Gd
	AXxYJaf30Gf5IPfQIBDpKHIEvfyzdK7LfXyoe504M9051QNjUHO6GXF5TXVr/kBF
	4P29ngO80k8vGsFrdrWVraNJUn/+pir7tlBb8i/eaUb8Oz861cV/yT4LmkEI1SUr
	MZBzxw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hh2fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:33:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4df60ea7a1bso151212761cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898001; x=1760502801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f73pC66UxLFt4BbenYscOe5t9+ujLGSu8ggi9R1XpLQ=;
        b=uxDUjs83Am0RsXBVztZV5eL6f9vUxhQhU06LpXoQu9PJxf1b51d1Hq2r5qMMHhtSXM
         RWyplup5ioVv4vsWP+xL91wgPo4HtEliWVpCMswqQtFOdxlQkCOUIbw0go6HEfIjlUzD
         hsRyZvAJEQCaUy98IpZDpNxbULyh5nr6outceVZDZzd/B97os/BRhC5HgSn5Hk5qQqGM
         62PPwlWGqQXXjTWNmcTujaSeueVob/kmetxC5+wrERSnxtZlsEtwfAY805pR+vn/xYIn
         yvYJLtfl9nZnhHpKVzGm1qCRINXZ4A7/SuWN8vndf7j6+pCQeIIQRDfGKWm5Gwp7Wn9g
         R/7A==
X-Forwarded-Encrypted: i=1; AJvYcCWEG6sWf9Oe37RQr1sRqOoXB4B5ikJe4lIFXqukUKNc0hktbDFb7s7/+7Zczr1VQTWe9VnXIeY0hTeHRWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ypaDzF81HITWrkjlphKjlWI+lC+ALHdBg2LizID3Dhz01nr3
	ju6iD2x5wzEMnGHWOo2esB+uVhD6zX/hSwV3Czm4RBR2RnVH6Dj9uvcR24r7q8Fxdph+F8DKEc/
	NHDnV2iM6amhzS+nFguBx+x5QnFRn1L6+8PMKPy6LM3pM1YycX3T4yuKWX3qbLFGYU0Y=
X-Gm-Gg: ASbGncu3DwXQIlg0pqZGguzi+DqW5eJQsoFsF87B+IlCSCQTzjdop2grS5WvhM+gtoZ
	cqcPDQKq58FZ41PIpY0Yn0xwaT4/34BflDjOz0GZET04gbdjyEo1sFmfkKQ5VhvkVCeBHnF9AH+
	WM7AwVQns59XJEaNQZdvq+3FP+NR0V50QVxtThIcyqIzg7MV/IvkrPNY6NLQWYwuqsF/T6Ek0Km
	b81uy5db74G6jnCjPB5wSkI70DQ0Xv/0+rJKcMceZF+oANW/RqYr0Y3J/LshnhZA4JmB+k8vwHc
	YAp0pcUsdFEvl/hHIR8vm+wYN6sqVIef5eQZPnLqOyAHHVIHwQiH6+/EH5g8opEagfk3/pyW+I7
	CYbS9IsfdvZxzZ5n7i+BzhipOMesMhoE7qLQGCBIgAADW3S8y5Gik1bUTIg==
X-Received: by 2002:a05:622a:110e:b0:4d8:afdb:1266 with SMTP id d75a77b69052e-4e6ead4b14emr28047091cf.45.1759898000640;
        Tue, 07 Oct 2025 21:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0YbmahMqK0zNL1+oiEjryjk8HMcc1ReaJR4wM77+ILX29Y2SbV3PXQpAS2EnSlvzslr4s1A==
X-Received: by 2002:a05:622a:110e:b0:4d8:afdb:1266 with SMTP id d75a77b69052e-4e6ead4b14emr28046941cf.45.1759898000165;
        Tue, 07 Oct 2025 21:33:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119f461sm6751107e87.107.2025.10.07.21.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:33:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 07:33:02 +0300
Subject: [PATCH 4/8] media: iris: stop encoding PIPE value into fw_caps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-iris-sc7280-v1-4-def050ba5e1f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3537;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=N+IKqzurGKX75UM4EW+hTzffIcDi+0wYJu9pHIUdLPg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo5emCs3ZLTV33Szlchupn75t6PyGmNGwdnbRKR
 ItAl6id6yCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOXpggAKCRCLPIo+Aiko
 1aiGCACp+lBVfmjmxwRnTemtd7DpkWslHgtXtKgbWhDISyW+I2XN9e2VON3VR6BADmP74o3MZO2
 i1HGDeooYBOFo1u3PJZhynN3YvWGj1moEIAC2wEAFFPToWnvCEM/UQx6Dn8cYwSXxaPfPVmmiaX
 PK+FdjoTYwpsW0sTzt+0reUC4N0rDiANso3vmg5Brv8v/u4GRP14iGOHObd+SAGwbNH9xiNdTuR
 mnt5w67un3MFCzp9XXsAXNYdc/0Vxf2RyBlxLcqj9vnNbG+HFRu62JzHL2I0ZN8PPIrxyAz2t2g
 rYXzZ7wfpwjk2NBhIef681doppXPEOnKfxGayaXV5PAzhQeR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX7FCweqFMuYg4
 ZRkpcGUG/5rnLHc7O/f9f9NyHroBzFrSJ9D/3JpZfgUhpyNmgcx4e5aopKUKowsuA5BepXsZdmc
 T1hzh3pfoPiXYpNcHB+LA+cgFc2c2tOHSxDD1V0F1vLSbasiMfiBPHMC3L/tAqH8B2RxRunPg8l
 qiSXpzCYWPnSp/5izwuhbK1pcRqgSSeA42wsiyOdwStt13AIk/i9RzitNZNRLBVxOPtgEwGiYYX
 5wHv9wqMrF5D3WGzF1Yk/xZFXBhgmT0eN66dy4niBrRmbpd2cWvXejo3qoSqvSn81+uMI3GHmvD
 6myyT3fWfC66cYuqy8vq3rMfEqXnm0oi5e+EnKy5Hn4JpeSO/AvB2P5hNOJLVhqUq5GjgNKsJzL
 kkm8XPzBFfKA8c0RBPvYHHsNct4QcA==
X-Proofpoint-ORIG-GUID: oIByp-QIlC0WJfb8XgkC2UmmjHvTKrqf
X-Proofpoint-GUID: oIByp-QIlC0WJfb8XgkC2UmmjHvTKrqf
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e5e992 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Fn2TP4Vc3OsuT4lKjqUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

The value of the PIPE property depends on the number of pipes available
on the platform and is frequently the only difference between several
fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
iris_platform_data rather than hardcoding the value into the fw_cap.

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


