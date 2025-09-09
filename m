Return-Path: <linux-kernel+bounces-807090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBDB4A016
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F701BC4C81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA127466A;
	Tue,  9 Sep 2025 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JAUE6IYE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29266246782;
	Tue,  9 Sep 2025 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388901; cv=fail; b=pXE2C5kdtWxWyRugHtkMImWiJt0rKTsSrc5+B9CvXi1r90HfGNfDqE2yL5cae/20loB7+8DweGg6e0jnYl0HDqz47SsQdyXM3RUc0Kp6X2DyDnnTYaXss3Bn3OU3wrkPE5vYIYHZTj0FQaUkL/qtfpX+3OimYOmOawMLP43+034=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388901; c=relaxed/simple;
	bh=g13VXpXWrQ2pXrExRDzPD4QU41kTcSDOWJ88kbpC704=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LtGbSM4qo4cxGAZQft9dDUmT0IfvonwtJfa2hWQxug5nKPUmPkNBbXvwYwYyccwvcrN5qyOgH9CAtD7jDFudnnOAZZLZMnaysIvPLZsqznpEsYJO2ZCZCNGDoww5ZBXKufawcfnmj/PV73AKtV5MvJUAHH5/fB0oNhZILDsWDpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JAUE6IYE; arc=fail smtp.client-ip=40.107.236.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMcPrOdeqqVIOWd3gGbyxMCXhwMqT4I+dXj3OCE3PFAynn4mrHhkYCd362GcCPlPTKBpai2kC9F86p9CZsXJAPJppb5zQQLLrVblaczxjZToYOGXUTJjqA7QF0e+3vbJkdRvJKskS3lRRLBnxeewCGbXa+Aqmm+egHekmliNKIz6SfW8v2FguKsSsJ5H9KH7aoPKtmNbNDrwH7sT5wZ+yxfPDevOrjo/A2QHuDLiiRaVOW+I5ul4JK7IDYxzFbPmlel7Rh3BqGi44BANLQv7ZbSTurFKb/jHHRYNuTMf/W7c2m6ul6B0OF9ey3w/MLCP5BW6sKrY7ZiycT3pzvelQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhcQPBqPqhdxrmCFR4wDRk2xNbeL6gw+gjdKLWJpYts=;
 b=BliLqwLhU85gkl+KgwGGzIBb19ov7Ai4ekZ+02igjp152tZy43Gf3/9uKKj7RIgR23Pe/mvQzw951pkby0GPJN/wZnSrItUmzOuaMSOz0zoYxGPRsMBMwNiodUCZI8ZQXfZ9HUA8q1JoOvgqNI5CmEpTJPkltmbxbsDWI/8kVh0QNOuXwewIxxRhCkKPOu7aLTQ0CgkLIg/ewEloUFcvxLjjYLK/8DjsA+3eCDtwKgIHzPlTtbdHASjaaeOmoUkYujzcUPvjI8S2SiW+qjC6jbXLZ/cP600FFVbL/wV7sFxjM7L3YjR8sJpPXPQi02a43DkPdStXWnHAcxPVXiBd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhcQPBqPqhdxrmCFR4wDRk2xNbeL6gw+gjdKLWJpYts=;
 b=JAUE6IYECW1GbnVgDtFlw2Bu5ub4Q7uJ25oZ4E7krz+lj+WypVGs0zP8UavarV6KiLMpjZF0CCNbyvA5CZD9PsaNcZXq5Qum0m9JXrCv6Uld6sVvsxXFUTFHhow7DaQEtqOVrq6i+8GSgqFX9Yb0B3jlBc9PSe4IBQdoQYFKKkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8128.prod.exchangelabs.com (2603:10b6:a03:500::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 03:34:52 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:34:23 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	corbet@lwn.net,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com,
	bp@alien8.de,
	ardb@kernel.org,
	anshuman.khandual@arm.com,
	suzuki.poulose@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rdunlap@infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v7 0/2]  arm64: refactor the rodata=xxx
Date: Tue,  9 Sep 2025 11:32:34 +0800
Message-Id: <20250909033236.4099-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0375.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cd1418-32df-4bee-29b3-08ddef51c4c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LxfFc+d75jqbCuuoLbfi1Wnl+eBn01mzSsJpnY3w+ffISHouwD140TJerPmq?=
 =?us-ascii?Q?mwqwCxTjZLNq7DS9n07wesOmpP6f0f6jiTa7r2KFtqzXyXBVFXRlwLjGN86j?=
 =?us-ascii?Q?zzMCZ6bnsM52LawUkmoXW+6P0T2DR5WBrdMxETW5gnAqAqeAyKOuPGsb875m?=
 =?us-ascii?Q?F2B2naGrEdnORk7DPlJaqN/3ojM3h+2FzQ0lDbXKvv6dg23ALV1feRNspmvu?=
 =?us-ascii?Q?JNUfhtGqwwhefXpsoW6dRqwfJy5jO4EQHDUmUbNFIdyjjtGLsEUQ7CLiuRyo?=
 =?us-ascii?Q?XNKSKXCCZxKfwCfhcZCdVd2Nd2vtaiYoERylqo4O92CrtBrv6juG2ySIaBy1?=
 =?us-ascii?Q?AIqfuwEIM5suVEGf8RPUkG8zc05H0T0FMN83DVHBYhvZWhNirHVgsX3/s4cw?=
 =?us-ascii?Q?RPASZcM3RV/0NHKOepvCf0ew7Rgm8gyKM6Zrw5OFPvWT8KRJBMx9YnRTFOXa?=
 =?us-ascii?Q?JSMiY+9Cx1SLKM6bgHzaxCzOyY1OEMooGjWD4RizQPfoMW4XegfBx2B329/7?=
 =?us-ascii?Q?Kebk6J1JUWqR7rBm8duUYk+LLO2w7rD1ydUaOZlOb6EeJLro0fUyTKFkN2jR?=
 =?us-ascii?Q?rsrOdP5WsF5+Yo5Qw8Rs2GK0lDTi0Gfu7mz0aRVAmo2nb14pnSEz2zB+2pCl?=
 =?us-ascii?Q?tVJEpJWulVpobZ7iCfTn+3alDgjMjmU3ar6itHdRwgL8X5VIquVHkWorN/1x?=
 =?us-ascii?Q?rWN7+9VVdxsIo05X26qZYHEOG7yBPfJQZGVRSOVprsYw/WsoxA3KZcgxdf7X?=
 =?us-ascii?Q?uLTcy6mN3Cc2p1Qd3po72gnqOvjJ6384X7ZoOIQJW/psfkFWQ9xEzfCFozFE?=
 =?us-ascii?Q?7GOngdzztxxczsOX17G0Ii29OSfSMFc1Ejs4PsEuGgFhWWAWAjHoHFAimdMs?=
 =?us-ascii?Q?bCKtPQVvD1PHoGxxi9WOHaWnWWIF6jQW4BU6AtQQyaJYxVWPthk6EOVe4yiY?=
 =?us-ascii?Q?nWfbdLJweDtFuJwFo4IUdQTWsyBZwhCBQg7RaMYAJvvrmyoY3eMyEBEHYomE?=
 =?us-ascii?Q?tt18QtrVn4E7AJLWV68f40p9IeZS7BGwX0QVT1HcbuiVsF5GmQXG7GJ5YAsI?=
 =?us-ascii?Q?2LiGXTOMRf7hULxp1dsfumhahY4D2VKgHxFVTXi4v9GrYr74B9ZRQQaINZYm?=
 =?us-ascii?Q?+1VKVojSAyVndbGGvPZldPWwnPYql988T1G+zrnKRNM87DHTem1olI17L+5f?=
 =?us-ascii?Q?8zT9yCo8+1NXK8w7c/6RPCpgFfguSKrEw140cb47HZyKub952eHJ7X0GxV1q?=
 =?us-ascii?Q?1b/x8Oh+Rku1GAAd89OEnoahVvzL5cVMwcsWJsP+kBr4oWZ5l8YdOjtK120D?=
 =?us-ascii?Q?UHvP9mhIaPhSo4OynTzhrC7IjiXFM7etTc6lu2cI7iZLwAHMz2VHvNJi3X/d?=
 =?us-ascii?Q?vRqV3cnr/KOpzsYoX9CB8k0PYQFqTut/UITx0Zr5c1rowx5Z46B4cP7HljGv?=
 =?us-ascii?Q?gWu4I5eHXZnz9wJ7us/2sQABL/vSlsAM+Xzz5qM8IQbY9OnqBlMBRQzh7OMf?=
 =?us-ascii?Q?V1QO+Xkm7FOppYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcqHArLoLGLoZ+SbjLJEbzD5NrX1yCPUQYD9JdvLHCqq2HcsfttjwgqttwNQ?=
 =?us-ascii?Q?Nue0L9SMOjX3kCEd2yRppo7eBniwjrm07bOyTSvww23IiBWPGVziBaMeARzB?=
 =?us-ascii?Q?pl5bRmvPXUllG3PjVhOamtNvHybQZO/wMCg1coXrhhsgGGhISgjfJidPBUaF?=
 =?us-ascii?Q?LutO+Yvj+jpj6DPva1lyiON0+npKHI9/QhhWKJHuzG/Eb9fXbX0AjpBVJkI4?=
 =?us-ascii?Q?V59rEy+0rddRfcQOlOW2f46UxFvPz51BHIspIE+8d9WbV5oItJ1mQNgBm+JK?=
 =?us-ascii?Q?f1VK9AsYvqFLuI45vYXgWuCugXP3oRN/b6V8oaZlyYxFDy19fWEnk5dA1W6p?=
 =?us-ascii?Q?M40aQObN1RJtXX+D7Qm9xgk12koxE5zgIsv6bmfWk6NMyKPkkKDUl/tlGWOe?=
 =?us-ascii?Q?31YO9QkRDt47nsjl/SGRCnv7uXBgtAWV3DaxC4XR/J2kdMMjoRxv9QX0xZ+F?=
 =?us-ascii?Q?XdEgiHl2W/bxHoKS/Twv2zeHRXGS10XcYUaYIHR552GXHlS1AtNFAp4Zsmot?=
 =?us-ascii?Q?MMKeV3/iPQaRzJ1P1ZrLKq+ouX9rj0pl/AvLr10DMsEB+UDZ2O+jgrNjjZxy?=
 =?us-ascii?Q?b8Yp7v+1dipfX9ywgLiHw97oLHZxzoRw+fcILbfcxs6EZQKTeBSBmojm/8Zm?=
 =?us-ascii?Q?mbFpG8t/5GhWu0UEjGL7afFOko1zeADDZUOGB5jzBDezngJytnBa0dDBVOcC?=
 =?us-ascii?Q?ByP1iFIKksm9Ld19NG5t7Awv4yS7NC1Jwp45+kPdcTddqW2UgLcRI72oBsk/?=
 =?us-ascii?Q?pNn5WnM0VGMdVoBm70UYXbKJtnARDsl+LhDNu4gbaplcUd1gCLtrLrAeHinl?=
 =?us-ascii?Q?1TGgE9bQpOACT5MZu7dDEbe8oekeQRJGHI5ZQSE2dyYH3xHUorN09ao5KFzs?=
 =?us-ascii?Q?WiozohV9UbDZ2kq6+YouViMAna5kl1NPBP4oS8zTwhfkso/MxpWb9wdvt5eI?=
 =?us-ascii?Q?J5vE3q0ANCDPMAfc3bRlCtfI8Q43gIadnKRFDFi7cpT04nLDyqxlQlAAK6fF?=
 =?us-ascii?Q?MALaDiiBINbnir9y5cO2yW4B+PcysThPYR+aZ1JCZr4M+8A4FQ/EyZGJluDt?=
 =?us-ascii?Q?b/u9BHRN50okBxCftoSgv6fwWxuM95SBSVZm8shrwF+9Zflg+UkjiYaFlKfC?=
 =?us-ascii?Q?uIPRNkn+0BuZo4q7VASnbCmM3Y1Gj1mwZ3w8y9uBg4TrUelZlwtHOBVwHC81?=
 =?us-ascii?Q?/Kz2b0qJnZzU5JO/iUjs46k7MAMNmUIIwyVnC0aMRp1Kel1OactJYMHAmEwh?=
 =?us-ascii?Q?J5uEK7pQtXTJUADd6Lyr+tqC7jEVlYU30j0n6pTkj0M6cW4lMVxLO/BXK0sJ?=
 =?us-ascii?Q?7AnhZdDstgjSeUE/BprQHJbuQCukBrpJ5ucaDfUOFFklj2VxUfvrxuFuO60F?=
 =?us-ascii?Q?woxZzVZ1Z1V/KLmi5j3DSnD+wlYFg983AuvIaRLNqdaJ07t75WtlG5tSyr9h?=
 =?us-ascii?Q?4wQIzSBOhi8anOBQH0mwjcNwuz8D63nBuPknpVMvlZ8iYbc6VJo937EzVOm1?=
 =?us-ascii?Q?Ia/dHebIviy76MaAFIxHR3pE0+g/PPP3SJe0O23ScPWnQCUT7BottNQRv9ku?=
 =?us-ascii?Q?+lrJJxnT/RHQ9tEzzLu69okMtxWLIk0/jjsjTkmYCtlxCPuAAUCHn3rlC8f8?=
 =?us-ascii?Q?lQs5661mZq1Uh8r/B4UCvbY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cd1418-32df-4bee-29b3-08ddef51c4c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 03:34:23.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFrfFwvlfFIitNFhxW91z1sSTVk9JobAzWpF3dkMfhwbDDyaamWNU+b6aPMkMWpF/7kG6iQWhxWGojQTQ2VeUnMplPxiD7hR8soSHPnR8m2NMt9vNZ4maxTA4OFR/z3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8128

From Documentation/admin-guide/kernel-parameters.txt, we know that:
 rodata=	[KNL,EARLY]
	on	Mark read-only kernel memory as read-only (default).
	off	Leave read-only kernel memory writable for debugging.
	full	Mark read-only kernel memory and aliases as read-only
		[arm64]

So the "rodata=on" is the default.

But the current code does not follow the document, it makes "rodata=full"
as the default.

This patch set follows Anshuman Khandual's suggetions.
It makes the "rodata=on" as the default, and removes the CONFIG_RODATA_FULL_DEFAULT_ENABLED.

v7:
  Change the code by following Will's suggestions.
  
v6:
  Fix a small issue pointed by Randy Dunlap.
  https://lists.infradead.org/pipermail/linux-arm-kernel/2025-July/1041488.html
  
v5:
  Rebase this patch set with linux-next20250627
  https://lists.infradead.org/pipermail/linux-arm-kernel/2025-June/1040297.html

v4:
  Follows Anshuman Khandual/Ard Biesheuvel's suggetions:
  - Change commit message format.
  - Change the titile name.
  - others
  https://lists.infradead.org/pipermail/linux-arm-kernel/2024-December/985629.html

v3:
  Follows Anshuman Khandual's suggetions:
  - Merge patch 1 and patch 3 into one patch.
  - Remove patch 4
  - update comments and document.
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-December/984344.html

v2:
  Follows Will's suggetions.
  Add a new file fine-tuning-tips.rst for the expert users.
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-November/981190.html

v1:
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-October/971415.html


Huang Shijie (2):
  arm64: refactor the rodata=xxx
  arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED

 Documentation/admin-guide/kernel-parameters.txt |  5 +++--
 arch/arm64/Kconfig                              | 14 --------------
 arch/arm64/include/asm/setup.h                  |  4 ++--
 arch/arm64/mm/pageattr.c                        |  2 +-
 4 files changed, 6 insertions(+), 19 deletions(-)

-- 
2.40.1


