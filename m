Return-Path: <linux-kernel+bounces-848757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168FCBCE81B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C216D544C29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D542F3638;
	Fri, 10 Oct 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQTIiTlN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2F18872A;
	Fri, 10 Oct 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129064; cv=none; b=UhlPa0JB4y6QeRD2wdtSg/ioAnNzYmp6Kp9Ero3EPpA9kuhOFUhYs4FBS3AuiwAb+uB3IZZeA1z4wQnhOMlyOHDxIVPlmMyiMcCJvc60BY2ZCP3EGk0IJOoppiktxgx6s/OU7EW/smCrsN7NyJB/eNWSMwM/uktiqsfww3bvVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129064; c=relaxed/simple;
	bh=AmACX1L3O3Micl1zV5BG913P9u4WWgLhjIGb6Q+xKy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbA/QFhw0dT8dx1UH7+jekvo4J9kiOgP0z1XMODuL2WD4gMYK/vEG1NItpZjchzC8kblrJFMcJYo1R9rSk5bnma8wHPPvhcjGlI+Sb8hDj/MVGuVOUX6dL0rJRNZFlWfp9GhMVlp/hdEKKDfu5P77F5xxJi4ah/tTQjNV6IDfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kQTIiTlN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFtwFG011662;
	Fri, 10 Oct 2025 20:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=p6FSTZMWwyv3y7/oFJZxNQ8Uo2RFV
	PeerJcAGhPqIsw=; b=kQTIiTlNPpySb3nfgxBxG41ypOhX8P9Eutrbxx3bzYumM
	zQi5f9LNXPtWEXcwxe/mhfWK8R3AeXfoqqdYHMXvDv9OBCRzbHZ8LZNSOncJQfGz
	8A5++C72joWycsRGCI8uWR6ZQ2022zYTTqw+L3AnvWowB071dQckyKwjiOFZF4th
	c6EKR56GBrpzqm7/Y4aeDn6B4xuz1snQsSHKqo1G7XYYKbi103AVRoqwl9MqLNLW
	D9quD+cAi5FL+Vlkz5q7ZbG721BF98lxHb7fwDxUdMVPTZDmtSRtkJYVP20Hk+dc
	kZ26+kjtBhc4+E9U80B0qWSTCODxwUTMHzm8ctToA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6bcgcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:44:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AKN2Zx036578;
	Fri, 10 Oct 2025 20:44:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv69emwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:44:02 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59AKdKHg032417;
	Fri, 10 Oct 2025 20:44:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49nv69emw9-1;
	Fri, 10 Oct 2025 20:44:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Cryolitia PukNgae <cryolitia@uniontech.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] hwmon: gpd-fan: Fix return value when platform_get_resource() fails
Date: Fri, 10 Oct 2025 13:43:59 -0700
Message-ID: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: LlrRznzQaLGqbnPiz2jNIoAZwetU6Jui
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e97013 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=NidHIJ8EfkdNFoYrZv4A:9
X-Proofpoint-ORIG-GUID: LlrRznzQaLGqbnPiz2jNIoAZwetU6Jui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXziYO6zCPB6NR
 zOYjpE1totk8dijegC6ZSCPQ6FUVW2Dp0wbq591yabwYjRA2Tgimk4t18Du0z1kLb7KpGfJVFM1
 UafIOQNWFqbbWHBeYhC9+XepzG0oOcXDA77566cApTrQ2oAjNf5JUO5uS0iqIFJf8or2tMOVdKz
 AxnDcHJUTJA1jwkGft4k3f/S8INqboSIv6+U1E5sW5jEUt/sNLFY/0mnhRgWPqIehJRMszl93jP
 gTb8rDAe5ggPK1cwub3jxXlveE7d6TOwx0iNanUGdKa2wh31wUn4kItgu1DjdGuMmbxHCb1hKPX
 zqftOiabY46yhfBOizpQpQwc5RoNBJ50sGxWPTzNCWgye25i0Uuup+4f9gnN0FPDD4KUPqg14UI
 lckh63zZ86Greicvm8LzEfYWTwsFSQ==

When platform_get_resource() fails it returns NULL and not an error
pointer, accordingly change the error handling.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch, only compile tested.
---
 drivers/hwmon/gpd-fan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index 644dc3ca9df7..eebe39ef9677 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -615,8 +615,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
 	const struct device *hwdev;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (IS_ERR(res))
-		return dev_err_probe(dev, PTR_ERR(res),
+	if (!res)
+		return dev_err_probe(dev, -EINVAL,
 				     "Failed to get platform resource\n");
 
 	region = devm_request_region(dev, res->start,
-- 
2.39.3


