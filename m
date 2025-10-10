Return-Path: <linux-kernel+bounces-848758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422EDBCE823
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67E6544C23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0C27A917;
	Fri, 10 Oct 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WD8HOpA4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2771142E83;
	Fri, 10 Oct 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129109; cv=none; b=YE/qid8a/oMrbynpgSci3lUyhYbc1NAVI4NeWGYZU2ua7HSFecvAJmf2eNV7xtIwBr4irow+UtbGWDTK8dGGphiteJNIqn6svGCSiT6jbHwAnwavRDNWcgvipVWQ65/wz7fOhIPEAh1yi32FF+BAhI5TGE0VZ9UPoT4b7qWgoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129109; c=relaxed/simple;
	bh=Mt15IM7GW0j4CLPKG7zaCYm3wL9NawpjzSf872S2qmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zt3ue0fQa/xWzCi5Dg/v3YBivnjA+pGEfTykFvYfV+WPuDxXzS8f08ps5c8RWXDCK+AxSZLm+Vqc46RLoc/11dw52d7tQwxT4Yw+Xuag/lWPzlG7x+ENwZLDRnIbrNEAk+78ObhAYjJQROUu3OuI8yBxEkSEm1anV3lkbU4b56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WD8HOpA4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFuINg025383;
	Fri, 10 Oct 2025 20:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=976nOAc7s6H7MRD/aQvTBJGOi6XfW
	tjS4WQSSBpWEGI=; b=WD8HOpA4QEptVCbzwn4D848OvPaH/yRy5rX+tt2rFuI0x
	0a2IjK4F+tpZiXm54QwlkYkIqQqZpojfxvzOleSfiafZ0f/J7yEJZRcG+sSIaNOw
	A6Un5FeGtp4+J+YUPvWOtmXK4EiIAuKw5zq4ZBKppysN34WlE8jgVHuVSqHWfBjH
	nAsabhBZvtAb/P8MayLpDLZs6AJAgeRSmAZW5AoKdMIP3sSLflQ43jIzVWaPyNOn
	ZrWS/jElz1QxfdxNLvK0KW3WZiyEPC4SvOYbbn2WOl9fDa1Au3uwdF3U+KfEnG2e
	76Rcr6jH2hQJONdERMz+wAasTtIpnkrdVPfEDZUFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8pvhd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:44:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AK0fYZ036698;
	Fri, 10 Oct 2025 20:44:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv69enbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:44:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59AKintn003774;
	Fri, 10 Oct 2025 20:44:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49nv69enbn-1;
	Fri, 10 Oct 2025 20:44:49 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Cryolitia PukNgae <cryolitia@uniontech.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] hwmon: gpd-fan: Fix error handling in gpd_fan_probe()
Date: Fri, 10 Oct 2025 13:44:46 -0700
Message-ID: <20251010204447.94343-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100119
X-Proofpoint-GUID: VLJqjperGGul7HTR3A8WbdflLpXMiyiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX7uAZeJkTIO6E
 pjMZjuN5f85z1kVPP7CkP4faRktcOrcclfyZ5KtYFvuDnoBkyH1pr5YN4/2rgMjtm8A8OB7+pDb
 5YpFXxKShoyy9EIVH5mYeUn8Xh+lhAeQB0nie+rmCy56TrE1pDLZclcKMAy1UGJP35gqezOScXn
 sPmgy+G1+NUyp8KL99gwbOYovis5nGb06EEdJ8Xzstl3gfvTXRoB3z2Ihz67yB6cFUQDj8WOXky
 b99Lu/sQDfvtkfd1PO0WP9UjtCxLM1jjktRszAJ2H/U5MbA+rv0quxELtwQIif6abij02EuIgJ+
 UBp0cv0hIh/Lxs+qbVF70OJrqLTmf/Z0R9nRKu1YkKRaBiul8FcANQGcERIqy6PZD6V53quLd2C
 ZiaO+e65qNykjElaKCn4DYZqe3ziPA==
X-Proofpoint-ORIG-GUID: VLJqjperGGul7HTR3A8WbdflLpXMiyiS
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e97042 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=3FsyAyFuyTR6OhSxi1EA:9

When devm_request_region(0 fails to get a region regrion would be NULL
and devm_hwmon_device_register_with_info() fails, best to propagate
the hwmon dev to PTR_ERR() as opposed to region.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch, only compile tested.
---
 drivers/hwmon/gpd-fan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index eebe39ef9677..321794807e8d 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -621,8 +621,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
 
 	region = devm_request_region(dev, res->start,
 				     resource_size(res), DRIVER_NAME);
-	if (IS_ERR(region))
-		return dev_err_probe(dev, PTR_ERR(region),
+	if (!region)
+		return dev_err_probe(dev, -EBUSY,
 				     "Failed to request region\n");
 
 	hwdev = devm_hwmon_device_register_with_info(dev,
@@ -631,7 +631,7 @@ static int gpd_fan_probe(struct platform_device *pdev)
 						     &gpd_fan_chip_info,
 						     NULL);
 	if (IS_ERR(hwdev))
-		return dev_err_probe(dev, PTR_ERR(region),
+		return dev_err_probe(dev, PTR_ERR(hwdev),
 				     "Failed to register hwmon device\n");
 
 	return 0;
-- 
2.39.3


