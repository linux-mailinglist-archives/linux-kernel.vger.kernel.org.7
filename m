Return-Path: <linux-kernel+bounces-745574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE93B11BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F22B189C410
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3922E040C;
	Fri, 25 Jul 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxEHMxWs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4902DE710
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438107; cv=none; b=sLQnkQmJl1fl56AJZE8RYLYdDiPmuXANrh/RUzu23ZfP65gNPnWU3vWoxSmcXylO75gfihCNB12T8YRj1A7jgScWkmzXSe7O+/iXFhsuf00DyzXb6GdmDTKdmxLyDspob02FLXa5v9kDeKHNhJjKyckLLgaEUDdlsArD5x4BJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438107; c=relaxed/simple;
	bh=MlUhyGdVnh8kU2bXiSAS0ogGhDUv6OxnQL7AC037lgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5bfDf5zWHwJcSIRgYEYcCtUdnb9/l8+hXJ2QThZnT/aMxbk/tX02NER+IK7XOaG8Q9bFea7hKkwBSh/srfRD0FF08DjNU1uY5H7rOncxNnF9TAdcGauVHUS2vdOKB761AXjQTv5Vej/qTy0jHb03KNd7kEDT+A4WSMSZY1E5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxEHMxWs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8s9Ax015762
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iwVty+8EPpT
	8rhXCALbF9loLMkW446LKfXLUZrsgr4I=; b=CxEHMxWse1WCK9wBxDV9iQM7wTg
	VFNZogTvcgdq/U31WLQ3dyK2D4QIfI5f4hr+u7hewdXFstQgGieekWtU5b+GzGae
	Vu32wjNnI5jEjl2cj4oLoJd9n7gp7/Vtx0sTpvut3bR8seBrMtOM4WmLQoNizGBG
	zF6DZxUzkcqGhkEsM5Uys/xeVCTJUlfW78p6V/Q3DrKDwqVtSXo4jNH6vBdpHp3s
	mZylXggVW7z5Di3FT4Utg/09a1JnNMeXtl7gqnkTBA/pnuQvBJohzi8ZoQ5XeOM8
	yNuIOYbFVs9TH3j2ezsUMbR7WyT7WDSP7m8Sm+ONG8dwrarFvcgeXgS1ZZQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501nnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c36951518so2338526a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438102; x=1754042902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwVty+8EPpT8rhXCALbF9loLMkW446LKfXLUZrsgr4I=;
        b=EsTvOsroBmAq3iMhZq/cpWkeyp7AhXrLtYeciyJq6F+Gk+LrJFBqKlnb1cyKz9RZHg
         HvpoMT8ClDzHQRoQB0Ub1VTUZkf2KHJRZCLmlmvormwLi0bdDmwc5LPneaPoHIv7cbXR
         ZKfYDHGuJNxlmC3TyCS1MsC7Om3URwbwiGHe31vre8b9tNVu9Gc+eYWdixQKODvsBgfW
         WXlnMfHANHGSOEx7vJF2if57VwS4Ko32zvvnKeKNrNJ0tFu3I2CH49d/MZbff98+YnoW
         nhkuwBePjExo5Qi1jWLXF9Si+NKO4kUmOArsSosx3mWF5LlaVhupLhlYz3fDlJkWK6T8
         k4qg==
X-Forwarded-Encrypted: i=1; AJvYcCV6LOdMsRQ2KVmoQxZSPphx8A535BGu1FRZr8NChtxzUSeCj82ef/2FQ1PsQteP5hCeYRpEFOYMer8NU6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JO4UPo/1bplOA45kCVZMS1AOoRitgSAxvVt8L6A9gSa4lZRY
	P6pzBgerbd3djVLMNpF1IQx9DXnPDr1Zcns3WiOFLySokz9N0fBxF4lNOvorX87dSf8cGmwUWKC
	+LR5MqFYDR8rGO2T42xVsxu14IP8RlN1Ix0aCO9ujRzeVJ5feQypjN7cRwQlXAnzfktk=
X-Gm-Gg: ASbGncsEOJLODC7GfmIhCgArSHfgItjAE5Ngc9zUMTLCKUExX/n3kpZQq008RuR7WOk
	nuWRO3bH4vMgkMTkF1hShhsTBnBAAv/ywuGGxJqb3mzqkXqXEMNeZu2jMyPAwHVAK1gCFMoHWKj
	UJxJg9/L6+dLNICystZbhvvEffx5/zv9MJW5zoEMP9MUMoXqGQ3C8oopKbs0HtQaZvMa4qlQZu3
	cVQIR3rERZiahJTXhUsDemgaa5zCs1A7OJYh5SbDkNozL03r//mu8zwX7O3UeSGScly/lRfJ7vi
	wtUpIXgu/B5PK+zunziQqrPE2g4xWqAIvfSuZeSLBrvzBQzOCUSoj63BpwNoF0UScv5gHv9vXip
	5sfewN6+hILXK/olcbno=
X-Received: by 2002:a17:903:4405:b0:23d:da20:1685 with SMTP id d9443c01a7336-23fb3065804mr23647175ad.4.1753438102570;
        Fri, 25 Jul 2025 03:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGAiBJTC/djKisNS0F0AMBhg//Vc5DrCNPe8BoJTA4OkfqBJrdGCh9t/rTtPqfvIB0yiXT9g==
X-Received: by 2002:a17:903:4405:b0:23d:da20:1685 with SMTP id d9443c01a7336-23fb3065804mr23646345ad.4.1753438101895;
        Fri, 25 Jul 2025 03:08:21 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:21 -0700 (PDT)
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
Subject: [PATCH v4 02/10] coresight: core: add a new API to retrieve the helper device
Date: Fri, 25 Jul 2025 18:07:58 +0800
Message-Id: <20250725100806.1157-3-jie.gan@oss.qualcomm.com>
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
X-Proofpoint-GUID: pNVq3O0ZfSw1x45FbURhvjikhHFO51gx
X-Proofpoint-ORIG-GUID: pNVq3O0ZfSw1x45FbURhvjikhHFO51gx
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=68835797 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ViBFXQGRTvhYuEXyb1sA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfX9+dfDYfUISFX
 0O5chMnu6UHBFyxXEqalF0qAWum3nWxFMM+yYVYDqaWgKorBKzUbKntTPmk1FtL/uZCfBRtwKQ9
 h35lYnQoTsVz4SaW5ZMIK+KrR/sZpRt4najdmIhICYRhivRq8U687xpTnAsxZP1fG0ym29MOUH6
 1w5Yq6ZiUSDLtjCGU9cAYnBICwQfd/OAXpQ02Yw34z3eVMV6azlOVspqf98RQ93dZMCSSxRCHVS
 6Jz2d7Ols+moyZ/yJKRoKl2LS6ABymbLDazlsq/lKDpjteDr/r8g8X7TkdpDqdMsT2RmFSngkng
 yhm0csBPwJ8xaVTbnuL1de6oiFJ3mmaovAKDMm4afxGP0kw4Td7Xehfoo7RIxbcv2YymFTjzqL0
 EohC0Lq+7n4oD80XDKj547uWo2tUl/yErYKwhqeKphgY+RphiJNxUEAiriV+KZdhpmxxRM1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Retrieving the helper device of the specific coresight device based on
its helper_subtype because a single coresight device may has multiple types
of the helper devices.

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


