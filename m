Return-Path: <linux-kernel+bounces-745573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AAFB11BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D5D4E64E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EB2DCF50;
	Fri, 25 Jul 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNJKMEb3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CA2DBF7C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438102; cv=none; b=BUlhh0qOhiFoSTomiIM54uF5XRMa3s30owHaKRo/5McN3Lf2QlPjh5oP2n+whBMa9N5Dd1TBduT2NYGNBTXKMQ1dZcvcfWV/kwN0rqG/RcrzsfYqNaVmOmfBchYPpmqok5cKFs2b56PSD6Qi2xampe3smSbxvWwkghzwqcrRDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438102; c=relaxed/simple;
	bh=yn1QIuKySDexmchd65JrgRCHP2kQE2kNc+u+Py2NP8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ec4GqJxWBxfB2/zDQZKoQCvj3nlsG2Vh43QiryFe9jr7IWcXSQkCMIgby+r9lk40653TGSvB/IrnxYKlx7i/z14NJOwXMy6wJ4YFYxwVn67Lj/E7rNBwiJg03K7n4K5GaLmguX2ty6wHZU8FAjMxT3oM3y6X1TGwaM05NoRNUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YNJKMEb3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9EKUx001090
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JQSm3zvoXYx
	xsOZ9zUxxblStkpQCRCtAS9aiINsQKeM=; b=YNJKMEb34iL64fQ1J0XRQRZP3lV
	P+cuxrHw8wkky7k2ghef9lrh5qd2HR6RqzvhEsoCodZQxM+6iORpReT3gl3LHPWx
	KXDbulYZQBLP+EHrQh88u9g4NznCKjN/2jTT/mtdQ6Lsg0NNh4cyHUjbDTUFlp6+
	p/hK2mDfRjgGmEO39xc6CU+YQBYP5YdL+FuN8WGosBK/F0KePv/+1fAyMhsMI3BP
	uMUYW0SMOheZ0CQNTpvzyfNLKzHNGMAw2v8AOtYcCUMfsQKL9nqBhfyRhOhB//XR
	qg2+vo5+yH4z0yQv0MsaZFD89NvTjG+LVXbm4TWPXCuYLh5kEXleLoZhJmA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xhmgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2363bb41664so18136375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438098; x=1754042898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQSm3zvoXYxxsOZ9zUxxblStkpQCRCtAS9aiINsQKeM=;
        b=qG8XsvHSqqILDDwewx3xZT8q9fpBNQmIMpejmpcfP6I0RF44kL8AbGINR8jzxPMuef
         MvmR4Mz1DKeDo4/jNS+GP9toVG+v13/ATGprjimZVLAjaIVPcusPAHCc+iYQSHMBWcAc
         ZbeWbfqq4oNYNkhb+m45Rzu6XmuPyv6MTW5bXMHulrdJ6TQONoCtNpQTaZcP012/ZX8E
         DK1HfpNpOBEc549hO6rLna70uQ27HyeC0HkRFbZ9zXVU0Re3MynAyDOQNhHc6Hb5Gs5s
         WWpQqPF6JF4UZat18oQ7Owf3aUda6TRPaYTuC84Esy0rvF04dYZxoV/2tzbPKnRl4xfi
         ZUcA==
X-Forwarded-Encrypted: i=1; AJvYcCWzIvbaJuaKgsR3w6ADo/COd6vbrYeQprPlbhIYqctcRdNwc0KOIf6FTOTao3o/GZowbddKe7TUiniAuvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPc/wy1dGjNttHxR1WXRQZpcBw7B63eZ1fyfv1lbggRkQNtKX
	fH3T20elVtJUEhLFIcHd4B1RInxCQ0Kuw9ahfvgh2PiQRcBlB4ZQ3eq8FpC8QYDajXd/SHEm6lt
	ZSi34InQhtMlyutWxFRUU+g4k8lhDwFqOk8VQQma2JGqLJ2WbU38HaSzYR/tLbopRmQs=
X-Gm-Gg: ASbGncubXdZNYzWhvLjo5G9zrSSjnZpxR8AEUHEUg/WWvWlqVBZGclHNJh/m8TjR4Gf
	i+b17eBr0AWXO4x0ZSSepGXtS3NhjtHIFAowc1antuGjCIoxsioK+oA1HpHosuOJdLf4VpxPazN
	JwsrMhQ+M01tJCueP6atVFyeiIEg6FV8lHbNayXcwjoDKIyZSmOTFSdlShCJQQfB08IMKXJqg2K
	0ebC45DfBEvGxBXYsDuncssb/4hgEjOewNLEAksMdPZeLiOeip7weDfB7fcqdWYDOxcKqL0lv0N
	CybkMhh2c1Oj+DZDk9l4lG47hqXdd1GKO9CtwqNmVWXPgjeejnOHCYiAVPCA+AEJUb9nS35qyAG
	r7PX0bHkyz16+UCRegwY=
X-Received: by 2002:a17:902:ef09:b0:215:b1e3:c051 with SMTP id d9443c01a7336-23fb2acfed9mr21632235ad.11.1753438098006;
        Fri, 25 Jul 2025 03:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGueJ9+UVphua6IFcLHYOrZC6BjRhw5clhGAM6ie7Z8MXkNXHXuyioPE834TkUegaSIl4MtsA==
X-Received: by 2002:a17:902:ef09:b0:215:b1e3:c051 with SMTP id d9443c01a7336-23fb2acfed9mr21631535ad.11.1753438097427;
        Fri, 25 Jul 2025 03:08:17 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:16 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Subject: [PATCH v4 01/10] coresight: core: Refactoring ctcu_get_active_port and make it generic
Date: Fri, 25 Jul 2025 18:07:57 +0800
Message-Id: <20250725100806.1157-2-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aRvlpTAuzpiqLYb5NMj0Hn4Dfh7uMAf6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfX9lPzAyCnkXQe
 YDR5Dl7kBZCIbu4kwOz1AFPVL7rCaiyBItTlaXHfCFmKYK+L9xgCTsG7BdiRgvbhwJrsB0DjNu8
 AL8oT7X8sVY58hV459Zh+zRE1LYu/2c7PaEUJNm7P1QO2TCWLkIDQaF/PYHgOVvloG8U1WbJcrG
 tHrrg1r7k0reoGdgubZxQOMXGH7KllRY88VrFOlzyqDf1hrULZGKqYQjoxjzQ+FQyMFiSg3S+I9
 stKg7JMRqxtJxDHxBXRZvZsfnE7AHTFZJUoLiRBmNVeUgJx/I9CGzuYKVIAjL4bmBggLxyEMbNN
 Bet+qmrY6RKEE5u1GyfKX1g4X4f1N+fmGTapoDRXVppOZ4MC3ppbNVsAHzLl0raL1ffJg5IETwT
 D23uw0MUKbCFEuAPLN3oRsuqzTpamR2KGgx9gZVL/X9jo3zyZrUpFDmPZ11mFzJz5XK8D42T
X-Proofpoint-GUID: aRvlpTAuzpiqLYb5NMj0Hn4Dfh7uMAf6
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=68835793 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UMME_An3wchvczm7DuYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Remove ctcu_get_active_port from CTCU module and add it to the core
framework.

The port number is crucial for the CTCU device to identify which ETR
it serves. With the port number we can correctly get required parameters
of the CTCU device in TMC module.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 24 +++++++++++++++++++
 .../hwtracing/coresight/coresight-ctcu-core.c | 19 +--------------
 drivers/hwtracing/coresight/coresight-priv.h  |  2 ++
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


