Return-Path: <linux-kernel+bounces-804957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F1B4825E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD89189BB31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECE1F873B;
	Mon,  8 Sep 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAbt/Bc2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035F1E990E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296959; cv=none; b=f1t1u7YIFQ2p/C1rewe0863wuAREvig8ZI4+O9/xiiIiD0E4jvfmuWX3V2WMR3udtebVXz84NvdFzk7uajXndbQbP5bHwmAuD2q3ghUq1g7Lid7Bf9lYCYPgFZlcFlec4kmbLE8JspEtJlSqgHP6TfdHtSC14uyQWV/ci058U3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296959; c=relaxed/simple;
	bh=QFpFMOUZf/2SBDLxhrsEj1Eto2xysYNZ7RxKlu5EyYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEFP0LcKPDPhTQ4++Snewae/ycOc7Zp7RUOW1mUbqbOwYI6NJt6tDANOoeZI05BggnIzul6MnlcCoU/vxp+0NsGrxWcdeaboo5zX6qbIP7P4lTji094TUXwBuS6b2QrkqQiMaGt8W9WZNpv3jvwL/f/jknr41ye882e6eJxD1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAbt/Bc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587M03MB030096
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mmrEmFTMxg84eXRvylgPXjTGj2u1nEfxmypzMMZc/rM=; b=SAbt/Bc2JoIaPY45
	59j0UsyvnCnYOylZEbH2gVACRNpOPn+Tj0yk8AuBs9qpG/tgFtNpjQhTFvIdte2b
	OFuME9rCEkfqQp3bRQiR1cpy/4Rw5I4bee29vRnMm11R7YdwBceeR2DQ6aKm/n78
	BJWDW/XS72Gz1xG7ofwGyT4sj3FceVqPV8Bao0F7SOyCK+lbY5r0HJjJ2hL7Fox7
	Y7GylWa2V+3O7W9kvxUrAmOORulAB3EBskwYknoB07jfE4CJA/Hy0c2UwDIVGfnB
	2/zXAUGasCYRnEoZfyTp4A9H/6MiruSYRKNWTYKVS94ZKkreuoOJuKy9WSvwNoLq
	1oz67A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4ktu5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7725b4273acso8322243b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296956; x=1757901756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmrEmFTMxg84eXRvylgPXjTGj2u1nEfxmypzMMZc/rM=;
        b=SaDm4oT6qPxUTJv04asHK9Ya+5PYZCWK8OT+rhIHE+x60VeckLPYWZpCeK5BuVeWEv
         gOaWZuagsLjrcy1pbr2y4Ba+fWADUQ0QBPu1AWil+VsqxNVNyJBtiwGjmnYPQqDvF/Du
         U6AxuhLPDqAuM+GGldlJMSok0Y9mOtUEqpGmGckIFVcFuTo2NxKba/sTpxmpYQO7Bggg
         hGlFzIpXW52kOYeVQdlSVuw6rh+TNi29AfbyosgYJufXX0vk3qdrQe+jovzqm6+7DK3R
         MIYEjylJojP0/8hKfmItay+izzBvwDoEEFUh/DgnLLbxzuQPWi9zD2bkReEU0t5fb5tQ
         DnLw==
X-Forwarded-Encrypted: i=1; AJvYcCW7B94of3YAps8ypsV9RsJrjpEImfkdLkb/5Wm1Se4r2LZf+dw5MFX8FSOn/mNFcnNpR21d8Bv0KS6+lC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRlPIXKbKPkxC+jKqr28yjtshJZP3K+1d87VbKFZM7T18opaV
	LThZEqhWHpsJgKN7yPo2/50/2r8Ive9qOJnVMI0g6vX+0RfjBVomxJGa+wqPA9YkVEuFjAIrvk/
	Didfu7JRhGX7ZLRfbLAndFB81htxdTAVvD1Cy2tL6EQttnMRvQjtToi2wVRAw+RtqjVY=
X-Gm-Gg: ASbGncvbG5qEedMy7LQikSRkMutErJAFHcs7aPeszh6Z0tnJaB9d1z7/fFpFtxpeaZP
	saqNHVWo53Z80QW/hM93xsMPSt/w3e/IUvhEuflvLPgpDzieXQ3yJ/WL2HUXsCK/ySIVq3aRqlT
	w1XrCE7qoci7Grt26d0dYPeVZETVa1O5YiMnlyoVcfLYgsI4Ya49UNa8E/kvVceqqlRDqKWFjFo
	VY9zswHwtPoHmFynQGZNKVN/g8nU5jQAv0wnfSZqKaJNfV7BWLgTTU+k0F/NeWZZsjbfYul8gmQ
	jS1bgFT9ANazhRGKNCfJ5nGH6MK0UcymY/J4S+bh0vPSoa32PWxw0IwmEOJ/i8HicbDouaBXbvk
	96QB43FhDyi0OcmBdY9KSQmQNmJY=
X-Received: by 2002:a05:6a20:939e:b0:243:78a:82a7 with SMTP id adf61e73a8af0-25345579b43mr7587412637.47.1757296956470;
        Sun, 07 Sep 2025 19:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpz91qpajdyoSqIcc47npMEE1FkO9LwTqg9ZWKouQV8RyNp0nC1V+LGbeoE3r4URiIgPkNgw==
X-Received: by 2002:a05:6a20:939e:b0:243:78a:82a7 with SMTP id adf61e73a8af0-25345579b43mr7587375637.47.1757296955935;
        Sun, 07 Sep 2025 19:02:35 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:35 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:54 +0800
Subject: [PATCH v6 2/9] coresight: core: add a new API to retrieve the
 helper device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-2-1db9e621441a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=2649;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=QFpFMOUZf/2SBDLxhrsEj1Eto2xysYNZ7RxKlu5EyYo=;
 b=bi+tUi3A8/0GEEoeIWtWZ7na0uNDvTr9BROFOck5sTnvMXnTbiYnJxMCb3pPyOarEUn1dR8Kj
 rl4N7CvjIGgDyH59hczXqMiQtklb4wJquhOR2XH0lTt3flB7xAbZl2K
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX2PxM+kQGrYCn
 2dVz9c3q0ezsrReNc+KTygBm2m9NVXlybeelJzNSkI1gV+aKgBMTxsGNjGBHp6N+7PFfa0WIz53
 bxqal5KuwI4z78fgky3NgVJETkhFAvTsFglE8JhHUajNZtbrCgkAXk0pN21iGsxPpvjMSCl01bI
 HSYMRQvb3h8fRVNcO9z+AkcW/lM2p6XJ6oawsfLn5Z7lysv7jBV7ajldDtjijRXCr4iyfWZ9lup
 TotfmjFtiL/vJNbUeSx9+PolzfLHMtvVmrIMApj5FqdjPetJ6xDv2D4S7dM/SY9OBSKlNMelKEX
 P7DjpCI9V9lgkrrcKumupA61Pyi+G6yeB+VP84uUfjMR+RqX1DDei0zuk08sxBjmEFTZzbyLxub
 2HSUSFpp
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68be393d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=WErVAGsNQcrMbPXGsVkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gxUh42NzcMT7ZC4ni6yV1-x0_Yac098n
X-Proofpoint-ORIG-GUID: gxUh42NzcMT7ZC4ni6yV1-x0_Yac098n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

Retrieving the helper device of the specific coresight device based on
its helper_subtype because a single coresight device may has multiple types
of the helper devices.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 35 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 042c4fa39e55..018b1119c48a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -580,6 +580,41 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
 }
 EXPORT_SYMBOL_GPL(coresight_get_sink);
 
+/**
+ * coresight_get_helper: find the helper device of the assigned csdev.
+ *
+ * @csdev: The csdev the helper device is conntected to.
+ * @type:  helper_subtype of the expected helper device.
+ *
+ * Retrieve the helper device for the specific csdev based on its
+ * helper_subtype.
+ *
+ * Return: the helper's csdev upon success or NULL for fail.
+ */
+struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
+					      int type)
+{
+	int i;
+	struct coresight_device *helper;
+
+	/* protect the connections */
+	mutex_lock(&coresight_mutex);
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i]->dest_dev;
+		if (!helper || !coresight_is_helper(helper))
+			continue;
+
+		if (helper->subtype.helper_subtype == type) {
+			mutex_unlock(&coresight_mutex);
+			return helper;
+		}
+	}
+	mutex_unlock(&coresight_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_helper);
+
 /**
  * coresight_get_in_port_dest: get the in-port number of the dest device
  * that is connected to the src device.
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index e51b22b8ebde..f80122827934 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -158,6 +158,8 @@ void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
 int coresight_get_in_port_dest(struct coresight_device *src,
 			       struct coresight_device *dest);
+struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
+					      int type);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 int etm_readl_cp14(u32 off, unsigned int *val);

-- 
2.34.1


