Return-Path: <linux-kernel+bounces-776207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58707B2CA05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2625803B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7832C234B;
	Tue, 19 Aug 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXRdml3m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7D2C11D8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622528; cv=none; b=QxHbVBb8EDudbh6tBc2/GbAY4A4FsBJKmVFYSebSuw4SI+NoSQx1QyQcWyg88m3JRspSOzKVM3EQQeLRfWjyZpeLjgKuPUR9M5uTfulzQCtQ3pVSzcapkdujdBEbHBqIA35fvbK+Xv/xJA0kwshxMEoGUnNem5/GiihsJ35XuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622528; c=relaxed/simple;
	bh=/AflHXTFVOH16SOW2V+0meYRbIqCERPZj2WZC7Vo8H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euC0vbMgXhjTF0+cCmDA7UYRSGu9GQ7aRxQv4/jOB2oNOuTYL+5tbaouVyVDW8Qo4YK2wYprV05G4g7fxaIDkyK4WoFw8fYptt4IlWTeQtwF4nNYm4S3HvEC1z3PzeTf38Zi53oKGJ3nH7jIHedYOJVq29mE3ccgwbSpTkhmAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXRdml3m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90awC008391
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pXVD6URM8iG
	tLYeJuDTnL3ZNXgs+m9zGa8usL8h3epI=; b=cXRdml3mbCs2lHhaZJZzWvieN84
	kUS2hI4UYd+t00HXPun/dT3q0wvOzh+VJZq5Sz4z68oWu6692DeoM6iHmvklrRvk
	3kO1lhs7ViWgxA7Tc/8A06DVdWK60h+dHVuL4iS4EVmLd7n7orD79MAnQhiq9Vea
	x8mZItrgJUcJNZo06G0lcAL8rfbWcfRdZwY4kzuyGkAAMKVwMehXWpGYZMQfcL8c
	983esjVm9Rovo/ji4enBKuQseE70aQHRkDTwV2jGVxXPg3QtFeb8XiXiB3pkMrAK
	rdh2t6kW9+ewtdHjPflu6mtlmLLbkbFSZzRHSfsZ+kIrBBC/BRbbPRx342A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99s96b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806eab4so58151955ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755622525; x=1756227325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXVD6URM8iGtLYeJuDTnL3ZNXgs+m9zGa8usL8h3epI=;
        b=acUr5YWrl1vCEe44chJNYlRp8bMlvE6xUsqUi0/5Fm0/2q76Lj2p1jhPGj+DG5ajY9
         4XycXrZ4abdXHXLCHRWbtNL1glzYerVZ3FEKioWXhHjwEverl2pZWuq72RSEfmLj2QXm
         FikFtjP9kDsEAh5cWi1inV46mQiijF1IchprHmyqvVSAIvytY41JxSEdROPKlib+1LVO
         fE+IHxc/jFl2iZxGTzoPRV+V6RVUqBuT5mtIIC4EmSHCU0ZKagh4SvQx3tFmF8LDvePN
         4yY+Toi1/PBk3K+3grmigavZa6DNooIsRlCJGQu8nO+7sXBWHVYvtG1L1bUVHMGXzAoq
         FCEw==
X-Forwarded-Encrypted: i=1; AJvYcCWP8vI7KVcoh47XK7Feed1YwsPUV9th+Mpq6U+dgzRtLQQ30No9Bl1wD1cVxftFFWmMe0m0Fu/09hMIZ5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAfBeNKvcdO8KdbIB86Bf64iXuHHEC5uutPIhK1m7ZijBl52t
	pUtga/e+gWH2M1d9inBtHyJQ3yoFbstdBl1Zd31qsh2t8Xtqnh0fIdMPA0CaF1yvY8wrt5RuMqK
	sCxUuLD6TF5Gk3AfnF1T8Tuv40sWKEmS68gMbFMaFRGv2wykZRBclx4FQIqXQOoNllEM=
X-Gm-Gg: ASbGncsII9VmI29B8Wo9DGhW5yvty+ttYCA+zuVY1aFUU5qedXrs+AMC3hCSPqmzIWX
	G3PSMfJ7Ap0Rb9ebkoFsnpf1hArvX/OON57q3aE7dgrQpS87QyVt9o7HprX0kJrsb6V+I8xWHHP
	CBBYrag2Zq4mULIO5GaEayI4Fta6siLromqyXz7Jzm+Zpu62btleqbcE0q2Q/N3+51P7IYvN53H
	SuAeKADrFhmvRi+l+HnZ63AhJXEDKNjcYgy3sgm3m2hvilFk3TtESgZOz99Q4CnjVxNroDUvnwO
	vY3qocNlPnRG+vQ59ANhfbDXSk1MAMatxlJzd3AGI4gi+ZKBGdcUposakEma7E8izyQ=
X-Received: by 2002:a17:903:198e:b0:240:967a:fec3 with SMTP id d9443c01a7336-245e0484a9amr41225435ad.29.1755622525327;
        Tue, 19 Aug 2025 09:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lNYppywDdTFFexVwLhEK+BRHzaI9WsoHo0SSwLAnNl6dT+h/o5sN/sHh1+Wi0XAryEA6Lg==
X-Received: by 2002:a17:903:198e:b0:240:967a:fec3 with SMTP id d9443c01a7336-245e0484a9amr41225205ad.29.1755622524920;
        Tue, 19 Aug 2025 09:55:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33aa3esm2273885ad.24.2025.08.19.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:55:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 01/11] firmware: qcom_scm: Introduce PAS context initialization helper
Date: Tue, 19 Aug 2025 22:24:36 +0530
Message-ID: <20250819165447.4149674-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1Gnd9fsFXMDee2ItiqGS1b2-UwJtgYxO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX/Mqbkl6uQ+qy
 BO/XzZXPF3ri6VMi3Y/HLeTqbCIR0y4+i68sZ/MgzyBp5SuhosCYUJQCWGhOcUSxie+uv+ethkz
 +z0mNox87Lnoqg2G+OXg6ptM1YFz5e6neMAhtzLK2jQNrlYxwMkDE1HV57MHBgFmoldhc0h4Njs
 Wj5GQsyxs0Oq+jDaZPP+IyoiZs2dD0R4n2Yy5C7iSvn/6JV4UzzrgZoTR2GHaNryKDghSL0DGLC
 w7ZscT4WdH/8OgwqcI9cRd6bNU6gJXdZ/8OY7QHZZKbOGT9Mvk3vRilfeD6JmaiJ2PvKpui+kCd
 8Ai4yWcpVPQH1JES/JD5v16n8d85KM07CdylzTaF1ItMNb5oUsCUqmCXL8FwGcQReU9HPUlfYEU
 acMEbAJp
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a4ac7e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=3w5JJ7MTCOpz5QvkTaEA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 1Gnd9fsFXMDee2ItiqGS1b2-UwJtgYxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Currently, remoteproc and non-remoteproc subsystems use different
variants of the MDT loader helper API, primarily due to the handling of
the metadata context. Remoteproc subsystems retain this context until
authentication and reset, while non-remoteproc subsystems (e.g., video,
graphics) do not require it.

Unify the metadata loading process for both remoteproc and
non-remoteproc subsystems by introducing a dedicated PAS context
initialization function.

By introducing qcom_scm_pas_ctx_init(), we can standardize the API usage
across subsystems and reduce the number of parameters passed to MDT
loader functions, improving code clarity and maintainability.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
 include/linux/firmware/qcom/qcom_scm.h | 11 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 96d5cf40a74c..33187d4f4aef 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -558,6 +558,32 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
 }
 
+void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_phys,
+			    size_t mem_size, bool save_mdt_ctx)
+{
+	struct qcom_scm_pas_ctx *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->dev = dev;
+	ctx->peripheral = peripheral;
+	ctx->mem_phys = mem_phys;
+	ctx->mem_size = mem_size;
+	ctx->save_mdt_ctx = save_mdt_ctx;
+	ctx->metadata = NULL;
+
+	if (save_mdt_ctx) {
+		ctx->metadata = devm_kzalloc(dev, sizeof(*ctx->metadata), GFP_KERNEL);
+		if (!ctx->metadata)
+			return NULL;
+	}
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a55ca771286b..b7eb206561a9 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
 	ssize_t size;
 };
 
+struct qcom_scm_pas_ctx {
+	struct device *dev;
+	u32 peripheral;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	struct qcom_scm_pas_metadata *metadata;
+	bool save_mdt_ctx;
+};
+
+void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_phys,
+			    size_t mem_size, bool save_mdt_ctx);
 int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx);
 void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
-- 
2.50.1


