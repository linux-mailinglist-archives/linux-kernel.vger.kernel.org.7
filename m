Return-Path: <linux-kernel+bounces-724826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58494AFF74E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152D5A54FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9888280CD0;
	Thu, 10 Jul 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eL+w5Dx0"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23A2236F4;
	Thu, 10 Jul 2025 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116771; cv=fail; b=pizr1KFkoYUoFNJ57tNuuoprV4ENY5z8Z0qXQKj5R1ApMAARRb+9/KRHW7BhQUnvAfRi1QC0FQA5N2I++WNwUhYl06PAnp6jjSFDbr66TjTIEzKW0z3HENPD30T0/tPAzqyPE9whL65rO/xUJxx7RDOvpZuFx2R87jfy0hYITnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116771; c=relaxed/simple;
	bh=Kdm7IUd/kZLoXhnchTrmafIcr5KUABSP/K7NARprCEg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Msrikkj2CCLRVRSmW5ODGCm06gBaaf3DQSPIZ3hu7BSJDRgrBvEO0IkdDHLjU2o8SpqKdMsMSwhOanOxe8aRzyghxEvV6G1NKn6TbsXGOTX0gmJZWi8L2vxpb0SfIui2xmc9pC+6xhcfZeCC2p6ZzzO89+oK6K2WGnZnTT9Qa64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eL+w5Dx0; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYBp2j3EuVzHto2UPs5/D8/nTMU+OEauM9SFwe9bu1yiCJIPNcl3YyhC5BxlV/nw2wZwNQMSWHZjLx9xs/dGILwq1xWvFGBfg8o7XuJE1yidOEKPvecjiqVZ+5KBqWKNcdDMFVBcYRvBSbRVW0Pod8FTPuGZSc4DMapNtvvhoCV+/J+d9AuvLZchEVfXEfqXvyt5wTfksdhaohz0Tb6dzE0J7EpF3XR0qnIAWjePpELggJndW+MVVulFA59Q62/Y2or7GFfGKSqHd7WfdxZEMmsHXz2WshJ0gJdNMrMQ1Ya9dWym7Uvec4fuLauQ+3FMTxFju3HR3BXEuESse4j/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFCGFh5OssziJ5mNUSH0thPYwgNQhSkNJZRfY7yRSvU=;
 b=n8XtLazO6qcX7mXibwkTu4DdKReVmCb1HXisWvmyMWp4V0hfOoozeUu9xEpN0KwFfC2F0qZO/SyGP2ynTN76yx4s/ty9ZcbMzFV2BBfFcMn95MedeMyXK8tS2pRTjVGAopUkhM6k2hHK9235HcEjlpY6xm71lNYeY3xZFcNIuDkFpIDUnyuJht5xV3NFBy8rMP4oAPAKU6ukXOSoDvk83op0g5fdX+R96KN8qJwl6AcWxjytAauYliMCqIaHBk+fDU6ZYYudi38OrFWV1nq0kr7wE/Gs8dPjs4Wo9E+Kne8P7Qjw+WrQKcgh6o2YyvviIeBuRxf87uvPgJbKun9R/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFCGFh5OssziJ5mNUSH0thPYwgNQhSkNJZRfY7yRSvU=;
 b=eL+w5Dx0PK94d1bWeuwXZpm/DB5VeJuTuLBDD03G9KPSY4tfvAFZpL7j4fbItvMnu+KkP3OeGl+ZouU0MLJ6hWMbnX79p7O3UndxXPXHvJgn9hkSrwRWFU8NY4xVH6/7rJyn44vBJl9KvP7fReCgNua1M/k3JvgWJF2Rj7iMUh1prmpwbfI0wjTtyN143wPe6YxeygnG541w0NtO//hhwNiMQO2ls8kS8cOBM+G9qFOeVkakATIigcPwzTWBc98v3tyh/qixFT/7q5TvSn3zzH5An5OLnOapJVLQdKWpoLDh168JkOI46pMnp6AG3TEEN5WvHji1nNltZo6B9HKkZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by FRWPR04MB11221.eurprd04.prod.outlook.com (2603:10a6:d10:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 10 Jul
 2025 03:06:06 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 03:06:06 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: fsl_xcvr: get channel status data in two cases
Date: Thu, 10 Jul 2025 11:04:03 +0800
Message-Id: <20250710030405.3370671-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|FRWPR04MB11221:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d597c89-22d4-4f4d-e3da-08ddbf5eb645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zgEFXbqPBKmTuFEgPZMBgAaCKflIeiZlgdhq4vy5eZx5f2XNZFwwMxpuvmp?=
 =?us-ascii?Q?R22TKGpeXal6pKUdn2Ug9aaNmIt2jdl9OqGUs5QdgIJdYrXMGdXB/TG5MdeT?=
 =?us-ascii?Q?InYh/Ve52YgcnpvKBgyup1jW4H38SPQE53Az9+iT84oo0xZVvcxMFZNUNpih?=
 =?us-ascii?Q?LhUfz08mWUjKf0OGfnzWQ2+3NuBlY8w+60T8brkPtt+fJB6AVjyAxdFOIGjF?=
 =?us-ascii?Q?m7dK4zmCK8rRQUudV+fTLCIwne9LqqJzhak9cvwbzP0nKWWOda8RYDU15Hk2?=
 =?us-ascii?Q?nTSl1a2N+gmXGn7WZoGyV4rYERsu7qKR7p3/QeDRbZd2n4+5vFiDOag+9JWr?=
 =?us-ascii?Q?4mPBbCjlwWgHJxt1gFSiecL4pYKkQKq1zNkjJegA27LkRU4p/iQS3EGjvAik?=
 =?us-ascii?Q?LMeHk8G1B9Lgnpb9GkRMNH4v1wHVOfPV99Dq3Lh36jRSH8SZUYqkahD0e5Yk?=
 =?us-ascii?Q?UPVM6fFhuss3b1ctZG+vPqrr7+EcHrwj7t2+g1zgNlAgBX+ZkxPpiaolVVlQ?=
 =?us-ascii?Q?qTeHtBHsA5TKTfhODZMCGZ+2AHt+6DzaaEeMik3iilz4BMJq0p/y9q5LyXKc?=
 =?us-ascii?Q?wTBCM3mNSYD+G/dbEEfUtGloVb18q6zyYk+DPckEzikzOQUdmcv6R4Bb7tDO?=
 =?us-ascii?Q?2CFtvp5t0gR3gp0v1JpfD6WmzYCGHwJVM5MxWd4E0xNsXBv4x+wn/SDGlsOd?=
 =?us-ascii?Q?7RrlEfbLkT27+JfX0FJ97FH6OTMDlNdGIvHkeT+w6YlmWwbXQ2HLwTUicEQ3?=
 =?us-ascii?Q?R/AHaqRFFRFreKPcampOCmSHdPpSFGsY4T4/VX+PBJo3+QfojhxUD2zznz4X?=
 =?us-ascii?Q?LHls4bfgCwvXMbNWbWKzZRUdjXRjn5Qnl5IPr52+8Z5oF3cIn06kNgB6yKQd?=
 =?us-ascii?Q?4PP9Nf9hrPzThUoKh/VpAgOrvG3K8wBxoEhC7YsmyowGJGt3l/gMVHps6u0w?=
 =?us-ascii?Q?9nnXhFXVrSSmSYwI+OR+8SmeEczDb+MIkraZ7SEYMJ0MRRZl4NHZsKi840tY?=
 =?us-ascii?Q?Q6XPMLHtnwODhKVGqpuH5w5KQE651FN5/n+OTcH0nf66JNlzDVvl23Dq9yoF?=
 =?us-ascii?Q?4lG/ch6u+i4SxzI2URzH0Skb7vGqlXLs6JyAboRdvbfmtYf4DpukOKBSbCLe?=
 =?us-ascii?Q?HckxFWv91n+p62tbE4WJF/jZ9oSiChhktBjVYQ8bpJfcu1b6D8Femv7zmLs1?=
 =?us-ascii?Q?s5ENr3HEcBPbnR6nfYYxyhYQCJxGDSfO2qkWwTeedeJIcNiQUmlly2BFZTFV?=
 =?us-ascii?Q?P2HPtTLSkHofQ1KHcGNBHF9Swph/MgKnFIs7gBnz01bJb6Sl44nAEMhuowgq?=
 =?us-ascii?Q?44lAv1HFOR66M+atrsTVd8DmjbWeADzA4xxCdJh+mur1Vtja5NKf3s+qe4PA?=
 =?us-ascii?Q?iHamEx8l0itp7BsihnEICQOIg8eNU+gr1eBWFUPS/iWTgfrPVBdKvSHGac9v?=
 =?us-ascii?Q?P8W159yOqnauEWlfQeVp93g0RgthNSgSjMx52//6iqsNpsezT4/2ryZq4vnh?=
 =?us-ascii?Q?yG4G/e2HEGAC4xk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FA5n3BdvfnyYivrFPbXJAbs6MjeiCK9sH5ZwsMgA/4qD3EgMrIp/8IvR16z7?=
 =?us-ascii?Q?MpPcyyywyQmSYTnF/At+EZJi9rcND5HAhjK9hm17dTXTNPNW2ws+w5ELjaUq?=
 =?us-ascii?Q?q2v2FzZZV/BRmo31agtPlFtUmGgA9lfCBH5ZAG11pVloKaZIrDfpOyeTwyEw?=
 =?us-ascii?Q?DFJ3hlLB+oYNrBMj+XMIeX4iMszbbJJW6XTVDwWcNQj3imgdUWsY+rkuGYDT?=
 =?us-ascii?Q?WCm8DH/+iXUqjCX/K1uVwTR7dQaJaSraMP7xdyIG87vimgBTP0QtjsqwTCub?=
 =?us-ascii?Q?T3ij10VZNvm/ieUAh9t6eaQ0fhYf2swwrXbraMS8opatIW1h/B7BWWbnhnUJ?=
 =?us-ascii?Q?1CS/z6WExn9x02UjIhtsJ4raQfxiGx5j5QnuTHX08qo/SqlWhhbUngQNR7mw?=
 =?us-ascii?Q?g/EZgaPfkGL2MTCLXBa4QPExgAdDnNxwzflgFHS07DIPUk3O3/xfEzsiZpbd?=
 =?us-ascii?Q?df3t5gAHc2peCUpoykPY6riMZ8UKI7dYsvLTU4TCQSoRUAx0P/OyxPSDphLb?=
 =?us-ascii?Q?xS/S883uofPLFnO/MA29+r9378Qy3prXsnQ5zYNq/0A3wTuN0TCZvLxxAh1y?=
 =?us-ascii?Q?VEVIz6LtZrZ4myv+020ZbKuPuc/5nbUoyQu/Np1MKgd8v6GDjunY92CktszK?=
 =?us-ascii?Q?OcXTFKREUCgv/auD8VEzIsMGuHWWrkoD/u9Q+OGgjCd1/dT+Dqm+Dp06CsES?=
 =?us-ascii?Q?e9MBKwa8Xr9JIV00fyZp69upsi2bVf29xkp3J1TvdQa3695UByQiud5j1EPn?=
 =?us-ascii?Q?k4eQ+JG8hN4hWjJYQ9/X7AXANPKORiXDAaHmpbf4IudB90Wf4o5T3P/upTy8?=
 =?us-ascii?Q?HwhkdfviR73Yt5OBCvQToN1lOQli1jUFSFy02Cdos7DJZOOsXrGxJPsYjvmN?=
 =?us-ascii?Q?hj5uI4+KItgOiHioR/bimvwOfffWSKGvN5aESbAv1Uqq7LFNVsClsY+H+6I9?=
 =?us-ascii?Q?OOL8TlNCe5g/9U2ZH7eInsnjUcDdHQI8Q4/8sj+sUAV1BzQSrV8nqH3zNQeG?=
 =?us-ascii?Q?toR+O2sj8aqGqdr62j/4wmRi5MGgLxz15jZPufcYEJW041gLOJLn+d4kI9Nj?=
 =?us-ascii?Q?glx/2GBbZMlyzSI3PPt760NUfPVu2tMd5W/jL269i5/7vbx2wOcYA0hkby2J?=
 =?us-ascii?Q?QBI/c7YjX86U9f+Ig1YgKT8/8/xi5rl3FBJUG/NkPSwFfA78cWOozbWTTJZ/?=
 =?us-ascii?Q?ZN+/I9ijns7hBzkPkdvNai5vxTXt+ok6DJN32N+5aY2UIUqv0w0IlwH9ujFo?=
 =?us-ascii?Q?7RYp5oEYhD07XSjpGqP+OsQ7glYYihdpkCzj2W4F87QbyQy9jffrUDNZkVZc?=
 =?us-ascii?Q?pA/rOWrCk7cKMGHbENi/mqRSfKF0VwTePZfgOKIuEDfz6NHBmdfwI8fb8u7y?=
 =?us-ascii?Q?LZ9TiAlIyRBrQFTISbt7RePtbnESIRsSEc1FCxpjIhmppPuTkDAcHXfL5HYm?=
 =?us-ascii?Q?Mno5KWNzO3h7+i2Imc5uhKu8Jr+obDDq1Is9uA/V6evUnxFHnb3ErcvSbqWi?=
 =?us-ascii?Q?LJx8rW92vJRirk2MV+dLI5/Sgj2POWkuV66w9mUwQj6w6tEiY13StC/F25ok?=
 =?us-ascii?Q?OCy8qCWA083Lgzr11pjP+QBxJ4E5jFJN5CJ6C+Ql?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d597c89-22d4-4f4d-e3da-08ddbf5eb645
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 03:06:06.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eik9Wldhq0z1ka3hV1OraEJDyEb54dV2SgZVce36tYdaeqbXAuV1xDzpf0bu1rO1dx70ECBO4nGV6BAuMMt21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11221

There is two different cases for getting channel status data:
1. With PHY exists, there is firmware running on M core, the firmware
should fill the channel status to RAM space, driver need to read them
from RAM.
2. Without PHY, the channel status need to be obtained from registers.

Shengjiu Wang (2):
  ASoC: fsl_xcvr: get channel status data when PHY is not exists
  ASoC: fsl_xcvr: get channel status data with firmware exists

 sound/soc/fsl/fsl_xcvr.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1


