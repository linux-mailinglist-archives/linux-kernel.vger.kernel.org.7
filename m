Return-Path: <linux-kernel+bounces-851545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE6BD6BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530EF4E1FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D862D7385;
	Mon, 13 Oct 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YJA+ieOF"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020134.outbound.protection.outlook.com [52.101.85.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E0258ED9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398117; cv=fail; b=q5syB8xSW+qN+T8WCjbMudUwaRc6qhn5rpuHmSJngq8OtxrOWYoF/1RBSqu6MbR4gb08Af4tLTF323jpFKvwGWOCRui3rr5yxZRDf8m4IAXlGojSLABV/Mufe3rNAAhVM3lR07Qqjn1SlXMQsDv7paEHBSrGS2EsIAVrhXcvLyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398117; c=relaxed/simple;
	bh=nSyhfdtumah6Lm4YjQYnhILD89vpkiypc9HRQHF+5rs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dHdRJ5Icujl4R6sPGqhJhezTiL3PLhBxm/inoBJX4G2wnU7wMoFOApOVHzXY1opKO2+PC8XCSl3orISpHhAlTezQdIO4SILCsR0NBBu3VuDtvlqJkzxcqDMXLrqTyWbpTnU7x944rjbu6Vn3Kgy/qZAQyOBo2o9vAbQtpX9s+i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YJA+ieOF; arc=fail smtp.client-ip=52.101.85.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeLDrRhp/wMspnCZ5gC/c/rva8qdhcvYWFi5q7YqcdbPoehnUhL1ZSJ3HM4VOA6uSA9XefLlUge5lfGkUlBGK/9yWPZ8ttGfziDuOYSlCnxZ8vyR+aPIsBPaTD6yv0j+d4iCEiYOS9JkEIWORkVIqzUPripi0U1iiTrDo+Wuk3ENosmrcKvthEPLL20EHiRmD0JOX/h4nw0jBIX1P9MEyVGhJaS+oQ15sGibgdJ72GY+skqs6EgAGEYoCD3ehtnGokX0apCsdbBd37KMZOhGl+OjfqEX27TBR24PyS31LlnDTRa/stdLSqbVeA90yRyET98we2TNSDcP1kTs5+pzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DVX3J7XC1HoHEzPXDeLIMV83Vtl2eTSBU9DPAeXdJ0=;
 b=QljpGMDcxwapO9k83FCgvHEXW0Pi8RPGBp13hvdVUe5iJ5UatreLvQm9u5UCWph040YCXBK/JAQZ2vsIOOdauD36esUyWA+O9/yFV5upoIC6iOfrYGJ/m+XX3VbdLCrA9IbY87pN6qq0b4rzsdDyYKeUb6ds4RpECfthZs7q38F519bBIGEtXaV3MrmnX98RLWG2luE7F6QU9/Rx7k4uDf+FgKvPe0rnW9gJ+Q/2hD9gpca3IDGrGAf6Wdem9ByclFkF/NVjHE3G2Kl9CVqzOWPGq3eMNHL02aDjEb9mwPd+V5Ot7JWZlaOlShMWjOIZ70PVOa/LKD5etzBdX4Bl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DVX3J7XC1HoHEzPXDeLIMV83Vtl2eTSBU9DPAeXdJ0=;
 b=YJA+ieOFS+j5hZsCXGL+q9y7TgdAldvupN9RAOoXtlM9VnTykXnK2Nvq32LVHu3u/vx0ZzsjvF/D3ALhTJy8JTLwkUzMhj9EAGUwPf6RfW8MdW164i4hcdvqFfm6opXk4h4YCW/agEOWh4I9Pi2Z4vzjT0wk+mPAiaqdIMmoqKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7368.prod.exchangelabs.com (2603:10b6:510:10c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 23:28:32 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:28:32 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	dev.jain@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Two minor fixes for BBML2_NOABORT
Date: Mon, 13 Oct 2025 16:27:29 -0700
Message-ID: <20251013232803.3065100-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:510:323::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5841d45c-3757-41ab-a508-08de0ab03934
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYUuOC5p9y9RZefYZ3DY5FqpPu2cvGGLyWgyKeIhoGYgZxRFegIbohgA3lkw?=
 =?us-ascii?Q?kgvyAE5Z3QQ9S6QLIaX9r/PcZCz0aRXLrtUSIAReTG6KRXYbFRVH7yETvcWS?=
 =?us-ascii?Q?ZgJjeB/Lr5EYzTnEKY3dWs4n8g0MCAB4/uowXe148qSYBY/ZX7Ff/L7xR7YF?=
 =?us-ascii?Q?SbhT2P0seLtMdhqa2RSqD1iZxq9D0B8WWHYyBRsZ+rbt2vHzWGJaS2Lni8om?=
 =?us-ascii?Q?PcaOgHwpJb6rEEwmoXG9MRjqrfrarBSED8OFePfVmYU1EtvinprXiCETX6Pd?=
 =?us-ascii?Q?BTvoQ1hV5RgpnJUCVQ1IenZ1d0iTK4jcSHvnFCgsCLYTP45tz4B66pdca8WO?=
 =?us-ascii?Q?5kwkMy1ZxWauLUF5VM4bSrFIjbKvccxMn3uGd+PwhKZc3VVAls8L6LpudEj6?=
 =?us-ascii?Q?fQldmkKG96G5qDX4/lGDVpS4hzOcAtjyB2z/iiSxJALznT+KTVcQx7Ipep9l?=
 =?us-ascii?Q?WmaRGrV1HSn3+wft9X/gK594Zll7OdcvkbwJmSWkXXuXUeqLuSiSL3VKZoUM?=
 =?us-ascii?Q?B1UiFbcKzax27NR6A6cZ+xvRgAjHj63htanPcppkB+pRuQre2x1x/qxL07Dt?=
 =?us-ascii?Q?f+wx1y/yKJVKcbK8N4EOOcI9noIU+H8s/gwFLcwxb633KIgdLbxGqOIcGn2Q?=
 =?us-ascii?Q?9qnx1olDRMsAhTzZm3ilEjqfWNy6S1JLt1xjIXtkAzlqhS7c+/OZTet3ls74?=
 =?us-ascii?Q?eh5766J1bwJv0YJ6N3q8QRGt9XGoDktNoLa4/ZUvrvPWADaMHa6A8n0JKK8g?=
 =?us-ascii?Q?vnVxpPZR0ECe+4LJzc58JyuBwTbmKSBPeOKlePewQzDUPc/LgwAfa1ciMWRv?=
 =?us-ascii?Q?Jb4yYyPHtuumG0Hrw3dYHrKFzGEKSh40oOL0c58SqRwvdOF03scfNG5UG7dm?=
 =?us-ascii?Q?1NwX2Qwudh86IWASPwtuKNlbEGAQNCAZ1LwU8A5yu6z48eGXhZiJLGaUfYW2?=
 =?us-ascii?Q?iOnudljx9xQdRv2/PBg2N48lqihbEvW+kWfiGKwWTGm0sTG3oYV7vvaIcfhN?=
 =?us-ascii?Q?8+PDsbmlI+2DHpcKDKj7tqqa7qKcOGRu6LVXl2Am2zYy/ILHK1vanutJ+KIg?=
 =?us-ascii?Q?gVTPXXMQv1D/UNyXUS11afbKSYSdkX7/5BRgiwM1czFuJciOTjGDzrm5Hy4D?=
 =?us-ascii?Q?uDJ1KIIT0nyIiWDDT0yVw5U8GfQrIu5GasCLDIH3WDKrB6fRjQsVZtmvEhMy?=
 =?us-ascii?Q?Hlek/keIESb8Evs9MYS8eecNpoXJ42VCWwKB772ZfVwSDTwKNP2v7BjUf1CA?=
 =?us-ascii?Q?Uqjv83oA00icpTbOOPqXdMEN3+RB+lMz6Dr+avmPgf1cXi4If4KwWRRQqoWb?=
 =?us-ascii?Q?kKxJ5A8R0yRBzIpfBNfOnvHfHCqm8qxEAsZF0qzTRyyPgFpqMuJlZ3M87MLX?=
 =?us-ascii?Q?M7xq1LZvLmTfc9b6ctPWjlN54pECj9CEfM3ni6HoT2cXs5sxcuRzqt0acHqK?=
 =?us-ascii?Q?bHN/cCuTkOh7AroBv5ZQxRwycg0cLHAAXMnss5oXruIwR9sEivsfg/57QRZJ?=
 =?us-ascii?Q?AoPnLSDJDBzHOPHNZ80XTO8KGLFrXEArYjn9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FpJgnQ6KhUBiYZ0egNcfImoxe/nBwmuwFRtktkjry8kX7CXIcbJV/F6UumB?=
 =?us-ascii?Q?pn8gQ/M5z1A4UzgRsUUujm0fGSg+gGHAYPJauHyisdPyHQoYfqgkESpvezSC?=
 =?us-ascii?Q?oYV1CFof08Mj4zya7fjWgG/s1cMrBnZc78biMCm8la3NwmXUwzZos2dA5yI7?=
 =?us-ascii?Q?J4CH2PPBlns/RJ3Zn/2fPiX6MVRK5NxGzWVp4JjFmZlMrosRSbb7HQ534rbC?=
 =?us-ascii?Q?bmdY22ej08iHWKiP1NRmRk6SY+IU5mGIbt8iWt1LfCGg162IZnCp3xF7i7PG?=
 =?us-ascii?Q?mXaejcIL33OZcevDrQVNxcMJ65aI+7rWtWKYgMJ/8Huyz96/fFHknu3br0p6?=
 =?us-ascii?Q?3TPTpxYuaPbiQRsqF4pWIeSywx7dgS4VhXfO2/7cuOWAdGFAmgL73b0v/MHV?=
 =?us-ascii?Q?znpU/+pKo2engUyaNi2soyWl7hjVY5GxXW3/lUtWKV6ksnnr7RDTXYQweyTu?=
 =?us-ascii?Q?dhBmfJw+prm5ckdpnZX2pkolwgRSte/pzU4vetUrGMses9QhdZQ2OJdypSqN?=
 =?us-ascii?Q?LUz/L6QmFc8BDgM46zgwDb0ShKdzlNjo5/FhKAHJVawMXk0yPcKHMuweJGe3?=
 =?us-ascii?Q?s2jNUZwt0awXikZq3Nw3WSiAHTUc1PYUr3zk5GtFFQlSt2HU00S4OnE8LHx5?=
 =?us-ascii?Q?seDpRp4TyWvHLhFa5lX7zhVIs6eIOvAYCubv6FJRGbFiUu0yKzsrfpVyjXdQ?=
 =?us-ascii?Q?hk8biI7DjJy111K1YjLcYuUgikamJ/s/JXR4PKHF+TlWGSTp8NIZyrtjKfwT?=
 =?us-ascii?Q?ntMTbdYvUFjkgj7orbiNsSpnSlHDEcSDKlmXzX4eio8ZEYiXn73kpKfVbJBc?=
 =?us-ascii?Q?tLVtHGFhFxMsAuTgjVOK/a89Lbs+6hmcIKSLrRAb6hi/T6T1qEew2zy52LH+?=
 =?us-ascii?Q?1tt4jWkET7Cy4TYkpQFaLZkU7il33P1DK119GeT7zpAbUi8r8nNQ5RNXsZ95?=
 =?us-ascii?Q?RGZ0gQSqsVd0lsiwr2qpqYAH1WTH4lO3u1oKhoRCMmMH0cTaPq7TxkHGQoR3?=
 =?us-ascii?Q?4RyhPE7KIEJuvo5nr4ViEDv2tJ/5ckXC107ByUzs8Etn47BP2o1T8nRrVV9K?=
 =?us-ascii?Q?lAyWS+xzmHiHgRjlHhhzkX8YpfVBEvxsnCLjnTONBxC95SSHEepo5SFXXoNd?=
 =?us-ascii?Q?TkW2O/nViZsksC9VBq2dyTqeg4DZ/+SxNX9QFT8/JBhel8X5X8/gzINDSfvL?=
 =?us-ascii?Q?qPOA84j7IPIAPKFGpiI4kI8mWnEGygeXRjRemhcZ32A7QjImW8dNRuziNwFc?=
 =?us-ascii?Q?UJToGv2JvzWT0Y5sUAL3TBj5PGgNHBpeEN9ieK12HoCLzK1jJ8QyzsxzLpip?=
 =?us-ascii?Q?jl2yLPFLE3A/VG2IR97vMC3UJC+Sktsp876MR7H52xfDoJmWdxYACxrwk6+k?=
 =?us-ascii?Q?reDB4xoA1DHJ8pmAOd5THltrSNN5QdanqhX+anJV+mzs1SoPYjXl3c1Z7Z+o?=
 =?us-ascii?Q?CA7zeOIhJ+eZH5kPYAeSqcgObttvfI5mLcacxUekUmmQjVVWEEj4s0hEAZgL?=
 =?us-ascii?Q?gpQH2+MZo7X/oYSAmEWkrYOytq4RYd3QvmY1BrQ7XiqBRv1B5pKxCeDN3bVZ?=
 =?us-ascii?Q?SSqeZbZg3wd9b040oJcRzAcHurwXoAfO7YWdE/KmOwdRLHzE8eAv6n/CZzFI?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5841d45c-3757-41ab-a508-08de0ab03934
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:28:32.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LkNzAr+9Yu2lqskotQWGQ0EyIBF6oGm+H0bRh2UUxvyXk7MtLD7WFeUtEWoYm48EfHNMfkMOGwXPDPS6cqi890/1c2YYwdg+t6NtY+rf3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7368


Yang Shi (2):
      arm64: mm: make linear mapping permission update more robust for patial range
      arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT is supported

 arch/arm64/mm/pageattr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

