Return-Path: <linux-kernel+bounces-804955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D8B4825B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFB17A9090
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC81DF73C;
	Mon,  8 Sep 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HsBIkjfb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25321DE8B3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296956; cv=none; b=mrIRktNcPXKnjQn+Rav/1YSByp62sOhbQBH0dm12N+TWbwekSYGSdeXvUADcUYjah5Enq/AFsnNFGUs/FbcxSyxTs8CwNTwo1J9IHpBpui04msCSnBGuZrdLt2EqLtGDUCfFWgbicNpuwhvm3M0y6Jr1Q8L51AT/EYBJIrGfnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296956; c=relaxed/simple;
	bh=qzd5gVviJkuX4BcigfW/YZdkjwAG5WVRtPg9BE+cAXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/DOvPUlfz2i32N2jVVMTC6C0Jo8XFRUd5lS4pGS/iHG5yKdGxYXXQRSJdA6/DXzX82Krog1tvMAhHpVyl+Zg0cEckTxqRk+62YpKoyMusg1/2yw50De47CM9VSexMaPAYnAjKcfEO3xHPzDE8t5oP0Pt/feg8OG2CKQpJG4yAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HsBIkjfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LVuDQ006019
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fOGihsR+2JZnyd1bIX/cqtdxz8sWBUYderONs+SBjZg=; b=HsBIkjfba6BrFK9M
	f5PrcVXbEMYws3OZNAZ87xm3/12htmJF0CGZRkMWVLzvL7nzYxIpjOh/PQr6WnDQ
	QsMbsb135aTucZQs0E/+MxyaH2n12aksuZOOBlFv3SPRvGMusLOK39MLgUpcQ3Sz
	e5T386OWYWh1Yl70qr9lTXkcSOUaejPaFcpG9RS13wljN35uLA4IpZUUBLk8f23l
	Y3IU396HfTLLlAqKeUstybDF4jZcgV3/xQmm5opt2TmqX8YLPex3g2mTvS3T8zvv
	0xF9y3z3+6iqq3prb/Ne0yhlek2RR4b1iqePOjYXF2276a5OKRELxSK3Uwnwau8W
	W9M5tw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vaxse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24cc19f830fso83732495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296952; x=1757901752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOGihsR+2JZnyd1bIX/cqtdxz8sWBUYderONs+SBjZg=;
        b=J5I9fSUPfNLUb3pWKviwjIcE6E2W5yaOxAa8tdpTy3+i2z1mhaRlPjm36lvbSjAKJn
         b8Dp2o6wdvxiMXeT9zBPzeB9PcsnwRPTMj6Jdy4EqeRoAUHbslj0BAPcrLkNxj+o0Z/i
         iMjOkCOQozoFFQBcc5fixbFhGqJa9Hrx24rZPIQHc/AhGYMOABlbQCKXxb3ARWThpGSk
         fum06h1G1VTy/PhHQOY0EzFgh6sx/wms0fGzjzVvJ4YVXg4/anUjKIr5Hak5ztGLF5hS
         eV91bEgRBcVDXPWNGmKBDIWjWN8WtSpW9gujLFSMoS+RWOzFTWdsJuqYSc54wwYzbvZa
         qI0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzVMh91YtdiZTpQfdTtIGf+DyknwfO5oVyq+oDUuyhdqPAe0P4b6ivMvVS+cMUu52J133GX8s/w8BAwbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyf22okJtzvpvyFMpIqwyvO0KIoRQnZrUxP45vhFJ/zwq4pwDw
	yRNB8nWvVZ85DOnEKGFwysJSAXdFzAJdIWkWelcT4xkuLrI+BDucejeKmrDsnKr/qji0dx+lgS8
	FnBerQJreboKIMiZYbuie10JGwAWXb+2goI9ghxKtEtamrv2ryYeiuvQVDpzGh44IYDc=
X-Gm-Gg: ASbGnct0gK8YyQfuIWUdSFN5Tp4nnK0ET3WrGhMhXM5RuSP15g7ACvL7IptG5AKarzR
	lfD/ZB5kFBy4fRv9C/U3n8KwpgGCRpusJ4vBuvrPM2L558v22I+z+w/mfW5TQ/drl6MXTtsZSA+
	lI8AzvZXH2FnwCDaYNV0v063gtAZpm4VYbWQ+smtifuJEOBqIss0DAfpmUqjIjZp5Kx1sGx8hns
	/uUvtvLA2y66MC8ZI1W6jDKGxP4QfEINbYbj6EL+kSJT+Wbt8HJwPGtR2AUnCwOGkv6pjE2XTpP
	q0n2I0hd7UqMLbJOFnzxTZdzY4SC+fL12XE3cBqtrwtwv0eHoY0Wp/ko1VPqBIS+pZmeJt6Q9o3
	T9/IV70ddRc5DOF0MO41lhfE0NXU=
X-Received: by 2002:a17:902:f549:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-251728629c4mr80558985ad.42.1757296952426;
        Sun, 07 Sep 2025 19:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPMBDMwU4ZeTYAGNAbVmG2Eswoq+QPv2lxOCPjVREgO/b1eKZg4RlBnYo9ANXpCxNn+uZ6Q==
X-Received: by 2002:a17:902:f549:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-251728629c4mr80557685ad.42.1757296951163;
        Sun, 07 Sep 2025 19:02:31 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:30 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:53 +0800
Subject: [PATCH v6 1/9] coresight: core: Refactoring ctcu_get_active_port
 and make it generic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-1-1db9e621441a@oss.qualcomm.com>
References: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
In-Reply-To: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=3773;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=qzd5gVviJkuX4BcigfW/YZdkjwAG5WVRtPg9BE+cAXU=;
 b=D0xPJj+TDYxZODNsXVWs49Rwgvy06gQZ21co8dTaDv+o6EHqbig8HL8glyKgk99jan8igO+zi
 8TViphBaah7BKBeEaTX3CM8ekMKd1bM/McOqMljiaqCMiW5jrdeW3PM
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-ORIG-GUID: 2LrmWUx8wqX4B2B1X6lpUeaajjR-v1M3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfX8nU3yPBl/sB+
 sPDUUBAEnJySfplaqp3whMrIaPE9i7jKo8SjUjmyUFkGNYX5xtSRkPDoPYl/nsIztHN2ovPBP3C
 f1+WOGC1T/ja1hy82TW2Q+l/5A6zDh0ukMol9JP6PdqewkgKL5c2RlDKaixYxRlR8u4nfer0cZl
 kIQr2mUjsVh2iMziwBsCPpNXKicXgUW76HmYtxy2FwlQAuc5gl5fbudNOXZR7WwjPzJCqkCrE5B
 wFL7Zqga2pin2+mg6PQsgONMFslNkz9NaphGBEkgBnDOB58gTvMHXB7PqcSeG8/OajjDPKp7vG2
 BLUbvvWeqRHNLd2DjqvwT7xGgqqg+hlW6k+E2S7iP8LW5+UltkTmx15+Ci9HZ6TqHUGUM0CAtkf
 ezLDDerG
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be3939 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=qQZ2XtAyJf2dEkEvaVsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2LrmWUx8wqX4B2B1X6lpUeaajjR-v1M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

Remove ctcu_get_active_port from CTCU module and add it to the core
framework.

The port number is crucial for the CTCU device to identify which ETR
it serves. With the port number we can correctly get required parameters
of the CTCU device in TMC module.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c      | 24 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-ctcu-core.c | 19 +-----------------
 drivers/hwtracing/coresight/coresight-priv.h      |  2 ++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1accd7cbd54b..042c4fa39e55 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -580,6 +580,30 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
 }
 EXPORT_SYMBOL_GPL(coresight_get_sink);
 
+/**
+ * coresight_get_in_port_dest: get the in-port number of the dest device
+ * that is connected to the src device.
+ *
+ * @src: csdev of the source device.
+ * @dest: csdev of the destination device.
+ *
+ * Return: port number upon success or -EINVAL for fail.
+ */
+int coresight_get_in_port_dest(struct coresight_device *src,
+			       struct coresight_device *dest)
+{
+	struct coresight_platform_data *pdata = dest->pdata;
+	int i;
+
+	for (i = 0; i < pdata->nr_inconns; ++i) {
+		if (pdata->in_conns[i]->src_dev == src)
+			return pdata->in_conns[i]->dest_port;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_in_port_dest);
+
 u32 coresight_get_sink_id(struct coresight_device *csdev)
 {
 	if (!csdev->ea)
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c6bafc96db96..3bdedf041390 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -118,23 +118,6 @@ static int __ctcu_set_etr_traceid(struct coresight_device *csdev, u8 traceid, in
 	return 0;
 }
 
-/*
- * Searching the sink device from helper's view in case there are multiple helper devices
- * connected to the sink device.
- */
-static int ctcu_get_active_port(struct coresight_device *sink, struct coresight_device *helper)
-{
-	struct coresight_platform_data *pdata = helper->pdata;
-	int i;
-
-	for (i = 0; i < pdata->nr_inconns; ++i) {
-		if (pdata->in_conns[i]->src_dev == sink)
-			return pdata->in_conns[i]->dest_port;
-	}
-
-	return -EINVAL;
-}
-
 static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight_path *path,
 				bool enable)
 {
@@ -147,7 +130,7 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
 		return -EINVAL;
 	}
 
-	port_num = ctcu_get_active_port(sink, csdev);
+	port_num = coresight_get_in_port_dest(sink, csdev);
 	if (port_num < 0)
 		return -EINVAL;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 33e22b1ba043..e51b22b8ebde 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -156,6 +156,8 @@ void coresight_remove_links(struct coresight_device *orig,
 u32 coresight_get_sink_id(struct coresight_device *csdev);
 void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
+int coresight_get_in_port_dest(struct coresight_device *src,
+			       struct coresight_device *dest);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 int etm_readl_cp14(u32 off, unsigned int *val);

-- 
2.34.1


