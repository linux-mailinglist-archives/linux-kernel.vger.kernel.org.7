Return-Path: <linux-kernel+bounces-829971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D3B98583
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABE73AFD80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85313242D67;
	Wed, 24 Sep 2025 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Mc0a+nWc"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020110.outbound.protection.outlook.com [52.101.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F92D7BF;
	Wed, 24 Sep 2025 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693924; cv=fail; b=Uwal/n4f2bKq1dqCBIkZQhjLU5GU9slLJVJZjdhgStynvCn6Nor20joEs5UJ3ymmKFqhX1P8t/HkwXCWEkDTws/si1ajfeqoptGOu6x7wHBiMknP6sZSGurX9h5XHPPMq2xlwtH7MUAw5H/NT6Egh7V1pO/svFec3Oe0H4iPt5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693924; c=relaxed/simple;
	bh=EtKz63fCrr7xK7qV+COrO5wt/uQmK60/fVQbv+UCFKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tLYoa8xmpHw63uBnq8XYlp3/Ekr4jLkwiewnVuISxDtla+KoBIoUIExjM0kwhtiBhNzSQg/e8bF36O2e+7EfipWt3YafRMf9SYmm/mkBLTZ9hxyDhV/kIHjvE4fjE/NaVnS08NOyiigACBrGeCHo4Xbx1w6KjvEinerCbzDQ4P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Mc0a+nWc; arc=fail smtp.client-ip=52.101.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6GIHgnS2Zpu1o6YtQ+dAhsOAvHLIZgykJ4m/2WZI8r9eE630jDB1/JWmEtLdOpLbiXRDRVckhn61YRR8fxVTxni9PF9pukCLfZoMrkHt6/qkaW7QbNittVbygMNwvJTen56jvtidcOUfz7K6+k6iDImy/5vuX3mPkt1kv6Az3e8j1NOHNlzXx/wm/ugezda6hg0t5jmZ8nSRN7UKSmxh7dj50qyrPatCCF+oPJAHqFuFOwJYPnj3oU5JrV0CbBhzmgUdOqxhnMwuDxE9o8N77UNk5R1kVpHwspSrlc9W4o/Jrp/7B/Ez84unvcDBGM9hUZAQ56QN95lfgv0ufINNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWzUpXmaMFnj5WRXl4qsuR/PFkgA7DR7OzBmtXHQHCM=;
 b=ajlB9P3JJUPl65p0u+lhK2oVceQLIujmes+LmOTk77zWMl+6Hs+u8haxKMT9RyVbntcxAlDK1yo3EEYKADjEYXCD6bcOPnZDYzaXGsIlbxh05BkS1wTyaRnEkVZ9LypMZmRCWZQAV4M1q1Gww4wYj20nj0VW8DNBpcU5vbvAeMnxdkg+WkSG1jIQKYdZ2WTaxn3Ll1mQGJMA1r3g9AmQtoJWovKvRdRwC2cXDSvdw9bBoRC8mKauOyxCBSE6ehvJVvTUgBm+ivaVWPGzxRjpaqo1e2W0gJyNySPTY1BXhIP1EA1YggogtG3Xj8XQs2xBZiKzle1uUOWIduREvSNW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWzUpXmaMFnj5WRXl4qsuR/PFkgA7DR7OzBmtXHQHCM=;
 b=Mc0a+nWcb+aFxvu8Nfo+Wmrl1kaA0JMa51zHfYmmMSgSCLIbR8KBDMrbFVK3DywwVLvn9ovhGrCltHf0PXxmdaS9a5llocVmHoWITKRvoV+so22HAze86ZdXxiTJ3j+r/eo4sqza3OBCf2g0fKkgalDlayVYrHUvGjDaxSReMPZRTB6FBMtGFTUAoR/7lcolE98zY7IMsZIo7UB2Q0G0fAgIMU+iuEVJQ+ZEk7j8FD6sM4wMgOvVZZGO1r8siAT9cg1kiDdP86ciCRB0K4kiM0o23TdgUVdEODkRMffV97hUX35cVbzBI6kOHz391PooBdZssN2Cv6SEcNHx+peocg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9694.eurprd08.prod.outlook.com (2603:10a6:20b:616::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:05:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 06:05:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 0/2] clk: en7523: reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 09:05:07 +0300
Message-ID: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 539f4654-8d2e-4527-4285-08ddfb3055b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MaUmdEpnFKla4JGCPy+3e9dLBt0biacUwfIkBHm1z/oLFies8IhBdCWqyeBw?=
 =?us-ascii?Q?9jaR81MmeLn+U6IaXQwkWXLLe6ALzKgdQlu551sr8fiYMzL1bT+titUXz7j6?=
 =?us-ascii?Q?858RB90mCvErIAH4qUuUtV3B8nOfPiCNy2Z6wPJF/3kMSCAsM8MEso8oPuNk?=
 =?us-ascii?Q?dR+A4gqad3LRL47Lg5luXn+wRHE/XhXwBNbc5QEawvZdYBfYSrbdkpkqdPgP?=
 =?us-ascii?Q?B+iamzU9MwXxjPfywjzwlFtEBsbXF8PmQP4zn6/szi0+3fu/PvT1ZWhWfitV?=
 =?us-ascii?Q?6HKx34Tayo95I8+Usq/vcZoTJyAhwA3fxnaeZYFijpy6z/2Cef6fqH0zKjBq?=
 =?us-ascii?Q?9dg9P09Hcpo6+bPplvoETErsePgMXdIGKjYqsW7FNdPoAizDhTSYNE/qt7Tb?=
 =?us-ascii?Q?Rpvobe/FLgCz8iXdFthcMyWQj5PZrING2lSxrfMiS7jzmjC69uFGw/YyWRDQ?=
 =?us-ascii?Q?cQuM5oiJs9ijgtsN2rIrEJ/MegdH/1X0TPLxNHgTdPbh3hzinrbmgKvBBgRm?=
 =?us-ascii?Q?4s+jxv7Fqay3M9JQQ1qWMatGKS820IMhqZ4TR5maB+8j9SKExpCA/aWOIG34?=
 =?us-ascii?Q?8puarFWomDD0ylz0zph1p1zCeytGV0wVordgXzD8SHmzxJFMI9GL83GO211u?=
 =?us-ascii?Q?X5mwlikks8HO6LgO/CqIW+p1kxScG0BvtarBrelSYNtAXYNmxW8/klXjUyT7?=
 =?us-ascii?Q?WdaUyE0Fz6z6d51NMG6PPBhCOLmq0fUSNoVwftf8LBw98MHi7Kj/V6uq6Lms?=
 =?us-ascii?Q?ieAsIqnwPP0Ft1X8FBk+vIu4nizimOWyXScVuDh35ajabLxIzJttNZfuebfU?=
 =?us-ascii?Q?1W5jWRFjwM/1X1FvRGKJdQJ1vJjJ7mKSsguFjn+M8EIiVTxIXdnU9GL04xJF?=
 =?us-ascii?Q?tuBSSAsHkPqxsqX5HDMA2uvC2x76lS7vjmrrYtX/eVB9+yxuZ7GlbsOCTygj?=
 =?us-ascii?Q?eyOCIowjrzsDMtl98F6ugI975GEoZ747Tg26VtOn0we+Bd+Ui9DbKSzE9OOt?=
 =?us-ascii?Q?0k27Cl34Gzj74xyPVUIHPLKzwgJWVxM8107RzTvaXE73zawclzLa/8LbD5OE?=
 =?us-ascii?Q?XGR3FZ+c2T3kT3AbsfXqLacjYTVU92zLcYxQlq2kM21td0lI7PvegC9c2/RA?=
 =?us-ascii?Q?BdoqGyDW7l6SXDZrCoVze21Pchu2eTUtrzzE5AnZ6mBcIPu6wxdqPZsCpW2y?=
 =?us-ascii?Q?nyrVA2XhyU5IAQoR/AfH/jvsz86Scg4MqudTeWv6cx+8oqPFFBUA6XNZ0Irj?=
 =?us-ascii?Q?HSXnoTQ7hk8MZwM1jewPpOkabGnjWhXbDTJLh8TGTcGn1A4WsWFYQJnVwMCR?=
 =?us-ascii?Q?dfBiYMJED09sQO2V2ZXomfm0Znv0+t+rsg+j6fROqyMfNtJ8Ll8oRTmOnJwq?=
 =?us-ascii?Q?fXolIUpd21js4o575NOjP8PrLxpfcYR7i8v0cCHSXL+7owiNhx87LUMCeB9J?=
 =?us-ascii?Q?EdcRvfObzM4NBebbab1e9NUyr2o1ZzfVug1XnEVMAsMEo+yNsfDfA4LaYRvf?=
 =?us-ascii?Q?DZuzWI+vV/mT9IE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKVAVIGiQPYcO+tcO5zVbHgkZiFGjB+pPNMPOkPh8EFQHZPWY8RvJ3wiFWk6?=
 =?us-ascii?Q?cazOZnWu14+AWb3lTSr13Dkp/kzUX5cnwhaUNnW2tylp5wqmBySKWs/qa6T2?=
 =?us-ascii?Q?bIrKH21XV1zKFv8clm0UpalF2fpGZPS7j4gEpODY8BFyt7UNCTsayuV4NYTr?=
 =?us-ascii?Q?7yPzMf/+/CW0jniQXRmdpzeP3zBIZ9FkulrdwgDPAzy+nGJzh15aN7HTo/AQ?=
 =?us-ascii?Q?sLcHpGMq8r6AyU79906hWNVAh2IEd527JiWrzrcre5a7dMGfX3tDNO8RDSQB?=
 =?us-ascii?Q?0X4BO3v16ONeus6Xz0LeaA2lc5vu6ztFtHTxQ5RfFswKKzH07qYzD3x4PZ6B?=
 =?us-ascii?Q?MP/uiRnuZ1wihsS/2jZsuV8qBNI/AXBzxSGPERSzLGFO9xlStOZGe6hP4jNt?=
 =?us-ascii?Q?jemMaTvxQty6pYqbmY672uahfKwrNadTK3CFKCWw/HGQDL12Zeh1RvKKMoVK?=
 =?us-ascii?Q?3BuE8hpeIOofkGi538BM1glIkX8PDK3KsjTuAHoj+Mwduih36DuAyLVbDqAD?=
 =?us-ascii?Q?zEpzDh1LvBCJezsvCKhI9G9141uXXeUQBHQdAN/qMsTKOKhP1VbZTLXfmAlw?=
 =?us-ascii?Q?eUGavVwXqEc1EmcymbM7SC2pCX5bHUniMq0/j/O2wwrs3I8yQ3X/CJbU4Jpu?=
 =?us-ascii?Q?vk48vV4Aa8Hvj8UdOwCqwVjvDCZA4gy4p6515tMfxiSU6wC+KhkgELT/34LT?=
 =?us-ascii?Q?gaCCkjvHaW4T8L4aVTYMrQbHLm3uXkJgk72W/IN/VhLZNJCOzuGrw7F6XKTu?=
 =?us-ascii?Q?URIHR2jAUjjX1D/7uXDixiNDrY4eI80BMH2Kz3el4Nmr19dbAfcL3KGK8WII?=
 =?us-ascii?Q?nA1kFWumnXpNx8KEjIm28aB+O/H0hafF5qXU+89iMigYzCr8zJSTxlKHYBdS?=
 =?us-ascii?Q?lJry8pz36smdh6Hwu1QQFbEBJ8wlpT/YSuGMKzZzkCMb+MDJloOudVmZmlOW?=
 =?us-ascii?Q?HVUIdGISGHbjWWAwFCKMyhPUkmDpqL030X9YL6BiKs9Eaw7KVnWQ2Hia9Amt?=
 =?us-ascii?Q?5KmEu8vlOVOiCVkBvd/d07zi46DxM+v+2LW96W0iFkjPqGQkj9PzvgSUaJzA?=
 =?us-ascii?Q?IByK/chSS0I78x/60oW0AyL+x2f0OdUeX9XM0OUYa9foYpmwAzErjDj1gFYx?=
 =?us-ascii?Q?MGgT4SgfZ4wBAc/f6f7OCCBRevjcYz5ress1BscpGzhtOsiVqWKsp+67XssF?=
 =?us-ascii?Q?A2xdF5WuzFvULwZ86QstBLlWYLjPgbfzzwO8MWEAud0KEGJOZQSyDX4iTnOF?=
 =?us-ascii?Q?rKYB5PAXp8v79YKviLmJhuM0E+iNXFbWTfXWW1vUnhoTQFI/5I6tKQ2zZp8O?=
 =?us-ascii?Q?RzpvjeV4XlP2XEI+UjZSCAVbyP3emWAFpfxARYphUqnnYWabcd779cezgDRD?=
 =?us-ascii?Q?yc3iI5enrJ40e9qHcCejKDEQw15ukeB6/YQmuwcQ+119YmmxmlihDFlYUEVX?=
 =?us-ascii?Q?PGOxS0IEMdHKVKAFfC4nPwcrB+wlgn/531E+cUvUinemM4lLPLWi8B6wWFWm?=
 =?us-ascii?Q?Sq32N8cCpnkQo9+0yPI5U0YYiq4XoXTBrKNuqY/Oz1QwRgUAsT9a+mXz0lVs?=
 =?us-ascii?Q?YToxrhkWSs+pZdZynuFgxbquV1qGboLOJSfmsCPLyDaopH7Y2XQ1mA9URm+8?=
 =?us-ascii?Q?6ee4yZcr6nbZoSIvSXKcs14=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 539f4654-8d2e-4527-4285-08ddfb3055b9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 06:05:17.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfg+6jqVzGOZlG2rIacFQZ3PdwyUGzwT5p4X6KDAnXskH1tskhrl4hbUZdTqDUBo82VvvkLUC8DiuFQLOcC50mRWl1pYL60bHl7oS3OFPvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9694

These patches:
 * adds reset-controller support for EN7523 SoC
 * updates dt-bindings
 * updates en7523 dtsi

Reset-controller support will allow us more easily reusing of en7581 drivers
for en7523.

Mikhail Kshevetskiy (2):
  dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
  clk: en7523: Add reset-controller support for EN7523 SoC

 .../bindings/clock/airoha,en7523-scu.yaml     |  4 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  1 +
 drivers/clk/clk-en7523.c                      | 72 ++++++++++++++++---
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++
 4 files changed, 127 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

-- 
2.51.0


