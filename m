Return-Path: <linux-kernel+bounces-750769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F45B160DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D4189F297
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1522E36F9;
	Wed, 30 Jul 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="isIh5mqG"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C2256C70;
	Wed, 30 Jul 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880382; cv=fail; b=VVB1Kswo1qHemqMfTkjyz/Bw5EZY+s2n5DAG+f2d3c0ccS3gFyIypu6UA3ljYYndYW2BY5S+CxtNu9yi2esj6ZpU7RCf9lrI1eetMZwUM8s9UVVUBd7oGJ2K5kmaiP6lITTni4pT73oQrUXZ0p8mtQUKYkOC97opUuZomEt6GoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880382; c=relaxed/simple;
	bh=W+5ipbqO3C96O9sFwWV5dM9tMTjTrjASFrS2qq2NLyo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gWKpeFs4+1dF0j3LwWmPSxOOVL5m5WHStu+52RLtVY1VXQcLytd5gVwfqSIsGoq8Cf4uEUkoZdnvhQU4bSGy75C2WsA8T19ZLJN6jfNTFcNTpdOHlUX3keJJLQBbB0HsCfR4ubuRmk/nw8o3dt7jgripz1lia7dNpqn3SgF+TBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=isIh5mqG; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCUr/ZIzPZFiPInqoDyOxTBunew64+PDxxI1GwmPOgiB+XGnTRpZbf90ygRFnA16SfzLIJJMm5hr1Nkjg/7a7gaCLtt1o4Rg+aiIt9ANXSSoRU3PFvEAjkhQqxobK/TFs7S6pI75zY2xOlmw3TB8w5EqbH7xcNceCtUcGb8srtjfmH9VXdXwp1+cPUEnyLaiPeaFY1xMXHzu8HeOsKr++liIU1wa0Lz1v8lsB0c8g9piEpdJoj7xf+nxWXAGVKjZJyCD/TPaUz/jL17FJze+5k3Y0SxrR8Z8CRPYTPAFsVvg6Anxobp8VJoiczubAjwTBIt/p7p4cCv1XLtNkQZVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQKf0rter087prd8cnl4AmYBcUlEp49LOtxOuYf6bHI=;
 b=O4j5K4dAVKsjioD1uiMhjtu+KDqSv3ADMEs7c/Nw5JakgO0lukQ4Wm1U5vDE/xD8ZSZAlq1TrhW5PEggUSpI3OrIDs6kxi96q+PL+dZ4DD9HZtqQM/n4PF42asxeJDwpGV/ELHQXXkGLDXshXQZs4PVctW6paxSimvkerS9XtPQfO+Kwl6xcML+V6Yzu9rtTZEYMa+SjBDZR49+o44GN4/rKQTWBHsyluo4Z+c+P2BLYqoPLUcXq/7VjzetQSeVdtKuifPXmqbyb/ukoDSf3U4C8xjXvj/zoDmdgDXZoTa0c8Xv9Rf3hLTXPkkcisnpw/hFRnROblhgs7moZcSfYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQKf0rter087prd8cnl4AmYBcUlEp49LOtxOuYf6bHI=;
 b=isIh5mqG44g62XsuNZ5he9ZeSgSPjr9wUgTGy3NTHTxUxwcHqhyt14nrUjfF2TXMzeF070aNcc8JD+CnGxTVJCyWyRkax2mXveVNVXKBD8AbXRAtT/1aMnWjKtRnRqronBC5IDRvI0bE4hxBMJBjXEukrXXM9i3bBx9MFJ5rnGdc9GpV031nPSzWPdn05AIvC6LgSY48lA+9cfei8Gd2tWYbNzivTUmYEMeXyiWGiQn1p6vFibqRLFlCzdfLG7DBux+EGnyvD+S0YHC/6YNB0YHaVBRR/0Kn/D78oHfLXqMeIdf85mfIfGTAd+XmIrc/yeqgxAmo2CScFrvYaUhbYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM9PR04MB8763.eurprd04.prod.outlook.com (2603:10a6:20b:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 12:59:37 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 12:59:36 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: imx95-blk-ctl: Fix runtime PM issues
Date: Wed, 30 Jul 2025 15:59:29 +0300
Message-Id: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::15) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM9PR04MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e465812-269b-4fc0-6528-08ddcf68ef69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buNg7aPwYXCXbgQb2KnUNf7AcvOndwAgyPqAbsU/ZQ8/7gMMLv2SLMXYlfba?=
 =?us-ascii?Q?SKWOyDG5xdfVyDVbOLkPkCgGN7zhUAWepkmIMyT+yCeyAGZY6/vk764cw+hv?=
 =?us-ascii?Q?XtRQ9pKuGdeQcQBWPppzGimWpfZ5ykvnkQICufD+Ay9XO8ZzZH0t1GI9e4E+?=
 =?us-ascii?Q?8Nth1+FzxSK9qI7QjkiEWS1jSHxrwJq6ZGLgp/9scWEnl7iaMTIaYrNxdrLo?=
 =?us-ascii?Q?iBYTicvkgR1heHCeoDQMHqfm37OTriqgGqeqT3xr/1g/UrFmqUJy432rBCpH?=
 =?us-ascii?Q?VTQBpCPmg8Shkhktsvzpyo84WQbKK2Y7HH+OSNuziW8DWx9TnazJZmlJPjI1?=
 =?us-ascii?Q?2cPPb3g5EPsk6ztqAdmqzehJC9Am79WvI/1YfYs8Sd2LQ7tu5WHnECzu0XRH?=
 =?us-ascii?Q?qJ7nYBWb5D+gW0GV3svikauHy+Lj4k9CjDlK3uPeJF/MjPRXzHwhslxUmhVg?=
 =?us-ascii?Q?sMWfYoIE28NMYdCElaP13MGFhmvwwLyhP2hzwJks/iOri8T+5G5NPWBEHl93?=
 =?us-ascii?Q?fI/tdrIaiWjMZHL0ixj4xm89zMnx+9/2+/MVtml0+dxS7vazynZMvVgi3GPH?=
 =?us-ascii?Q?r8W/cO2MBAx7mYdhUJ0x0l6iW5pOZtPWndX4P2zz8U03c41PO0t3OjHBJuMh?=
 =?us-ascii?Q?Phgvcs3FWzlwLcKaJVl1wDLD/zGXmiBRx85luSNv2jV5Wpx8PO2SNPVoJ6PW?=
 =?us-ascii?Q?uewe0wO62MQa0E89u+LJCY2kMEYqIDAvLn/4WbATxN1x2ccWerl1+rHA1EQg?=
 =?us-ascii?Q?UQ6QDDtJklCFyV1xwF+miV8+f1MDhqVQL+HiXRzhLZPpVQOqClBdvBHZI6XE?=
 =?us-ascii?Q?Kz+VzikTHXj/2RsSTzgkN5v2CkWZg9y+THCltKZuf6hyPhHNEzCzOhA2XB8x?=
 =?us-ascii?Q?fwincVkY94KdWbygmreu8sLuns9t479AVMpvQQgiQbLKgOKbfNXj+TTKqgnA?=
 =?us-ascii?Q?/Wxm8q90YkNxDkxKq3Ezv7CcXuvJBsh/K5mcHFnUY9URa6Lf+ReJximDZojv?=
 =?us-ascii?Q?B0f53ZuhrLOU7X+G948fGzurcXQUmIknPgQ38SusuKm4DBT+WqWqDkEYpWfd?=
 =?us-ascii?Q?otwh+vUiFmxlJz/ZJDOUmvkR9evIVRQoNe80nwhumjd24qGsppa4pNN5JQnI?=
 =?us-ascii?Q?GM1nG+HNsYfE9TEf/mKEfdcoVcaAp9dMuYoMOK8CAiRudspWuHffx44ISEvp?=
 =?us-ascii?Q?DbbqPXWMfV5XhxeRCIZo9whtdIvElZr3EVpcfKA56NSic6xGaM9YIFm4Hj6Q?=
 =?us-ascii?Q?hOaqaRRaKmhgZxT3dEfhFBYjUT4mSjflCIG71fo11jkKnRqrxEE0juX8Q0n7?=
 =?us-ascii?Q?d0HIs4qT2Ssok33Uyg1i6AUEiYp22Ds1dd1qutJJVCh5smDXwBj50MAXOR6D?=
 =?us-ascii?Q?PdW07gA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myP8hg1QM88CHmwJKaLeLX+fFFr8tBWJjuhkn61Z6j6Ac1HE4+mrhI6u/x4O?=
 =?us-ascii?Q?2syXwXN/TSOFKfGoSswobZ46jyq9m3pWkbqON7IOc8cMS3v8f23Qh1EMDPGQ?=
 =?us-ascii?Q?55vu+dZairxarw9mJqNO+eVDXdfN5gL3bpMig/Ari5dU/hihbbKEgRNkS4zb?=
 =?us-ascii?Q?VYkP2oPVk6//SY6bo8ZZ2aCUKCFtltl0dX+PzLBHIzzsM00XnlnABs4VEP5W?=
 =?us-ascii?Q?BA+ScW6P05SeAsel0MauYx6rI44pNHBL4oITXEfsPvD+vlzRCvhYYIsB2E6r?=
 =?us-ascii?Q?yF33U1cb4qENeu6Y8IlDY22ZPi4SyjTt1uRiiDxjbGQRsn7JO4IhzMRuU2kp?=
 =?us-ascii?Q?I43fgPG3VUbYfuyAEaX0GzRx8SVTsJAQoJoQw4+0/Q1kC3N5udR86nCf8QK+?=
 =?us-ascii?Q?r+W0BjoQC61sq1FA4NJN+hgwv8xweF9jma+KQYjRSwsQDFTAUMR80CHz+6b+?=
 =?us-ascii?Q?cLD4/3N6XpjJkKOF6MMRXqafdGNlzPDNbIQpJiGEIPvwUrP3Dk/cQohJIGt0?=
 =?us-ascii?Q?DNp4M/oscpc03tVUurnSk3B/Ftn19UVgQjqHadWj+myrpLVoMV5hPSQEGXUM?=
 =?us-ascii?Q?XjNo1Zltz9c7Ila4Go23PqHvFu3Yr4IYTdDUVypeer/nG8e12DtR81wBekR0?=
 =?us-ascii?Q?WWY1fj2X0QpYOIMojfs5HwHmcoMaqMXERc6pMAhIV4BfR4F7lWajgLrvCOhs?=
 =?us-ascii?Q?W+ORnHBCEXUDZmm0O+lzZ7b5Sj5366Yu/TNjqKvX9Uh76DwpVvA6WXslh47D?=
 =?us-ascii?Q?K3cCKDbewnYfIs0px74dFKO7QyWJnvezRlrmgg2Q1lAFnXgYGR0LbCl5Tt5a?=
 =?us-ascii?Q?SKYLu3bkOgwJpNTVAyIDEUnsa5pI0epASBZLMT+bWws+26T8WO2RCkTPUkNo?=
 =?us-ascii?Q?7Og0ugBW8lS7PVTTtjLSJYw+oprjwcxD9UEE5gIsW10W5tunE4KS3+uGWkSu?=
 =?us-ascii?Q?JYiNWev+bnKEtfJMvtBuaJodXr0VH/EfuXo0/wkUOI6dBtajLn9c0SQeDpek?=
 =?us-ascii?Q?ADev9aN0Y0uQTi5dK7+k/E/uIIhefWfOeiJOHcu1Ar3a7oYy2DUTn3GyQqIe?=
 =?us-ascii?Q?/tvN/HafAODXfvL9xMlRahtb87joeFxI46EqnwbPfB+LpHGNP+k2Qzp0Y+MB?=
 =?us-ascii?Q?cFD7a/aRXZ6R1eEq3ksbo2UKDCbkswmStCCDMIsyY7tPQ2kGxTZDLwOiqjuo?=
 =?us-ascii?Q?P8+5UwKz0fn1Vy6lU4A50YMLHWKAKS1xXOUB91k4aPVWhs1ArSqDg5Jg5Tg7?=
 =?us-ascii?Q?2aS0ykls7JDaxVk7rK51FMnq8dM0qnuB+BajiRWaUxBJG/JvoEFrB1f78TM7?=
 =?us-ascii?Q?1XgG1ZDKRfqYzS+DxcffAACU0oyyUWZRAPqI/r0Bq2YumsBPLQhIHiyzfYHn?=
 =?us-ascii?Q?/D591cyYEWt0K9HJ1uD2YxcjNEseODubHlII2UETyu8HDPACP98cUSfStrV4?=
 =?us-ascii?Q?A0NwYe2jxcRpP1sRJUo+93W21U4F0q46DIqJoTR5ZNCMAJgaE0Z1CnVBr8re?=
 =?us-ascii?Q?DpxP/H8Qd/Kv1llN+LDCPCsyV1dRAS52HdSC1LgRu70zOvwKpL7BlVt0mnwL?=
 =?us-ascii?Q?K7ALWIuT8PpubNEjXpxi8YQmuYlAEevfV6lu9e3UuBf5nyJuquEoc9k2gB6f?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e465812-269b-4fc0-6528-08ddcf68ef69
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 12:59:36.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntDjz4VK72225JOaZ5hUaLC0sJ3Oh70b8RW4ud/GZN47rTv9pYEwb69JbABZLofxpVSisxMxxDSAL03xk+ggZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8763

Hi,

These 2 patches belonged to a larger patch-set I sent a couple of weeks
ago([1]) but I decided to break that set into smaller sets, where
possible, as they will be easier to respin, to address any issues, and
will probably be merged faster than the other one.

Also, I addressed all the reviewers' comments received previously for
these patches.

Thanks,
Laurentiu

[1] https://lore.kernel.org/imx/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com/T/#t

Laurentiu Palcu (2):
  clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
  clk: imx95-blk-ctl: Save/restore registers when RPM routines are
    called

 drivers/clk/imx/clk-imx95-blk-ctl.c | 57 ++++++++++++++---------------
 1 file changed, 28 insertions(+), 29 deletions(-)

-- 
2.46.1


