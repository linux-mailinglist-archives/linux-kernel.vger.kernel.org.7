Return-Path: <linux-kernel+bounces-657022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B1ABEE05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2778C3B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3555237170;
	Wed, 21 May 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kERgPdgW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396F238175
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816365; cv=none; b=RYaC3nUxYxPiVCFz7yXH5r9F+Fmx7vrzQQ9FMl0pb29Z4l+6kYE6fHEg80Rw+eyU2bXINp6neJzjN792tVFM5O015MdBFMgehM1ZSQqjYuGXbYwkn76tmBR9LciB5z9Obeyt5afVLy7TaFSreWuBqb3n/iyx8ovX25/K1veCOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816365; c=relaxed/simple;
	bh=B90rtJaEdLVGrv1h54uOTMtYopEROylXsM2X/zlsPDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=el/2f72e3sPXPNtKthj3ejI+f29fcHeUHVtDl5FwS1yqCpUatlNm+Y8EVOSBA1UFWftLMFtV81tGnBZ3Qsbi63ng1YinjmJgXjQ4eyd20jyghDWxWqvushacQSg/gJ2GW4vy+BJ1R1zSLvZ6wsIlIRrA0eROzwVjUQBITbkSxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kERgPdgW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L6HKtX030890
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 08:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q8WlVCilRvu0R8ZkLwU1bjGX+ll6bjMiuOVM1KThDM0=; b=kERgPdgWw+/NE7D4
	XhLxrLiULjlDATmiINY1fsDA+uFlBlnxUVajj0tI0C8CsHFOOAp2Fb+Cb1jn9BjF
	2/q5xFHo24P5xUyHShMQsjKceFlXwppSWvLLpTo9OuW0jJ3FGQT26xOkuYfOtTvK
	+V8rlO4ZCn+b3z3OpE4mQQVKdVW6mnYtEc9BN9VqMJGk2hEZhZjLvEsct7jsItkB
	ZAaxUI1aRSJ1ygxvD47KJyA03eTCLA4SlFkDOW4wHysOskksEOIxsnhfz2Mf5Gwi
	qorp63aP//niU/4TCqkNXeVWggOMryEaYQVBLKPbQLPkz+f5YXWFTHv18FykkuD3
	b0MDuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9t79w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 08:32:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54e7922a1so1431350285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 01:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816361; x=1748421161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8WlVCilRvu0R8ZkLwU1bjGX+ll6bjMiuOVM1KThDM0=;
        b=vLqjSSuwMt6YhntUU4YlRWlS89UEayp7D6QX8vv0L28o2rWy6s1vmz7AzUx6Z3bdfw
         KfuT2YnKzmY2qU77ldYz7shS+diDo1hp5P8n6lUoCrSdfi2SlL1iQaa3z5g12TWikF4D
         t0PiBUQy3N0EpeWqk9Cy6sDF1k5UogLHnSICp5lKyrVtPlRnGChM7PGRGpO/eTXkTRfj
         k5xndu665byatcdC1+hF0VJHLMHa9SgBW0fu064axxGVHSS80sM8wFGRjyJI4PbfYIgQ
         pyoC2xjrlYSM/mnLXsetn052Ix/v5y0sekqd3d/R2l6fiK+F8L1mMbtQ0UExiZ+Ef24n
         gdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDsaIcGD5RyywPoEcsbaKC3keg3wByO7wouGetENJ7Cg3R3tayZWlbps5ssg3CoBFQX6bRLRvM13HtiPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rHLxpcskljw9XrSTGGc/zx1woMFEuyn3kSK5XEYbOzO2427s
	sY8izEdRGvYlDNioB41pbrFNNLbaYC0kUl4v1BLUnQGMAqSshPCbm5gAqG7Z/1/K9xx9Sg0Dfof
	OHb2TO0YnsHhBS9dYtT2X3o4pv6+c2z2WBhD5htnJBQ7lZHQ3kmafg2sUAXkFUijh1jsEHaU94r
	c=
X-Gm-Gg: ASbGncu7lmc4uoKlJZ4ji5emlGIQbILyuYkUm55PDBP+0dRugZNUo0SsRCYTIO0jXPF
	AKd/+yrduSA3HEcqzMrHN1GQY5A2LBlYtyaeDWhx+S3N1rxOdxlE8rzBL6l0/m39a2/qUVPxHbY
	4jZn2EVoPNNN6MjXywiZuM0eZb3wnmBC1jQq2ObJL6ScJKd8zXGkUnYbgyi57gUKW8TUDiaztD3
	UOYlanI54Yb9424TEmyM/36VsRaxye8sD9bk628IynlJZj1Mbw8wcXrnhhK43if1xch3koFoI7H
	KCBIYy5qv5ke6mWnpAP3NDFTpA==
X-Received: by 2002:a05:620a:290e:b0:7c7:827b:46bf with SMTP id af79cd13be357-7cd47fae083mr2624393285a.39.1747816361035;
        Wed, 21 May 2025 01:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZQqSOAx2Bxa4yRiJZZ0m16zE1B1PlA2lhEyP9p5hl0i+wk6+k2XHsKXXRZEXZW3tGc/2c9w==
X-Received: by 2002:a17:902:ef4e:b0:231:cec7:465a with SMTP id d9443c01a7336-231de36b432mr231781865ad.20.1747816350468;
        Wed, 21 May 2025 01:32:30 -0700 (PDT)
Received: from [10.213.103.17] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233abb99a06sm13194265ad.254.2025.05.21.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:32:30 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Wed, 21 May 2025 14:02:11 +0530
Subject: [PATCH v2 2/3] soc: qcom: qcom_stats: Add QMP support for syncing
 ddr stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-ddr_stats_-v2-2-2c54ea4fc071@oss.qualcomm.com>
References: <20250521-ddr_stats_-v2-0-2c54ea4fc071@oss.qualcomm.com>
In-Reply-To: <20250521-ddr_stats_-v2-0-2c54ea4fc071@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Doug Anderson <dianders@chromium.org>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747816340; l=2719;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=B90rtJaEdLVGrv1h54uOTMtYopEROylXsM2X/zlsPDA=;
 b=GBFBCNX5R87eCsqSldgqftv+DUUjDPTkN4YAgA/+62IfTuYkCWkeTptZUqHkB9HJipE5sHsFB
 mrwcZZhfXWEBLGeXrLJl8FhmxzdS0WsiqYAQbGKm6loYxp882042O3+
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682d8faa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=BT90xxDHZu-g9S-RVkkA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: _YKXqtrGft6n3dlJTIr68pVID8uAowrd
X-Proofpoint-GUID: _YKXqtrGft6n3dlJTIr68pVID8uAowrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4MyBTYWx0ZWRfXx8pwc9PjwRWP
 lGbWxVOckiXWBXfwtQYXYMbhQ8duISCXvn239Lu6WrUXCgtkWnkTWb6wBkL/4ryMtIggtpS+nNb
 A54F4/9U2c+iRStN23AsThAwV4xPsP5eMkrXW7kgadv4xU1hJSwv0Ed/Yizy+C7pZK622q2IGEL
 UWvEi1Kzj5llQBD9nK7pbvo5XMfIKTdcuAKCwibC0IRJZEDZ6MZPtaYJpVzrVcUnfP3HlthFMcN
 qicZDShuNSAIAlm4F6m9cxAK7JRzi9tuheVcIATIb1oQB9PN70ad2/HbcTz21YF5GC7F0615TRa
 5k5FBFdopmVIOffqun+h5JDh2dEK2U1eUG3Dg/i93syem+QXtKYHyaqwlfX25BiJXLboEVoCdwK
 V71M7Y9SUoFx8CjsAY0VyypeKmh8ojZwh+dl4xOLox+HENTLE47XU1a2ce28+IneU94xHM0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210083

Recent SoCs (SM8450 onwards) require QMP command to be sent before reading
ddr stats. The duration field of ddr stats will get populated only if QMP
command is sent.

Add support to send ddr stats freqsync QMP command.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom_stats.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 6ee73268db1d4f69deaf4ff1ee8cc8e245b76f07..52b0f909bc4a365af77ca7e7fc7f997ce2c2be9a 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 
+#include <linux/soc/qcom/qcom_aoss.h>
 #include <linux/soc/qcom/smem.h>
 #include <clocksource/arm_arch_timer.h>
 
@@ -37,6 +38,8 @@
 #define DDR_STATS_TYPE(data)		FIELD_GET(GENMASK(15, 8), data)
 #define DDR_STATS_FREQ(data)		FIELD_GET(GENMASK(31, 16), data)
 
+static struct qmp *qcom_stats_qmp;
+
 struct subsystem_data {
 	const char *name;
 	u32 smem_item;
@@ -188,12 +191,28 @@ static int qcom_ddr_stats_show(struct seq_file *s, void *d)
 	struct ddr_stats_entry data[DDR_STATS_MAX_NUM_MODES];
 	void __iomem *reg = (void __iomem *)s->private;
 	u32 entry_count;
-	int i;
+	int i, ret;
 
 	entry_count = readl_relaxed(reg + DDR_STATS_NUM_MODES_ADDR);
 	if (entry_count > DDR_STATS_MAX_NUM_MODES)
 		return -EINVAL;
 
+	if (qcom_stats_qmp) {
+		/*
+		 * Recent SoCs (SM8450 onwards) do not have duration field
+		 * populated from boot up onwards for both DDR LPM Stats
+		 * and DDR Frequency Stats.
+		 *
+		 * Send QMP message to Always on processor which will
+		 * populate duration field into MSG RAM area.
+		 *
+		 * Sent everytime to read latest data.
+		 */
+		ret = qmp_send(qcom_stats_qmp, "{class: ddr, action: freqsync}");
+		if (ret)
+			return ret;
+	}
+
 	reg += DDR_STATS_ENTRY_START_ADDR;
 	memcpy_fromio(data, reg, sizeof(struct ddr_stats_entry) * entry_count);
 
@@ -310,6 +329,14 @@ static int qcom_stats_probe(struct platform_device *pdev)
 	qcom_create_subsystem_stat_files(root, config);
 	qcom_create_soc_sleep_stat_files(root, reg, d, config);
 	qcom_create_ddr_stat_files(root, reg, config);
+	/*
+	 * QMP is used for DDR stats syncing to MSG RAM for recent SoCs (SM8450 onwards).
+	 * The prior SoCs do not need QMP handle as the required stats are already present
+	 * in MSG RAM, provided the DDR_STATS_MAGIC_KEY matches.
+	 */
+	qcom_stats_qmp = qmp_get(&pdev->dev);
+	if (IS_ERR(qcom_stats_qmp))
+		qcom_stats_qmp = NULL;
 
 	platform_set_drvdata(pdev, root);
 

-- 
2.34.1


