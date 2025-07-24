Return-Path: <linux-kernel+bounces-744046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C96B10758
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92464AA5502
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7125F7A7;
	Thu, 24 Jul 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VObaBVfI"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6825D917;
	Thu, 24 Jul 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351438; cv=fail; b=qN73pyTRg++bB0HxbdStiTFPOrXPCQL4hzi7LwibuIyHX85AMCRWtwxN3ZCzu5eev47EtTJ7/rgsp/vXwvqcF9S1+x1wgXpSr+Sf6INskIgErPARR7jPnlVUni5UclZUZyB1DJZl0a5X8aEPz7/0c/8SHuk6O614t9OCWz4s/4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351438; c=relaxed/simple;
	bh=qeBlX7xCEeaLhIgtkWiMBBq/0nb0KeviNDOrJlANYJA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZgxonYZvReXoeNE/u07Ipahb4ogOceFr8mcE5S19xWeitCFn/WR8MuSKNgH2kXHq4wmG4pTacYRHsGz4LS9Zedul71KjePxYwWxwB4cA1TEW5wQWxuhWsj4TYYrtOFLK/ypAUDFDB3aqLDoXyq3CX8OFWspW5bHhV6d+G64KLds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VObaBVfI; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbhNxJWIF1MrYq5nJCS2O/2tk3UNZGiBTrdKzYpsd+YqJHzChIexe0IaEovoZqj7nbLzOp1ZstJYRMCSBHlsTCRZT+CRYw5UVZLj1UKlkwMDopZkN7ZmgLmrzkLJSl1T6Vzik2dxb2h59mnP0v6F17IL0QPiYxoio+Zfj3jCEM0uhKaOpJtnnYqGRiuH+FxvyHL0TikJc3ejrvxlNDeLIQAY4xgc5xuypQERus8GXtuQz5YTb6qkSPWJi8k0zd9LvuGF4F6UZBWbvUuH66rhjiBJrKjHGQY34VcKdfjpTOiXg0aC5Vx2beSw0pjkHiUGhyVR3JVYD8bEhHJ5GOBpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG5hT+4BdeVuinmzk1A04/1Fwa2hyep27irUc9ksL5w=;
 b=qTjAGWjn0Pv0/EhEC4V/TAX4gQ+CXvwStT69JHC5x1e7G10VLsXlw1Ww9smR0JGEpREC/myikmvCOgaTk3eXFWVdlhR+Bn40RDZe/UFPVP8B/PkZyRiD6iv6+f9WzCBnHcAFhOFeq/4jg97odXKxkv3kInf22VeXUFeyh2cACfpmkJtiRWGszsbObj+KxSlNlV7vn35fVwv6HqMjtH/lMSg2ahyFamPyltOShXKPb6NygQgIfPTD8cMNj01w7fZFpcOa1WKscoZd0bJ+thINeMcQHAhinPws1t8yrVtz0d81vBseOGP85zcVxSJkXPHo4y3IWY+sY3z9QxYYO4kx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG5hT+4BdeVuinmzk1A04/1Fwa2hyep27irUc9ksL5w=;
 b=VObaBVfIjey3Pehvb/ngEeZN0ruBmxN4qCckguFp2/LBkk+olZrGLE6siJnIx8CbGS5tcXQdBXZJqAElFNVOzMyxGpShDSb0hmGiuVmsWHLPBJgJzJg1rwA9yx1tiBzl3GU5H+9sMADBSMMmUjI7fdOVOL2j/zNbXPmNv+Vu1urkgCkRPtSZqwEcdKCLoupB52Rq/Mq/T9n0V1zIAzEnItdUZEha9D26fV4g1JV0XdJwy0Ccom/qIu895HH4zGm4SmkfPERkAvzKxmJNRacB2M8zt0C3hzz71HSQQHdAQh0GrRhB9BpohXk1d1IdcVKaG0UYEoSFrkSRdLE3c0UEFA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9312.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 10:03:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:03:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: mention MIT license as a compatible license with GPLv2
Date: Thu, 24 Jul 2025 10:03:41 +0000
Message-ID:
 <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250724100342.16850-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB9312:EE_
X-MS-Office365-Filtering-Correlation-Id: 540a71f6-d222-46f1-8419-08ddca9963b7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|15080799012|19110799012|8060799015|461199028|5072599009|440099028|52005399003|40105399003|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IOU43z3A0yhHSeU0NOMXQEwfMxtz2k81G/U0W2JLdcI7zNEjlP+tByHY1gia?=
 =?us-ascii?Q?H7w0F8jU4cJXZCd1yHXABzBQVafBD5uo2tsmtFSTnjd0HEddwPTEWsDCSFoa?=
 =?us-ascii?Q?EJpqmXqWQTNO+r0HaYRnQeek5Uncdym70dfnemDK/gFDwhgsIj/bQd2CzI+H?=
 =?us-ascii?Q?d5Twz0QGbmuq0wEzMbWoM0V/gpqLrzKVMqHTYTMW3C4Ht6wzoqBSSfBuZDBg?=
 =?us-ascii?Q?xTbAQSEHXvKmZMLn4+XP0AvotJRMli86hepGtJe2wfQymRXpI6WyIYocK4/O?=
 =?us-ascii?Q?D0fW5x26hNm27fEDjGOgLEszEuAvBDhxioFvuvmtnWLxPgYpuzMwKUr5TPGh?=
 =?us-ascii?Q?QQrKIeOhQzZVlIOjIqnf05hWaO92WaCLZjzQEb67bWML6QD2+jpPBsIEWC2n?=
 =?us-ascii?Q?m+Vp+b+YqexHcaqwwkheA/HJdxth0me2B7XfKjt6ND3XfMdmseCLWzXVgYzC?=
 =?us-ascii?Q?VJ34Smri1TgzBPPUxBTon57SLgy4c4navy1jw1rTW7pKf9AvctF4JR6Ku/HL?=
 =?us-ascii?Q?3qVFUqaKDJ0DFNZzeAMbF7y/BbByJc9oSORlwl5srQhaXtCjzzfKSuu8Sw0A?=
 =?us-ascii?Q?byfrmjTSSMTHHuVAp+0Sj+5V7EFrHuqDc5Zz6aia4DFlTOsMMB28j5NzJhdn?=
 =?us-ascii?Q?Kkk96kArNl1o9iXu9BtC7NNKFA6rrB+QWLkwEmFKZSoqQNK64XMIwBAAJhKw?=
 =?us-ascii?Q?a9ZlSc9Za165ejunTd6ROrlOX+qs9ZLwiOZeRYcp2n0fiUIuGcIeKxPFjonw?=
 =?us-ascii?Q?GJccHhEJtMODaLJ47hqjjAwOm5YsK1XyJOR1YWSBdN3gN09GrJ/Y5u8uEJ2U?=
 =?us-ascii?Q?I3gblar5qekS925M3gIRXRI4IJseLen/qPtwatg9dPh+QiNEAg/4RwfYUSRc?=
 =?us-ascii?Q?yE0dnS2No9oK+FkEYrG3nYMAIs93/La6Q02YcD3ZJoTjNzAGqvFsVWkHDx4w?=
 =?us-ascii?Q?x18yCJZajT3ATIVsCl07hkARmJDKXZXyb/zKGhDJVtsYIda9O76Eflj3GEGe?=
 =?us-ascii?Q?Fs2UKbQqDAJs2d4U7g4ImtTn6EBAMSnAeUuVHD5ZzQrGOYFYLM2q8avm/qkc?=
 =?us-ascii?Q?2V3qN5NFpD0spY3HO22jhNcZtSCW9hhb1919TxrvgvSqYKup/0SX6hW1je3t?=
 =?us-ascii?Q?RRe2mV/q602k+z2po4W3UWtDaenL9GFkLRxr733Hai++7lSxO3rdgn8dIL2X?=
 =?us-ascii?Q?2U1sr74ipnWe9FzCzNIAxd8LNxrgWqujzS4fLA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PCI6bPZuwbOA/EzDhWNtwr22ILqomhhj9hXZ7RohyIVUIvu65oBL15JbBon?=
 =?us-ascii?Q?zJ4/bctZOYxAALUvISiKrf06kNywYCw3Vpp8jniZloWNWoG3nmpMkOFsxpIh?=
 =?us-ascii?Q?MKhcr/f4LNFbCS5uX8xYk4n3F/h5gcA9HEOPN2QzKQ31/UeFCDz+MRPdRiKO?=
 =?us-ascii?Q?TH3E9XyTfP+ybO9SytSKScCMnO/+VvmNJe0HCNgHx+YVdjjiQhNTZLyOa+DN?=
 =?us-ascii?Q?UmT3HO+vKvcDnFZvEzXsJ2KdgawKiMYR+80Ok/vNij0aI5HFvRL1phfgLXq2?=
 =?us-ascii?Q?ayN7BCHplbeMJ2DYp1M8ONXmiP1dMVLu8962ru9BkDOp+dUguqx0UL/cdF6r?=
 =?us-ascii?Q?0qFmUqV0VxXtaDbfmgIicE3Dpe4q6nYWiZY1YByns3iCWJqhYMCtbBkzAuSa?=
 =?us-ascii?Q?gfjfaPIxNMRyDxkvvRlY+4lqPhdHFsRmu1PUc4CZxOjee4M87BBORooY7iQI?=
 =?us-ascii?Q?S7lbL9dDoI7rwbiDXkmJFHSmulumxErg7qEFhFPckC1BpRXskUZy6j+xBycO?=
 =?us-ascii?Q?b0s6AdSHtc4Hy3z4oIecquy2rWXveFYGHCJe+5olyMFb9IwtntVO3q2nHN+r?=
 =?us-ascii?Q?RCC/uMpaBLZ8KZMS8a1dupMebIHJmySTTtI0TeZ4yvVXCVuGXwHzBfWJra+x?=
 =?us-ascii?Q?ojT8sefeALg0qm1n6Esb89DEwOuzauAxOC4PcrtU4nApSdlLdm7UB1NkYgqP?=
 =?us-ascii?Q?E0Lnvxv0hoKWM2Yi5FxyAsGZqBCx7bY33kp+kiBWVK3ZtR78cm2SnnwxzeHx?=
 =?us-ascii?Q?zjWH3TLROwgO8G43dSAWmo4xZQiRowUcmGCvqgkS8Z7gEgm9EqmcXhCEfpan?=
 =?us-ascii?Q?bPxXIdvKT3ea6f/l7kSAnSaXXPrbbD3CtAw7u3OtbLmg6LDNuhE4U+kW968Q?=
 =?us-ascii?Q?3XjrwWjCOI8BQ+JA/ndPLHf76HFd2YXzI12iSRFRTUvQ2UIR3I1UmebHYNpI?=
 =?us-ascii?Q?9XAtJe3MORg5siRpBgMMdq8garasQHxCXCA8amIWcHlWP39f8r+i3HcraJHk?=
 =?us-ascii?Q?lt8a7dT4MmkQoukjUzpMYWZFcbPeHArZYlWCwoT+Oq60Si8DkPULvYCngRwv?=
 =?us-ascii?Q?qHBDi1svG/35PFQuk74Lbqq/M5en65R9Z+ejCVksx6euswyb+5labYYXc5GZ?=
 =?us-ascii?Q?g2LnGFCH1IZ1W4hZriMIoY0Sh6fRzQv2UbSNIXIVQBA8oC83/bZ5sxjhkpG4?=
 =?us-ascii?Q?eSJooaGGBWaBHvHCuuzhg1oVreRkq6CURigEWDa4nTdSCtxWdnPo7hJm48Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 540a71f6-d222-46f1-8419-08ddca9963b7
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:03:51.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9312

MIT is a widely used permissive free software license that is compatible
with the GPLv2 license. This change adds it to the list of compatible
licenses with GPLv2 in the kernel documentation.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/process/1.Intro.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/1.Intro.rst b/Documentation/process/1.Intro.rst
index 25ca49f7a..c3465e3aa 100644
--- a/Documentation/process/1.Intro.rst
+++ b/Documentation/process/1.Intro.rst
@@ -235,9 +235,9 @@ code must be compatible with version 2 of the GNU General Public License
 (GPLv2), which is the license covering the kernel distribution as a whole.
 In practice, that means that all code contributions are covered either by
 GPLv2 (with, optionally, language allowing distribution under later
-versions of the GPL) or the three-clause BSD license.  Any contributions
-which are not covered by a compatible license will not be accepted into the
-kernel.
+versions of the GPL), the three-clause BSD license or the MIT license.
+Any contributions which are not covered by a compatible license will not
+be accepted into the kernel.
 
 Copyright assignments are not required (or requested) for code contributed
 to the kernel.  All code merged into the mainline kernel retains its
-- 
2.50.1


