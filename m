Return-Path: <linux-kernel+bounces-764327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F44B221B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB96E65E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD42E8E1C;
	Tue, 12 Aug 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gufhqA2Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC92E8E02
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987873; cv=none; b=K09zhA/vtFvYZTHRQ6tTwdjneWQGUjIAscR5l0rrHuKGKNhZIvPDC7wbJ4pxcx4a3gU788n5XygmYJCev1jUo5zwME2LDyGYIy6GAQ6USIG5cqc3dYC8ZCWeJOi6KfpSfusoYbKN5/IYPbBf2nM+lwovQcuPhE9zQWnGwtniMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987873; c=relaxed/simple;
	bh=D/F4ojh5lN6J1g3jMwklYOcZ7lTVu6mETleBG8wgOTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHbksOT03t/Scw2zXA6jNJy7hajhady+QDc+HWjKt4HljVxSBBAdC3P4DQd97msK5M7ZJZr4EIyYfvVptnEEnaVUEoVqWIKxgPUYfuRn9v1CwyEM+OF8z6Dehj40GhxXFFu1grqUOQSvGKgSbmQ9b5UiqoDRLej/G+I9Dl40hNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gufhqA2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4t5bY013094
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wrGu5dBmfdM
	mzrfdvoTs2DIE+CWt05hHpp1+g0Qaf2o=; b=gufhqA2ZBtkvBSF2b8ZHeibVtt5
	H43hsVSJWZzwVH70ZTx66iee0kXSpyLFjt+WIp2nL/iJ10+tej5R08Dv4/VDezcV
	kajiTaj4wwFt4VPqzZi7Lh5wwMxkEAF9r516yTN3ncFqMcTyKkNhez8wbYmg3NSU
	ONPJprHDkB0q2vdSXmZ5QhokpifwubucDWxGjfMoqOIVrMZhX5Soc+NomHwPOww1
	uMKm2Bk05Ar3iiqkoi1r6LXWS5PJN+6dACdhWbUCFcZA38v0KrAbkVhy6y6mWj0l
	SuVOxLx9wkq/eJ8dmitZ8AsOqgluTivUGHqAcPJkB3g9RjL3Z6b5oYh3ahQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmqjcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fc5b1c983so63564035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987869; x=1755592669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrGu5dBmfdMmzrfdvoTs2DIE+CWt05hHpp1+g0Qaf2o=;
        b=dkoNfPKjAXcBeJgLIzv6gt7nSUeaaXlBnhEQ/NTmJk7/IpDl+l2QwdNxoZgMYwmWB6
         Je16DXOCTimussLaWdSqwSzYTDi00ycfcS1e597gcwwk9bbY8c6iMlLDWmOTyczp/sCj
         nSgRa7PuUS5gklIJTlhxC1FpZ7YZyJ6y44mey/chY16UKPKIVw0IoEj1HCitVv+rVcTi
         s6ndqunEYCb1kU2UhAgDoDdQldWNRl6TJVa8Vp5gQjN8RATCqXn2wqyV1ovHYqcZEisL
         9IaX9d/1WNd4cjpMl6q4Ya3SFSCkL2CqVhxIR2i1yNSj6Y1bZCOwRXo4WO2wvoMpjaLg
         QpgA==
X-Forwarded-Encrypted: i=1; AJvYcCUBdsS3A2gcuapz7jR63P9UKH207X/MIL9KBDLGnb1wCJmkjZheDCidT6xwUqV8asfntm9INFDLz8Nv7WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGyTyeLpCe2g85+DfHr21Stk5ANz13vkKU5hdVROPwx22Vz31
	eKn8hhBZpno/Ei6XjK9icAdbPAGxU5C+unGpH/gimKKZX48P/6Yryls50ODCrZ+JVAt5Zbh8t9v
	8A3LSynacqgpj2iS7Y32YgeVfthlSqOTHeOOo1a37NcqvAioq9zaVZlafFkQoS76L/Sw=
X-Gm-Gg: ASbGncuS64jNZxzE8i81YTzUUVqFXhMZLiD4P/vA98c3EhOsfiOFndmt1gOBobqaBQV
	at2YyXUczhzJIy/ZXvWGdZr/pu+VBwvguzTKvuQkuc5w3arKKqP5zx9nAt+MCgsyZ82K36e9d90
	6jRnCrSXM4MoW3dlCF1zpThG0mlB1rM0u4uv7gjoZAJXq6O1E9wYsKKNE8hgGTIqpBWJzMnDrIY
	/JnxM2FNwUyr8srocRbSHSC7ywtHTh3LXrQsJy4WMw2EYsuieWHofZz+JvBcUXcF9HNLYpDBRVQ
	0ywim/U9sXsymB12oiSol/pqROo352rss/ybfD9QDJbfr7zuwpk3K9T6U9KPfs6++jA9CTs6FFg
	DP228FWfkhx3oNKS4aR4=
X-Received: by 2002:a17:903:32d0:b0:240:6fc0:3421 with SMTP id d9443c01a7336-242fc2df919mr32672035ad.3.1754987869228;
        Tue, 12 Aug 2025 01:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1epWZtnF2IBB4X6gRIcAxheEo7d+5Pdk6LBydS5mLgAm0zXrYNJ+qesoW7cmIPGP6RrbrFw==
X-Received: by 2002:a17:903:32d0:b0:240:6fc0:3421 with SMTP id d9443c01a7336-242fc2df919mr32671605ad.3.1754987868720;
        Tue, 12 Aug 2025 01:37:48 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:37:48 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/9] coresight: core: add a new API to retrieve the helper device
Date: Tue, 12 Aug 2025 16:37:24 +0800
Message-Id: <20250812083731.549-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
References: <20250812083731.549-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689afd5e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ViBFXQGRTvhYuEXyb1sA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gYD-ndTocgELL1Ndxt4cSluBhpAj3MMk
X-Proofpoint-ORIG-GUID: gYD-ndTocgELL1Ndxt4cSluBhpAj3MMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX1va/zBPgSujX
 02RTFpqWF+YgMhlzZ6ZaGrEAs6WHGdCUaMe+NPGvuEKZB4Oltgc1wtpX3n7AxCKqcrS62Nrlplw
 B5pY0wOxsWUyT5HOpBJEuBUF5qvV1e4AqZxWRp5eckMEbN4/wJ64s1Sr79pabTPfbxhR/6QmKta
 wnPwhj2OIYIGds3ZQKZqTbFwRxs2ynaqCM0W8rqQV2PEWKADdR2njDlxPwdb5fhP5GLFSASpKUW
 eunL+1faSaA/YgDwYmwqpR0OJRnliLfNi95x3YO5jNOe7k76GD5OdDVTd1rf+ogjX5WWHUxpwtW
 39WmnnTSD28vgXQEbk75HoIzawxTuGQlXbBuHPvRKMb7HomYisO0FCUZKP/YLDtuyVZqu5GA+zZ
 2u823ktI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

Retrieving the helper device of the specific coresight device based on
its helper_subtype because a single coresight device may has multiple types
of the helper devices.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 35 ++++++++++++++++++++
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


