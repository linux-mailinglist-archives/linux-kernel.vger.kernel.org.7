Return-Path: <linux-kernel+bounces-889639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B106BC3E1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273383AC5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A252F690B;
	Fri,  7 Nov 2025 01:24:17 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021130.outbound.protection.outlook.com [52.101.95.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4622F6195
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478656; cv=fail; b=e6Vly3jmwny6CX9StHcoLPVPCvbn2o/zTxOhD5abwPlUWIpW5oTa/McHlECzsQ+iX1zq8ZOsHuEPt8SKioAjIrSaSmL4jk50D5STf1bMFuTwlzpcBWrLL0OpqaDiymiAX++13vFh8eAC0q49W0RzeH/4phfk0E8+DrZ2xWkvt7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478656; c=relaxed/simple;
	bh=r5bK62pE3hfI+/LWucCNGGw5qthNzh6zzLgH+L6Oz3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9CJNhqT4SM6NgcpbjTYLYeihGJ4B7WLtRAzvCVVjGn1UPhJ2ho2PkDuw5Mq4woQL/f8ZniepF5JFlAWxeybPVfXWCAmNc406mpRF4ORp7P643wTAoqAPvTf4lBx+qvccLoJTdmkXwhNYm/3Pyf3jA3fxkm2DXqT0wHZb6g3e3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8dtV3eaCVnNOAvY1VhZErJ8n0TkGQfdK3N+mpWWR0y1pLVFHQn0Oy+JSwEguPGgVT48roKxYHNAUgbsOYoWkpdeSOV2Iiv3Bnqdh6yi3IilBV4lkCfLvSzsE0FajljwyJFqsyzOWNtBFG07uvpDxWvfoaZg8jrFKKGPdzYwFTlaod1MZavRshHrGyfhs2EPgqBLUopCSe6Rm2gdwKnk8Gf/cOUy6bPPschAwTHWvwylH9iedy3D94c59oXkXNYgvnRwWy6C602V/lw5vKCf4H9cJ/O4LHiXYDJb2NhE0QWKC+8OiNBIjrYVzw2ZFRQsLTBMey8hA1TfbuZxkxrFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUDSzFREbHbkH7IEoBm/8XH5uGkbgmuIm455p5eVUZQ=;
 b=ouZF485hwSdxqOXO5DtDgBoKH1kvIgxKmaIsYzXqygMntO6gs0HEowk+YzARxJ+qf5QXFYE7LK5+lPnuilx9Kd73sNLQLmFELISrF9N6LiHeTB3zDIOZp5ibkYhJd2jmZmoeLQRtzmfw7Ng6qsdJ57GH0C8sgz9GTaIEZTgbHBuPLA3Su6QsucXFy0kP1jURDf0KPdZz1KEDDCQqf/CzE8KM8cEdCqscuY2jrJyZnhSJk7cwVhV/+h6WYHhN1y8aEC7cl7N8S4u0sq2jiS0TjGtYjbNk7l/Ukh3tbk2l+slSUC7jlKB+WpsLcIF3lnLOMfpKeR9LwfVUCERLrLpd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6922.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:24:14 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 01:24:14 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: dave.martin@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/resctrl: resctrl: Return -EINVAL for a missing seq_show implementation
Date: Thu,  6 Nov 2025 20:24:01 -0500
Message-ID: <20251107012401.224515-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107012401.224515-1-atomlin@atomlin.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0910.namprd03.prod.outlook.com
 (2603:10b6:408:107::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 8474d4b8-88d3-4f44-4c94-08de1d9c5c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VzcZLQdRg8PVwTm0lgWyqtzzmArb7ORQqz3XZHaD7SK/uIR6k3sHIO+0nQg2?=
 =?us-ascii?Q?BWBFC79HPRpmsnN0HNcbZzt0dcksKSGsL/tSM/AsP0JwraqovT9MTQbYhF7X?=
 =?us-ascii?Q?bP4b3kbAt3CHqunU2We8+EdA1AUOmgYr4e/B9R/YVZW0nKqlSeEOIWRGMnNq?=
 =?us-ascii?Q?IYOFHaHmqYf6X+bvFQ2/1ZfjfDagAkIOCj/RnkUEXsRWmlf+xaTt8g33tJ9i?=
 =?us-ascii?Q?aqhccf+mKkd2gEFWH42JL2evpkw572B25eCsiKAZnbf5q0szy9wKHA8HFFc/?=
 =?us-ascii?Q?O0EsQj6mDDRxj1am8Yw3WUmXHjz6maOJRg9rJe5WT/nuCc8AX4asp3e0Tawm?=
 =?us-ascii?Q?KurhLA44ghVQBmgSRZM2nmurXN6SyX6jz6SSuRS4Z+s9m6zyna5oFOqK1dxW?=
 =?us-ascii?Q?60Rx6MqagKpfOm8shwNENf6a1A13N9VgsALONwPOSXjR6NFtIzZTebvG1aDt?=
 =?us-ascii?Q?Yb+D5Z3l3syf9HRlyEkMcUOrPr220facXioaql1wJ+ZMCrbG3UOw4sW0TJxj?=
 =?us-ascii?Q?FpDRgXhoUvlhFp+xfllKvjcUrU4IpNh8yAWdXT3HIAZW7AbZp6rQKb/RSRQY?=
 =?us-ascii?Q?oAb9KnA281axHulC4ftL8TVn+FNtS0hI1IUJEywZ+3pJGv7QqwC4y1lsn/gG?=
 =?us-ascii?Q?wlzi/nO+642pSCcsEXpqXLs49LuNEgvYc/JdYrUgrBmKualklJy8Rp8l66L+?=
 =?us-ascii?Q?0O1LK4iQ6lHLDqQJ2OMgGhU62N7YfKtRxVJM56jlLRWPWPBBb6LcWsBNRJ6G?=
 =?us-ascii?Q?jltQHyPH65Y+VFplB83K819qGR98QyNGgRsE/CdlArjx06BnDIfRwGCzjFeS?=
 =?us-ascii?Q?RHkPiEu0R+nY6PzxELpzh5a2BPaNXuraFO/dxV9nBASQ7RNNySkfpdUixnhK?=
 =?us-ascii?Q?q+y20Bw11ZJhOdmlMIg8kjrM4NC92shnkuf8HuzPTkMskCLKWEyqPY+RF74k?=
 =?us-ascii?Q?N1NG4WYjcH7A7N832I3uHfz5mjpf6peONuXR4nteqQrh3pw3dgC4Y/SFMalS?=
 =?us-ascii?Q?i2YAb3KnTE5m2djh1krqiTysIixxiBNqZLGJBl+iL9+vy1JlB17LgPASrkrI?=
 =?us-ascii?Q?5zDtJK0peXP9RiC0XY2/S0BdzjZ67gcxf2t0Sm8eC83BhU8V5fdyjjqrMSlg?=
 =?us-ascii?Q?Z96U+WwmkQBJqFiwbhMfiO2ZIMVZR0wEEkL2XskwjFBNXaJFDyyNaXB/QM4A?=
 =?us-ascii?Q?Gh2mluttoqsW9M7C+HMTwsnII+wac1A4UYHt20+S9zRjP3vV+PvekX2L+qyt?=
 =?us-ascii?Q?WC6fjy9wX+DYQHeyYuREfgwm1IvvxSURYyOZI8kdiDC4+hp4yQ+On1h/9qKL?=
 =?us-ascii?Q?OFvJRrQURP8Oh0/yXXCcUf0l+bKtHgP9b1FfKEaWMl4NiUYVhuNml23Xfw6w?=
 =?us-ascii?Q?eJ6NGSAOMrqAm+Yhf8fKnFTLo4LcdomZtdIzpsqyINSdC2MkzwoFi9sYDwBV?=
 =?us-ascii?Q?B3JnHx3E8WnV/VMwiHGifuk0Sq6L50ZC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qBXIoJwELJUtiwGDUe93C7bnEEwQkLscyepv19MBGxmYSYkDtkbUiXslP7j?=
 =?us-ascii?Q?gdr8tl1Hr6Utvjk/Z7EU7pLUCl23TA7LmRjjaXKaO3roiTlKBIzRPVbkD1EN?=
 =?us-ascii?Q?l7pxdHnV/vQPluhzu442e61mkxBT0QzjgYZkSMzkdIAJEhrQwFr7gDw4dmUu?=
 =?us-ascii?Q?SPSndKPGhB0UQ0NlWNw1rTljzgPqEQ964pjH+1dyMr0DvJUWJOxetX0tdjXu?=
 =?us-ascii?Q?HPu4dz/riJdj62qIfsSVMYCOzua9sm+8CUPu8do+0fldM+Tt1FB832V75wfk?=
 =?us-ascii?Q?rS/rx+5/s6jMJl2tNkui9nWvcey7lSfIWBegEexoearXHq1gkflYJxNNps05?=
 =?us-ascii?Q?a1U4OZb2BK3pLdQJOU0kONFbuS3SOXO1bdrvwHEeUI7oIpADp1sHEJeVJ/x+?=
 =?us-ascii?Q?wVu4yJo2A8rOnIgwM8Fz1DOyAzZkbHo9g5sWwVRBmccyGha9TJR24WCyxfGU?=
 =?us-ascii?Q?1onm6k8R5vMLKiTvc24Nu+bOkeVj00SdKDiEqfKf5iqz5hEQJwDjXETOSJYu?=
 =?us-ascii?Q?a2BqxwaZceMf9ToR4ENwFxNyhDGH7S/KO82G0oH6PItKZx8TSFL1/kIFjhGJ?=
 =?us-ascii?Q?bs4uGtC9jdUW0rLwr1h39ceZyfKYWpZlefIzS8awJ2KrQ4exDvhykiJ2sOc9?=
 =?us-ascii?Q?90kBBMvASHPHkHryULCp4cSesSGGOgR8Ll1CUMR1X3vT8kqKMhvZdDpQLnFL?=
 =?us-ascii?Q?t2B96RZ+pEq0WLsH8/PXPo/RG0Rx2FrGYAVCY6AoxC9Uaz7DdXyuvBxpWuZW?=
 =?us-ascii?Q?tSAZAfEY4QTjSerH5/4MP1aqgFHaMOTUu2gOiPeF740nzRrIn0nTlHJs9HhB?=
 =?us-ascii?Q?y3pIaq0amICHINNw0/U6c8ruxLKlK+WUHRNLipeOv4VnxI7kXbJHYl+oubfK?=
 =?us-ascii?Q?WBivW2oZQSpStwbFB1ElSAnmBWsxyNlvN9IBUklHHBCoG9symH/ZcfkFnJLY?=
 =?us-ascii?Q?1jNPBbKGO0D9G3J0zi+YEyZWOlq8F0nQFxNoRnNwqzMWiWRTja5YD4RQBnd0?=
 =?us-ascii?Q?oo9ZJSo720BRJOsoXi6ES15SHxgu9PlqGhcvwGX7NGwnLPdf24zKnjyi+8a8?=
 =?us-ascii?Q?f5eqtFwjZ2nbwhoUbqcI4EJSrs+qMehc7c5BJOKvZJ8JzQhZUQr7LZ8X00I8?=
 =?us-ascii?Q?V28rVo+IFgqFUYJD4FU5NZEpPJiqYrGICmUsVKuD9dvXTqkCYD8ZgU0N6P3j?=
 =?us-ascii?Q?QQsIt7APBqGZD69evyTE4jyrFrHC6s7RE+cZLbWL4DbHfRDy1e5jUTCodek0?=
 =?us-ascii?Q?D44zQNauoKl4lO1DNnHYqQ/BWPg/0Gn2LDdFNBtyyXW2vs926CM2HrYrOB00?=
 =?us-ascii?Q?r9XxITMU9QW0/lp0cFo+dcI7awdy5GBBrUT1iLAe70BfexbaRGOc287cVuxP?=
 =?us-ascii?Q?DGQZlPgf5BPNaoNM+FrvxuQBEYhEbQJWw8PeCojiwdLR49B9YcmwJDN1NEVF?=
 =?us-ascii?Q?RniXuTG9Ttc4+pt/pUvLul+tpfrD/VJLTMM01feMcApjCGqNsj99wXoAyQY/?=
 =?us-ascii?Q?mKEZ4kuiTHI5xB6f95tDSIbSKizQgpvlJrqEYCBr11iD1r9DJiOaQMK9KsqM?=
 =?us-ascii?Q?MRbmu35xCCt0qUdGaSo4dVcmvUF10yJuJLt+GQtF?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8474d4b8-88d3-4f44-4c94-08de1d9c5c80
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:24:13.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UZqnR+JHZW5BqmvCeCsTzgMZg+uXurcTbQSIZBJ3JAYIRtCQ/X29+Z3FZG/yS+ePqtpdGNDbtc1QTKIK5sZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6922

The rdtgroup_seqfile_show() function, which is the sequence file handler
for reading data from resctrl files, previously returned 0 (success) if
the file's associated rftype did not define a .seq_show implementation.

This behavior is incorrect and confusing, as a read operation that
does not define a display function should be treated as an error.

This patch change the function to return -EINVAL if the file type
handler (i.e., rft->seq_show) is NULL, providing proper feedback that
the operation is invalid for that file.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 fs/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bd41ab5a8eb4..661a38176d19 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -314,7 +314,8 @@ static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
 
 	if (rft->seq_show)
 		return rft->seq_show(of, m, arg);
-	return 0;
+
+	return -EINVAL;
 }
 
 static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
-- 
2.51.0


