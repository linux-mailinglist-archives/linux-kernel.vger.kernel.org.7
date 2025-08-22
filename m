Return-Path: <linux-kernel+bounces-781422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6FB3123A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D91CC7A39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B52E9EA4;
	Fri, 22 Aug 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQaeNILa"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF296224AF3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852570; cv=none; b=Wjq+CpUk15+8MMo9xVyyrphIMhBw50IbxzDFJKPOZMnYTaCf+jAJod4IKAx/pVuemkubh7ipggU3BA3zKfsa/X2xEghqGtlM7dhQAcND+S6M03ImUnLIc/xCiWamlTmfQ4/d1m67I/m9xj7SwsJw1hFMw1dVsxP8oiPk8r/IL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852570; c=relaxed/simple;
	bh=fx/zHCRVQHaOsBNUnReaPjpJxp221X70aISKE9eB1pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDLSgNAe8WNsP79jJgVz8/eo+sEJjDHgN+AW/Xuo6RnvRAIJPl+HvOM/EPQspBkIWJgVn5HiR/AFXS2KREkWZRuQekaUtYdr7TM8aJyxaxx3N+nnbJ3czU/OszZpPe37lyjuMV294CLN1DJ8uonVQnfdc5CUKWOTy19TWjFjudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQaeNILa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8mOL1026300;
	Fri, 22 Aug 2025 08:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=mPZVwvfWavV4HClz+jY+wxIvWkfG
	xruR0/gW4y6TrKM=; b=VQaeNILa9B3AgzWLpyCVVWiaRKtwnE4kf1D6iQXAoEeX
	METzk0xAAbpmNhxbUSpIjiGGZzDdsIKwXEIJBPYvmxbCwX5R8wq0MOSIk4U2V9NF
	xOyVkIHMWRWos+58SCZxp2wl7UzLYZviezlVlb2eREoiSFs1cMQ8ryK0IMkqRvcI
	s/Nt7aaHsrMNa2tGsysXyKYnEehXU2rm2py8CpAfK2t5f1RMwHCnZdzWxDiz0SvC
	B7ZVQBam7OCbCq0de5a7ojIGi2XN9NzcZ0aLGu3Hch5CxX5EF5gtmhPiVjBkmrFV
	NyW3k2hfaiyqbLkMaOt4jl5z27HeZHzkkAXqwfwlMQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vngyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:48:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M8mvMa024344;
	Fri, 22 Aug 2025 08:48:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vngyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:48:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M87Lkh031994;
	Fri, 22 Aug 2025 08:48:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5ycess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:48:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M8msAJ19005740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:48:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF372004B;
	Fri, 22 Aug 2025 08:48:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA6F20040;
	Fri, 22 Aug 2025 08:48:50 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com.com (unknown [9.39.21.51])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:48:50 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v2] drivers/base/node: Handle error properly in register_one_node()
Date: Fri, 22 Aug 2025 14:18:45 +0530
Message-ID: <20250822084845.19219-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7UGMZhipVthh
 Stkntuj7VehdRWzLVmeeIYhxx+ktPQmeIjH0hxbyqppNZ3hWEdvDOomTYwOCjTjuUx4HLPImmAH
 fyS+WmmBTuAH60ixmzm/z0ebD7a8WMtPdjl3HUhASVRqpXLgX5MLwTr6barBoNtFHRoaFaeskbQ
 llqZElV0MhUFD4O7cUESeYKJRo2c1rqBb7g+mzPPQyoKELr4qZHYbz/r8EY6JSApLiw+EH03UkM
 y0+cjHS5PZGGYkzf2gDLir7Mc09Jnxfj43QEzswTukwLjrJ/qSDPCu8WEbKGuz7yWEDS2fzBNkV
 HBmanuclNar8kd3l7KnbucT7Fczt6ROu6fRryj42ce+GTe35NzI3gGoyscj4ZpI/+w104889HXE
 RmieLP+bIEbn0aXrmILgYWdvc5aqTg==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a82ef9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5ll99_7Qev2jIdKbKUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0aVtIqSXgZCth1bRsup1cSf5pxWqzXqn
X-Proofpoint-ORIG-GUID: QrZJ9-yrqYdAn9qvjzfnpcfgC97BJz8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

If register_node() returns an error, it is not handled correctly.
The function will proceed further and try to register CPUs under the
node, which is not correct.

So, in this patch, if register_node() returns an error, we return
immediately from the function.

Fixes: 76b67ed9dce6 ("[PATCH] node hotplug: register cpu: remove node struct")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
v1 -> v2
Made the changes based on Oscar’s review comments.

v1 - https://lore.kernel.org/all/20250702112856.295176-1-donettom@linux.ibm.com/
---
 drivers/base/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index c65b4917794e..1608816de67f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -883,6 +883,11 @@ int register_one_node(int nid)
 	node_devices[nid] = node;
 
 	error = register_node(node_devices[nid], nid);
+	if (error) {
+		node_devices[nid] = NULL;
+		kfree(node);
+		return error;
+	}
 
 	/* link cpu under this node */
 	for_each_present_cpu(cpu) {
-- 
2.50.1


