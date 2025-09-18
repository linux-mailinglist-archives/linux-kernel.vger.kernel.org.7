Return-Path: <linux-kernel+bounces-822103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444BB83082
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6FC3255C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611D2D5C95;
	Thu, 18 Sep 2025 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gk43Mya7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3528F5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174141; cv=none; b=axRpQRoyA0SkzB7oNBzceyvYOiMBml9PjPmhC5LLKNXepv3K//sO77zPkDdDVlVjUV2YFwus1+nlECXiq2BmBml3UIzldJ84+nbr/xgHiDGGv6fOlJopoY4tUcM/gpeim6dKSt73hOj+HnZyGzXA4+Q2JwquzIryF39t4AWKim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174141; c=relaxed/simple;
	bh=GFIX6ah5vvMx9jnt+SGp7prQxnbTMudHgL3OxkEbacQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALDRx/qTjOim9PfPNlQGOvDXnDb+hnkeQFZSOXlTvZBbA05wzKeFz8tYOAxPV4vFBBsfotGruMTNVx6LR2BOMSkhnO2zcJaSh0GE6tFshBsSoeOx7hue9mUQsr1pr/A5KzXhYG/a7jtn+yCiDq+znJUvLiOCDOCLg9ok3xki5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gk43Mya7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HICOo0031226;
	Thu, 18 Sep 2025 05:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OBKDixxSjT9l4K8ggAIuPhppYH3mz6c+uzt5X0taD
	P8=; b=Gk43Mya7CycMMGrFXDyvFLazPFln3O0efxiRrTTyEeJlaXkxhwMyzXcYK
	CDJV3F9rwkJxXF6M6AexeESgZjAdnv24kt5SlDCgD4y9FAcHApUXhfRDBpc0qKRx
	Teh9rc6v6GUGVooaeUFse17glud4v0Ml7Td4MFvwX6UlPduSL4wVe1xgUkF4ky56
	4WsEnWNuPmamTaXQTlEJbk6OjHh9uA+gLjZPh2JjtRKw7ICHu4I33QNfVRDrj28X
	jtjJjWZgW2Z2aoTHW/y9pmlc2Yvtj/1pHYeHLpLh8NLWI7ClzybT5WXaMN1L2umC
	amWbfKq9auVqDu8oedeqHVUVzcslw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hr6f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 05:41:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I5ft41020814;
	Thu, 18 Sep 2025 05:41:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hr6f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 05:41:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I29qA3027349;
	Thu, 18 Sep 2025 05:41:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495mend029-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 05:41:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58I5fqmG19923348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 05:41:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4865820040;
	Thu, 18 Sep 2025 05:41:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E55620043;
	Thu, 18 Sep 2025 05:41:47 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 05:41:47 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: akpm@linux-foundation.org, clm@meta.com
Cc: Jonathan.Cameron@huawei.com, alison.schofield@intel.com, dakr@kernel.org,
        dave.jiang@intel.com, david@redhat.com, gregkh@linuxfoundation.org,
        kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, osalvador@suse.de, rafael@kernel.org,
        ritesh.list@gmail.com, yury.norov@gmail.com, ziy@nvidia.com,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH] drivers/base/node: Fix double free in register_one_node()
Date: Thu, 18 Sep 2025 11:11:44 +0530
Message-ID: <20250918054144.58980-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fd2goAVEEdH8ru3hzgPbmf9ZS_NUOEPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX/Kvmx8lXMZAr
 ESMuGg4RK6CyQ7Er4mqCCEkm+upkNw+TY9Yz532HF9AYdUfYMO67DoKG0zGncMmJZKtHIuayWk9
 rvEJsnWHtzlitNsERaKujevkNjUvXHz3T3SFKdX3PXZLc1X8x+Dg7albq4tZ1CD6wXEmDDKxmG5
 YAohK1fHAhDGTxhPHq/tYku2zHxWMITUSFx3+nXDM38aYUe22ZfFP36FR+Bp7xwcvbwsdWUB0mj
 sEXcT8uclieEamy2opwGcC+86u8AVdeH9ls8Tf2/JeBKhxxLLJF14ccrSaCsc6LRJm1ujBb7GjP
 pox+oCQ41NdLz+c50CjtivCQWZSe+q+tmtYYro4pcNDz6J/AWL6u3+9457gd9cGUCB7JW5taQ2F
 Kkfs6K5z
X-Proofpoint-GUID: 9dkO_JwuQlghnLk9u7i_C_STFIa2wwFr
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cb9ba4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=U0bHb1oF5oj0ebd8ssAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

When device_register() fails in register_node(), it calls
put_device(&node->dev). This triggers node_device_release(),
which calls kfree(to_node(dev)), thereby freeing the entire
node structure.

As a result, when register_node() returns an error, the node
memory has already been freed. Calling kfree(node) again in
register_one_node() leads to a double free.

This patch removes the redundant kfree(node) from
register_one_node() to prevent the double free.

Fixes: 786eb990cfb7 ("drivers/base/node: handle error properly in register_one_node()")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/base/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1608816de67f..6b6e55a98b79 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -885,7 +885,6 @@ int register_one_node(int nid)
 	error = register_node(node_devices[nid], nid);
 	if (error) {
 		node_devices[nid] = NULL;
-		kfree(node);
 		return error;
 	}
 
-- 
2.51.0


