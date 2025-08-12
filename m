Return-Path: <linux-kernel+bounces-764326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A5BB22193
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1716566161
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A32E8DF1;
	Tue, 12 Aug 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJKin4ld"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB762E2845
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987868; cv=none; b=rBa1JSyjXhtZTI0REsOIIR+xnKUcHbmv8KVbcefQX84xFNeNkl/QfYkv0j/qCpWC+wkT1h5ZXAUzL1A5PH2NBD1/1M+6NhqNpI9L/6i8Z4EM4FCk2TVKYIje3IkyjOatu/OdShYk7E3+rX6uxmHVJkvC68GqJiqaauBIhYn8Qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987868; c=relaxed/simple;
	bh=xtxhewrRdxb/X3PMc7wN8egXSrqwQkWhSbTXQL2ZeWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5SxtbWvcITuWZSguiRS6UfOo29E7Hg3kv8upkBlTSH5xXf4yw0DfgneKYNkF0/9kOZ2aP1wPOBLPpok8Q2mgax5kM4IIl3C1/+1z7BPrX8pMDKxAShLxNm/2eFHls0fla26WHf0/UVbBwcBYxTxnc+DeqihzePtSsOKD3X63zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJKin4ld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6QcAs008762
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=riURT7yHCOP
	Zx38hIetmNcrk/xUqPrSJU9dLdU0LRDM=; b=GJKin4ldmrNMZD8zcr+1NHBAgdz
	//9AbRH4PQBcUZ9fxecK3iWVCNevMsUQte/Wa19fuvpNErwbWvdgEdtGLkJJ54AP
	6QAeJ7nuYET1jC7bT8urMGONOZ58wRSdeD5+WG1RoAnOrjryp5hdW5hQjFBiigWi
	sKtkF8ut80Y0AWUkhzTVbfSnQAkAhlYaFeDwx5ZKv2EBmFoVTA4DiOVa7FeSC1pE
	0mnzbdi8Xag38oKA/LfJenvYvulhigEPEVQtvUjuaoXUuKadvy5UoGYs/Oje5b+s
	1SYOGRR8kkdaPM45dusXOyT9nW/nzbU6MYQRYCbjs+VqwR6xjGCpurrsN8Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjk8p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:37:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso4120001a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987864; x=1755592664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riURT7yHCOPZx38hIetmNcrk/xUqPrSJU9dLdU0LRDM=;
        b=HCRMHVDYWDHcQCTfNl6BLBHswk7VMkgF4E+Ph9BMnLTSJ3eG3z7qxgsxE2hDhrpyJF
         4WcOTdlqDdvj+A96fnpXjrHZJ+WH6YEPrQ0Ev60VLyjpF/PSnIz0gXFfMkRwn9wmFWz/
         zUFfgNpJHZLyPIihbtw1AkSu7V1U8hK5HpBpnc2fmFYNsleRPr2A75zekS9lLzSBakDt
         buZ4H/HMthTI7X1SZ3Mpwb00HLtwrfvzTzkOGKVc5qR/knkv593AtRgc3PMVdo+SxIk0
         ECJna3zJW8seCT+4hoM2JY//PQJpznJfk/ww42nv0SfdYbfrzSN/WG/JzizG9Fq6fTJ8
         ZmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThZcaXHVH2Opj9RqAPHBil9PFezPQTrVc9D/cXzYEZB00dkwILVflMYIvINsOYjWNUQqSzXDGCHHsm28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qNJdiamdfX6G4h8Mjrif+Hv0NVrLGkpq2Ae11otwer7drQKe
	bvXKEq8zKw0rV+TNfciZrC/DOpYMHIjdpmlXE962YuY9PkxQ/eH5rfB4N0PuOunheV3LsF2cFNm
	wIKF1EcDIBmLDXjaZEA04/F5JjuckLLo21aeuHXNELcNsYJVLvgE2ONsYKAaL1CpkcfU=
X-Gm-Gg: ASbGncs/BCPZGUiZ4c5rNcIfI5mZlnhB5U+yHxLSX5aCiZmvl6ChnHtYNBxYJcCuFBm
	GAD1TAMVuZUZ2Qp0egh77hGQ0VDp0LRurJDHcX4YfoR88+mlac4eQ3waLM7zs8JtowiQx5AlFKq
	lPZn30Vi/fsM4IIfi4jZJ07jdQpJiKiH/cjqcyQtmaW+wJIDWOwi89FEktfVZQRkWo45I4PgyNh
	0Z0tmdUPJbOqimDa5MhwcCeHsMaLvU8DUzCfaSdPFmsfZ5pVwCnj3N3z7H+W77fasjdqcAFDj1E
	E5oSDicySCCeoq3OpoHhSpbvYgRKltTCPX+tDg5wNFrgUJYznB0wAT1jJ0HDeOnO6zkW/BDgEiA
	lbvcM1l6sbL2XpRuyMEY=
X-Received: by 2002:a17:902:e74f:b0:240:11be:4dd3 with SMTP id d9443c01a7336-242fc230cd9mr37045745ad.3.1754987864054;
        Tue, 12 Aug 2025 01:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5dAbW2Log0v6AuB3l+T7D5XFDndUH0k2jF1NznPuDRg5AqrmtsIfJngtinh2TBDJFxMffEA==
X-Received: by 2002:a17:902:e74f:b0:240:11be:4dd3 with SMTP id d9443c01a7336-242fc230cd9mr37045195ad.3.1754987863460;
        Tue, 12 Aug 2025 01:37:43 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243086849b3sm1915345ad.175.2025.08.12.01.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:37:43 -0700 (PDT)
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
Subject: [PATCH v5 1/9] coresight: core: Refactoring ctcu_get_active_port and make it generic
Date: Tue, 12 Aug 2025 16:37:23 +0800
Message-Id: <20250812083731.549-2-jie.gan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX3mec3r7LhUPg
 ft+5mq9hUMJNnEowvTcjKy3SAvLQiukBZ8E4bpfmUWDus5XplLmBYi33/nOFEtTOuLeBW/StkHS
 +nmiPK0yRoo+quxNQk43ouL07Wi9IxRtQj6sCnjLw7WPFDo/wSLoPBYjUuAyB9VxkAtkGIf6Shy
 ini4sR9pldGDWzq0xV48dQApeAMM5Vv/lcQOyPejzTpuRCAOOU/IcOCaAUbFlpsC2gE7DGUQ2z8
 LRhGHhB5CpnluTzfqNygRTuY39NtJ20TgYgCdwZBnLiXOLiyaKLwyMjb23ZxSUQVZXn2YZSnkLJ
 ZykM2vK91tMwy3s2AJS3QnQjQHyOPIKFZiVrNmEIzaVPXwcDeCKlze724GZdRqrfSskoMf74SSJ
 /oPQtySB
X-Proofpoint-GUID: okzpZQ1HHswGd0hJS0G2iesZefH0Y8vk
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689afd59 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UMME_An3wchvczm7DuYA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: okzpZQ1HHswGd0hJS0G2iesZefH0Y8vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

Remove ctcu_get_active_port from CTCU module and add it to the core
framework.

The port number is crucial for the CTCU device to identify which ETR
it serves. With the port number we can correctly get required parameters
of the CTCU device in TMC module.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
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


