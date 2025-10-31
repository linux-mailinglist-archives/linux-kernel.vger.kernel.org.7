Return-Path: <linux-kernel+bounces-879717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4633C23D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F67E3A76F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4E2E8B81;
	Fri, 31 Oct 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Noy3QtUD"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0C20013A;
	Fri, 31 Oct 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899388; cv=fail; b=JMbRUYxdmFcW8z7Bk73ewZiTaUJymTA4V2JGoeh3l4QqyCr/cGycc/ULvbgqk1ZfEy/K3W4e0Qjjdq2mYfiDRKhORdSPs3Fbd9/r9a77PBUZIOqCxI975XmvaOyEfDh4LEclQ4c0/qsNNKweQWGfj0L13Iu1Fh/QdYLSydPUsDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899388; c=relaxed/simple;
	bh=6kwULExJMmKDUOl2vQynWVZlnwLU35Q6vZ3W8AhT/BI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dAiFAwwYUBhmWpIqPXHrAWeXdvx978x1lQdJlqg69honqQ5Q4iOrJfPvWjKuySSv+cdQBVEt+t8vS0zXTSSzqRlWz5BVmhY6x9fnUjHNlGYttebvHdpj2/4POcMiZTwR46uzdB6LtgNorXlEihA95tOpyYUQp+jnilGR29lPxyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Noy3QtUD; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnVXG6bZn7KlFUUmdVJVOPEdd4U4zjoGjB2LwJ1INDwfekSNhJzcZ4l/WHHnzRQl9uCNJAa8deAfFVh3zEB/29UGQAlZibugzsc/hhY+QdbPBcTzOJGMwixu6RNqpkCcSvm4Xfm+5+X+w2avt3/Od5vFTQ9DIcLemze3PBpUaBeDd/65OZSIXr1KcPfAsJyNZzuE+3FIG4q/0UXyVQ3XwJ5t2Tj+hZiZpvO473DZfPbeM6nDut9hpFVUlz9JfoK4blWWNVrj2cO/cCJhOXaRurSt8eIdubue3tqHac7IlvJiqz22J8UGK4pS/RjuyoQsC8eNDvXpHUywxRiW6O2ILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J097hbRgW7uyhk3RJPPgYZY/PzOIy+RvQ9gvj+WD7E=;
 b=peCGOseXupRc5UYJ36bxOyYp8yFHKyKXXj8v0Qv8M18x3iiYMc+Vw2VIXOY9D3m7/6t2N0yTIGk5YoWFIBw5saQecOyPiDliwsnmrWuYQlGdBw0Hy39uGKQprsH3LWiRkfAJwvsvs/VtzKJjrT2v7bYaaH6kN4l2DLHmWE10tCSj9gLhS3Wjknrf3C2BOkT0DO7adZHm/k49Met4weXcOxh9A3xJI2/WtTwrMfr9M0ooJyymS0b7ztQFFFyCXzoJttcRv0rZd3F8y/IjXTddyXnF/lIJM5K1MyGqOWhGRoEqfZhCPZBaTnbBcjEWnESxcQuoC5Ep32y7rY3En8vbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J097hbRgW7uyhk3RJPPgYZY/PzOIy+RvQ9gvj+WD7E=;
 b=Noy3QtUDVfW/qsOcJ3Qqux9Wh6HTuGmmbqWI0pevLAd3ZESqx0Gf6zCgf2Ezi4iHgQjItzw4GUFyeBmAuslOJqP16cYr7lvWQ2L3Zh+0WA3DQ2DgHLYjQy/xgxUNPh1FJAhAtocagpNQbjeF13PQIs5sZyTacmfRd5JZMFAd/SASKpaOvYG63wzDUN9hex3+os24jVC2MKvd20c2kd2Lhd94a6g/qL/P5TOoSRi/QtNkJaGAES8n+YLzumquPvKK3y64SaZz13DS1w1MEuTBaJgbcWEVrBqy02o6GSOr1/r3Rnz7OCF+oMXJW+IICY6C2m7LXuNNOT53czuFOHGTzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 PH0PR03MB5862.namprd03.prod.outlook.com (2603:10b6:510:42::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Fri, 31 Oct 2025 08:29:43 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:29:43 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [RFC PATCH v2 0/3] i3c: dw: Add Altera SoCFPGA runtime PM disable quirk
Date: Fri, 31 Oct 2025 16:27:28 +0800
Message-ID: <cover.1761893824.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|PH0PR03MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: f74238fc-487b-4a15-6a83-08de1857a475
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hPGRvIX9gXVm6MTYSU2BHRrGmW83T1JpKlmur48z1EvNRSqK8pJo7ulWvVLs?=
 =?us-ascii?Q?4/ypZGnZLv5QjlgoZSEUZNcQLmAIgTA97u5ZxaeUMEx/VuHxfyv+gK7ghoZu?=
 =?us-ascii?Q?2sJUP3VkscZzjN2rt8jiEK5M7sMVL200YUlnH5aRihjTPj2Q0TS9Tiyn/lVp?=
 =?us-ascii?Q?HvBhiG9/nhXS/UWlts6d9AksaZYx7ptg5TWijetrrtwP4MXzany5FIGcAGdM?=
 =?us-ascii?Q?ZJ3xYDc5JaMkPGJawF9zDbErW64IzUXSqD0B40l2DYmV2eK4Vcg8RoclX9DC?=
 =?us-ascii?Q?lYzZmCou38G4K/QoeSnjCqqtxxhDBSyIbma0p2qEtcPtCpmR5Hw80YgMeB57?=
 =?us-ascii?Q?dbpCRAGek5XtKU/rCIQjHEB0aZtzV3i0tae3br2ZF+0r4L2ikvgC+XN/9xPA?=
 =?us-ascii?Q?TTalP8WUbtSi05QjmZCT7XvuA9EgUH5U/45ibCz5R87eLpfC3rolzLNsxST1?=
 =?us-ascii?Q?1bFke6+4yGuQR1xCWzed/jSjuKPvoD7Z3YP8y60nnfcF0nA4L6KG0BHQpeXs?=
 =?us-ascii?Q?Vs++i3ohfr9ZS8BqZgIC8RPcBQOrOxvfzlxGY+29fx161wyhgUI/xhI7JbTu?=
 =?us-ascii?Q?MWTrirm1OlAFvARwVyj8k4mfitOUsDySxpJApaB2GoSyr8kVU4eOxYDRnt+Q?=
 =?us-ascii?Q?2dkE2u5R/Wj1NGj14y58r+wKcA68imseSKDW0W/yiP/zF2+Z1uWfgnZXVX2Q?=
 =?us-ascii?Q?cDf8bzqPpcE4lVhp9V8L0CpRd58VxcHHH9AykalrEGQP6kCVVYpljzrHyal8?=
 =?us-ascii?Q?fhpLYUjK58kJ5C0O7OnfhhvADvhTjZlchPYHze2XIITdZzi+QJchzpsJixNA?=
 =?us-ascii?Q?pN6tM2SRyFLi87VUi2SYFoqnSiqsNcqj7KDNR+z8DJO98ZRULb8W7gTgHS4L?=
 =?us-ascii?Q?KIpGcooQSgEWzZKLxeMiYsCOxwKDmw6BF5Rw/rvtb/XO+6Il6bMHoQUB11D2?=
 =?us-ascii?Q?FUSZJuawvw2tnKekzDUr2XYoQU9pxDIg8FtDNcTDCcgq3Bkn3ybRAdYNd1Ze?=
 =?us-ascii?Q?XKGdmxv7xkLUctPKz+RIf5i02NyEJwZJ8Z++zliGTl4Qxj+holK1YiEJ+fN9?=
 =?us-ascii?Q?CG9eHRrXB9A/RnqTRi8WgNHvGKx+kpCO03Mn6jT0oF0fy/Nre25niKvwfp0x?=
 =?us-ascii?Q?cv26tzGvR7nGzj30sKvJLCWU3SQkjuiIoZUuNAE0PhvE7TEcMJSP4vbPzrC3?=
 =?us-ascii?Q?kbU6c6lXYzUea9UJtkEx/7i0qLMl7FLSV06uAJqGAnGtlfi7SMYMHQpgoB4r?=
 =?us-ascii?Q?RDUrfOWVEgg0vF1NPHy977Pd/qqsNRJhlp87vPyni3jOpRfnM3YDoJ9HYUaq?=
 =?us-ascii?Q?6oMgRquLdFgHpNHM57u+0iSc/DZSsQIs/BW/TW5nZS3Fu4AIFPA2Gc6785+3?=
 =?us-ascii?Q?Vy/1mQL/i+jd+als9psHagLcYF3hknP+IxSmiReJBAAGy1XcBhvP/L55BPrV?=
 =?us-ascii?Q?fBBFCc9ar4By2Irz2gksWzJP5yyvSvEOnq7ODb3lHZltAYOd8UuA0WLPgdm4?=
 =?us-ascii?Q?KkJRcb3Qd85Isy+ptXPzZQRGbohnH80mube8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0q4T7MC8+5yYfVITiR1dKh5oupWRneqVsLEIg3ht4nuqRzXaP10O2OvXnZAN?=
 =?us-ascii?Q?DKmOA6B9ICr1OAyczMmCCLs3JnyBDNUPMPYCyBnBb4fo/dPCXjSb6BnkiCBG?=
 =?us-ascii?Q?YTyrsl8nY0un3GgeF7h97sw3EKI+5PMzCZ1TwjNpRHMx/YX9dcM7F2u+rtQh?=
 =?us-ascii?Q?kenLx734nOzD5jxqc+BVRPo/4LWhdwPKHg2EJmchZCgzlsQETE0LIrw+9DNA?=
 =?us-ascii?Q?2O05lYOIQTmLtopSPX1wbPi9U3SVzCHfFXfp9YAg8prC291vtCXiWQuGkS91?=
 =?us-ascii?Q?/KYjyaNjbhKJnQT50FJKGSWqiWPmr36w/YoXTu1zf8JVvwTD/io6EopdS1wr?=
 =?us-ascii?Q?pcVPSEITgmczEgmuL3mgeDUbYdcTR6ZN8dbpyUHSgvR3enanK5UcmonG6xuM?=
 =?us-ascii?Q?rtukkbSwD5eSUc+GADhW2pHO/cRn++XOlEYaeWBj8r5UI8zZBK6ablqCbX9G?=
 =?us-ascii?Q?6CZ/8MP+SUX1kLyuV0G1HzMKDpQTv/Eqa82UcJ7I/6GByKIcd4U+Ycx98gBF?=
 =?us-ascii?Q?ma1QObMoW3s8mO7LDNkQSDeaET47Mss4EklLxhvEAoJK/0NR0IlQDGmAwTgU?=
 =?us-ascii?Q?4rrcxodTmwE1PpOJwE5GvVmstyznnl0cWaWoRzUrCxQD+O/uWfsOWPAjkc0B?=
 =?us-ascii?Q?aMHNzq94S4SKzHCqcQpuUMhtmuEH9ktKd8NYWEFrhvZgg9/JbmygUZxdkFIo?=
 =?us-ascii?Q?SaKXz6XTCN3UGVBFzyqLe6aEEHETfU6in8I+8KOQJbs6R16hXj06L1bPzeTS?=
 =?us-ascii?Q?OmfyKDxPjIC56lH/E4CKdDHDPkMuJk7ZcMu6Mn6mRd2irBsCVmK2VpFpP6UE?=
 =?us-ascii?Q?t5cdx/WrXyBE1nl3nWLC2bIKlMGzS9jIERjQA3SStNG4qQmgDadpzTAqD8V4?=
 =?us-ascii?Q?mRCQJ7FC9PKO+0MRf3glUIOP255X5Xu5PUx4rht8zcM83nvFidBaooznusbB?=
 =?us-ascii?Q?GSzEkCAqzt3Mk4Jnhj3RpvmBxYfv7g6RF1qm6wbKshnC1RIOGtrtNvKnYNf4?=
 =?us-ascii?Q?62sRZYPtCNnqyVjfFy0pUGf3B8U8hMKSOQE0NKEm+R1w+DZcQBFDmyk+oXJ6?=
 =?us-ascii?Q?tZ4fwG5iqZvYSdezMhGB6u39n1mUtMDEnj6z2Vl388WqssU/yAyM5kk2STrb?=
 =?us-ascii?Q?SGQCCzM4eMoTyxxt+7G+Racdv868PAyzHWrfAlfqEoqnG/9sxuE4nTY55QFk?=
 =?us-ascii?Q?JX26KZnwq7OGGOkYtO45Ms5vzXJK6HFG0/5hjfd73yGnbnUSzfynOOOcTW5f?=
 =?us-ascii?Q?XWXAZdNaLDB+qxTjEkEYovz/aIZukb+OrpVs5qbUHBX/1x2VBleL+MVQcICN?=
 =?us-ascii?Q?Kh5fz9Ui7cgXmSDZJnM9RFcHfugEOiJMCBA3ePxXoLSNJ3ytZU1yHbTMK0JD?=
 =?us-ascii?Q?SPJK85PcMRRvfI5AwzXFhN23Da7rD4TcMfnQKUrp0FXzwjUyqdXLLpf66TZH?=
 =?us-ascii?Q?iFOxZF0Vv913Pr7iiV/MaUllLzMzxpdP4opJMpKmuaV/iETVC0LVDkIxQYSn?=
 =?us-ascii?Q?gb7GASi6rLMCKTlmCi+mUnzDiDufyyo77H8Y8N1odpE8iNgp9LgEsIPj/t9n?=
 =?us-ascii?Q?jQ+hocT1hHfxQa4/zlF3Si8dAQR7eBVX8w/e94NGqIbzExnkA2x9FdWge/kF?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74238fc-487b-4a15-6a83-08de1857a475
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:29:43.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYEgkRM8arMBBjtzxaxk/W9MkjgaxYdsFdan1AXuB1qKm0c2moOi+sBOR+0WLvet11kW7OqbCWTniZwnsND0+DM7iVjS9JsWHR/XbxzNd9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5862

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patchset adds support for an Altera SoCFPGA-specific quirk
in the Synopsys DesignWare I3C master driver.

While running the I3C compliance test suite on the Altera Agilex5 SoCFPGA,
the I3C bus was observed to hang when a slave device issued an IBI after
the Dynamic Address Assignment (DAA) process completed.

This issue occurs because the controller enters a suspended state after
DAA due to runtime PM being enabled. When suspended, the controller stops
driving the SCL line. As a result, an IBI transfer cannot complete, leaving
the SDA line stuck low and the bus in a hung state.

To address this issue, a new compatible string,
"altr,socfpga-dw-i3c-master", is introduced to identify the
SoCFPGA variant. When this compatible string is matched, a new
quirk (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) disables all runtime PM
operations in the driver, ensuring the controller remains active
to handle IBI transactions reliably.

---
changelog:
v1->v2:
*Add new compatible string in dw i3c dt binding.
*Added new compatible string for altr socfpga platform.
*Remove Kconfig that disables runtime PM added in v1.
*Update implementation to disable runtime PM via compatible string
match

See previous patch series at:
https://lore.kernel.org/all/22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com/ 
---.

Adrian Ng Ho Yin (3):
  dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
  arm64: dts: intel: agilex5: Add Altera compatible for I3C controllers
  i3c: dw: Add runtime PM disable quirk for Altera SoCFPGA

 .../bindings/i3c/snps,dw-i3c-master.yaml      |   6 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   6 +-
 drivers/i3c/master/dw-i3c-master.c            | 176 +++++++++++-------
 3 files changed, 115 insertions(+), 73 deletions(-)

-- 
2.49.GIT


