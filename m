Return-Path: <linux-kernel+bounces-826772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC1B8F4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90449189F679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D462F548E;
	Mon, 22 Sep 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLrjZNXq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E82F617C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526333; cv=none; b=ircp19RXEVbdXwTS8WQAZxFyEAJeJpBYd+IcSu+AKA25wv/k5ka/uHMSGnTNSgjMjXDKn+F7DuD3JBH64LIglHPUimrslObfZD83JTkVypmmdqi/62IyxOvykdngqdmOfmGsyXdk1igrfVLkPxWfDgnExV8FQ5dO3naV87SQehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526333; c=relaxed/simple;
	bh=QEBlXI+s6Pg9S40qJyLflLft2wUwobd5Tsvp12e09dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fS5O0AJOe+Yc3MuHSNikpDalz68mTayopbertYkgeMO+MOziiq++148Pit1YDaCQ/DgY85VvBeFotBZUMBKSJjolhLIYoP7Uy1vl6QYO0W45N2uMMnhg/zVIfVmz/xftsuYAJE3D2ZNrS0Q8pxi8abuVn3PdD/d7REzetdDB/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLrjZNXq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LMnTnw007783
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufG3sJi0LeG+2kPC0a9al27kJCVNII9Yo0Sf2m3fcC8=; b=gLrjZNXqOHVAt5k0
	NIsVpduON6SlA/lSw61zvy7VA0SfMpZAt4C55EWIFNVBGBXAm0Od+tyR5To+YJ7D
	2IjRE8bGYTsWqgDl82neXtuPBbJFOvW4ZeEWCJfQzyzClGfvQSxXLGYJH8Gzh6WD
	YKfn24h11svGzJUqIGcndKfwB1cp/UktQlUy5Jsn+Vdo0EdGTPjfIbyvgoSvVDyI
	KJPAP+1vpNP3MrdU30+np6c3hi5gJWqRcyu0xRlJgMoLwgENtYJI0R9nSq2WRrlE
	3WhRkqCeGqzd7mPVEdRh0OB6XFZp5kGA5XlZES0CpxgWWh3fKer3hg45PC6R124V
	EF+Zxw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg33r2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269af520712so43285905ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758526330; x=1759131130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufG3sJi0LeG+2kPC0a9al27kJCVNII9Yo0Sf2m3fcC8=;
        b=VIQ5l//DeLXqAoGNG3BdPqn5asN2by0Ge8sELoGSaKXR+a0g/cJNS2bllEoG6ReJtV
         +hailThKk4veWwA1TZYYhLEO+eaQy9x5IfllriEZVjK3UonY6y1ixu5hfJxSXuTt6FpT
         aqZPOI3/ZT6b3x/DAivte352AwCiawI30rscTVx+vO3on30aw5iH6MkFd1BFG+mPAmTA
         fdG/Ab8X3RjRkObAV6wNRA/Q7el38Mn+gRZrpXHkWD8Ga0XL75qp3bhqULSMC/n43L9R
         MzV833ZgMzAsxr5HSYmPspfBmRMvJASFfZVKTPtpIPRl5hBtUM/COAy44f+EMKdQg+Y0
         3lkw==
X-Forwarded-Encrypted: i=1; AJvYcCXTGRYZXAdjdXqNmZICFlVqQlYhgVwwG+95f0xeDA4xYYhARqOx+hox2vsUIVEy+2wR/Sz5xwJhMO6izzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMh9W/Zk5Z98zIbA38MQ+iSbl+SyqwmgtMbvrdkev4kEFWW/5s
	vNmlzj88eqEfsqICXhYZZAaJMd3byp+tOQhjdvHcsMij6d/yB23YXWshoL6RDzTGjW6RP63ZsdM
	u4fcOos5tWe0HgV9r+B1yZ2EYPweHv+9JPaemxBPyLl1SqgKzymADqnpMXlRsIBZDl6I=
X-Gm-Gg: ASbGncvMBHlglZqpSIIKFcO25Yi2mVOq2Y7ORL50Lk+0IOJa5cEhtd8DalOAhlj8mMW
	4IB1GU+E1kMzdwsGBFTATkyMRTvpE7tmPT1+rLTolDrZx8+jxdNmXhyzBDIej0bQHkSh7wdZx4o
	L/vsDzyNYxsN2FqUy6x/H0A1vDACnMHP6v9ow+x91lL+FqGJGk3t/ySp1fy95JPJaddaApeS6Pr
	jexAinC8E7jtYbt/LfwdtTeKr6RLNMv7S9slcK7mVRTOoE/3HHs3rwbKvxwOSstPfqpqmYfdCjs
	5920iuHQPc+hWbfVRabaU6PneOBoFnjufEBzCDq4ZYR8do6ukXvhIrD1nVZRBR74cu9f6rg5Ykk
	Mpzpx7LRSNflGVmSEfy7ZUcbN/fY=
X-Received: by 2002:a17:903:40c5:b0:269:96db:939 with SMTP id d9443c01a7336-269ba5628e6mr143483855ad.58.1758526329874;
        Mon, 22 Sep 2025 00:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Vp6gvYIR1bXT5jSRLeA0Dq+/XmIuZlyLKdJBmXmf3ry7gid2Ea6v/MpWbW0ZGZhIjTy0jw==
X-Received: by 2002:a17:903:40c5:b0:269:96db:939 with SMTP id d9443c01a7336-269ba5628e6mr143483585ad.58.1758526329364;
        Mon, 22 Sep 2025 00:32:09 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800529cdsm123806865ad.22.2025.09.22.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:32:09 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 15:31:40 +0800
Subject: [PATCH RFC 2/3] coresight: change helper_ops to accept
 coresight_path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-fix_helper_data-v1-2-905e8115a24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758526319; l=9918;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=QEBlXI+s6Pg9S40qJyLflLft2wUwobd5Tsvp12e09dc=;
 b=9NtI1pfDUEbYlQdKKADnRMqgOTdWi9zQ4N7QotfDx+WNujMbQNXirNSlwc3H1Mp0+vyG7Wy3v
 vgZg2zNM47kCzuIl/l8+qeCXInuxQ+ksbRFx6UE3t+X8YxzA3XfmwkE
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX70jYdzJOu+iT
 gEPGoqmvrumBPtst6u0IJbuRsnqGbI08J6w43AoafDgkOPavg+kfAqL4qDwG2kKmI7myjAD3cFa
 h/GmrHkJHbgp++6IHok7KCkGQEVC0MKtrJH7Hw3Qti0f23lX3yzBdbBm3dQo/sn2nreO25Qr1qs
 SVyuX9h13oqU7ubH9p7sFZSzEwaF59z9bGte2ZiofFh8FpD66nJOU54qsI5vAreqwCtPVtFRjF0
 LFYJnttFGNedI3smE1Zr3PM2F9z1x0E6HAerUvGPN+KQsTqDbtnSrtFxF+JqFMm+6FqBiApC8oI
 2dtZWBuQ534a8xUTBuhiDtbMyW7SV5UlfqS0P0DZnZzb8JEtYsiI8nu/62LumS4O0LQl+QVr5Yl
 v9fin141
X-Proofpoint-GUID: DVQ-mMl7V3n7YtsQNXhpeqLWq2Jruh1K
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68d0fb7a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Gv9EIBWDmE4dLvOUe8gA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: DVQ-mMl7V3n7YtsQNXhpeqLWq2Jruh1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

Update the helper_enable and helper_disable functions to accept
coresight_path instead of a generic void *data, as coresight_path
encapsulates all the necessary data required by devices along the path.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c      | 10 +++++-----
 drivers/hwtracing/coresight/coresight-core.c      | 20 ++++++++++++--------
 drivers/hwtracing/coresight/coresight-ctcu-core.c |  9 +++------
 drivers/hwtracing/coresight/coresight-cti-core.c  |  5 +++--
 drivers/hwtracing/coresight/coresight-cti.h       |  5 +++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-tmc.h       |  3 ++-
 include/linux/coresight.h                         |  5 +++--
 8 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index a3ccb7034ae1..69b36bae97ab 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -397,7 +397,7 @@ static int catu_wait_for_ready(struct catu_drvdata *drvdata)
 }
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
-			  void *data)
+			  struct coresight_path *path)
 {
 	int rc;
 	u32 control, mode;
@@ -425,7 +425,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 	etrdev = coresight_find_input_type(
 		csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
 	if (etrdev) {
-		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
+		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, path);
 		if (IS_ERR(etr_buf))
 			return PTR_ERR(etr_buf);
 	}
@@ -455,7 +455,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 }
 
 static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
-		       void *data)
+		       struct coresight_path *path)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
@@ -463,7 +463,7 @@ static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
 	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
 	if (csdev->refcnt == 0) {
 		CS_UNLOCK(catu_drvdata->base);
-		rc = catu_enable_hw(catu_drvdata, mode, data);
+		rc = catu_enable_hw(catu_drvdata, mode, path);
 		CS_LOCK(catu_drvdata->base);
 	}
 	if (!rc)
@@ -488,7 +488,7 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	return rc;
 }
 
-static int catu_disable(struct coresight_device *csdev, void *__unused)
+static int catu_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3267192f0c1c..f44ec9e5b692 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -355,17 +355,20 @@ static bool coresight_is_helper(struct coresight_device *csdev)
 }
 
 static int coresight_enable_helper(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct coresight_path *path)
 {
-	return helper_ops(csdev)->enable(csdev, mode, data);
+	return helper_ops(csdev)->enable(csdev, mode, path);
 }
 
-static void coresight_disable_helper(struct coresight_device *csdev, void *data)
+static void coresight_disable_helper(struct coresight_device *csdev,
+				     struct coresight_path *path)
 {
-	helper_ops(csdev)->disable(csdev, data);
+	helper_ops(csdev)->disable(csdev, path);
 }
 
-static void coresight_disable_helpers(struct coresight_device *csdev, void *data)
+static void coresight_disable_helpers(struct coresight_device *csdev,
+				      struct coresight_path *path)
 {
 	int i;
 	struct coresight_device *helper;
@@ -373,7 +376,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev, void *data
 	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
 		helper = csdev->pdata->out_conns[i]->dest_dev;
 		if (helper && coresight_is_helper(helper))
-			coresight_disable_helper(helper, data);
+			coresight_disable_helper(helper, path);
 	}
 }
 
@@ -479,7 +482,8 @@ void coresight_disable_path(struct coresight_path *path)
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 static int coresight_enable_helpers(struct coresight_device *csdev,
-				    enum cs_mode mode, void *data)
+				    enum cs_mode mode,
+				    struct coresight_path *path)
 {
 	int i, ret = 0;
 	struct coresight_device *helper;
@@ -489,7 +493,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 		if (!helper || !coresight_is_helper(helper))
 			continue;
 
-		ret = coresight_enable_helper(helper, mode, data);
+		ret = coresight_enable_helper(helper, mode, path);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c586495e9a08..abed15eb72b4 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -156,17 +156,14 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
 	return __ctcu_set_etr_traceid(csdev, traceid, port_num, enable);
 }
 
-static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       struct coresight_path *path)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, true);
 }
 
-static int ctcu_disable(struct coresight_device *csdev, void *data)
+static int ctcu_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, false);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 8fb30dd73fd2..bfbc365bb2ef 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -799,14 +799,15 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
 }
 
 /** cti ect operations **/
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
 	return cti_enable_hw(drvdata);
 }
 
-int cti_disable(struct coresight_device *csdev, void *data)
+int cti_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index 8362a47c939c..4f89091ee93f 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -216,8 +216,9 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
 			     const char *assoc_dev_name);
 struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
 					   int out_sigs);
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
-int cti_disable(struct coresight_device *csdev, void *data);
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path);
+int cti_disable(struct coresight_device *csdev, struct coresight_path *path);
 void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
 void cti_write_intack(struct device *dev, u32 ackval);
 void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1040f73f0537..b9bdbc745433 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1325,9 +1325,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 }
 
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct coresight_path *path)
 {
-	struct coresight_path *path = data;
 	struct perf_output_handle *handle = path->handle;
 	struct etr_perf_buffer *etr_perf;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cbb4ba439158..95473d131032 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -442,7 +442,8 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data);
+				   enum cs_mode mode,
+				   struct coresight_path *path);
 extern const struct attribute_group coresight_etr_group;
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4591121ae1d4..a54241ae9aa1 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -424,8 +424,9 @@ struct coresight_ops_source {
  */
 struct coresight_ops_helper {
 	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data);
-	int (*disable)(struct coresight_device *csdev, void *data);
+		      struct coresight_path *path);
+	int (*disable)(struct coresight_device *csdev,
+		       struct coresight_path *path);
 };
 
 

-- 
2.34.1


