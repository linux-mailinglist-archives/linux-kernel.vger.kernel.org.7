Return-Path: <linux-kernel+bounces-777654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC33B2DC44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85437ACC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EB2E7F13;
	Wed, 20 Aug 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="G2RTExXE"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023098.outbound.protection.outlook.com [40.107.159.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89152E5D39
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692477; cv=fail; b=TQVTFlD0+m+VU+ttL3b3dtPqsDWoPFsvc0geV7fOLhbWxwHhoDo/spG67kGkRlMkV8sG9ZLwpWueuG/1hxS5xhlqzFzIRbDxNccrSb8tCxQcCpc4amoMnDR6jsXOnLZ1PI8E6kFbSf1IU5YqLBcxDeWT2xvdwB0SHMHlxs3orog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692477; c=relaxed/simple;
	bh=mgJ/gTYyH/I+ov6zL/MXfdB8iPDvs38YShwkoCHIdrI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i4eBxs/hYWJmHW6MpaARqwYxm3MRNl+bAakFl6jd2j1LjsU7lkO6kG8LqcvXc3xWanf2BbuclmSpxrrprtJzdKgBiMquHR+4h6tXAWoCfsjpYDnXLnRoRIj8VqINhiIRu5f9AqGKtOtwkwpNuF9gZXAEBIwQEkYnGlMUm9dC8qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=G2RTExXE; arc=fail smtp.client-ip=40.107.159.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytJnm9Ygq2BOQL59rEyy7fzMfjmSDEGQH3RLvGi18dcz6dbAcJ/pUEeSnDTQloCcLCQcr+SG1yBAPyXrAU0400O1Yz6JsS3C9358PXaQq0oLyQo8x6+Ag7IsLVk3mM/uhUBWOoYO74cGR+vLhgLBjYSsx2zPOgSenadH8iQ734V9yvSb9uhwEZKZDhpT3apZrI9QIZX7LV6u4wBfPq8Ql2vUkXyA4+F6wtuU5zGTzIby7ObhphlgsYsN+ySCfCDmz3b+cwJD3H2z7w0lY6JjaltRgr/KfUwsLU6CVGD+0VgdOyS2PxrYWEDNQVf/ixH3u14HTyiBaTGAYorhK9Enow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXhMy3wE6h2dHP+izI5ZvKjjU2e6yDNXODOy+4gM+zU=;
 b=FgHcZxDO+iWgv2XruMnVJZXP970u8pZmPXfXH3HBPevC0cYyc3WRRX3Xy5x1iRdg8Uuk3mLebqUgtZpkG/suo6ZxBPwWbb5yPZfEV59Y8AHH1LP35+NSmZZfHBxMd8Hq2Wv26oKEY5aH1FTezvz/agB594Bhm97fd3769B7OyKHmZIjSXSfc0iQIvMa6EcrxYrjgV6OZ0epWYgrNaGhAaXJaT1Oq/WwrCyK13CC4RX9Uma9vSdUBgvUb8EelZRoioa/Ye9uBHqtzxNLbuUjsHLCIz8SgOK5aMjQ62METgsMm80DQfCJwjogf42GFWszRDtmx/D2lnZ3vcIcw9iVwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXhMy3wE6h2dHP+izI5ZvKjjU2e6yDNXODOy+4gM+zU=;
 b=G2RTExXEVTGsLJ8lgm62i4ZDMFBQ33aU2M/DjO84q5fuuOtj50SS7gbuCNUhAI+02M6xDNtK3hqw2+PKmly/pFpLpl6P/4oqSPsPwdtYCs+RBmVjZB5dQ7QnU/gY7iWcDoQkn189KQ/0omHgQgnCTyMFfHvTt9vsZBCoJ/CGnykycXeN4MnTpKGWMPDJAOT+64sQ0RpXEqe3z79TyNx7q5JTMvLVCVZpES7I2NJYIir3sRRr10k4jkJNdCqRN9vrbDldS7c0bvbubae4wtwT3mCkuWFov506ws+gbLUMZuH1mFVrjjy5fZt605KdPLqn19xYta+EG0nvI1+h7nIblQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB7958.eurprd08.prod.outlook.com (2603:10a6:10:38f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 20 Aug
 2025 12:21:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:21:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/3] mtd: spinand: fix continuous reading mode support
Date: Wed, 20 Aug 2025 15:20:57 +0300
Message-ID: <20250820122100.726451-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A8E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: f49fe0fa-cd20-4d79-168e-08dddfe40b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4rubQQoWbrFGEN1Zb+HbLHPWp7WOIp+pFaVyJx1DWkcLS3EPMIqzpM5/06u?=
 =?us-ascii?Q?FfFfHGOZyWSbYd4Xyv0yma7bu9nBTnXe+vV9V0yeSxTr52zqqAEkQTn52ZsF?=
 =?us-ascii?Q?DECAxR9EZogmajodKJR2fZf8tdTXUadNeg+Ws5p/1oVxcwGR6SiX6ve/VdeW?=
 =?us-ascii?Q?12utiu+pyeo0V8mWzgWkSkyb4wqHdvAm+AwFiWuc1SpRB3rctkVDNXkZFHfx?=
 =?us-ascii?Q?OANIyn7KZZGyxDKs+XepJ9uVkS6YrDad/7BhuAG/yj3mKsCP6wGP0omGVUi2?=
 =?us-ascii?Q?9NnZmdxiJt6oyBKSt/h7dw05hRidOcpLHmwMXRS4BhXM9lpwXcdMy1gspjGe?=
 =?us-ascii?Q?SxejHHsq5agegDsO69/P51XGlbOOR1pMiugykNdUvQXLyNfGBX4RMXyeRI5z?=
 =?us-ascii?Q?E9UuZcAfB6NFNnnRySNtVchDLaHaykUpcmYBgXxntFdbtXxiBzrAhh3H+8PS?=
 =?us-ascii?Q?IkzesSlUPSFVRGp/WOSQJEvxULJHESBl7fPflfkJ+w5BLE14/kT/lqCMkGCo?=
 =?us-ascii?Q?FRa5Pj3RxZ7/y6+Qq9dW0Z4h4d0eeLy1wukWWIrcBk1ksnUZ8eRiE+FvYwhY?=
 =?us-ascii?Q?eyIsElESGSv5HRDYBmCLJn7ReqexgaYabsDcoTuMvvTklkrH0N5Zd2SFK6VD?=
 =?us-ascii?Q?DKzD1x6a8+u1sWvF4JubXh7f1dsjVSV8H19EqkdHWM7ZUPAFEINLaA1bmYH+?=
 =?us-ascii?Q?MbrJ/l3baRk+9GnB3xaRrJz05u9s8ZNXNyhVEuhNPqNfEg7XdKe5dMJe8Y7Q?=
 =?us-ascii?Q?YtsIlr2noslgv1ofnTG7VHw0FxrtFVDtI1Vt1NLbX+APEGoZgq2vkuPhyXwA?=
 =?us-ascii?Q?clH7Zgs9mETCihZG4EriLTqcgq03wrGHTlvxekylisHQ5739nhZyNrkJI9Df?=
 =?us-ascii?Q?o5LwDO7rBlbCbv9zvT8icfZH1346/YgA70oEFKiUEyoecA0K6W2NRWoTmAAv?=
 =?us-ascii?Q?2wCNSwkR180FOuo2kl3OK8dJi+ojbB+xyc8Thk3fV2xRxnRt9zX/ORHQYw3j?=
 =?us-ascii?Q?f6c/7egUMjAMzC+T80LnTvk1+fYsazKAoVdeYrmDr+oRq8lG9xwDYgCi/FH0?=
 =?us-ascii?Q?V1k0/OZIA16bHkwSFdvpWpDIsBuNL0rR1klal6zCpGSPm+wcmXi6Qe3KUJIK?=
 =?us-ascii?Q?TeJmSoHSRy6lr6ObOpYUSMRsIirmVo8oKNkV/IZGIs+pSGXdScXSE3kZyxpD?=
 =?us-ascii?Q?vIYjPSHws++/3FSMVvEs05CDgNlqg0diL3mQvp3y1xnmLijX2xPICa8RbDgD?=
 =?us-ascii?Q?HJMOQFUzo8mmS+RY6EJaHJKsXaIsUC/5OCB7bHs6wju9UoehBsk6MsYmituz?=
 =?us-ascii?Q?6qLXmF/9yKlUQhG/w8sILTinQMTAeNcjDgh3x0bpZobW/Ehn5wWutdybJ/bT?=
 =?us-ascii?Q?Zs3nXtat8Ef1X9mUBx3Rnc7b+AgdgPLXC3UlJ39bBm48OXEbFfGFnntl3AII?=
 =?us-ascii?Q?YfFdjgwUswRpeQPM+BFt04CjnIxSsiwLq+sR2nzYZgM2tUhg8icECct/zRtG?=
 =?us-ascii?Q?pI9LU8Ql9z3Z/KM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0Hslr+YS3qVdZtOXAYnUbaPaxwc1X/BD6M8C+LMfmrnmFPu4Yb6Sj/vJ4Fl?=
 =?us-ascii?Q?NF7jKHv9xCKOgYBslecI6IzAGN/bOgBw5y3/8KLEFwq5HuS3UfYiZ+2EUfAK?=
 =?us-ascii?Q?RDtnApNu6Fnn/kwIGqAKXiCAp1uF2VzpIYXWE2M/V2AB6cr5psc1bkgAoPNm?=
 =?us-ascii?Q?Hu8SnIBVNp8sVw2D/fEXL2ktASk51Pb9MuRJXuGw8K6n99asf6Wrtzy3wGhL?=
 =?us-ascii?Q?rZ/hIKLBg343DXH7IE8O2F4cJAaQlQ+eoyje/9xJbbjY7TQ2nOtj+OCsMMw0?=
 =?us-ascii?Q?Lnc9bmKWRCm0fts3SyHWs5AdZEJ4D8FMoPbjea0VTgG83hDTJntubsl0RJvQ?=
 =?us-ascii?Q?y79c+iBVobQbtXamfoOJzD0IuqXw6d2SxujhKK5o4zIyviorz6QHnSJb2gTj?=
 =?us-ascii?Q?gqxbEyLr/YRlrOdXxIrjnEbcx7v2DbDMJu8KvzdmeDJReLCiTQ6JFZFMLmel?=
 =?us-ascii?Q?el8X15NHqrX6ZpBAWBVIRfscOe7b0DwyGFwpF93XAKs5sOcubNvevR8cfm9h?=
 =?us-ascii?Q?wxMK8Hn9za8cfmybHexZUS7LlAyB/o7wUNqJj+PCb5dE/FJX4qTMb1FM+mCg?=
 =?us-ascii?Q?5U7sXVsPDsGuu0Es5FB9Qa5xRzELb8nyBsaouZaUyUm+lDIL+xajMWtujg0R?=
 =?us-ascii?Q?SB0jFw8vtBZnuyppX8YDyTEzyQddqhr64qiGzeNzcav59h2ttBn5WiHEabeg?=
 =?us-ascii?Q?u2e4KDBmteXGG1a5mxKkJxHt69DotfFsHsj4zy1TlANQpME+/Wab4aVz9CBn?=
 =?us-ascii?Q?Qn5rLgkkc4457MKl3tBStuXkc3tY6IbVklY6sV4dlzqbegYHd4oxQ/5viX77?=
 =?us-ascii?Q?2rFk2puQ6V8EY7/jme7OI80zmWlT1lTnVchGyLLzCk1ssFGj7ve1GJKNG/V/?=
 =?us-ascii?Q?RQn3AjYZvNOzr4O+EoTNx1/WCeCRd/GXrFe7MQgPhIkBXD9iC31jxLMzikaX?=
 =?us-ascii?Q?yHpu72/ghAMqXUpBHhZ1vz+vEyAYoUNnpa6NlecVdWVaWweEeYiszwUOSa0X?=
 =?us-ascii?Q?YuG8G53pAKOOI5rDB/RVWiXbtQYFkwD8j1eOQOQwyRIF1ok492jrntehL9JJ?=
 =?us-ascii?Q?ajxyPr33FhmiR9GKAbDS9L+pempZ/YG4QHs7wCOtBBjMFyiGJ5gQI4Yath5j?=
 =?us-ascii?Q?JCxTdIyKpJqtzmXQwfuEdcUzTmxAK7gnSSH+iOyAtZ8Y58Rt+G5GB8mhezlN?=
 =?us-ascii?Q?/KNs/hz57LAu05pXzmWAIkw5j1C78eWjeUwPiT6H8bet7O5NI3W1YYFIpGTd?=
 =?us-ascii?Q?uIx5yQ98a6ldzEYhZjSywvWs7GyhfWyptD1/l+C7hHql3Tz4Wv9wmRG9nBtD?=
 =?us-ascii?Q?9FYSmjl/Saj2pv/l+3ldZGWJRwUDZdbg+mdyTXj3uBS/ClHhCRPm9lzkUO9p?=
 =?us-ascii?Q?3u6CoWE01jTXDs0mAk1TVzpNsPuHZhxmsTzaP6tdhSEomsvECJblGwS3JLEH?=
 =?us-ascii?Q?5nys0dDo0iBs3Xnb/OlC+5n9w+4wrwylv2gMeS3XnxxeWBsAIQGr8285ICY2?=
 =?us-ascii?Q?w0+vnIIqSOXxktQeiExr5pOKw9xBGCj1wmrB02dCG1A08VZFWvJ4Rs2vfUTi?=
 =?us-ascii?Q?w7fcvrVRAydHD44EjQ4bpC5Xxr3jL0PVSf9DhS+Hjckn6Ss3QYC3F+sMYLne?=
 =?us-ascii?Q?Y2M1VJeARNzfbZE2dIlVQkU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f49fe0fa-cd20-4d79-168e-08dddfe40b6c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:21:09.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0j0mCbtwlrI0Xw8LXtNKAwlisblms6rSelsmMp5ztNhrfMSng21UJEK+7vKMAym/h3qJGQFpTXWZhTMm37bbRDYlEuyXAMfrpsLziGyFLkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7958

Continuous reading mode is broken for some spi controllers. There are two
possible bug scenarios:

1) "continuous mode" flash and spi controller without dirmap support,
   but with restriction on transfer length in adjust_op_size()

2) "continuous mode" flash and spi controller with dirmap support for a
   single flash page

In the first case, any read that exceeds the limit specified in adjust_op_size()
will result in an EIO error. The limit may even be less than a size of a single
flash page. In this case, any read will result in an error.

In the second case, any read larger than flash page size will result in an EIO
error or spinand driver spoofing (because the spi controller driver returns
more bytes than were actually read).

This patch series tries to fix continuous reading (spinand driver side).
Unfortunately these fixes can't resolve "spinand driver spoofing" case.
Spi controller drivers might need fixes as well.

Changes v2:
 * added helper to create reading dirmap descriptor
 * fix spelling
 * error code is not used for regular reading fallback anymore
 * it's possible (but very unlucky) that someone will do raw reading
   of the flash in continuous mode (i.e. without OOB), so fix dirmap
   creation for that case as well.

Changes v3:
 * improve description
 * move airoha spi controller driver fix to a separate airoha spi fix series

Mikhail Kshevetskiy (3):
  mtd: spinand: fix direct mapping creation sizes.
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

 drivers/mtd/nand/spi/core.c | 88 ++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 20 deletions(-)

-- 
2.50.1


