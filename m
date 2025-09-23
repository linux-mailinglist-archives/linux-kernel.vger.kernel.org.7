Return-Path: <linux-kernel+bounces-828711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759AB9541E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE5116AB61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279F31DDBB;
	Tue, 23 Sep 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b="ZsxxleZj"
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A82AD13;
	Tue, 23 Sep 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.160.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619897; cv=none; b=e+puyIv1cZon4hlgkt26ZO3QpUBx9zUgsPUWhszlZ9n6K/9peVMsyjBSwyQw7cBXPMSfV28xHHckqqsZKbDCgWtXhsv27FWqF5GDYixqIh2n5LNJ2QzFuqdJh3yYS98G8u3lFtQX9fhuei8//tHjFERqQb/xaGFC4Lr8hbyQL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619897; c=relaxed/simple;
	bh=SK08o5jMmktq+j12ohAFj5YUuAH+hnUns+Ln37TmV7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGznxoJ9M5oOaNVLq8dw0+qmr/KQefa+qvRslgAiNHR8gt6D8pMbnZCugZxQz0oVcFqUMGhIH8MNEzlF6D252uWsju7TcNbat4LY84rOoztSJGnEccOb2LAPMd/FFGZyBoH5QnTejJGDa4Sc/P7DW0GUGCZlXpOFdn0CrzfNEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com; spf=pass smtp.mailfrom=monolithicpower.com; dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b=ZsxxleZj; arc=none smtp.client-ip=205.220.160.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monolithicpower.com
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
	by mx0a-002bf204.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58N58bjg1331671;
	Tue, 23 Sep 2025 02:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	monolithicpower.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to; s=pps1; bh=5BrRan
	ophlTOQzk7isMVjv+0gTzaWx6yYsZFutNEAL8=; b=ZsxxleZjVnndc4L5LAke36
	Cx6srhDcEx8y57x57VVsDC3Zt4xHPP2l7AtYw6qpQ0v3WI1/AbEB8WqnIYT/EjrQ
	x9UMFjKkX3zRTNTLrOeKQOf7l8wE7F7PGwV2ZySkvydU4Lo28V6NroObHkVtIosw
	f/jz1PePQ3W492BVOrinuA4U4louFSW+/pQdRRe9G7AkwLjYdI1h7wZC39xpN2kP
	qRVDyFwom29QLAbwzpRFW6rhbMh8HYnS6o2Put/rinTFYGJUizt/nkREsia6F/uH
	UT58IU3uIiYUA8qGQYYObVW+B20LqBMiRB3H9mWu+jn2jkHYHGzkWVyz3Dpnq7vQ
	==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
	by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 499qpnhh6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 Sep 2025 02:09:52 -0700 (PDT)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 mps-mslbn03.monolithicpower.com (10.10.10.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 23 Sep 2025 02:09:43 -0700
Received: from HZ-200L-YUWANG.monolithicpower.com (10.10.86.73) by
 CD-MSH04.monolithicpower.com (10.10.70.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 23 Sep 2025 17:09:38 +0800
From: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
To: <Yuxi.Wang@monolithicpower.com>, <corbet@lwn.net>, <linux@roeck-us.net>,
        <jdelvare@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <wyx137120466@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] hwmon: Add support for MPS mp5998 chip
Date: Tue, 23 Sep 2025 17:09:23 +0800
Message-ID: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
X-Mailer: git-send-email 2.44.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CD-MSLBN02.monolithicpower.com (192.168.86.32) To
 CD-MSH04.monolithicpower.com (10.10.70.213)
X-Proofpoint-GUID: ZQdgEHx8RNMO6yTs-B9PunW3UMzSt3j4
X-Authority-Analysis: v=2.4 cv=S8jZwJsP c=1 sm=1 tr=0 ts=68d263e0 cx=c_pps
 a=Zb4R73zfuCEKbQz3U9Wi8g==:117 a=Zb4R73zfuCEKbQz3U9Wi8g==:17
 a=Mn2HaNVs01YA:10 a=yJojWOMRYYMA:10 a=gs3WAU5GOovDNR7Q-woA:9
X-Proofpoint-ORIG-GUID: ZQdgEHx8RNMO6yTs-B9PunW3UMzSt3j4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA4NCBTYWx0ZWRfX16krY/DMJZn3
 MKdet8FyfAgfqlj+LSjv1o/oCrpv4oZlHObH3ML+HRcrRkF17F9VGIqYsezx2srgljxxo6gqges
 W+DA/YcqHxtglTfTtsQAzSNATIl0TLpW5mj7Ye/OaXqV+IiY7hADEwkfY9ctMCxEdum/lDg6eLq
 XWz8fQC0L9wFoeNSki/Tn2DvICbsBSnlvJW3tsclO4B2TGUshHmotoc03CB6q0F/dQy1jW0d+b7
 hAVZPtfSqZ9JXzOQ92LRpDmne0Vb8MFvZ5npppmT/7Q7YvJr8Ea85LWcYMlxQJh6BzWWNIRxvQM
 oEj37Rdl3g84wzDoWZGP+hNb9yi5x6fipUyGUwdaKncpkt3ZiNW5lX1sQQKAw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

Add mp5998 driver in hwmon and add dt-binding for it.

Yuxi Wang (2):
  dt-bindings: hwmon: Add MPS mp5998
  hwmon: add mp5998 driver

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/mp5998.rst                |  92 ++++++++++
 MAINTAINERS                                   |   7 +
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/mp5998.c                  | 162 ++++++++++++++++++
 7 files changed, 274 insertions(+)
 create mode 100644 Documentation/hwmon/mp5998.rst
 create mode 100644 drivers/hwmon/pmbus/mp5998.c

-- 
2.39.2


