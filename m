Return-Path: <linux-kernel+bounces-729467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C738B0371E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72BC174C99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922422A80D;
	Mon, 14 Jul 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfS+iyOE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7598229B13
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474691; cv=none; b=T0WX1k9ymeymuwQYdx2ZXA4tALsUUtrVN/8uqKdbg8k0pX4y+D7xowhoXY0fvDZQRdmq2a0Z4scSdmgqWhF2wiS2l492lcorolliovSrl8oQPW3mDNIhAryvwRS52a4WjB42YbYgf/xF8FWldgkgDEuecyr9BNJ1r34MSEjkmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474691; c=relaxed/simple;
	bh=1b7rvw56Mctvyg+F2hGGn2xKS9+q2PZD+8BFDtHftYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCYKqLprf7cQiW/GsDAi6K9/DlNqpaGbAkheCde9kpCehTxt79gkKBuLK1hIiFF5aGRo1sF9Kg9twN7lPhWqH488Vke+iMUX54DJ/bRYeKmYYyq40LvL9qjsyVHGF80cVcJ90kH8nq+7Gno+46hkqjmDfY+am1EPy6sD7wh831c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfS+iyOE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLR426023898
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AXLNn+wjGkg
	SdDfX67QxF5l/RNz39oJDxLQvREZpRME=; b=HfS+iyOEMqpMEBJv0AV3xStaduT
	YXA1i+SJdLVUuV14+/JitLchm+N2q9ujnayRhe77pye5mmQ/FvvMomfTGKCUyyQU
	5A+jBSG0EDpwpDVWLunZ1iv5UPsZzIYY+t+Z1+9HyTEV+Q+t11sekxG7s/IyhL/H
	dxCUA7tLA49Lgd15cvf80ifat5mhYnQgph2wAuWFtBIaUq3JIQ3ITcHzkfa1jCAx
	q7xevMOvM8O3NCJk093NwAuTMeF7IMwrR+ULKXTyPrcv28k+vR1WAWtwnmdp1K9C
	uhspC7et9g7/uviuUvkBZfcD47tCBxE4a8THkjEWhQ9TlEAbYw9O03qLuIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu83ecr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23689228a7fso58331715ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474687; x=1753079487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXLNn+wjGkgSdDfX67QxF5l/RNz39oJDxLQvREZpRME=;
        b=VE5chpwNzvsuXFvDPyoOF6UA4FcqCi2zJ1UTHOzEdQC1eo3l9zaN7gyn331YE2u48B
         SzM8d88wIwVj6OwAQRvt/MOtDK6vmAOe+ygcuT40DiQKg/YqQnaqSNtCpjVknUPLpKy9
         3R5Q30VnDNk8UsHd/QK44Jhuu68aiwCwrG0ra9a7ZOr/kleMsscV1v82XyrLa7vmPYgU
         dqikKk62zcdUgufghIPJbnB1Li2yFasFym6qqSAzf51l7oLuMY/TDIidQRbLSiqNlHn/
         RSvzxqvQJ7Sz5vl3uIFkJmTvbJ6iM1+ir636AC24WgKLraIpixhkmR2mveFUT5yZMZff
         qdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOgqbIAAW2pkfnKKeodXrbIxx7ey/ebzEVR5bwOqcaGksYXPgQn/VBHiKClY7AZV4BydOmMV/pmNafoPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHtXyAxX6fC6GvnSssIiJDByUYgVU0vHCHFS0eJ/PIsqMrH+q
	I+00Rm61J2VBvxXnSbgouVXYciCkPCA5xaZf7SDn/8jBkIUX18RPjovvLBcu8jJYWkSfM+l0/0W
	1wHU7N4XT3KKJQAG3JeyRpJqVLMQqWcV5r0qQafd9dXb7a1XalsuyZdL9IHVYphv4zhs=
X-Gm-Gg: ASbGncvJE8IhUOSwwkPfucy8k+WJEDxbC+yWrmYUfsWpf8UDguhvVuxmqWi+oqerOQ6
	ue25LPoo9OFREaXOgP21XdX5HYWA7XP8WygBNBozRuwKWsjbqsTxmxxFblc3iQ81RgHWVdqsfOp
	i34FeMRdM9bRkxeej+Iwd0XpAf9YBb5Ee5f67tgwgxiSMyfyK+3aRUKRxOB7smTs+oG6ygF8Syr
	nTmO5jzlMojeoLTba9QdYQ33ikXvgkkO8rBxouqtLZXZm4W8hqRzbm5814UoGR20w0b4tbTCD5A
	mUvc+FDdaXHUMYNkg76KhOlMjw619w/bzUzCAY2pTLJMot9QRQIATDdF91gKWOwF4A9WhqWJPs6
	M6qxfQDjq5KirifPykFsm
X-Received: by 2002:a17:902:f990:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-23dede8c3femr140606905ad.38.1752474687317;
        Sun, 13 Jul 2025 23:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhuRWB8qDraxlgUCSzGpQ7hJwWY5emhcB3nOzVNA1nN8Z3RmdDgtgMiAQImDA3RGWg7WXXIw==
X-Received: by 2002:a17:902:f990:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-23dede8c3femr140606595ad.38.1752474686921;
        Sun, 13 Jul 2025 23:31:26 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:26 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 02/10] coresight: core: add a new API to retrieve the helper device
Date: Mon, 14 Jul 2025 14:31:01 +0800
Message-Id: <20250714063109.591-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfXwXUsETsQyY+Y
 ygl3bZaYPqYk22m5Z+7NRsk7XA955NviySO8+vn8PmYB7V184SOq5U2chGUavBwB9jwNLcHJPSy
 0dbT66lL7cMJWaDHstfX46+Dd8biizhcJIYyI4xspaKu4P2jdmECBumvPA4e9CZz5vLhgcjjR2B
 OH0f/F4aIpYFa6e9nRGmwxR2lUFjN6+1FDEC2DySPowS2fdwM2T457ju4fbY8+r87vaZjI+P0L8
 ZUFcosb6KdvJLyHAcVqZyS4UMYCpLz+UGfz8/JkqD5NB9VM9er4Wahbr3V/7EH44yNtDHEwrgln
 B/hVNkr7u6wq63fhVGpqYQl8woAB3ib9tgF82OIHoetofBH0vErck+IwgF2dFapFCWbFUJgDGLW
 FzLgDJuceq607OO1BlSYV4hEvDSNv2FUeTrFtb7k9j5bGyWRRdj18uGZQb976MAmVnO4HDP7
X-Proofpoint-ORIG-GUID: mvqwxWX2QiZiKZwg3boAW1V5eDxCKMhm
X-Proofpoint-GUID: mvqwxWX2QiZiKZwg3boAW1V5eDxCKMhm
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6874a440 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Bv2r1u00ER1ubdDhqu4A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140037

Retrieving the helper device of the specific coresight device based on
its helper_subtype because a single coresight device may has multiple types
of the helper devices.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 30 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 5297a5ff7921..76e10c36a8a1 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -580,6 +580,36 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
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
+	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
+		helper = csdev->pdata->out_conns[i]->dest_dev;
+		if (!helper || !coresight_is_helper(helper))
+			continue;
+
+		if (helper->subtype.helper_subtype == type)
+			return helper;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_helper);
+
 /**
  * coresight_get_port_helper: get the in-port number of the helper device
  * that is connected to the csdev.
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 07a5f03de81d..5b912eb60401 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -158,6 +158,8 @@ void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
 int coresight_get_port_helper(struct coresight_device *csdev,
 			      struct coresight_device *helper);
+struct coresight_device *coresight_get_helper(struct coresight_device *csdev,
+					      int type);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 int etm_readl_cp14(u32 off, unsigned int *val);
-- 
2.34.1


