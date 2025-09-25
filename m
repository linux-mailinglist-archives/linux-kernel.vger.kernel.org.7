Return-Path: <linux-kernel+bounces-832274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40BDB9ECAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65BC169364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD52FD1C1;
	Thu, 25 Sep 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrgXwlh/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2F2FBE1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796985; cv=none; b=d7LaGL8k41Ktalzg4LlE1QhCyHJoMjgbQB/Ur6bWZJ2rfn3z0nj50ND7CVcoFE6KxM1/g9KIJIz9VNi+PRQlONZc+eDn3q0fLHJnEViCcTW5500RPFt/QXphTM8CdDLAmpatokBT3e3E9C0X/DOTeOAl7WgHJ3VMaLZ6GoJTIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796985; c=relaxed/simple;
	bh=SuUkpE58+WLzMO0NG55e+BFB60hihzNAcDbxPmKE41g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk+C2kVuAZ8t+53/QS94JGELgNL8bT3jmBQThkX0p0kuE/EjrbWryN9mxR/uLWeFCF+d6M/tNnxJ6IqFmBOHSYq0Kqugo18cW8DJwi7MAqyWRMNXorrMCaHCteHqZy+IUxgNrc3NOM7Xf+Rn5Aa74HMGM70RBn5kvberoqq2U14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrgXwlh/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9SNMv018026
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLPlknKStxzHQLun70iF8lyrWcWViBSqIF9JNqs4Tf0=; b=VrgXwlh/JfBDkp/2
	it34a+B9Ip8eh034LmHAf4uYduz9tVZ0N82wLsjvmCaTvVpVu/jJ5qa348sBW1b4
	SZzoC8nm2M7Cjy4QVaPlMQT3Bo4ka0IGixumgcHY6Nu2BS8UMy3Bx0QISqVZSRVf
	cLwLS1OC1maUDHI+UqiKNBRIgFWxV6SzjAJB/VueNSRvwm2SZkkzCkqsBMXvAvjG
	s2f9o9TnYGR7Dsj9C5whunSiWyHXR1Sa8ZVCkAeTYikpdCD+ZNFgl3LWlPrcn/VE
	0OUIZ/UYRWpTLqowpPh4F9uha+xFo8u3IHRxlWcW5uGybW5flPtcAAVv64RsbliZ
	i9kb0w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbrec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2681623f927so8814075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796981; x=1759401781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLPlknKStxzHQLun70iF8lyrWcWViBSqIF9JNqs4Tf0=;
        b=q+hvCOjzmip9njXANpG2ryfHIKSklNcJQTEKGr1diSLH/C+FVP7hXnZU++pbd3L649
         jWj09k8e8wWfw30TfbQ5rnkt1RHnbkjfR0zmZN+444ov4sueNuhoCRyBDbpPIVyDOvXF
         Sqdo3GxAH1KDUBDhaEeJ1Kw7plyrTymjh6cdzn75FRWRPVSKQNK+6Jl3+gQF9jR1FceM
         9hS2XaJPgBk5wFaRTMNgvN34QiVOfhTbYupnhZoQyIppTfTwf0OT7a20Dx4JfmNy48qk
         djnp19fbqFcLoqEr03ru+EfDx0sxTtNGI3xFVDk/sAX+L/jHFqcpwmmauAONS1AV30p4
         yUMA==
X-Forwarded-Encrypted: i=1; AJvYcCXMHWjuNhpPA97mI5RZhWnKu/n4v3XrTuJzOaRUHduUOEzMbdf7AluzwM7RPIR1w/3RSrfpuXtu4k1LZg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TbqYaajxswBhlrwqe3d6giEZuk1DBVlAGElpQPKVesRR+qrB
	Spuj8NGQ+MHabhsNEUfqwATEAMQJPrC0FgyF8RdcClHEopHsLk/v3NJVomwMr7ELtTDVPJqZ3bH
	7Bc6NpMmkN6Kghl8kiyvE7T+luQlKVgOqOBSCZgnYSqlMAVJPH5+aD3IthlFxp7KEhumZdrjrrq
	M=
X-Gm-Gg: ASbGnctdkSLX3pIamsxhusxIOIL3j3wh+blLN1Zf6zM/mLI+qvCWUdOKdxruFZnpn3d
	KrPYaz6EOPuP/UkIRRmAlIxOj0hL9getoKQDDmTiy/pV8T7KqEhMH380S9P0u+enS3dd9oWT+Y1
	bo7w/pLPh0v4bedDlKtn6B3afGngT2qMvoZyz2RyHd09ygMCZsBKwS6kt2zJKn9pejKKnAoFJNB
	EKDsPO70YQlQQwn8yzemmZGM9sQXRNn3ALEw/ntq4AbZmLofNH5AqtQ3AG8QqJfFRmkLufdicD9
	Z+1SmxujyKgAA5a06TRPc8QoB30AAVa9HBSlajIyIKx7etTRK50O4aSTpz/eNgPoOMzJxHbF0I1
	3vmhX0OCr6qvCrZ8MF5DmCfoFlCA=
X-Received: by 2002:a17:902:ced2:b0:271:ac7a:8f18 with SMTP id d9443c01a7336-27ed4a9615cmr40835565ad.43.1758796980998;
        Thu, 25 Sep 2025 03:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2SgLtjVZ5SV9a7Yca+ZIPmrp9cTi9AptrSWj/eCKVG3S2KJNj7dnuoNLHU1UfwZNdJgZ63w==
X-Received: by 2002:a17:902:ced2:b0:271:ac7a:8f18 with SMTP id d9443c01a7336-27ed4a9615cmr40835215ad.43.1758796980408;
        Thu, 25 Sep 2025 03:43:00 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6727ea7sm21046845ad.61.2025.09.25.03.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:43:00 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 18:42:33 +0800
Subject: [PATCH v2 3/3] coresight: change the sink_ops to accept
 coresight_path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-fix_helper_data-v2-3-edd8a07c1646@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758796966; l=12751;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=SuUkpE58+WLzMO0NG55e+BFB60hihzNAcDbxPmKE41g=;
 b=gZFCNV/GB6vRv0QcjvrX0LfchqGF+8eMa33QBgjZ8jdi3pG6yUCouR1a9fHQYyh0vhFghQJ2C
 7+eDYTCMWcQCl6IowOT8eevpSCTQ/xowDlly2YC/8WFTWwsl00BP8jQ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: wz-yhrhdMxXW5Bfo_5UElj6m3_UiwpWL
X-Proofpoint-ORIG-GUID: wz-yhrhdMxXW5Bfo_5UElj6m3_UiwpWL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX7H79moCAumdv
 Ljt86JxqUlELqOX94+0ia+2eqpPY7OrwbgAABNNgcYyICN22VAUHIpoVIU+1TO71IZrdktod9HC
 wfrCidwhE5CP1+uhMN+cxyyjO3bPF6v0YIuXZO5yCr6+2WSFnfDshmHRIWL4VeNg09hwwFYKBbN
 VzPs4rCJh5IpxjePkBoa4A2/LXFzpBKLpZj1Pvx7muUeyOczV+j+XDZiphsiB18DbvCj1Pa9oga
 gJCH4P/tOHXMuNYizQ/mhNG0L1BpuWG+BgpM6YPndlgzplhoOGaRa/mqNdjL0Tg6h/txUsE88qv
 jwd4PX4pHHxCKguRe3Vswhalc/bSXd++l9n7NiQDbi0p8vkklF+lSOTSkM+MRpJxX1iRtgfsD4Z
 7ouPfDzb
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d51cb6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=t4OZSbUdKNgAmLiGTPYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

Update the sink_enable functions to accept coresight_path instead of
a generic void *data, as coresight_path encapsulates all the necessary
data required by devices along the path.

Tested-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c     | 10 +++++-----
 drivers/hwtracing/coresight/coresight-dummy.c    |  2 +-
 drivers/hwtracing/coresight/coresight-etb10.c    |  8 ++++----
 drivers/hwtracing/coresight/coresight-etm-perf.c |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h     |  3 +--
 drivers/hwtracing/coresight/coresight-sysfs.c    |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 10 ++++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 10 ++++++----
 drivers/hwtracing/coresight/coresight-tpiu.c     |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c     |  4 ++--
 drivers/hwtracing/coresight/ultrasoc-smb.c       |  9 +++++----
 include/linux/coresight.h                        |  2 +-
 12 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f44ec9e5b692..c660cf8adb1c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -300,9 +300,10 @@ void coresight_add_helper(struct coresight_device *csdev,
 EXPORT_SYMBOL_GPL(coresight_add_helper);
 
 static int coresight_enable_sink(struct coresight_device *csdev,
-				 enum cs_mode mode, void *data)
+				 enum cs_mode mode,
+				 struct coresight_path *path)
 {
-	return sink_ops(csdev)->enable(csdev, mode, data);
+	return sink_ops(csdev)->enable(csdev, mode, path);
 }
 
 static void coresight_disable_sink(struct coresight_device *csdev)
@@ -501,8 +502,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 	return 0;
 }
 
-int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
-			  void *sink_data)
+int coresight_enable_path(struct coresight_path *path, enum cs_mode mode)
 {
 	int ret = 0;
 	u32 type;
@@ -532,7 +532,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
 
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-			ret = coresight_enable_sink(csdev, mode, sink_data);
+			ret = coresight_enable_sink(csdev, mode, path);
 			/*
 			 * Sink is the first component turned on. If we
 			 * failed to enable the sink, there are no components
diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
index aaa92b5081e3..14322c99e29d 100644
--- a/drivers/hwtracing/coresight/coresight-dummy.c
+++ b/drivers/hwtracing/coresight/coresight-dummy.c
@@ -52,7 +52,7 @@ static int dummy_source_trace_id(struct coresight_device *csdev, __maybe_unused
 }
 
 static int dummy_sink_enable(struct coresight_device *csdev, enum cs_mode mode,
-				void *data)
+			     struct coresight_path *path)
 {
 	dev_dbg(csdev->dev.parent, "Dummy sink enabled\n");
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 35db1b6093d1..6657602d8f2e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -167,13 +167,13 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int etb_enable_perf(struct coresight_device *csdev, void *data)
+static int etb_enable_perf(struct coresight_device *csdev, struct coresight_path *path)
 {
 	int ret = 0;
 	pid_t pid;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct perf_output_handle *handle = data;
+	struct perf_output_handle *handle = path->handle;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -224,7 +224,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 }
 
 static int etb_enable(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data)
+		      struct coresight_path *path)
 {
 	int ret;
 
@@ -233,7 +233,7 @@ static int etb_enable(struct coresight_device *csdev, enum cs_mode mode,
 		ret = etb_enable_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = etb_enable_perf(csdev, data);
+		ret = etb_enable_perf(csdev, path);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 5c256af6e54a..17afa0f4cdee 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -527,7 +527,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 		goto fail_end_stop;
 
 	/* Nothing will happen without a path */
-	if (coresight_enable_path(path, CS_MODE_PERF, handle))
+	if (coresight_enable_path(path, CS_MODE_PERF))
 		goto fail_end_stop;
 
 	/* Finally enable the tracer */
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..fd896ac07942 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -135,8 +135,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
 }
 
 void coresight_disable_path(struct coresight_path *path);
-int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
-			  void *sink_data);
+int coresight_enable_path(struct coresight_path *path, enum cs_mode mode);
 struct coresight_device *coresight_get_sink(struct coresight_path *path);
 struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct coresight_device *
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 5e52324aa9ac..d2a6ed8bcc74 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -215,7 +215,7 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
 	if (!IS_VALID_CS_TRACE_ID(path->trace_id))
 		goto err_path;
 
-	ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
+	ret = coresight_enable_path(path, CS_MODE_SYSFS);
 	if (ret)
 		goto err_path;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0f45ab5e5249..8882b1c4cdc0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -246,13 +246,14 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	return ret;
 }
 
-static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
+static int tmc_enable_etf_sink_perf(struct coresight_device *csdev,
+				    struct coresight_path *path)
 {
 	int ret = 0;
 	pid_t pid;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct perf_output_handle *handle = data;
+	struct perf_output_handle *handle = path->handle;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -304,7 +305,8 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 }
 
 static int tmc_enable_etf_sink(struct coresight_device *csdev,
-			       enum cs_mode mode, void *data)
+			       enum cs_mode mode,
+			       struct coresight_path *path)
 {
 	int ret;
 
@@ -313,7 +315,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
 		ret = tmc_enable_etf_sink_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = tmc_enable_etf_sink_perf(csdev, data);
+		ret = tmc_enable_etf_sink_perf(csdev, path);
 		break;
 	/* We shouldn't be here */
 	default:
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b9bdbc745433..bf08f6117a7f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1726,13 +1726,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	return size;
 }
 
-static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
+static int tmc_enable_etr_sink_perf(struct coresight_device *csdev,
+				    struct coresight_path *path)
 {
 	int rc = 0;
 	pid_t pid;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct perf_output_handle *handle = data;
+	struct perf_output_handle *handle = path->handle;
 	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
 
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -1780,13 +1781,14 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev,
-			       enum cs_mode mode, void *data)
+			       enum cs_mode mode,
+			       struct coresight_path *path)
 {
 	switch (mode) {
 	case CS_MODE_SYSFS:
 		return tmc_enable_etr_sink_sysfs(csdev);
 	case CS_MODE_PERF:
-		return tmc_enable_etr_sink_perf(csdev, data);
+		return tmc_enable_etr_sink_perf(csdev, path);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 9463afdbda8a..aaa44bc521c3 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -75,7 +75,7 @@ static void tpiu_enable_hw(struct csdev_access *csa)
 }
 
 static int tpiu_enable(struct coresight_device *csdev, enum cs_mode mode,
-		       void *__unused)
+		       struct coresight_path *path)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 43643d2c5bdd..293715b4ff0e 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1013,11 +1013,11 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
 }
 
 static int arm_trbe_enable(struct coresight_device *csdev, enum cs_mode mode,
-			   void *data)
+			   struct coresight_path *path)
 {
 	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
-	struct perf_output_handle *handle = data;
+	struct perf_output_handle *handle = path->handle;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 
 	WARN_ON(cpudata->cpu != smp_processor_id());
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 26cfc939e5bd..8f7922a5e534 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -213,10 +213,11 @@ static void smb_enable_sysfs(struct coresight_device *csdev)
 	coresight_set_mode(csdev, CS_MODE_SYSFS);
 }
 
-static int smb_enable_perf(struct coresight_device *csdev, void *data)
+static int smb_enable_perf(struct coresight_device *csdev,
+			   struct coresight_path *path)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct perf_output_handle *handle = data;
+	struct perf_output_handle *handle = path->handle;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 	pid_t pid;
 
@@ -240,7 +241,7 @@ static int smb_enable_perf(struct coresight_device *csdev, void *data)
 }
 
 static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data)
+		      struct coresight_path *path)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
@@ -261,7 +262,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 		smb_enable_sysfs(csdev);
 		break;
 	case CS_MODE_PERF:
-		ret = smb_enable_perf(csdev, data);
+		ret = smb_enable_perf(csdev, path);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2bee2e3bb1c6..56d0108658db 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -367,7 +367,7 @@ enum cs_mode {
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data);
+		      struct coresight_path *path);
 	int (*disable)(struct coresight_device *csdev);
 	void *(*alloc_buffer)(struct coresight_device *csdev,
 			      struct perf_event *event, void **pages,

-- 
2.34.1


