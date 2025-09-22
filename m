Return-Path: <linux-kernel+bounces-826771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFE0B8F4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6519F189F60D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2632F6166;
	Mon, 22 Sep 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I37ZHM3H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947142EE611
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526330; cv=none; b=C5QyGWTEl7tbDKTBRHstcI9Qqt5tS7oF7q+LhOoz50q5QD/Ogfa/NKD8R5OGOB0H5J6Hhcnkwz7S55vjNJQeMbO1/gbcvSWEbh1VqxI4LfHp3g5pPsh42ZXp1g/+VAeDy7+CcsKo9i4cJ8cJ+u/IadIoEBIM3TalccFgFeCBHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526330; c=relaxed/simple;
	bh=7QS7PVZYOwghmcjQZm7ZNanUnsFs7B9cSJZhhEysQQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMUwYGPkFRwFV1oCp6vdzbp6qu48kbdawRjhQcZqDAsOxDuuEPv1dia53V+iBYDBV4yhbn/3bPQQFAY/2My8IJjFMkyO/MLLcPWOOllKpxpzPY5FETykZVj8bPJiUyRVJxRGLvpoV49Bcnu8n4aq84XD4geco3AK2201VymYwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I37ZHM3H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LKjPCW019452
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQi62HqkpD2bVNcH9CMZOAQ2N9Y6g9An2bvA6I9tnx8=; b=I37ZHM3HnRw/uJ55
	P/nDwboYOSv1Oj0ZOeyqsVTtsEG3BFCbnlcaebzu7WiuBY+lRTaFjFT9ttYzcHwM
	JO8Qz6EsgdJaFLymqOmlRXp9zV8Cc1yrzw+1qYOA4NbcWiwulWye6VUSb4c3buyt
	FuoyOSh81Jk+YJybSnHtLly2El7Bc24gFH/35ABcYWJCUwhh/exX5QQzE6/tMfBU
	W5Q+ylECuI1ZwZRbp72RcXQgmwVk/W2yLn/0eEnRpMJNFSTi0Rfw0Mz65QqDjDoK
	Axwpzi620r1POTybHh4FEcnmHV5ZqMZlGUZPKVMdAN1XEqk4Ks/83VG2lm/uHghP
	aS7DLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg33r2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244582bc5e4so45537055ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526327; x=1759131127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQi62HqkpD2bVNcH9CMZOAQ2N9Y6g9An2bvA6I9tnx8=;
        b=iA4JQGswpj8bsXgJzriwIZFTkCz2B0S6vedZe+GFL5ZzDMceKipLRA30FiwdQGNVPr
         45Qda/3QkkLcbpUO3gMZ0n0mPyKtH21TNnyJC3a4HH1XET9XmkyNzvOyy7hAFGwK7luX
         71sxCNTNPNRh+7LnCxf37nN8aZYswVzgZBIzDTKx7S8l62jWm+mM5hGaHMXQe06rbXG5
         5An8JbP0kxh694ghL/envVyRsDqQiqcjaDQtQvqr5LyxlYLQg/NSGWd5BOZIG8xGbZOP
         GYZeI2y2yqXRIF+3dXjxVNYPy5j0o80bbYXmDumM3WjVBxj/JX81XkjBcZpVoidA7ai/
         qziw==
X-Forwarded-Encrypted: i=1; AJvYcCVqlcW7G59o1t+RWDuPH1cSqOX9DhSx/VwLMUEGVnyjs/kjnIQJMYXzQidW8uvs3csWcjqu1zeEUnjhNc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVO27tnbnXDwd0HDMWojzlvVUNwCMGdrr8WbBYs5cffNwDd4U7
	qYBZhwrXx+0yU4Nb/trRkqTCCCv0AWiCiNetLhozF0PG+WjvScpUDYpdy85t3NXhItjG363aWG5
	rfosGh1RDGNsY/+3E3cihR5CuHVDKuoDsbzJWnJumD7aqQpcT91ZL6x01rjMVzFesMOo=
X-Gm-Gg: ASbGncvEvsPTq1Tw2QdhUjkPD8Zpm1i2o0maDS2wLMlD1yZnqaSd6yyMFpVS7xN6iw0
	Io9H7k8uUL59gAk5CtROoJLEbLhMTCgUyHS/QzeyodfakW4qS8HdQ4NPTwYl5C45qkmiuEnKtrq
	8G1E1oGeawZ8Jbpqn6jT2dklfoFC95scnVMlDQYttZ1kqn/1ezZySQqnofyJ9b0sxk+MYr+e6Tn
	jMM5HvhKIpWmnT/goW+KCiSRl2aICVqr52SF/NtZhAIYhctEQLRwAtjEWTcJvtGp7hy0bs69plV
	P2JUxrBdNkxdgWigj0KXO4DpG6rM8OmrgvpaFBU2fcAV4yWeYFc7kaas6AQ88BDSbVGbehg2/b9
	GJAbOqgnxJYm9AM7xF/lEF7f6+Uw=
X-Received: by 2002:a17:903:2d0:b0:24c:bc02:788b with SMTP id d9443c01a7336-269ba53c0ebmr154946505ad.44.1758526326584;
        Mon, 22 Sep 2025 00:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz+nMZTcyNRr0hckCWlDT/UQXZGGtLRJwMI2Ea3XZY0s6XMVkdw7M/B2+CSosx3seJPnCaMg==
X-Received: by 2002:a17:903:2d0:b0:24c:bc02:788b with SMTP id d9443c01a7336-269ba53c0ebmr154946155ad.44.1758526326067;
        Mon, 22 Sep 2025 00:32:06 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800529cdsm123806865ad.22.2025.09.22.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:32:05 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 15:31:39 +0800
Subject: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to the
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
In-Reply-To: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758526319; l=2707;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=tPjMdil7gxCwjC8YbC6YODeceMt/ZeL5Vyiw0lVmYeE=;
 b=4mpDNdSNuz9Jpo6MxISK9MiwQupv+EU8xwmuzB++YqlMXtb4VKLAWUNs3Jrz6rmmZ+PG0/aJl
 VZ9AJQs36h+CreAjWtqFq9ahKJi1iB85MmZ4ayZSfNNrTu4q7s2j3St
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX35bs1dGc2d/h
 To8cLGlWiG540g07RzIoR/ZTBv9CEikTQRIFE4s0Dwgb+EZIdvGD/Y5d/eriJN3xEggVE6SrJ8+
 Uf3iXRw8w+6ckdElN8rEasAlEuDYOQ4QukJuDsNaxASQ9AHzj+ovBNeQ/ApqMXsBXt2Oi24U5LI
 4R7a1gszhO0yujblr87sy9eQ8l7Keid5Umjh/CdKsjcKjDc/RP505cLZnW8luiIaOpQakjIcljd
 1e3FDyOl2ZRK/4ouOuZeEBYe/6nbmmbxwlRIYKtQpUCir5ZwDSgJ02Gn67dWmLEG0wEiQUP6nfF
 biHCzttwa60lD2k56SRwCRYTa3HvcGGB+W0tksT+dUqLg48o6odTWlowAW9ixcHECuzWf731J22
 fowAGh4j
X-Proofpoint-GUID: q3iAQqjt_5erpI_MCGST0ezUvizQiFjH
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68d0fb77 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=ck2vDrGU2QCsmqff:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8
 a=EUspDBNiAAAA:8 a=ml0eKJYL87Gv2QZM9wAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-ORIG-GUID: q3iAQqjt_5erpI_MCGST0ezUvizQiFjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

From: Carl Worth <carl@os.amperecomputing.com>

The handle is essential for retrieving the AUX_EVENT of each CPU and is
required in perf mode. It has been added to the coresight_path so that
dependent devices can access it from the path when needed.

Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
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
index 6de59ce8ef8c..4591121ae1d4 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -332,12 +332,14 @@ static struct coresight_dev_list (var) = {				\
 
 /**
  * struct coresight_path - data needed by enable/disable path
- * @path_list:              path from source to sink.
- * @trace_id:          trace_id of the whole path.
+ * @path_list:			path from source to sink.
+ * @trace_id:			trace_id of the whole path.
+ * struct perf_output_handle:	handle of the aux_event.
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


