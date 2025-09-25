Return-Path: <linux-kernel+bounces-832271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11743B9EC83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A270142464A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27582FB0B0;
	Thu, 25 Sep 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joVRSOVc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477872FAC1B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796977; cv=none; b=sxjufqMYDZ/gVp9ilz6+lVTm6AonRSPK6wUkBKFmRuo65xIIM+IVutb439Hv12UhWNBVnOBYoecWf8JRgza5AqZJqkJIsmwmItzORP0Uwz978IOVBTB0WheJ/H9sXPdWrGisiLBATpulD0hAGNLGYuSAsFRWBP49Km6Ms8Dk38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796977; c=relaxed/simple;
	bh=6hJQu8sVuECIpGG1zcQBiA8+IoZKHEuXd1Po+itz8bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQaxdsuqfSTyC2xd5KeVh+O4AyNu2WWhcdhJnqb4YnqW3vIzxz7xdOLU0edoqJP9ylNhjQjssyYhUDKFF+QjgPkRulDCYRTs6JYzd6djFYA3/abhKfznjjYvSEcuLUteJ/LIZqZ5/s11GE0vnmwLYrMWPOIVQWBFoW1jSuJgTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joVRSOVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P90EbO027782
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8CLWFz7RuVZjswljNK7uzTq6+mx1G/m7eJ8hvj0C84=; b=joVRSOVc/dm0JlQb
	PhYDpKrP1FGgPA3nBgvwjqWPuCImILBpZtq0TD4+fvgAbqnUj6gDmiRKX6FoEh1T
	5bquaprrLQS0jLF0MAZ/4wXER42RYVIGYu5aKEB+PGHYW++DfEw4WmU9TGmOhWgO
	G9vMTObCTlZeGtIxtaEZoxsVIUBkzBCxHUkGhUTdP9VyYL7f6ZmHIUfkZW9oVf1O
	bjrt6bhj8yYx/HHXy64Dk6sCPxtgngk+6xvICtQum/Y8RXHpMJbalvLEPtNEFcUD
	Cp1Nqj6VTlKuU2tQMJIzPWi2MM/AO/Fd0+TknvJRxPR9EtPjHglBCNNIp1k6w9Ec
	Z6FCow==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmp05b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-267fa90a2fbso19438365ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796974; x=1759401774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8CLWFz7RuVZjswljNK7uzTq6+mx1G/m7eJ8hvj0C84=;
        b=lw1/SRnjjs3E5ZltTtC6Qv/y7lTEPiOw973ENCK3Ls2xAB//nAN03KR18l6DBlngkG
         kB0SfqtMHZoIGOAp+ctHodxxM1OU8+h2vTdVI/lRPz18zghPkDKZnuz5fa/AS4SOcLw6
         iqRf6QqeESamKT9gKHc/NTiF7nANYRxtFb37pVCdvRDgyNxLMH9HtLKI1Xa4fDUDZXwr
         nQVbeWZSu50eMyfJbSoyElgynGARIsy1GCf+07FX5ZjWmyd0JjJTz27ZY0ySBSRYA1RL
         WklcUX6fkpt1Q23Mc1jyN5UXjxRac5p2YgTSKm2i0WEKxLEX3wvEFHuuKcItqXZXelZF
         IzAg==
X-Forwarded-Encrypted: i=1; AJvYcCUjcxBUnqckSPkxujDdRPQ5HnTLKRuZbr1lywQ/pqkTDGVzHrupFoAPROmUCCnLBkGT4qus0lrIGpaGr+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xW/UDtVtpgbI7/bl0eETEgSxq13sN6z7NOFui9h55CDTRt4g
	Y+I/Ray4ifDJwJg66Tie3pA6pGwRugONluWS23l5HFee/5nJxwcVL6+mDLucZdCu6Z4lI5Ujjo4
	hadR4N8q5vVW7DBczDtvVIIC8zM97E8ofHzhanoYicnRBaHMP5dGMqxkYy3LWX9zBOOM=
X-Gm-Gg: ASbGncsp18Pnj+gm3r5/tMs5mC/DgYgfW/pRkpAkpmOcGKXWRJlmBALnknLkscbTfRA
	dTXMMAMkbVlNXWO0qW4+sCW6fG2HxJ6eE48zBx56tJ9pfsoOH6SDLxAovOxJIGwAdjIsfi9I8tb
	GwSsjhfzUCe/iuqtxm+egE+B0BdA7Mlu5mVLw2hezFFQUqG07EcTMrdXDfTchXbHyWFFsxWHm2r
	KUzxWKh7S7tX2QdcAtbEdpLuhd15rPcIwuwKr8zvQtF/CoychCLOY7qceEEaeGEvnBsITpNWRVO
	col/QlwRK3DHBn2c73W8U2OWRBsI2tgp7ahbVqMm8lxiW9HXRmB7lSzOUTPXGmmrAqdMEy46SCw
	A1kYurl2QKajMV/1CM77zPWAOc4c=
X-Received: by 2002:a17:902:ec85:b0:267:9601:dca0 with SMTP id d9443c01a7336-27ed7218e13mr24248975ad.27.1758796973820;
        Thu, 25 Sep 2025 03:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0G8/NZgKJnhaVOdgJM09KwUXkWI+O18jBUOCePLdswg8OrdCjedFCc4xPV83qBAglXjkWmg==
X-Received: by 2002:a17:902:ec85:b0:267:9601:dca0 with SMTP id d9443c01a7336-27ed7218e13mr24248715ad.27.1758796973333;
        Thu, 25 Sep 2025 03:42:53 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6727ea7sm21046845ad.61.2025.09.25.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:42:53 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 18:42:31 +0800
Subject: [PATCH v2 1/3] coresight: tmc: add the handle of the event to the
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-fix_helper_data-v2-1-edd8a07c1646@oss.qualcomm.com>
References: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
In-Reply-To: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Carl Worth <carl@os.amperecomputing.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758796966; l=3140;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=tHg1S0/CMUeFUXHjzpKxW+80GxEVQnIjGvOC2sWdHXQ=;
 b=45YdQeepVPMs1UJloA72VJbiseOSEnSPvY2N9hB65a2vqAiKihPLdSEGOvAeVAcsWyyueiMy7
 lsX3i2P8+rUC80cqx/w+RsXyQIrecHWkUkf06n9rVmK/BMnntQdMKKH
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d51caf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=ck2vDrGU2QCsmqff:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=3z9VKJkIq1Abr3NU0PoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: fZcIaqLOEh_9t5eOaWKLZVcbi7GF6qVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX+KoxFhRZn/bU
 crymufopWuIoquco4VlEk6upejNPIIFmFmWUaL5CGQqnARJnLsAt6dcN2U03kjApYO2BdR8k363
 AIAu/iISQMO9FtUWRqQj2phTViuNIPwXN/vBy8uEDFmEJOSRsmv/XVBD5tRUdJ1ASnK8MT4aNV+
 Bcg12GrNrg4XnqUIZkSVcPy9UPSCd1mKrAc6g4+nRxCrlnthUFFu1sUcemHWU30c5C5W5EFRBm2
 tvnXoyZaC7lmKK5wzBj58Y5HySdK8vhVXmPZLNMKXTjioV2Ae/JuTk24F2TkcDMx+C64UakoQ4G
 CW3j2K+qU5wCcxXv0Zb9HRKrU8RL0qEOhXDgkV1LzQaLqhfhUJw8xJxbAW2YFCWJ+45GqFsxMUh
 HTY6Iw2A
X-Proofpoint-GUID: fZcIaqLOEh_9t5eOaWKLZVcbi7GF6qVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Carl Worth <carl@os.amperecomputing.com>

The handle is essential for retrieving the AUX_EVENT of each CPU and is
required in perf mode. It has been added to the coresight_path so that
dependent devices can access it from the path when needed.

The existing bug can be reproduced with:
perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null

Showing an oops as follows:
Unable to handle kernel paging request at virtual address 000f6e84934ed19e

Call trace:
 tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
 catu_enable_hw+0xbc/0x3d0 [coresight_catu]
 catu_enable+0x70/0xe0 [coresight_catu]
 coresight_enable_path+0xb0/0x258 [coresight]

Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c  |  3 ++-
 include/linux/coresight.h                        | 10 ++++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f677c08233ba..5c256af6e54a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -520,6 +520,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 		goto out;
 
 	path = etm_event_cpu_path(event_data, cpu);
+	path->handle = handle;
 	/* We need a sink, no need to continue without one */
 	sink = coresight_get_sink(path);
 	if (WARN_ON_ONCE(!sink))
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..1040f73f0537 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1327,7 +1327,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data)
 {
-	struct perf_output_handle *handle = data;
+	struct coresight_path *path = data;
+	struct perf_output_handle *handle = path->handle;
 	struct etr_perf_buffer *etr_perf;
 
 	switch (mode) {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 6de59ce8ef8c..2626105e3719 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -332,12 +332,14 @@ static struct coresight_dev_list (var) = {				\
 
 /**
  * struct coresight_path - data needed by enable/disable path
- * @path_list:              path from source to sink.
- * @trace_id:          trace_id of the whole path.
+ * @path_list:		path from source to sink.
+ * @trace_id:		trace_id of the whole path.
+ * @handle:		handle of the aux_event.
  */
 struct coresight_path {
-	struct list_head	path_list;
-	u8			trace_id;
+	struct list_head		path_list;
+	u8				trace_id;
+	struct perf_output_handle	*handle;
 };
 
 enum cs_mode {

-- 
2.34.1


