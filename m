Return-Path: <linux-kernel+bounces-776211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C4DB2CA16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64A3564FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3E2F1FE5;
	Tue, 19 Aug 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUr/u2nm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB82E22B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622541; cv=none; b=M284XxISLBNMYah4gc9w8DNkbicX9qUKmleZZyHepNcbuumPpfZku9DVTQzHvjJvXPmLcvSVXpbm7W1IuWjJ3ryuIDFxGXyrRQQ5CDcJ+lL5krRb4nh0CgO5ngVmjh0Mwo6FyNPKmlxAneZyxOdFsmU8DvUCkPSdpb2c1d7cOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622541; c=relaxed/simple;
	bh=Jz5i0hb8iPyBN4hHz1WzlmNjotDeNcwA9V2rf5gcWrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG9E4JRKMV0JJefznBkhn9HBwtlQMiyghntL2FsqvGvMlpDYlOfj/2DXDk3nxm8O+D8GlEOMHuQvNC0Twh13gnfAuK+3ESj7fMheHPaYwtt4urOaLJmBb/2zcVH8jVTP9tDBKKrWO/8ojTIN1x4XCFT8Dkw4y0adsMsE1AU6YZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NUr/u2nm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Ysv023100
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MHzX4m9djdY
	BrCYq6RUgrrQ8tJswsBpsxDwBSp7qf/U=; b=NUr/u2nmxmdVRpXNIpi6Bv/ZqJF
	QaF80JGuChksMqQWy5NghH2UKhmKs/DyGXhWImn0feeIlofLOqVX9jY3q7mo38IX
	kepnbVDMivsFl9nwsC/IjIL7rxMI3voD2/CDVL1tpyduMjPWpoHpKCPFKVF9X/Fv
	mRdjtAy50pwfxZ0vbwX+bcDaB5Kndt//uW241ypCIczKc+CNUDtrxzJVgx7Zb/bf
	0WlLgwbdIcFtn+ZxqhfgyMWY0+/oeElA2farCiWXCtqbt3PABUtQNVApONhHFl77
	2eTn+FS2HFIdzSZXtEigG6kCG9XsWmyGl3HBNFyaDF3JgJJkOoLON48PEfQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5k1ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:55:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445823bc21so137729755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755622538; x=1756227338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHzX4m9djdYBrCYq6RUgrrQ8tJswsBpsxDwBSp7qf/U=;
        b=G3XfFKjpwnRm67YGM1bDjTVGAkw0jFTFIKrcPxASBzfypyQfJ1xxXmNJZD9gpfZ62d
         1I9PB91a+cKeygvv8RHQTuIu0/qanbAJPjPHem81NLJFjkGJ3h4gf7gnV3+Sk8/sGeEJ
         VLp851QdGnsqad3T1ChTcsBKa9IPROWpDPN7F0ECcm6uqsJS0EdqMdCdqL2ZOzfarxxR
         zOFZ3g+STqAz2/LjKM0XjmPTeZvVD9jW3OyG/R6KWqq5U4GaG2ahSrKm5jkKHCmJy/et
         mehxi3kU4moVgjliSSD3ARYxEFW+cycGQhwMEx+2k6RKr+At8EqAJktlYDxR7VJa2875
         UVCg==
X-Forwarded-Encrypted: i=1; AJvYcCVeYiNss5rj0hnT+I0gnQF2i46tSShj1XexWnZg0Hj25Lo+fVjFLMWYAD23aXKVi5Cm/DPEvJ+JektqttE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcE0AdQjXapkUuLusG+k4nFpRM9zSi1hLAtgzHFpr+Mf+ecdRI
	aQga3L4+moGAhTDhdQiYMsdbsRwO6AarNNPX8X9vorbZMAvJzBpalkROOhuVDNizDDvrTW/NZnU
	ym3fm1JOP4DMOcxyvHN6GkCf56Xflk5qReZbk1zmTlxgvkEwPQXqxRPmXDijbHVbzwvA=
X-Gm-Gg: ASbGnctMm5mDt/intyFBjsjYDLCcQ3dNdsqerInR72HMj6JFP15rLM/v5ZXyV629Lhs
	A1konOrHdk2yN05E4pIy+PWcXDulAS3IUzSfci0+/DBjJNQGKEGpWAZl+Ej2L4TjIbNAqhMu5Rq
	mw1nyueJQk8S/oeOaDtHNdpIb9oS+ud6O80AyDzFcXUA34boqS3YFfB85ZnUnRJBiuxy9iLUy21
	JfZuoryXjztiYFzAvCn6TWsAIB3XDUJmuvZJvMhZAchBzHBREaoPAxHm+chQSz8sfJ4tojUTQ4G
	4P2Ice3Uvnb4cSnRfcwCieDxzxl5/+ajGjfdDA/dyJ+TJuaMr7yPx9C11FU83R9BSlw=
X-Received: by 2002:a17:902:ea0b:b0:243:597:a2d6 with SMTP id d9443c01a7336-245e02a52ecmr56407085ad.1.1755622538302;
        Tue, 19 Aug 2025 09:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdZh+CflCKOL+J9L55ubWiuqFife6t4XkwShQjJuGcwmfkYC9b9mA7fxGUIeUJ/HsPN4t1Pw==
X-Received: by 2002:a17:902:ea0b:b0:243:597:a2d6 with SMTP id d9443c01a7336-245e02a52ecmr56406285ad.1.1755622537275;
        Tue, 19 Aug 2025 09:55:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33aa3esm2273885ad.24.2025.08.19.09.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:55:36 -0700 (PDT)
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
Subject: [PATCH v2 04/11] firmware: qcom_scm: Simplify qcom_scm_pas_init_image()
Date: Tue, 19 Aug 2025 22:24:39 +0530
Message-ID: <20250819165447.4149674-5-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a4ac8b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7vI4Mn6wnVF6ixtUiuoA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: hqiK4IeEU8hOEKJHYOw2wCoSDTIW6nId
X-Proofpoint-GUID: hqiK4IeEU8hOEKJHYOw2wCoSDTIW6nId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX1bCls0mUq0BC
 VQQ0H+BDigIQ8Efr3uWCttT913z9mde6sSdkNKN4lQ+AjJa/UlWG2aMVOsVHvoTp/2MVbFhQYUF
 hguNDCEy96kQmijnrDcmBDgJDsx/yjJ/1mI7X6ATbtugYa0fsClCvYthg3EABieijMJZ/zWi+8i
 NKCFgYZz3BXcPRWERTNe8e6GnReFcV0LyWK2duSJpMe3lKEcHmzjKahmZeEm8iFwn/xno6gejxr
 bybwJun1teA7q0pFMp2YK5K7m0CVMn/N2j8eWmMhJxaWi8KOvIHlThGGJX+U36HIwXhTBOZzoHN
 5WK1LA9kxJpn6gCtAG9YO6DTmCxHIz7q/e7Q8ofhHmwGm3ze2nSs9GnsROJ7GnIYJR9ZmqgWzh9
 IyCWU8+O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

Simplify qcom_scm_pas_init_image() by making the memory
allocation, copy and free work in a separate function
then the actual SMC call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 59 ++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9a5b34f5bacb..7827699e277c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -584,6 +584,38 @@ void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
 
+static int __qcom_scm_pas_init_image(u32 peripheral, dma_addr_t mdata_phys,
+				     void *metadata, size_t size,
+				     struct qcom_scm_res *res)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		goto disable_clk;
+
+	desc.args[1] = mdata_phys;
+
+	ret = qcom_scm_call(__scm->dev, &desc, res);
+	qcom_scm_bw_disable();
+
+disable_clk:
+	qcom_scm_clk_disable();
+
+	return ret;
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -604,17 +636,10 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
 int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 			    struct qcom_scm_pas_metadata *ctx)
 {
+	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
 	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
-		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
-		.args[0] = peripheral,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
 
 	/*
 	 * During the scm call memory protection will be enabled for the meta
@@ -635,23 +660,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	memcpy(mdata_buf, metadata, size);
 
-	ret = qcom_scm_clk_enable();
-	if (ret)
-		goto out;
-
-	ret = qcom_scm_bw_enable();
-	if (ret)
-		goto disable_clk;
-
-	desc.args[1] = mdata_phys;
-
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
-	qcom_scm_bw_disable();
-
-disable_clk:
-	qcom_scm_clk_disable();
-
-out:
+	ret = __qcom_scm_pas_init_image(peripheral, mdata_phys, mdata_buf, size, &res);
 	if (ret < 0 || !ctx) {
 		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
 	} else if (ctx) {
-- 
2.50.1


