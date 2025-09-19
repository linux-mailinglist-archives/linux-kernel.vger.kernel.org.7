Return-Path: <linux-kernel+bounces-825061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76679B8AD38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703C2164BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76389322A26;
	Fri, 19 Sep 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohk+ioKN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BD3054F2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304231; cv=none; b=dA07i44X00D2fHdJ3hSK9ah34EJwq0XSCHwvkwghDUbUqJOZ+njuPhE/1DOwmwiDDeUYiFZXTeWz2kByQcZOIoHqQtxo4e+BT/yRDKShcb+tmEPLlTQRcuOkJP/UeN3wxG+ksPy6pblGo0VKDebjjoIQHyKz5jTh5lJ8IZxhOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304231; c=relaxed/simple;
	bh=/mPo8lPIeMUbMiGlkP38hUb5Wg6RHjHPXXFrqZymSjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t7gY3mdgdfqjIgtea9o4jAdzl1+EnesQDwkWn6hfa7aW6MQPn7YK7xJr5skY712cgW86mRKHxJiWy7UNHKZR3DmhMWNFd7nH6+U4x2mk87u0+Cprs8RdU012WG5I7WIYNrYGvWFhCk++CIYy6NdJvGMRz0oEZyjV4fiowg5Ic1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ohk+ioKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9Feif031000
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lUVhA5pzXz07jeB/n45m2bQF4wRz5z2cLhx
	Sd7PJcPQ=; b=ohk+ioKNN2W3E6EOYRZBoPo4r3rQDfby/DuHAxFp6dCus+XrWMv
	Pi1/LekuSehpupAOj1hi52L3UpgJ7UCpt6MQ2ITe0TRGoazdcUn1Le+Da+Y2ngSS
	AgIB59giKn0RBQZ1WR+wVZQ3mTrRb6k8xfGd619saGYQJb+5IGR04lZvhZfK0vim
	p23uD/9DBKVnBwhCimf9lQCE/hvo6jWg9ODvF5Fy4Ta8OIqeZjlqM+xZDcenl0xS
	jJKgK/NK8xaQau+qaVIyG0N4jTsHAGtLFYun7HOcbDeOcbQxP44Y5qt/ML5iANby
	jWZ1ognNFU5IWzBufFlvwL/nempJvjWKZ9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy139yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:50:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ebc0319so19625455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304228; x=1758909028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUVhA5pzXz07jeB/n45m2bQF4wRz5z2cLhxSd7PJcPQ=;
        b=g8A73/ZP/vL9ndCXM4wky11rAZ72dg3HtXn81c42isJDV8G6Ox5fYma90IBLOkK6HD
         IyOoH/RutzZm4p1rG0NEZHfElUsus1z37BlZq0UccCp5kCB29TX0VOX+c+DA9PC11Ka7
         pes1+RYKn5QdKAbzMgL/50BGhCznk7Wt9/2T31MFRCYUwtc0dF1uclkUrNw5Zfiy8OsL
         P/187BhJr9bbhI/WED+fkrHyUmOxoxFz6BFgqarbtpNiAl428I/zhHO8i/W5jCmlhDw7
         KBzd/fxnbn58aEhvod3DVlR312B/YHB1+Xnh+F/795KA5hvf1jPz+5imFBcSaUU6iUKx
         MASg==
X-Forwarded-Encrypted: i=1; AJvYcCW2/+t7d9cp+FesQyedeZyYypeFeE+wq0glAqKkeR5WT5+7sKA1NyG55thH3z4ISHeLi3CdBPG6xAV3nqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30VyW+HmsDxLa8eCFWc0ACvoyJn2+eIpHdux31zQI71S7uhGu
	N3jxOLyn6mXSoTgZRWMqNxW3duRm3N0pBuCuFa0A9iKJrgnxCgLDtRBCiFAjOjmL1/JrGOs4d14
	67c6LMZw3F/r2faPCxrjqnTCThb5YG+42BXjCKMPjP6VqSTUuqVOs6zJiByf5NJbs89s=
X-Gm-Gg: ASbGnctWBV1KtESS/tpJW9aeU0bxhhAkkfvJrazWYVLNu2VJEB7ONMH3hS1pZ/PrHa/
	T92E0+rDvb5ua+c8LhYAgJDSAmrJgnaVh731RPdbajuSha1rwY5EbbVY21Xly8mREjqUtAYaTml
	7pi+U9Rpf88c0poUSuEvvG/NHr1WT6NIIx+g4CNcfglPKcePJvg+WBQXgf95+N6MU0NyuUU1Evy
	s2LsYPAUFlNgYVMeszmSEggP/9W9mDTd93UxXZdZaYxmg2R/bGJE164WJLhZ7ePU8EWIcS7bYMH
	mEyM3OBbCac7znexfKc1zmKpoFzJAERa37eFdKqzknjQLqmvB4dZWFyOCmivmbflVLM56NAPLrq
	JYbZFycF/7EzM4cLE1GUakPeooU4=
X-Received: by 2002:a17:903:1b6c:b0:261:1521:17a8 with SMTP id d9443c01a7336-269ba43dfffmr64056355ad.16.1758304228075;
        Fri, 19 Sep 2025 10:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Kzie8oSdOEBS90XbtwiLTvrynMSVegeI/TKZ5eJjg06eMYGr2szW6HyTo08NoA0zM8CkGw==
X-Received: by 2002:a17:903:1b6c:b0:261:1521:17a8 with SMTP id d9443c01a7336-269ba43dfffmr64056025ad.16.1758304227603;
        Fri, 19 Sep 2025 10:50:27 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26876ffsm8970468a91.3.2025.09.19.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:50:27 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels
Date: Fri, 19 Sep 2025 10:50:25 -0700
Message-Id: <20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EJdDXW_se3ROOkvF0iFLPKNQ4JmJSXfb
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cd97e5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=U2TDSMueiEXJ_JPGoVUA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: EJdDXW_se3ROOkvF0iFLPKNQ4JmJSXfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6GBixvYQroG2
 X1lVxdkrRbhIk9u29fBGpcqfptD7muwE8xw+wO5ICBqE5yMbSQ/CaWjXSEe5+pwerxf+1khFUGz
 S2OQlktM/9ejMLWVLo27B27WIDmIPmzsR7MY0pf2NhfEi7jIwRcIi9kPsRvDF3OPFMI0RcegbTY
 A2QCaO37NJ29EmuU3PY96h2T1C4/OZ7McIuk2ToWK9hGNPS+HWTGMKnoGDT9ZItWwcGGODtvX34
 6ZjBcLMPgYgXfAM8Z2KQuqDT0KJh0UWEIoknvG9lHz48h+5wG80QICY6BIP5IEjyXg5kclEbrab
 E2tuymL/QiVlRE3EQAkQbRj7shN1t7e832wOmj/tnhpYU24P7Kvd8EpQy9omF2lilbU+zqnMdhN
 4zVjxvT+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

System On Chip Control Processor (SOCCP) is a subsystem that can have
battery management firmware running on it to support Type-C/PD and
battery charging. SOCCP does not have multiple PDs and hence PDR is not
supported. So, if the subsystem comes up/down, rpmsg driver would be
probed or removed. Use that for notifying clients of pmic_glink for
PDR events.

Add support for battery management FW running on SOCCP by adding the
"PMIC_RTR_SOCCP_APPS" channel name to the rpmsg_match list and
updating notify_clients logic.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
Changes since V1:
  - Updated commit message
  - Removed enum defintions and isntead using booleans
  - Simplified logic by setting pg->pdr_state directly if pdr is not available
---
 drivers/soc/qcom/pmic_glink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c0a4be5df926..627f96ca322e 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -39,6 +39,7 @@ struct pmic_glink {
 	struct mutex state_lock;
 	unsigned int client_state;
 	unsigned int pdr_state;
+	bool pdr_available;
 
 	/* serializing clients list updates */
 	spinlock_t client_lock;
@@ -246,9 +247,12 @@ static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
 		return dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
 
 	dev_set_drvdata(&rpdev->dev, pg);
+	pg->pdr_available = rpdev->id.driver_data;
 
 	guard(mutex)(&pg->state_lock);
 	pg->ept = rpdev->ept;
+	if (!pg->pdr_available)
+		pg->pdr_state = SERVREG_SERVICE_STATE_UP;
 	pmic_glink_state_notify_clients(pg);
 
 	return 0;
@@ -265,11 +269,14 @@ static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	guard(mutex)(&pg->state_lock);
 	pg->ept = NULL;
+	if (!pg->pdr_available)
+		pg->pdr_state = SERVREG_SERVICE_STATE_DOWN;
 	pmic_glink_state_notify_clients(pg);
 }
 
 static const struct rpmsg_device_id pmic_glink_rpmsg_id_match[] = {
-	{ "PMIC_RTR_ADSP_APPS" },
+	{.name = "PMIC_RTR_ADSP_APPS", .driver_data = true },
+	{.name = "PMIC_RTR_SOCCP_APPS", .driver_data = false },
 	{}
 };
 
-- 
2.34.1


